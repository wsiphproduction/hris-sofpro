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
	LeaveDateModel,
	ShiftsModel,
	ShiftType,
	EmploymentsModel,
	ConfigModel
} = require('../../config/Sequelize');



exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'custom-form-change-shift');
	}).then(function(data){
		user_role = data;
		res.render('CustomForm/ChangeShift/index',{
			route: 'custom-form-change-shift',
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
        let user_id = req.body.employee
        
        //req.checkBody('old_date').notEmpty().withMessage('The old field is required.');
        req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
        req.checkBody('new_date').notEmpty().withMessage('The new date field is required.');
        req.checkBody('shift_type').notEmpty().withMessage('The shift type field is required.');
        req.checkBody('cur_shift_type').notEmpty().withMessage('The old shift type is required');
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
                        shift_id: req.body.shift_type
                    }
                });
                
            }).then(data=>{
                shift_type = data;

                let old_checkin = shift ? shift.check_in ? res.locals.moment(shift.check_in).utc().format('HH:mm:ss'): null : null;
                let old_checkout = shift ? shift.check_out ? res.locals.moment(shift.check_out).utc().format('HH:mm:ss'): null : null;
                let old_date_checkin = old_checkin ? shift.date + " " + old_checkin : null;
                let old_date_checkout = old_checkout ? shift.date + " " + old_checkout : null; 

                // Adapt Old checkin depending on shift
                if (old_date_checkin && (shift.shift_type == '10PM TO 7AM' || shift.shift_type == '1st SHIFT' || shift.shift_type ==  '1st SHIFT GEO' || shift.shift_type ==  'LEVEL 6 1' || shift.shift_type ==  'Security 1' )){
                    old_date_checkin = res.locals.moment(old_date_checkin).subtract(1,'days').format('YYYY-MM-DD HH:mm:ss');
                } 
                if(shift && (old_date_checkin > old_date_checkout)){
                    old_date_checkout = res.locals.moment(old_date_checkout).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
                }

                let new_checkin = shift_type.shift_id == 'NONE' ? null : res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_in).utc().format('HH:mm:ss');
                let new_checkout = shift_type.shift_id == 'NONE' ? null : res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_out).utc().format('HH:mm:ss');
                // Adapt New checkin depending on shift
                if (new_checkin && (shift_type.shift_id == '10PM TO 7AM' || shift_type.shift_id == '1st SHIFT' || shift_type.shift_id ==  '1st SHIFT GEO' || shift_type.shift_id ==  'LEVEL 6 1' || shift_type.shift_id ==  'Security 1' )){
                    new_checkin = res.locals.moment(new_checkin).subtract(1,'days').format('YYYY-MM-DD HH:mm:ss');
                } 
                if(new_checkin > new_checkout){
                    new_checkout = res.locals.moment(new_checkout).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
                }
                
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
                    date: req.body.new_date,
                    primary_approver: req.body.approver_id,
                    backup_approver: req.body.approver_secondary_id,
                    new_checkin: new_checkin ? new_checkin: null,
                    new_checkout: new_checkout ? new_checkout: null,
                    is_change_shift: 1,
                    old_checkin: old_date_checkin ? old_date_checkin: null,
                    old_checkout: old_date_checkout ? old_date_checkout: null,
                    new_shift_type: shift_type.shift_id,
                    secretary_id: user.id
                }

                if(attachment && attachment.size > 0){
                    reqData.attachment = filename
                }

                if (shift && (shift.primary_status ==1 && shift.is_change_shift == 1)){
                    var error = [
                        {	
                            param: 'new_date',
                            msg: 'Date has already been taken.'
                        }
                    ]
                    res.status(422).json({
                        success: false,
                        errors: error
                    });
                } else {
                    ShiftsModel.update(reqData, {
                        where: {
                            id: id,
                        }
                    }).then(data=>{
                        res.status(200).json({
                            success: true,
                            action: 'fetch',
                            msg: 'Record has been successfully updated.'
                        });
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
        let id = req.body.id;
        req.checkBody('new_date').notEmpty().withMessage('The new date field is required.');
        req.checkBody('shift_type').notEmpty().withMessage('The shift type field is required.');
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
                        shift_id: req.body.shift_type
                    }
                });
                
            }).then(data=>{
                shift_type = data;
                let new_checkin = shift_type.shift_id == 'NONE' ? null : res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_in).utc().format('HH:mm:ss');
                let new_checkout = shift_type.shift_id == 'NONE' ? null : res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_out).utc().format('HH:mm:ss');
                if(new_checkin > new_checkout){
                    new_checkout = res.locals.moment(new_checkout).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
                }

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

                let reData = {
                    new_checkin: new_checkin ? new_checkin : null,
                    new_checkout: new_checkout ? new_checkout : null,
                    new_shift_type: shift_type.shift_id,
                }

                if(attachment && attachment.size > 0){                
                    reData.attachment = filename
                }
                
                ShiftsModel.update(reData,{
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

    where.is_change_shift = 1;

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

            ShiftsModel.findAndCountAll({
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

            ShiftsModel.findAndCountAll({
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
                //console.log(shifts);
                numrows = shifts.count;
                count = 0;
                if (limit < numrows) {
                    count = numrows / limit;
                    count = Math.ceil(count);
                } else {
                    count = 0;
                }
                let record = shifts.rows;
                let fields = ['Employee', 'TimeIn', 'TimeOut', 'NewTimeIn', 'NewTimeOut', 'Approved By', 'Status'];
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
                            'Employee': record[i].applicant.last_name + ', ' + record[i].applicant.first_name,
                            'TimeIn': record[i].old_checkin ? moment(record[i].old_checkin).utc().format('MM/DD/YYYY hh:mmA') : '',
                            'TimeOut': record[i].old_checkout ? moment(record[i].old_checkout).utc().format('MM/DD/YYYY hh:mmA') : '',
                            'NewTimeIn': record[i].new_checkin ? moment(record[i].new_checkin).utc().format('MM/DD/YYYY hh:mmA') : '',
                            'NewTimeOut': record[i].new_checkout ? moment(record[i].new_checkout).utc().format('MM/DD/YYYY hh:mmA') : '',
                            'Approved By': record[i].primary ? record[i].primary.last_name + ', ' + record[i].primary.first_name : '--',
                            'Status': status,
                        });
                    }
                }
                let filename = 'Custom_change_shift_' + moment(start).format('YYYYMMDD');
                const json2csvParser = new Parser({ fields });
                const csv = json2csvParser.parse(arrayData);
                res.attachment(filename + '.csv');
                res.status(200).send(csv);
            })
        })
    })
}

exports.getshift = function(req, res){
	let user_id = req.body.id;
	let date = res.locals.moment().subtract(30, 'days').format('YYYY-MM-DD');
	let shift_type = '';
	ShiftsModel.findAll({
		where: {
			user_id: user_id,
			// new_checkin: {
			// 	[Op.eq]: null
			// },
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
	let reData = {
		primary_status: 1,
		primary_approver: null,
		new_checkin: null,
		new_checkout: null,
		is_change_shift: null,
		old_checkin: null,
		old_checkout: null,
		new_shift_type: null,
		secretary_id: null
	}
	ShiftsModel.update(reData, {
		where: {
			primary_status: 1,
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