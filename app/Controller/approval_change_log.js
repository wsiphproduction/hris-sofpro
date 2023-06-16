const Notification = require('../Helper/Notification');
const MailHelper = require('../Helper/MailHelper');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser');
const fs = require('fs');
const _ = require('underscore');
const UserRole = require('../Helper/UserRole');
const GlobalHelper = require('../Helper/GlobalHelper');
const moment     	= require('moment-timezone');
const TSSHelper = require('../Helper/TSSHelper');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	ShiftsModel,
	ApproversModel,
    ChangeLogModel,
    BiometricLog,
	ConfigModel,
	BiometricNumberModel,
	BiometricModel,
	ShiftType
} = require('../../config/Sequelize');
const { result } = require('lodash');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-change-log').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/ChangeLog/index',{
					route: 'app-change-log',
					usrRole: usrRole,
					user_role: user_role,
					cutoff: await GlobalHelper.cutoff()
				});
			});
		}
	});
}

exports.fetch = async(req, res)=>{
//exports.fetch = function(req, res){
	let user = res.locals.user;
	let isHRGeneralist = res.locals.isHRGeneralist;
	let employee 	= req.body.employee;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let key 	= req.body.key;
    let session = req.session;

	let whereUser = {}
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
	if(status){
		where.primary_status = status;
	}
	if((start && end) && (start <= end)){
		where.log_date = {
	        $between: [start, end]
	    }
	}
	if(employee){
		where.user_id = employee;
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

		ChangeLogModel.findAndCountAll({
			where: where,
			limit: limit,
			offset: offset,
			order: [
				['id','desc']
			],
			include:[
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
					as: 'applicant'
				}
			]
		}).then(data=>{
			records = data;
			numrows = records.count;
			count = 0;
			if(limit < numrows){
				count = numrows / limit;
				count = Math.ceil(count);
			}else{
				count = 0;
			}

			res.status(201).json({
				success: true,
				count: count,
				records: records.rows,
				numrows: numrows,
				appId: user.id,
				isHRGeneralist: isHRGeneralist,
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
	let employee 	= req.body.employee;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	let where = {
		primary_approver: user.id,
	}
	if(status){
		where.primary_status = status;
	}
	if((start && end) && (start <= end)){
		where.created_at = {
	        $between: [start, end]
	    }
	}
	if(employee){
		where.user_id = employee;
	}
	ChangeLogModel.findAndCountAll({
		where: where,
		limit: limit,
        offset: offset,
        order: [
        	['id','desc']
        ],
        include:[
        	{
        		model: UsersModel,
        		as: 'applicant'
        	}
        ]
	}).then(data=>{
		shifts = data;
		numrows = shifts.count;
		count = 0;
		if(limit < numrows){
			count = numrows / limit;
			count = Math.ceil(count);
		}else{
			count = 0;
		}
		let record = shifts.rows;
		let fields = ['Date Filed','Employee','Login','Logout','NewLogin','NewLogout','Status'];
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
					'Login': record[i].orig_login_time ? moment(record[i].log_date).format('YYYY-MM-DD')+' '+moment(record[i].orig_login_time).utc().format('hh:mmA') :'-',
					'Logout': record[i].orig_logout_time ? moment(record[i].log_date).format('YYYY-MM-DD')+' '+moment(record[i].orig_logout_time).utc().format('hh:mmA') :'-',
					'NewLogin': record[i].req_login_time ? moment(record[i].log_date).format('YYYY-MM-DD')+' '+moment(record[i].req_login_time).utc().format('hh:mmA') :'-',
					'NewLogout': record[i].req_logout_time ? moment(record[i].log_date).format('YYYY-MM-DD')+' '+moment(record[i].req_logout_time).utc().format('hh:mmA') :'-',
					'Status': status,
				});
			}
		}
		let filename = 'Approval_change_log_'+moment(start).format('YYYYMMDD');
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(arrayData);
		res.attachment(filename+'.csv');
		res.status(200).send(csv);
	});
}

exports.archive = function(req, res){

}

exports.update = function(req, res){
	let user 	 = res.locals.user;
	let status 	 = req.body.status == 'approve' ? 2 : 3;
	let title    = status == 2 ? 'Approved' : 'Declined';
	let checkbox = req.body.checkbox; 
    let new_login_time = null;
    let new_logout_time = null;
    let req_shift_id = null;
	if(checkbox.length){
		for(let x in checkbox){
			let id = checkbox[x];
			ChangeLogModel.findOne({
				where: {
					id: id
				},
				include: [
					{
						model: UsersModel,
						as: 'applicant',
						attributes: ['id','email', 'first_name', 'last_name','employee_number'],
					},
				],
				// attributes: ['id','user_id', 'primary_approver']
			}).then(function(data){
				let result = data;
				
                new_login_time   = result.req_login_time ? result.req_login_time : null;
                new_logout_time  = result.req_logout_time ? result.req_logout_time : null;
                orig_login_time  = result.orig_login_time ? result.orig_login_time : null;
                orig_logout_time = result.orig_logout_time ? result.orig_logout_time : null;
                req_shift_id 	 = result.shift_id;
				userId 			 = result.applicant.employee_number;
				nUserId 		 = Number(userId.replace(/\D/g,''));
                loginDate		 = result.log_date;
                logoutDate 		 = result.log_date;

				if (result.orig_login_time && result.orig_logout_time && result.orig_logout_time < result.orig_login_time){
					logoutDate = moment(logoutDate).add(1,'days').format('YYYY-MM-DD');
				}


				let reqData = {
					primary_status : status,
					backup_status  : status,
					updated_at     : moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
				}

				ChangeLogModel.update(reqData, {
					where: {
						id: id,
						primary_status: 1
					}
				}).then(function(data){
                    // Update the Shift information
					return ShiftsModel.findOne({
						where:{
							id: result.shift_id 
						}
					}).then((data)=>{
						let date 	= data?.date;
						let user_id	= data?.user_id;

						if (status == 2) {
							//IF BOTH REQUESTED TIME IN AND TIME OUT IS EMPTY
							// CHANGE THE SHIFT ACTUAL TIME IN AND OUT TO NULL
							if (!new_login_time && !new_logout_time) {
								let reqData = {
									actual_check_in: null,
									actual_check_out: null,
									updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
									_token: '',
								}
								ShiftsModel.update(reqData, {
									where: {
										// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
										//date: date,
										//user_id: user_id
										id: req_shift_id
									}
								});
							}
							else {
								let reqData2 = {
									updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
									_token: '',
								}

								if (new_login_time) {
									reqData2.actual_check_in = moment(new_login_time).utc().format('HH:mm:ss');
								}
								if (new_logout_time) {
									reqData2.actual_check_out = moment(new_logout_time).utc().format('HH:mm:ss');
								}

								//UPDATE SHIFT
								ShiftsModel.update(reqData2, {
									where: {
										// FOR EMPLOYEE THAT HAS DOUBLE SHIFTS
										//date: date,
										//user_id: user_id
										id: req_shift_id
									}
								}).then((data) => {
									// Initiate TSSHelper
									TSSHelper.process(result.log_date, result.user_id);
								});
							}
						}

					});
					// let notificationMessage = {
					// 	sender: user.id,
					// 	content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your overtime application.',
					// 	url: 'forms/overtime'
					// }
					// let receiver = [result.user_id];
					// Notification.notify(notificationMessage, receiver, null, null);

					// //MAIL Notification
					// let mailMessage = `<p>Your overtime application has been declined.</p>`;
					// if(status == 2){
					// 	mailMessage = `<p>Your overtime application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
					// }
					// let subject = 'Overtime Application';
					// let applicant = {
					// 	first_name: result.applicant.first_name,
					// 	email: result.applicant.email
					// }
					// MailHelper.send_mail(applicant, mailMessage, subject);
				});
			});
		}
	}
	
	res.status(200).json({
		success: true,
		action: 'fetch',
		msg: 'Record has been successfully updated.'
	});

}
