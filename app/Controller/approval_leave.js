const Notification = require('../Helper/Notification');
const MailHelper = require('../Helper/MailHelper');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser');
const fs = require('fs');
const _ = require('underscore');
const UserRole = require('../Helper/UserRole');
const GlobalHelper = require('../Helper/GlobalHelper');
const TSSHelper = require('../Helper/TSSHelper');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const {
	Op,
	UsersModel,
	LeavesModel,
	ApproversModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	LeaveDateModel,
	TSSData,
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-leave').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/Leave/index',{
					route: 'app-leave',
					usrRole: usrRole,
					user_role: user_role,
					cutoff: await GlobalHelper.cutoff()
				});
			});
		}
	});
}

exports.init = function(req, res){
	let user = res.locals.user;
	let where = {
		$or: [
			{
				approver_id: user.id
			},
			{
				secondary_approver_id: user.id
			},
			{
				secretary_id: user.id
			}
		]
	}
	UsersModel.findAll({
		where: where,
		order: [
			['last_name','asc']
		],
		attributes: ['id','first_name','last_name'],
		raw: true
	}).then(data=>{
		users = data;
		//console.log(users);
		res.status(200).json({
            success: true,
            users: users
        });
	})
}
exports.fetch = async(req, res)=>{
//exports.fetch = function(req, res){
	let user 			= res.locals.user;
	let isHRGeneralist 	= res.locals.isHRGeneralist;
	let isManager 		= res.locals.isManager;
	let employee		= req.body.employee;
	let start 			= req.body.start;
	let end 			= req.body.end;
	let status 			= req.body.status;
	let limit   		= parseInt(req.body.limit);
	let page 			= req.body.page;
	let offset  		= (parseInt(page) - 1) * parseInt(limit);
	let key 			= req.body.key;
    let session 		= req.session;
	

	
	let where = {}
	if (!isHRGeneralist) {
		where = {
			$or: [
				{
					primary_approver: user.id
				},
				{
					backup_approver: user.id
				}
			]
		}
	}
	// if(employee){
	// 	where.user_id = employee;
	// }
	if(status){
		where.primary_status = status;
	}
	if((start && end) && (start <= end)){
		where.start_date = {
	        $between: [start, end]
	    }
	}
	
	if(key || isHRGeneralist) {
		let whereUser = {}
		if(key) {
			whereUser[Op.or] = {
				first_name : {
					[Op.like] : '%'+ key +'%'
				},
				last_name : {
					[Op.like] : '%'+ key +'%'
				},
				middle_name : {
					[Op.like] : '%'+ key +'%'
				},
				email : {
					[Op.like] : '%'+ key +'%'
				},
				username : {
					[Op.like] : '%'+ key +'%'
				},
				employee_number : {
					[Op.like] : '%'+ key +'%'
				},
			}
		}
		
		if(isHRGeneralist) {
			if(key) {
				whereUser[Op.and] = {
					hr_generalist_id: user.id,
					[Op.or]: [
						{
							first_name : {
								[Op.like] : '%'+ key +'%'
							}
						},
						{
							last_name : {
								[Op.like] : '%'+ key +'%'
							},
						},
						{
							middle_name : {
								[Op.like] : '%'+ key +'%'
							},
						},
						{
							email : {
								[Op.like] : '%'+ key +'%'
							},
						},
						{
							username : {
								[Op.like] : '%'+ key +'%'
							},
						},
						{
							employee_number : {
								[Op.like] : '%'+ key +'%'
							},
						}
					]
				}
			} else {
				whereUser = {
					hr_generalist_id: user.id
				}
			}
		}
		
		let employee_not_existing_list = await getEmployeeID(whereUser);
		where.user_id = {
				[Op.in]: employee_not_existing_list
		}
	}
	
	ConfigModel.findOne({
        where: {
            id: 1
        }
    }).then(function (data) {
        config = data;
        json = config.json ? JSON.parse(config.json) : null;

		LeavesModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return LeavesModel.findAll({
				where: where,
				order: [
					['created_at', 'DESC']
				],
				include: [
					{
						model: UsersModel,
						as: 'primary',
						attributes: ['id', 'first_name', 'last_name']
					},
					{
						model: UsersModel,
						as: 'backup',
						attributes: ['id', 'first_name', 'last_name']
					},
					{
						model: UsersModel, 
						as: 'applicant',
						attributes: ['id', 'first_name', 'last_name','employee_number']
					},
					{
						model: LeavePolicyModel,
						attributes: ['name']
					},
					{
						model: LeaveDateModel,
						as: 'leaves_dates'
					},
					{
						model: LeaveCreditPolicyModel,
						required: false,
						where: {
							user_id: { $col: 'leaves.user_id' }
						},
						attributes: ['balance', 'utilized']
					}
				],
				offset: offset,
				limit: limit,
			});
		}).then(function(data){
			records = data;
			//records.appId = user.id;
			if(limit < numrows){
				count = numrows / limit;
				count = Math.ceil(count);
			}else{
				count = 0;
			}
			res.status(200).json({
				success: true,
				records: records,
				isHRGeneralist: isHRGeneralist,
				isManager: isManager,
				count: count,
				appId: user.id,
				config: config,
				session: session
			});
		});
	});
}

const getEmployeeID =  async (queryFilter)=>{
	let results = [];
	
	await UsersModel.findAll({
		where: queryFilter,
		raw: false,
	}).then(data=>{
		users = data;
		if(users && users.length){
			results = _.pluck(users, 'id');
			results = [...new Set(results)];
		}		
	});
	
	return results
}

exports.export = function(req, res){
	let user = res.locals.user;
	let employee= req.body.employee;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	let where = {
		$or: [
			{
				primary_approver: user.id
			},
			{
				backup_approver: user.id
			}
		]
	}
	if(employee){
		where.user_id = employee;
	}
	if(status){
		where.primary_status = status;
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
		return LeavesModel.findAndCountAll({
			where: where,
			order: [
				['created_at', 'DESC']
			],
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name']
				},
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
					model: LeaveCreditPolicyModel,
					required: false,
					where: {
						user_id: { $col: 'leaves.user_id' }
					},
					attributes: ['balance', 'utilized']
				}
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		leaves = data;
		numrows = leaves.count;
		count = 0;
		if(limit < numrows){
			count = numrows / limit;
			count = Math.ceil(count);
		}else{
			count = 0;
		}
		let record = leaves.rows;
		let fields = ['Date Filed','Employee','Date','No. of Days','Leave Type','Credit','Purpose','Status'];
		let arrayData = [];
		if(record){
			for(let i in record){
				let status = '';
				if(record[i].primary_status == 1){
					status = 'Pending';
				}else if(record[i].primary_status == 2){
					status = 'Approved';
				}else if(record[i].primary_status == 3){
					status = 'Declined';
				}else if(record[i].primary_status == 4){
					status = 'Closed';
				}
				arrayData.push({
					'Date Filed': moment(record[i].created_at).format('YYYY-MM-DD HH:mm:ss'),
					'Employee': record[i].applicant.last_name +', '+ record[i].applicant.first_name,
					'Date': moment(record[i].start_date).format('MM/DD/YYYY') +' — '+ moment(record[i].end_date).format('MM/DD/YYYY'),
					'No. of Days': record[i].no_of_days +' day(s)',
					'Leave Type': record[i].leave_policy ? record[i].leave_policy.name : '',
					'Credit': record[i].credit==1 ?'With Pay':'Without Pay',
					'Purpose': record[i].reason,
					'Status': status,
				});
			}
		}
		let filename = 'Approval_leave_'+moment(start).format('YYYYMMDD');
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(arrayData);
		res.attachment(filename+'.csv');
		res.status(200).send(csv);
	});
}

exports.update = function(req, res){
	let user 	 = res.locals.user;
	let status 	 = req.body.status == 'approve' ? 2 : 3;
	let checkbox = req.body.checkbox; 
	if(checkbox.length){
		for(let x in checkbox){
			let id = checkbox[x];
			LeavesModel.findOne({
				where: {
					id: id
				},
				attributes: ['id','user_id','primary_approver', 'backup_approver', 'no_of_days', 'leave_type', 'credit', 'start_date', 'end_date'],
				include: [
					{
						model: LeaveCreditPolicyModel,
						required: false,
						where: {
							user_id: { $col: 'leaves.user_id' }
						},
						attributes: ['id', 'balance', 'utilized']
					},
					{
						model: UsersModel,
						as: 'applicant',
						attributes: ['email', 'first_name', 'last_name']
					},
					{
						model: LeaveDateModel,
						as: 'leaves_dates',
						where: {
							date_is_filed:1,
						}
					}
				]
			}).then(function(data){
				let result 			= data;
				let credit 		= result.leave_credit_policy;
				let leave_dates	= result.leaves_dates;
				let type 		= result.leave_type;

				if(status == 2 && credit){		// Approve and with leave credit info
					let creditID 	= credit.id;
					let creditScore = credit && credit.balance ? parseFloat(credit.balance) : 0;
						creditScore = parseFloat(creditScore);

					//CHECK leave_dates object CREDIT TYPES 1(WITH PAY),2(WITHOUT PAY),3(MIX)
					//COMPUTE NO OF DAYS THAT ARE WITH PAY TO BE DEDUCTED TO THE BALANCE
					let credit_type = parseFloat(leave_dates[0].credit);
					let no_of_days 	= 0;

					for(index in leave_dates)
					{
						if(credit_type != parseFloat(leave_dates[index].credit) && index != 0)
						{
							credit_type = 3;
						}

						if(parseFloat(leave_dates[index].credit) == 1)
						{
							no_of_days += parseFloat(leave_dates[index].number_of_day);
						}
					}
					
					//Decline if credit score is less than no_of_days or equal to zero and with pay.
					if((creditScore <= 0 || creditScore < no_of_days) && credit_type!=2){
						let reqData = {
							backup_status: 3,
							primary_status: 3,
							updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
							_token: ''
						}
						let where = {
							id: id
						}
						if(user.id == result.primary_approver || true){
							where.primary_status = 1;
						}else{
							where.backup_status = 1;
						}
						LeavesModel.update(reqData, {
							where: where
						}).then(function(data){
							let title = 'Declined';
							let notificationMessage = {
								sender: user.id,
								content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your leave application.',
								url: 'forms/leave'
							}
							let receiver = [result.user_id];
							Notification.notify(notificationMessage, receiver, null, null);

							//MAIL Notification
							let mailMessage = `<p>Your leave application has been declined.</p>`;
							let subject = 'Leave Application';
							let applicant = {
								first_name: result.applicant.first_name,
								email: result.applicant.email
							}
							// MailHelper.send_mail(applicant, mailMessage, subject);
							// Initiate TSSHelper
							let target_date_list = [result.start_date, result.end_date]
							TSSHelper.process(target_date_list, result.user_id,true);
						});
					}else{
						let reqData = {
							backup_status: 2,
							primary_status: 2,
							updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
							_token: ''
						}
						let where = {
							id: id
						}

						if(user.id == result.primary_approver || true){
							where.primary_status = 1;

							let balance 	= creditScore - no_of_days;
							let utilized 	= credit && credit.utilized ? parseFloat(credit.utilized) : 0;
								utilized 	= utilized + no_of_days;

							if (credit_type==1 || credit_type==3){		// Deduct if with pay
								let reqCredit = {
									balance: balance,
									utilized: utilized
								}
								LeaveCreditPolicyModel.update(reqCredit, {
									where: {
										id: creditID
									}
								});
							}

						}else{
							where.backup_status = 1;
						}
						LeavesModel.update(reqData, {
							where: where
						}).then(function(data){
							let title = 'Approved';
							let notificationMessage = {
								sender: user.id,
								content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your leave application.',
								url: 'forms/leave'
							}
							let receiver = [result.user_id];
							Notification.notify(notificationMessage, receiver, null, null);

							// Initiate TSSHelper
							let target_date_list = [result.start_date, result.end_date]
							TSSHelper.process(target_date_list, result.user_id);

							// let mailMessage = `<p>Your leave application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
							// let subject = 'Leave Application';
							// let applicant = {
							// 	first_name: result.applicant.first_name,
							// 	email: result.applicant.email
							// }
							// MailHelper.send_mail(applicant, mailMessage, subject);
						});
					}
				}else{ // Decline all application. No leave credit found.
					
					let reqData = {
						backup_status: 3,
						primary_status: 3,
						updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
						_token: ''
					}
					let where = {
						id: id
					}
					if(user.id == result.primary_approver || true){
						where.primary_status = 1;
					}else{
						where.backup_status = 1;
					}
					LeavesModel.update(reqData, {
						where: where
					}).then(function(data){
						let title = 'Declined';
						let notificationMessage = {
							sender: user.id,
							content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your leave application.',
							url: 'forms/leave'
						}
						let receiver = [result.user_id];
						Notification.notify(notificationMessage, receiver, null, null);

						//MAIL Notification
						let mailMessage = `<p>Your leave application has been declined.</p>`;
						let subject = 'Leave Application';
						let applicant = {
							first_name: result.applicant.first_name,
							email: result.applicant.email
						}
						MailHelper.send_mail(applicant, mailMessage, subject);
						// Initiate TSSHelper
						let target_date_list = [result.start_date, result.end_date]
						TSSHelper.process(target_date_list, result.user_id);
					});
				}
			});
		}
	}

	res.status(200).json({
		success: true,
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	LeavesModel.destroy({
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}

exports.cancel = function(req, res){
	let id = req.body.id;

	LeavesModel.findOne({
		where: {
			id: id
		},
		order: [
			['created_at', 'DESC']
		],
		include: [
			{
				model: LeavePolicyModel,
				attributes: ['id','code','name']
			},
			{
				model: UsersModel, 
				as: 'applicant',
				attributes: ['id', 'first_name', 'last_name']
			},
			{
				model: LeaveCreditPolicyModel,
				required: false,
				where: {
					user_id: { $col: 'leaves.user_id' }
				},
				attributes: ['id', 'balance', 'utilized']
			}
		],
		attributes: ['id', 'user_id', 'start_date', 'end_date', 'leave_type', 'credit', 'primary_status', 'no_of_days']
	}).then(function(data){
		leaves_data = data
		let where = {}
		
		where.leave_id = leaves_data.id
		where.date = {
			$between: [leaves_data.start_date, leaves_data.end_date]
		}

		return LeaveDateModel.findAll({
			where: where
		});
	}).then(async(data)=>{
		leaveDates = data;
		let leave_policy_code = leaves_data.leave_policy.code;
		let isApproved = leaves_data && leaves_data.primary_status == 2 ? true : false;
		let isPaid = leaves_data && leaves_data.credit == 1 && isApproved ? 'paid':'unpaid';
		let leaveDatesIDs = []

		if(leaveDates) {
			if(leaveDates && leaveDates.length){
				leaveDatesIDs = _.pluck(leaveDates, 'id');
				leaveDatesIDs = [...new Set(leaveDatesIDs)];
			}	
			for (let i in leaveDates) {
				let number_of_days = leaveDates[i].number_of_day == 1 ? 8 : 4;
				let queryFilter = {}
				queryFilter.user_id = leaveDates[i].user_id
				queryFilter.date = leaveDates[i].date
				
				await TSSData.findOne({
					where: queryFilter,
					raw: true,
				}).then(async(data)=>{
					tssData = data
					if(tssData) {
						let newTSSData = createNewTSSData(leave_policy_code, isPaid, number_of_days)
						
						await TSSData.update(newTSSData,{
							where:{
								id: tssData.id
							}
						}).then(async(data)=>{
							let reqCredit = {
								balance: leaves_data.leave_credit_policy.balance + leaves_data.no_of_days,
								utilized: leaves_data.leave_credit_policy.utilized - leaves_data.no_of_days
							}
							await LeaveCreditPolicyModel.update(reqCredit, {
								where: {
									id: leaves_data.leave_credit_policy.id
								}
							});
						});
					}
				});
			}

			LeaveDateModel.destroy({
				where: {
					id: {
						[Op.in]: leaveDatesIDs
					}
				}
			}).then(function(data){
				let reqData = {
					backup_status: 4,
					primary_status: 4,
				}
				LeavesModel.update(reqData, {
					where: {
						id: leaves_data.id
					}
				}).then(function(data){
					res.status(200).json({
						success: true
					});
				});
			});
		}
	});
}

const createNewTSSData = function (leave_policy_code, isPaid, number_of_days){
	let reqData = {};
	
	if(leave_policy_code == 'SL'){					// SL - Sick Leave
		if(isPaid == 'paid'){
			reqData.Leave01 = 0;
		}else{
			reqData.UnpaidSL = 0;
		}
	}else if(leave_policy_code == 'EL'){			// EL - Emergency Leave
		if(isPaid == 'paid'){
			reqData.Leave02 = 0;
		}else{
			reqData.UnpaidEL = 0;
		}
	}else if(leave_policy_code == 'VL'){			// VL - Vacation Leave
		if(isPaid == 'paid'){
			reqData.Leave03 = 0;
		}else{
			reqData.UnpaidVL = 0;
		}
	}else if(leave_policy_code == 'ML'){			// ML - Maternity Leave
		if(isPaid == 'paid'){
			reqData.Leave04 = 0;
		}
	}else if(leave_policy_code == 'PL'){			// Paternity Leave
		if(isPaid == 'paid'){
			reqData.Leave05 = 0;
		}
	}else if(leave_policy_code == 'BL'){			// Bereavement Leave
		if(isPaid == 'paid'){
			reqData.Leave10 = 0;
		}
	}else if(leave_policy_code == 'MML'){			// Miscarriage Leave
		if(isPaid == 'paid'){
			reqData.Leave11 = 0;
		}
	}else if(leave_policy_code == 'SPL'){			// Solo Parent Leave
		if(isPaid == 'paid'){
			reqData.Leave08 = 0;
		}
	}else if(leave_policy_code == 'SLWL'){			// Special Leave for Women
		if(isPaid == 'paid'){
			reqData.Leave12 = 0;
		}
	}else if(leave_policy_code == 'VAWCL'){			// VAWCI Leave
		if(isPaid == 'paid'){
			reqData.Leave13 = 0;
		}
	}else if(leave_policy_code == 'UL'){			// Union Leave
		if(isPaid == 'paid'){
			reqData.Leave11 = 0;
		}
	}

	if(reqData) {
		reqData.Absent = number_of_days
	}
	
	return reqData
}

exports.get_policy = function(req,res){
	user_id = req.body.user_id;

	UsersModel.findByPk(user_id).then(function(data){
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
			res.status(200).json({
				policies: policy,
			});			
		})
	});
}