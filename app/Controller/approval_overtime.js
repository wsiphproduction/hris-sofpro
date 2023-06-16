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
	OvertimesModel,
	ApproversModel,
	ConfigModel,
	TSSData
} = require('../../config/Sequelize');
const OvertimeHelper = require('../Helper/OvertimeHelper');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-overtime').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/Overtime/index',{
					route: 'app-overtime',
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
	let isManager = res.locals.isManager;
	let employee 	= req.body.employee;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let type 	= req.body.type;
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
		where.start_date = {
	        $between: [start, end]
	    }
	}
	if(employee){
		where.user_id = employee;
	}
	if(type){
		where.type = type;
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

		OvertimesModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return OvertimesModel.findAll({
				where: where,
				order: [
					['created_at', 'DESC']
				],
				include: [
					{
						model: UsersModel,
						as: 'applicant',
						attributes: ['id', 'first_name', 'last_name','employee_number']
					},
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
				count: count,
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
	let type 	= req.body.type;
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
	if(status){
		where.primary_status = status;
	}
	if((start && end) && (start <= end)){
		where.start_date = {
	        $between: [start, end]
	    }
	}
	if(employee){
		where.user_id = employee;
	}
	if(type){
		where.type = type;
	}
	OvertimesModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return OvertimesModel.findAndCountAll({
			where: where,
			order: [
				['created_at', 'DESC']
			],
			include: [
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id', 'first_name', 'last_name']
				},
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name']
				},
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		overtimes = data;
		numrows = overtimes.count;
		count = 0;
		if(limit < numrows){
			count = numrows / limit;
			count = Math.ceil(count);
		}else{
			count = 0;
		}
		let record = overtimes.rows;
		let fields = ['Date Filed','Employee','Date','Purpose','Status'];
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
					'Date': moment(record[i].start_date).format('MM/DD/YYYY') + ' ' + moment(record[i].start_time).format('HH:mm:ss') +' — '+ moment(record[i].end_date).format('MM/DD/YYYY') + ' ' + moment(record[i].end_time).format('HH:mm:ss'),
					'Purpose': record[i].purpose,
					'Status': status,
				});
			}
		}
		let filename = 'Approval_overtime_'+moment(start).format('YYYYMMDD');
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(arrayData);
		res.attachment(filename+'.csv');
		res.status(200).send(csv);
	});
}

exports.update = function(req, res){
	let user 	 = res.locals.user;
	let status 	 = req.body.status == 'approve' ? 2 : 3;
	let title    = status == 2 ? 'Approved' : 'Declined';
	let checkbox = req.body.checkbox; 
	if(checkbox.length){
		for(let x in checkbox){
			let id = checkbox[x];
			OvertimesModel.findOne({
				where: {
					id: id
				},
				include: [
					{
						model: UsersModel,
						as: 'applicant',
						attributes: ['email', 'first_name', 'last_name']
					}
				],
				attributes: ['id','user_id', 'primary_approver', 'backup_approver', 'start_date', 'end_date']
			}).then(function(data){
				//console.log(data);
				let result = data;

				let reqData = {
					backup_status: status,
					primary_status: status,
					updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
					_token: '',
				}
				let where = {
					id: id
				}
				if(user.id == result.primary_approver || true){
					where.primary_status = 1;
				}else{
					where.backup_status = 1;
				}

				OvertimesModel.update(reqData, {
					where: where
				}).then(function(data){
					let notificationMessage = {
						sender: user.id,
						content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your overtime application.',
						url: 'forms/overtime'
					}
					let receiver = [result.user_id];
					Notification.notify(notificationMessage, receiver, null, null);

					//IF ACCEPTED ONLY
					if(status == 2){
						// Initiate TSSHelper
						let target_date_list = [result.start_date, result.end_date];
						async function overtimeHelper(){
							OvertimeHelper.process(null,id);
							return 1;
						}
						console.log("OT approval: "+ target_date_list + " " + result.user_id);
						overtimeHelper().then(function(){
							TSSHelper.process(target_date_list, result.user_id,true);
						});
					}

					//MAIL Notification - changed to by batch using cron
					//let mailMessage = `<p>Your overtime application has been declined.</p>`;
					//if(status == 2){
					//	mailMessage = `<p>Your overtime application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
					//}
					//let subject = 'Overtime Application';
					//let applicant = {
					//	first_name: result.applicant.first_name,
					//	email: result.applicant.email
					//}
					//MailHelper.send_mail(applicant, mailMessage, subject);
				});
			});
		}
	}

	res.status(200).json({
		success: true,
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	OvertimesModel.destroy({
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
	let ot_id = req.body.id;
	OvertimesModel.findOne({
		where: {
			id: ot_id
		}
	}).then(function(data){
		overtime_data = data
			
		let reqDataOT = {
			backup_status: 4,
			primary_status: 4,
			_token: '',
		}
		return OvertimesModel.update(reqDataOT, {
			where: {
				id: ot_id
			}
		}).then(function(data){
			let target_date_list = [overtime_data.start_date, overtime_data.end_date]
			TSSHelper.process(target_date_list, overtime_data.user_id);

			res.status(200).json({
				success: true
			});
		});
	});
}