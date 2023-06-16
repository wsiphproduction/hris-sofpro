const { convertCSVToArray } = require('convert-csv-to-array');
const csv = require('csv-parser')
var { Parser } = require('json2csv');
const fs = require('fs');
const _ = require('underscore');
const formidable = require('formidable');
const UserRole = require('../Helper/UserRole');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	BiometricNumberModel,
	ShiftsModel,
	BiometricModel,
	BiometricCsvModel,
	OvertimesModel,
	EmploymentsModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-overtime');
	}).then(function(data){
		user_role = data;
		if(!(user_role.read || res.locals.isSupervisor > 0)){
			res.render('Errors/403');
		}else{
			res.render('Attendance/Overtime/index',{
				route: 'attendance-overtime',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

// exports.fetch = function(req, res){
// 	let isSupervisor = res.locals.isSupervisor;
// 	let user = res.locals.user;
// 	let userId 	= req.body.user;
// 	let start 	= req.body.start;
// 	let end 	= req.body.end;
// 	let company 	= req.body.company;
// 	let department 	= req.body.department;
// 	let division 	= req.body.division;
// 	let section 	= req.body.section;
// 	let limit   = parseInt(req.body.limit);
// 	let page 	= req.body.page;
// 	let offset  = (parseInt(page) - 1) * parseInt(limit);
	
// 	let where = {}

// 	if(!start){
// 		start = moment().startOf('month').format('YYYY-MM-DD');
// 	}
// 	if(!end){
// 		end = moment().endOf('month').format('YYYY-MM-DD');
// 	}
// 	let whereOvertime = {
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
		
// 		if(user_role.read){
// 			if(!_.isEmpty(where)){
// 				whereOvertime.user_id = {
// 					[Op.in]: user_id
// 				}
// 			}
// 		}else if(isSupervisor > 0){
// 			whereOvertime.user_id = {
// 				[Op.in]: userIDS
// 			}
// 		}

// 		OvertimesModel.findAndCountAll({
// 			where: whereOvertime,
//             limit: limit,
//             offset: offset,
//             include: [
// 				{
// 					model: UsersModel,
// 					as: 'applicant',
// 					attributes: ['id','shortid','first_name','last_name','employee_number']
// 				},
// 				{
// 					model: UsersModel,
// 					as: 'primary',
// 					attributes: ['id','shortid','first_name','last_name']
// 				}
// 			],
// 			// logging: true
// 		}).then(data=>{
// 			overtime = data;
// 			numrows = overtime.count;
// 	        count = 0;
// 	        if(limit < numrows){
// 	            count = numrows / limit;
// 	            count = Math.ceil(count);
// 	        }else{
// 	            count = 0;
// 	        }
// 	        res.status(200).json({
// 	            success: true,
// 	            records: overtime.rows,
// 				count: count
// 	        });
// 		})
// 		// console.log(whereUser);
// 	});

// }

exports.fetch = function(req, res){
	let isSupervisor = res.locals.isSupervisor;
	let isHRGeneralist = res.locals.isHRGeneralist;
	let user = res.locals.user;
	let userId 	= req.body.user;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let company 	= req.body.company;
	let department 	= req.body.department;
	let division 	= req.body.division;
	let section 	= req.body.section;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let key = req.body.key;
	
	let where = {};
	let whereUser = {};
	let whereOvertime = {}
	let hasStartAndEndDate = false;


	if(!start){
		start = moment().startOf('month').format('YYYY-MM-DD');
	}
	if(!end){
		end = moment().endOf('month').format('YYYY-MM-DD');
	}

	if(start && end){
		hasStartAndEndDate = true;
	}
	//let whereOvertime = {
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
			whereOvertime = {
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

		whereOvertime.user_id = {
			[Op.in]: userIDS
		}
		
		OvertimesModel.findAndCountAll({
			where: whereOvertime,
            limit: limit,
            offset: offset,
            include: [
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','shortid','first_name','last_name','employee_number']
				},
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id','shortid','first_name','last_name']
				}
			],
			// logging: true
		}).then(data=>{
			overtime = data;
			numrows = overtime.count;
	        count = 0;
	        if(limit < numrows){
	            count = numrows / limit;
	            count = Math.ceil(count);
	        }else{
	            count = 0;
	        }
	        res.status(200).json({
	            success: true,
	            records: overtime.rows,
				isHRGeneralist: isHRGeneralist,
				count: count
	        });
		})
		// console.log(whereUser);
	});

}

exports.import = function(req, res){
	let uploadPath = './assets/uploads/overtime/';
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

							if(!(header.includes('employee_number') && header.includes('start_date_time') && header.includes('end_date_time') && header.includes('overtime_type'))){
								error = 'File import failed. Please follow the given format and try again.';
							}
						})
						.on('data', (data) => results.push(data))
						.on('end', () => {
							if(!error){
								if(results && results.length){
									for(let i in results){
										saveOvertime(results[i]);
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

const saveOvertime = function(row){
	let employee_number = row.employee_number;
	let start_date = moment(new Date(row.start_date_time)).format('YYYY-MM-DD');
	let start_time = moment(new Date(row.start_date_time)).format('HH:mm:ss');
	let end_date = moment(new Date(row.end_date_time)).format('YYYY-MM-DD');
	let end_time = moment(new Date(row.end_date_time)).format('HH:mm:ss');
	let type = row.overtime_type;
	let purpose = row.purpose;

	let start = moment(start_date +' '+ start_time);
	let end = moment(end_date +' '+ end_time);
	let no_of_hours = end.diff(start, 'hours');
	UsersModel.findOne({
		where:{
			employee_number: employee_number
		}
	}).then(data=>{
		user = data;
		if(user){
			OvertimesModel.findOne({
				where: {
					user_id: user.id,
					start_date: start_date
				}
			}).then(data=>{
				overtime = data;
				return ShiftsModel.findOne({
					where: {
						user_id: user.id,
						date: start_date
					}
				});
			}).then(data=>{
				shift = data;
				if(!overtime && shift){
					let reqData = {
						user_id: user.id,
						type: type == 'regular' ? 1 : 2,
						start_date: start_date,
						end_date: end_date,
						start_time: start_time,
						end_time: end_time,
						no_of_hours: no_of_hours,
						purpose: purpose,
						primary_status: 2,
						primary_approver: null
					}
					OvertimesModel.create(reqData);
				}
			})
		}
	});
}


exports.export = function(req, res){
	let isSupervisor = res.locals.isSupervisor;
	let user = res.locals.user;
	let userId 	= req.query.user;
	let start 	= req.query.start;
		start = start ? moment(start).format('YYYY-MM-DD') : '';
	let end 	= req.query.end;
		end = end ? moment(end).format('YYYY-MM-DD') : '';
	let company 	= req.query.company;
	let department 	= req.query.department;
	let division 	= req.query.division;
	let section 	= req.query.section;
	let limit   = parseInt(req.query.limit);
	let page 	= req.query.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	
	let where = {}

	if(!start){
		start = moment().startOf('month').format('YYYY-MM-DD');
	}
	if(!end){
		end = moment().endOf('month').format('YYYY-MM-DD');
	}
	let whereOvertime = {
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
		
		if(user_role.read){
			if(!_.isEmpty(where)){
				whereOvertime.user_id = {
					[Op.in]: user_id
				}
			}
		}else if(isSupervisor > 0){
			whereOvertime.user_id = {
				[Op.in]: userIDS
			}
		}

		OvertimesModel.findAndCountAll({
			where: whereOvertime,
            limit: limit,
            offset: offset,
            include: [
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','shortid','first_name','last_name']
				},
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id','shortid','first_name','last_name']
				}
			],
			// logging: true
		}).then(data=>{
			overtime = data;
			let numrows = overtime.count;
	        count = 0;
	        if(limit < numrows){
	            count = numrows / limit;
	            count = Math.ceil(count);
	        }else{
	            count = 0;
	        }
	        let fields = ['Date Filed','Employee','Start Date','End Date','No. of hours','Purpose','Approved By','Status'];
	        let record = overtime.rows;
	        let arrayData = [];
	        if(numrows){
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
						'Date Filed' : moment(record[i].created_at).format('YYYY-MM-DD HH:mm:ss'),
						'Employee' : record[i].applicant.first_name +' '+ record[i].applicant.last_name,
						'Start Date' : moment(record[i].start_date).format('MM/DD/YYYY')+' '+moment(record[i].start_time).format('hh:mmA'),
						'End Date' : moment(record[i].end_date).format('MM/DD/YYYY')+' '+moment(record[i].end_time).format('hh:mmA'),
						'No. of hours' : record[i].no_of_hours +' hour(s)',
						'Purpose' : record[i].purpose,
						'Approved By' : record[i].primary.first_name +' '+ record[i].primary.last_name,
						'Status' : status
					});
	        	}
	        }
	        let filename = 'Overtime Management_'+moment(start).format('YYYYMMDD');
	       	const json2csvParser = new Parser({ fields });
			const csv = json2csvParser.parse(arrayData);
			res.attachment(filename+'.csv');
			res.status(200).send(csv);
	        // res.header("Content-Type",'application/json');
        	// res.send(JSON.stringify(record, null, 4));
		})
		// console.log(whereUser);
	});

}