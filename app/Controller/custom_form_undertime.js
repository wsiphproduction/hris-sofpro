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
	CompanyModel, 
	LeavesModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	EmploymentsModel,
	Division,
	Department,
	Section,
	LeaveDateModel,
	UndertimeModel,
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'custom-form-undertime');
	}).then(function(data){
		user_role = data;
		res.render('CustomForm/Undertime/index',{
			route: 'custom-form-undertime',
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
        let user_id = req.body.employee;

        req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
        req.checkBody('date').notEmpty().withMessage('The start date field is required.');
        req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
        let errors = req.validationErrors();

        if(errors){
            res.status(422).json({
                success: false,
                errors
            });
        }else{
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

            let primary_approver = req.body.approver_id;
            let secondary_approver = req.body.approver_secondary_id;
            let undertime = req.body.undertime;
            let date = res.locals.moment(req.body.date).format('YYYY-MM-DD');
            let time = res.locals.moment(req.body.date).format('HH:mm:ss');
            

            let inputData = {
                user_id: user_id,
                date: date,
                time: time,
                reason: req.body.reason,
                primary_status: 1,
                backup_status: 1,
                primary_approver: primary_approver,
                backup_approver: secondary_approver,
                secretary_id: user.id,
                _token: uuidv4()
            }

            if(attachment && attachment.size > 0){                
                inputData.attachment = filename
            }

            UndertimeModel.count({
                where: {
                    user_id: user_id,
                    primary_status: {[Op.lte]:2},
                    date: date
                }
            }).then(function(data){
                if(data == 0){
                    UndertimeModel.create(inputData).then(function(data){
                        let insertId = data.id

                        res.status(200).json({
                            success: true,
                            action: 'fetch',
                            msg: 'New record has been successfully saved.'
                        });
                    });
                }else{
                    var error = [
                        {	
                            param: 'date',
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

exports.update = function(req, res){
    let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
        req.checkBody('date').notEmpty().withMessage('The start date field is required.');
    
	    let user = res.locals.user;
        let errors = req.validationErrors();
        if(errors){
            res.status(422).json({
                success: false,
                errors
            });
        }else{
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
            
            let id = req.body.id;
            let date = res.locals.moment(req.body.date).format('YYYY-MM-DD');
            let time = res.locals.moment(req.body.date).format('HH:mm:ss');
            UndertimeModel.count({
                where: {
                    id: {
                        $not: id
                    },
                    user_id: user.id,
                    date: date
                }
            }).then(function(data){
                if(data == 0){
                    let inputData = {
                        date: date,
                        time: time,
                        reason: req.body.reason
                    }

                    if(attachment && attachment.size > 0){                
                        inputData.attachment = filename
                    }
                    
                    UndertimeModel.update(inputData, {
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
                            param: 'date',
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

exports.fetch = function (req, res) {
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
            where.date = {
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

            where.date = {
                $between: [start, end]
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

            UndertimeModel.findAndCountAll({
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
                undertimes = data;
                numrows = undertimes.count;
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
                    records: undertimes.rows,
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
    if ((start && end) && (start <= end)) {
        where.date = {
            $between: [start, end]
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
                $between: [start, end]
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

            UndertimeModel.findAndCountAll({
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
                undertimes = data;
                numrows = undertimes.count;
                count = 0;
                if (limit < numrows) {
                    count = numrows / limit;
                    count = Math.ceil(count);
                } else {
                    count = 0;
                }
                let record = undertimes.rows;
                let fields = ['Date Filed', 'Employee', 'Date', 'Reason', 'Approved By', 'Status'];
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
                            'Date': moment(record[i].date).format('MM/DD/YYYY') + ' ' + moment(record[i].time).format('HH:mm:ss'),
                            'Reason': record[i].reason,
                            'Approved By': record[i].primary ? record[i].primary.last_name + ', ' + record[i].primary.first_name : '--',
                            'Status': status,
                        });
                    }
                }
                let filename = 'Custom_undertime_' + moment(start).format('YYYYMMDD');
                const json2csvParser = new Parser({ fields });
                const csv = json2csvParser.parse(arrayData);
                res.attachment(filename + '.csv');
                res.status(200).send(csv);
            })
        })
    })
}

exports.delete = function(req, res){
	let id = req.body.id;
	let data = {
		primary_status: 4,
		backup_status: 4,
	}

	UndertimeModel.update(data, {
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
		order:[
			['last_name','ASC']
		]
	}).then(data=>{
		users = data;
		res.status(200).json({
            success: true,
            users: users,
        });
	})
}
