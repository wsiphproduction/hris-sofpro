const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const PrepareMail = require('../Helper/PrepareMail');
const Notification = require('../Helper/Notification');
const UserRole = require('../Helper/UserRole');
const DateHelper = require('../Helper/DateHelper');
const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	UsersModel,
	LeavesModel,
	ApproversModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	LeaveDateModel,
	CustomApproverModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'forms-leave').then(function(data){
		user_role = data;
		// console.log(user_role);
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Form/Leave/index', {
					route: 'form-leave',
					usrRole: usrRole,
					user_role: user_role
				});
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
		where.start_date = {
	        $between: [start, end]
	    }
	}
	LeavesModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return LeaveDateModel.findAll({
			where: {
				user_id: user.id
			},
			attributes: ['date']
		});
		
	}).then(function(data){
		disableDates = data;
		return LeavesModel.findAll({
			where: where,
			order: [
				['created_at', 'DESC']
			],
			offset: offset,
	    	limit: limit,
	    	include: [
	    		{
					model: LeavePolicyModel,
					attributes: ['name']
				},
				{
					model: LeaveDateModel
				},
				{
					model: UsersModel,
					as: 'primary'
				},
				{
					model: UsersModel,
					as: 'backup'
				}
	    	]
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
			disableDates: disableDates
        });
	});
}
exports.store = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/attachments/';
	
	let form = new formidable.IncomingForm();

	let branch_id = user.company_branch_id;
	let department_id = user.department_id;
	
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let hasErrors = req.body.has_errors;
		let leave_objects = req.body.leave_object_string_converted

		
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('leave_type').notEmpty().withMessage('The leave policy field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');

		let errors = req.validationErrors(); 
		
		if(errors || hasErrors === 'true'){
			res.status(422).json({
				success: false,
	            errors
			});

		}else{
			let primary_approver 	= req.body.approver_id;
			let backup_approver		= req.body.approver_secondary_id;
			let leave_type 			= req.body.leave_type;
			let other       		= req.body.other;
			let reason 				= req.body.reason;
			let attachment			= files.attachment;
			
			let filename 				= null;
			let leave_json 				= JSON.parse(leave_objects);
			let start_date 				= leave_json[0].date;;
			let end_date 				= leave_json[leave_json.length - 1].date;
			let no_of_days	 			= 0.0

			//COUNT NUMBER OF DAYS
			for(let i in leave_json) {
				if(leave_json[i].date_is_filed) {
					no_of_days += parseFloat(leave_json[i].leave_duration == 0 ? 1 : 0.5);
				}
			}
			
			//FILE UPLOADING
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

			//DATA ASSIGNMENT
			let data = {
				user_id				: user.id,
				start_date			: res.locals.moment(new Date(start_date)).format('YYYY-MM-DD'),
				end_date			: res.locals.moment(new Date(end_date)).format('YYYY-MM-DD'),
				leave_type			: req.body.leave_type,
				other				: leave_type == 5 ? other : '',
				no_of_days			: no_of_days,
				credit				: 1,
				leave_duration		: no_of_days,
				reason				: reason,
				attachment			: filename,
				primary_status		: 1,
				backup_status		: 1,
				primary_approver	: primary_approver,
				backup_approver		: backup_approver,
				_token				: uuidv4()
			}
			
			LeavesModel.create(data).then(function(data){
				let insertId = data.id;
				for(let i in leave_json) {

					let numdays = leave_json[i].leave_duration == 0 ? 1 : 0.5;
					let dateData = {
						leave_id: insertId,
						user_id: user.id,
						date: res.locals.moment(new Date(leave_json[i].date)).format('YYYY-MM-DD'),
						number_of_day	: (leave_json[i].date_is_filed) ? numdays : 0,
						leave_duration	: (leave_json[i].date_is_filed) ? leave_json[i].leave_duration : 0,
						credit			: (leave_json[i].date_is_filed) ? leave_json[i].leave_credit : null,
						date_is_filed	: (leave_json[i].date_is_filed) ? 1 : 0,
					}
					LeaveDateModel.create(dateData);
				}
				let notificationMessage = {
					sender: user.id,
					content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> sent leave application that requires your approval.',
					url: 'approvals/leave'
				}
				
				let receiver = [primary_approver];

				Notification.notify(notificationMessage, receiver, 'leave', 'create');
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'New record has been successfully saved.'
				});
			});
		}
	});
}

exports.init_form = function(req, res){
	let user = res.locals.user;
	let gender = user.gender;
	let company_id = user.company_branch_id ? user.company_branch_id : '';
	let department = user.department_id ? user.department_id : '';
	LeavePolicyModel.findAll({
		where: {
			status: 1,
			gender: {
				$or: [null, '', gender]
			},
			company: {
				$or: [null, '', company_id]
			},
			department: {
				$or: [null, '', department]
			}
		},
		attributes: ['id','name','gender'],
		include: [
			{
				model: LeaveCreditPolicyModel,
				where: {
					user_id: user.id
				},
				required: false,
				attributes: ['id','balance', 'utilized']
			}
		],
		order: [
			['name', 'ASC']
		]
	}).then(function(data){
		policy = data;
		// console.log(policy);
		res.status(200).json({
			success: true,
			policy: policy,
		});
	});
}

exports.edit = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;

	LeavesModel.findOne({
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
			},
			{
				model: LeavePolicyModel,
				attributes: ['name']
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

exports.archive = function(req, res){
	let id = req.body.id;
	let data = {
		primary_status: 4,
		backup_status: 4,
	}
	LeavesModel.destroy({
		where: {
			id: id
		}
	});
	LeaveDateModel.destroy({
		where: {
			leave_id: id
		}
	});
	res.status(200).json({
		success: true
	});
	// LeavesModel.update(data, {
	// 	where: {
	// 		id: id
	// 	}
	// }).then(function(data){
		
	// });
}

exports.update = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/attachments/';
	
	let form = new formidable.IncomingForm();

	form.parse(req, function (err, fields, files) {
		req.body = fields;

		req.checkBody('leave_type').notEmpty().withMessage('The leave policy field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('leave_object_string_converted').notEmpty().withMessage('The leave credit and leave duration field is required.');

		// if(req.body.leave_type == 5){
		// 	req.checkBody('other').notEmpty().withMessage('The other field is required.');
		// }
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let id 					= req.body.id;
			let primary_approver 	= req.body.approver_id;
			let secondary_approver 	= req.body.approver_secondary_id;
			let leave_object		= JSON.parse(req.body.leave_object_string_converted);	

			LeavesModel.findOne({
				where: {
					id: id,
					user_id: user.id
				}
			}).then(function(response){
				if(!response) res.status(404).json({
					success: false,
					msg: 'No record found for the given selection.'
				});

				//GET THE INFORMATION OF THE LEAVE
				record = response;

				//ARRANGE DATES IN LEAVE_OBJECT
				leave_object.sort((a,b)=>{
					return new Date(a.date) - new Date(b.date);
				});

				//NUMBER OF DAYS & GETING THE DATES 
				let date=leave_object.map(item=>item.date);
				let no_of_days = 0;
				for(item in leave_object){
					if(leave_object[item].date_is_filed)
					{
						no_of_days += parseFloat((leave_object[item].leave_duration>0)?.5:1);
					}
				}

				let start_date = date[0];
				let end_date = date.pop();	

				//FILE UPLOADING
				let attachment 		= files.attachment;
				let filename 		= null;
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

				let data = {
					start_date		: res.locals.moment(new Date(start_date)).format('YYYY-MM-DD'),
					end_date		: res.locals.moment(new Date(end_date)).format('YYYY-MM-DD'),
					leave_type		: req.body.leave_type,
					no_of_days		: no_of_days,
					credit			: 1,
					reason			: req.body.reason,
					leave_duration	: no_of_days,
					primary_approver: primary_approver,
					backup_approver	: secondary_approver,

					
					// other			: req.body.leave_type == 5 ? req.body.other : '',
				}
				if(filename){
					data.attachment = filename
				}

				//UPDATING VALUES
				LeavesModel.update(data, {
					where: {
						id: id
					}
				}).then(function(data){
					//DELETE FORMER LEAVE DATES THEN CREATE NEW LEAVE DATES
					LeaveDateModel.destroy({
						where: {
							leave_id: id
						}
					}).then(function(data){
						for(let x in leave_object){
							let numdays = (leave_object[x].leave_duration == 0) ? 1 : 0.5;
							let dateData = {
								leave_id		: id,
								user_id			: user.id,
								date			: res.locals.moment(new Date(leave_object[x].date)).format('YYYY-MM-DD'),
								number_of_day	: (leave_object[x].date_is_filed) ? numdays : 0,
								leave_duration	: (leave_object[x].date_is_filed) ? leave_object[x].leave_duration : 0,
								credit			: (leave_object[x].date_is_filed) ? leave_object[x].leave_credit : null,
								date_is_filed	: (leave_object[x].date_is_filed) ? 1 : 0,
							}
							LeaveDateModel.create(dateData);
						}
					});
					

					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been successfully updated.'
					});

				});
			});
		}
	});
}

exports.get_vl_id = function(req,res){
	res.status(200).json({
		vl: {
			id			: $env.parsed.VL_ID,
			date_advance: $env.parsed.VL_DATE_ADVANCE,
		},
	});
}