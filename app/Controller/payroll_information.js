const UserRole = require('../Helper/UserRole');
const { 
	UsersModel, 
    Payroll
} = require('../../config/Sequelize');

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
			},
		});
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'payroll-information').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/PayrollInformation/index', {
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

exports.store = function(req, res){
    req.checkBody('rate_type').notEmpty().withMessage('The rate type field is required.');
    req.checkBody('payee_location').notEmpty().withMessage('The payee location field is required.');
    req.checkBody('payment_type').notEmpty().withMessage('The payment type field is required.');
    req.checkBody('currency_id').notEmpty().withMessage('The currency ID type field is required.');
    req.checkBody('bank_id').notEmpty().withMessage('The bank ID field is required.');
    req.checkBody('bank_name').notEmpty().withMessage('The bank name field is required.');
    req.checkBody('bank_acct_number').notEmpty().withMessage('The bank account number field is required.');
    req.checkBody('basic_monthly_rate').notEmpty().withMessage('The basic monthly rate field is required.');
    req.checkBody('basic_daily_rate').notEmpty().withMessage('The basic daily rate field is required.');
    let validate = [];
    let errors = req.validationErrors();
    
    if (errors || validate.length){
        if(errors && validate.length){
            errors = errors.concat(validate);
        }else if(!errors && validate.length){
            errors = validate;
        }else if(errors && !validate.length){
            errors = errors;
        }
        res.status(422).json({
            success: false,
            errors
        });
    } else {
        UsersModel.findOne({
            where: {
                shortId: req.params.id
            }
        }).then(data => {
            userID = data.id;

            let reqData = {
                user_id: userID,
                rate_type: req.body.rate_type,
                payee_location: req.body.payee_location,
                payment_type: req.body.payment_type,
                currency_id: req.body.currency_id,
                bank_id: req.body.bank_id,
                bank_name: req.body.bank_name,
                bank_acct_number: req.body.bank_acct_number,
                basic_monthly_rate: req.body.basic_monthly_rate,
                basic_daily_rate: req.body.basic_daily_rate,
                e_cola_daily: req.body.e_cola_daily ? req.body.e_cola_daily : null,
                allowance: req.body.allowance ? req.body.allowance : null,
                allowance_effective_date: req.body.allowance_effective_date ? req.body.allowance_effective_date : null,
                incentive: req.body.incentive ? req.body.incentive : null,
                incentive_effective_date: req.body.allowance_effective_date ? req.body.allowance_effective_date : null,
                benefit: req.body.benefit ? req.body.benefit : null,
                benefit_effective_date: req.body.benefit_effective_date ? req.body.benefit_effective_date : null
            }; 

            Payroll.create(reqData).then(data => {
                res.status(200).json({
                    success: true,
                    action: 'fetch',
                    msg: 'Record has been created.'
                });
            })  
        })
    }
}

exports.update = function(req, res){
    req.checkBody('rate_type').notEmpty().withMessage('The rate type field is required.');
    req.checkBody('payee_location').notEmpty().withMessage('The payee location field is required.');
    req.checkBody('payment_type').notEmpty().withMessage('The payment type field is required.');
    req.checkBody('currency_id').notEmpty().withMessage('The currency ID type field is required.');
    req.checkBody('bank_id').notEmpty().withMessage('The bank ID field is required.');
    req.checkBody('bank_name').notEmpty().withMessage('The bank name field is required.');
    req.checkBody('bank_acct_number').notEmpty().withMessage('The bank account number field is required.');
    req.checkBody('basic_monthly_rate').notEmpty().withMessage('The basic monthly rate field is required.');
    req.checkBody('basic_daily_rate').notEmpty().withMessage('The basic daily rate field is required.');
    let validate = [];
    let errors = req.validationErrors();
    
    if (errors || validate.length){
        if(errors && validate.length){
            errors = errors.concat(validate);
        }else if(!errors && validate.length){
            errors = validate;
        }else if(errors && !validate.length){
            errors = errors;
        }
        res.status(422).json({
            success: false,
            errors
        });
    } else {
        UsersModel.findOne({
            where: {
                shortId: req.params.id
            }
        }).then(data => {
            userID = data.id;

            let reqData = {
                user_id: userID,
                rate_type: req.body.rate_type,
                payee_location: req.body.payee_location,
                payment_type: req.body.payment_type,
                currency_id: req.body.currency_id,
                bank_id: req.body.bank_id,
                bank_name: req.body.bank_name,
                bank_acct_number: req.body.bank_acct_number,
                basic_monthly_rate: req.body.basic_monthly_rate,
                basic_daily_rate: req.body.basic_daily_rate,
                e_cola_daily: req.body.e_cola_daily ? req.body.e_cola_daily : null,
                allowance: req.body.allowance ? req.body.allowance : null,
                allowance_effective_date: req.body.allowance_effective_date ? req.body.allowance_effective_date : null,
                incentive: req.body.incentive ? req.body.incentive : null,
                incentive_effective_date: req.body.allowance_effective_date ? req.body.allowance_effective_date : null,
                benefit: req.body.benefit ? req.body.benefit : null,
                benefit_effective_date: req.body.benefit_effective_date ? req.body.benefit_effective_date : null
            }; 
            Payroll.update(reqData, {
                where: {
                    id: req.body.id
                }
            }).then(data => {
                res.status(200).json({
                    success: true,
                    action: 'fetch',
                    msg: 'Record has been updated.'
                });
            })  
        })
    }
}

exports.fetch = function(req, res){
    let shortid = req.body.shortid;

    UsersModel.findOne({
        where: {
            shortid: shortid
        },
    }).then(data => {
        user = data;
        return Payroll.findAll({
            where: {
                user_id: user.id
            }
        }).then(data => {
            payrollInformation = data;
            res.status(200).json({
                success: true,
                payrollInformation
            })
        })
    })
}
