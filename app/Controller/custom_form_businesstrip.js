const UserRole = require('../Helper/UserRole');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser');
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
	DisputeModel,
	BusinessTripsModel,
	BusinessTripDate,
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'custom-form-businesstrip');
	}).then(function(data){
		user_role = data;
		if(!(user_role.read || res.locals.isSupervisor > 0)){
			res.render('Errors/403');
		}else{
			res.render('CustomForm/BusinessTrip/index',{
				route: 'custom-form-businesstrip',
				usrRole: usrRole,
				user_role: user_role,
			});
		}
		
	});
}

exports.store = function(req, res){
    let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
        let user = res.locals.user;
        let user_id = req.body.employee ? req.body.employee:'';
        req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
        req.checkBody('note').notEmpty().withMessage('The note field is required.');
        req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
        req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
        req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
        let errors = req.validationErrors();

        if(errors){
            res.status(422).json({
                success: false,
                errors
            });
        }else{

            let startDate = res.locals.moment(new Date(req.body.start_date)).format('YYYY-MM-DD');
            let endDate   = res.locals.moment(new Date(req.body.end_date)).format('YYYY-MM-DD');
            let primary_approver = req.body.approver_id;
            let secondary_approver = req.body.approver_secondary_id;
            
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

            let inputData = {
                user_id: req.body.employee,
                date_start: startDate,
                date_end: endDate,
                note: req.body.note,
                primary_status: 1,
                primary_approver: primary_approver,
                backup_approver: secondary_approver,
                secretary_id: user.id,
                _token: uuidv4()
            }
            
            if(attachment && attachment.size > 0){
                inputData.attachment = filename
            }

            BusinessTripsModel.create(inputData).then(function(data){
                let insertId = data.id
                let dates = [];
                let currDate = moment(new Date(startDate)).startOf("day");
                let lastDate = moment(new Date(endDate)).startOf("day");
                do {
                dates.push(currDate.clone().toDate());
                } while (currDate.add(1, "days").diff(lastDate) < 0);
                dates.push(currDate.clone().toDate());
                for(let i in dates){
                    let date = moment(dates[i]).format('YYYY-MM-DD');
                    let BData =  {
                        bid: insertId,
                        date: date,
                        user_id: inputData.user_id
                    }
                    BusinessTripDate.create(BData);
                }
                res.status(200).json({
                    success: true,
                    action: 'fetch',
                    msg: 'New record has been successfully saved.'
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
        let user = res.locals.user;
        req.checkBody('note').notEmpty().withMessage('The note field is required.');
        req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
        req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
        let errors = req.validationErrors();

        if(errors){
            res.status(422).json({
                success: false,
                errors
            });
        }else{
            let id = req.body.id;
            let startDate = res.locals.moment(new Date(req.body.start_date)).format('YYYY-MM-DD');
            let endDate   = res.locals.moment(new Date(req.body.end_date)).format('YYYY-MM-DD');
            let primary_approver = req.body.approver_id;

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

            let inputData = {
                date_start: startDate,
                date_end: endDate,
                note: req.body.note,
                _token: uuidv4()
            }
            
            if(attachment && attachment.size > 0){
                inputData.attachment = filename
            }
            
            BusinessTripDate.destroy({
                where:{
                    bid: id
                }
            });

            BusinessTripsModel.update(inputData,{
                where:{
                    id: id
                }
            }).then(function(data){
                let dates = [];
                let currDate = moment(new Date(startDate)).startOf("day");
                let lastDate = moment(new Date(endDate)).startOf("day");
                do {
                dates.push(currDate.clone().toDate());
                } while (currDate.add(1, "days").diff(lastDate) < 0);
                dates.push(currDate.clone().toDate());
                for(let i in dates){
                    let date = moment(dates[i]).format('YYYY-MM-DD');
                    let BData =  {
                        bid: id,
                        date: date,
                        user_id: inputData.user_id
                    }
                    BusinessTripDate.create(BData);
                }
                res.status(200).json({
                    success: true,
                    action: 'fetch',
                    msg: 'New record has been successfully saved.'
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
            where.date_start = {
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

            where.date_start = {
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

            BusinessTripsModel.findAndCountAll({
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
                    records: overtimes.rows,
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
        where.date_start = {
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

            BusinessTripsModel.findAndCountAll({
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
                trips = data;
                numrows = trips.count;
                count = 0;
                if (limit < numrows) {
                    count = numrows / limit;
                    count = Math.ceil(count);
                } else {
                    count = 0;
                }
                let record = trips.rows;
                let fields = ['Date Filed', 'Employee', 'Date', 'Note', 'Approved By', 'Status'];
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
                            'Date': moment(record[i].date_start).format('MM/DD/YYYY') + '—' + moment(record[i].date_end).format('MM/DD/YYYY'),
                            'Note': record[i].note,
                            'Approved By': record[i].primary ? record[i].primary.last_name + ' ' + record[i].primary.first_name : '--',
                            'Status': status,
                        });
                    }
                }
                let filename = 'Custom_business_trip_' + moment(start).format('YYYYMMDD');
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

	BusinessTripsModel.update(data, {
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
		res.status(200).json({
            success: true,
            users: users,
        });
	})
}
