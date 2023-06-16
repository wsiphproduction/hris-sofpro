const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	LoanModel,
	LoanPaymentModel
} = require('../../config/Sequelize');


//Render Loan
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
		})
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'employee-loan').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/Loan/index',{
						employee: employee,
						segment: segment,
						usrRole: usrRole,
						user_role: user_role,
						route: 'employee'
					});
				}
			});
			
		}
	});
}

//Add loans
//Create record
exports.store = function(req, res){
	let id 		= req.params.id;
	let path    = req.path.split('/');
	let segment = path[2];
	
	UsersModel.findOne({
		where: {
			shortid: id
		}
	}).then(function(data){
		employee = data;
		req.checkBody('label').notEmpty().withMessage('The label field is required.');
		req.checkBody('amount').notEmpty().withMessage('The amount field is required and must be a number.');
		req.checkBody('mode').notEmpty().withMessage('The Mode of Payment field is required.');
		req.checkBody('date_to_pay').notEmpty().withMessage('The Date to pay field is required.');
		req.checkBody('frequency').notEmpty().withMessage('The loan frequency field is required.');
		req.checkBody('status').notEmpty().withMessage('The status field is required.');
		req.checkBody('loan_type').notEmpty().withMessage('The loan type field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{

			let reqBody = {
				user_id: employee.id,
				amount: req.body.amount,
				label: req.body.label,
				mode_of_payment: req.body.mode,
				date_to_pay: res.locals.moment(req.body.date_to_pay).format('YYYY-MM-DD'),
				frequency: req.body.frequency,
				loan_type: req.body.loan_type,
				status: req.body.status,
			}
			LoanModel.create(reqBody).then(function(data){
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Loan has been created.'
				});
			});
		}
	});
}

//Update Loans
exports.update = function(req, res){
	let id = req.body.id;
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('amount').notEmpty().withMessage('The amount field is required and must be a number.');
	req.checkBody('mode').notEmpty().withMessage('The Mode of Payment field is required.');
	req.checkBody('date_to_pay').notEmpty().withMessage('The Date to pay field is required.');
	req.checkBody('frequency').notEmpty().withMessage('The frequency field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('loan_type').notEmpty().withMessage('The loan type field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			amount: req.body.amount,
			label: req.body.label,
			mode_of_payment: req.body.mode,
			date_to_pay: res.locals.moment(req.body.date_to_pay).format('YYYY-MM-DD'),
			payroll_to_pay: req.body.payroll_to_pay,
			loan_type: req.body.loan_type,
			status: req.body.status,
		}
		LoanModel.update(reqBody,{
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Loan has been updated.'
			});
		});
	}
}

//Get loan records
exports.fetch = function(req, res){
	let shortid = req.body.shortid;
	UsersModel.findOne({
		where: {
			shortid: shortid
		}
	}).then(function(data){
		employee = data;
		return LoanModel.findAll({
			where: {
				user_id: employee.id
			},
			include: [
				{
	    			model: UsersModel,
	    			attributes: ['shortid', 'first_name', 'last_name']
	    		},
				{
	    			model: LoanPaymentModel,
	    			required: false
	    		}
			]
		});
	}).then(function(data){
		records = data;
		res.status(200).json({
			success: true,
			records: records
		});
	});
}