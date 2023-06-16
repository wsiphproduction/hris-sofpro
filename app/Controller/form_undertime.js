const Notification = require('../Helper/Notification');
const PrepareMail = require('../Helper/PrepareMail');
const uuidv4 = require('uuid/v4');
const fs = require('fs');
const formidable = require('formidable');
const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	UndertimeModel,
	ApproversModel,
	CustomApproverModel
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'forms-undertime').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Form/Undertime/index',{
					route: 'form-undertime',
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
	UndertimeModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return UndertimeModel.findAll({
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
		req.checkBody('date').notEmpty().withMessage('The start date field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let primary_approver = req.body.approver_id;
			let backup_approver = req.body.approver_secondary_id;
			let undertime = req.body.undertime;
			let date = res.locals.moment(req.body.date).format('YYYY-MM-DD');
			let time = res.locals.moment(req.body.date).format('HH:mm:ss');
			
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

			let inputData = {
				user_id: user.id,
				date: date,
				time: time,
				reason: req.body.reason,
				primary_status: 1,
				backup_status: 1,
				primary_approver: primary_approver,
				backup_approver: backup_approver,
				_token: uuidv4()
			}

			if(attachment && attachment.size > 0){                
				inputData.attachment = filename
			}

			UndertimeModel.count({
				where: {
					user_id: user.id,
					date: date
				}
			}).then(function(data){
				if(data == 0){
					UndertimeModel.create(inputData).then(function(data){
						let insertId = data.id
						let notificationMessage = {
							sender: user.id,
							content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> sent undertime application that requires your approval.',
							url: 'approvals/undertime'
						}
						let receiver = [primary_approver];
						Notification.notify(notificationMessage, receiver, 'undertime', 'create');
						//Send Mail
						//PrepareMail.undertime(insertId, res.locals.baseUrl);

						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'New record has been successfully saved.'
						});
					});
				}else{
					var error = [
						{	
							param: 'date',
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

exports.edit = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;

	UndertimeModel.findOne({
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
		let user = res.locals.user;
		req.checkBody('date').notEmpty().withMessage('The start date field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let id = req.body.id;
			let date = res.locals.moment(req.body.date).format('YYYY-MM-DD');
			let time = res.locals.moment(req.body.date).format('HH:mm:ss');

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

			UndertimeModel.count({
				where: {
					id: {
						$not: id
					},
					user_id: user.id,
					date: date
				}
			}).then(function(data){
				if(data == 0){
					let inputData = {
						date: date,
						time: time,
						reason: req.body.reason
					}

					if(attachment && attachment.size > 0){                
						inputData.attachment = filename
					}
					UndertimeModel.update(inputData, {
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
							param: 'date',
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

	UndertimeModel.update(data, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}
