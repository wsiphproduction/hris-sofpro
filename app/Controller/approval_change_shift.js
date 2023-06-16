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
	ShiftsModel,
	ApproversModel,
	ConfigModel,
	ShiftType
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-change-shift').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/ChangeShift/index',{
					route: 'app-change-shift',
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

	where.is_change_shift = 1;
	
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

		ShiftsModel.findAndCountAll({
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
		$or: [
			{
				primary_approver: user.id
			},
			{
				backup_approver: user.id
			}
		]
	}

	where.is_change_shift = 1;
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
	ShiftsModel.findAndCountAll({
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
		let fields = ['Employee','TimeIn','TimeOut','NewTimeIn','NewTimeOut','Status'];
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
					'Employee': record[i].applicant.last_name +', '+ record[i].applicant.first_name,
					'TimeIn': record[i].old_checkin ? moment(record[i].old_checkin).utc().format('MM/DD/YYYY hh:mmA') : '',
					'TimeOut': record[i].old_checkout ? moment(record[i].old_checkout).utc().format('MM/DD/YYYY hh:mmA') : '',
					'NewTimeIn': record[i].new_checkin ? moment(record[i].new_checkin).utc().format('MM/DD/YYYY hh:mmA') : '',
					'NewTimeOut': record[i].new_checkout ? moment(record[i].new_checkout).utc().format('MM/DD/YYYY hh:mmA') : '',
					'Status': status,
				});
			}
		}
		let filename = 'Approval_change_shift_'+moment(start).format('YYYYMMDD');
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
	if(checkbox.length){
		for(let x in checkbox){
			let id = checkbox[x];
			ShiftsModel.findOne({
				where: {
					id: id
				},
				include: [
					{
						model: UsersModel,
						as: 'applicant',
						attributes: ['email', 'first_name', 'last_name']
					},
					{
						model: ShiftType,
						as: 'type_of_shift',
						attributes: ['id', 'shift_id', 'break_hours']
					}
				],
				// attributes: ['id','user_id', 'primary_approver', 'backup_approver']
				raw: true
			}).then(function(data){
				let result = data;

				// remove instead of update
				let update_check_in = result.new_checkin ? res.locals.moment(result.new_checkin).utc().format('HH:mm:ss'): null;
				let update_check_out = result.new_checkout ? res.locals.moment(result.new_checkout).utc().format('HH:mm:ss'): null;
				let date = result.date;
				let shiftType = result.new_shift_type;

				ShiftType.findOne({
					where: {
						shift_id: result.new_shift_type
					}
				}).then(data => {

					let reqData = {
						primary_status: status,
						backup_status: status,
						date: date,
						check_in: update_check_in,
						check_out: update_check_out,
						shift_type: shiftType,
						updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
						_token: '',
						break_hour: data.break_hours,
						shift_length: data.num_hours,
					}
					
					ShiftsModel.update(reqData, {
						where: {
							//user_id : result.user_id,
							//date    : result.date,
							id: id,
							primary_status: 1
						}
					}).then(data => {
						TSSHelper.process(result.date, result.user_id);
					})
				});
				// let reqData = {
				// 	primary_status: status,
				// 	backup_status: status,
				// 	date: result.date,
				// 	check_in: update_check_in,
				// 	check_out: update_check_out,
				// 	shift_type: result.new_shift_type,
				// 	updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
				// 	_token: '',
				// 	break_hour: result['type_of_shift.break_hours'],
				// }

				// ShiftsModel.update(reqData, {
				// 	where: {
				// 		user_id : result.user_id,
				// 		date    : result.date,
				// 		primary_status: 1
				// 	}
				// }).then(function(data){
					// Initiate TSSHelper
					// TSSHelper.process(result.date, result.user_id);
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
				// });
			});
		}
	}

	res.status(200).json({
		success: true,
	});
}
