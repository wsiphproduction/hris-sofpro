const moment     	= require('moment-timezone');
const $env 	= require('dotenv').config();
const { 
	Op,
	UsersModel,
	ShiftsModel,
	EmploymentsModel,
	TSS,
	TSSData,
	OvertimesModel,
	UndertimeModel,
	HolidaysModel,
	LeavesModel,
	LeaveDateModel,
	LeavePolicyModel,
	BiometricLog,
	BiometricNumberModel,
	BiometricModel,
	ConfigModel
} = require('../../config/Sequelize');

let config = null;
let holidays = null;
let overtimes = null;
let shifts = null;
let actualShifts = [];
let leaves = [];

exports.process = function(target_date = null){
	console.log("Proccessing TSS Data Helper")
	let DATE_DIFF = null;
	let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
	let START_DATE = null;
	let END_DATE = null;

	if(target_date != null) {
		if(Array.isArray(target_date)) { 
			START_DATE 	= target_date[0];
			END_DATE	= target_date.pop();
		} else {
			// START_DATE = moment(target_date).format('YYYY-MM-DD');
			// END_DATE = moment(target_date).add(Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
			START_DATE 	= target_date;
			END_DATE 	= target_date;
		}
		// START_DATE = moment(target_date).format('YYYY-MM-DD');
		// END_DATE = moment(target_date).add(Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	} else {
		DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

		START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
		END_DATE = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	}
	console.log(START_DATE + ' --- ' + END_DATE);
	
	TSSData.findAll({
		where: {
			date:{
				[Op.gte]: START_DATE,
				[Op.lte]: END_DATE
			},
		},
		attributes: ['id','date','user_id','shift_id','overtime_id'],
		raw: true
	}).then(data=>{
		tss = data;
		if(tss){
			for(let i in tss){
				// DELETE SHIFTS WITH OVERTIME BUT NO SHIFT_ID
				if(tss[i].shift_id && tss[i].overtime_id){
					let reqData = {
						overtime_id: null
					}
					TSSData.destroy({
						where: {
							shift_id: null,
							date: tss[i].date,
							user_id: tss[i].user_id,
							overtime_id: tss[i].overtime_id
						}
					});
					TSSData.update(reqData,{
						where:{
							date: tss[i].date,
							user_id: tss[i].user_id,
							overtime_id: tss[i].overtime_id,
							shift_id: {
								[Op.ne]: null
							}
						}
					})
				}
				
				else{
					if(tss[i].shift_id){
						ShiftsModel.count({
							where:{
								id: tss[i].shift_id,
								date: tss[i].date,
								user_id: tss[i].user_id
							}
						}).then(data=>{
							let count = data;
							if(!count){
								TSSData.destroy({
									where: {
										shift_id: tss[i].shift_id,
										date: tss[i].date,
										user_id: tss[i].user_id,
									}
								});
							}
						});
					}

					if(tss[i].overtime_id){
						let where = {
							id: tss[i].overtime_id,
							user_id: tss[i].user_id,
							start_date: tss[i].date,
						}
						OvertimesModel.findOne({
							where: where,
							raw: true
						}).then(data=>{
							let overtime = data;
							if(!overtime){
								TSSData.destroy({
									where: {
										overtime_id: tss[i].overtime_id,
										date: tss[i].date,
										user_id: tss[i].user_id,
									}
								});
							}
						})
					}
				}
			}
		}
	});
}


const findShiftAndDelete = function(){

}