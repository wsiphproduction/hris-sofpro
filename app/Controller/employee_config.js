const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	BiometricModel,
	BiometricNumberModel,
	UserSettingModel,
	WorkScheduleModel,
	ShiftType
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	let id 		= req.params.id;
	let path    = req.path.split('/');
	let segment = path[2];
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UsersModel.findOne({
			where: {
				shortid: id
			}
		})
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'employee-config').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/Config/index',{
						employee: employee,
						usrRole: usrRole,
						segment: segment,
						overtime: [],
						user_role: user_role,
						route: 'employee'
					});
				}
			});
		}
	});
}

exports.store = function(req, res){
	let shortid = req.params.id;
	UsersModel.findOne({
		where: {
			shortid: shortid
		}
	}).then(function(data){
		employee = data;
		let siteId = req.body.site;
		let user_id = employee.id;
		req.checkBody('site').notEmpty().withMessage('The site field is required.');
		req.checkBody('number').notEmpty().withMessage('The biometric number field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			BiometricNumberModel.count({
				where: {
					biometric_id: siteId,
					biometric_number: req.body.number
				}
			}).then(function(data){
				count = data;
				if(!count){
					let reqBody = {
						user_id: employee.id,
						biometric_id: req.body.site,
						biometric_number: req.body.number
					}
					BiometricNumberModel.create(reqBody).then(function(data){
						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'Biometric number has been created.'
						});
					});
				}else{
					var errors = [
						{	
							param: 'number',
							msg: 'The biometric number has already been taken.'
						}
					]
					res.status(422).json({
						success: false,
						errors
					});
				}
			});
		}
	});
}

exports.update = function(req, res){
	let id = req.body.id;
	let site = req.body.site;
	let number = req.body.number;
	BiometricNumberModel.count({
		where: {
			id: {
				$ne: id
			},
			biometric_id: site,
			biometric_number: number
		}
	}).then(function(data){
		count = data;
		if(count){
			var errors = [
				{	
					param: 'number',
					msg: 'The biometric number has already been taken.'
				}
			]
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let reqBody = {
				biometric_id: site,
				biometric_number: number
			}
			BiometricNumberModel.update(reqBody, {
				where: {
					id: id
				}
			}).then(function(data){
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Biometric number has been updated.'
				});
			});
		}
	});
}

exports.fetch = function(req, res){
	let shortid = req.body.shortid;
	UsersModel.findOne({
		where: {
			shortid: shortid
		},
		attributes: ['id','first_name','last_name']
	}).then(function(data){
		employee = data;
		return BiometricNumberModel.findAll({
			where:{
				user_id: employee.id
			},
			attributes: ['id','biometric_id','biometric_number'],
			include: [
				{
					model: BiometricModel,
					attributes: ['id','site','label'],
				}
			]
		});
	}).then(function(data){
		records = data;
		return ShiftType.findAll({
			raw: true
		});
	}).then(function(data){
		shift_types = data;
		return BiometricModel.findAll();
	}).then(function(data){
		sites = data;
		return UserSettingModel.findOne({
			where: {
				user_id: employee.id
			}
		});
	}).then(function(data){
		user_setting = data;
		
		return WorkScheduleModel.findOne({
			where: {
				user_id: employee.id
			}
		});
		
	}).then(function(data){
		workSchedule = data;
		//console.log(workSchedule);
		res.status(200).json({
			success: true,
			records: records,
			shift_types: shift_types,
			sites: sites,
			employee: employee,
			user_setting: user_setting,
			workSchedule: workSchedule
		});
	});
	
}

exports.delete = function(req, res){
	let id = req.body.id;
	BiometricNumberModel.destroy({
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true,
            record
		});
	});
}

exports.update_setting = function(req, res){
	let id      = req.body.id;
	let user_id = req.body.user_id;
	req.checkBody('overtime').notEmpty().withMessage('The overtime field is required.');
	req.checkBody('holiday').notEmpty().withMessage('The holiday field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		UserSettingModel.findOne({
			where: {
				user_id: user_id
			}
		}).then(function(data){
			record = data;
			let reqData = {
				has_holiday: req.body.holiday,
				has_overtime: req.body.overtime
			}
			if(record){
				UserSettingModel.update(reqData, {
					where: {
						id: id
					}
				}).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been updated.'
					});
				});
			}else{
				reqData.user_id = user_id;
				UserSettingModel.create(reqData).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been updated.'
					});
				});
			}
		});
	}
	
}

exports.update_work_schedule = function(req, res){
	let user_id = req.body.user_id;
	let method = req.body.method;
	let break_type = req.body.break_type;
	let type = req.body.type;
	
	//req.checkBody('method').notEmpty().withMessage('The method field is required.');
	req.checkBody('break_type').notEmpty().withMessage('The Break Type field is required.');
	if(break_type == 1) {
		req.checkBody('rooster_break').notEmpty().withMessage('The Rooster Break field is required.');
		req.checkBody('shift_type').notEmpty().withMessage('The Shift Type field is required.');
		// req.checkBody('destination_entitlement').notEmpty().withMessage('The Destination Entitlement field is required.');
	}
	req.checkBody('effective_date').notEmpty().withMessage('The effective date field is required.');
	
	if(method == 2){
		let monday = req.body.monday;
		let tuesday = req.body.tuesday;
		let wednesday = req.body.wednesday;
		let thursday = req.body.thursday;
		let friday = req.body.friday;
		let saturday = req.body.saturday;
		let sunday = req.body.sunday;
		req.checkBody('type').notEmpty().withMessage('The type field is required.');
		req.checkBody('effective_date').notEmpty().withMessage('The effective date field is required.');
		req.checkBody('shift_length').notEmpty().withMessage('The shift length field is required.');
		req.checkBody('paid_hours').notEmpty().withMessage('The paid hours field is required.');
		if(type == 3){
			req.checkBody('between_start').notEmpty().withMessage('The between start field is required.');
			req.checkBody('between_end').notEmpty().withMessage('The between end field is required.');
		}
		if(type == 1){
			req.checkBody('start_time').notEmpty().withMessage('The start time field is required.');
			req.checkBody('end_time').notEmpty().withMessage('The end time field is required.');
		}
		req.body.days = 'ok';
		if(!monday && !tuesday && !wednesday && !thursday && !friday && !saturday && !sunday){
			req.body.days = '';
		}
		req.checkBody('days').notEmpty().withMessage('Please select days.');
	}
	
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		UserSettingModel.findOne({
			where: {
				user_id: user_id
			},
			raw: true
		}).then(function(data){
			record = data;
			let reqData = {
				work_schedule_method: method
			}
			if(record){
				UserSettingModel.update(reqData, {
					where: {
						id: record.id
					}
				}).then(function(data){
					if(method == 2 || method == 3){
						setWorkSchedule(req.body, res, user_id);
					}
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been updated.'
					});
				});
			}else{
				reqData.user_id = user_id;
				UserSettingModel.create(reqData).then(function(data){
					if(method == 2 || method == 3){
						setWorkSchedule(req.body, res, user_id);
					}
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been updated.'
					});
				});
			}
		});
	}
}

const setWorkSchedule = function(req, res, user_id){
	let reqData = {
		type: req.type,
		effective_date: res.locals.moment(req.effective_date).format('YYYY-MM-DD'),
		check_in: req.type == 1 ? res.locals.moment(req.start_time).format('HH:mm:ss') : null,
		check_out: req.type == 1 ? res.locals.moment(req.end_time).format('HH:mm:ss') : null,
		between_start: req.type == 3 ? res.locals.moment(req.between_start).format('HH:mm:ss') : null,
		between_end: req.type == 3 ? res.locals.moment(req.between_end).format('HH:mm:ss') : null,
		shift_length: req.shift_length,
		paid_hours: req.paid_hours ? req.paid_hours : 0,
		monday: req.monday ? 1 : 0,
		tuesday: req.tuesday ? 1 : 0,
		wednesday: req.wednesday ? 1 : 0,
		thursday: req.thursday ? 1 : 0,
		friday: req.friday ? 1 : 0,
		saturday: req.saturday ? 1 : 0,
		sunday: req.sunday ? 1 : 0,
		break_type: req.break_type,
		rooster_break: req.rooster_break,
		// destination_entitlement: req.break_type == 1 ? null : null,
		shift_type: req.shift_type,
	}
	WorkScheduleModel.findOne({
		where: {
			user_id: user_id
		},
		raw: true
	}).then(function(data){
		result = data;
		if(result){
			WorkScheduleModel.update(reqData, {
				where: {
					id: result.id
				}
			});
		}else{
			reqData.user_id = user_id;
			WorkScheduleModel.create(reqData);
		}
	});
}