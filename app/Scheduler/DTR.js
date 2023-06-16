const $env 			= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	sequelize,
	UsersModel,
	WorkScheduleModel,
	ShiftsModel,
	UserSettingModel,
	LeavesModel
} = require('../../config/Sequelize');

function DTR(){

	this.proccess = function(){
		let DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;
		let today = moment().format('YYYY-MM-DD');
		let endDate = moment().format('YYYY-MM-DD');
		let startDate = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
		ShiftsModel.findAll({
			where:{
				date: {
					[Op.between]: [startDate, endDate]
				}
			},
			include: [
				{
					model: LeavesModel,
					as: 'leave',
					where:{
						primary_status: 2,
						start_date:{
							[Op.col]: 'shifts.date'
						}
					},
					required: false
				}
			],
			raw: false,
		}).then(data=>{
			shift = data;
			if(shift && shift.length){
				for(let i in shift){
					let date = shift[i].date;
					// console.log(date);
					/*
					* If Complete Logs
					* Calculate actual work hours
					*/
					if(shift[i].actual_check_in && shift[i].actual_check_out){
						this.actual_work_hours(shift[i]);
						let start_date = shift[i].actual_check_in <= shift[i].check_in ? date+' '+moment(shift[i].check_in).utc().format('HH:mm:ss') : date+' '+moment(shift[i].actual_check_in).utc().format('HH:mm:ss');
						let end_date = shift[i].actual_check_out >= shift[i].check_out ? date+' '+moment(shift[i].check_out).utc().format('HH:mm:ss') : date+' '+moment(shift[i].actual_check_out).utc().format('HH:mm:ss');
						this.night_differencial(shift[i].id, start_date, end_date);
					}else{
						/*
						* If no login and logout
						* check leaves to calculate absent and awol
						*/
						if(!shift[i].actual_check_in && !shift[i].actual_check_out){
							this.absent_awol(shift[i]);
						}else{
							// No Logout
							if(shift[i].actual_check_in && !shift[i].actual_check_out){
								this.no_logout(shift[i]);
								let end_date = date+' '+moment(shift[i].check_out).utc().format('HH:mm:ss');
								let start_date = moment(end_date).subtract(4, 'hours').format('YYYY-MM-DD HH:mm:ss');
								this.night_differencial(shift[i].id, start_date, end_date);
							}else if(!shift[i].actual_check_in && shift[i].actual_check_out){//No Login
								this.no_login(shift[i]);
								let start_date = shift[i].actual_check_in <= shift[i].check_in ? date+' '+moment(shift[i].check_in).utc().format('HH:mm:ss') : date+' '+moment(shift[i].actual_check_in).utc().format('HH:mm:ss');
								let end_date = moment(start_date).add(4, 'hours').format('YYYY-MM-DD HH:mm:ss');
								this.night_differencial(shift[i].id, start_date, end_date);
							}
						}
					}
				}
			}
			// console.log(shifts);
		})
	}

	// Calculate [work hours, late, undertime]
	this.actual_work_hours = function(shift){
		let data = {}

		let check_in = shift.date +' '+ moment(shift.check_in).utc().format('HH:mm:ss');
		let check_out = shift.date +' '+ moment(shift.check_out).utc().format('HH:mm:ss');
		let actual_check_in = shift.date +' '+ moment(shift.actual_check_in).utc().format('HH:mm:ss');
		let actual_check_out = shift.date +' '+ moment(shift.actual_check_out).utc().format('HH:mm:ss');
		// console.log(check_in, check_out, actual_check_in, actual_check_out);
		if(actual_check_in <= check_in && actual_check_out >= check_out){
			data.actual_work_hours = shift.shift_length;
		}else{
			let startDate = null;
			let endDate = null;
			if(actual_check_in > check_in){
				let startTime = moment(check_in);
				let endTime = moment(actual_check_in);
				// let lateDuration = moment.duration(check_in.diff(actual_check_in));
				let diff = moment.duration(endTime.diff(startTime));
				// let late = end.diff(start,'hours') end.diff(start,'hours');
				data.late = moment(endTime).diff(moment(startTime),'minutes');
				startDate = actual_check_in;
			}else{
				startDate = check_in;
			}

			if(actual_check_out < check_out){
				let startTime = moment(actual_check_out);
				let endTime = moment(check_out);
				let diff = moment.duration(endTime.diff(startTime));
				data.undertime = moment(endTime).diff(moment(startTime),'minutes');
				endDate = actual_check_out;
			}else{
				endDate = check_out;
			}
			if(startDate && endDate){
				data.actual_work_hours = moment(endDate).diff(moment(startDate),'hours');
			}

		}
		ShiftsModel.update(data,{
			where:{
				id: shift.id
			}
		});
	}

	// Absent or awol
	this.absent_awol = function(shift){
		let data = {}
		if(shift.leave){
			data.absent = 1;
			data.awol = 0;
		}else{
			data.absent = 0;
			data.awol = 1;
		}
		ShiftsModel.update(data,{
			where: {
				id: shift.id
			}
		});
	}

	//NO Login
	this.no_login = function(shift){
		
		let data = {
			actual_work_hours: shift.shift_length ? Math.floor(shift.shift_length / 2) : 0
		}
		ShiftsModel.update(data,{
			where: {
				id: shift.id
			}
		});
	}

	//NO Logout
	this.no_logout = function(shift){
		let data = {
			actual_work_hours: shift.shift_length ? Math.floor(shift.shift_length / 2) : 0
		}
		ShiftsModel.update(data,{
			where: {
				id: shift.id
			}
		});
	}

	this.night_differencial = function(id, start_date, end_date){
		let start_work = new Date(start_date);
		let end_work = new Date(end_date);
		let start_work_time = moment(start_work).format('HH:mm:ss');
		let end_work_time = moment(end_work).format('HH:mm:ss');
		let start_night = '22:00:00';
		let end_night = '06:00:00';
		let start = null;
		let end = null;
		let result = 0;
		
		if((start_work && end_work) && (Date.parse(start_work) < Date.parse(end_work))){
			if(start_work_time >= end_night && start_work_time < start_night){
				if(!(end_work_time >= end_night && end_work_time < start_night)){
					start = start_work;
					start.setHours(22);
					start.setMinutes(00);
					start.setSeconds(00);
					end   = end_work;
				}else{
					let checkStart = moment(start_work).format('YYYY-MM-DD');
					let checkEnd = moment(end_work).format('YYYY-MM-DD');
					if(checkStart != checkEnd){
						let diffStart = moment(checkStart);
						let diffEnd = moment(checkEnd);
						let duration = moment.duration(diffEnd.diff(diffStart));
							duration = duration.asDays();
						if(duration == 1){
							start = start_work;
							start.setHours(22);
							start.setMinutes(00);
							start.setSeconds(00);

							end   = end_work;
							end.setHours(06);
							end.setMinutes(00);
							end.setSeconds(00);
						}
					}
				}
				if(start && end){
					start = moment(start);
					end   = moment(end);
					let duration = moment.duration(end.diff(start));
					result = duration.asHours();
					result = result > 0 ? Math.floor(result) : 0;
				}
			}else{
				start = start_work;
				end   = end_work;
				if(end_work_time >= end_night && end_work_time < start_night){
					end.setHours(06);
					end.setMinutes(00);
					end.setSeconds(00);
				}
				start = moment(start);
				end   = moment(end);
				let duration = moment.duration(end.diff(start));
				result = duration.asHours();
				result = result > 0 ? Math.floor(result) : 0;
				if(start_work_time < end_night && end_work_time > start_night){
					result = result - 16;
				}				
			}

			
		}
		result = parseInt(result) > 16 ? (parseInt(result) - 16) : result;
		
		if(result > 0){
			let data = {
				night_diff: result
			}
			ShiftsModel.update(data,{
				where: {
					id: id
				}
			});
		}
	}
}

module.exports = new DTR();