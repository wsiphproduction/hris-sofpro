const UserRole = require('../Helper/UserRole');
const { convertCSVToArray } = require('convert-csv-to-array');
var { Parser } = require('json2csv');
const csv = require('csv-parser')
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const PrepareMail = require('../Helper/PrepareMail');
const Notification = require('../Helper/Notification');
const _ = require('underscore');
const $env 	= require('dotenv').config();
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
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'custom-form-leave');
	}).then(function(data){
		user_role = data;
		if(!(user_role.read || res.locals.isSupervisor > 0)){
			res.render('Errors/403');
		}else{
			res.render('CustomForm/Leave/index',{
				route: 'custom-form-leave',
				usrRole: usrRole,
				user_role: user_role,
			});
		}
		
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;

		req.checkBody('leave_type').notEmpty().withMessage('The leave policy field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('leave_object_string_converted').notEmpty().withMessage('The leave credit and leave duration field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let userID 				= req.body.employee;
			let primary_approver 	= req.body.approver_id;
			let secondary_approver 	= req.body.approver_secondary_id;
			let leave_type 			= req.body.leave_type;
			let other       		= req.body.other;
			let leave_object 		= JSON.parse(req.body.leave_object_string_converted);

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

			//NUMBER OF DAYS & GETING THE DATES 
			let date=leave_object.map(item=>item.date);
			let no_of_days = 0;
			for(item in leave_object){
				if(leave_object[item].date_is_filed)
				{
					no_of_days += parseFloat((leave_object[item].leave_duration>0)?.5:1);
				}
			}

			let start_date = date[0];
			let end_date = date.pop();

			// Check if VL is 2 days in advance
			let VL_ID = $env.parsed.VL_ID ? $env.parsed.VL_ID : 10;
			let VL_ADVANCE = $env.parsed.VL_ADVANCE ? $env.parsed.VL_ADVANCE : 2;
			let leave_date = moment().add(VL_ADVANCE,'days').format('MM/DD/YYYY');

			if (req.body.leave_type == VL_ID && (start_date <= leave_date)){
				req.checkBody('dates').notEmpty().isLength({ max: 1 }).withMessage('Vacation leave should be 2 days advance.');
				let errors = req.validationErrors();
				res.status(422).json({
					success: false,
					errors
				});
			} else {
				let data = {
					user_id			: userID,
					start_date		: res.locals.moment(new Date(start_date)).format('YYYY-MM-DD'),
					end_date		: res.locals.moment(new Date(end_date)).format('YYYY-MM-DD'),
					leave_type		: req.body.leave_type,
					other			: leave_type == 5 ? other : '',
					no_of_days		: no_of_days,
					credit			: 1,
					reason			: req.body.reason,
					attachment		: filename,
					primary_status	: 1,
					is_hr			: 1,
					primary_approver: primary_approver,
					backup_approver	: secondary_approver,
					_token			: uuidv4(),
					secretary_id	: user.id,
					leave_duration	: no_of_days,
				}
				LeavesModel.create(data).then(function(data){
					let insertId 		= data.id;

					for(let x in leave_object){

						let numdays = (leave_object[x].leave_duration == 0) ? 1 : 0.5;
						let dateData = {
							leave_id: insertId,
							user_id: userID,
							date: res.locals.moment(new Date(leave_object[x].date)).format('YYYY-MM-DD'),
							number_of_day: (leave_object[x].date_is_filed) ? numdays : 0,
							leave_duration: (leave_object[x].date_is_filed) ? leave_object[x].leave_duration : 0,
							credit: (leave_object[x].date_is_filed) ? leave_object[x].leave_credit : null,
							date_is_filed: (leave_object[x].date_is_filed) ? 1 : 0,
						}
						LeaveDateModel.create(dateData);
					}
					//Send Mail
					//PrepareMail.leave(insertId, res.locals.baseUrl);
					//CustomLeaveHelper._set(insertId);

					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'New record has been successfully saved.'
					});
				});
			}
		}
		
	});
}

exports.update = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/attachments/';
	
	let form = new formidable.IncomingForm();

	form.parse(req, function (err, fields, files) {
		req.body = fields;

		req.checkBody('leave_type').notEmpty().withMessage('The leave policy field is required.');
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
		req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
		req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('leave_object_string_converted').notEmpty().withMessage('The leave credit and leave duration field is required.');
		let errors = req.validationErrors();


		if(errors){

			res.status(422).json({
				success: false,
	            errors
			});

		}else{
			let id 					= req.body.id;
			let userID 				= req.body.employee;
			let primary_approver 	= req.body.approver_id;
			let secondary_approver 	= req.body.approver_secondary_id;
			let leave_object		= JSON.parse(req.body.leave_object_string_converted);	

			LeavesModel.findOne({
				where: {
					id: id,
					// user_id: user.id
				}
			}).then(function(response){
				if(!response) res.status(404).json({
					success: false,
					msg: 'No record found for the given selection.'
				});

				//GET THE INFORMATION OF THE LEAVE
				record = response;

				//ARRANGE DATES IN LEAVE_OBJECT
				leave_object.sort((a,b)=>{
					return new Date(a.date) - new Date(b.date);
				});

				//NUMBER OF DAYS & GETING THE DATES 
				let date=leave_object.map(item=>item.date);
				let no_of_days = 0;
				for(item in leave_object){
					if(leave_object[item].date_is_filed)
					{
						no_of_days += parseFloat((leave_object[item].leave_duration>0)?.5:1);
					}
				}

				let start_date = date[0];
				let end_date = date.pop();		

				
				//FILE UPLOADING
				let attachment 		= files.attachment;
				let filename 		= null;
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

				let data = {
					start_date		: res.locals.moment(new Date(start_date)).format('YYYY-MM-DD'),
					end_date		: res.locals.moment(new Date(end_date)).format('YYYY-MM-DD'),
					leave_type		: req.body.leave_type,
					no_of_days		: no_of_days,
					credit			: 1,
					reason			: req.body.reason,
					leave_duration	: no_of_days,
					primary_approver: primary_approver,
					backup_approver	: secondary_approver,
					
					// other: req.body.leave_type == 5 ? req.body.other : '',
				}
				if(filename){
					data.attachment = filename;
				}

				//UPDATING VALUES
				LeavesModel.update(data, {
					where: {
						id: id
					}
				}).then(function(data){
					//DELETE FORMER LEAVE DATES THEN CREATE NEW LEAVE DATES
					LeaveDateModel.destroy({
						where: {
							leave_id: id
						}
					}).then(function(data){
						for(let x in leave_object){
							let numdays = (leave_object[x].leave_duration == 0) ? 1 : 0.5;
							let dateData = {
								leave_id		: id,
								user_id			: userID,
								date			: res.locals.moment(new Date(leave_object[x].date)).format('YYYY-MM-DD'),
								number_of_day	: (leave_object[x].date_is_filed) ? numdays : 0,
								leave_duration	: (leave_object[x].date_is_filed) ? leave_object[x].leave_duration : 0,
								credit			: (leave_object[x].date_is_filed) ? leave_object[x].leave_credit : null,
								date_is_filed	: (leave_object[x].date_is_filed) ? 1 : 0,
							}
							LeaveDateModel.create(dateData);
						}


						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'Record has been successfully updated.'
						});

					});
					
				});
			});
		}
	});
}

exports.fetch = function(req, res){
	let user 		= res.locals.user;
	let employee 	= req.body.employee;
	let start 		= req.body.start;
	let end 		= req.body.end;
	let status 		= req.body.status;
	let limit   	= parseInt(req.body.limit);
	let page 		= req.body.page;
	let offset  	= (parseInt(page) - 1) * parseInt(limit);
 	let key 		= req.body.key;
	let startOf 	= null;
	let endOf 		= null;
	let session 	= req.session;

	let approvingOrganization 	= res.locals.approvingOrganization;
	let approvingOrganizationId = res.locals.approvingOrganizationId;
	
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
		where.primary_status = status;
	}else{
		where.primary_status = {
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

		if(session.user){
            month_date = new Date(session.user.default_month_date);
            period = session.user.default_period
        } else {
            month_date = new Date();
            period = 'A'
        }
		
		if((start && end) && (start <= end)){
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
			
			// let user_id = [];
			// if (employment && employment.length) {
			// 	for (let i in employment) {
			// 		user_id.push(employment[i].user_id);
			// 	}
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

			if(key) {
				whereUser = {
					// id:  {
					// 		[Op.in]: user_id
					// },
					[Op.and]: [
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
				// 		[Op.in]: user_id
				// }
			}
			
			return UsersModel.findAll({
				where: whereUser,
				raw: false,
			}).then(data=>{
				users = data;
				let results = [];
				if(users && users.length){
					results = _.pluck(users, 'id');
					results = [...new Set(results)];
				}
			
				where.user_id = {
						[Op.in]: results
				}

				LeavesModel.count({
					where: where
				}).then(function(data){
					numrows = data;
					return LeaveDateModel.findAll({
						where: {
							user_id: user.id
						},
						attributes: ['date']
					});
					
				}).then(function(data){
				disableDates = data;
				return LeavesModel.findAll({
					where: where,
					order: [
						['created_at', 'DESC']
					],
					offset: offset,
					limit: limit,
					include: [
						{
							model: UsersModel, 
							as: 'applicant',
							attributes: ['id', 'first_name', 'last_name', 'employee_number']
						},
						{
							model: UsersModel, 
							as: 'primary',
							attributes: ['id', 'first_name', 'last_name']
						},
						{
							model: UsersModel, 
							as: 'backup',
							attributes: ['id', 'first_name', 'last_name']
						},
						{
							model: LeavePolicyModel,
							attributes: ['name']
						},
						{
							model: LeaveDateModel
						}
					]
				});
				}).then(function(data){
					records = data;
					if(limit < numrows){
						count = numrows / limit;
						count = Math.ceil(count);
					}else{
						count = 0;
					}
					res.status(200).json({
						success: true,
						records: records,
						count: count,
						disableDates: disableDates,
						config: config,
						session: session
				});
			});
		});
	});
}

exports.export = function (req, res){
    let user 		= res.locals.user;
    let employee 	= req.body.employee;
    let start 		= req.body.start;
    let end 		= req.body.end;
    let status 		= req.body.status;
    let limit 		= parseInt(req.body.limit);
    let page 		= req.body.page;
    let offset 		= (parseInt(page) - 1) * parseInt(limit);
    let startOf 	= null;
    let endOf 		= null;
    let session 	= req.session;
	let approvingOrganization 	= res.locals.approvingOrganization;
	let approvingOrganizationId = res.locals.approvingOrganizationId;

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

            LeavesModel.count({
                where: where
            }).then(function (data) {
                numrows = data;
                return LeaveDateModel.findAll({
                    where: {
                        user_id: user.id
                    },
                    attributes: ['date']
                });

            }).then(function (data) {
                disableDates = data;
                return LeavesModel.findAndCountAll({
                    where: where,
                    order: [
                        ['created_at', 'DESC']
                    ],
                    offset: offset,
                    limit: limit,
                    include: [
                        {
                            model: UsersModel,
                            as: 'applicant',
                            attributes: ['id', 'first_name', 'last_name']
                        },
                        {
                            model: UsersModel,
                            as: 'primary',
                            attributes: ['id', 'first_name', 'last_name']
                        },
                        {
                            model: LeavePolicyModel,
                            attributes: ['name']
                        },
                        {
                            model: LeaveDateModel
                        }
                    ]
                });
            }).then(function (data) {
                leaves = data;
                numrows = leaves.count;
                count = 0;
                if (limit < numrows) {
                    count = numrows / limit;
                    count = Math.ceil(count);
                } else {
                    count = 0;
                }
                let record = leaves.rows;
                let fields = ['Date Filed', 'Employee', 'Date', 'No. of Days', 'Leave Type', 'Credit', 'Purpose', 'Approved By', 'Status'];
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
                            //'Date': moment(start).format('MM/DD/YYYY') + ' - ' + moment(end).format('MM/DD/YYYY'),
							'Date': moment(record[i].start_date).format('MM/DD/YYYY') + ' - ' + moment(record[i].end_date).format('MM/DD/YYYY'),
                            'No. of Days': record[i].no_of_days + ' day(s)',
                            'Leave Type': record[i].leave_policy ? record[i].leave_policy.name : '',
                            'Credit': record[i].credit == 1 ? 'With Pay' : 'Without Pay',
                            'Purpose': record[i].reason,
                            'Approved By': record[i].primary ? record[i].primary.first_name + ' ' + record[i].primary.last_name : '--',
                            'Status': status,
                        });
                    }
                }
                let filename = 'Custom_leave_' + moment(start).format('YYYYMMDD');
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
	LeaveDateModel.destroy({
		where:{
			leave_id: id
		}
	}).then((data)=>{
		LeavesModel.destroy({
			where: {
				id: id
			}
		}).then(data=>{
			res.status(200).json({
				success: true
			});
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
	});
}

exports.get_policy = function(req,res){
	let user = res.locals.user;
	let userID = req.body.id ? req.body.id : user.id;

	UsersModel.findByPk(userID).then(function(data){
		let user = data;
		let gender = '';
		if(user && typeof user.gender != 'undefined'){
			gender = user.gender;
		}
		let company_id = user.company_branch_id ? user.company_branch_id : '';
		let department = user.department_id ? user.department_id : '';

		LeavePolicyModel.findAll({
			where: {
				status: 1,
				gender: {
					$or: [null, '', gender]
				},
				company: {
					$or: [null, '', company_id]
				},
				department: {
					$or: [null, '', department]
				}
			},
			attributes: ['id','name','gender'],
			include: [
				{
					model: LeaveCreditPolicyModel,
					where: {
						user_id: user.id
					},
					required: false,
					attributes: ['id','balance', 'utilized']
				}
			],
			order: [
				['name', 'ASC']
			]
		}).then(function(data){
			policy = data;
			res.status(200).json({
				success: true,
				policy: policy,
			});			
		})
	});
}

exports.get_vl_id = function(req,res){
	res.status(200).json({
		vl: {
			id			: $env.parsed.VL_ID,
			date_advance: $env.parsed.VL_DATE_ADVANCE,
		},
	});
}