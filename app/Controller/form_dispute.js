const Notification = require('../Helper/Notification');
const PrepareMail = require('../Helper/PrepareMail');
const uuidv4 = require('uuid/v4');
const UserRole = require('../Helper/UserRole');
const formidable = require('formidable');
const fs = require('fs');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const {
	UsersModel,
	DisputeModel,
	ApproversModel,
	CustomApproverModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'forms-dispute').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Form/Dispute/index',{
					route: 'form-dispute',
					usrRole: usrRole,
					user_role: user_role
				});
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
		where.date = {
	        $between: [start, end]
	    }
	}
	DisputeModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return DisputeModel.findAll({
			where: where,
			include: [
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
	let form = new formidable.IncomingForm();
	let uploadPath = './assets/uploads/attachments/';
	let user = res.locals.user;
	let user_id = user.id;
	let branch_id = user.company_branch_id;
	let department_id = user.department_id;

	
	form.parse(req, function (err, fields, files) {
		console.log("files: ", files)
		let attachment 	= files.document;
		let size = attachment ? attachment.size : 0;
		req.body = fields;
		req.body.document = size > 0 ? size : '';

		req.checkBody('type').notEmpty().withMessage('The type field is required.');
		req.checkBody('date').notEmpty().withMessage('The date field is required.');
		req.checkBody('note').notEmpty().withMessage('The note field is required.');
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		if(req.body.type != 4){
			req.checkBody('hours').notEmpty().withMessage('The number hour field is required.');
		}
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let hours = req.body.hours;
			if(req.body.type == 1 || req.body.type == 2){
				hours = hours;
			}else if(req.body.type == 3){
				hours = parseInt(hours) * 8;
			}else if(req.body.type == 4){
				hours = 4;
			}
			let primary_approver = req.body.approver_id;
			let backup_approver = req.body.approver_secondary_id;
			let date = res.locals.moment(new Date(req.body.date)).format('YYYY-MM-DD');
			let hashName = null;
			if(attachment && attachment.size > 0){
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop();
				hashName = uuidv4(origFileName).substring(0,8) + '.'+ ext;
				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + hashName, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){
	  						
						});
					});
				});
			}

			let inputData = {
				user_id: user.id,
				date: date,
				hour: hours,
				type: req.body.type,
				note: req.body.note,
				primary_status: 1,
				backup_status: 1,
				primary_approver: primary_approver,
				backup_approver: backup_approver,
				_token: uuidv4(),
				document: hashName
			}

			DisputeModel.create(inputData).then(function(data){
				let insertId = data.id
				// let notificationMessage = {
				// 	sender: user.id,
				// 	content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> sent dispute application that requires your approval.',
				// 	url: 'approvals/dispute'
				// }
				// let receiver = [primary_approver, backup_approver];
				// Notification.notify(notificationMessage, receiver, 'dispute', 'create');
				// //Send Mail
				// PrepareMail.dispute(insertId, res.locals.baseUrl);

				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'New record has been successfully saved.'
				});
			});
		}
	});
}

exports.update = function(req, res){
	let form = new formidable.IncomingForm();
	let uploadPath = './assets/uploads/attachments/';

	let user = res.locals.user;
	form.parse(req, function (err, fields, files) {
		console.log("files: ", files)
		let attachment 	= files.document;
		let size = attachment ? attachment.size : 0;
		req.body = fields;
		req.body.document = size > 0 ? size : '';

		req.checkBody('type').notEmpty().withMessage('The type field is required.');
		req.checkBody('date').notEmpty().withMessage('The date field is required.');
		req.checkBody('note').notEmpty().withMessage('The note field is required.');
		if(req.body.type != 4){
			let typeMessage = req.body.type == 3 ? 'The number day field is required.':'The number hour field is required.';
			req.checkBody('hours').notEmpty().withMessage(typeMessage);
		}
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let id = req.body.id;
			let date = res.locals.moment(new Date(req.body.date)).format('YYYY-MM-DD');
			let hours = req.body.hours;
			if(req.body.type == 1 || req.body.type == 2){
				hours = hours;
			}else if(req.body.type == 3){
				hours = parseInt(hours) * 8;
			}else if(req.body.type == 4){
				hours = 4;
			}
			let hashName = '';
			if(attachment && attachment.size > 0){
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop();
				hashName = uuidv4(origFileName).substring(0,8) + '.'+ ext;
				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + hashName, data, function(err){
						//if (err) console.log(err);
						fs.unlink(path, function(err){
	  						
						});
					});
				});
			}

			let inputData = {
				user_id: user.id,
				date: date,
				hour: hours,
				type: req.body.type,
				note: req.body.note,
			}
			if(hashName){
				inputData.document = hashName;
			}
			DisputeModel.update(inputData, {
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

	DisputeModel.update(data, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}