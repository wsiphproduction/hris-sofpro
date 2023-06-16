const UserRole = require('../Helper/UserRole');
const _ = require('underscore');
const { convertCSVToArray } = require('convert-csv-to-array');
const csv = require('csv-parser')
const fs = require('fs');
const formidable = require('formidable');
const Excel = require('exceljs');
const moment     	= require('moment-timezone');
const { 
	Op,
	sequelize,
	UsersModel,
	BiometricNumberModel,
	ShiftsModel,
	BiometricModel,
	BiometricCsvModel,
	UndertimeModel,
	EmploymentsModel,
	ShiftType,
	CompanyModel,
	Division,
	Department,
	Section,
	PositionCategory,
	PositionClassification,
	Position
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-undertime');
	}).then(function(data){
		user_role = data;
		if(!(user_role.read || res.locals.isSupervisor > 0)){
			res.render('Errors/403');
		}else{
			res.render('Attendance/Undertime/index',{
				route: 'attendance-undertime',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.store = function(req, res){
	let uploadPath = './assets/uploads/undertime/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let attachment 	= files.csv;
		let size = typeof attachment != 'undefined' ?  attachment.size : 0;
		req.body.csv = size ? size: '';
		req.checkBody('csv').notEmpty().withMessage('The csv field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let date = res.locals.moment().format('YYYY-MM-DD');
			let filename = 'SHFT-'+res.locals.moment().format('YYMMDDHHmmss')+'.csv';
			if(attachment && attachment.size > 0){
				const results = [];
				let error = '';
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				// filename = filename + '.'+ ext;
				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err){
							res.status(200).json({
								success: true,
								action: 'fetch',
								msg: 'Cant find '+ filename
							});
						}else{
							raw = fs.createReadStream('./assets/uploads/undertime/'+ filename);
							raw.on('error', function(error){
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
								if(!(header.includes('employee_number') 
									&& header.includes('date')
									&& header.includes('time')
									&& header.includes('approver_employee_number')
									)) {
									error = 'File import failed. Please follow the given format and try again.';
								}
							})
							.on('data', (data) => results.push(data))
							.on('end',() => {
								if(error != ''){
									fs.unlink(uploadPath + filename, function (err) {
										if (err) throw err;
										console.log('File deleted!');
									}); 
									var errorData = [
										{	
											param: 'csv_format',
											msg: error
										}
									]
									res.status(422).json({
										success: false,
										errors: errorData
									});
								}else{
									//log(results && results.length);
									if(results && results.length){
										for(let i in results){
											let employee_number = results[i].employee_number;
											let date = res.locals.moment(results[i].date).format('YYYY-MM-DD');
											let time = res.locals.moment(new Date(date + ' ' + results[i].time)).format('HH:mm:ss');
											let approver_employee_number = results[i].approver_employee_number;
											let reason = results[i].reason ? results[i].reason : '';

											proccessUndertime(employee_number, date, time, approver_employee_number, reason);
											
										}
									}
									res.status(201).json({
										success: true,
										action: 'fetch',
										msg: 'Undertime files has been uploaded.'
									});
								}
							});
						}
					});
				});				
			}else{
				res.status(422).json({
					success: false,
		            errors: [
		            	{
		            		location: "body",
							msg: "Unknown error, please try again or contact administratot.",
							param: "csv"
		            	}
		            ]
				});
			}
		}
	});
}

const proccessUndertime = function(employee_number, date, time, approver_employee_number, reason){
	
	//console.log(approver_employee_number);
	UsersModel.findOne({
		where: {
			employee_number: employee_number
		},
		attributes: ['id','first_name','last_name'],
		raw: false,
	}).then(data=>{
		let employee = data;
		let user_id = employee.id;
		return UsersModel.findOne({
			where: {
				employee_number: approver_employee_number
			},
			attributes: ['id','first_name','last_name'],
			raw: false,
		}).then(function(data){
			approver = data;
			//console.log(approver);
			let approver_user_id = approver.id;
			UndertimeModel.create({
				user_id: user_id,
				date: date,
				time: time,
				reason: reason,
				primary_approver: approver_user_id,
				primary_status: 2
			});
		});
	});
}

// exports.fetch = function(req, res){
// 	let isSupervisor = res.locals.isSupervisor;
// 	let user = res.locals.user;
// 	let company = req.body.company ? req.body.company : '';
// 	let division = req.body.division ? req.body.division : '';
// 	let department = req.body.department ? req.body.department : '';
// 	let section = req.body.section ? req.body.section : '';
// 	let limit = req.body.limit ? req.body.limit : 25;
// 	let page 	= req.body.page ? req.body.page : 1;
// 	let offset  = (parseInt(page) - 1) * parseInt(limit);
// 	let start 	= req.body.start;
// 	let end 	= req.body.end;
// 	let key = req.body.key;

// 	if(!start){
// 		start = moment().startOf('month').format('YYYY-MM-DD');
// 	}
// 	if(!end){
// 		end = moment().endOf('month').format('YYYY-MM-DD');
// 	}
	
// 	let where = {};
// 	let whereUndertime = {
// 		date: {
// 			$between: [start, end]
// 		}
// 	};
// 	//console.log(start_date, end_date);
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
// 	}).then(function(data){
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
// 				whereUndertime.user_id = {
// 					[Op.in]: user_id
// 				}
// 			}
// 		}else if(isSupervisor > 0){
// 			whereUndertime.user_id = {
// 				[Op.in]: userIDS
// 			}
// 		}
// 		UndertimeModel.findAndCountAll({
// 			where: whereUndertime,
//             limit: limit,
//             offset: offset,
//             include: [
// 				{
// 					model: UsersModel,
// 					as: 'applicant',
// 					attributes: ['shortid','first_name','last_name', 'employee_number']
// 				},
// 				{
// 					model: UsersModel,
// 					as: 'primary',
// 					attributes: ['shortid','first_name','last_name', 'employee_number']
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
// 	});
// }

exports.fetch = function(req, res){
	let isSupervisor = res.locals.isSupervisor;
	let isHRGeneralist = res.locals.isHRGeneralist;
	let user = res.locals.user;
	let company = req.body.company ? req.body.company : '';
	let division = req.body.division ? req.body.division : '';
	let department = req.body.department ? req.body.department : '';
	let section = req.body.section ? req.body.section : '';
	let limit = req.body.limit ? req.body.limit : 25;
	let page 	= req.body.page ? req.body.page : 1;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let start 	= req.body.start;
	let end 	= req.body.end;
	let key = req.body.key;
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

	let where = {};
	let whereUser = {};
	let whereUndertime = {}
	//console.log(start_date, end_date);
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
			whereUndertime = {
				date: {
					$between: [start, end]
				}
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

		whereUndertime.user_id = {
			[Op.in]: userIDS
		}
		
		UndertimeModel.findAndCountAll({
			where: whereUndertime,
            limit: limit,
            offset: offset,
            include: [
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['shortid','first_name','last_name', 'employee_number']
				},
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['shortid','first_name','last_name', 'employee_number']
				}
			],
			
			// logging: true
		}).then(data=>{
			undertime = data;
			numrows = undertime.count;
	        count = 0;
	        if(limit < numrows){
	            count = numrows / limit;
	            count = Math.ceil(count);
	        }else{
	            count = 0;
	        }
	        res.status(200).json({
	            success: true,
	            records: undertime.rows,
				isHRGeneralist: isHRGeneralist,
				count: count
	        });
		})
	});
}

exports.download = function(req, res){
	let company = req.query.company ? req.query.company : '';
	let division = req.query.division ? req.query.division : '';
	let department = req.query.department ? req.query.department : '';
	let section = req.query.section ? req.query.section : '';
	let start_date = req.query.start ? res.locals.moment(new Date( req.query.start )).format('YYYY-MM-DD') :  null;
	let end_date = req.query.end ? res.locals.moment(new Date( req.query.end )).format('YYYY-MM-DD') :  null;
	let absenteeism = req.query.absenteeism ?  req.query.absenteeism : '';
	let key = req.query.key;
	let option = req.query.option;
	let limit = req.query.limit ? req.query.limit : 25;
	
	let where = {};
	let whereUser = {};
	
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
		include:[
			{
				model: CompanyModel,
				as: 'company'
			},{
				model: Division,
				as: 'division',
				include: [
					{
						model: UsersModel,
						as: 'manager',
						attributes:['first_name','last_name']
					}
				]
			},{
				model: Department,
				as: 'department',
				include: [
					{
						model: UsersModel,
						as: 'manager',
						attributes:['first_name','last_name']
					}
				]
			},{
				model: Section,
				as: 'section',
				include: [
					{
						model: UsersModel,
						as: 'supervisor',
						attributes:['first_name','last_name']
					}
				]
			},{
				model: Position,
				as: 'position'
			},{
				model: PositionClassification,
				as: 'position_classification'
			},{
				model: PositionCategory,
				as: 'position_category'
			}
		]
	}).then(function(data){
		employment = data;
		
		let employment_user_id = [];
		if(employment && employment.length){
			for(let i in employment){
				employment_user_id.push(employment[i].user_id);
			}
		}
		employment_user_id = [...new Set(employment_user_id)];
		
		if(!_.isEmpty(where) && employment_user_id.length){
			whereUser.id = {
				[Op.in]: employment_user_id
			}
		}

		if(employment.length < 1) {
			whereUser.id = '';
		}

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

		return UsersModel.findAll({
			where: whereUser,
			attributes: ['id'],
			raw: true
		}).then(function(data){
			users_filtered = data;

			let whereFilteredUser = {};
			let whereShiftUser = {};
			let filtered_user_id = [];

			if(users_filtered && users_filtered.length){
				for(let i in users_filtered){
					filtered_user_id.push(users_filtered[i].id);
				}
			}

			filtered_user_id = [...new Set(filtered_user_id)];
			
			if(filtered_user_id.length){
				whereFilteredUser.user_id = {
					[Op.in]: filtered_user_id
				}
			}
			
			if(employment.length < 1) {
				whereFilteredUser.id = '';
			}

			whereFilteredUser[Op.and] = {
				date: {
					$between: [start_date, end_date]
				},
			}
			
			return UndertimeModel.findAll({
				where: whereFilteredUser,
				attributes: ['id', 'user_id'],
				raw: true
			}).then(function(data){
				undertime_records = data;

				let undertime_user_id = [];
				if(undertime_records && undertime_records.length){
					for(let i in undertime_records){
						undertime_user_id.push(undertime_records[i].user_id);
					}
				}
				
				undertime_user_id = [...new Set(undertime_user_id)];

				if(filtered_user_id.length){
					whereShiftUser.id = {
						[Op.in]: undertime_user_id
					}
				}
				
				if(undertime_records.length < 1) {
					whereShiftUser.id = '';
				}

				return UsersModel.findAll({
					where: whereShiftUser,
					include: [
						{
							model: ShiftsModel,
							required: false,
							where: {
								//primary_status: 2,
								date: {
									$between: [start_date, end_date]
								}
							},
							attributes: ['id','user_id','date','check_in','check_out','actual_check_in','actual_check_out'],
							order: '"date" DESC' 
						},
						{
							model: UndertimeModel,
							// as: 'secretary',
							required: false,
							where: {
								primary_status: 2,
								date: {
									$between: [start_date, end_date]
								}
							},
							include: [
								{
									model: UsersModel,
									as: 'applicant',
									where: whereUser,
									attributes: ['shortid','first_name','last_name', 'employee_number']
								},
								{
									model: UsersModel,
									as: 'primary',
									where: whereUser,
									attributes: ['shortid','first_name','last_name', 'employee_number']
								}
							],
							// attributes: ['type','start_date','end_date','start_time','end_time','actual_check_in','actual_check_out']
						}
					],
					attributes: ['id','shortid','employee_number','first_name','last_name','company_branch_id','department_id','job_title_id'],
				
	
				}).then(function(data){
					shifts = data;
					return ShiftType.findAll({
						attributes: ['id', 'shift_id','shift_desc'],
						raw: true
					});
					}).then(function(data){
					shift_type = data;

					// Export throuh excel
					// console.log(start_date, end_date);
					let start = moment(start_date);
					let end = moment(end_date);
					var duration = moment.duration(end.diff(start));
					var days = duration.asDays();

					let undertimeMonitoring = proccessUndertimeMonitoring(employment, shifts, start_date, days, shift_type);
					
					
					//Initiate Excel
					let filenameStartDate = moment(start_date).format('MMM DD');
					let filenameEndDate = moment(end_date).format('MMM DD');
					let filenameYear = moment(end_date).format('YYYY');
					let filenamePrefix = option == 1 ? "Undertime Monitoring (" : "Undertime Summary (";
					let filename  = filenamePrefix + filenameStartDate + " - " + filenameEndDate + ")-" + filenameYear;

					if(option == 1){
						let workbook  = new Excel.Workbook();
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
							fgColor:{argb:'ffff00'},
							bgColor:{argb:'ffff00'}
						}
						let undertime_monitoring_fill = {
							type: 'pattern',
							pattern:'solid',
							fgColor:{argb:'d5dce4'},
							bgColor:{argb:'d5dce4'}
						}
						let align_center = {
							vertical: 'middle',
							horizontal: 'left'
						}
						let text_font = {
							name: 'Calibri',
							size: 8,
							bold: true
						}

						var columns = [
							{ header: '', key: 'col1', width: 5},
							{ header: '', key: 'col2', width: 10},
							{ header: '', key: 'col3', width: 15},
							{ header: '', key: 'col4', width: 10},
							{ header: '', key: 'col5', width: 15},
							{ header: '', key: 'col6', width: 10},
							{ header: '', key: 'col7', width: 10},
							{ header: '', key: 'col8', width: 50},
							{ header: '', key: 'col9', width: 20},
							{ header: '', key: 'col10', width: 20},
							{ header: '', key: 'col11', width: 10},
							{ header: '', key: 'col12', width: 22},
							{ header: '', key: 'col13', width: 20},
						];

						var center = {
							horizontal: 'center'
						}

						var middleCenter = {
							vertical: 'middle', 
							horizontal: 'center'
						}

						workbook.eachSheet(function(worksheet, sheetId) {
							worksheet.views = [
								{
									//state: 'frozen'
								}
							];
							worksheet.columns = columns;

							
							if(undertimeMonitoring.length){
								let employeeHeader = 13;
								let summaryStart = 2;
								let countSummary = 0;
								let next = 4;
								let i = 0;
									
								//log(start_date, end_date);
								let start = moment(start_date);
								let end = moment(end_date);
								var duration = moment.duration(end.diff(start));
								var days = duration.asDays();
								
								
								let row1Details = ['','EMPLOYEE DETAILS','', '', '', '', '', '', '', '', '', '', '', 'DATE RANGE'];
								let row2Details = [];
								let row3Details = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
								
								row2Details.push('','SN','EMP ID','FAMILY NAME','FIRST NAME','MIDDLE NAME','SUFFIX','POSITION','SECTION','DEPARTMENT','DIVISION','DEPARTMENT MANAGER\'S NAME','APPROVED SHIFT SCHEDULE');
								
								
								for(ctr=0; ctr<days + 1; ctr++) {
									//console.log(ctr);
									var new_date = moment(start_date, "YYYY-MM-DD").add('days', ctr);
									let date = moment(new_date).format('MMMM DD, YYYY - ddd');
									row1Details.push('', '', '');
									row2Details.push(date.toString().toUpperCase(), '', '');
									row3Details.push('IN', 'OUT', 'OT');
								}
								row1Details.splice(-1);
								row1Details.push('TOTAL \nOT (HOURS)');

								worksheet.addRow(row1Details);
								worksheet.addRow(row2Details);
								worksheet.addRow(row3Details);
								summaryStart += next + 1;
								
								let headStart = summaryStart - next - 1;
								let employeeMerge = headStart + 1;

								let regularShiftScheduleEndHeader = convertToColumnLetter(employeeHeader + ((days + 1) * 3));
								let totalEndHeader = convertToColumnLetter(employeeHeader + ((days + 1) * 3) + 1);

								worksheet.mergeCells('B'+ headStart, 'M'+ headStart);
								worksheet.mergeCells('B'+ 3, 'B'+ 4);
								worksheet.mergeCells('C'+ 3, 'C'+ 4);
								worksheet.mergeCells('D'+ 3, 'D'+ 4);
								worksheet.mergeCells('E'+ 3, 'E'+ 4);
								worksheet.mergeCells('F'+ 3, 'F'+ 4);
								worksheet.mergeCells('G'+ 3, 'G'+ 4);
								worksheet.mergeCells('H'+ 3, 'H'+ 4);
								worksheet.mergeCells('I'+ 3, 'I'+ 4);
								worksheet.mergeCells('J'+ 3, 'J'+ 4);
								worksheet.mergeCells('K'+ 3, 'K'+ 4);
								worksheet.mergeCells('L'+ 3, 'L'+ 4);
								worksheet.mergeCells('M'+ 3, 'M'+ 4);
								worksheet.mergeCells('N'+ headStart, regularShiftScheduleEndHeader + headStart);
								worksheet.mergeCells(totalEndHeader + 2, totalEndHeader + 4);
								
								//Header Border
								worksheet.getCell('B'+ headStart).border = border;
								worksheet.getCell('B'+ 3).border = border;
								worksheet.getCell('C'+ 3).border = border;
								worksheet.getCell('D'+ 3).border = border;
								worksheet.getCell('E'+ 3).border = border;
								worksheet.getCell('F'+ 3).border = border;
								worksheet.getCell('G'+ 3).border = border;
								worksheet.getCell('H'+ 3).border = border;
								worksheet.getCell('I'+ 3).border = border;
								worksheet.getCell('J'+ 3).border = border;
								worksheet.getCell('K'+ 3).border = border;
								worksheet.getCell('L'+ 3).border = border;
								worksheet.getCell('M'+ 3).border = border;
								worksheet.getCell('N'+ headStart).border = border;
								worksheet.getCell(totalEndHeader + headStart).border = border;
								

								//Header Alignment
								worksheet.getCell('B'+ headStart).alignment = middleCenter;
								worksheet.getCell('B'+ 3).alignment = middleCenter;
								worksheet.getCell('C'+ 3).alignment = middleCenter;
								worksheet.getCell('D'+ 3).alignment = middleCenter;
								worksheet.getCell('E'+ 3).alignment = middleCenter;
								worksheet.getCell('F'+ 3).alignment = middleCenter;
								worksheet.getCell('G'+ 3).alignment = middleCenter;
								worksheet.getCell('H'+ 3).alignment = middleCenter;
								worksheet.getCell('I'+ 3).alignment = middleCenter;
								worksheet.getCell('J'+ 3).alignment = middleCenter;
								worksheet.getCell('K'+ 3).alignment = middleCenter;
								worksheet.getCell('L'+ 3).alignment = middleCenter;
								worksheet.getCell('M'+ 3).alignment = middleCenter;
								worksheet.getCell('N'+ headStart).alignment = middleCenter;
								worksheet.getCell(totalEndHeader + headStart).alignment = middleCenter;
								
								//Header Background
								worksheet.getCell('B'+ headStart).fill = fill;
								worksheet.getCell('B'+ 3).fill = fill;
								worksheet.getCell('C'+ 3).fill = fill;
								worksheet.getCell('D'+ 3).fill = fill;
								worksheet.getCell('E'+ 3).fill = fill;
								worksheet.getCell('F'+ 3).fill = fill;
								worksheet.getCell('G'+ 3).fill = fill;
								worksheet.getCell('H'+ 3).fill = fill;
								worksheet.getCell('I'+ 3).fill = fill;
								worksheet.getCell('J'+ 3).fill = fill;
								worksheet.getCell('K'+ 3).fill = fill;
								worksheet.getCell('L'+ 3).fill = fill;
								worksheet.getCell('M'+ 3).fill = fill;
								worksheet.getCell('N'+ headStart).fill = undertime_monitoring_fill;
								worksheet.getCell(totalEndHeader + headStart).fill = undertime_monitoring_fill;
								
								//Text Font
								worksheet.getCell('B'+ headStart).font = text_font;
								worksheet.getCell('B'+ 3).font = text_font;
								worksheet.getCell('C'+ 3).font = text_font;
								worksheet.getCell('D'+ 3).font = text_font;
								worksheet.getCell('E'+ 3).font = text_font;
								worksheet.getCell('F'+ 3).font = text_font;
								worksheet.getCell('G'+ 3).font = text_font;
								worksheet.getCell('H'+ 3).font = text_font;
								worksheet.getCell('I'+ 3).font = text_font;
								worksheet.getCell('J'+ 3).font = text_font;
								worksheet.getCell('K'+ 3).font = text_font;
								worksheet.getCell('L'+ 3).font = text_font;
								worksheet.getCell('M'+ 3).font = text_font;
								worksheet.getCell('N'+ headStart).font = text_font;
								worksheet.getCell(totalEndHeader + headStart).font = text_font;

								for(ctr=0; ctr<days + 1; ctr++) {
									worksheet.mergeCells(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3,
														convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 3);
														
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 4).font = text_font;

									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).fill = undertime_monitoring_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).fill = undertime_monitoring_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).fill = undertime_monitoring_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 4).fill = undertime_monitoring_fill;
									
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 4).alignment = middleCenter;

									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 4).border = border;
								}
								
								let sumCount = undertimeMonitoring.length;
								// console.log(sumCount);
								let recordsIDNumber = 0;
								for(let key in undertimeMonitoring) {
									recordsIDNumber++;
									let totalOT = 0;
									let undertimeRecords = [];
									let shifts = undertimeMonitoring[key].shifts;

									undertimeRecords.push('', 
												recordsIDNumber, 
												undertimeMonitoring[key].employee_id,
												undertimeMonitoring[key].family_name,
												undertimeMonitoring[key].first_name,
												undertimeMonitoring[key].middle_name,
												undertimeMonitoring[key].suffix,
												undertimeMonitoring[key].position,
												undertimeMonitoring[key].section,
												undertimeMonitoring[key].department,
												undertimeMonitoring[key].division,
												undertimeMonitoring[key].name_of_supervisor_or_manager,
												undertimeMonitoring[key].approved_shift_schedule);

									for(let shift in shifts) {
										let checkIn = shifts[shift].checkIn;
										let checkOut  = shifts[shift].checkOut;
										let undertimeHours  = shifts[shift].undertimeHours;
										
										totalOT += parseInt(undertimeHours);
										undertimeRecords.push(checkIn, checkOut, undertimeHours);
									}
									undertimeRecords.push(totalOT);
									worksheet.addRow(undertimeRecords);
								}

								let totalColumns = employeeHeader + ((days + 1) * 3);
								let UndertimeTotalColumns = (days + 1) * 3;
								let dataStart = 5;
								
								for(let dataCol = 0; dataCol < sumCount; dataCol++){
									for(let dataRow = 1; dataRow < totalColumns + 1; dataRow++) {
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).border = border;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).alignment = middleCenter;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).font = text_font;
									}

									for(let dataRow = 1; dataRow < UndertimeTotalColumns + 2; dataRow++) {
										worksheet.getCell(convertToColumnLetter(dataRow + 13) + dataStart).fill = undertime_monitoring_fill;
									}

									dataStart++;
								}
							}
							
						});

						let path = 'assets/reports/timekeeping/'+ filename +'.xlsx';
						workbook.xlsx.writeFile(path).then(function() {
							res.download(path);
						});
					} else if (option == 2){
						let workbook  = new Excel.Workbook();
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
							fgColor:{argb:'ffff00'},
							bgColor:{argb:'ffff00'}
						}
						let undertime_details_fill = {
							type: 'pattern',
							pattern:'solid',
							fgColor:{argb:'04ac54'},
							bgColor:{argb:'04ac54'}
						}
						let align_center = {
							vertical: 'middle',
							horizontal: 'left'
						}
						let text_font = {
							name: 'Calibri',
							size: 8,
							bold: true
						}

						var columns = [
							{ header: '', key: 'col1', width: 5},
							{ header: '', key: 'col2', width: 10},
							{ header: '', key: 'col3', width: 15},
							{ header: '', key: 'col4', width: 10},
							{ header: '', key: 'col5', width: 15},
							{ header: '', key: 'col6', width: 10},
							{ header: '', key: 'col7', width: 10},
							{ header: '', key: 'col8', width: 40},
							{ header: '', key: 'col9', width: 20},
							{ header: '', key: 'col10', width: 20},
							{ header: '', key: 'col11', width: 10},
							{ header: '', key: 'col12', width: 22},
							{ header: '', key: 'col13', width: 20},
							{ header: '', key: 'col14', width: 12},
							{ header: '', key: 'col15', width: 7},
							{ header: '', key: 'col16', width: 12},
							{ header: '', key: 'col17', width: 12},
							{ header: '', key: 'col18', width: 12},
							{ header: '', key: 'col19', width: 10},
						];

						var center = {
							horizontal: 'center'
						}

						var middleCenter = {
							vertical: 'middle', 
							horizontal: 'center'
						}

						workbook.eachSheet(function(worksheet, sheetId) {
							worksheet.views = [
								{
									//state: 'frozen'
								}
							];
							worksheet.columns = columns;

							
							if(undertimeMonitoring.length){
								let summaryStart = 2;
								let next = 4;
								let i = 0;
									
								console.log(start_date, end_date);
								let start = moment(start_date);
								let end = moment(end_date);
								var duration = moment.duration(end.diff(start));
								var days = duration.asDays();
								
								
								let row1Details = ['','EMPLOYEE DETAILS','', '', '', '', '', '', '', '', '', '', '', 'UNDERTIME DETAILS'];
								let row2Details = ['','SN','EMP ID','FAMILY NAME','FIRST NAME','MIDDLE NAME','SUFFIX','POSITION','DIVISION','DEPARTMENT','SECTION','DEPARTMENT MANAGER\'S NAME','RATE TYPE', 'SHIFT SCHEDULE', 'DAY', 'SHIFT ID', 'TIME IN', 'TIME OUT', 'UNDERTIME'];

								worksheet.addRow(row1Details);
								worksheet.addRow(row2Details);
								summaryStart += next + 1;
								
								let headStart = summaryStart - next - 1;

								worksheet.mergeCells('B'+ headStart, 'M'+ headStart);
								worksheet.mergeCells('N'+ headStart, 'S'+ headStart);
								
								//Header Border
								worksheet.getCell('B'+ headStart).border = border;
								worksheet.getCell('N'+ headStart).border = border;
								worksheet.getCell('B'+ 3).border = border;
								worksheet.getCell('C'+ 3).border = border;
								worksheet.getCell('D'+ 3).border = border;
								worksheet.getCell('E'+ 3).border = border;
								worksheet.getCell('F'+ 3).border = border;
								worksheet.getCell('G'+ 3).border = border;
								worksheet.getCell('H'+ 3).border = border;
								worksheet.getCell('I'+ 3).border = border;
								worksheet.getCell('J'+ 3).border = border;
								worksheet.getCell('K'+ 3).border = border;
								worksheet.getCell('L'+ 3).border = border;
								worksheet.getCell('M'+ 3).border = border;
								worksheet.getCell('N'+ 3).border = border;
								worksheet.getCell('O'+ 3).border = border;
								worksheet.getCell('P'+ 3).border = border;
								worksheet.getCell('Q'+ 3).border = border;
								worksheet.getCell('R'+ 3).border = border;
								worksheet.getCell('S'+ 3).border = border;
								

								//Header Alignment
								worksheet.getCell('B'+ headStart).alignment = middleCenter;
								worksheet.getCell('N'+ headStart).alignment = middleCenter;
								worksheet.getCell('B'+ 3).alignment = middleCenter;
								worksheet.getCell('C'+ 3).alignment = middleCenter;
								worksheet.getCell('D'+ 3).alignment = middleCenter;
								worksheet.getCell('E'+ 3).alignment = middleCenter;
								worksheet.getCell('F'+ 3).alignment = middleCenter;
								worksheet.getCell('G'+ 3).alignment = middleCenter;
								worksheet.getCell('H'+ 3).alignment = middleCenter;
								worksheet.getCell('I'+ 3).alignment = middleCenter;
								worksheet.getCell('J'+ 3).alignment = middleCenter;
								worksheet.getCell('K'+ 3).alignment = middleCenter;
								worksheet.getCell('L'+ 3).alignment = middleCenter;
								worksheet.getCell('M'+ 3).alignment = middleCenter;
								worksheet.getCell('N'+ 3).alignment = middleCenter;
								worksheet.getCell('O'+ 3).alignment = middleCenter;
								worksheet.getCell('P'+ 3).alignment = middleCenter;
								worksheet.getCell('Q'+ 3).alignment = middleCenter;
								worksheet.getCell('R'+ 3).alignment = middleCenter;
								worksheet.getCell('S'+ 3).alignment = middleCenter;
								
								//Header Background
								worksheet.getCell('B'+ headStart).fill = fill;
								worksheet.getCell('B'+ 3).fill = fill;
								worksheet.getCell('C'+ 3).fill = fill;
								worksheet.getCell('D'+ 3).fill = fill;
								worksheet.getCell('E'+ 3).fill = fill;
								worksheet.getCell('F'+ 3).fill = fill;
								worksheet.getCell('G'+ 3).fill = fill;
								worksheet.getCell('H'+ 3).fill = fill;
								worksheet.getCell('I'+ 3).fill = fill;
								worksheet.getCell('J'+ 3).fill = fill;
								worksheet.getCell('K'+ 3).fill = fill;
								worksheet.getCell('L'+ 3).fill = fill;
								worksheet.getCell('M'+ 3).fill = fill;
								worksheet.getCell('N'+ headStart).fill = undertime_details_fill;
								worksheet.getCell('N'+ 3).fill = undertime_details_fill;
								worksheet.getCell('O'+ 3).fill = undertime_details_fill;
								worksheet.getCell('P'+ 3).fill = undertime_details_fill;
								worksheet.getCell('Q'+ 3).fill = undertime_details_fill;
								worksheet.getCell('R'+ 3).fill = undertime_details_fill;
								worksheet.getCell('S'+ 3).fill = undertime_details_fill;
								
								//Text Font
								worksheet.getCell('B'+ headStart).font = text_font;
								worksheet.getCell('N'+ headStart).font = text_font;
								worksheet.getCell('B'+ 3).font = text_font;
								worksheet.getCell('C'+ 3).font = text_font;
								worksheet.getCell('D'+ 3).font = text_font;
								worksheet.getCell('E'+ 3).font = text_font;
								worksheet.getCell('F'+ 3).font = text_font;
								worksheet.getCell('G'+ 3).font = text_font;
								worksheet.getCell('H'+ 3).font = text_font;
								worksheet.getCell('I'+ 3).font = text_font;
								worksheet.getCell('J'+ 3).font = text_font;
								worksheet.getCell('K'+ 3).font = text_font;
								worksheet.getCell('L'+ 3).font = text_font;
								worksheet.getCell('M'+ 3).font = text_font;
								worksheet.getCell('N'+ 3).font = text_font;
								worksheet.getCell('O'+ 3).font = text_font;
								worksheet.getCell('P'+ 3).font = text_font;
								worksheet.getCell('Q'+ 3).font = text_font;
								worksheet.getCell('R'+ 3).font = text_font;
								worksheet.getCell('S'+ 3).font = text_font;
								
								let sumCount = undertimeMonitoring.length;
								// console.log(days);
								let recordsIDNumber = 0;
								let columnDataStart = 4;
								let totalShiftCount = 0;

								for(let key in undertimeMonitoring) {
									let shifts = undertimeMonitoring[key].shifts;
									totalShiftCount += shifts.length;
									for(let shift in shifts) {
										recordsIDNumber++;
													
										let shiftSchedule = moment(shifts[shift].date).format('DD-MMM-YY');
										let day = moment(shifts[shift].date).format('ddd');
										let shiftID = shifts[shift].shiftID;
										let checkIn = shifts[shift].checkIn;
										let checkOut  = shifts[shift].checkOut;
										let undertimeHours  = shifts[shift].undertimeHours;
										
										worksheet.addRow(['', 
										recordsIDNumber, 
										undertimeMonitoring[key].employee_id,
										undertimeMonitoring[key].family_name,
										undertimeMonitoring[key].first_name,
										undertimeMonitoring[key].middle_name,
										undertimeMonitoring[key].suffix,
										undertimeMonitoring[key].position,
										undertimeMonitoring[key].section,
										undertimeMonitoring[key].department,
										undertimeMonitoring[key].division,
										undertimeMonitoring[key].name_of_supervisor_or_manager,
										'MONTHLY',
										shiftSchedule,
										day,
										shiftID,
										checkIn,
										checkOut,
										undertimeHours]);

									}
								}
								
								let columnCount = 19;

								for(let dataCol = 0; dataCol < totalShiftCount; dataCol++ ) {
									for(let dataRow = 1; dataRow < columnCount; dataRow++) {
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + (dataCol + columnDataStart)).border = border;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + (dataCol + columnDataStart)).alignment = middleCenter;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + (dataCol + columnDataStart)).font = text_font;
									}
								}
							}
							
						});

						let path = 'assets/reports/timekeeping/'+ filename +'.xlsx';
						workbook.xlsx.writeFile(path).then(function() {
							res.download(path);
						});
					}


				});
			});
		});
	});
}

const convertToColumnLetter = function(input_num) {
	var result = '';
	var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	if(input_num > 702) {
		result += 'A'
	}
	else if (input_num > 26) {
		let leftHeader = Math.trunc(input_num / 26);
		let rightHeader = input_num - (leftHeader * 26);

		if(rightHeader == 0) {
			rightHeader = 26;
			leftHeader -= 1;
		}

		result += characters[leftHeader - 1];
		result += characters[rightHeader - 1];
	} else {
		result = characters[input_num - 1];
	}
	return result;
 }
 


const proccessUndertimeMonitoring = function(employment, shifts, start_date, days, shift_type){
	let undertimeMonitoringObject = [];
	
	if(shifts) {
		if(shifts.length) {
			for(let shift in shifts) {
				let manager = "";
				let employementObject = employment.find(x => x.user_id === shifts[shift].id);

				if(employementObject.approving_organization === 'division') {
					manager = employementObject.division.manager.first_name+' '+ employementObject.division.manager.last_name;
				} else if(employementObject.approving_organization === 'department') {
					manager = employementObject.department.manager.first_name+' '+ employementObject.department.manager.last_name;
				} else if(employementObject.approving_organization === 'section') {
					manager = employementObject.section.supervisor.first_name+' '+ employementObject.section.supervisor.last_name;
				}

				let shiftObjects = shifts[shift].shifts;
				let undertimeObjects = shifts[shift].undertime
				
				let shiftID = "REST DAY"
				let checkIn = "REST DAY";
				let checkOut = "REST DAY";
				let undertimeHours = "0";
				let shiftObjectContainer = [];

				for(ctr = 0; ctr < days + 1; ctr++) {
					new_start_date = moment(start_date, "YYYY-MM-DD").add(ctr, 'days');
					shiftObjectContainer.push({
						date: moment(new_start_date).format("YYYY-MM-DD"),
						shiftID: shiftID,
						checkIn: checkIn,
						checkOut: checkOut,
						undertimeHours: undertimeHours,
					});
				}

				for(let shiftObject in shiftObjects) {
					let shift = shiftObjects[shiftObject];
					let shiftObjectMatch = shiftObjectContainer.find(x => x.date === shift.date);

					let shift_type_id = shift.type;
					let shift_type_object = shift_type.find(x => x.id === shift_type_id);

					if(shiftObjectMatch) {
						shiftObjectMatch.checkIn = shift.actual_check_in ? moment(shift.actual_check_in).utc().format('hh:mmA') : '--';
						shiftObjectMatch.checkOut = shift.actual_check_out ? moment(shift.actual_check_out).utc().format('hh:mmA') : '--';
						shiftObjectMatch.shiftID = shift_type_object ? shift_type_object.shift_id : "--";
					}
				}
				
				for(let undertimeObject in undertimeObjects) {
					let undertime = undertimeObjects[undertimeObject];
					
					let shiftObjectMatch = shiftObjectContainer.find(x => x.date === undertime.start_date);
					
					if(shiftObjectMatch) {
						shiftObjectMatch.undertimeHours = undertime.no_of_hours;
					}
				}
				
				undertimeMonitoringObject.push({
					employee_id : shifts[shift].employee_number,
					family_name : shifts[shift].last_name,
					first_name : shifts[shift].first_name,
					middle_name : shifts[shift].middle_name ? shifts[shift].middle_name : '--',
					suffix : shifts[shift].suffix ? shifts[shift].suffix : '--',
					position : employementObject.position.name,
					section : employementObject.section ? employementObject.section.section_name : '',
					department : employementObject.department ? employementObject.department.department_name : '',
					division : employementObject.division ? employementObject.division.name : '',
					name_of_supervisor_or_manager : manager,
					approved_shift_schedule: '--',
					shifts: shiftObjectContainer
				});
			}
		}
	}

	// console.log(undertimeMonitoringObject[0].shifts);
	return undertimeMonitoringObject;
}
