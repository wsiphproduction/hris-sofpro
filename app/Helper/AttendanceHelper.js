const $env 	= require('dotenv').config();
const moment= require('moment-timezone');
const { where } = require('underscore');
	moment.tz.setDefault($env.parsed.moment_timezone);
const {
	sequelize,
	Op,
	ShiftsModel,
	BiometricLog,
	UsersModel,
	BiometricNumberModel,
	BiometricModel,
	ShiftType,
	ChangeLogModel
} = require('../../config/Sequelize');

function AttendanceHelper(){

	this.proccess = function(source, target_date = null){
		console.log("Proccessing " + source + " Helper")
		let DATE_DIFF = null;
		let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
		let date = null;
		let current_date = null;

		if(target_date != null) {
			if(Array.isArray(target_date)) { 
				date 	= target_date[0];
				current_date	= target_date.pop();
			} else {
				// START_DATE = moment(target_date).format('YYYY-MM-DD');
				// END_DATE = moment(target_date).add(Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
				date 			= target_date;
				current_date 	= target_date;
			}
			// date = moment(target_date).format('YYYY-MM-DD');
			// current_date = moment(target_date).add(1,'days').format('YYYY-MM-DD');
		} else {
			DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

			date = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
			current_date = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
		}
		console.log(date + ' --- ' + current_date);
		ShiftsModel.findAll({
			where:{
				date:{
					$between: [date, current_date]
				},
				// [Op.or]: [
				// 	{
				// 		actual_check_in: {
				// 			[Op.eq]: null
				// 		}
				// 	},
				// 	{
				// 		actual_check_out: {
				// 			[Op.eq]: null
				// 		}
				// 	}
				// ]
				
			},
			include:[
				{
					model: UsersModel,
					attributes: ['id','first_name','last_name'],
					include: [
						{
							model: BiometricNumberModel,
							as: 'biometric_number',
							attributes: ['id','biometric_id','biometric_number'],
							separate: true,
							include: [
								{
									model: BiometricModel
								}
							]
						}
					]
				},
				{
					model: ShiftType,
					as: 'type_of_shift',
					attributes: ['is_from_previous'],
				}
			],
			attributes: ['id','user_id','date','check_in','check_out','actual_check_in','actual_check_out','shift_type'],
			raw: false,
			// logging: true
		}).then((data)=>{
			shift = data;
			if(shift && shift.length){
				for(let i in shift){
					this.proccess_shift(shift[i], source);
				}
			}
		});
	}

	this.findUser = function(array, biometric){
		let obj = array.filter(o => o.biometric_number == biometric);
		return typeof obj != 'undefined' && obj.length ? obj[0] : null;
	}


	this.proccess_shift = function(shift, source){
		let shift_id 		 = shift.id;
		let date 			 = shift.date;
		let user_id			 = shift.user_id
		let check_in 		 = moment(shift.check_in).utc().format('HH:mm:ss');
		let check_out 		 = moment(shift.check_out).utc().format('HH:mm:ss');
		let is_from_previous = shift.type_of_shift? shift.type_of_shift.is_from_previous: null;

		ChangeLogModel.findOne({
			where:{
				user_id  		: shift.user_id,
				log_date 		: shift.date,
				primary_status	: 2,
			},
			raw:false,
		}).then((data)=>{
			let change_log_data = data;

			//CHANGE LOG BOTH NULL (REQ_TIME_IN AND REQ_TIME_OUT)
			if(change_log_data && !change_log_data.req_login_time && !change_log_data.req_logout_time){
				let reqData = {
					actual_check_in  : null,
					actual_check_out : null
				};
				
				ShiftsModel.update(reqData,{
					where:{
						// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
						//date: date,
						//user_id: user_id
						id: shift_id
					}
				})
			}
			// CHANGE LOG WITH ONE NULL
			else if(change_log_data){
				let req_login_time  = change_log_data.req_login_time? moment(change_log_data.req_login_time).utc().format('HH:mm:ss') : null;
				let req_logout_time = change_log_data.req_logout_time? moment(change_log_data.req_logout_time).utc().format('HH:mm:ss') : null;

				let reqData = {};

				if(req_login_time){
					reqData.actual_check_in	 = req_login_time;
				}
				if(req_logout_time){
					reqData.actual_check_out = req_logout_time;
				}
				
				ShiftsModel.update(reqData,{
					where: {
						date: date,
						user_id: user_id
					}
				}).then((data)=>{
					if(shift.user && shift.user.biometric_number && shift.check_in && shift.check_out){
						let biometric_number = shift.user.biometric_number;

						if(!req_login_time){
							this._getTimeIn(date, check_in, check_out,  date, user_id, is_from_previous, biometric_number);
						}	
						if(!req_logout_time){
							this._getTimeOut(date, check_in, check_out,  date, user_id, is_from_previous, biometric_number);
						}
					}
				});
			}
			else{
				if(shift.user && shift.user.biometric_number && shift.check_in && shift.check_out){
					let biometric_number = shift.user.biometric_number;
					if(biometric_number && biometric_number.length){
						this._getTimeIn(date, check_in, check_out, date, user_id, is_from_previous, biometric_number);
						this._getTimeOut(date, check_in, check_out, date, user_id, is_from_previous, biometric_number);
					}
				}
			}
		});
	}

	this._getTimeIn = function(date, check_in, check_out, date, user_id, is_from_previous, biometric_number){
		let	startDate 	= null;
		let endDate 	= null; 

		// FOR TIME IN
		if (is_from_previous == '1'){
			startDate 	= moment(date+' '+check_in).subtract(29,'hours').format('YYYY-MM-DD HH:mm:ss');
			endDate		= moment(date+' '+check_out).format('YYYY-MM-DD HH:mm:ss');
		} else {
			startDate 	= moment(date+' '+check_in).subtract(5,'hours').format('YYYY-MM-DD HH:mm:ss');
			endDate 	= date+' '+check_in > date+' '+check_out ? moment(date+' '+check_out).add(24,'hours').format('YYYY-MM-DD HH:mm:ss') : moment(date+' '+check_out).format('YYYY-MM-DD HH:mm:ss');
		}

		// console.log("TI START DATE: " + startDate + "---" + " END DATE: " + endDate);

		let time 		= null;
		let userId 		= biometric_number.map(el => el.biometric_number);
		let ip_address 	= biometric_number.map(el => el.biometric.site);

		let where = {
			ip_address: {[Op.in]:ip_address},
			userId: {[Op.in]:userId},
			status: 0,
			date:{
				[Op.between]:[startDate, endDate]
			}
		};
		// where.state = {
		// 	$ne: 0
		// }

		if(!time && ip_address){
			BiometricLog.findOne({
				where: where,
				order:[
					['date','asc']
				]
			}).then(data=>{
				log = data;
				if(log){
					time = log.date ? moment(log.date).utc().format('HH:mm:ss') : null;
					let reqData = {
						actual_check_in: time
					}
					ShiftsModel.update(reqData,{
						where: {
							// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
							date: date,
							user_id: user_id
						}
					});
				}	
				else{
					let reqData = {
						actual_check_in: null
					}
					ShiftsModel.update(reqData,{
						where: {
							// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
							date: date,
							user_id: user_id
						}
					});
				}
			});
		}
	}

	this._getTimeOut = function(date, check_in, check_out, date, user_id, is_from_previous, biometric_number){
		let	startDate 	= null;
		let endDate 	= null; 

		// FOR TIME OUT
		if (is_from_previous == '1'){
			startDate 	= moment(date+' '+check_in).subtract(24,'hours').format('YYYY-MM-DD HH:mm:ss');
			endDate		= moment(date+' '+check_out).add(12,'hours').format('YYYY-MM-DD HH:mm:ss');
		} else {
			startDate 	= moment(date+' '+check_in).format('YYYY-MM-DD HH:mm:ss');
			endDate 	= date+' '+check_in > date+' '+check_out ? moment(date+' '+check_out).add(36,'hours').format('YYYY-MM-DD HH:mm:ss') : moment(date+' '+check_out).add(12,'hours').format('YYYY-MM-DD HH:mm:ss');
		}
		// console.log("TO START DATE: " + startDate + "---" + " END DATE: " + endDate);

		let time 		= null;
		let userId 		= biometric_number.map(el => el.biometric_number);
		let ip_address 	= biometric_number.map(el => el.biometric.site);

		let where = {
			ip_address: {[Op.in]:ip_address},
			userId: {[Op.in]:userId},
			status: 1,
			date:{
				[Op.between]:[startDate, endDate]
			}
		};
		// where.state = {
		// 	$ne: 0
		// }

		if(!time && ip_address){
			BiometricLog.findOne({
				where: where,
				order:[
					['date','desc']
				]
			}).then(data=>{
				log = data;
				if(log){
					time = log.date ? moment(log.date).utc().format('HH:mm:ss') : null;
					let reqData = {
						actual_check_out: time
					}
					ShiftsModel.update(reqData,{
						where: {
							// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
							date: date,
							user_id: user_id
						}
					});
				}	
				else{
					let reqData = {
						actual_check_out: null
					}
					ShiftsModel.update(reqData,{
						where: {
							// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
							date: date,
							user_id: user_id
						}
					});
				}
			});
		}		
	}

	this.proccess2 = function(source, target_date = null, shift_id = null){
		console.log("Proccessing2 " + source + " Helper")
		let DATE_DIFF = null;
		let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
		let date = null;
		let current_date = null;


		if(target_date != null) {
			date = moment(target_date).format('YYYY-MM-DD');
			current_date = moment(target_date).add(1,'days').format('YYYY-MM-DD');
		} else {
			DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

			date = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
			current_date = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
		}
		
		let where_shift = {
			date:{
					$between: [date, current_date]
				},
		};
		
		// IF SHIFT ID EXIST FOR DTR MANAGEMENT
		// CHANGE THE WHERE OF THE SHIFT FOR THAT SPECIFIC SHIFT
		if(shift_id){
			where_shift = {
						id:shift_id
					};
		}

		console.log(date + ' --- ' + current_date);
		ShiftsModel.findAll({
			where: where_shift,
			include:[
				{
					model: UsersModel,
					attributes: ['id','first_name','last_name'],
					include: [
						{
							model: BiometricNumberModel,
							as: 'biometric_number',
							attributes: ['id','biometric_id','biometric_number'],
							separate: true,
							include: [
								{
									model: BiometricModel
								}
							]
						}
					]
				},
				{
					model: ShiftType,
					as: 'type_of_shift',
					attributes: ['is_from_previous'],
				}
			],
			attributes: ['id','user_id','date','check_in','check_out','actual_check_in','actual_check_out','shift_type'],
			raw: false,
		}).then((data)=>{
			shift = data;
			if(shift && shift.length){
				for(let i in shift){
					if(shift[i].shift_type){
						this.proccess_shift(shift[i], source);
					}
				}
			}
		});
	}

	this.biometric = async()=>{
		let transaction; 
		try{
			transaction = await sequelize.transaction();
			return await BiometricModel.findAll({raw: true, transaction });
		}catch(error){

		}
	}
}

module.exports = new AttendanceHelper();