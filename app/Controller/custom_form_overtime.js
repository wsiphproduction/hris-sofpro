const UserRole = require('../Helper/UserRole');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser')
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const _ = require('underscore');
const PrepareMail = require('../Helper/PrepareMail');
const Notification = require('../Helper/Notification');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	CompanyModel, 
	EmploymentsModel,
	Division,
	Department,
	Section,
	LeaveDateModel,
	ShiftsModel,
	ShiftType,
	OvertimesModel,
    ConfigModel,
	BiometricLog,
	BiometricNumberModel
} = require('../../config/Sequelize');
const BiometricNumber = require('../Models/BiometricNumber');

exports.index = function(req, res){
	//PrepareMail.test_email();
	
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'custom-form-overtime');
	}).then(function(data){
		user_role = data;
		res.render('CustomForm/Overtime/index',{
			route: 'custom-form-overtime',
			usrRole: usrRole,
			user_role: user_role
		});
		
	});
}

exports.store = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let user = res.locals.user;
		let user_id = req.body.employee ? req.body.employee:'';
		let branch_id = user.company_branch_id;
		let department_id = user.department_id;
		let break_hours = req.body.breakHours ? req.body.breakHours : 0;

		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
		req.checkBody('shift_type').notEmpty().withMessage('The Shift Type field is required.');
		req.checkBody('shift_id').notEmpty().withMessage('The Target Shift Date field is required.');
		
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let primary_approver = req.body.approver_id;
			let secondary_approver = req.body.approver_secondary_id;
			let overtime = req.body.overtime;
			let shift_id = req.body.shift_id;
			let nHours = req.body.no_of_hours;
			let start_date = res.locals.moment(req.body.start_date).format('YYYY-MM-DD');
			let end_date   = res.locals.moment(req.body.end_date).format('YYYY-MM-DD');
			let start_time = res.locals.moment(req.body.start_date).format('HH:mm:ss');
			let end_time   = res.locals.moment(req.body.end_date).format('HH:mm:ss');
			let attachment = files.attachment;
			let filename = null;

			// Check number of hours
			if (nHours == null || isNaN(nHours)){
				nHours= 0;
			}

			// Allow last minute overlap
			let overlap_start_time = res.locals.moment(req.body.start_date).add(1, 'minutes').format('HH:mm:ss');
			let overlap_end_time = res.locals.moment(req.body.end_date).subtract(1, 'minutes').format('HH:mm:ss');

			if(attachment && attachment.size > 0){
				var oldFile = uploadPath + record.attachment;
				//Delete File if exists
				try {
					if (fs.existsSync(oldFile)) {
						fs.unlinkSync(oldFile);
					}
				} catch(err) {
					console.log('Cant find.')
				}
							let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				filename = uuidv4(origFileName) + '.'+ ext;
				
							fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){});
					});
				});
			}
			
			ShiftsModel.findOne({
				where: {
					id:shift_id
				},
				include:[
					{
						model: ShiftType,
						as: 'type_of_shift',
						attributes: ['is_from_previous'],
					}
				],
			}).then(data=>{
				shift = data;
				ot_find_attendance(user_id, req.body.start_date, req.body.end_date, shift).then((data) => {
					let check_ot = data;
					// console.log('CHECK OT: ', check_ot);
					if (check_ot) {
						let type = shift && shift.shift_type != 'NONE' ? 1 : 2;

						let inputData = {
							user_id: user_id,
							start_date: start_date,
							end_date: end_date,
							start_time: start_time,
							end_time: end_time,
							no_of_hours: nHours,
							purpose: req.body.purpose,
							shift_id: shift_id,
							type: type,
							primary_status: 1,
							attachment: filename,
							backup_status: 1,
							primary_approver: primary_approver,
							backup_approver: secondary_approver,
							secretary_id: user.id,
							break_hours: break_hours,
							_token: uuidv4()
						}

						OvertimesModel.count({
							where: {
								user_id: user_id,
								start_date: start_date,
								end_date: end_date,
								//primary_status : {$ne: 4},
								primary_status: { $lte: 2 },
								$or: [{
									start_time: {
										$between: [overlap_start_time, overlap_end_time]
									}
								}, {
									end_time: {
										$between: [overlap_start_time, overlap_end_time]
									}
								}]
							}
						}).then(function (data) {
							if (data == 0) {
								OvertimesModel.create(inputData).then(function (data) {
									let insertId = data.id
									let notificationMessage = {
										sender: user.id,
										content: '<strong>' + user.first_name + ' ' + user.last_name + '</strong> sent overtime application that requires your approval.',
										url: 'approvals/overtime'
									}
									let receiver = [primary_approver];
									Notification.notify(notificationMessage, receiver, 'overtime', 'create');
									//Send Mail
									//PrepareMail.overtime(insertId, res.locals.baseUrl);

									res.status(200).json({
										success: true,
										action: 'fetch',
										msg: 'New record has been successfully saved.'
									});
								});
							} else {
								var error = [
									{
										param: 'start_date',
										msg: 'Date and time has already been taken.'
									}
								]
								res.status(422).json({
									success: false,
									errors: error
								});
							}
						});
					}
					else {
						var error = [
							{
								param: 'shift_id',
								msg: "No actual employee time in and time out"
							}
						]
						res.status(422).json({
							success: false,
							errors: error
						});
					}
				});
			});		
		}
	});
}

exports.update = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let user = res.locals.user;

		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		req.checkBody('shift_id').notEmpty().withMessage('The Target Shift field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let id = req.body.id;
			let start_date = res.locals.moment(req.body.start_date).format('YYYY-MM-DD');
			let end_date   = res.locals.moment(req.body.end_date).format('YYYY-MM-DD');
			let start_time = res.locals.moment(req.body.start_date).format('HH:mm:ss');
			let end_time   = res.locals.moment(req.body.end_date).format('HH:mm:ss');
			let shift_id   = req.body.shift_id;

			let attachment = files.attachment;
			let filename = null;

			if(attachment && attachment.size > 0){
				var oldFile = uploadPath + record.attachment;
				//Delete File if exists
				try {
					if (fs.existsSync(oldFile)) {
						fs.unlinkSync(oldFile);
					}
				} catch(err) {
					console.log('Cant find.')
				}
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				filename = uuidv4(origFileName) + '.'+ ext;
				
							fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){});
					});
				});
			}

			let where = {
				id: {
					$not: id
				},
				user_id: req.body.employee,
				start_date: start_date,
				end_date: end_date,
				//primary_status : {$ne: 4},
				primary_status : {$lte: 2},
				$or: [{
					start_time: {
						$between: [start_time, end_time]
					}
				}, {
					end_time: {
						$between: [start_time, end_time]
					}
				}]
			};
			
			OvertimesModel.count({
				where: where
			}).then(function(data){
				if(data == 0){
					let no_of_hours = req.body.no_of_hours ? req.body.no_of_hours: 0;

					if (no_of_hours == null || isNaN(no_of_hours)){
						no_of_hours = 0;
					}

					let inputData = {
						start_date: start_date,
						end_date: end_date,
						start_time: start_time,
						end_time: end_time,
						type: req.body.type,
						shift_id: shift_id,
						no_of_hours: no_of_hours,
						purpose: req.body.purpose
					}
	
					if(filename){
						inputData.attachment = filename
					}
					
					OvertimesModel.update(inputData, {
						where: {
							id: id
						}
					}).then(function(data){
						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'Record has been successfully updated.'
						});
					});
				}else{
					var error = [
						{	
							param: 'start_date',
							msg: 'Date and time has already been taken.'
						}
					]
					res.status(422).json({
						success: false,
						errors: error
					});
				}
			});
		}	

	});
}

exports.fetch = function(req, res){
	let user = res.locals.user;
	let employee = req.body.employee;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
 	let key 	= req.body.key;
	let approvingOrganization = res.locals.approvingOrganization;
	let approvingOrganizationId = res.locals.approvingOrganizationId;
	let startOf = null;
	let endOf = null;
	let session = req.session;
	
	let where = {}
	let whereUser = {}
	let whereEmployment = {}
	
	if (approvingOrganization == 'division') {
		whereEmployment.division_id = approvingOrganizationId;
	}
	if (approvingOrganization == 'department') {
		whereEmployment.department_id = approvingOrganizationId;
	}
	if (approvingOrganization == 'section') {
		whereEmployment.section_id = approvingOrganizationId;
	}

	if(status){
		where.$or = [
			{
				primary_status: status
			},{
				backup_status: status
			}
		]
	}else{
		where.primary_status = {
			$ne: 4
		}
		where.backup_status = {
			$ne: 4
		}
	}

	if(employee){
		where.user_id = employee;
	}

	ConfigModel.findOne({
        where: {
            id: 1
        }
    }).then(function (data) {
        config = data;
        json = config.json ? JSON.parse(config.json) : null;
    
        let cutoff = json.cutoff;
        let month_date = null;
        let period = null;
    
        if (session.user) {
            month_date = new Date(session.user.default_month_date);
            period = session.user.default_period
        } else {
            month_date = new Date();
            period = 'A'
        }
    
        if ((start && end) && (start <= end)) {
            where.start_date = {
                $between: [start, end]
            }
        } else {
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
    
            where.start_date = {
                $between: [startOf, endOf]
            }
        }
    
        return EmploymentsModel.findAll({
            where: whereEmployment,
            attributes: ['id', 'user_id'],
            raw: true
        });
    }).then(function (data) {
        employment = data;
    
        // let user_id = [];
        // if (employment && employment.length) {
        //     for (let i in employment) {
        //         user_id.push(employment[i].user_id);
        //     }
        // }
        // user_id = [...new Set(user_id)];

		if(res.locals.user.id){
            whereUser.$or = [
                {
                    secretary_id: user.id
                },{
                    alternate_secretary: user.id
                },{
                    hr_generalist_id: user.id
                }
            ]
        }
    
        if (key) {
            whereUser = {
                // id: {
                //     [Op.in]: user_id
                // },
                [Op.and]: [
                    {
                        [Op.or]: [
                            {
                                first_name: {
                                    [Op.like]: '%' + key + '%'
                                }
                            },
                            {
                                last_name: {
                                    [Op.like]: '%' + key + '%'
                                },
                            },
                            {
                                middle_name: {
                                    [Op.like]: '%' + key + '%'
                                },
                            },
                            {
                                email: {
                                    [Op.like]: '%' + key + '%'
                                },
                            },
                            {
                                username: {
                                    [Op.like]: '%' + key + '%'
                                },
                            },
                            {
                                employee_number: {
                                    [Op.like]: '%' + key + '%'
                                },
                            }
                        ]
                    },
                    {
                        [Op.or]: [
                            {
                                secretary_id: user.id
                            },{
                                alternate_secretary: user.id
                            },{
                                hr_generalist_id: user.id
                            }
                        ]
                    }
                ]
            }
        } else {
            // whereUser.id = {
            //     [Op.in]: user_id
            // }
        }
    
        return UsersModel.findAll({
            where: whereUser,
            raw: false,
        }).then(data => {
            users = data;
            let results = [];
            if (users && users.length) {
                results = _.pluck(users, 'id');
                results = [...new Set(results)];
            }
    
            where.user_id = {
                [Op.in]: results
            }
    
            ShiftType.findAll({
                order: [
                    ['shift_id', 'ASC']
                ],
            }).then(data => {
                shifts = data;
                OvertimesModel.findAndCountAll({
                    where: where,
                    limit: limit,
                    offset: offset,
                    include: [
                        {
                            model: UsersModel,
                            as: 'primary'
                        },
                        {
                            model: UsersModel,
                            as: 'backup'
                        },
                        {
                            model: UsersModel,
                            as: 'applicant'
                        },
						{
                            model: ShiftsModel,
							as: 'ot_shift_target',
							attributes: ['id', 'date']
                        },
                    ],
                    order: [
                        ['created_at', 'DESC']
                    ],
                }).then(data => {
                    overtimes = data;
                    numrows = overtimes.count;
                    count = 0;
                    if (limit < numrows) {
                        count = numrows / limit;
                        count = Math.ceil(count);
                    } else {
                        count = 0;
                    }
    
                    res.status(201).json({
                        success: true,
                        count: count,
                        shifts: shifts,
                        records: overtimes.rows,
                        numrows: numrows,
						config: config,
						session: session
                    });
                })
            })
        })
    })
}

exports.export = function (req, res) {
    let user = res.locals.user;
    let employee = req.body.employee;
    let start = req.body.start;
    let end = req.body.end;
    let status = req.body.status;
    let limit = parseInt(req.body.limit);
    let page = req.body.page;
    let offset = (parseInt(page) - 1) * parseInt(limit);

    let approvingOrganization = res.locals.approvingOrganization;
    let approvingOrganizationId = res.locals.approvingOrganizationId;
    let startOf = null;
    let endOf = null;
    let session = req.session;

    let where = {}
    let whereUser = {}
    let whereEmployment = {}

    if (approvingOrganization == 'division') {
        whereEmployment.division_id = approvingOrganizationId;
    }
    if (approvingOrganization == 'department') {
        whereEmployment.department_id = approvingOrganizationId;
    }
    if (approvingOrganization == 'section') {
        whereEmployment.section_id = approvingOrganizationId;
    }

    if (status) {
        where.$or = [
            {
                primary_status: status
            }, {
                backup_status: status
            }
        ]
    } else {
        where.primary_status = {
            $ne: 4
        }
        where.backup_status = {
            $ne: 4
        }
    }
    
    if (employee) {
        where.user_id = employee;
    }

    ConfigModel.findOne({
        where: {
            id: 1
        }
    }).then(function (data) {
        config = data;
        json = config.json ? JSON.parse(config.json) : null;

        let cutoff = json.cutoff;
        let month_date = null;
        let period = null;

        if (session.user) {
            month_date = new Date(session.user.default_month_date);
            period = session.user.default_period
        } else {
            month_date = new Date();
            period = 'A'
        }

        if ((start && end) && (start <= end)) {
            where.start_date = {
                $between: [start, end]
            }
        } else {
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

            where.start_date = {
                $between: [startOf, endOf]
            }
        }

        return EmploymentsModel.findAll({
            where: whereEmployment,
            attributes: ['id', 'user_id'],
            raw: true
        });
    }).then(function (data) {
        employment = data;

        let user_id = [];
        if (employment && employment.length) {
            for (let i in employment) {
                user_id.push(employment[i].user_id);
            }
        }
        user_id = [...new Set(user_id)];

        whereUser.id = {
            [Op.in]: user_id
        }


        return UsersModel.findAll({
            where: whereUser,
            raw: false,
        }).then(data => {
            users = data;
            let results = [];
            if (users && users.length) {
                results = _.pluck(users, 'id');
                results = [...new Set(results)];
            }

            where.user_id = {
                [Op.in]: results
            }

            OvertimesModel.findAndCountAll({
                where: where,
                limit: limit,
                offset: offset,
                include: [
                    {
                        model: UsersModel,
                        as: 'primary'
                    },
                    {
                        model: UsersModel,
                        as: 'applicant'
                    },
                ],
                order: [
                    ['created_at', 'DESC']
                ],
            }).then(data => {
                overtimes = data;
                numrows = overtimes.count;
                count = 0;
                if (limit < numrows) {
                    count = numrows / limit;
                    count = Math.ceil(count);
                } else {
                    count = 0;
                }
                let record = overtimes.rows;
                let fields = ['Date Filed', 'Employee', 'Date', 'Total Hours', 'Purpose', 'Approved By', 'Status'];
                let arrayData = [];
                if (record) {
                    for (let i in record) {
                        let status = '';
                        if (record[i].primary_status == 1) {
                            status = 'Pending';
                        } else if (record[i].primary_status == 2) {
                            status = 'Approved';
                        } else if (record[i].primary_status == 3) {
                            status = 'Declined';
                        } else if (record[i].primary_status == 4) {
                            status = 'Closed';
                        }
                        arrayData.push({
                            'Date Filed': moment(record[i].created_at).format('YYYY-MM-DD HH:mm:ss'),
                            'Employee': record[i].applicant.last_name + ', ' + record[i].applicant.first_name,
                            'Date': moment(record[i].start_date).format('MM/DD/YYYY') + ' ' + moment(record[i].start_time).format('HH:mm:ss') + ' — ' + moment(record[i].end_date).format('MM/DD/YYYY') + ' ' + moment(record[i].end_time).format('HH:mm:ss'),
							'Total Hours':record[i].no_of_hours,
                            'Purpose': record[i].purpose,
                            'Approved By': record[i].primary ? record[i].primary.last_name + ', ' + record[i].primary.first_name : '--',
                            'Status': status,
                        });
                    }
                }
                let filename = 'Custom_overtime_' + moment(start).format('YYYYMMDD');
                const json2csvParser = new Parser({ fields });
                const csv = json2csvParser.parse(arrayData);
                res.attachment(filename + '.csv');
                res.status(200).send(csv);
            });
        });
    });
}

exports.delete = function(req, res){
	let id = req.body.id;
	let data = {
		primary_status: 4,
		backup_status: 4,
	}

	OvertimesModel.update(data, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}

exports.init = function(req, res){
	let user = res.locals.user;
	let session = req.session;
	let whereUser = {};
	let where = {
		status: 1
	}
	if(user.id){
		where.$or = [
			{
				secretary_id: user.id
			},{
				alternate_secretary: user.id
			},{
				hr_generalist_id: user.id
			}
		]
	}

	ConfigModel.findOne({
		where: { 
			id: 1
		},
	}).then((data) => {
		config = data;
		json = config.json ? JSON.parse(config.json) : null;

		let cutoff = json.cutoff;
		let month_date = null;
		let period = null;

		if (session.user) {
			month_date = new Date(session.user.default_month_date);
			period = session.user.default_period
		} else {
			month_date = new Date();
			period = 'A'
		}

		let start 	= null;
		let end 	= null;
		
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

		whereUser.date = {
			$between: [startOf, endOf]
		}

		UsersModel.findAll({
			where: where,
			include: [
				{
					model: EmploymentsModel,
					limit: 1,
					order: [
						['id', 'desc']
					],
					required: false,
					include: [{
						model: Division,
						as: 'division',
						include: [
							{
								model: UsersModel,
								as: 'manager',
								attributes: ['id', 'first_name', 'last_name', 'email']
							},
							{
								model: UsersModel,
								as: 'assistant_manager',
								attributes: ['id', 'first_name', 'last_name', 'email']
							}

						]
					}, {
						model: Department,
						as: 'department',
						include: [
							{
								model: UsersModel,
								as: 'manager',
								attributes: ['id', 'first_name', 'last_name', 'email']
							},
							{
								model: UsersModel,
								as: 'assistant_manager',
								attributes: ['id', 'first_name', 'last_name', 'email']
							}

						]
					}, {
						model: Section,
						as: 'section',
						include: [
							{
								model: UsersModel,
								as: 'supervisor',
								attributes: ['id', 'first_name', 'last_name', 'email']
							},
							{
								model: UsersModel,
								as: 'assistant_supervisor',
								attributes: ['id', 'first_name', 'last_name', 'email']
							}
						]
					}
					],
				}
			],
			attributes: ['id', 'first_name', 'last_name', 'email', 'alternate_secretary', 'approver_id', 'employee_number', 'employee_type', 'hr_generalist_id', 'middle_name', 'old_employee_number', 'secondary_approver_id', 'secretary_id', 'shortid', 'user_role'],
			order: [
				['last_name', 'ASC']
			]
		}).then(data => {
			users = data;
			userIDS = _.pluck(users, 'id');
			whereUser.user_id = {
				[Op.in]: userIDS
			}

			ShiftsModel.findAll({
				where: whereUser,

				raw: true,
				order: [
					['created_at', 'DESC']
				],
			}).then(data => {
				shifts_type = data;
				res.status(200).json({
					success: true,
					users: users,
					shifts: shifts_type,
				});
			})
		})
	});
}

const ot_find_attendance = async function(user_id,start_date_ot,end_date_ot,shift){
	let ReturnValue =  new Promise(resolve => {
		//RESULT
		let result = false;
		// OT FILED CHECK IN AND CHECK OUT
		start_date_ot = moment(start_date_ot).format('YYYY-MM-DD HH:mm:ss');
		end_date_ot = moment(end_date_ot).format('YYYY-MM-DD HH:mm:ss');
		// SHIFT INFORMATION
		let shift_length = shift.shift_length ? shift.shift_length : 9;
		let is_from_previous = shift && shift.type_of_shift ? shift.type_of_shift.is_from_previous ? shift.type_of_shift.is_from_previous : null : null;
		let shift_check_in = shift.check_in ? moment(shift.check_in).utc().format("HH:mm:ss") : null;
		let shift_check_out = shift.check_out ? moment(shift.check_out).utc().format("HH:mm:ss") : null;
		let shift_date = shift.date ? shift.date : null;

		// SHIFT ACTUAL TIME IN AND TIME OUT
		let shift_act_check_in = shift.actual_check_in ? shift_date + " " + moment(shift.actual_check_in).utc().format("HH:mm:ss") : null;
		let shift_act_check_out = shift.actual_check_out ? shift_date + " " + moment(shift.actual_check_out).utc().format("HH:mm:ss") : null;

		// SHIFT PROCESSED DATES
		let shift_start_date = null;
		let shift_end_date = null;

		// console.log("RAW CHECK_IN: ", shift.check_in, " CHECKOUT: ", shift.check_out, " DATE: ", shift.date);
		// console.log("ACTUAL CHECK_IN: ", shift_check_in, " CHECKOUT: ", shift_check_out, " DATE: ", shift_date, " IS FROM PREV: ", is_from_previous);

		// FOR TIME IN
		if (is_from_previous == '1') {
			shift_start_date = shift_check_in ? moment(shift_date + ' ' + shift_check_in).subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss') : null;
			shift_end_date = shift_check_out ? moment(shift_date + ' ' + shift_check_out).format('YYYY-MM-DD HH:mm:ss') : null;

			shift_act_check_in = shift_act_check_in && shift_check_out ? shift_act_check_in > shift_check_out ? moment(shift_act_check_in).subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss') : moment(shift_act_check_in).format('YYYY-MM-DD HH:mm:ss') : null;
		} else {
			shift_start_date = shift_check_in ? moment(shift_date + ' ' + shift_check_in).format('YYYY-MM-DD HH:mm:ss') : null;
			shift_end_date = shift_check_out ? shift_start_date > shift_date + ' ' + shift_check_out ? moment(shift_date + ' ' + shift_check_out).add(1, 'days').format('YYYY-MM-DD HH:mm:ss') : moment(shift_date + ' ' + shift_check_out).format('YYYY-MM-DD HH:mm:ss') : null;

			if (shift_act_check_in && moment(shift_start_date).diff(shift_act_check_in, 'hours') < (shift_length * -1)) {
				shift_act_check_in = shift_act_check_in ? moment(shift_act_check_in).subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss') : null;
			}
			if (shift_act_check_out && moment(shift_act_check_out).diff(shift_end_date, 'hours') < (shift_length * -1)) {
				shift_act_check_out = shift_act_check_out ? moment(shift_act_check_out).add(1, 'days').format('YYYY-MM-DD HH:mm:ss') : null;
			}
		}

		// console.log("PROCESSED SD: ", shift_start_date, " ED: ", shift_end_date);

		BiometricNumberModel.findAll({
			where: {
				user_id: user_id
			}
		}).then((data)=>{
			let user_biometrics = data.map(el => el.biometric_number);
			// PRE OT
			if (start_date_ot < shift_start_date) {
				// OT FILED START AND END DATE
				start_date_ot = moment(start_date_ot).subtract(4, 'hours').format("YYYY-MM-DD HH:mm:ss");
				console.log("PRE OT PROCESSED OTSD: ", start_date_ot, " OTED: ", end_date_ot);

				BiometricLog.count({
					where: {
						date: { [Op.between]: [start_date_ot, end_date_ot] },
						status: 0,
						userId: user_biometrics
					}
				}).then((data) => {
					let total_ti = data;
					console.log("TOTAL: ", total_ti);
					if (total_ti > 0) {
						// console.log('[IF]PRE OT SHIFT ACT TI: ', shift_act_check_in);
						resolve('1');
					}
					else {
						// console.log('[ELSE]PRE OT SHIFT ACT TI: ', shift_act_check_in);
						if (shift_act_check_in && shift_act_check_in < end_date_ot) {
							// console.log('TRUE');
							resolve('1');
						}
						else {
							// console.log('FALSE');
							resolve('0');
						}
					}
				});
			}
			// POST OT
			else {
				// OT FILED START AND END DATE
				end_date_ot = moment(end_date_ot).add(4, 'hours').format("YYYY-MM-DD HH:mm:ss");
				// console.log("POST OT PROCESSED OTSD: ", start_date_ot, " OTED: ", end_date_ot);

				BiometricLog.count({
					where: {
						userId: user_biometrics,
						date: { [Op.between]: [start_date_ot, end_date_ot] },
						status: 1,
					}
				}).then((data) => {
					let total_to = data;
					// console.log("TOTAL: ", total_to);
					if (total_to > 0) {
						resolve('1');
					}
					else {
						if (shift_act_check_out && shift_act_check_out > start_date_ot) {
							resolve('1');
						}
						else {
							resolve('0');
						}
					}
				});
			}
		});

	});

	return await ReturnValue == '1'? true:false;
}

exports.fetch_user_shifts = function(req,res){
	let user_id 	= req.body.user_id? req.body.user_id:null;
	let date 		= req.body.date? moment(req.body.date).format('YYYY-MM-DD'): null;

	// console.log(user_id,' --- ', date);
	// console.log(prev_date,' --- ', next_date);

	if(user_id && date){
		let prev_date 	= moment(date).subtract(1,'day').format("YYYY-MM-DD");
		let next_date 	= moment(date).add(1,'day').format("YYYY-MM-DD");
		ShiftsModel.findAll({
			where:{
				date:{
					[Op.between]:[prev_date,next_date]
				},
				user_id: user_id
			},
			include:[
				{
					model: ShiftType,
					as: 'type_of_shift',
					attributes: ['id', 'shift_id'],
				}
			],
			attributes:['id','date','shift_type']
		}).then(data=>{
			// console.log("SHIFTS: ", data);
			let user_shifts = data;

			if(user_shifts.length){
				res.status(200).json({
					shifts: user_shifts,
				});
			}
			else{
				res.status(200).json({
					error: "There are no shift found, please upload a shift schedule",
				});
			}

		});
	}

}