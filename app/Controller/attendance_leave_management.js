const UserRole = require('../Helper/UserRole');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser')
const fs = require('fs');
const uuidv4 = require('uuid/v4');
const _ = require('underscore');
const formidable = require('formidable');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	CompanyModel, 
	TaxonomyModel,
	BranchesModel,
	LeavesModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	EmploymentsModel,
	Division,
	Department,
	Section,
	LeaveDateModel
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-leave');
	}).then(function(data){
		user_role = data;
		if(!(user_role.read || res.locals.isSupervisor > 0)){
			res.render('Errors/403');
		}else{
			res.render('Attendance/LeaveManagement/index',{
				route: 'attendance-leave',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.import = function(req, res){
	let uploadPath = './assets/uploads/leave/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let attachment 	= typeof files.csv != 'undefined' ? files.csv : null;
		let size = attachment ? attachment.size : null;
		req.body.csv = size ? size: '';
		req.checkBody('csv').notEmpty().withMessage('The site field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let filename = res.locals.moment().format('YYYYMMDDHHmmss');
			let path = attachment.path;
			let origFileName = attachment.name;
			let ext = origFileName.split(".");
				ext = ext.pop()
			filename = filename + '.'+ ext;
			fs.readFile(path, function(err, data){
				fs.writeFile(uploadPath + filename, data, function(err){
					if(!err){
						const results = [];
						let error = '';
						raw = fs.createReadStream(uploadPath + filename);
						raw.on('error', function(){
							res.status(200).json({
								success: true,
								action: 'fetch',
								msg: 'Cant find '+ filename
							});
						});
						raw.pipe(csv({
							mapHeaders: ({ header, index }) => header.toLowerCase()
						}))
						.on('headers', (headers) => {
						
							let header = headers.map(function(v) {
							  return v.toLowerCase();
							});

							if(!(header.includes('employee_number') && header.includes('start_date') && header.includes('end_date') && header.includes('leave_type') && header.includes('credit'))){
								error = 'File import failed. Please follow the given format and try again.';
							}
						})
						.on('data', (data) => results.push(data))
						.on('end', () => {
							if(!error){
								if(results && results.length){
									for(let i in results){
										saveLeave(results[i]);
									}
								}
								res.status(200).json({
									success: true,
									action: 'fetch',
									msg: 'Import success.'
								});
							}else{
								res.status(200).json({
									success: true,
									action: 'failed',
									msg: error
								});
							}
						});
					}else{
						res.status(200).json({
							success: true,
							action: 'failed',
							msg: 'Import failed.'
						});
					}
				});
			});
		}
	});
}


// exports.fetch = function(req, res){
// 	let user = res.locals.user;
// 	let isSupervisor = res.locals.isSupervisor;
// 	let start 	= req.body.start;
// 	let end 	= req.body.end;
// 	let company = req.body.company;
// 	let userId 	= req.body.user;
// 	let department 	= req.body.department;
// 	let division 	= req.body.division;
// 	let section 	= req.body.section;
// 	let limit   = parseInt(req.body.limit);
// 	let page 	= req.body.page;
// 	let offset  = (parseInt(page) - 1) * parseInt(limit);
// 	let user_role = null;
// 	let employment = null;
// 	let userIDS = null;
// 	let where = {}

// 	if(!start){
// 		start = moment().startOf('month').format('YYYY-MM-DD');
// 	}
// 	if(!end){
// 		end = moment().endOf('month').format('YYYY-MM-DD');
// 	}
// 	let whereLeave = {
// 		start_date: {
// 			$between: [start, end]
// 		}
// 	};
// 	if(company){
// 		where.company_id = company;
// 	}
// 	if(division){
// 		where.division_id = division;
// 	}
// 	if(department){
// 		where.department_id = department;
// 	}
// 	if(section){
// 		where.section_id = section;
// 	}
// 	EmploymentsModel.findAll({
// 		where: where,
// 		attributes: ['id','user_id'],
// 		raw: true
// 	}).then(data=>{
// 		employment = data;
// 		return UsersModel.findAll({
// 			where: {
// 				[Op.or]: [
// 					{
// 						approver_id: user.id
// 					},{
// 						secretary_id: user.id
// 					}
// 				]
// 			},
// 			attributes: ['id'],
// 			raw: true
// 		});
		
// 	}).then(function(data){
// 		userIDS = data;
// 		userIDS = _.pluck(userIDS, 'id');
// 		return UserRole.get_role(user, 'attendance-shift');
// 	}).then(function(data){
// 		user_role = data;
// 		let user_id = [];
// 		if(employment && employment.length){
// 			for(let i in employment){
// 				user_id.push(employment[i].user_id);
// 			}
// 		}
// 		user_id = [...new Set(user_id)];
// 		// console.log("user_id: ", user_id);
		
// 		let whereUser = {}
// 		if(user_role.read){
// 			if(!_.isEmpty(where)){
// 				whereLeave.user_id = {
// 					[Op.in]: user_id
// 				}
// 			}
// 		}else if(isSupervisor > 0){
// 			whereLeave.user_id = {
// 				[Op.in]: userIDS
// 			}
// 		}
		
// 		// console.log(whereUser);
// 		LeavesModel.findAndCountAll({
// 			where: whereLeave,
//             limit: limit,
//             offset: offset,
//             include: [
// 				{
// 					model: UsersModel,
// 					as: 'applicant',
// 					attributes: ['shortid','first_name','last_name','employee_number'],
// 				},
// 				{
// 					model: UsersModel,
// 					as: 'primary',
// 					attributes: ['shortid','first_name','last_name']
// 				},
// 				{
// 					model: LeavePolicyModel,
// 					attributes: ['name']
// 				},
// 				{
// 					model: LeaveCreditPolicyModel,
// 					required: false,
// 					where: {
// 						user_id: { $col: 'leaves.user_id' }
// 					},
// 					attributes: ['balance', 'utilized']
// 				}
// 			],
// 			// logging: true
// 		}).then(data=>{
// 			leaves = data;
// 			numrows = leaves.count;
// 	        count = 0;
// 	        if(limit < numrows){
// 	            count = numrows / limit;
// 	            count = Math.ceil(count);
// 	        }else{
// 	            count = 0;
// 	        }
// 	        res.status(200).json({
// 	            success: true,
// 	            records: leaves.rows,
// 				count: count
// 	        });
// 		})
// 	});
// }


exports.fetch = function(req, res){
	
	let user = res.locals.user;
	let isHRGeneralist = res.locals.isHRGeneralist;
	let isSupervisor = res.locals.isSupervisor;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let company = req.body.company;
	let userId 	= req.body.user;
	let department 	= req.body.department;
	let division 	= req.body.division;
	let section 	= req.body.section;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let user_role = null;
	let employment = null;
	let userIDS = null;
	let key = req.body.key;
	let hasStartAndEndDate = false;

	
	
	let where = {};
	let whereUser = {};
	let whereLeave = {}

	if(!start){
		start = moment().startOf('month').format('YYYY-MM-DD');
	}
	if(!end){
		end = moment().endOf('month').format('YYYY-MM-DD');
	}

	if(start && end){
		hasStartAndEndDate = true;
	}
	//let whereLeave = {
	//	start_date: {
	//		$between: [start, end]
	//	}
	//};
	if(company){
		where.company_id = company;
	}
	if(division){
		where.division_id = division;
	}
	if(department){
		where.department_id = department;
	}
	if(section){
		where.section_id = section;
	}
	
	EmploymentsModel.findAll({
		where: where,
		attributes: ['id','user_id'],
		raw: true
	}).then(function(data){
		employment = data;
		return UserRole.get_role(user, 'attendance-shift');
	}).then(function(data){
		user_role = data;

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

		if(hasStartAndEndDate) {
			whereLeave = {
				[Op.or]: [
					{
						start_date: {
							$between: [start, end]
						}
					},{
						end_date: {
							$between: [start, end]
						}
					},
				]
			};
		}

		if(!user_role.read && (isSupervisor > 0 || isHRGeneralist > 0)){
			let newWhereUser = {}
			if(!_.isEmpty(whereUser)) {
				newWhereUser[Op.and] = {
					whereUser,
					[Op.or]: [
						{
							approver_id: user.id
						},{
							secondary_approver_id: user.id
						},{
							secretary_id: user.id
						},{
							hr_generalist_id: user.id
						}
					]
				}
			} else {
				newWhereUser[Op.or] = [
					{
						approver_id: user.id
					},{
						secondary_approver_id: user.id
					},{
						secretary_id: user.id
					},{
						hr_generalist_id: user.id
					}
				]
			}
			whereUser = newWhereUser
		} else {
			let user_id = [];

			if(isHRGeneralist) {
				whereUser.hr_generalist_id = user.id
			}

			if(employment && employment.length){
				user_id = _.pluck(employment, 'user_id');
			}
			user_id = [...new Set(user_id)];
			if(!_.isEmpty(where)){
				whereUser.id = {
					[Op.in]: user_id
				}
			}
		}

		return UsersModel.findAll({
			where: whereUser,
			attributes: ['id'],
			raw: true
		});
		
	}).then(function(data){
		userIDS = data;
		userIDS = _.pluck(userIDS, 'id');

		whereLeave.user_id = {
			[Op.in]: userIDS
		}
		
		LeavesModel.findAndCountAll({
			where: whereLeave,
            limit: limit,
            offset: offset,
            include: [
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['shortid','first_name','last_name','employee_number'],
				},
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['shortid','first_name','last_name']
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
			// logging: true
		}).then(data=>{
			leaves = data;
			numrows = leaves.count;
	        count = 0;
	        if(limit < numrows){
	            count = numrows / limit;
	            count = Math.ceil(count);
	        }else{
	            count = 0;
	        }
	        res.status(200).json({
	            success: true,
	            records: leaves.rows,
				isHRGeneralist: isHRGeneralist,
				count: count
	        });
		})
	});
}


const saveLeave = function(row){
	let employee_number = row.employee_number;
	let start_date = moment(new Date(row.start_date)).format('YYYY-MM-DD');
	let end_date = moment(new Date(row.end_date)).format('YYYY-MM-DD');
	let leave_type = row.leave_type;
	let credit = row.credit;
	let reason = row.reason;
	LeavePolicyModel.findOne({
		where: {
			code: leave_type
		}
	}).then(data=>{
		leave = data;
		return UsersModel.findOne({
			where:{
				employee_number: employee_number
			},
			include: [
				{
					model: EmploymentsModel,
					limit: 1,
					order: [
						['id','desc']
					],
					separate: true,
					include:[{
							model: Division,
							as: 'division',
							include: [
								{
									model: UsersModel,
									as: 'manager',
									attributes:['id','first_name','last_name','email']
								}
							]
						},{
							model: Department,
							as: 'department',
							include: [
								{
									model: UsersModel,
									as: 'manager',
									attributes:['id','first_name','last_name','email']
								}
							]
						},{
							model: Section,
							as: 'section',
							include: [
								{
									model: UsersModel,
									as: 'supervisor',
									attributes:['id','first_name','last_name','email']
								}
							]
						}
					]
				}
			],
		});
	}).then(data=>{
		user = data;
		let user_id = user.id;
		if(leave){
			let employment = user.employments && user.employments.length ? user.employments[0] : null;
			let primary_approver = null;
			if(employment){
				if(employment.approving_organization == 'division'){
					primary_approver = employment.division && employment.division.manager ? employment.division.manager.id : null;
				}else if(employment.approving_organization == 'department'){
					primary_approver = employment.department && employment.department.manager ? employment.division.manager.id : null;
				}else if(employment.approving_organization == 'section'){
					primary_approver = employment.section && employment.section.supervisor ? employment.section.supervisor.id : null;
				}
			}
			// console.log(leave);
			let no_of_days = moment(start_date).diff(moment(end_date), 'days');
				no_of_days = no_of_days + 1;
			
			let dates = [];
			let start = moment(start_date);
			let end = moment(end_date);

			var now = start.clone();
			while (now.isSameOrBefore(end)) {
	            dates.push(now.format('MM/DD/YYYY'));
	            now.add(1, 'days');
	        }
			let reqData = {
				user_id: user_id,
				start_date: start_date,
				end_date: end_date,
				leave_type: leave.id,
				no_of_days: no_of_days,
				credit: credit,
				reason: reason,
				primary_status: 2,
				backup_status: 0,
				primary_approver: primary_approver,
				backup_approver: null,
				_token: uuidv4(),
				is_hr: !primary_approver ? 1 : null
			}
			LeavesModel.findOne({
				where: {
					user_id: user_id,
					start_date: start_date,
					end_date: end_date
				}
			}).then(data=>{
				count = data;
				if(!count){
					LeavesModel.create(reqData).then(function(data){
						let insertId = data.id;
						for(let x in dates){
							let dateData = {
								leave_id: insertId,
								user_id: user_id,
								date: moment(new Date(dates[x])).format('YYYY-MM-DD'),
								number_of_day: 1
							}
							LeaveDateModel.create(dateData);
						}
					});
				}
			})
			
		}
	});
	// console.log(row);
}


exports.export = function(req, res){
	let user = res.locals.user;
	let isSupervisor = res.locals.isSupervisor;
	let start 	= req.query.start;
		start = start ? moment(start).format('YYYY-MM-DD') : '';
	let end 	= req.query.end;
		end = end ? moment(end).format('YYYY-MM-DD') : '';
	let company = req.query.company;
	let userId 	= req.query.user;
	let department 	= req.query.department;
	let division 	= req.query.division;
	let section 	= req.query.section;
	let limit   = parseInt(req.query.limit);
	let page 	= req.query.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let user_role = null;
	let employment = null;
	let userIDS = null;
	let where = {}

	if(!start){
		start = moment().startOf('month').format('YYYY-MM-DD');
	}
	if(!end){
		end = moment().endOf('month').format('YYYY-MM-DD');
	}
	let whereLeave = {
		start_date: {
			$between: [start, end]
		}
	};
	if(company){
		where.company_id = company;
	}
	if(division){
		where.division_id = division;
	}
	if(department){
		where.department_id = department;
	}
	if(section){
		where.section_id = section;
	}
	EmploymentsModel.findAll({
		where: where,
		attributes: ['id','user_id'],
		raw: true
	}).then(data=>{
		employment = data;
		return UsersModel.findAll({
			where: {
				[Op.or]: [
					{
						approver_id: user.id
					},{
						secretary_id: user.id
					}
				]
			},
			attributes: ['id'],
			raw: true
		});
		
	}).then(function(data){
		userIDS = data;
		userIDS = _.pluck(userIDS, 'id');
		return UserRole.get_role(user, 'attendance-shift');
	}).then(function(data){
		user_role = data;
		let user_id = [];
		if(employment && employment.length){
			for(let i in employment){
				user_id.push(employment[i].user_id);
			}
		}
		user_id = [...new Set(user_id)];
		// console.log("user_id: ", user_id);
		
		let whereUser = {}
		if(user_role.read){
			if(!_.isEmpty(where)){
				whereLeave.user_id = {
					[Op.in]: user_id
				}
			}
		}else if(isSupervisor > 0){
			whereLeave.user_id = {
				[Op.in]: userIDS
			}
		}
		
		// console.log(whereUser);
		LeavesModel.findAndCountAll({
			where: whereLeave,
            limit: limit,
            offset: offset,
            include: [
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['shortid','first_name','last_name'],
				},
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['shortid','first_name','last_name']
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
			// logging: true
		}).then(data=>{
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
	        let fields = ['Date Filed','Employee','Date','No. of Days','Leave Type','Credit','Purpose','Approved By','Status'];
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
	        			'Employee': record[i].applicant.first_name +' '+ record[i].applicant.last_name,
	        			'Date': moment(record[i].start_date).format('MM/DD/YYYY') +' — '+ moment(record[i].end_date).format('MM/DD/YYYY'),
	        			'No. of Days': record[i].no_of_days +' day(s)',
	        			'Leave Type': record[i].leave_policy ? record[i].leave_policy.name : '',
	        			'Credit': record[i].credit==1 ?'With Pay':'Without Pay',
	        			'Purpose': record[i].reason,
	        			'Approved By': record[i].primary ? record[i].primary.first_name +' '+ record[i].primary.last_name:'--',
	        			'Status': status,
	        		});
	        	}
	        }
	        let filename = 'Leave Management_'+moment(start).format('YYYYMMDD');
	       	const json2csvParser = new Parser({ fields });
			const csv = json2csvParser.parse(arrayData);
			res.attachment(filename+'.csv');
			res.status(200).send(csv);
		})
	});
}