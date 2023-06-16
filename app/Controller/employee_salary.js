const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	IncentiveModel,
	SalaryModel,
} = require('../../config/Sequelize');

//Render salary page
exports.index = function(req, res){
	let user = res.locals.user;
	let id 		= req.params.id;
	let path    = req.path.split('/');
	let segment = path[2];

	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UsersModel.findOne({
			where: {
				shortid: id
			}
		});
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'employee-salary').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/Salary/index', {
						employee: employee,
						segment: segment,
						user_role: user_role,
						usrRole: usrRole,
						route: 'employee'
					});
				}
			});
		}
	});
}

//Get salary details
exports.fetch = function(req, res){
	let shortid = req.body.shortid;

	UsersModel.findOne({
		where: {
			shortid: shortid
		}
	}).then(function(data){
		employee = data;
		return SalaryModel.findAll({
			where: {
				user_id: employee.id
			},
			order: [
				['start_date','desc']
			]
		});
	}).then(function(data){
		salary = data;
		return IncentiveModel.findAll({
			where: {
				user_id: employee.id
			}
		});
	}).then(function(data){
		incentive = data;
		res.status(200).json({
			success: true,
			salary: salary,
			incentive: incentive
		});
	});
	
}

exports.store = function(req, res){
	let shortid = req.params.id;
	let type = req.body.type;
	UsersModel.findOne({
		where: {
			shortid: shortid
		}
	}).then(function(data){
		employee = data;
		if(type == 'salary'){
			req.checkBody('from').notEmpty().withMessage('The from field is required.');
			req.checkBody('basic_pay').notEmpty().withMessage('The basic pay field is required and must be a number.');
			req.checkBody('mode').notEmpty().withMessage('The mode field is required.');
			let errors = req.validationErrors();
			if(errors){
				res.status(422).json({
					success: false,
		            errors
				});
			}else{
				let start_date = req.body.from ? res.locals.moment(req.body.from).format('YYYY-MM-DD') : null;
				let end_date = req.body.to ? res.locals.moment(req.body.to).format('YYYY-MM-DD') : null;
				let reqBody = {
					user_id: employee.id,
					start_date: start_date,
					end_date: end_date,
					amount: req.body.basic_pay && req.body.basic_pay >= 0 ? req.body.basic_pay : '',
					mode: req.body.mode
				}
				SalaryModel.create(reqBody).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Salary has been updated.'
					});
				});
			}
		}else{
			req.checkBody('from').notEmpty().withMessage('The from field is required.');
			req.checkBody('amount').notEmpty().withMessage('The amount field is required and must be a number.');
			req.checkBody('mode').notEmpty().withMessage('The mode field is required.');
			req.checkBody('label').notEmpty().withMessage('The label field is required.');
			req.checkBody('status').notEmpty().withMessage('The status field is required.');
			req.checkBody('period').notEmpty().withMessage('The period field is required.');
			req.checkBody('taxable').notEmpty().withMessage('The taxable field is required.');
			let errors = req.validationErrors();
			if(errors){
				res.status(422).json({
					success: false,
		            errors
				});
			}else{
				let from = req.body.from ? res.locals.moment(req.body.from).format('YYYY-MM-DD') : null;
				let to = req.body.to ? res.locals.moment(req.body.to).format('YYYY-MM-DD') : null;
				let reqBody = {
					user_id: employee.id,
					from: from,
					to: to,
					amount: req.body.amount,
					label: req.body.label,
					mode: req.body.mode,
					status: req.body.status,
					period: req.body.period,
					taxable: req.body.taxable,
				}
				IncentiveModel.create(reqBody).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Incentive has been updated.'
					});
				});
			}
		}
	});
}

//Update Salary
exports.update = function(req, res){
	let type = req.body.type;
	let shortid = req.params.id;

	UsersModel.findOne({
		where: {
			shortid: shortid
		}
	}).then(function(data){
		employee = data;
		//If salary
		if(type == 'salary'){
			req.checkBody('from').notEmpty().withMessage('The from field is required.');
			req.checkBody('basic_pay').notEmpty().withMessage('The basic pay field is required and must be a number.');
			req.checkBody('mode').notEmpty().withMessage('The mode field is required.');
			let errors = req.validationErrors();
			if(errors){
				res.status(422).json({
					success: false,
		            errors
				});
			}else{
				let id = req.body.id;
				let start_date = req.body.from ? res.locals.moment(req.body.from).format('YYYY-MM-DD') : null;
				let end_date = req.body.to ? res.locals.moment(req.body.to).format('YYYY-MM-DD') : null;
				let reqBody = {
					start_date: start_date,
					end_date: end_date,
					amount: req.body.basic_pay,
					mode: req.body.mode
				}
				SalaryModel.update(reqBody,{
					where: {
						id: id
					}
				}).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Salary has been updated.'
					});
				});
			}
		}else{ // IF Incentive
			req.checkBody('from').notEmpty().withMessage('The from field is required.');
			req.checkBody('amount').notEmpty().withMessage('The amount field is required and must be a number.');
			req.checkBody('mode').notEmpty().withMessage('The mode field is required.');
			req.checkBody('label').notEmpty().withMessage('The label field is required.');
			req.checkBody('status').notEmpty().withMessage('The status field is required.');
			req.checkBody('period').notEmpty().withMessage('The period field is required.');
			req.checkBody('taxable').notEmpty().withMessage('The taxable field is required.');
			let errors = req.validationErrors();
			if(errors){
				res.status(422).json({
					success: false,
		            errors
				});
			}else{
				let id = req.body.id;
				let from = req.body.from ? res.locals.moment(req.body.from).format('YYYY-MM-DD') : null;
				let to = req.body.to ? res.locals.moment(req.body.to).format('YYYY-MM-DD') : null;
				let reqBody = {
					user_id: employee.id,
					from: from,
					to: to,
					amount: req.body.amount,
					label: req.body.label,
					mode: req.body.mode,
					status: req.body.status,
					period: req.body.period,
					taxable: req.body.taxable,
				}
				IncentiveModel.update(reqBody,{
					where: {
						id: id
					}
				}).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Incentive has been updated.'
					});
				});
			}
		}
	});
}