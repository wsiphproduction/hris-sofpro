const DateHelper = require('../Helper/DateHelper');
const Notification = require('../Helper/Notification');
const UserRole = require('../Helper/UserRole');
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const { 
	UsersModel,
	ShiftsModel,
	ApproversModel,
	CustomApproverModel
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let view = req.query.view;
	let user = res.locals.user;
	UserRole.get_role(user, 'forms-shift').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				if(typeof view != 'undefined' && view == 'calendar'){
					res.render('Form/Shift/calendar',{
						route: 'form-shift',
						usrRole: usrRole
					});
				}else{
					res.render('Form/Shift/index',{
						route: 'form-shift',
						usrRole: usrRole,
						user_role: user_role
					});
				}
			});
		}
	});
}

exports.fetch = function(req, res){
	let user = res.locals.user;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	let where = {
		user_id: user.id
	}
	if(status){
		where.$or = [
			{
				primary_status: status
			},{
				backup_status: status
			}
		]
	}else{
		where.primary_status = {
			$ne: 4
		}
		where.backup_status = {
			$ne: 4
		}
	}
	if((start && end) && (start <= end)){
		where.date = {
	        $between: [start, end]
	    }
	}
	ShiftsModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return ShiftsModel.findAll({
			where: where,
			order: [
				['date', 'DESC']
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		records = data;

		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
        res.status(200).json({
            success: true,
            records: records,
			count: count,
        });
	});
}

exports.calendar = function(req, res){
	
	let user = res.locals.user;
	let start = new Date(req.body.date);
		start.setMonth(start.getMonth() - 1);
		start.setDate(15);

		start = res.locals.moment(start).format('YYYY-MM-DD');
	let end = new Date(req.body.date);
		end.setMonth(end.getMonth() + 1);
		end.setDate(15);

		end = res.locals.moment(end).format('YYYY-MM-DD');
	
	ShiftsModel.findAll({
		where: {
			user_id: user.id,
			date: {
				$between: [start, end]
			}
		}
	}).then(function(data){
		record = data;
		res.status(200).json({
			success: true,
            record
		});
	});
}


exports.store = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
		let user = res.locals.user;
		let user_id = user.id;
		let branch_id = user.company_branch_id;
		let department_id = user.department_id;

		ApproversModel.findOne({
			where: {
				company_location_id: branch_id,
				department_id: department_id
			}
		}).then(function(data){
			approvers = data ? data : null;
			if(approvers){
			approvers = JSON.parse(JSON.stringify(approvers));
			}

			return CustomApproverModel.findOne({
				where: {
					user_id: user_id
				}
			});
		}).then(function(data){
			custom = data;
			if(custom){
			custom = JSON.parse(JSON.stringify(custom));
			}
			approvers = custom ? custom : approvers;
			
			let type 		 = req.body.type;
			let repeat 		 = req.body.repeat;
			let shift_length = req.body.shift_length;
			let paid_hours 	 = req.body.paid_hours;
			let start_date 	 = req.body.start_date;
			let end_date 	 = req.body.end_date;
			let start_time 	 = req.body.start_time;
			let end_time 	 = req.body.end_time;
			let between_start= req.body.between_start;
			let between_end  = req.body.between_end;
			let days 		 = req.body.days;
			let onsite 		 = req.body.onsite;

			req.checkBody('type').notEmpty().withMessage('The shift type field is required.');
			req.checkBody('repeat').notEmpty().withMessage('The shift repeat field is required.');
			req.checkBody('shift_length').notEmpty().withMessage('The shift length field is required.');
			req.checkBody('paid_hours').notEmpty().withMessage('The paid hours field is required.');
			req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
			req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');

			if(type == 1){
				req.checkBody('start_time').notEmpty().withMessage('The start time field is required.');
				req.checkBody('end_time').notEmpty().withMessage('The end time field is required.');
			}else if(type == 3){
				req.checkBody('onsite').notEmpty().withMessage('The onsite field is required.');
			}else if(type == 3){
				req.checkBody('between_start').notEmpty().withMessage('The time between field is required.');
				req.checkBody('between_end').notEmpty().withMessage('The time between field is required.');
			}

			if(repeat == 3){
				req.checkBody('days').notEmpty().withMessage('The applicable days field is required.');
			}

			let errors = req.validationErrors();

			if(errors){
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				if(approvers && approvers.primary_approver_id && approvers.backup_approver_id){
					let primary_approver = approvers.primary_approver_id;
					let backup_approver  = approvers.backup_approver_id;

					let startDate = new Date(DateHelper.date(start_date));
					let endDate   = new Date(DateHelper.date(end_date));

					var dateArr  = DateHelper.dateArray(startDate, endDate);
					let check_in = null;
					let check_out= null;
					let betweenStart  = null;
					let betweenEnd  = null;
					
					for(let x in dateArr){
						let date = res.locals.moment(dateArr[x]).format('YYYY-MM-DD');
						let day  = res.locals.moment(dateArr[x]).format('dddd');
							day  = day.toLowerCase();
						let check= days.includes(day);

						if(type == 1){
							check_in = res.locals.moment(start_time).format('HH:mm:ss');
							check_out= res.locals.moment(end_time).format('HH:mm:ss');
						}else if(type == 3){
							betweenStart = res.locals.moment(between_start).format('HH:mm:ss');
							betweenEnd   = res.locals.moment(between_end).format('HH:mm:ss');
						}
			
						//UPLOADING OF FILES
						let attachment 	= files.attachment;			
						let filename = null;
			
						if(attachment && attachment.size > 0){
							let path = attachment.path;
							let origFileName = attachment.name;
							let ext = origFileName.split(".");
								ext = ext.pop()
							filename = uuidv4(origFileName) + '.'+ ext;
							
			
							fs.readFile(path, function(err, data){
								fs.writeFile(uploadPath + filename, data, function(err){
									if (err) console.log(err);
									fs.unlink(path, function(err){});
								});
							});
						}

						let shiftData = {
							user_id: user.id,
							type: type,
							date: date,
							check_in: check_in,
							check_out: check_out,
							between_start: betweenStart,
							between_end: betweenEnd,
							primary_status: 1,
							backup_status: 1,
							shift_length: shift_length,
							paid_hours: paid_hours,
							primary_approver: primary_approver,
							backup_approver: backup_approver,
							onsite: onsite
						}

						if(attachment && attachment.size > 0){                
							shiftData.attachment = filename
						}

						//console.log(check);
						if(repeat == 3){
							if(check){
								ShiftsModel.count({
									where: {
										user_id: user.id,
										date: date
									}
								}).then(function(data){
									if(!data){
										ShiftsModel.create(shiftData);
									}
								});
							}
						}else{

							ShiftsModel.count({
								where: {
									user_id: user.id,
									date: date
								}
							}).then(function(data){
								if(!data){
									ShiftsModel.create(shiftData);
								}
							});
						}
						
					}
					
					let notificationMessage = {
						sender: user.id,
						content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> sent shift application that requires your approval.',
						url: 'approvals/shift'
					}
					
					let receiver = [primary_approver, backup_approver];

					Notification.notify(notificationMessage, receiver, 'shift', 'create');

					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'New record has been successfully saved.'
					});
				}else{
					var error = [
						{	
							param: 'approver',
							msg: 'Failed! Approver is required. Please contact administrator.'
						}
					]
					res.status(422).json({
						success: false,
						errors: error
					});
				}
			}
		});
	});
}


exports.edit = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;
	ShiftsModel.findOne({
		where: {
			id: id,
			user_id: user.id
		},
		include: [
			{
				model: UsersModel, as: 'primary',
				attributes: ['id','first_name', 'last_name']
			},{
				model: UsersModel, as: 'backup',
				attributes: ['id','first_name', 'last_name']
			}
		]
	}).then(function(data){
		if(!data) res.status(404).json({
			success: false,
			msg: 'No record found for the given selection.'
		});
		res.status(200).json({
			success: true,
			record: data
		});
	});
}


exports.update = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
		let id = req.body.id;

		req.checkBody('type').notEmpty().withMessage('The shift type field is required.');
		req.checkBody('shift_length').notEmpty().withMessage('The shift length field is required.');
		req.checkBody('paid_hours').notEmpty().withMessage('The paid hours field is required.');

		if(req.body.type == 1){
			req.checkBody('start_time').notEmpty().withMessage('The start time field is required.');
			req.checkBody('end_time').notEmpty().withMessage('The end time field is required.');
		}else if(req.body.type == 2){
			req.checkBody('onsite').notEmpty().withMessage('The onsite field is required.');
		}else if(req.body.type == 3){
			req.checkBody('between_start').notEmpty().withMessage('The time between field is required.');
			req.checkBody('between_end').notEmpty().withMessage('The time between field is required.');
		}

		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let check_in = null;
			let check_out = null;
			let between_start = null;
			let between_end = null;

			if(req.body.type == 1){
				check_in = res.locals.moment(req.body.start_time).format('HH:mm:ss');
				check_out= res.locals.moment(req.body.end_time).format('HH:mm:ss');
			}else if(req.body.type == 3){
				between_start = res.locals.moment(req.body.between_start).format('HH:mm:ss');
				between_end   = res.locals.moment(req.body.between_end).format('HH:mm:ss');
			}
			
			//UPLOADING OF FILES
			let attachment 	= files.attachment;			
			let filename = null;

			if(attachment && attachment.size > 0){
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				filename = uuidv4(origFileName) + '.'+ ext;
				

				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){});
					});
				});
			}

			let shiftData = {
				type: req.body.type,
				shift_length: req.body.shift_length,
				paid_hours: req.body.paid_hours,
				check_in: check_in,
				check_out: check_out,
				between_start: between_start,
				between_end: between_end,
				onsite: req.body.onsite
			}

			if(attachment && attachment.size > 0){                
				shiftData.attachment = filename
			}

			ShiftsModel.update(shiftData, {
				where: {
					id: id
				}
			}).then(function(data){	
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Record has been successfully updated.'
				});
			});
		}
	});
}


exports.archive = function(req, res){
	let id = req.body.id;

	let data = {
		primary_status: 4,
		backup_status: 4,
	}

	ShiftsModel.update(data, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}

