const UserRole = require('../Helper/UserRole');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser')
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const _ = require('underscore');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	Division,
	Department,
	Section,
	ShiftsModel,
	ShiftType,
	EmploymentsModel,
    ChangeLogModel,
	ConfigModel
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'custom-form-change-log');
	}).then(function(data){
		user_role = data;
		res.render('CustomForm/ChangeLog/index',{
			route: 'custom-form-change-log',
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
        let id = req.body.id ? req.body.id : 0;
        
        //req.checkBody('old_date').notEmpty().withMessage('The old field is required.');
        req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
        req.checkBody('new_date').notEmpty().withMessage('The new date field is required.');
        // req.checkBody('new_login').notEmpty().withMessage('The new login field is required.');
        // req.checkBody('new_logout').notEmpty().withMessage('The new logout field is required.');
        let errors = req.validationErrors();
        if(errors){
            res.status(422).json({
                success: false,
                errors
            });
        }else{
            ShiftsModel.findOne({
                where:{
                    id:id
                }
            }).then(data=>{
                shift = data;
                return ShiftType.findOne({
                    where: {
                        id: req.body.shift_type
                    }
                });
                
            }).then(data=>{
                shift_type = data;

                let user_id = shift ? shift.user_id ? shift.user_id : req.body.employee : req.body.employee ;
                let old_checkin = shift ? shift.actual_check_in ? res.locals.moment(shift.actual_check_in).utc().format('HH:mm:ss'): null : null;
                let old_checkout = shift ? shift.actual_check_out ? res.locals.moment(shift.actual_check_out).utc().format('HH:mm:ss'): null : null;
                let new_checkin = req.body.new_login ? res.locals.moment(req.body.new_login).format('HH:mm:ss') : null;
                let new_checkout = req.body.new_logout ? res.locals.moment(req.body.new_logout).format('HH:mm:ss'): null;

                let log_date = res.locals.moment(req.body.new_date).format('YYYY-MM-DD');

                //UPLOADING OF FILES
                let attachment 	= files.attachment;			
                let filename = null;

                if(attachment && attachment.size > 0){
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

                let reqData = {
                    user_id: user_id,
                    primary_status: 1,
                    shift_id: id,
                    log_date: log_date,
                    orig_login_time: old_checkin,
                    orig_logout_time: old_checkout,
                    req_login_time: new_checkin,
                    req_logout_time: new_checkout,
                    note: req.body.note,
                    primary_approver: req.body.approver_id,
                    backup_approver: req.body.approver_secondary_id,
                    secretary_id: user.id,
                }

                if(attachment && attachment.size > 0){                
                    reqData.attachment = filename
                }

                ChangeLogModel.count({
                    where: {
                        user_id: user_id,
                        log_date: log_date,
                        primary_status : {$lte: 2},
                    }
                }).then(function(data){
                    if(data == 0){
                        ChangeLogModel.create(reqData).then(function(data){
                            res.status(200).json({
                                success: true,
                                action: 'fetch',
                                msg: 'Record has been successfully created.'
                            });
                        });
                    }else{
                        var error = [
                            {	
                                param: 'new_date',
                                msg: 'Date and time has already been taken.'
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
    let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
        let id = req.body.id;
        req.checkBody('new_date').notEmpty().withMessage('The new date field is required.');
        req.checkBody('new_login').notEmpty().withMessage('The new login field is required.');
        req.checkBody('new_logout').notEmpty().withMessage('The new logout field is required.');
        let errors = req.validationErrors();

        if(errors){
            res.status(422).json({
                success: false,
                errors
            });
        }else{
            let log_date = res.locals.moment(req.body.new_date).format('YYYY-MM-DD');
            let new_checkin = res.locals.moment(req.body.new_login).format('HH:mm:ss');
            let new_checkout = res.locals.moment(req.body.new_logout).format('HH:mm:ss');
            let note = req.body.note;

            //UPLOADING OF FILES
            let attachment 	= files.attachment;			
            let filename = null;

            if(attachment && attachment.size > 0){
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

            let reqData = {
                log_date: log_date,
                req_login_time: new_checkin,
                req_logout_time: new_checkout,
                note: note
            }

            if(attachment && attachment.size > 0){                
                reqData.attachment = filename
            }

            ChangeLogModel.update(reqData,{
                where:{
                    id:id
                }
            }).then(data=>{
                res.status(200).json({
                    success: true,
                    action: 'fetch',
                    msg: 'New record has been successfully updated.'
                });
            });
        }
    });
}

exports.fetch = function(req, res){
    let user = res.locals.user;
    let employee = req.body.employee;
    let start = req.body.start;
    let end = req.body.end;
    let status = req.body.status;
    let limit = parseInt(req.body.limit);
    let page = req.body.page;
    let offset = (parseInt(page) - 1) * parseInt(limit);
    let key = req.body.key;
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
        where.primary_status = status;
    } else {
        where.primary_status = {
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
            where.log_date = {
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

            where.log_date = {
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

            ChangeLogModel.findAndCountAll({
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
                ],
                order: [
                    ['created_at', 'DESC']
                ],
            }).then(data => {
                shifts = data;
                numrows = shifts.count;
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
                    records: shifts.rows,
                    numrows: numrows,
                    config: config,
                    session: session
                });
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
        where.primary_status = status;
    } else {
        where.primary_status = {
            $ne: 4
        }
    }
    // if((start && end) && (start <= end)){
    // 	where.log_date = {
    //         $between: [start, end]
    //     }
    // }
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
            where.log_date = {
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

            where.log_date = {
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
            ChangeLogModel.findAndCountAll({
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
                shifts = data;
                numrows = shifts.count;
                count = 0;
                if (limit < numrows) {
                    count = numrows / limit;
                    count = Math.ceil(count);
                } else {
                    count = 0;
                }
                let record = shifts.rows;
                let fields = ['Date Filed', 'Employee', 'Login', 'Logout', 'NewLogin', 'NewLogout', 'Approved By', 'Status'];
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
                            'Login': record[i].orig_login_time ? moment(record[i].log_date).format('YYYY-MM-DD') + ' ' + moment(record[i].orig_login_time).utc().format('hh:mmA') : '-',
                            'Logout': record[i].orig_logout_time ? moment(record[i].log_date).format('YYYY-MM-DD') + ' ' + moment(record[i].orig_logout_time).utc().format('hh:mmA') : '-',
                            'NewLogin': record[i].req_login_time ? moment(record[i].log_date).format('YYYY-MM-DD') + ' ' + moment(record[i].req_login_time).utc().format('hh:mmA') : '-',
                            'NewLogout': record[i].req_logout_time ? moment(record[i].log_date).format('YYYY-MM-DD') + ' ' + moment(record[i].req_logout_time).utc().format('hh:mmA') : '-',
                            'Approved By': record[i].primary ? record[i].primary.first_name + ' ' + record[i].primary.last_name : '--',
                            'Status': status,
                        });
                    }
                }
                let filename = 'Custom_change_log_' + moment(start).format('YYYYMMDD');
                const json2csvParser = new Parser({ fields });
                const csv = json2csvParser.parse(arrayData);
                res.attachment(filename + '.csv');
                res.status(200).send(csv);
            })
        })
    })
}

exports.getlog = function(req, res){
	let user_id = req.body.id;
	let date = res.locals.moment().subtract(120, 'days').format('YYYY-MM-DD');
	ShiftsModel.findAll({
		where: {
			user_id: user_id,
			date: {
				[Op.gte]: date
			},
		},
		order:[
			['date','desc']
		],
		raw: true
	}).then(data=>{
		shifts = data;
		res.status(201).json({
			shift_type: shift_type,
			shifts: shifts
		});
	});
}

exports.delete = function(req, res){
	let id = req.body.id;
	ChangeLogModel.destroy({
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
	UsersModel.findAll({
		where: where,
		include:[
			{
				model: EmploymentsModel,
				limit: 1,
				order: [
					['id','desc']
				],
				required: false,
				include:[{
						model: Division,
						as: 'division',
						include: [
							{
								model: UsersModel,
								as: 'manager',
								attributes:['id','first_name','last_name','email']
							},
							{
								model: UsersModel,
								as: 'assistant_manager',
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
							},
							{
								model: UsersModel,
								as: 'assistant_manager',
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
							},
							{
								model: UsersModel,
								as: 'assistant_supervisor',
								attributes:['id','first_name','last_name','email']
							}
						]
					}
				],
			}
		],
		attributes:['id','first_name','last_name','email','alternate_secretary','approver_id','employee_number','employee_type','hr_generalist_id','middle_name','old_employee_number','secondary_approver_id','secretary_id','shortid','user_role'],
		order:[
			['last_name','ASC']
		]
	}).then(data=>{
		users = data;
		return ShiftType.findAll({
			order: [
				['shift_id','ASC']
			]
		});
		
	}).then(data=>{
		shift_type = data;
		res.status(200).json({
            success: true,
            users: users,
            shift_type: shift_type
        });
	})
}