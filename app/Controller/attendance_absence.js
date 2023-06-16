const UserRole = require('../Helper/UserRole');
const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const { 
	sequelize,
	UsersModel,
	ShiftsModel
} = require('../../config/Sequelize');
const Holiday = require('../Scheduler/Holiday');
exports.index = function(req, res){
	let user = res.locals.user;
	// Holiday.proccess();
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-absence');
	}).then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			res.render('Attendance/Absence/index',{
				route: 'attendance-absence',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.fetch = function(req, res){
	let user = res.locals.user;
	let year = req.body.year;
	let userId = req.body.user;
	let company = req.body.company;
	let department = req.body.department;
	let job_title = req.body.job_title;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	let today = moment().utc().format('YYYY-MM-DD');
	let where = {}
	if(company){
		where.company_branch_id = company;
	}
	if(department){
		where.department_id = department;
	}
	if(job_title){
		where.job_title_id = job_title;
	}
	if(userId){
		where.id = userId;
	}
	UsersModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return UsersModel.findAll({
			where: where,
			order: [
				['first_name','asc']
			],
			include: [
				{
					model: ShiftsModel,
					required: false,
					where: {
						onsite: 0,
						$and: [
							sequelize.where(sequelize.fn('YEAR', sequelize.col('date')), year)
						],
						$or: [
							{
								actual_check_in: null
							},
							{
								actual_check_out: null
							}
						]
					},
					attributes:[
						'user_id',
						'type',
						'date',
						'actual_check_in',
						'actual_check_out',
						'onsite',
						[sequelize.fn('MONTH', sequelize.col('date')), 'month']
					]
				}
			],
			attributes: ['shortid','first_name','last_name'],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		records = data;
		records = JSON.parse(JSON.stringify(records));
		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
		res.status(200).json({
			success: false,
			count: count,
			records: records
		});
	});
}