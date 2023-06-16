const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const PrepareMail = require('../Helper/PrepareMail');
const Notification = require('../Helper/Notification');
const UserRole = require('../Helper/UserRole');
const DateHelper = require('../Helper/DateHelper');
const CustomLeaveHelper = require('../Helper/CustomLeaveHelper');

const {
	UsersModel,
	LeavesModel,
	CompanyModel, 
	TaxonomyModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	ApproversModel,
	CustomApproverModel,
	LeaveDateModel,
	sequelize
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'custom-leave').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/403');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				return UsersModel.findAll({
					where: {
						status: 1
					},
					order: [
						['first_name','asc']
					],
					attributes: ['id','first_name', 'last_name']
				});
			}).then(function(data){
				users = data;
				res.render('CustomLeave/index',{
					user_role: user_role,
					usrRole: usrRole,
					users: users,
					route: 'custom-leave'
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
		is_hr: {
			$not: null
		}
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
					model: UsersModel, 
					as: 'applicant',
					attributes: ['id', 'first_name', 'last_name']
				},
	    		{
					model: LeavePolicyModel,
					attributes: ['name']
				},
				{
					model: LeaveDateModel
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

exports.init_form = function(req, res){
	let user = res.locals.user;
	let userID = req.body.id ? req.body.id : user.id;

	UsersModel.findByPk(userID).then(function(data){
		let user = data;
		let gender = '';
		if(user && typeof user.gender != 'undefined'){
			gender = user.gender;
		}
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
			return ApproversModel.findOne({
				where: {
					company_location_id: user.company_branch_id,
					department_id: user.department_id
				},
				attributes: ['id','backup_approver_id','primary_approver_id'],
				include: [
					{
						model: UsersModel, as: 'primary',
						attributes: ['id', 'first_name', 'last_name'] 
					},{
						model: UsersModel, as: 'backup',
						attributes: ['id', 'first_name', 'last_name'] 
					}
				]
			});
			// console.log(policy);
			
		}).then(function(data){
			approver = data;
			approver   = JSON.parse(JSON.stringify(approver));
			return CustomApproverModel.findOne({
				where: {
					user_id: userID
				},
				include: [
					{
						model: UsersModel, as: 'primary',
						attributes: ['id', 'first_name', 'last_name'] 
					},{
						model: UsersModel, as: 'backup',
						attributes: ['id', 'first_name', 'last_name'] 
					}
				]
			});

			
		}).then(function(data){
			custom = data;
			custom   = JSON.parse(JSON.stringify(custom));
			res.status(200).json({
				success: true,
				policy: policy,
				approver: custom ? custom : approver
			});
		});
	});
		
}

exports.store = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;

		req.checkBody('leave_type').notEmpty().withMessage('The leave policy field is required.');
		req.checkBody('dates').notEmpty().withMessage('The date field is required.');
		req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let userID = req.body.employee;
			UsersModel.findByPk(userID).then(function(data){
				user = data;
				branch_id = user.company_branch_id;
				department_id = user.department_id;
				return ApproversModel.findOne({
					where: {
						company_location_id: branch_id,
						department_id: department_id
					}
				});
			}).then(function(data){
				approvers = data ? data : null;
				if(approvers){
				approvers = JSON.parse(JSON.stringify(approvers));
				}
				
				return CustomApproverModel.findOne({
					where: {
						user_id: userID
					}
				});
			}).then(function(data){
				custom = data;
				if(custom){
				custom = JSON.parse(JSON.stringify(custom));
				}
				approvers = custom ? custom : approvers;

				if(approvers && approvers.primary_approver_id && approvers.backup_approver_id){
					let primary_approver = approvers.primary_approver_id;
					let backup_approver  = approvers.backup_approver_id;
					let leave_type 	= req.body.leave_type;
					let other       = req.body.other;
					let credit 	   	= req.body.credit;
					let reason 		= req.body.reason;
					let date 		= req.body.dates;
						date        = date.split(',');
						date = date.sort(function(a,b){
						  return new Date(b) - new Date(a);
						});// Sort Date
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

					let no_of_days = date.length;
					let end_date = date[0];
					let start_date = date.pop();
					let data = {
						user_id: user.id,
						start_date: res.locals.moment(new Date(start_date)).format('YYYY-MM-DD'),
						end_date: res.locals.moment(new Date(end_date)).format('YYYY-MM-DD'),
						leave_type: req.body.leave_type,
						other: leave_type == 5 ? other : '',
						no_of_days: no_of_days,
						credit: req.body.credit,
						reason: req.body.reason,
						attachment: filename,
						primary_status: 2,
						backup_status: 2,
						is_hr: 1,
						primary_approver: primary_approver,
						backup_approver: backup_approver,
						_token: uuidv4()
					}
					LeavesModel.create(data).then(function(data){
						let insertId = data.id;
						let dates = req.body.dates.split(',');
						for(let x in dates){
							let dateData = {
								leave_id: insertId,
								user_id: user.id,
								date: res.locals.moment(new Date(dates[x])).format('YYYY-MM-DD'),
								number_of_day: 1
							}
							LeaveDateModel.create(dateData);
						}
						// //Send Mail
						//PrepareMail.leave(insertId, res.locals.baseUrl, 'custom');
						CustomLeaveHelper._set(insertId);
						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'New record has been successfully saved.'
						});
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
			});
		}
		
	});

}

exports.migrate = function(req, res){
	let start_date = req.params.start_date;
	let end_date = req.params.end_date;
	CustomLeaveHelper.migrate(start_date, end_date);
}


