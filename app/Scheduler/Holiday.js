const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	sequelize,
	UsersModel,
	ShiftsModel,
	EmploymentsModel,
	OvertimesModel,
	HolidaysModel
} = require('../../config/Sequelize');

function Holiday(){

	this.proccess = function(){
		let today = moment().format('YYYY-MM-DD');
		let endDate = moment().format('YYYY-MM-DD');
		let startDate = moment().subtract(30,'days').format('YYYY-MM-DD');

		ShiftsModel.findAll({
			where:{
				date: {
					[Op.between]: [startDate, endDate]
				}
			},
			raw: true
		}).then(data=>{
			shift = data;
			return OvertimesModel.findAll({
				where:{
					primary_status: 2,
					start_date: {
						[Op.between]: [startDate, endDate]
					}
				},
				raw: true
			});
		}).then(data=>{
			overtime = data;
			this.shift(shift);
			this.overtime(overtime);
		})
	};

	this.shift = function(record){
		if(record && record.length){
			for(let i in record){
				let shiftID = record[i].id;
				let user_id = record[i].user_id;
				

				let check_in = record[i].date +' '+moment(record[i].check_in).utc().format('HH:mm:ss'); 
				let check_out = record[i].date +' '+moment(record[i].check_out).utc().format('HH:mm:ss');
				//Diff date login/logout
				if(record[i].actual_check_in || record[i].actual_check_out){
					EmploymentsModel.findOne({
						where:{
							user_id: user_id
						},
						order:[
							['id','desc']
						],
						raw: true
					}).then(data=>{
						employment = data;
						// console.log(user_id, employment.branch_id, date);
						if(employment){
							let date = record[i].date;
							let sameDay = true;
							let actual_work_hours = record[i].actual_work_hours ? record[i].actual_work_hours : 0;
							this.diffDate(record[i],shiftID,employment.branch_id, 'IN');
							if(check_in > check_out){
								sameDay = false;
								if(record[i].actual_check_in){
									this.diffDate(record[i],shiftID,employment.branch_id, 'IN');
								}
								if(record[i].actual_check_out){
									this.diffDate(record[i],shiftID,employment.branch_id, 'OUT');
								}
							}else{
								this.findHoliday(date, actual_work_hours, shiftID, employment.branch_id);
							}
						}
					});
				}
			}
		}
	}

	this.diffDate = function(record,shiftID,location_id,type){
		let date = record.date;
		let check_in = record.check_in ? moment(record.check_in).utc().format('HH:mm:ss') : null;
		let check_out = record.check_out ? moment(record.check_out).utc().format('HH:mm:ss') : null;
		let actual_check_in = record.actual_check_in ? moment(record.actual_check_in).utc().format('HH:mm:ss'):null;
		let actual_check_out = record.actual_check_out ? moment(record.actual_check_out).utc().format('HH:mm:ss'):null;
		let startDate = null;
		let endDate = null;
		if(type == 'IN'){
			if(date+' '+actual_check_in > date+' '+check_in){ //Late
				startDate = actual_check_in ? moment(date+' '+actual_check_in) : actual_check_in;
			}else{
				startDate = check_in ? moment(date+' '+check_in) : check_in;
			}
			endDate = moment(record.date +' 23:59:59');
			if(startDate && endDate){
				let actual_work_hours = endDate.diff(startDate, 'hours');
				this.findHoliday(date, actual_work_hours, shiftID, location_id);
			}
		}else{
			date = moment(record.date).add(1,'days').format('YYYY-MM-DD');
			startDate = moment(date+' 00:00:00');
			if(date+' '+actual_check_out > date+' '+check_out){
				endDate = check_out ? moment(date +' '+check_out):check_out;
			}else{
				endDate = actual_check_out ? moment(date +' '+actual_check_out):actual_check_out;
			}
			if(startDate && endDate){
				let actual_work_hours = endDate.diff(startDate, 'hours');
				this.findHoliday(date, actual_work_hours, shiftID, location_id);
			}
		}
	}

	this.findHoliday = function(date, actual_work_hours, shiftID, location_id){
		HolidaysModel.findAll({
			where:{
				date: date,
				// location_id: location_id
				location_id : {
					[Op.like] : '%'+ location_id +'%'
				}
			},
			raw: true
		}).then(data=>{
			holiday = data;
			if(holiday && holiday.length){
				let holiday1 = holiday[0];
				let data = {}
				if(holiday.length > 1){
					let holiday2 = holiday[1];
					//Double Regular
					if(holiday1.type == 1 && holiday2.type == 1){
						data.double_reg_holiday = actual_work_hours;
					}else{
						data.reg_special_holiday = actual_work_hours;
					}
					this.update_shift(shiftID, data);
				}else{
					if(holiday1.type == 1){
						data.reg_holiday_work_hrs = actual_work_hours;
					}else{
						data.special_holiday = actual_work_hours;
					}
					this.update_shift(shiftID, data);
				}
			}
		});
	}

	this.overtime = function(record){

		if(record && record.length){
			for(let i in record){
				let date = record[i].start_date;
				let user_id = record[i].user_id;

				EmploymentsModel.findOne({
					where:{
						user_id: user_id
					},
					order:[
						['id','desc']
					],
					raw: true
				}).then(data=>{
					employment = data;
					// console.log(user_id, employment.branch_id, date);
					if(employment){
						HolidaysModel.findAll({
							where:{
								date: date,
								//location_id: employment.branch_id
								location_id : {
									[Op.like] : '%'+ employment.branch_id +'%'
								}
							},
							raw: true
						}).then(data=>{
							holiday = data;
							if(holiday && holiday.length){
								let holiday1 = holiday[0];
								if(holiday.length == 1){
									let start_date = moment(record[i].start_date+' '+ moment(record[i].start_time).utc().format('HH:mm:ss'));
									let end_date = moment(record[i].end_date+' '+ moment(record[i].end_time).utc().format('HH:mm:ss'));
									if(holiday1.type == 1){
										// this.create_update_shift(record[i], date, user_id, 'regular', end_date.diff(start_date, 'hours'));
									}else{
										// this.create_update_shift(record[i], date, user_id, 'special', end_date.diff(start_date, 'hours'));
									}
								}
							}
						});
					}
				});

				
			}
		}
	}

	this.create_update_shift = function(record, date, user_id, holiday, hours){
		ShiftsModel.findOne({
			where: {
				date: date,
				user_id: user_id
			}
		}).then(data=>{
			shift = data;
			if(!shift){
				let data = {
					user_id: user_id,
					date: date,
					check_in: moment(record.start_time).utc().format('HH:mm:ss'),
					check_out: moment(record.end_time).utc().format('HH:mm:ss'),
					actual_check_in: null,
					actual_check_out: null,
					is_restday: 1,
				}
				if(holiday == 'regular'){
					data.reg_holiday_rest_day_work_hrs = hours;
				}else{
					data.special_holiday_restday = hours;
				}
				ShiftsModel.create(data);
			}else{
				let data = {}
				if(holiday == 'regular'){
					data.reg_holiday_rest_day_work_hrs = hours;
				}else{
					data.special_holiday_restday = hours;
				}
				ShiftsModel.update(data,{
					where:{
						id: shift.id
					}
				});
			}
		});
	}

	this.update_shift = function(id, data){
		ShiftsModel.update(data,{
			where:{
				id: id
			}
		});
	}
}

module.exports = new Holiday();