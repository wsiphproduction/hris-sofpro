const Notification = require('../Helper/Notification');
const PrepareMail = require('../Helper/PrepareMail');
const uuidv4 = require('uuid/v4');
const uuidv5 = require('uuid/v5');
const fs = require('fs');
const formidable = require('formidable');
const UserRole = require('../Helper/UserRole');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	UsersModel,
	BusinessTripsModel,
	ApproversModel,
	CustomApproverModel,
	BusinessTripDate
} = require('../../config/Sequelize');

exports.index = function(req,res){
	let user = res.locals.user;
	UserRole.get_role(user, 'forms-business-trip').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Form/BusinessTrip/index',{
					route: 'form-business',
					usrRole: usrRole,
					user_role: user_role
				});
			});
		}
	});
}

exports.fetch = function(req,res){
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
		where.date_start = {
	        $between: [start, end]
	    }
	}
	BusinessTripsModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return BusinessTripsModel.findAll({
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

exports.store = function(req,res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
		let user = res.locals.user;
		let user_id = user.id;	
		req.checkBody('note').notEmpty().withMessage('The note field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{

			let startDate = res.locals.moment(new Date(req.body.start_date)).format('YYYY-MM-DD');
			let endDate   = res.locals.moment(new Date(req.body.end_date)).format('YYYY-MM-DD');
			let primary_approver = req.body.approver_id;
			let backup_approver = req.body.approver_secondary_id;

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

			let reqData = {
				user_id: user.id,
				date_start: startDate,
				date_end: endDate,
				note: req.body.note,
				primary_status: 1,
				backup_status: 1,
				primary_approver: primary_approver,
				backup_approver: backup_approver,
				_token: uuidv4()
			}

            if(attachment && attachment.size > 0){                
                reqData.attachment = filename
            }
			
			BusinessTripsModel.create(reqData).then(function(data){
				let insertId = data.id;
				let dates = [];
				let currDate = moment(new Date(startDate)).startOf("day");
				let lastDate = moment(new Date(endDate)).startOf("day");
				do {
				dates.push(currDate.clone().toDate());
				} while (currDate.add(1, "days").diff(lastDate) < 0);
				dates.push(currDate.clone().toDate());
				for(let i in dates){
					let date = moment(dates[i]).format('YYYY-MM-DD');
					let BData =  {
						bid: insertId,
						date: date,
						user_id: user.id
					}
					BusinessTripDate.create(BData);
				}
				//Notification
				// let notificationMessage = {
				// 	sender: user.id,
				// 	content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> sent business trip application that requires your approval.',
				// 	url: 'approvals/business-trip'
				// }
				// let receiver = [primary_approver, backup_approver];
				// Notification.notify(notificationMessage, receiver, 'business_trip', 'create');

				// PrepareMail.business_trip(insertId, res.locals.baseUrl);					

				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'New record has been successfully saved.'
				});
			});
		}
	});
}

exports.archive = function(req,res){
	let id = req.body.id;
	let data = {
		primary_status: 4,
		backup_status: 4,
	}
	BusinessTripsModel.update(data, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}

exports.edit = function(req,res){
	let user = res.locals.user;
	let id = req.body.id;

	BusinessTripsModel.findOne({
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

exports.update = function(req,res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
		let id = req.body.id;
		
		req.checkBody('note').notEmpty().withMessage('The note field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');

		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let startDate = res.locals.moment(new Date(req.body.start_date)).format('YYYY-MM-DD');
			let endDate   = res.locals.moment(new Date(req.body.end_date)).format('YYYY-MM-DD');

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

			let reqBody = {
				date_start: startDate,
				date_end: endDate,
				note: req.body.note,
			}

            if(attachment && attachment.size > 0){                
                reqBody.attachment = filename
            }

			BusinessTripDate.destroy({
				where:{
					bid: id
				}
			});
			BusinessTripsModel.update(reqBody, {
				where: {
					id: id
				}
			}).then(function(data){
				let dates = [];
				let currDate = moment(new Date(startDate)).startOf("day");
				let lastDate = moment(new Date(endDate)).startOf("day");
				do {
				dates.push(currDate.clone().toDate());
				} while (currDate.add(1, "days").diff(lastDate) < 0);
				dates.push(currDate.clone().toDate());
				for(let i in dates){
					let date = moment(dates[i]).format('YYYY-MM-DD');
					let BData =  {
						bid: id,
						date: date,
						user_id: inputData.user_id
					}
					BusinessTripDate.create(BData);
				}
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Record has been successfully updated.'
				});
			});
		}
	});
}
