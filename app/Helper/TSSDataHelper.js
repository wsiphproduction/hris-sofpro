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
			START_DATE 	= target_date;
			END_DATE 	= target_date;
		}
	} else {
		DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

		START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
		END_DATE = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	}
	console.log(START_DATE + ' --- ' + END_DATE);
	
	// FIRST, DELETE ALL THE TSS_DATA THAT DONT HAVE SHIFT_ID
	TSSData.destroy({
		where:{
			date:{
				[Op.gte]: START_DATE,
				[Op.lte]: END_DATE
			},
			shift_id:{
				[Op.is]: null
			}
		}
	}).then((data)=>{
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
			// console.log("TSS DATA TOTAL: ", tss.length);
			if(tss){
				for(let i in tss){
					// DELETE TSS_DATA IF USER,DATE, AND SHIFT_ID DOES NOT EXIST
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
					// DELETE TSS_DATA IF OVERTIME DOES NOT EXIST
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
		});
	});
}


const findShiftAndDelete = function(){

}