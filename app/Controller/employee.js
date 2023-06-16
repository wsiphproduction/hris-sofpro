const bcrypt = require('bcryptjs');
const shortid = require('shortid');
const Global = require('../Models/Global');
const GlobalHelper = require('../Helper/GlobalHelper');
const ImportEmployee = require('../Helper/ImportEmployee');
const UserRole = require('../Helper/UserRole');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const fs = require('fs');
const _ = require('underscore');
const { convertCSVToArray } = require('convert-csv-to-array');
const csv = require('csv-parser');
var { Parser } = require('json2csv');

const {
	Op,
	EducationsModel,
	CountryModel,
	UsersModel,
	CompanyModel,
	TaxonomyModel,
	EmploymentsModel,
	BranchesModel,
	ApproversModel,
	RoleModel,
	WorkScheduleModel,
	SalaryModel,
	LeaveCreditPolicyModel,
	Location,
	Division,
	Department,
	Section,
	Position,
	PositionCategory,
	PositionClassification,
	WorkArea,
	EmployeeType,
	BiometricNumberModel,
	BiometricModel,
	AddressModel
} = require('../../config/Sequelize');


exports.index = async (req, res) => {
	let user = res.locals.user;
	UserRole.get_role(user, 'employee-list').then(function (data) {
		user_role = data;
		if (!user_role.read) {
			res.render('Errors/404');
		} else {
			UserRole.get_role(user, 'employee-role').then(function (data) {
				empRole = data;
				return CompanyModel.findAll({
					where: {
						status: 1
					},
					order: [
						['name', 'ASC']
					],
				});
			}).then(function (data) {
				company = data;

				return UserRole.allRead(user);
			}).then(function (data) {
				usrRole = data;
				res.render('Employee/index', {
					company: company,
					user_role: user_role,
					usrRole: usrRole,
					empRole: empRole,
					route: 'employee',
				});
			});
		}
	});
}

exports.import = function (req, res) {
	let user = res.locals.user;
	let result = [];
	let uploadPath = './assets/uploads/imports/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let attachment = "";
		let size = "";
		let operation = "";
		if(files.attachment) { 
			attachment = files.attachment;
			size = attachment.size;
			operation = req.body.operation;
			req.body.file = size ? size : '';
		}
		req.checkBody('operation').notEmpty().withMessage('The operation field is required.');
		req.checkBody('file').notEmpty().withMessage('The file field is required.');
		let errors = req.validationErrors();
		if (errors) {
			res.status(422).json({
				success: false,
				errors
			});
		} else {
			let error = '';
			try {
				let date = res.locals.moment().format('YYYY-MM-DD');
				let filename = res.locals.moment().format('YYYYMMDDHHmmss');
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
				ext = ext.pop()
				filename = filename + '.' + ext;
				if (fields.operation == 'insert_employment') {
					fs.readFile(path, { encoding: 'binary' }, function (err, data) {
						fs.writeFile(uploadPath + filename, data, function (err) {
							if (err) console.log(err);
							fs.unlink(path, function (err) {

							});
							raw = fs.createReadStream(uploadPath + filename);
							raw.on('error', function () {
								res.status(200).json({
									success: true,
									action: 'fetch',
									msg: 'Cant find ' + filename
								});
							});
							raw.pipe(csv({
								mapHeaders: ({
									header,
									index
								}) => header.toLowerCase()
							}))
								.on('headers', (headers) => {
									let header = headers.map(function (v) {
										return v.toLowerCase();
									});
									let arrayHeader = [
										'employee_number',
										'company',
										'division',
										'department',
										'section',
										'position',
										'position_classification',
										'position_category',
										'location',
										'work_area',
										'approving_organization',
										'effective_date',
										'biometric_id',
										'biometric_number',
										'approver_number',
										'secretary_number',
									];
									//console.log(arrayHeader);
									let allFounded = arrayHeader.every(ai => header.includes(ai));

									if (!allFounded) {
										error = 'File import failed. Please follow the given format and try again.';
									}
								})
								.on('data', (data) => result.push(data))
								.on('end', () => {
									if (!error) {
										if (result.length) {
											// console.log(result);
											for (let i in result) {
												let company_name = result[i].company.trim()
												let division_name = result[i].division.trim()
												let department_name = result[i].department.trim()
												let section_name = result[i].section.trim()
												let position_name = result[i].position.trim()
												let position_classification_name = result[i].position_classification.trim()
												let position_category_name = result[i].position_category.trim()
												let location_name = result[i].location.trim()
												let work_area_name = result[i].work_area.trim()
												let error_message = ""
												
												UsersModel.findOne({
													where: {
														[Op.or]: [
															{
																employee_number: result[i].employee_number
															},{
																old_employee_number: result[i].employee_number
															}
														]
													},
												}).then(function (data) {
													user = data;
													
													if(user != null) {
														CompanyModel.findOne({
															where: {
																name: company_name
															},
														}).then(function (data) {
															company = data;
															if(!company && company_name !='') {
																affected_row = parseInt(i) + 1
																error_message = "ERRORss! \"" + company_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																returnError(res, error_message)
																return
															}
															
															// if(company) {
															// 	let code = company.code;
															// 	let now = res.locals.moment(Date.now()).format('MM/DD/YYYY');
															// 	let year = result[i].effective_date ? res.locals.moment(new Date(result[i].effective_date)).format('YYYY') : res.locals.moment(new Date(now)).format('YYYY');
															// 	let employee_number = GlobalHelper.generate_employee_number(code, year, user.id);
															// 	let userData = {
															// 		employee_number: employee_number
															// 	}
															// 	if (user.employee_number == null || user.employee_number == '') {
															// 		UsersModel.update(userData, {
															// 			where: {
															// 				id: user.id
															// 			}
															// 		});
															// 	}
															// }
															Division.findOne({
																where: {
																	name: division_name
																},
															}).then(function (data) {
																division = data;
																if(!division && division_name !='') {
																	affected_row = parseInt(i) + 1
																	error_message = "ERROR! \"" + division_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																	returnError(res, error_message)
																	return
																}
																Department.findOne({
																	where: {
																		department_name: department_name
																	},
																}).then(function (data) {
																	department = data;
																	if(!department && department_name !='') {
																		affected_row = parseInt(i) + 1
																		error_message = "ERROR! \"" + department_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																		returnError(res, error_message)
																		return
																	}
																	Section.findOne({
																		where: {
																			section_name: section_name
																		},
																	}).then(function (data) {
																		section = data;
																		if(!section && section_name !='') {
																			affected_row = parseInt(i) + 1
																			error_message = "ERROR! \"" + section_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																			returnError(res, error_message)
																			return
																		}
																		
																		Position.findOne({
																			where: {
																				name: position_name
																			},
																		}).then(function (data) {
																			position = data;
																			if(!position && position_name !='') {
																				affected_row = parseInt(i) + 1
																				error_message = "ERROR! \"" + position_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																				returnError(res, error_message)
																				return
																			}
																			PositionClassification.findOne({
																				where: {
																					name: position_classification_name
																				},
																			}).then(function (data) {
																				position_classification = data;
																				if(!position_classification && division_name !='') {
																					affected_row = parseInt(i) + 1
																					error_message = "ERROR! \"" + position_classification_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																					returnError(res, error_message)
																					return
																				}
																				PositionCategory.findOne({
																					where: {
																						name: position_category_name
																					},
																				}).then(function (data) {
																					position_category = data;
																						if(!position_category && division_name !='') {
																						affected_row = parseInt(i) + 1
																						error_message = "ERROR! \"" + position_category_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																						returnError(res, error_message)
																						return
																					}
																					Location.findOne({
																						where: {
																							location: location_name
																						},
																					}).then(function (data) {
																						location = data;
																						if(!location && division_name !='') {
																							affected_row = parseInt(i) + 1
																							error_message = "ERROR! \"" + location_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																							returnError(res, error_message)
																							return
																						}
																						WorkArea.findOne({
																							where: {
																								name: work_area_name
																							},
																						}).then(function (data) {
																							work_area = data;
																							if(!work_area && division_name !='') {
																								affected_row = parseInt(i) + 1
																								error_message = "ERROR! \"" + work_area_name + "\" does not exist in database. \n\n\n Affected row: Line " + affected_row
																								returnError(res, error_message)
																								return
																							}

																							let reqData = {
																								user_id: user.id,
																								company_id: company ? company.id : '',
																								division_id: division ? division.id : '',
																								department_id: department ? department.id : '',
																								section_id: section ? section.id : '',
																								position_id: position ? position.id : '',
																								position_classification_id: position_classification ? position_classification.id : '',
																								position_category_id: position_category ? position_category.id : '',
																								approving_organization: result[i].approving_organization ? result[i].approving_organization : '',
																								work_area_id: work_area ? work_area.id : '',
																								location_id: location ? location.id : '',
																								date_entry: res.locals.moment(result[i].effective_date).format('YYYY-MM-DD'),
																								status: 1
																							}
																							EmploymentsModel.create(reqData).then(data => {
																								UsersModel.findOne({
																									where: {
																										employee_number: result[i].approver_number.trim()
																									}
																								}).then(function (data) {
																									approver = data;
																									UsersModel.findOne({
																										where: {
																											employee_number: result[i].hr_generalist_number.trim()
																										}
																									}).then(function (data) {
																										hr_generalist = data;
																										UsersModel.findOne({
																											where: {
																												employee_number: result[i].secretary_number.trim()
																											}
																										}).then(function (data) {
																											secretary = data;
																											let userData = {
																												approver_id: approver ? approver.id : null,
																												secretary_id: secretary ? secretary.id : null,
																												hr_generalist_id: hr_generalist ? hr_generalist.id : null,
																											}
																											UsersModel.update(userData, {
																												where: {
																													id: user.id
																												}
																											}).then(function (data) {
																												BiometricModel.findOne({
																													where: {
																														id: result[i].biometric_id
																													}
																												}).then(function (data) {
																													biometrics = data;
																													if(!biometrics) {
																														affected_row = parseInt(i) + 1
																														error_message = "ERROR! Biometric ID: \"" + result[i].biometric_id + "\" Does not exist. \n\n\n Affected row: Line " + affected_row
																														returnError(res, error_message)
																														return
																													}
																													let biometricData = {
																														user_id: user.id,
																														biometric_id: result[i].biometric_id,
																														biometric_number: result[i].biometric_number
																													}
																													BiometricNumberModel.create(biometricData);
																													res.status(200).json({
																														success: true,
																														action: 'close',
																														msg: 'Record has been successfully updated.'
																													});
																												});
																											});
																										});
																									});
																								});
																							});
																						});
																					});
																				});
																			});
																		});
																	});
																});
															});
														});
													} else {
														console.log("User does not exist.")
														returnError(res, "User does not exist.")
														return
													}
												});
											}
										}
									} else {
										var errors = [{
											param: 'file',
											msg: error
										}]
										res.status(422).json({
											success: false,
											errors
										});
									}
								});
						});
					});
				} else {
					fs.readFile(path, { encoding: 'binary' }, function (err, data) {
						fs.writeFile(uploadPath + filename, data, function (err) {
							if (err) console.log(err);
							fs.unlink(path, function (err) {

							});
							raw = fs.createReadStream(uploadPath + filename);
							raw.on('error', function () {
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
									let arrayHeader = [
										'first_name',
										'last_name',
										'birthdate',
										'marital_status',
									];
									if (operation == 'update') {
										arrayHeader.push('id');
									}
									//console.log(arrayHeader);
									let allFounded = arrayHeader.every(ai => header.includes(ai));

									if (!allFounded) {
										error = 'File import failed. Please follow the given format and try again.';
									}
								})
								.on('data', (data) => result.push(data))
								.on('end', () => {
									if (!error) {
										if (result.length) {
											let designations = [];
											let departments = [];
											let users = [];
											let approvers = [];
											// console.log(result);
											for (let i in result) {
												shortid.characters('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$-');
												var salt = bcrypt.genSaltSync(10);
												let sid = shortid.generate();
												let uID = operation == 'insert' ? '' : result[i].id;
												let gender = result[i].gender ? result[i].gender.toLowerCase() : 'M';
												gender = gender == 'm' || gender == 'male' ? 'Male' : 'Female';
												// let department = result[i].department ? result[i].department : '';
												// let designation = result[i].designation ? result[i].designation : '';
												let employee_number = result[i].employee_id ? result[i].employee_id : '';
												let password = result[i].password ? result[i].password : '';
												password = bcrypt.hashSync(password, salt);
												let setStatus = 1;
												let marital_status = result[i].marital_status ? result[i].marital_status : '';
												marital_status = marital_status != '' ? marital_status.charAt(0).toUpperCase() + marital_status.slice(1).toLowerCase() : '';
												marital_status = marital_status ? marital_status : 'Single';
												let status = result[i].status;
												status = status ? status.toLowerCase() : '';
												if (status == 'active') {
													setStatus = 1;
												} else if (status == 'inactive') {
													setStatus = 2;
												} else if (status == 'resigned') {
													setStatus = 3;
												} else if (status == 'terminated') {
													setStatus = 4;
												}

												let userData = {
													first_name: result[i].first_name ? result[i].first_name : '',
													middle_name: result[i].middle_name ? result[i].middle_name : '',
													last_name: result[i].last_name ? result[i].last_name : '',
													suffix: result[i].suffix ? result[i].suffix : '',
													nick_name: result[i].nick_name ? result[i].nickname : '',
													gender: gender,
													birthdate: result[i].birthdate ? res.locals.moment(new Date(result[i].birthdate)).format('YYYY-MM-DD') : '',
													present_address: result[i].current_address ? result[i].current_address : '',
													permanent_address: result[i].permanent_address ? result[i].permanent_address : '',
													marital_status: marital_status,
													contact_number: result[i].contact_number ? result[i].contact_number : '',
													email: result[i].email ? result[i].email : '',
													status: setStatus,
													sss_number: result[i].sss_number ? result[i].sss_number : '',
													pagibig_number: result[i].pagibig_number ? result[i].pagibig_number : '',
													tin_number: result[i].tin_number ? result[i].tin_number : '',
													philhealth_number: result[i].philhealth_number ? result[i].philhealth_number : '',
													employee_type: 0,
													date_entry: result[i].date_hired ? res.locals.moment(new Date(result[i].date_hired)).format('YYYY-MM-DD') : null,
													street: result[i].street ? result[i].street : '',
													barangay: result[i].barangay ? result[i].barangay : '',
													city: result[i].city ? result[i].city : '',
													province: result[i].province ? result[i].province : '',
													region: result[i].region ? result[i].region : '',
													employee_number: employee_number,
													old_employee_number: result[i].old_employee_number ? result[i].old_employee_number : '',
												}
												if (result[i].password) {
													userData.password = password;
												}

												if (operation == 'insert') {
													userData.shortid = employee_number ? employee_number : sid;
													userData.user_role = 4;
													userData.nationality = 177;
												}
												if (uID) {
													// console.log(result[i].date_hired);
													UsersModel.count({
														where: {
															id: uID
														}
													}).then(data => {
														count = data;
														if (count > 0) {
															UsersModel.update(userData, {
																where: {
																	id: uID
																}
															});
														} else {
															UsersModel.create(userData);
														}
													})
												} else {
													UsersModel.create(userData);
												}
											}

										}


										res.status(200).json({
											success: true,
											action: 'close',
											msg: 'New record has been successfully saved.'
										});
									} else {
										var errors = [
											{
												param: 'file',
												msg: error
											}
										]
										res.status(422).json({
											success: false,
											errors
										});
									}
								});
						});
					});
				}

			} catch (error) {
				console.log(error);
			}
		}
	});
	/*
	let filename = 'employee_format.csv';
	let uploadPath = './assets/uploads/';
	let result = [];
	
	*/
}


exports.export = function (req, res) {
	let filename = res.locals.moment().format('MMDDYYYYhmA');
	let user = res.locals.user;
	let company = req.query.company ? req.query.company : '';
	let division = req.query.division ? req.query.division : '';
	let department = req.query.department ? req.query.department : '';
	let section = req.query.section ? req.query.section : '';
	let where = {};
	let whereUser = {};
	//console.log(start_date, end_date);
	if (company) {
		where.company_id = company;
	}
	if (division) {
		where.division_id = division;
	}
	if (department) {
		where.department_id = department;
	}
	if (section) {
		where.section_id = section;
	}
	let users = [];
	let user_id = [];
	EmploymentsModel.findAll({
		where: where,
		attributes: ['id', 'user_id'],
		raw: true
	}).then(function (data) {
		employment = data;
		let user_id = [];
		if (employment && employment.length) {
			for (let i in employment) {
				user_id.push(employment[i].user_id);
			}
		}
		user_id = [...new Set(user_id)];

		if (!_.isEmpty(where)) {
			whereUser.id = {
				[Op.in]: user_id
			}
		}
		return UsersModel.findAll({
			where: whereUser,
			order: [
				['first_name', 'asc']
			],
			raw: true
		});
	}).then(function (data) {
		users = data;
		if (users) {
			let fields = [
				'id',
				'employee_id',
				'first_name',
				'middle_name',
				'last_name',
				'suffix',
				'nickname',
				'gender',
				'birthdate',
				'street',
				'barangay',
				'city',
				'province',
				'region',
				'permanent_address',
				'marital_status',
				'contact_number',
				'email',
				'password',
				'sss_number',
				'pagibig_number',
				'tin_number',
				'philhealth_number',
				'date_hired',
				'status',
				'old_employee_number'
			];

			let userData = [];
			for (let i in users) {
				let setStatus = 1;
				if (users[i].status == 1) {
					setStatus = 'Active';
				} else if (users[i].status == 2) {
					setStatus = 'Inactive';
				} else if (users[i].status == 3) {
					setStatus = 'Resigned';
				} else if (users[i].status == 4) {
					setStatus = 'Terminated';
				}
				userData.push({
					id: users[i].id,
					first_name: users[i].first_name ? users[i].first_name.replace(/[^a-zA-Z0-9]/g, '') : '',
					middle_name: users[i].middle_name ? users[i].middle_name.replace(/[^a-zA-Z0-9]/g, '') : '',
					last_name: users[i].last_name ? users[i].last_name.replace(/[^a-zA-Z0-9]/g, '') : '',
					suffix: users[i].suffix ? users[i].suffix.replace(/[^a-zA-Z0-9]/g, ' ') : '',
					nickname: users[i].nickname ? users[i].nickname.replace(/[^a-zA-Z0-9]/g, '') : '',
					gender: users[i].gender,
					birthdate: users[i].birthdate ? res.locals.moment(users[i].birthdate).format('YYYY-MM-DD') : '',
					street: users[i].street,
					barangay: users[i].barangay,
					city: users[i].city,
					province: users[i].province,
					region: users[i].region,
					permanent_address: users[i].permanent_address ? users[i].permanent_address.replace(/[^a-zA-Z0-9]/g, ' ') : '',
					marital_status: users[i].marital_status,
					contact_number: users[i].contact_number,
					email: users[i].email,
					password: '',
					sss_number: users[i].sss_number,
					pagibig_number: users[i].pagibig_number,
					tin_number: users[i].tin_number,
					philhealth_number: users[i].philhealth_number,
					date_hired: users[i].date_entry ? res.locals.moment(users[i].date_entry).format('MM/DD/YYYY') : '',
					status: setStatus,
					old_employee_number: users[i].old_employee_number,
				});
			}

			const json2csvParser = new Parser({ fields });
			const csv = json2csvParser.parse(userData);
			res.attachment(filename + '.csv');
			res.status(200).send(csv);
			// res.header("Content-Type",'application/json');
			// res.send(JSON.stringify(userData, null, 4));
		} else {
			res.render('Errors/404');
		}
	});
}

exports.get = function (req, res) {
	let company = req.body.company;
	let location = req.body.location;
	let division = req.body.division;
	let department = req.body.department;
	let section = req.body.section;
	let position = req.body.position;
	let key 	= req.body.key;

	let status = req.body.status;
	let limit = parseInt(req.body.limit);
	let page = req.body.page;
	let offset = (parseInt(page) - 1) * parseInt(limit);

	let where = {}
	if (company) {
		where.company_id = company;
	}
	if (location) {
		where.location_id = location;
	}
	if (division) {
		where.division_id = division;
	}
	if (department) {
		where.department_id = department;
	}
	if (section) {
		where.section_id = section;
	}
	if (position) {
		where.position_id = position;
	}
	let whereUser = {}
	
	if (status) {
		whereUser.status = status;
	}
	EmploymentsModel.findAll({
		where: where,
		attributes: ['id', 'user_id'],
		raw: true
	}).then(data => {
		employment = data;
		let user_id = [];
		if (employment && employment.length) {
			for (let i in employment) {
				user_id.push(employment[i].user_id);
			}
		}
		user_id = [...new Set(user_id)];

		if (!_.isEmpty(where)) {
			whereUser.id = {
				[Op.in]: user_id
			}
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
		
		UsersModel.findAndCountAll({
			where: whereUser,
			limit: limit,
			offset: offset,
			include: [
				{
					model: EmploymentsModel,
					where: where,
					limit: 1,
					separate: true,
					required: false,
					order: [
						['id', 'desc']
					],
					include: [
						{
							model: CompanyModel,
							as: 'company'
						}, {
							model: Division,
							as: 'division'
						},
						{
							model: Department,
							as: 'department',
						},
						{
							model: Section,
							as: 'section',
						},
						{
							model: Position,
							as: 'position'
						},
						// {
						// 	model: Location
						// }
					]
				}
			],
			order: [
				['last_name', 'asc']
			]
		}).then(data => {
			users = data;
			numrows = users.count;
			count = 0;
			if (limit < numrows) {
				count = numrows / limit;
				count = Math.ceil(count);
			} else {
				count = 0;
			}
			res.status(200).json({
				success: true,
				records: users.rows,
				count: count
			});
		})
	});
}

exports.store = async (req, res) => {
	let user_id = req.session.user ? req.session.user.id : null;
	let validate = [];
	req.checkBody('first_name').notEmpty().withMessage('The first name field is required.');
	req.checkBody('last_name').notEmpty().withMessage('The last name field is required.');
	req.checkBody('gender').notEmpty().withMessage('The gender field is required.');
	req.checkBody('birthday').notEmpty().withMessage('The birthday field is required.');
	req.checkBody('marital_status').notEmpty().withMessage('The marital status field is required.');
	req.checkBody('nationality').notEmpty().withMessage('The nationality field is required.');
	req.checkBody('email').notEmpty().isEmail().withMessage('The email is required and should be valid.');
	let email = req.body.email;

	if (email != '' && await Global._validate('UsersModel:email,' + email + ':null,null')) {
		validate.push({
			'param': 'email',
			'msg': 'This email is already registered.'
		});
	}

	let errors = req.validationErrors();

	if (errors || validate.length) {

		if (errors && validate.length) {
			errors = errors.concat(validate);
		} else if (!errors && validate.length) {
			errors = validate;
		} else if (errors && !validate.length) {
			errors = errors;
		}

		res.status(422).json({
			success: false,
			errors
		});

	} else {

		shortid.characters('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$-');

		let bday = req.body.birthday;

		let birthday = res.locals.moment(req.body.birthday).format('YYYY-MM-DD');
		let date_entry = null;
		if (req.body.start_date) {
			date_entry = res.locals.moment(req.body.start_date).format('YYYY-MM-DD');
		}
		let company_branch_id = req.body.company;
		let department_id = req.body.department;
		let account = {
			shortid: shortid.generate(),
			first_name: req.body.first_name,
			middle_name: req.body.middle_name,
			last_name: req.body.last_name,
			suffix: req.body.suffix,
			nick_name: req.body.nick_name,
			gender: req.body.gender,
			birthdate: res.locals.moment(req.body.birthday).format('YYYY-MM-DD'),
			present_address: req.body.current_address,
			permanent_address: req.body.permanent_address,
			nationality: req.body.nationality,
			marital_status: req.body.marital_status,
			contact_number: req.body.contact_number,
			email: req.body.email,
			sss_number: req.body.sss_number,
			pagibig_number: req.body.pagibig_number,
			tin_number: req.body.tin_number,
			philhealth_number: req.body.philhealth_number,
			old_employee_number: req.body.old_employee_number,
			// department_id: department_id,
			// job_title_id: req.body.job_title,
			// date_entry: date_entry,
			// team_id: req.body.team,
			status: 1,
			employee_type: 0,
			created_by: user_id
		}

		UsersModel.create(account).then(function (data) {
			result = data;
			let insertId = result.id;
			//Generate Employee Number and Update
			// BranchesModel.findOne({
			// 	where: {
			// 		id: company_branch_id
			// 	},
			// 	include: [ CompanyModel ]
			// }).then(function(data){
			// 	result = data;
			// 	company = result.company;
			// 	let code = company.code;
			// 	let now = res.locals.moment(Date.now()).format('MM/DD/YYYY');
			// 	let year = req.body.start_date ? res.locals.moment(new Date(req.body.start_date)).format('YYYY') : res.locals.moment(new Date(now)).format('YYYY');
			// 	let employee_number = GlobalHelper.generate_employee_number(code, year, insertId);
			// 	let userData = {
			// 		employee_number: employee_number
			// 	}
			// 	UsersModel.update(userData, {
			// 		where: {
			// 			id: insertId
			// 		}
			// 	});
			// });
			//Check Approvers and Create or Update if Any
			// setApprover(company_branch_id, department_id);

			//Return Success Message
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'New record has been successfully saved.'
			});
		});
	}
}

exports.edit = function (req, res) {

	let id = req.body.id;

	UsersModel.findOne({
		where: {
			id: id
		},
		attributes: [
			'avatar',
			'birthdate',
			'company_branch_id',
			'contact_number',
			'date_entry',
			'department_id',
			'email',
			'employee_number',
			'old_employee_number',
			'first_name',
			'gender',
			'id',
			'job_title_id',
			'last_name',
			'marital_status',
			'middle_name',
			'nationality',
			'note',
			'pagibig_number',
			'philhealth_number',
			'present_address',
			'shortid',
			'sss_number',
			'status',
			'tin_number',
			'user_role',
			'username',
			'team_id',
			'resignation_date'
		]


	}).then(function (data) {

		if (!data) res.status(404).json({
			success: false,
			msg: 'No record found for the given selection.'
		});

		res.status(200).json({
			success: true,
			record: data
		});

	});
}

exports.update = async (req, res) => {

	let id = req.body.id;
	let type = req.body.type;
	let user_id = req.session.user ? req.session.user.id : null;

	if (type == 'info') {

		let validate = [];

		req.checkBody('first_name').notEmpty().withMessage('The first name field is required.');
		req.checkBody('last_name').notEmpty().withMessage('The last name field is required.');
		req.checkBody('gender').notEmpty().withMessage('The gender field is required.');
		req.checkBody('birthday').notEmpty().withMessage('The birthday field is required.');
		req.checkBody('marital_status').notEmpty().withMessage('The marital status field is required.');
		req.checkBody('nationality').notEmpty().withMessage('The nationality field is required.');
		req.checkBody('email').notEmpty().isEmail().withMessage('The email is required and should be valid.');

		let email = req.body.email;
		let employee_number = req.body.employee_number;

		if (email != '' && await Global._validate('UsersModel:email,' + email + ':id !=,' + id)) {
			validate.push({
				'param': 'email',
				'msg': 'This email is already registered.'
			});
		}
		if (employee_number != '' && await Global._validate('UsersModel:employee_number,' + employee_number + ':id !=,' + id)) {
			validate.push({
				'param': 'employee_number',
				'msg': 'This employee number is already registered.'
			});
		}

		let errors = req.validationErrors();

		if (errors || validate.length) {

			if (errors && validate.length) {
				errors = errors.concat(validate);
			} else if (!errors && validate.length) {
				errors = validate;
			} else if (errors && !validate.length) {
				errors = errors;
			}

			res.status(422).json({
				success: false,
				errors
			});

		} else {
			let birthday = res.locals.moment(req.body.birthday).format('YYYY-MM-DD');
			let company_branch_id = req.body.company;
			let department_id = req.body.department;
			let account = {
				first_name: req.body.first_name,
				middle_name: req.body.middle_name,
				last_name: req.body.last_name,
				gender: req.body.gender,
				birthdate: birthday,
				present_address: req.body.current_address,
				permanent_address: req.body.permanent_address,
				nationality: req.body.nationality,
				marital_status: req.body.marital_status,
				contact_number: req.body.contact_number,
				email: req.body.email,
				sss_number: req.body.sss_number,
				pagibig_number: req.body.pagibig_number,
				tin_number: req.body.tin_number,
				philhealth_number: req.body.philhealth_number,
				company_branch_id: company_branch_id,
				department_id: department_id,
				team_id: req.body.team,
				job_title_id: req.body.job_title,
				date_entry: date_entry = res.locals.moment(req.body.start_date).format('YYYY-MM-DD'),
				updated_by: user_id,
				old_employee_number: req.body.old_employee_number,
			}

			UsersModel.update(account, {
				where: {
					id: id
				}
			}).then(function (data) {
				//Check Approvers and Create or Update if Any
				// setApprover(company_branch_id, department_id);
				//Return Successs
				res.status(200).json({
					success: true,
					action: 'close',
					msg: 'Record has been successfully updated.'
				});
			});
		}

	} else {

		let validate = [];

		// req.checkBody('email').notEmpty().withMessage('The email field is required.');
		// req.checkBody('password').notEmpty().withMessage('The password is required.');
		req.checkBody('status').notEmpty().withMessage('The status field is required.');
		if (req.body.status == 3 || req.body.status == 4) {
			req.checkBody('resignation_date').notEmpty().withMessage('The resignation date field is required.');
		}
		let email = req.body.email;

		if (email != '' && await Global._validate('UsersModel:email,' + email + ':id != ,' + id)) {
			validate.push({
				'param': 'email',
				'msg': 'This email is already registered.'
			});
		}

		let errors = req.validationErrors();

		if (errors || validate.length) {

			if (errors && validate.length) {
				errors = errors.concat(validate);
			} else if (!errors && validate.length) {
				errors = validate;
			} else if (errors && !validate.length) {
				errors = errors;
			}

			res.status(422).json({
				success: false,
				errors
			});

		} else {
			let password = req.body.password;
			let account = {
				email: req.body.email,
				status: req.body.status,
			}
			if (password) {
				var salt = bcrypt.genSaltSync(10);
				password = bcrypt.hashSync(password, salt);
				account.password = password;
			}
			if (req.body.status == 3 || req.body.status == 4) {
				account.resignation_date = req.body.resignation_date ? res.locals.moment(new Date(req.body.resignation_date)).format('YYYY-MM-DD') : '';

				LeaveCreditPolicyModel.count({
					where: {
						user_id: id
					}
				}).then(function (countCredit) {
					if (countCredit > 0) {
						LeaveCreditPolicyModel.update({
							balance: 0
						}, {
							where: {
								user_id: id
							}
						});
					}
				});
			} else {
				account.resignation_date = null;
			}
			UsersModel.update(account, {
				where: {
					id: id
				}
			}).then(function (data) {
				res.status(200).json({
					success: true,
					action: 'close',
					msg: 'Record has been successfully updated.'
				});
			});
		}
	}

}

exports.init_form = function (req, res) {
	let session = req.session; 
	let user = res.locals.user;
	let isHRGeneralist = res.locals.isHRGeneralist;
	CompanyModel.findAll({
		where: {
			status: 1
		},
		order: [
			['name', 'asc']
		]
	}).then(function (data) {
		companies = data;
		return Department.findAll({
			where: {
				status: 1
			},
			include: [
				{
					model: UsersModel,
					as: 'manager',
					attributes: ['id', 'first_name', 'last_name']
				}
			],
			order: [
				['department_name', 'asc']
			]
		});
	}).then(function (data) {
		departments = data;
		return Division.findAll({
			where: {
				status: 1
			},
			include: [
				{
					model: UsersModel,
					as: 'manager',
					attributes: ['id', 'first_name', 'last_name']
				}
			],
			order: [
				['name', 'asc']
			]
		});

	}).then(function (data) {
		divisions = data;
		return Section.findAll({
			where: {
				status: 1
			},
			include: [
				{
					model: UsersModel,
					as: 'supervisor',
					attributes: ['id', 'first_name', 'last_name']
				}
			],
			order: [
				['section_name', 'asc']
			]
		});
	}).then(function (data) {
		sections = data;
		return Position.findAll({
			order: [
				['name', 'asc']
			]
		});
	}).then(function (data) {
		positions = data;
		return PositionCategory.findAll({
			order: [
				['name', 'asc']
			]
		});
	}).then(function (data) {
		position_categories = data;
		return PositionClassification.findAll({
			order: [
				['name', 'asc']
			]
		});
	}).then(function (data) {
		position_classifications = data;
		return WorkArea.findAll({
			order: [
				['name', 'asc']
			]
		});
	}).then(function (data) {
		work_areas = data;
		return CountryModel.findAll({
			order: [
				['name', 'asc']
			],
			raw: true
		});
	}).then(function (data) {
		nationalities = data;
		return EmployeeType.findAll({
			order: [
				['name', 'asc']
			],
			raw: true
		});
	}).then(function (data) {
		employee_type = data;
		return Location.findAll({
			order: [
				['location', 'asc']
			]
		});

	}).then(function (data) {
		locations = data;
		return UserRole.get_role(user, 'employee-list').then(function (data) {
		user_role = data;
		let user_logged_id = user.id
			res.status(200).json({
				companies,
				departments,
				locations,
				divisions,
				sections,
				positions,
				position_categories,
				position_classifications,
				work_areas,
				nationalities,
				employee_type,
				user_role,
				user_logged_id,
				session,
				isHRGeneralist
			});
		});
	});
}


exports.userinfo = function (req, res) {

	let id = req.body.id;

	UsersModel.findOne({
		where: {
			shortid: id
		}
	}).then(function (data) {
		employee = data;
		user_id = employee.id;

		return EducationsModel.findOne({
			where: {
				user_id: employee.id
			}
		});
	}).then(function (data) {
		education = data;
		return EmploymentsModel.findAll({
			where: {
				user_id: employee.id
			},
			order: [
				['created_at', 'desc']
			]
		});
	}).then(function (data) { 
		employment = data;
		return AddressModel.findAll({
			where: {
				user_id: user_id
			}
		}).then(function(data) {
			address = data;

			let record = {
				employee: employee,
				education: education,
				employment: employment,
				address: address
			}
			res.status(200).json({
				success: true,
				record: record
			});
		})
		
	});
}

exports.search = function (req, res) {
	let key = req.body.key;

	UsersModel.findAll({
		where: {
			$or: [
				{
					first_name: {
						$like: '%' + key + '%'
					}
				},
				{
					last_name: {
						$like: '%' + key + '%'
					}
				},
				{
					middle_name: {
						$like: '%' + key + '%'
					}
				},
				{
					email: {
						$like: '%' + key + '%'
					}
				},
				{
					username: {
						$like: '%' + key + '%'
					}
				},
				{
					employee_number: {
						$like: '%' + key + '%'
					}
				},
			]
		},
		attributes: ['id', 'shortid', 'first_name', 'last_name', 'email', 'avatar', 'gender', 'user_role']
	}).then(function (data) {
		res.status(200).json({
			success: true,
			records: data
		});
	});

}

exports.getRole = function (req, res) {
	let id = req.body.id;
	RoleModel.findAll({
		where: {
			status: 1
		}
	}).then(function (data) {
		roles = data;
		res.status(200).json({
			success: true,
			roles: roles
		});
	});
}

exports.updateRole = function (req, res) {
	let user_id = req.body.user_id;
	let user_roles = req.body.user_roles;
	let array = [];
	if (user_roles.length) {
		for (let x in user_roles) {
			if (user_roles[x]['role_id']) {
				array.push(user_roles[x]['id']);
			}

		}
	}

	let string = array.join();

	let reqBody = {
		user_role: string
	}

	UsersModel.update(reqBody, {
		where: {
			id: user_id
		}
	}).then(function (data) {
		res.status(200).json({
			success: true,
			action: 'fetch',
			msg: 'User role has been updated.'
		});
	});
}


const setApprover = function (branch_id, department_id) {
	//Check Approvers and Create or Update if Any
	ApproversModel.findOne({
		where: {
			company_location_id: branch_id,
			department_id: department_id
		}
	}).then(function (data) {
		record = data;
		if (!record) {
			let approverData = {
				company_location_id: branch_id,
				department_id: department_id
			}
			ApproversModel.create(approverData);
		}
	});
}


const returnError = function (res, error_message) {
	var errorData = [
		{	
			param: 'csv_format',
			msg: error_message
		}
	]
	res.status(422).json({
		success: false,
		errors: errorData
	});
}