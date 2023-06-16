const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	sequelize,
	UsersModel,
	WorkScheduleModel,
	ShiftsModel,
	UserSettingModel,
	OvertimesModel,
	TSSData
} = require('../../config/Sequelize');

function WorkShift(){
	
	this.execute = function(){
		let dateToday = moment();
		let today = moment().format('dddd');
			today = today.toLowerCase();
		let now = moment().format('YYYY-MM-DD');
		// console.log(today, now);
		WorkScheduleModel.findAll({
			where:{
				break_type: 2,
				effective_date: {
					$lte: now
				},
			},
			raw: true
		}).then(data=>{
			schedule = data;
			if(today != 'sunday'){
				let check_in = null;
				let check_out = null;
				let shift_length = null;
				let shift_type = null;
				let break_hour = 0;
				if(today == 'monday'){
					break_hour = 1;
					check_in  = '08:00:00';
					check_out = '17:00:00';
					shift_type = 'O/C MONDAY';
					shift_length = 9;
				}else if(today == 'saturday'){
					check_in  = '08:00:00';
					check_out = '12:00:00';
					shift_type = 'O/C SATURDAY';
					shift_length = 4;
				}else{
					break_hour = 1;
					check_in  = '07:00:00';
					check_out = '17:00:00';
					shift_type = 'O/C TUE-FRIDAY';
					shift_length = 10;
				}

				if(schedule && schedule.length){
					for(let i in schedule){
						ShiftsModel.count({
							where: {
								user_id: schedule[i].user_id,
								date: now
							}
						}).then(data=>{
							count = data;
							// console.log(schedule[i].user_id, count);
							if(count <= 0){
								let reqData = {
									user_id: schedule[i].user_id,
									date: now,
									check_in: check_in,
									check_out: check_out,
									shift_length: shift_length,
									shift_type: shift_type
								}
								ShiftsModel.create(reqData).then(data=>{
									shift = data;
									if(shift){
										let tssReqData = {
											date: reqData.date,
											check_in: check_in,
											check_out: check_out,
											shift_length: shift_length,
											shift_type: shift_type,
											break_hour: break_hour
										}
										TSSData.findOne({
											where:{
												shift_id: shift.id,
												user_id: shift.user_id,
												date: shift.date,
											}
										}).then(data=>{
											tss = data;
											if(!tss){
												TSSData.create(tssReqData);		
											}
										});
									}
								});
							}
						});
					}
				}				
			}
			
		});
	}

}

module.exports = new WorkShift();