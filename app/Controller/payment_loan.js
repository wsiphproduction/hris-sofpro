const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	LoanModel,
	ConfigModel,
	LoanPaymentModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		UserRole.get_role(user, 'payment-loan').then(function(data){
			user_role = data;
			if(!user_role.read) {
				res.render('Errors/403');
			}else{
				res.render('Payment/Loan/index', {
					route: 'payment-loan',
					usrRole: usrRole,
					user_role: user_role
				});
			}
		});
	});
}

exports.store = function(req, res){
	req.checkBody('applicant').notEmpty().withMessage('The applicant field is required.');
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('amount').notEmpty().withMessage('The amount field is required and must be a number.');
	req.checkBody('mode').notEmpty().withMessage('The Mode of Payment field is required.');
	req.checkBody('year').notEmpty().withMessage('The year field is required.');
	req.checkBody('month').notEmpty().withMessage('The month field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	req.checkBody('frequency').notEmpty().withMessage('The loan frequency to pay field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('loan_type').notEmpty().withMessage('The loan type field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let user_id = req.body.applicant;
		let year = req.body.year;
		let month = req.body.month;
		let monthYear = year +'-'+ month;
		let	daysInMonth = res.locals.moment(monthYear, "YYYY-MM").daysInMonth();
		let period = req.body.period;
		let frequency = req.body.frequency;
		let amount = req.body.amount;
			amount = parseInt(amount) / parseInt(frequency);
		let reqBody = {
			user_id: req.body.applicant,
			amount: req.body.amount,
			label: req.body.label,
			mode_of_payment: req.body.mode,
			year: req.body.year,
			month: req.body.month,
			period: req.body.period,
			frequency: req.body.frequency,
			loan_type: req.body.loan_type,
			status: req.body.status,
		}
		LoanModel.create(reqBody).then(function(data){
			let id = data.id;
			let monthYear = year +'-'+ month;
			let	daysInMonth = res.locals.moment(monthYear, "YYYY-MM").daysInMonth();
			
			ConfigModel.findOne({
				where: {
					id: 1
				}
			}).then(function(data){
				config = data;
				config = config.json ? JSON.parse(config.json) : null;
				let cutoff = config && config.cutoff ? config.cutoff : null;
				let dayA = cutoff ? cutoff.A_day : 15;
					dayA = dayA <= daysInMonth ? dayA : daysInMonth;
				let dayB = cutoff ? cutoff.B_day : 28;
					dayB = dayB <= daysInMonth ? dayB : daysInMonth; 
				let day = period == 'A' ? dayA : dayB;
				let createDate = year +'-'+ month +'-'+ day;
					createDate = new Date(createDate);

				let date = createDate;

				for(let i = 1; i <= frequency; i++){
					let oddEven = '';
					if(period == 'A'){
						oddEven = i % 2 ? 'A':'B';
					}else{
						oddEven = i % 2 ? 'B':'A';
					}
					let setDate = '';
					if(oddEven == 'A'){
						date = res.locals.moment(date).add(1, 'months');
						date = date.format('YYYY-MM-DD');
			    		//$date = $date->addMonthsNoOverflow(1);
					}
					if(period == 'A'){
						setDate = date;
						setDate = res.locals.moment(setDate).subtract(1, 'months');
						setDate = setDate.format('YYYY-MM-DD');
					}else{
						setDate = date;
					}
					//LoanPaymentModel
					let paymentData = {
						loan_id: id,
						user_id: user_id,
						year: res.locals.moment(setDate).format('YYYY'),
						month: res.locals.moment(setDate).format('MM'),
						period: oddEven,
						amount: amount
					}
					LoanPaymentModel.create(paymentData);
				}
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Loan has been created.'
				});
			});
			
		});
	}
}

exports.update = function(req, res){
	let id = req.body.id;
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('amount').notEmpty().withMessage('The amount field is required and must be a number.');
	req.checkBody('mode').notEmpty().withMessage('The Mode of Payment field is required.');
	req.checkBody('year').notEmpty().withMessage('The year field is required.');
	req.checkBody('month').notEmpty().withMessage('The month field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	req.checkBody('frequency').notEmpty().withMessage('The loan frequency to pay field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('loan_type').notEmpty().withMessage('The loan type field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let year = req.body.year;
		let month = req.body.month;
		let period = req.body.period;
		let frequency = req.body.frequency;
		let amount = req.body.amount;
			amount = parseInt(amount) / parseInt(frequency);
		let reqBody = {
			amount: req.body.amount,
			label: req.body.label,
			mode_of_payment: req.body.mode,
			year: req.body.year,
			month: req.body.month,
			period: req.body.period,
			frequency: req.body.frequency,
			status: req.body.status,
			loan_type: req.body.loan_type,
		}
		LoanModel.findOne({
			where: {
				id: id
			}
		}).then(function(data){
			loan = data;
				LoanModel.update(reqBody,{
				where: {
					id: id
				}
			}).then(function(data){
				let monthYear = year +'-'+ month;
				let	daysInMonth = res.locals.moment(monthYear, "YYYY-MM").daysInMonth();
				
				ConfigModel.findOne({
					where: {
						id: 1
					}
				}).then(function(data){
					config = data;
					config = config.json ? JSON.parse(config.json) : null;
					let cutoff = config && config.cutoff ? config.cutoff : null;
					let dayA = cutoff ? cutoff.A_day : 15;
						dayA = dayA <= daysInMonth ? dayA : daysInMonth;
					let dayB = cutoff ? cutoff.B_day : 28;
						dayB = dayB <= daysInMonth ? dayB : daysInMonth; 
					let day = period == 'A' ? dayA : dayB;
					let createDate = year +'-'+ month +'-'+ day;
						createDate = new Date(createDate);

					let date = createDate;

					LoanPaymentModel.destroy({
						where: {
							loan_id: id
						}
					});
					for(let i = 1; i <= frequency; i++){
						let oddEven = '';
						if(period == 'A'){
							oddEven = i % 2 ? 'A':'B';
						}else{
							oddEven = i % 2 ? 'B':'A';
						}
						let setDate = '';
						if(oddEven == 'A'){
							date = res.locals.moment(date).add(1, 'months');
							date = date.format('YYYY-MM-DD');
				    		//$date = $date->addMonthsNoOverflow(1);
						}
						if(period == 'A'){
							setDate = date;
							setDate = res.locals.moment(setDate).subtract(1, 'months');
							setDate = setDate.format('YYYY-MM-DD');
						}else{
							setDate = date;
						}
						//LoanPaymentModel
						let paymentData = {
							loan_id: id,
							user_id: loan.user_id,
							year: res.locals.moment(setDate).format('YYYY'),
							month: res.locals.moment(setDate).format('MM'),
							period: oddEven,
							amount: amount
						}
						LoanPaymentModel.create(paymentData);
					}
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Loan has been updated.'
					});
				});
				
			});
		});
	}
}

exports.fetch = function(req, res){
	//let user = res.locals.user;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	let where = {}
	if(status){
		where.status = status;
	}
	if((start && end) && (start <= end)){
		where.date_to_pay = {
	        $between: [start, end]
	    }
	}
	LoanModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return LoanModel.findAll({
			where: where,
			offset: offset,
	    	limit: limit,
	    	attributes: ['id', 'user_id', 'label', 'amount','date_to_pay','mode_of_payment', 'frequency', 'status','loan_type'],
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
		return UsersModel.findAll({
			where: {
				status: 1
			},
			order:[
				['first_name', 'asc']
			],
			attributes: ['id', 'first_name', 'last_name']
		});
	}).then(function(data){
		applicant = data;
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