const Notification = require('../Helper/Notification');
const PrepareMail = require('../Helper/PrepareMail');
const NightDiffHelper = require('../Helper/NightDiffHelper');
const OvertimeHelper = require('../Helper/OvertimeHelper');
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const _ = require('underscore');
const UserRole = require('../Helper/UserRole');
const moment     	= require('moment-timezone');
moment.tz.setDefault('Asia/Manila');
const { 
	UsersModel,
	OvertimesModel,
	ApproversModel,
	CustomApproverModel,
	ShiftsModel
} = require('../../config/Sequelize');


exports.index = function(req, res){
	console.log("HAI")
	let user = res.locals.user;
	// OvertimeHelper.process();
	UserRole.get_role(user, 'forms-overtime').then(function(data){
		user_role = data;
		return UserRole.allRead(user);
	}).then(function(data){
		usrRole = data;
		if(!user_role.read || !usrRole['has_overtime']){
			res.render('Errors/404');
		}else{
			res.render('Form/Overtime/index',{
				route: 'form-overtime',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.fetch = function(req, res){
	let user    = res.locals.user;
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
		where.start_date = {
	        $between: [start, end]
	    }
	}
	OvertimesModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return OvertimesModel.findAll({
			where: where,
			include:[
				{
					model: UsersModel,
					as: 'primary'
				},
				{
					model: UsersModel,
					as: 'backup'
				}

			],
			order: [
				['created_at', 'DESC']
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

exports.store = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let user = res.locals.user;
		let user_id = user.id;
		let branch_id = user.company_branch_id;
		let department_id = user.department_id;

		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		// req.checkBody('no_of_hours').notEmpty().withMessage('The number of hours field is required.');
		// req.checkBody('type').notEmpty().withMessage('The overtime type field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let attachment = files.attachment;
			let filename = null;

			if(attachment && attachment.size > 0){
				var oldFile = uploadPath + record.attachment;
				//Delete File if exists
				try {
					if (fs.existsSync(oldFile)) {
						fs.unlinkSync(oldFile);
					}
				} catch(err) {
					console.log('Cant find.')
				}
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

			let primary_approver = req.body.approver_id;
			let backup_approver = req.body.approver_secondary_id;
			let overtime = req.body.overtime;
			let start_date = res.locals.moment(req.body.start_date).format('YYYY-MM-DD');
			let end_date   = res.locals.moment(req.body.end_date).format('YYYY-MM-DD');
			let start_time = res.locals.moment(req.body.start_date).format('HH:mm:ss');
			let end_time   = res.locals.moment(req.body.end_date).format('HH:mm:ss');

			// Allow last minute overlap
			let overlap_start_time = res.locals.moment(req.body.start_date).add(1, 'minutes').format('HH:mm:ss');
			let overlap_end_time = res.locals.moment(req.body.end_date).subtract(1, 'minutes').format('HH:mm:ss');

			ShiftsModel.count({
				where: {
					date: start_date,
					user_id: user.id
				}
			}).then(data=>{
				shift = data;
				let start = res.locals.moment(start_date +' '+ start_time);
				let end = res.locals.moment(end_date +' '+ end_time);
				let no_of_hours = end.diff(start, 'hours');
				let OTHrs01Mins = parseInt(moment(end).diff(moment(start), 'minutes')) - no_of_hours * 60;
					no_of_hours = no_of_hours+'.'+OTHrs01Mins;
				let type = shift && shift > 0 ? 1 : 2;

				let inputData = {
					user_id: user.id,
					start_date: start_date,
					end_date: end_date,
					start_time: start_time,
					end_time: end_time,
					no_of_hours: isNaN(no_of_hours) ? 0 : no_of_hours,
					purpose: req.body.purpose,
					type: type,
					primary_status: 1,
					backup_status: 1,
					attachment: filename,
					primary_approver: primary_approver,
					backup_approver : backup_approver,
					night_diff: NightDiffHelper.init(start, end),
					_token: uuidv4()
				}

				OvertimesModel.count({
					where: {
						user_id: user.id,
						start_date: start_date,
						end_date: end_date,
						//primary_status : {$ne: 4},
						primary_status : {$lte: 2},
						$or: [{
							start_time: {
								$between: [overlap_start_time, overlap_end_time]
							}
						}, {
							end_time: {
								$between: [overlap_start_time, overlap_end_time]
							}
						}]
					}
				}).then(function(data){
					if(data == 0){
						OvertimesModel.create(inputData).then(function(data){
							let insertId = data.id
							let notificationMessage = {
								sender: user.id,
								content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> sent overtime application that requires your approval.',
								url: 'approvals/overtime'
							}
							let receiver = [primary_approver];
							Notification.notify(notificationMessage, receiver, 'overtime', 'create');
							//Send Mail
							//PrepareMail.overtime(insertId, res.locals.baseUrl);

							res.status(200).json({
								success: true,
								action: 'fetch',
								msg: 'New record has been successfully saved.'
							});
						});
					}else{
						var error = [
							{	
								param: 'start_date',
								msg: 'Date and time has already been taken.'
							}
						]
						res.status(422).json({
							success: false,
							errors: error
						});
					}
				});
			});		
		}
	});
}

exports.edit = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;

	OvertimesModel.findOne({
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
	let user = res.locals.user;
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		// req.checkBody('no_of_hours').notEmpty().withMessage('The number of hours field is required.');
		// req.checkBody('type').notEmpty().withMessage('The overtime type field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let id = req.body.id;
			let start_date = res.locals.moment(req.body.start_date).format('YYYY-MM-DD');
			let end_date   = res.locals.moment(req.body.end_date).format('YYYY-MM-DD');
			let start_time = res.locals.moment(req.body.start_date).format('HH:mm:ss');
			let end_time   = res.locals.moment(req.body.end_date).format('HH:mm:ss');
			OvertimesModel.count({
				where: {
					id: {
						$not: id
					},
					user_id: user.id,
					start_date: start_date,
					end_date: end_date,
					primary_status : {$lte: 2},
					//primary_status : {$ne: 4},
					$or: [{
						start_time: {
							$between: [start_time, end_time]
						}
					}, {
						end_time: {
							$between: [start_time, end_time]
						}
					}]
				}
			}).then(function(data){
				if(data == 0){
					let start = res.locals.moment(start_date +' '+ start_time);
					let end = res.locals.moment(end_date +' '+ end_time);
					let no_of_hours = end.diff(start, 'hours');
					let OTHrs01Mins = parseInt(moment(end).diff(moment(start), 'minutes')) - no_of_hours * 60;
						no_of_hours = no_of_hours+'.'+OTHrs01Mins;

					let attachment = files.attachment;
					let filename = null;

					if(attachment && attachment.size > 0){
						var oldFile = uploadPath + record.attachment;
						//Delete File if exists
						try {
							if (fs.existsSync(oldFile)) {
								fs.unlinkSync(oldFile);
							}
						} catch(err) {
							console.log('Cant find.')
						}
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

					let inputData = {
						start_date: start_date,
						end_date: end_date,
						start_time: start_time,
						end_time: end_time,
						no_of_hours: isNaN(no_of_hours) ? 0 : no_of_hours,
						night_diff: NightDiffHelper.init(start, end),
						purpose: req.body.purpose
					}

					if(filename){
						inputData.attachment = filename
					}

					OvertimesModel.update(inputData, {
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
				}else{
					var error = [
						{	
							param: 'start_date',
							msg: 'Date and time has already been taken.'
						}
					]
					res.status(422).json({
						success: false,
						errors: error
					});
				}
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

	OvertimesModel.update(data, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}
