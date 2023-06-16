const UserRole = require('../Helper/UserRole');
const TSSHelper = require('../Helper/TSSHelper');
const OvertimeHelper= require('../Helper/OvertimeHelper');
const _ = require('underscore');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser')
const fs = require('fs');
const formidable = require('formidable');
const Excel = require('exceljs');
const moment     	= require('moment-timezone');
const { 
	Op, 
	sequelize,
	UsersModel,
	BiometricNumberModel,
	ShiftsModel,
	BiometricModel,
	BiometricCsvModel,
	UndertimeModel,
	EmploymentsModel,
	ShiftType,
	CompanyModel,
	Division,
	Department,
	Section,
	PositionCategory,
	PositionClassification,
	Position,
	TSS,
	TSSData,
	TSSSummary,
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	// TSSHelper.process();
	
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-tss');
	}).then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			res.render('Attendance/Tss/index',{
				route: 'attendance-tss',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.export = function(req, res){
	let id = req.params.id;
	let user = res.locals.user;
	
	TSS.findOne({
		where: {
			id: id
		},
		raw: true
	}).then(function(data){
		tss = data;
		console.log("TSS: ", tss)
		if(!tss){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				return UserRole.get_role(user, 'attendance-tss');
			}).then(function(data){
				user_role = data;
				return TSSSummary.findAll({
					where:{
						tss_id: tss.id
					},
					include:[
						{
							model: UsersModel,
							attributes: ['id','first_name','last_name','employee_number', 'old_employee_number']
						}
					]
				});
			}).then(function(data){
				tss_records = data;
				console.log("tss_records:", tss_records[0].user.first_name)
				let fields = ['Employee ID',
								'Old Employee ID',
								'Employee',
								'RegHrs',
								'LateHrs',
								'UndertimeHrs',
								'NDHrs',
								'Absent',
								'Leave01',
								'Leave02',
								'Leave03',
								'Leave04',
								'Leave05',
								'Leave06',
								'Leave07',
								'Leave08',
								'Leave09',
								'Leave10',
								'Leave11',
								'Leave12',
								'Leave13',
								'Leave14',
								'Leave15',
								'Leave16',
								'Leave17',
								'Leave18',
								'Leave19',
								'Leave20',
								'OTHrs01',
								'OTHrs02',
								'OTHrs03',
								'OTHrs04',
								'OTHrs05',
								'OTHrs06',
								'OTHrs07',
								'OTHrs08',
								'OTHrs09',
								'OTHrs10',
								'OTHrs11',
								'OTHrs12',
								'OTHrs13',
								'OTHrs14',
								'OTHrs15',
								'OTHrs16',
								'OTHrs17',
								'OTHrs18',
								'OTHrs19',
								'OTHrs20',
								'OTHrs21',
								'OTHrs22',
								'OTHrs23',
								'OTHrs24',
								'OTHrs25',
								'Rate',
								'UnpaidRegHrs',
								'UnpaidSL',
								'UnpaidTaxSL',
								'UnpaidVL',
								'UnpaidTaxVL',
								'UnpaidEL',
								'EffectivityDate',
								'EmpStatus',
								'EffectivityDateResign'];
				let arrayData = [];
				if(tss_records){
					for(let i in tss_records){
						arrayData.push({
							'Employee ID': tss_records[i].user ? tss_records[i].user.employee_number : '--',
							'Old Employee ID': tss_records[i].user ? tss_records[i].user.old_employee_number : '--',
							'Employee': tss_records[i].user ? tss_records[i].user.first_name+' '+tss_records[i].user.last_name : '',
							'RegHrs': tss_records[i].RegHrs.toFixed(1),
							'LateHrs': tss_records[i].LateHrs.toFixed(1),
							'UndertimeHrs': tss_records[i].UndertimeHrs.toFixed(1),
							'NDHrs': tss_records[i].NDHrs.toFixed(1),
							'Absent': tss_records[i].Absent.toFixed(1),
							'Leave01': tss_records[i].Leave01.toFixed(1),
							'Leave02': tss_records[i].Leave02.toFixed(1),
							'Leave03': tss_records[i].Leave03.toFixed(1),
							'Leave04': tss_records[i].Leave04.toFixed(1),
							'Leave05': tss_records[i].Leave05.toFixed(1),
							'Leave06': tss_records[i].Leave06.toFixed(1),
							'Leave07': tss_records[i].Leave07.toFixed(1),
							'Leave08': tss_records[i].Leave08.toFixed(1),
							'Leave09': tss_records[i].Leave09.toFixed(1),
							'Leave10': tss_records[i].Leave10.toFixed(1),
							'Leave11': tss_records[i].Leave11.toFixed(1),
							'Leave12': tss_records[i].Leave12.toFixed(1),
							'Leave13': tss_records[i].Leave13.toFixed(1),
							'Leave14': tss_records[i].Leave14.toFixed(1),
							'Leave15': tss_records[i].Leave15.toFixed(1),
							'Leave16': tss_records[i].Leave16.toFixed(1),
							'Leave17': tss_records[i].Leave17.toFixed(1),
							'Leave18': tss_records[i].Leave18.toFixed(1),
							'Leave19': tss_records[i].Leave19.toFixed(1),
							'Leave20': tss_records[i].Leave20.toFixed(1),
							'OTHrs01': tss_records[i].OTHrs01.toFixed(1),
							'OTHrs02': tss_records[i].OTHrs02.toFixed(1),
							'OTHrs03': tss_records[i].OTHrs03.toFixed(1),
							'OTHrs04': tss_records[i].OTHrs04.toFixed(1),
							'OTHrs05': tss_records[i].OTHrs05.toFixed(1),
							'OTHrs06': tss_records[i].OTHrs06.toFixed(1),
							'OTHrs07': tss_records[i].OTHrs07.toFixed(1),
							'OTHrs08': tss_records[i].OTHrs08.toFixed(1),
							'OTHrs09': tss_records[i].OTHrs09.toFixed(1),
							'OTHrs10': tss_records[i].OTHrs10.toFixed(1),
							'OTHrs11': tss_records[i].OTHrs11.toFixed(1),
							'OTHrs12': tss_records[i].OTHrs12.toFixed(1),
							'OTHrs13': tss_records[i].OTHrs13.toFixed(1),
							'OTHrs14': tss_records[i].OTHrs14.toFixed(1),
							'OTHrs15': tss_records[i].OTHrs15.toFixed(1),
							'OTHrs16': tss_records[i].OTHrs16.toFixed(1),
							'OTHrs17': tss_records[i].OTHrs17.toFixed(1),
							'OTHrs18': tss_records[i].OTHrs18.toFixed(1),
							'OTHrs19': tss_records[i].OTHrs19.toFixed(1),
							'OTHrs20': tss_records[i].OTHrs20.toFixed(1),
							'OTHrs21': tss_records[i].OTHrs21.toFixed(1),
							'OTHrs22': tss_records[i].OTHrs22.toFixed(1),
							'OTHrs23': tss_records[i].OTHrs23.toFixed(1),
							'OTHrs24': tss_records[i].OTHrs24.toFixed(1),
							'OTHrs25': tss_records[i].OTHrs25.toFixed(1),
							'Rate': tss_records[i].Rate.toFixed(1),
							'UnpaidRegHrs': tss_records[i].UnpaidRegHrs.toFixed(1),
							'UnpaidSL': tss_records[i].UnpaidSL.toFixed(1),
							'UnpaidTaxSL': tss_records[i].UnpaidTaxSL.toFixed(1),
							'UnpaidVL': tss_records[i].UnpaidVL.toFixed(1),
							'UnpaidTaxVL': tss_records[i].UnpaidTaxVL.toFixed(1),
							'UnpaidEL': tss_records[i].UnpaidEL.toFixed(1),
							'EffectivityDate': tss_records[i].EffectivityDate,
							'EmpStatus': tss_records[i].EmpStatus,
							'EffectivityDateResign': tss_records[i].EffectivityDateResign
						});
					}
				}
				let filename = tss.label
				const json2csvParser = new Parser({ fields });
				const csv = json2csvParser.parse(arrayData);
				res.attachment(filename+'.csv');
				res.status(200).send(csv);
			});
		}
	});
}

exports.summary = function(req, res){
	let id = req.params.id;
	let user = res.locals.user;
	TSS.findOne({
		where: {
			id: id
		}
	}).then(function(data){
		tss = data;
		if(!tss){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				return UserRole.get_role(user, 'attendance-tss');
			}).then(function(data){
				user_role = data;
				return TSSSummary.findAll({
					where:{
						tss_id: tss.id
					},
					include:[
						{
							model: UsersModel,
							attributes: ['id','first_name','last_name','employee_number', 'old_employee_number']
						}
					]
				});
			}).then(function(data){
				records = data;
				if(!user_role.read){
					res.render('Errors/404');
				}else{
					res.render('Attendance/Tss/summary',{
						route: 'attendance-tss',
						usrRole: usrRole,
						user_role: user_role,
						tss: tss,
						records: records
					});
				}
			});
		}
	});	
}

exports.posted = function(req, res){
	let user = res.locals.user;
	// TSSHelper.process();
	
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-tss');
	}).then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			res.render('Attendance/Tss/posted',{
				route: 'attendance-tss-posted',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.fetch_posted = function(req, res){
	TSS.findAll({
		order: [
			['id','desc']
		]
	}).then(data=>{
		records = data;
		res.status(200).json({
			success: true,
			count: 0,
			records: records
		})
	})
}

exports.fetch = function(req, res){
	let session = req.session;
	let isSupervisor = res.locals.isSupervisor;
	let isHRGeneralist = res.locals.isHRGeneralist
	let user = res.locals.user;

	ConfigModel.findOne({
			where: {
				id: 1
			}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		
		let cutoff = json.cutoff;
		
		let month_date = req.body.month_date ? req.body.month_date : "";
		let period = req.body.period;

		month_date = res.locals.moment(month_date).format('YYYY-MM');
		if(period =='A'){
			start = month_date+'-'+cutoff.A_from;
			start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
			end = month_date+'-'+cutoff.A_to;
			end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
			start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
		}else{
			start = month_date+'-'+cutoff.B_from;
			start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
			end = month_date+'-'+cutoff.B_to;
			end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
			start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
		}
		start_date = start;
		end_date = end;

		

		return UsersModel.findAll({
				where: {
					hr_generalist_id: user.id,
				},
				attributes: ['id'],
				raw: true
			});
		}).then(function(data){
			userIDS = data;
			userIDS = _.pluck(userIDS, 'id');
			
			let whereTSS = {};
			whereTSS.date = {
				[Op.gte]: start_date,
				[Op.lte]: end_date
			}
			if(isHRGeneralist > 0){
				whereTSS.user_id = {
					[Op.in]: userIDS
				}
			}
			return TSSData.findAll({
				where: whereTSS,
				include:[
					{
						model: UsersModel,
						as: 'users',
						attributes: ['id','first_name','last_name']
					}
				],
				raw: true
			}).then(data=>{
				result = data;
				
				result = groupBy(result, 'user_id');
				let array = Object.keys(result);
				let records = []
				
				if(array.length){
					for(let i in array){
						let key = array[i];
						let tss = result[key];
						var tssArr = tss.reduce((accumulator, current) => {

							if (checkIfAlreadyExist(current)) {
								return accumulator
							} else {
								return accumulator.concat([current]);
							}
							function checkIfAlreadyExist(currentVal) {
								return accumulator.some(function(item){
									return (item.user_id === currentVal.user_id && item.date === currentVal.date && item.shift_id === currentVal.shift_id);
								});
							}
						}, []);
						if(tssArr && tssArr.length){
							records.push(getProcessTSS(tss, key))
						}
					}
				}
				
				res.status(200).json({
					success: true,
					session: session,
					count: 0,
					records: records
				});
			});
		});
}

exports.store = function(req, res){
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('month_date').notEmpty().withMessage('The month year field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	let errors = req.validationErrors();
	
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		ConfigModel.findOne({
			where: {
				id: 1
			}
		}).then(function(data){
			config = data;
			json = config.json ? JSON.parse(config.json) : null;
			
			let label = req.body.label
			let cutoff = json.cutoff;
			let month_date = req.body.month_date;
			let period = req.body.period;
			month_date = res.locals.moment(month_date).format('YYYY-MM');
			if(period =='A'){
				start = month_date+'-'+cutoff.A_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.A_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}else{
				start = month_date+'-'+cutoff.B_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.B_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}
			start_date = start;
			end_date = end;
			
			TSS.findOne({
				where: {
					label: label
				},
				raw: true
			}).then(function(data){
				result = data;
				if(!result){
					let reqData = {
						label: req.body.label,
						start_date: start_date,
						end_date:  end_date,
						month_year: month_date,
						period: period
					}
					// console.log(reqData);
					TSS.create(reqData).then(data=>{
						result = data;
						let tss_id = result.id;
						let start_date = result.start_date;
						let end_date = result.end_date;
						TSSData.findAll({
							where:{
								date:{
									[Op.gte]: start_date,
									[Op.lte]: end_date
								},
							},
							raw: true
						}).then(data=>{
							result = data;
							
							if(result && result.length){
								result = groupBy(result, 'user_id');
								let array = Object.keys(result);
								
								if(array.length){
									for(let i in array){
										let key = array[i];
										let tss = result[key];
										var tssArr = tss.reduce((accumulator, current) => {

											if (checkIfAlreadyExist(current)) {
												return accumulator
											} else {
												return accumulator.concat([current]);
											}
											function checkIfAlreadyExist(currentVal) {
												return accumulator.some(function(item){
													return (item.user_id === currentVal.user_id && item.date === currentVal.date && item.shift_id === currentVal.shift_id);
												});
											}
										}, []);

										if(tssArr && tssArr.length){
											processTSS(tss, key, tss_id);
										}
									}
								}

								res.status(200).json({
									success: true,
									msg: 'New record has been successfully saved.'
								});
								
							}else{
								res.status(200).json({
									success: true,
									msg: 'New record has been successfully saved.'
								});
							}
							
							// console.log(result);
						});	
					});
				}else{
					res.status(200).json({
						success: false,
						action: 'close',
						msg: 'Record "' + label + '" is already posted.'
					});
				}
			});
		});
	}
}

exports.update = function(req, res){
	let id = req.body.id;
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('month_date').notEmpty().withMessage('The month year field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		ConfigModel.findOne({
			where: {
				id: 1
			}
		}).then(function(data){
			config = data;
			json = config.json ? JSON.parse(config.json) : null;
			
			let cutoff = json.cutoff;
			let month_date = req.body.month_date;
			let period = req.body.period;
			month_date = res.locals.moment(month_date).format('YYYY-MM');
			if(period =='A'){
				start = month_date+'-'+cutoff.A_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.A_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}else{
				start = month_date+'-'+cutoff.B_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.B_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}
			start_date = start;
			end_date = end;

			let reqData = {
				label: req.body.label,
				start_date: start_date,
				end_date:  end_date,
				month_year: month_date,
				period: period
			}
			TSS.update(reqData,{
				where: {
					id: id
				}
			}).then(data=>{
				result = data;
				let tss_id = id;
				let start_date = reqData.start_date;
				let end_date = reqData.end_date;
				TSSSummary.destroy({
					where: {
						tss_id: tss_id
					}
				}).then(data=>{
					TSSData.findAll({
						where:{
							date:{
								[Op.gte]: start_date,
								[Op.lte]: end_date
							},
						},
						// attributes: ['id','user_id','date','shift_id'],
						raw: true
					}).then(data=>{
						result = data;
						if(result && result.length){
							result = groupBy(result, 'user_id');
							let array = Object.keys(result);
							// console.log(array);
							if(array.length){
								for(let i in array){
									let key = array[i];
									let tss = result[key];
									var tssArr = tss.reduce((accumulator, current) => {

										if (checkIfAlreadyExist(current)) {
											return accumulator
										} else {
											return accumulator.concat([current]);
										}
										function checkIfAlreadyExist(currentVal) {
											return accumulator.some(function(item){
												return (item.user_id === currentVal.user_id && item.date === currentVal.date && item.shift_id === currentVal.shift_id);
											});
										}
								    }, []);
									if(tssArr && tssArr.length){
										processTSS(tssArr, key, tss_id);
									}
								}
							}
							res.status(200).json({
								success: true,
								action: 'fetch',
								msg: 'New record has been successfully saved.'
							});
						}else{
							res.status(200).json({
								success: true,
								action: 'fetch',
								msg: 'New record has been successfully saved.'
							});
						}
						
						// console.log(result);
					});	
				});
			});
		});
	}
}

const processTSS = function(row, user_id, tss_id = null){
	
		let RegHrs = 0;
		let LateHrs = 0;
		let UndertimeHrs = 0;
		let NDHrs = 0;
		let Absent = 0;
		let Leave01 = 0;
		let Leave02 = 0;
		let Leave03 = 0;
		let Leave04 = 0;
		let Leave05 = 0;
		let Leave06 = 0;
		let Leave07 = 0;
		let Leave08 = 0;
		let Leave09 = 0;
		let Leave10 = 0;
		let Leave11 = 0;
		let Leave12 = 0;
		let Leave13 = 0;
		let Leave14 = 0;
		let Leave15 = 0;
		let Leave16 = 0;
		let Leave17 = 0;
		let Leave18 = 0;
		let Leave19 = 0;
		let Leave20 = 0;
		let OTHrs01 = 0;
		let OTHrs02 = 0;
		let OTHrs03 = 0;
		let OTHrs04 = 0;
		let OTHrs05 = 0;
		let OTHrs06 = 0;
		let OTHrs07 = 0;
		let OTHrs08 = 0;
		let OTHrs09 = 0;
		let OTHrs10 = 0;
		let OTHrs11 = 0;
		let OTHrs12 = 0;
		let OTHrs13 = 0;
		let OTHrs14 = 0;
		let OTHrs15 = 0;
		let OTHrs16 = 0;
		let OTHrs17 = 0;
		let OTHrs18 = 0;
		let OTHrs19 = 0;
		let OTHrs20 = 0;
		let OTHrs21 = 0;
		let OTHrs22 = 0;
		let OTHrs23 = 0;
		let OTHrs24 = 0;
		let OTHrs25 = 0;
		let Rate = 0;
		let UnpaidRegHrs = 0;
		let UnpaidSL = 0;
		let UnpaidTaxSL = 0;
		let UnpaidVL = 0;
		let UnpaidTaxVL = 0;
		let UnpaidEL = 0;
		let EffectivityDate = 0;
		let EmpStatus = 0;
		let EffectivityDateResign = 0;
		for(let i in row){
			
			if(row[i].RegHrs){
				RegHrs += parseFloat(row[i].RegHrs);
			}
			if(row[i].LateHrs){
				LateHrs += parseFloat(row[i].LateHrs);
			}
			if(row[i].UndertimeHrs){
				UndertimeHrs += parseFloat(row[i].UndertimeHrs);
			}
			if(row[i].NDHrs){
				NDHrs += parseFloat(row[i].NDHrs);
			}
			if(row[i].Absent){
				Absent += parseFloat(row[i].Absent);
			}
			if(row[i].OTHrs01){
				OTHrs01 += parseFloat(row[i].OTHrs01);
			}
			if(row[i].OTHrs02){
				OTHrs02 += parseFloat(row[i].OTHrs02);
			}
			if(row[i].OTHrs03){
				OTHrs03 += parseFloat(row[i].OTHrs03);
			}
			if(row[i].OTHrs04){
				OTHrs04 += parseFloat(row[i].OTHrs04);
			}
			if(row[i].OTHrs05){
				OTHrs05 += parseFloat(row[i].OTHrs05);
			}
			if(row[i].OTHrs13){
				OTHrs13 += parseFloat(row[i].OTHrs13);
			}
			if(row[i].OTHrs14){
				OTHrs14 += parseFloat(row[i].OTHrs14);
			}
			if(row[i].OTHrs15){
				OTHrs15 += parseFloat(row[i].OTHrs15);
			}
			if(row[i].OTHrs16){
				OTHrs16 += parseFloat(row[i].OTHrs16);
			}
			if(row[i].OTHrs17){
				OTHrs17 += parseFloat(row[i].OTHrs17);
			}
			if(row[i].OTHrs18){
				OTHrs18 += parseFloat(row[i].OTHrs18);
			}
			if(row[i].OTHrs19){
				OTHrs19 += parseFloat(row[i].OTHrs19);
			}
			if(row[i].OTHrs20){
				OTHrs20 += parseFloat(row[i].OTHrs20);
			}
			if(row[i].OTHrs21){
				OTHrs21 += parseFloat(row[i].OTHrs21);
			}
			if(row[i].OTHrs22){
				OTHrs22 += parseFloat(row[i].OTHrs22);
			}
			if(row[i].OTHrs23){
				OTHrs23 += parseFloat(row[i].OTHrs23);
			}
			if(row[i].OTHrs24){
				OTHrs24 += parseFloat(row[i].OTHrs24);
			}
			if(row[i].OTHrs25){
				OTHrs25 += parseFloat(row[i].OTHrs25);
			}

			if(row[i].Leave01){
				Leave01 += parseFloat(row[i].Leave01);
			}
			if(row[i].Leave02){
				Leave02 += parseFloat(row[i].Leave02);
			}
			if(row[i].Leave03){
				Leave03 += parseFloat(row[i].Leave03);
			}
			if(row[i].Leave04){
				Leave04 += parseFloat(row[i].Leave04);
			}
			if(row[i].Leave05){
				Leave05 += parseFloat(row[i].Leave05);
			}
			if(row[i].Leave06){
				Leave06 += parseFloat(row[i].Leave06);
			}
			if(row[i].Leave07){
				Leave07 += parseFloat(row[i].Leave07);
			}
			if(row[i].Leave08){
				Leave08 += parseFloat(row[i].Leave08);
			}
			if(row[i].Leave09){
				Leave09 += parseFloat(row[i].Leave09);
			}
			if(row[i].Leave10){
				Leave10 += parseFloat(row[i].Leave10);
			}
			if(row[i].Leave11){
				Leave11 += parseFloat(row[i].Leave11);
			}
			if(row[i].Leave12){
				Leave12 += parseFloat(row[i].Leave12);
			}
			if(row[i].Leave13){
				Leave13 += parseFloat(row[i].Leave13);
			}
			if(row[i].Leave14){
				Leave14 += parseFloat(row[i].Leave14);
			}
			if(row[i].Leave15){
				Leave15 += parseFloat(row[i].Leave15);
			}
			if(row[i].Leave16){
				Leave16 += parseFloat(row[i].Leave16);
			}
			if(row[i].Leave17){
				Leave17 += parseFloat(row[i].Leave17);
			}
			if(row[i].Leave18){
				Leave18 += parseFloat(row[i].Leave18);
			}
			if(row[i].Leave19){
				Leave19 += parseFloat(row[i].Leave19);
			}
			if(row[i].Leave20){
				Leave20 += parseFloat(row[i].Leave20);
			}
			if(row[i].Rate){
				Rate += parseFloat(row[i].Rate);
			}
			if(row[i].UnpaidRegHrs){
				UnpaidRegHrs += parseFloat(row[i].UnpaidRegHrs);
			}
			if(row[i].UnpaidSL){
				UnpaidSL += parseFloat(row[i].UnpaidSL);
			}
			if(row[i].UnpaidTaxSL){
				UnpaidTaxSL += parseFloat(row[i].UnpaidTaxSL);
			}
			if(row[i].UnpaidVL){
				UnpaidVL += parseFloat(row[i].UnpaidVL);
			}
			if(row[i].UnpaidTaxVL){
				UnpaidTaxVL += parseFloat(row[i].UnpaidTaxVL);
			}
			if(row[i].UnpaidEL){
				UnpaidEL += parseFloat(row[i].UnpaidEL);
			}
			if(row[i].EffectivityDate){
				EffectivityDate += parseFloat(row[i].EffectivityDate);
			}
			if(row[i].EmpStatus){
				EmpStatus += parseFloat(row[i].EmpStatus);
			}
			if(row[i].EffectivityDateResign){
				EffectivityDateResign += parseFloat(row[i].EffectivityDateResign);
			}
		}
		if(LateHrs > 0){
			LateHrs = LateHrs / 60;
		}
		if(UndertimeHrs > 0){
			UndertimeHrs = UndertimeHrs / 60;
		}

		let reqData = {
			tss_id: tss_id,
			user_id: user_id,
			RegHrs: RegHrs,
			LateHrs: LateHrs,
			UndertimeHrs: UndertimeHrs,
			NDHrs: NDHrs,
			Absent: Absent,
			Leave01: Leave01,
			Leave02: Leave02,
			Leave03: Leave03,
			Leave04: Leave04,
			Leave05: Leave05,
			Leave06: Leave06,
			Leave07: Leave07,
			Leave08: Leave08,
			Leave09: Leave09,
			Leave10: Leave10,
			Leave11: Leave11,
			Leave12: Leave12,
			Leave13: Leave13,
			Leave14: Leave14,
			Leave15: Leave15,
			Leave16: Leave16,
			Leave17: Leave17,
			Leave18: Leave18,
			Leave19: Leave19,
			Leave20: Leave20,
			OTHrs01: OTHrs01,
			OTHrs02: OTHrs02,
			OTHrs03: OTHrs03,
			OTHrs04: OTHrs04,
			OTHrs05: OTHrs05,
			OTHrs06: OTHrs06,
			OTHrs07: OTHrs07,
			OTHrs08: OTHrs08,
			OTHrs09: OTHrs09,
			OTHrs10: OTHrs10,
			OTHrs11: OTHrs11,
			OTHrs12: OTHrs12,
			OTHrs13: OTHrs13,
			OTHrs14: OTHrs14,
			OTHrs15: OTHrs15,
			OTHrs16: OTHrs16,
			OTHrs17: OTHrs17,
			OTHrs18: OTHrs18,
			OTHrs19: OTHrs19,
			OTHrs20: OTHrs20,
			OTHrs21: OTHrs21,
			OTHrs22: OTHrs22,
			OTHrs23: OTHrs23,
			OTHrs24: OTHrs24,
			OTHrs25: OTHrs25,
			Rate: Rate,
			UnpaidRegHrs: UnpaidRegHrs,
			UnpaidSL: UnpaidSL,
			UnpaidTaxSL: UnpaidTaxSL,
			UnpaidVL: UnpaidVL,
			UnpaidTaxVL: UnpaidTaxVL,
			UnpaidEL: UnpaidEL,
			EffectivityDate: EffectivityDate,
			EmpStatus: EmpStatus,
			EffectivityDateResign: EffectivityDateResign,
		}
		TSSSummary.count({
			where:{
				tss_id: tss_id,
				user_id: user_id,
			}
		}).then(data=>{
			count = data;
			
			if(!count){
				TSSSummary.create(reqData);
			}else{
				TSSSummary.update(reqData,{
					where:{
						tss_id: tss_id,
						user_id: user_id,
					}
				});
			}
		})
}

const getProcessTSS = function(row, user_id){
	
		let RegHrs = 0;
		let LateHrs = 0;
		let UndertimeHrs = 0;
		let NDHrs = 0;
		let Absent = 0;
		let Leave01 = 0;
		let Leave02 = 0;
		let Leave03 = 0;
		let Leave04 = 0;
		let Leave05 = 0;
		let Leave06 = 0;
		let Leave07 = 0;
		let Leave08 = 0;
		let Leave09 = 0;
		let Leave10 = 0;
		let Leave11 = 0;
		let Leave12 = 0;
		let Leave13 = 0;
		let Leave14 = 0;
		let Leave15 = 0;
		let Leave16 = 0;
		let Leave17 = 0;
		let Leave18 = 0;
		let Leave19 = 0;
		let Leave20 = 0;
		let OTHrs01 = 0;
		let OTHrs02 = 0;
		let OTHrs03 = 0;
		let OTHrs04 = 0;
		let OTHrs05 = 0;
		let OTHrs06 = 0;
		let OTHrs07 = 0;
		let OTHrs08 = 0;
		let OTHrs09 = 0;
		let OTHrs10 = 0;
		let OTHrs11 = 0;
		let OTHrs12 = 0;
		let OTHrs13 = 0;
		let OTHrs14 = 0;
		let OTHrs15 = 0;
		let OTHrs16 = 0;
		let OTHrs17 = 0;
		let OTHrs18 = 0;
		let OTHrs19 = 0;
		let OTHrs20 = 0;
		let OTHrs21 = 0;
		let OTHrs22 = 0;
		let OTHrs23 = 0;
		let OTHrs24 = 0;
		let OTHrs25 = 0;
		let Rate = 0;
		let UnpaidRegHrs = 0;
		let UnpaidSL = 0;
		let UnpaidTaxSL = 0;
		let UnpaidVL = 0;
		let UnpaidTaxVL = 0;
		let UnpaidEL = 0;
		let EffectivityDate = 0;
		let EmpStatus = 0;
		let EffectivityDateResign = 0;
		for(let i in row){
			
			if(row[i].RegHrs){
				RegHrs += parseFloat(row[i].RegHrs);
			}
			if(row[i].LateHrs){
				LateHrs += parseFloat(row[i].LateHrs);
			}
			if(row[i].UndertimeHrs){
				UndertimeHrs += parseFloat(row[i].UndertimeHrs);
			}
			if(row[i].NDHrs){
				NDHrs += parseFloat(row[i].NDHrs);
			}
			if(row[i].Absent){
				Absent += parseFloat(row[i].Absent);
			}
			if(row[i].OTHrs01){
				OTHrs01 += parseFloat(row[i].OTHrs01);
			}
			if(row[i].OTHrs02){
				OTHrs02 += parseFloat(row[i].OTHrs02);
			}
			if(row[i].OTHrs03){
				OTHrs03 += parseFloat(row[i].OTHrs03);
			}
			if(row[i].OTHrs04){
				OTHrs04 += parseFloat(row[i].OTHrs04);
			}
			if(row[i].OTHrs05){
				OTHrs05 += parseFloat(row[i].OTHrs05);
			}
			if(row[i].OTHrs13){
				OTHrs13 += parseFloat(row[i].OTHrs13);
			}
			if(row[i].OTHrs14){
				OTHrs14 += parseFloat(row[i].OTHrs14);
			}
			if(row[i].OTHrs15){
				OTHrs15 += parseFloat(row[i].OTHrs15);
			}
			if(row[i].OTHrs16){
				OTHrs16 += parseFloat(row[i].OTHrs16);
			}
			if(row[i].OTHrs17){
				OTHrs17 += parseFloat(row[i].OTHrs17);
			}
			if(row[i].OTHrs18){
				OTHrs18 += parseFloat(row[i].OTHrs18);
			}
			if(row[i].OTHrs19){
				OTHrs19 += parseFloat(row[i].OTHrs19);
			}
			if(row[i].OTHrs20){
				OTHrs20 += parseFloat(row[i].OTHrs20);
			}
			if(row[i].OTHrs21){
				OTHrs21 += parseFloat(row[i].OTHrs21);
			}
			if(row[i].OTHrs22){
				OTHrs22 += parseFloat(row[i].OTHrs22);
			}
			if(row[i].OTHrs23){
				OTHrs23 += parseFloat(row[i].OTHrs23);
			}
			if(row[i].OTHrs24){
				OTHrs24 += parseFloat(row[i].OTHrs24);
			}
			if(row[i].OTHrs25){
				OTHrs25 += parseFloat(row[i].OTHrs25);
			}

			if(row[i].Leave01){
				Leave01 += parseFloat(row[i].Leave01);
			}
			if(row[i].Leave02){
				Leave02 += parseFloat(row[i].Leave02);
			}
			if(row[i].Leave03){
				Leave03 += parseFloat(row[i].Leave03);
			}
			if(row[i].Leave04){
				Leave04 += parseFloat(row[i].Leave04);
			}
			if(row[i].Leave05){
				Leave05 += parseFloat(row[i].Leave05);
			}
			if(row[i].Leave06){
				Leave06 += parseFloat(row[i].Leave06);
			}
			if(row[i].Leave07){
				Leave07 += parseFloat(row[i].Leave07);
			}
			if(row[i].Leave08){
				Leave08 += parseFloat(row[i].Leave08);
			}
			if(row[i].Leave09){
				Leave09 += parseFloat(row[i].Leave09);
			}
			if(row[i].Leave10){
				Leave10 += parseFloat(row[i].Leave10);
			}
			if(row[i].Leave11){
				Leave11 += parseFloat(row[i].Leave11);
			}
			if(row[i].Leave12){
				Leave12 += parseFloat(row[i].Leave12);
			}
			if(row[i].Leave13){
				Leave13 += parseFloat(row[i].Leave13);
			}
			if(row[i].Leave14){
				Leave14 += parseFloat(row[i].Leave14);
			}
			if(row[i].Leave15){
				Leave15 += parseFloat(row[i].Leave15);
			}
			if(row[i].Leave16){
				Leave16 += parseFloat(row[i].Leave16);
			}
			if(row[i].Leave17){
				Leave17 += parseFloat(row[i].Leave17);
			}
			if(row[i].Leave18){
				Leave18 += parseFloat(row[i].Leave18);
			}
			if(row[i].Leave19){
				Leave19 += parseFloat(row[i].Leave19);
			}
			if(row[i].Leave20){
				Leave20 += parseFloat(row[i].Leave20);
			}
			if(row[i].Rate){
				Rate += parseFloat(row[i].Rate);
			}
			if(row[i].UnpaidRegHrs){
				UnpaidRegHrs += parseFloat(row[i].UnpaidRegHrs);
			}
			if(row[i].UnpaidSL){
				UnpaidSL += parseFloat(row[i].UnpaidSL);
			}
			if(row[i].UnpaidTaxSL){
				UnpaidTaxSL += parseFloat(row[i].UnpaidTaxSL);
			}
			if(row[i].UnpaidVL){
				UnpaidVL += parseFloat(row[i].UnpaidVL);
			}
			if(row[i].UnpaidTaxVL){
				UnpaidTaxVL += parseFloat(row[i].UnpaidTaxVL);
			}
			if(row[i].UnpaidEL){
				UnpaidEL += parseFloat(row[i].UnpaidEL);
			}
			if(row[i].EffectivityDate){
				EffectivityDate += parseFloat(row[i].EffectivityDate);
			}
			if(row[i].EmpStatus){
				EmpStatus += parseFloat(row[i].EmpStatus);
			}
			if(row[i].EffectivityDateResign){
				EffectivityDateResign += parseFloat(row[i].EffectivityDateResign);
			}
		}

		if(LateHrs > 0){
			LateHrs = LateHrs / 60;
		}
		if(UndertimeHrs > 0){
			UndertimeHrs = UndertimeHrs / 60;
		}

		let First_name = row[0]['users.first_name']
		let Last_name = row[0]['users.last_name']
		let reqData = {
			user_id: user_id,
			RegHrs: RegHrs,
			LateHrs: LateHrs,
			UndertimeHrs: UndertimeHrs,
			NDHrs: NDHrs,
			Absent: Absent,
			Leave01: Leave01,
			Leave02: Leave02,
			Leave03: Leave03,
			Leave04: Leave04,
			Leave05: Leave05,
			Leave06: Leave06,
			Leave07: Leave07,
			Leave08: Leave08,
			Leave09: Leave09,
			Leave10: Leave10,
			Leave11: Leave11,
			Leave12: Leave12,
			Leave13: Leave13,
			Leave14: Leave14,
			Leave15: Leave15,
			Leave16: Leave16,
			Leave17: Leave17,
			Leave18: Leave18,
			Leave19: Leave19,
			Leave20: Leave20,
			OTHrs01: OTHrs01,
			OTHrs02: OTHrs02,
			OTHrs03: OTHrs03,
			OTHrs04: OTHrs04,
			OTHrs05: OTHrs05,
			OTHrs06: OTHrs06,
			OTHrs07: OTHrs07,
			OTHrs08: OTHrs08,
			OTHrs09: OTHrs09,
			OTHrs10: OTHrs10,
			OTHrs11: OTHrs11,
			OTHrs12: OTHrs12,
			OTHrs13: OTHrs13,
			OTHrs14: OTHrs14,
			OTHrs15: OTHrs15,
			OTHrs16: OTHrs16,
			OTHrs17: OTHrs17,
			OTHrs18: OTHrs18,
			OTHrs19: OTHrs19,
			OTHrs20: OTHrs20,
			OTHrs21: OTHrs21,
			OTHrs22: OTHrs22,
			OTHrs23: OTHrs23,
			OTHrs24: OTHrs24,
			OTHrs25: OTHrs25,
			Rate: Rate,
			UnpaidRegHrs: UnpaidRegHrs,
			UnpaidSL: UnpaidSL,
			UnpaidTaxSL: UnpaidTaxSL,
			UnpaidVL: UnpaidVL,
			UnpaidTaxVL: UnpaidTaxVL,
			UnpaidEL: UnpaidEL,
			EffectivityDate: EffectivityDate,
			EmpStatus: EmpStatus,
			EffectivityDateResign: EffectivityDateResign,
			First_name: First_name,
			Last_name: Last_name,
		}
		return reqData
}

const groupBy = function(xs, key) {
  return xs.reduce(function(rv, x) {
    (rv[x[key]] = rv[x[key]] || []).push(x);
    return rv;
  }, {});
};