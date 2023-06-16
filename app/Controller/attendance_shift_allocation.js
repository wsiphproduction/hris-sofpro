const UserRole = require('../Helper/UserRole');
const { convertCSVToArray } = require('convert-csv-to-array');
const csv = require('csv-parser')
const fs = require('fs');
const dataForge = require('data-forge');
const formidable = require('formidable');
var { Parser } = require('json2csv');
const _ = require('underscore');
const $env = require('dotenv').config();
const Sequelize = require('sequelize');
const moment = require('moment-timezone');
moment.tz.setDefault('Asia/Manila');
const {
	Op,
	sequelize,
	UsersModel,
	BranchesModel,
	CompanyModel,
	TaxonomyModel,
	ShiftsModel,
	ConfigModel,
	ShiftType,
	WorkScheduleModel,
	Division,
	Department,
	Section,
	EmploymentsModel,
	TSSData,
	LeaveDateModel,
	LeavesModel,
	BusinessTripDate,
	BusinessTripsModel,

} = require('../../config/Sequelize');


exports.index = function (req, res) {

	let user = res.locals.user;

	UserRole.allRead(user).then(function (data) {
		usrRole = data;
		return UserRole.get_role(user, 'attendance-shift');
	}).then(function (data) {
		user_role = data;
		if (!(user_role.read || res.locals.isSupervisor > 0)) {
			res.render('Errors/403');
		} else {
			res.render('Attendance/ShiftAllocation/index', {
				route: 'shift-management',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});

}

exports.calendar = function (req, res) {
	let shortid = req.params.shortid;
	let user = res.locals.user;
	UsersModel.findOne({
		where: {
			shortid: shortid
		},
		attributes: ['shortid', 'first_name', 'last_name', 'employee_number']
	}).then(function (data) {
		userData = data;

		if (userData) {
			UserRole.allRead(user).then(function (data) {
				usrRole = data;
				res.render('Attendance/ShiftAllocation/calendar', {
					route: 'shift-management',
					usrRole: usrRole,
					userData: userData
				});
			});
		} else {
			res.render('Errors/404');
		}
	});
}

exports.yearCalendar = function (req, res) {
	let year = req.body.year;
	let shortid = req.params.shortid;
	UsersModel.findOne({
		where: {
			shortid: shortid
		},
		attributes: ['id', 'shortid', 'first_name', 'last_name', 'employee_number']
	}).then(function (data) {
		userData = data;
		if (userData) {
			let user_id = userData.id;
			ShiftsModel.findAll({
				where: {
					user_id: user_id,
					$and: [
						sequelize.where(sequelize.fn('YEAR', sequelize.col('date')), year)
					]
				},
				attributes: ['type', 'date', 'check_in', 'check_out', 'actual_check_in', 'actual_check_out', 'between_start', 'between_end', 'primary_status', 'backup_status', 'onsite']
			}).then(function (data) {
				record = data;
				record = JSON.parse(JSON.stringify(record));
				res.status(200).json({
					success: true,
					record: record
				});
			});
		}
	});
}

exports.store = function (req, res) {
	let uploadPath = './assets/uploads/shifts/';
	let form = new formidable.IncomingForm();
	let currentDay = moment().format('D');
	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data) {
		config = data;
		let json = config.json ? JSON.parse(config.json) : null;
		let cutoff = json.cutoff;
		let A = parseInt(cutoff.A_day);
		let A_from = parseInt(cutoff.A_from);
		let A_to = parseInt(cutoff.A_to);
		let B = parseInt(cutoff.B_day);
		let B_from = parseInt(cutoff.B_from);
		let B_to = parseInt(cutoff.B_to);
		let CUT_OFF_DATE = null;
		if (currentDay >= B_from && currentDay <= B_to) {
			let CURR_YEAR = moment().format('YYYY-MM');
			CUT_OFF_DATE = B_to + 1;
			CUT_OFF_DATE = CUT_OFF_DATE < 10 ? '0' + CUT_OFF_DATE : CUT_OFF_DATE;
			CUT_OFF_DATE = CURR_YEAR + '-' + CUT_OFF_DATE;
		} else {
			let CURR_YEAR = moment().add(1, 'months').format('YYYY-MM');
			if (currentDay < B_from) {
				CURR_YEAR = moment().format('YYYY-MM');
			}
			CUT_OFF_DATE = B_from;
			CUT_OFF_DATE = CUT_OFF_DATE < 10 ? '0' + CUT_OFF_DATE : CUT_OFF_DATE;
			CUT_OFF_DATE = CURR_YEAR + '-' + CUT_OFF_DATE;
		}

		form.parse(req, function (err, fields, files) {
			req.body = fields;
			let attachment = files.csv;
			let size = typeof attachment != 'undefined' ? attachment.size : 0;
			req.body.csv = size ? size : '';
			req.checkBody('csv').notEmpty().withMessage('The csv field is required.');
			let errors = req.validationErrors();
			if (errors) {
				res.status(422).json({
					success: false,
					errors
				});
			} else {
				let date = res.locals.moment().format('YYYY-MM-DD');
				let filename = 'SHFT-' + res.locals.moment().format('YYMMDDHHmmss') + '.csv';
				if (attachment && attachment.size > 0) {
					const results = [];
					let error = '';
					let path = attachment.path;
					let origFileName = attachment.name;
					let ext = origFileName.split(".");
					ext = ext.pop()
					// filename = filename + '.'+ ext;

					//we can add a function call to remove the duplicate row
					removeDuplicates(path, 'employee_number', 'date');
					
					fs.readFile(path, function (err, data) {
						fs.writeFile(uploadPath + filename, data, function (err) {
							if (err) {
								res.status(200).json({
									success: true,
									action: 'fetch',
									msg: 'Cant find ' + filename
								});
							} else {
								raw = fs.createReadStream('./assets/uploads/shifts/' + filename);
								raw.on('error', function (error) {
									res.status(200).json({
										success: true,
										action: 'fetch',
										msg: 'Cant find ' + filename
									});
								});
								raw.pipe(csv({
									mapHeaders: ({ header, index }) => header.toLowerCase()
								}))
									.on('headers', (headers) => {

										let header = headers.map(function (v) {
											return v.toLowerCase();
										});
										let find = header.filter(element => element > 'employee_number');
										// console.log(find);
										if (!(header.includes('employee_number') && header.includes('shift_id') && header.includes('date'))) {
											error = 'File import failed. Please follow the given format and try again.';
										}
									})
									.on('data', (data) => results.push(data))
									.on('end', async () => {
										if (error != '') {
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
										} else {
											if (results && results.length) {
												for (let i in results) {
													let employee_number = results[i].employee_number;
													let shift_id = results[i].shift_id;
													let date = results[i].date ? res.locals.moment(new Date(results[i].date)).format('YYYY-MM-DD') : null;
													//if date is greater than cutoff date
													if ($env.parsed.SHIFT_STRICT_CUTOFF == true) {
														if (date >= CUT_OFF_DATE) {
															await proccessAttendance(employee_number, shift_id, date);
														}
													} else {
														await proccessAttendance(employee_number, shift_id, date);
													}
												}
											}
											res.status(201).json({
												success: true,
												action: 'fetch',
												msg: 'Shifts has been updated.'
											});
										}
									});
							}
						});
					});
				} else {
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
	});
}

const proccessAttendance = function (employee_number, shift_id, date) {
	return sequelize.transaction({ isolationLevel: Sequelize.Transaction.ISOLATION_LEVELS.READ_COMMITTED }, async (t) => {
		if (employee_number && date && shift_id) {
			let employee = await UsersModel.findOne({
				where: {
					employee_number: employee_number
				},
				include: [
					{
						model: WorkScheduleModel,
						attributes: ['id', 'break_type'],
						lock: true // lock the work schedule row
					}
				],
				attributes: ['id', 'first_name', 'last_name', 'employee_number'],
				raw: false,
				lock: true // lock the user row
			}, { transaction: t });
			if (employee) {
				let shift_type = await ShiftType.findOne({
					where: {
						shift_id: shift_id
					},
					raw: true,
					lock: true // lock the shift type row
				}, { transaction: t });
				if (shift_type) {
					if (!employee.work_schedule || (employee.work_schedule && employee.work_schedule.break_type != 5)) { // Set as temporary fix (5) since weekender automatic schedule is not supported yet
						let user_id = employee.id;
						let check_in = shift_type.time_in ? moment(shift_type.time_in).utc().format('HH:mm:ss') : null;
						let check_out = shift_type.time_out ? moment(shift_type.time_out).utc().format('HH:mm:ss') : null;
						let shift_length = shift_type.num_hours || null;
						let type = shift_type.shift_id || null;
						let break_hour = shift_type.break_hours || 0;
						if ((date && check_in && check_out) || (date && type == 'NONE')) {
							let where = {
								user_id: user_id,
								date: date
							}
							let shift = await ShiftsModel.findOne({
								where: where,
								lock: true // lock the shift row
							}, { transaction: t });
							if (type != '') {
								let reqData = {
									date: date,
									check_in: check_in,
									check_out: check_out,
									shift_length: shift_length,
									shift_type: type,
									break_hour: break_hour
								}
								if (!shift) {
									reqData.user_id = user_id;
									let newShift = await ShiftsModel.create(reqData, { transaction: t });
									let insertId = newShift.id;
									let tssReqData = {
										user_id: user_id,
										date: date,
										shift_id: insertId
									}
									await TSSData.create(tssReqData, { transaction: t });
								} else {
									await ShiftsModel.update(reqData, {
										where: {
											id: shift.id
										},
										transaction: t
									});
									if (shift.id != null) {// `?` removed
										await TSSData.update({
											date: date
										}, {
											where: {
												shift_id: shift.id
											},
											transaction: t
										});
									}
								}
							}
                        }
                    }
                }
            }
        }
    });
}

const removeDuplicates = function(filename, column1, column2) {
	// Load data from input CSV file.
	const data = dataForge.fromCSV(fs.readFileSync(filename).toString());
  
	// Remove duplicates in the specified columns.
	const distinctData = data.distinct(row => row[column1] + '|' + row[column2]);
  
	// Write the distinct data to the output CSV file.
	fs.writeFileSync(filename, distinctData.toCSV());
}

exports.initForm = function (req, res) {
	let session = req.session;
	let user = res.locals.user;
	let isHRGeneralist = res.locals.isHRGeneralist;
	CompanyModel.findAll({
		order: [
			['name', 'asc']
		]
	}).then(function (data) {
		company = data;
		return Division.findAll({
			order: [
				['name', 'asc']
			]
		});
	}).then(function (data) {
		division = data;
		return Department.findAll({
			order: [
				['department_name', 'asc']
			]
		});
	}).then(function (data) {
		department = data;
		return ConfigModel.findOne({
			where: {
				id: 1
			}
		});
	}).then(function (data) {
		config = data;
		jsonConfig = config.json ? JSON.parse(config.json) : null;
		return Section.findAll({
			order: [
				['section_name', 'asc']
			]
		});
	}).then(function (data) {
		section = data;
		return UserRole.get_role(user, 'attendance-shift').then(function (data) {
		user_role = data;
		let user_logged_id = user.id
			res.status(200).json({
				success: true,
				company: company,
				division: division,
				department: department,
				config: jsonConfig,
				section: section,
				session: session,
				user_role: user_role,
				user_logged_id: user_logged_id,
				isHRGeneralist: isHRGeneralist
			});
		});
	});
}

exports.fetch = function (req, res) {
	let user = res.locals.user;
	let isSupervisor = res.locals.isSupervisor;
	let isHRGeneralist = res.locals.isHRGeneralist
	let session = req.session;

	let date = req.body.date;
	let company = req.body.company ? req.body.company : '';
	let division = req.body.division ? req.body.division : '';
	let department = req.body.department ? req.body.department : '';
	let section = req.body.section ? req.body.section : '';
	let key 	= req.body.key;

	let userId = req.body.user;
	let limit = parseInt(req.body.limit);
	let page = req.body.page;
	let offset = (parseInt(page) - 1) * parseInt(limit);

	let startOf = res.locals.moment(date).startOf('month').format('YYYY-MM-DD');
	startOf = new Date(startOf);
	let endOf = res.locals.moment(date).endOf('month').format('YYYY-MM-DD');
	endOf = new Date(endOf);
	let whereUser = {}
	let whereComp = {}
	let whereEmployment = {};

	let config = null;
	let employment = null;
	let user_role = null;
	let users = null;

	if (company) {
		whereEmployment.company_id = company;
	}
	if (division) {
		whereEmployment.division_id = division;
	}
	if (department) {
		whereEmployment.department_id = department;
	}
	if (section) {
		whereEmployment.section_id = section;
	}

	if (userId) {
		whereUser.id = userId;
	}

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data) {
		config = data;
		json = config.json ? JSON.parse(config.json) : null;

		let cutoff = json.cutoff;
		let month_date = req.body.month_date;
		let period = req.body.period;

		// if (isSupervisor) {
		// 	if (session.user.default_month_date != null){
		// 		month_date = session.user.default_month_date;
		// 	}
		// 	if (session.user.default_period != null){
		// 		period = session.user.default_period;
		// 	}	
		// }

		if (month_date && period) {
			month_date = res.locals.moment(month_date).format('YYYY-MM');
			if (period == 'A') {
				start = month_date + '-' + cutoff.A_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date + '-' + cutoff.A_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
			} else {
				start = month_date + '-' + cutoff.B_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date + '-' + cutoff.B_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
			}

			startOf = new Date(start);
			endOf = new Date(end);
		}
		
		ConfigModel.findOne({
			where: {
				id: 1
			}
		}).then(function (data) {
			config = data;
			return EmploymentsModel.findAll({
				where: whereEmployment,
				attributes: ['id', 'user_id'],
				raw: true
			});
		}).then(function (data) {
			employment = data;
			return UserRole.get_role(user, 'attendance-shift');

		}).then(function (data) {
			user_role = data;
			let user_id = [];
			if (employment && employment.length) {
				for (let i in employment) {
					user_id.push(employment[i].user_id);
				}
			}
			user_id = [...new Set(user_id)];

			if(key) {
				whereUser = {
					resignation_date:  {
						[Op.or] : {
							[Op.gte]: startOf,
							[Op.eq]: null
						}
					},
					[Op.and]: [
						{
							[Op.or]: [
								{
									secretary_id: user.id
								}, {
									approver_id: user.id
								}, {
									secondary_approver_id: user.id
								},{
									alternate_secretary: user.id
								}
							]
						},
						{
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
					]
				}
				console.log("whereUser111: ", whereUser)
			} else {
				if (user_role.modify) {
					if (!_.isEmpty(whereEmployment)) {
						whereUser.id = {
							[Op.in]: user_id
						}
					}
				} else if (isSupervisor > 0) {
					whereUser[Op.or] = [
						{
							secretary_id: user.id
						}, {
							approver_id: user.id
						}, {
							secondary_approver_id: user.id
						},{
							alternate_secretary: user.id
						}
					]
				}
				// Resigned employees should not be displayed
				whereUser.resignation_date = {
					[Op.or] : {
						[Op.gte]: startOf,
						[Op.eq]: null
					}
				}
			}
			if (isHRGeneralist > 0 && Object.keys(whereEmployment).length === 0) {
				whereUser = {
					hr_generalist_id: user.id,
				}
			}

			return UsersModel.findAndCountAll({
				where: whereUser,
				offset: offset,
				limit: limit,
				order: [
					['last_name', 'asc']
				],
				attributes: ['id', 'first_name', 'last_name', 'shortid', 'employee_number'],
				include: [
					{
						model: ShiftsModel,
						where: {
							date: {
								$between: [startOf, endOf]
							}
						},
						separate: true,
						attributes: [
							'id',
							'user_id',
							'date',
							'check_in',
							'check_out',
							'actual_check_in',
							'actual_check_out',
							'type',
							'between_start',
							'between_end',
							'shift_length',
							'onsite'
						]
					}, {
						model: LeaveDateModel,
						where: {
							date: {
								$between: [startOf, endOf]
							}
						},
						include: [
							{
								model: LeavesModel,
								where: {
									primary_status: 2
								}
								// as: 'leave_info'
							}
						],
						separate: true,
					}, {
						model: BusinessTripDate,
						where: {
							date: {
								$between: [startOf, endOf]
							}
						},
						include: [
							{
								model: BusinessTripsModel,
								where: {
									primary_status: 2
								}
							}
						],
						separate: true,
					}
				],
			});
		}).then(function (data) {
			users = data;
			numrows = users.count;
			count = 0;
			if (limit < numrows) {
				count = numrows / limit;
				count = Math.ceil(count);
			} else {
				count = 0;
			}
			json = config.json ? JSON.parse(config.json) : null;
			res.status(200).json({
				success: true,
				config: json,
				session: session,
				records: users.rows,
				isHRGeneralist: isHRGeneralist,
				count: count
			});

		});
	});
}

exports.export = function (req, res) {
	let user = res.locals.user;
	let isSupervisor = res.locals.isSupervisor;

	let date = new Date(req.query.date);
	let company = req.query.company ? req.query.company : '';
	let division = req.query.division ? req.query.division : '';
	let department = req.query.department ? req.query.department : '';
	let section = req.query.section ? req.query.section : '';

	let userId = req.query.user;
	let limit = parseInt(req.query.limit);
	let page = req.query.page;
	let offset = (parseInt(page) - 1) * parseInt(limit);

	// let startOf = res.locals.moment(date).startOf('month').format('YYYY-MM-DD');
	// startOf = new Date(startOf);
	// let endOf = res.locals.moment(date).endOf('month').format('YYYY-MM-DD');
	// endOf = new Date(endOf);
	let whereUser = {}
	let whereComp = {}
	let whereEmployment = {};

	let config = null;
	let employment = null;
	let user_role = null;
	let users = null;

	if (company) {
		whereEmployment.company_id = company;
	}
	if (division) {
		whereEmployment.division_id = division;
	}
	if (department) {
		whereEmployment.department_id = department;
	}
	if (section) {
		whereEmployment.section_id = section;
	}

	if (userId) {
		whereUser.id = userId;
	}
	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data) {
		config = data;
		return EmploymentsModel.findAll({
			where: whereEmployment,
			attributes: ['id', 'user_id'],
			raw: true
		});
	}).then(function (data) {
		employment = data;
		return UserRole.get_role(user, 'attendance-shift');

	}).then(function (data) {
		user_role = data;
		let user_id = [];
		if (employment && employment.length) {
			for (let i in employment) {
				user_id.push(employment[i].user_id);
			}
		}
		user_id = [...new Set(user_id)];

		if (user_role.read) {
			if (!_.isEmpty(whereEmployment)) {
				whereUser.id = {
					[Op.in]: user_id
				}
			}
		} else if (isSupervisor > 0) {
			whereUser[Op.or] = [
				{
					approver_id: user.id
				}, {
					secondary_approver_id: user.id
				},
			]
		}

		return UsersModel.findAndCountAll({
			where: whereUser,
			offset: offset,
			limit: limit,
			order: [
				['first_name', 'asc']
			],
			attributes: ['id', 'first_name', 'last_name', 'shortid', 'employee_number'],
			include: [
				{
					model: ShiftsModel,
					where: {
						date: {
							$between: [startOf, endOf]
						}
					},
					separate: true,
					attributes: [
						'id',
						'user_id',
						'date',
						'check_in',
						'check_out',
						'actual_check_in',
						'actual_check_out',
						'type',
						'between_start',
						'between_end',
						'shift_length',
						'onsite'
					]
				}, {
					model: LeaveDateModel,
					where: {
						date: {
							$between: [startOf, endOf]
						}
					},
					include: [
						{
							model: LeavesModel,
							where: {
								primary_status: 2
							}
							// as: 'leave_info'
						}
					],
					separate: true,
				}
			],
		});
	}).then(function (data) {
		users = data;
		numrows = users.count;
		count = 0;
		if (limit < numrows) {
			count = numrows / limit;
			count = Math.ceil(count);
		} else {
			count = 0;
		}
		json = config.json ? JSON.parse(config.json) : null;

		let startOf = moment(date).startOf('month').format('YYYY-MM-DD');
		startOf = new Date(startOf);
		let endOf = moment(date).endOf('month').format('YYYY-MM-DD');
		endOf = new Date(endOf);
		let dateArray = [];
		let fields = ['Employee'];
		let arrayData = [];
		for (var d = startOf; d <= endOf; d.setDate(d.getDate() + 1)) {
			let dd = moment(new Date(d)).format('YYYY-MM-DD')
			fields.push(moment(dd).format('ddd, MMM D, YYYY'));
			dateArray.push(dd);
		}

		let records = users.rows;
		if (records.length) {
			for (let r in records) {
				let schedule = records[r].shifts;

				let obj = {
					Employee: records[r].first_name + ' ' + records[r].last_name
				}
				for (let i in dateArray) {

					let key = moment(dateArray[i]).format('ddd, MMM D, YYYY');
					let findDate = moment(dateArray[i]).format('YYYY-MM-DD');
					let filter = schedule.filter(obj => obj.date == findDate);
					filter = filter && filter.length ? filter[0] : '';
					filter = filter ? moment(filter.check_in).utc().format('hh:mmA') + ' - ' + moment(filter.check_out).utc().format('hh:mmA') : '-';
					obj[key] = filter;
				}
				arrayData.push(obj);
			}
		}

		let filename = 'Shift Management_' + moment(date).format('YYYYMMDD');
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(arrayData);
		res.attachment(filename + '.csv');
		res.status(200).send(csv);

	});
}

