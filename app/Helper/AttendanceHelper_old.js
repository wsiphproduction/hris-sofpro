const $env 	= require('dotenv').config();
const moment= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const {
	sequelize,
	Op,
	ShiftsModel,
	BiometricLog,
	UsersModel,
	BiometricNumberModel,
	BiometricModel
} = require('../../config/Sequelize');

function AttendanceHelper(){

	this.proccess = function(source, target_date = null){
		console.log("Proccessing " + source + " Helper")
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
		console.log(date + ' --- ' + current_date);
		ShiftsModel.findAll({
			where:{
				date:{
					$between: [date, current_date]
				},
				[Op.or]: [
					{
						actual_check_in: {
							[Op.eq]: null
						}
					},
					{
						actual_check_out: {
							[Op.eq]: null
						}
					}
				]
				
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
				}
			],
			attributes: ['id','user_id','date','check_in','check_out','actual_check_in','actual_check_out','shift_type'],
			raw: false,
			// logging: true
		}).then((data)=>{
			shift = data;
			// let biometric = await this.biometric();
			if(shift && shift.length){
				for(let i in shift){
					this.proccess_shift(shift[i], source);
					// console.log(shift[i]);
				}
			}
			// console.log(shift);
		});
	}

	this.findUser = function(array, biometric){
		let obj = array.filter(o => o.biometric_number == biometric);
		return typeof obj != 'undefined' && obj.length ? obj[0] : null;
	}


	this.proccess_shift = function(obj, source){
		let shift_id = obj.id;
		let date = obj.date;
		let check_in = moment(obj.check_in).utc().format('HH:mm:ss');
		let check_out = moment(obj.check_out).utc().format('HH:mm:ss');
		let actual_check_in = obj.actual_check_in;
		let actual_check_out = obj.actual_check_out;
		
		// if(obj.user.id == 117){
		// return new Promise( async( resolve, reject )=>{
			if(obj.user && obj.user.biometric_number && obj.check_in && obj.check_out){
				let biometric_number = obj.user.biometric_number;
				if(biometric_number && biometric_number.length){
					if (obj.shift_type=='10PM TO 7AM' || obj.shift_type=='1st SHIFT' || obj.shift_type=='1st SHIFT GEO' || obj.shift_type=='LEVEL 6 1' || obj.shift_type=='Security 1'){
						this._getTimeIn2(obj.user, shift_id, date,check_in,check_out, biometric_number, source);
						this._getTimeOut2(shift_id, date, check_in, check_out, biometric_number, source);
					} else {
						this._getTimeIn(obj.user, shift_id, date,check_in,check_out, biometric_number, source);
						this._getTimeOut(shift_id, date, check_in, check_out, biometric_number, source);
					}

					// if(!actual_check_in){
					// 	this._getTimeIn(obj.user, shift_id, date,check_in,check_out, biometric_number, source);
					// }
					// if(!actual_check_out){

					// 	this._getTimeOut(shift_id, date, check_in, check_out, biometric_number, source);
					// }
				}
			}
		// });
		// }
	}

	this._getTimeIn = function(user, shift_id, date,check_in,check_out, biometric_number, source){
		// console.log(user.id);
		let time = null;
		let startDate = moment(date+' '+check_in).subtract(5,'hours').utc().format('YYYY-MM-DD HH:mm:ss');
		let endDate = date+' '+check_out;
			endDate = date+' '+check_in > endDate ? moment(endDate).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : endDate;
		for(let i in biometric_number){
			let userId = biometric_number[i].biometric_number;
			let ip_address = biometric_number[i].biometric.site;

			let where = {
				ip_address: ip_address,
				userId: userId,
				status: 0,
				//source: source,
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
						['id','asc']
					]
				}).then(data=>{
					log = data;
					if(log){
						time = log.date ? moment(log.date).utc().format('HH:mm:ss') : null;
						ShiftsModel.findOne({
							where: {
								id: shift_id
							}
						}).then(data=>{
							shift = data;
							//if(!shift.actual_check_in){
								let reqData = {
									actual_check_in: time
								}
								ShiftsModel.update(reqData,{
									where:{
										id: shift_id
									}
								});
							//}
						});
					}	
				});
			}
			
		}

	}

	this._getTimeOut = function(shift_id, date, check_in, check_out, biometric_number, source){
		let time = null;
		let startDate = date+' '+check_in;
		let endDate = date+' '+check_out;
			endDate = startDate > endDate ? moment(endDate).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : endDate;
		    endDate = moment(endDate).add(12,'hours').format('YYYY-MM-DD HH:mm:ss');

		for(let i in biometric_number){
			let userId = biometric_number[i].biometric_number;
			let ip_address = biometric_number[i].biometric.site;

			let where = {
				ip_address: ip_address,
				userId: userId,
				status: 1,
				//source: source,
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
						['id','desc']
					]
				}).then(data=>{
					log = data;
					if(log){
						time = log.date ? moment(log.date).utc().format('HH:mm:ss') : null;
						ShiftsModel.findOne({
							where: {
								id: shift_id
							}
						}).then(data=>{
							shift = data;
							//if(!shift.actual_check_out){
								let reqData = {
									actual_check_out: time
								}
								ShiftsModel.update(reqData,{
									where:{
										id: shift_id
									}
								});
							//}
						});
					}	
				});
			}
			
		}

		
	}

	this.proccess2 = function(source, target_date = null, shift_id = null){
		console.log("Proccessing2 " + source + " Helper")
		let DATE_DIFF = null;
		let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
		let date = null;
		let current_date = null;
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

		if(target_date != null) {
			date = moment(target_date).format('YYYY-MM-DD');
			current_date = moment(target_date).add(1,'days').format('YYYY-MM-DD');
		} else {
			DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

			date = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
			current_date = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
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
					
					// THIS CONDITION ALREADY EXIST IN THE SHIFT_PROCESS
					// if (shift[i].shift_type && (shift[i].shift_type=='1st SHIFT' || shift[i].shift_type=='1st SHIFT GEO' || shift[i].shift_type=='LEVEL 6 1' || shift[i].shift_type=='Security 1')){
					// 	this.proccess_shift(shift[i], source);
					// }
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

	// For shifts with previous day time in
	this._getTimeIn2 = function(user, shift_id, date,check_in,check_out, biometric_number, source){
		let time = null;
		let prevDate = moment(date).subtract(1,'days').format('YYYY-MM-DD');
		let startDate = moment(prevDate+' '+check_in).subtract(5,'hours').utc().format('YYYY-MM-DD HH:mm:ss');
		let endDate = date+' '+check_out;
		for(let i in biometric_number){
			let userId = biometric_number[i].biometric_number;
			let ip_address = biometric_number[i].biometric.site;

			let where = {
				ip_address: ip_address,
				userId: userId,
				status: 0,
				date:{
					[Op.between]:[startDate, endDate]
				}
			};
			where.state = {
				$ne: 0
			}

			if(!time && ip_address){
				BiometricLog.findOne({
					where: where,
					order:[
						['id','asc']
					]
				}).then(data=>{
					log = data;
					if(log){
						time = log.date ? moment(log.date).utc().format('HH:mm:ss') : null;
						ShiftsModel.findOne({
							where: {
								id: shift_id
							}
						}).then(data=>{
							shift = data;
							//if(!shift.actual_check_in){
								let reqData = {
									actual_check_in: time
								}
								ShiftsModel.update(reqData,{
									where:{
										id: shift_id
									}
								});
							//}
						});
					}	
				});
			}
		}
	}

	this._getTimeOut2 = function(shift_id, date, check_in, check_out, biometric_number, source){
		let time 		= null;
		let prevDate 	= moment(date).subtract(1,'days').format('YYYY-MM-DD');
		let startDate 	= moment(prevDate+' '+check_in).format('YYYY-MM-DD HH:mm:ss');
		let endDate 	= moment(date+' '+check_out).add(12,'hours').format('YYYY-MM-DD HH:mm:ss');

		for(let i in biometric_number){
			let userId = biometric_number[i].biometric_number;
			let ip_address = biometric_number[i].biometric.site;

			let where = {
				ip_address: ip_address,
				userId: userId,
				status: 1,
				//source: source,
				date:{
					[Op.between]:[startDate, endDate]
				}
			};
			where.state = {
				$ne: 0
			}

			if(!time && ip_address){
				BiometricLog.findOne({
					where: where,
					order:[
						['id','desc']
					]
				}).then(data=>{
					log = data;
					if(log){
						time = log.date ? moment(log.date).utc().format('HH:mm:ss') : null;
						ShiftsModel.findOne({
							where: {
								id: shift_id
							}
						}).then(data=>{
							shift = data;
							//if(!shift.actual_check_out){
								let reqData = {
									actual_check_out: time
								}
								ShiftsModel.update(reqData,{
									where:{
										id: shift_id
									}
								});
							//}
						});
					}	
				});
			}
			
		}

		
	}

}

module.exports = new AttendanceHelper();