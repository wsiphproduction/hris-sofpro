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
	UndertimeModel,
	ApproversModel,
	ConfigModel
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-undertime').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/Undertime/index',{
					route: 'app-undertime',
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
		where.date = {
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

		UndertimeModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return UndertimeModel.findAll({
				where: where,
				order: [
					['created_at', 'DESC']
				],
				include: [
					{
						model: UsersModel, as: 'applicant',
						attributes: ['id', 'first_name', 'last_name','employee_number']
					},{
						model: UsersModel, as: 'primary',
						attributes: ['id','first_name', 'last_name']
					},{
						model: UsersModel, as: 'backup',
						attributes: ['id','first_name', 'last_name']
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
		where.date = {
	        $between: [start, end]
	    }
	}
	if(employee){
		where.user_id = employee;
	}
	UndertimeModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return UndertimeModel.findAndCountAll({
			where: where,
			order: [
				['created_at', 'DESC']
			],
			include: [
				{
					model: UsersModel, as: 'applicant',
					attributes: ['id', 'first_name', 'last_name','employee_number']
				},{
					model: UsersModel, as: 'primary',
					attributes: ['id','first_name', 'last_name']
				},
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		undertimes = data;
		numrows = undertimes.count;
		count = 0;
		if(limit < numrows){
			count = numrows / limit;
			count = Math.ceil(count);
		}else{
			count = 0;
		}
		let record = undertimes.rows;
		let fields = ['Date Filed','Employee','Date','Reason','Status'];
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
					'Date': moment(record[i].date).format('MM/DD/YYYY') + ' ' + moment(record[i].time).format('HH:mm:ss') ,
					'Reason': record[i].reason,
					'Status': status,
				});
			}
		}
		let filename = 'Approval_undertime_'+moment(start).format('YYYYMMDD');
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
	let title = status == 2 ? 'Approved':'Declined';
	if(checkbox.length){
		for(let x in checkbox){
			let id = checkbox[x];
			UndertimeModel.findOne({
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
				attributes: ['id','user_id','primary_approver', 'backup_approver','date']
			}).then(function(data){
				let result = data;
				let reqData = {
					backup_status: status,
					primary_status: status,
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

				UndertimeModel.update(reqData, {
					where: where
				}).then(function(data){
					let notificationMessage = {
						sender: user.id,
						content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your undertime application.',
						url: 'forms/undertime'
					}
					let receiver = [result.user_id];
					Notification.notify(notificationMessage, receiver, null, null);

					// Initiate TSSHelper
					TSSHelper.process2(result.date, result.user_id);
					//MAIL Notification - changed to by batch using cron
					//let mailMessage = `<p>Your undertime application has been declined.</p>`;
					//if(status == 2){
					//	mailMessage = `<p>Your undertime application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
					//}
					//let subject = 'Undertime Application';
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
	UndertimeModel.destroy({
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
	let undertime_id = req.body.id;
	UndertimeModel.findOne({
		where: {
			id: undertime_id
		}
	}).then(function(data){
		undertime_data = data
		let reqDataUndertime = {
			backup_status: 4,
			primary_status: 4,
			_token: '',
		}
		return UndertimeModel.update(reqDataUndertime, {
			where: {
				id: undertime_id
			}
		}).then(function(data){
			TSSHelper.process(undertime_data.date, undertime_data.user_id);

			res.status(200).json({
				success: true
			});
		});
	});
}