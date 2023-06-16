const Excel 	   = require('exceljs');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser');
const fs = require('fs');
const _ = require('underscore');
const MailHelper = require('../Helper/MailHelper');
const Notification = require('../Helper/Notification');
const UserRole = require('../Helper/UserRole');
const GlobalHelper = require('../Helper/GlobalHelper');
const moment     	= require('moment-timezone');
const TSSHelper = require('../Helper/TSSHelper');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	BusinessTripsModel,
	ApproversModel,
	RolePermissionModel,
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-business-trip').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/BusinessTrip/index',{
					route: 'app-business',
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
		where.date_start = {
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

		BusinessTripsModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return BusinessTripsModel.findAll({
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
						model: UsersModel, as: 'applicant',
						attributes: ['id', 'first_name', 'last_name','employee_number']
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
	console.log('Export Business Trip');
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
		where.date_start = {
	        $between: [start, end]
	    }
	}
	if(employee){
		where.user_id = employee;
	}
	BusinessTripsModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return BusinessTripsModel.findAndCountAll({
			where: where,
			order: [
				['created_at', 'DESC']
			],
			include: [
				{
					model: UsersModel, as: 'applicant',
					attributes: ['id', 'first_name', 'last_name']
				}
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		trips = data;
		numrows = trips.count;
		count = 0;
		if(limit < numrows){
			count = numrows / limit;
			count = Math.ceil(count);
		}else{
			count = 0;
		}
		let record = trips.rows;
		let fields = ['Date Filed','Employee','Date','Note','Status'];
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
					'Date': moment(record[i].date_start).format('MM/DD/YYYY') +'—'+moment(record[i].date_end).format('MM/DD/YYYY'),
					'Note': record[i].note,
					'Status': status,
				});
			}
		}
		let filename = 'Approval_business_trip_'+moment(start).format('YYYYMMDD');
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(arrayData);
		res.attachment(filename+'.csv');
		res.status(200).send(csv);
	});

}

exports.archive = function(req, res){
	let id = req.body.id;
	BusinessTripsModel.destroy({
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
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
			BusinessTripsModel.findOne({
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
				attributes: ['id','user_id', 'primary_approver', 'backup_approver', 'date_start', 'date_end'],
				
			}).then(function(data){
				let result = data;

				let reqData = {
					primary_status: status,
					backup_status: status,
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
				BusinessTripsModel.update(reqData, {
					where: where
				}).then(function(data){
					//APP Notification
					let notificationMessage = {
						sender: user.id,
						content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your business trip application.',
						url: 'forms/business-trip'
					}
					let receiver = [result.user_id];
					Notification.notify(notificationMessage, receiver, null, null);

					// Initiate TSSHelper
					let target_date_list = [result.date_start, result.date_end]
					TSSHelper.process(target_date_list, result.user_id);
					//MAIL Notification - changed to by batch using cron
					//let mailMessage = `<p>Your business trip application has been declined.</p>`;
					//if(status == 2){
					//	mailMessage = `<p>Your business trip application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
					//}
					//let subject = 'Business Trip Application';
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

exports.cancel = function(req, res){
	let business_trip_id = req.body.id;
	BusinessTripsModel.findOne({
		where: {
			id: business_trip_id
		}
	}).then(function(data){
		business_trip_data = data
		let reqDataBusinessTrip = {
			backup_status: 4,
			primary_status: 4,
			_token: '',
		}
		return BusinessTripsModel.update(reqDataBusinessTrip, {
			where: {
				id: business_trip_id
			}
		}).then(function(data){
			let target_date_list = [business_trip_data.date_start, business_trip_data.date_end]
			TSSHelper.process(target_date_list, business_trip_data.user_id);

			res.status(200).json({
				success: true
			});
		});
	});
}

/*
exports.report = function(req, res){
	let user = res.locals.user;
	let start		= req.query.start ? req.query.start : '';
	let end			= req.query.end ? req.query.end : '';
	let status		= req.query.status ? req.query.status : '';
	let page		= req.query.page;
	let limit       = req.query.limit ? parseInt(req.query.limit) : 25;

	let params = {
		start: start ? res.locals.moment(new Date(start)).format('YYYY-MM-DD') : null,
		end: end ? res.locals.moment(new Date(end)).format('YYYY-MM-DD') : null,
		status: status
	}

	BusinessTripModel._getApproverBusinessTrip(params, user.id, limit, page).then(function(data){
		record = data;
		if(record.length){
			let workbook  = new Excel.Workbook();
			let filename  = 'Business Trip - '+res.locals.moment().format('MMMM Do YYYY hA');
			let sheet     = workbook.addWorksheet(filename);
			let border = {
				top:    { style:'thin' },
			    left:   { style:'thin' },
			    bottom: { style:'thin' },
			    right:  { style:'thin' },
			}
			let fill = {
				type: 'pattern',
		        pattern:'solid',
				fgColor:{argb:'bdd7ee'},
			    bgColor:{argb:'bdd7ee'}
			}
			let align_center = {
				vertical: 'middle',
				horizontal: 'left'
			}
			var columns = [
				{ header: '', key: 'col1', width: 5},
				{ header: '', key: 'col2', width: 25},
				{ header: '', key: 'col3', width: 25},
				{ header: '', key: 'col4', width: 25},
				{ header: '', key: 'col5', width: 25},
				{ header: '', key: 'col6', width: 100},
			];

			workbook.eachSheet(function(worksheet, sheetId) {
				
				worksheet.views = [
				    {
				    	//state: 'frozen'
				    }
				];

				worksheet.columns = columns;
				worksheet.addRow(['','Status','Date Filed','Employee','Date','Note']);

				worksheet.getCell('B2').border = border;
				worksheet.getCell('C2').border = border;
				worksheet.getCell('D2').border = border;
				worksheet.getCell('E2').border = border;
				worksheet.getCell('F2').border = border;

				worksheet.getCell('B2').fill = fill;
				worksheet.getCell('C2').fill = fill;
				worksheet.getCell('D2').fill = fill;
				worksheet.getCell('E2').fill = fill;
				worksheet.getCell('F2').fill = fill;

				let num = 2;
				for(let x in record){
					num++;
					let status = '';
					if(record[x]['status'] == 1){
						status = 'Pending';
					}else if(record[x]['status'] == 2){
						status = 'Approved';
					}else if(record[x]['status'] == 3){
						status = 'Declined';
					}else{
						status = 'Closed';
					}
					let dateFiled = res.locals.moment(record[x]['created_at']).format('YYYY-MM-DD hh:mmA');
					let employee = record[x]['first_name'] +' '+ record[x]['last_name'];
					let date = res.locals.moment(record[x]['date_start']).format('MM/DD/YYYY') +' - '+ res.locals.moment(record[x]['date_end']).format('MM/DD/YYYY');
					let note = record[x]['note'];
					worksheet.addRow(['', status, dateFiled, employee, date, note]);

					worksheet.getCell('B'+ num).border = border;
					worksheet.getCell('C'+ num).border = border;
					worksheet.getCell('D'+ num).border = border;
					worksheet.getCell('E'+ num).border = border;
					worksheet.getCell('F'+ num).border = border;
				}
			});

			let path = 'assets/reports/business-trip/'+ filename +'.xlsx';
			workbook.xlsx.writeFile(path).then(function() {
				res.download(path);
			});
		}		
	});
}
*/