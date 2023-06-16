const UserRole = require('../Helper/UserRole');
var { Parser } = require('json2csv');
const { 
	Op,
	ConfigModel,
	Division,
	UsersModel,
	sequelize,
	CompanyModel,
	ShiftType
} = require('../../config/Sequelize');
const formidable = require('formidable');
const fs = require('fs');
const csv = require('csv-parser');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-shift-management');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/ShiftManagement/index',{
				user_role: user_role,
				route: 'settings-shift-management',
				usrRole: usrRole
			});
		}
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('shift_id').notEmpty().withMessage('The Shift ID field is required.');
	req.checkBody('shift_desc').notEmpty().withMessage('The Shift Description field is required.');
	req.checkBody('shift_opt').notEmpty().withMessage('The Shift Option field is required.');
	req.checkBody('time_in').notEmpty().withMessage('The Time-in field is required.');
	req.checkBody('time_out').notEmpty().withMessage('The Time-out field is required.');
	req.checkBody('num_hours').notEmpty().withMessage('The Number of Hours field is required.');
	req.checkBody('is_from_previous').notEmpty().withMessage('The Get Time In From Previous Date field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		ShiftType.count({
			where:{
				shift_id: req.body.shift_id
			}
		}).then(data=>{
			count = data;
			let reqData = {
				shift_id: req.body.shift_id,
				shift_desc: req.body.shift_desc,
				shift_opt: req.body.shift_opt,
				credit_time_in: formatTime(res, changeEmptyToNull(req.body.credit_time_in)),
				credit_time_out: formatTime(res, changeEmptyToNull(req.body.credit_time_out)),
				time_in: formatTime(res, req.body.time_in),
				time_out: formatTime(res, req.body.time_out),
				gp: changeEmptyToNull(req.body.gp),
				break_in: formatTime(res, changeEmptyToNull(req.body.break_in)),
				break_out: formatTime(res, changeEmptyToNull(req.body.break_out)),
				num_hours: req.body.num_hours,
				cbamin: formatTime(res, changeEmptyToNull(req.body.cbamin)),
				cbamout: formatTime(res, changeEmptyToNull(req.body.cbamout)),
				cbpmin: formatTime(res, changeEmptyToNull(req.body.cbpmin)),
				cbpmout: formatTime(res, changeEmptyToNull(req.body.cbpmout)),
				trig_late: formatTime(res, changeEmptyToNull(req.body.trig_late)),
				trig_under: formatTime(res, changeEmptyToNull(req.body.trig_under)),
				early_in: formatTime(res, changeEmptyToNull(req.body.early_in)),
				early_out: formatTime(res, changeEmptyToNull(req.body.early_out)),
				late_in: formatTime(res, changeEmptyToNull(req.body.late_in)),
				late_out: formatTime(res, changeEmptyToNull(req.body.late_out)),
				flex_am_break: changeEmptyToNull(req.body.flex_am_break),
				flex_pm_break: changeEmptyToNull(req.body.flex_pm_break),
				flex_break: changeEmptyToNull(req.body.flex_break),
				min_ot: changeEmptyToNull(req.body.min_ot),
				hday_by_late: changeEmptyToNull(req.body.hday_by_late),
				ot_type: changeEmptyToNull(req.body.ot_type),
				break_hours: changeEmptyToNull(req.body.break_hours),
				seq_id: changeEmptyToNull(req.body.seq_id),
				gp2: changeEmptyToNull(req.body.gp2),
				trig_absent: changeEmptyToNull(req.body.trig_absent),
				min_workhours_1h: changeEmptyToNull(req.body.min_workhours_1h),
				min_workhours_2h: changeEmptyToNull(req.body.min_workhours_2h),
				created_terminal: changeEmptyToNull(req.body.terminal),
				status: req.body.status,
				is_from_previous: req.body.is_from_previous,

				created_by: user.id
			}
			
			if(count){
				var errors = [
					{	
						param: 'shift_id',
						msg: 'The Sgift ID has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				ShiftType.create(reqData).then(data=>{
					res.status(201).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been successfully saved.'
					});
				});
			}
		});
	}
}

exports.update = function(req, res){
	let user = res.locals.user;
	req.checkBody('shift_id').notEmpty().withMessage('The Shift ID field is required.');
	req.checkBody('shift_desc').notEmpty().withMessage('The Shift Description field is required.');
	req.checkBody('shift_opt').notEmpty().withMessage('The Shift Option field is required.');
	req.checkBody('time_in').notEmpty().withMessage('The Time-in field is required.');
	req.checkBody('time_out').notEmpty().withMessage('The Time-out field is required.');
	req.checkBody('num_hours').notEmpty().withMessage('The Number of Hours field is required.');
	req.checkBody('is_from_previous').notEmpty().withMessage('The Get Time In From Previous Date field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
			let reqData = {
				shift_id: req.body.shift_id,
				shift_desc: req.body.shift_desc,
				shift_opt: req.body.shift_opt,
				credit_time_in: formatTime(res, changeEmptyToNull(req.body.credit_time_in)),
				credit_time_out: formatTime(res, changeEmptyToNull(req.body.credit_time_out)),
				time_in: formatTime(res, req.body.time_in),
				time_out: formatTime(res, req.body.time_out),
				gp: changeEmptyToNull(req.body.gp),
				break_in: formatTime(res, changeEmptyToNull(req.body.break_in)),
				break_out: formatTime(res, changeEmptyToNull(req.body.break_out)),
				num_hours: req.body.num_hours,
				cbamin: formatTime(res, changeEmptyToNull(req.body.cbamin)),
				cbamout: formatTime(res, changeEmptyToNull(req.body.cbamout)),
				cbpmin: formatTime(res, changeEmptyToNull(req.body.cbpmin)),
				cbpmout: formatTime(res, changeEmptyToNull(req.body.cbpmout)),
				trig_late: formatTime(res, changeEmptyToNull(req.body.trig_late)),
				trig_under: formatTime(res, changeEmptyToNull(req.body.trig_under)),
				early_in: formatTime(res, changeEmptyToNull(req.body.early_in)),
				early_out: formatTime(res, changeEmptyToNull(req.body.early_out)),
				late_in: formatTime(res, changeEmptyToNull(req.body.late_in)),
				late_out: formatTime(res, changeEmptyToNull(req.body.late_out)),
				flex_am_break: changeEmptyToNull(req.body.flex_am_break),
				flex_pm_break: changeEmptyToNull(req.body.flex_pm_break),
				flex_break: changeEmptyToNull(req.body.flex_break),
				min_ot: changeEmptyToNull(req.body.min_ot),
				hday_by_late: changeEmptyToNull(req.body.hday_by_late),
				ot_type: changeEmptyToNull(req.body.ot_type),
				break_hours: changeEmptyToNull(req.body.break_hours),
				seq_id: changeEmptyToNull(req.body.seq_id),
				gp2: changeEmptyToNull(req.body.gp2),
				trig_absent: changeEmptyToNull(req.body.trig_absent),
				min_workhours_1h: changeEmptyToNull(req.body.min_workhours_1h),
				min_workhours_2h: changeEmptyToNull(req.body.min_workhours_2h),
				created_terminal: changeEmptyToNull(req.body.terminal),
				status: req.body.status,
				is_from_previous: req.body.is_from_previous,

				created_by: user.id
			}
		
		ShiftType.update(reqData,{
			where:{
				id:id
			}
		}).then(data=>{
			res.status(201).json({
				success: true,
				action: 'fetch',
				msg: 'Record has been successfully updated.'
			});
		});
	}
}

exports.fetch = function(req, res){
	let status = req.body.status;
	let limit = req.body.limit ? parseInt(req.body.limit) : 25;
    let page = req.body.page ? req.body.page : 1;
    let offset   = (parseInt(page) - 1) * parseInt(limit);
    
	let where = {
    	deletedAt: null
    }
    if(status != ''){
    	where.status = status;
    }
    ShiftType.findAndCountAll({
    	where: where,
    	limit: limit,
        offset: offset,
    	order:[
    		['id','asc']
    	],
    	raw: false,
    }).then(data=>{
    	shift_type = data;
    	numrows = shift_type.count;
        count = 0;
        if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
            count = 0;
        }
        res.status(200).json({
            success: true,
            count: count,
            records: shift_type.rows,
            numrows: numrows,
        });
    });
}

const formatTime = function(res, input){
	return input ? res.locals.moment(input).format('HH:mm:ss') : input;
}

const changeEmptyToNull = function(input){
	return input = '' ? null : input
}

exports.init = function(req, res){
	UsersModel.findAll({
		where:{
			status: 1
		},
		order:[
			['first_name','asc']
		],
		attributes:['id','first_name','last_name']
	}).then(data=>{
		users = data;
		return CompanyModel.findAll({
			where:{
				status: 1
			},
			order:[
				['name','asc']
			],
			attributes:['id','name']
		});
	}).then(data=>{
		companies = data;
		res.status(200).json({
			success: true,
            users,
            companies
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	ShiftType.update({
        deletedAt: res.locals.moment(req.body.birthdate).format('YYYY-MM-DD HH:mm:ss')
    },{
        where: {
            id: id
        }
    }).then(data => {
        res.status(201).json({
            success: true
        });
    })
}