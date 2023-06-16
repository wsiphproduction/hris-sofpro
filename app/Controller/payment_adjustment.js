const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	LoanModel,
	AdjustmentModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		UserRole.get_role(user, 'payment-adjustment').then(function(data){
			user_role = data;
			if(!user_role.read) {
				res.render('Errors/403');
			}else{
				res.render('Payment/Adjustment/index', {
					route: 'payment-adjustment',
					usrRole: usrRole,
					user_role: user_role
				});
			}
		});
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('year').notEmpty().withMessage('The year field is required.');
	req.checkBody('month').notEmpty().withMessage('The month field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	req.checkBody('applicant').notEmpty().withMessage('The applicant field is required.');
	req.checkBody('amount').notEmpty().withMessage('The amount field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			user_id: req.body.applicant,
			year: req.body.year,
			month: req.body.month,
			period: req.body.period,
			amount: req.body.amount,
			status: req.body.status,
			created_by: user.id
		}
		AdjustmentModel.create(reqData).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Salary adjustment has been created.'
			});
		});
	}
}

exports.update = function(req, res){
	let user = res.locals.user;
	req.checkBody('year').notEmpty().withMessage('The year field is required.');
	req.checkBody('month').notEmpty().withMessage('The month field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	req.checkBody('amount').notEmpty().withMessage('The amount field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		let reqData = {
			year: req.body.year,
			month: req.body.month,
			period: req.body.period,
			amount: req.body.amount,
			status: req.body.status,
			created_by: user.id
		}
		AdjustmentModel.update(reqData,{
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Salary adjustment has been updated.'
			});
		});
	}
}

exports.fetch = function(req, res){
	let year 	= req.body.year;
	let month  	= req.body.month;
	let period  	= req.body.period;
	let company  	= req.body.company;
	let department  	= req.body.department;
	let designation  = req.body.designation;
	let limit   = parseInt(req.body.limit);
	let page = req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	
	let where = {
		status: {
			$ne: 3
		}
	}
	let userWhere = {}
	if(year){
		where.year = year;
	}
	if(month){
		where.month = month;
	}
	if(period){
		where.period = period;
	}
	if(company){
		userWhere.company_branch_id = company;
	}
	if(department){
		userWhere.department_id = department;
	}
	if(designation){
		userWhere.job_title_id = designation;
	}
	UsersModel.findAll({
		where: {
			status: 1
		},
		order: [
			['first_name','ASC']
		]
	}).then(function(data){
		applicant = data;
		return AdjustmentModel.count({
			where: where,
			include: [
				{
					model: UsersModel,
					where: userWhere
				}
			]
		});
		
	}).then(function(data){
		numrows = data;
		return AdjustmentModel.findAll({
			where: where,
			include: [
				{
					model: UsersModel,
					where: userWhere,
					attributes: ['id','first_name','last_name']
				}
			],
			order: [
				['created_at','desc']
			],
			limit: limit,
			offset: offset
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
			applicant: applicant,
			records: records,
			count: count,
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	let reqData = {
		status: 3
	}
	AdjustmentModel.update(reqData, {
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}