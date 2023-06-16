const bcrypt = require('bcryptjs');
const UserRole = require('../Helper/UserRole');
const resize = require('../Helper/Resize');
const fs = require('fs');
const formidable = require('formidable');
const MailHelper = require('../Helper/MailHelper');
const TimeKeeping = require('../Helper/TimeKeeping/Main');
const { 
	UsersModel,
	ShiftsModel,
	OvertimesModel,
	LoanModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	HolidaysModel,
	TwoFactorAuthModel,
	IncentiveModel,
	ConfigModel,
	LoanPaymentModel,
	LeavesModel,
	LeaveDateModel,
	SalaryModel,
	EmploymentsModel,
	AdjustmentModel,
	DisputeModel,
	UserSettingModel,
	BranchesModel,
	CompanyModel,
	TaxonomyModel,
	CountryModel,
	Payslip,
	Payroll
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UsersModel.findByPk(user.id);
	}).then(function(data){
		account = data;
		return CountryModel.findOne({
				where: {
				id: account.nationality
			}
		});
		
	}).then(function(data){
		nationality = data;
		res.render('Myaccount/index',{
			account: account,
			nationality: nationality,
			usrRole: usrRole
		});
	});
}

exports.two_factor = function(req, res){
	let user = res.locals.user;
	req.checkBody('password').notEmpty().withMessage('Please enter your password for verification.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let user_id = user.id;
		let status = req.body.twoFactor ? 1 : 0;
		UsersModel.findOne({
			where: {
				id: user.id
			}
		}).then(function(data){
			user_data = data;
			let hashPassword = user_data.password;
			let password = req.body.password;
			let compare = bcrypt.compareSync(password, hashPassword);
			if(compare){
				TwoFactorAuthModel.findOne({
					where: {
						user_id: user_id
					}
				}).then(function(data){
					result = data;
					let reqData = {
						status: status
					}
					let mailReceiver = {
						first_name: user_data.first_name,
						email: user_data.email
					}
					let mailMessage = ``;
					if(status == 1){
						mailMessage = `
							<p>You have enabled two-factor authentication.</p>
							<p>From now on, every time you log in to your account, we'll send you verification code to your email.</p>
						`;
					}else{
						mailMessage = `
							<p>You have disabled two-factor authentication.</p>
							<p>This means we will no longer ask for your authentication code when you log in to your account.</p>
						`;
					}
					let mailSubject = 'Two Factor Authentication';
					if(result){
						TwoFactorAuthModel.update(reqData,{
							where: {
								id: result.id
							}
						}).then(function(data){
							//Sent Email
							MailHelper.send_mail(mailReceiver, mailMessage, mailSubject);
							res.status(201).json({
								success: true,
								action: 'fetch',
								msg: 'Congratulation! Changes has been saved.'
							});
						});
					}else{
						reqData.user_id = user_id;
						TwoFactorAuthModel.create(reqData).then(function(data){
							//Sent Email
							MailHelper.send_mail(mailReceiver, mailMessage, mailSubject);
							res.status(201).json({
								success: true,
								action: 'fetch',
								msg: 'Congratulation! Changes has been saved.'
							});
						});
					}
				});
			}else{
				var errors = [
					{	
						param: 'password',
						msg: 'Invalid password. Try again.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}
		});
		
	}
}

exports.change_password = function(req, res){
	let user = res.locals.user;
	req.checkBody('current').notEmpty().withMessage('The current password field is required.');
	req.checkBody('new').notEmpty().withMessage('The new password field is required.');
	req.checkBody('confirm').notEmpty().withMessage('The confirm password field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		UsersModel.findOne({
			where: {
				id: user.id
			}
		}).then(function(data){
			result = data;
			let current = req.body.current;
			let new_password = req.body.new;
			let confirm = req.body.confirm;
			let hashPassword = result.password;
			let compare = bcrypt.compareSync(current, hashPassword);
			if(compare){
				if(new_password == confirm){
					let user_id = result.id;
					let salt = bcrypt.genSaltSync(10);
					let password = new_password;
						password = bcrypt.hashSync(password, salt);
					let reqData = {
						password: password
					}
					UsersModel.update(reqData,{
						where: {
							id: user_id
						}
					}).then(function(data){
						res.status(201).json({
							success: true,
							msg: 'Congrats! Your password has been changed.'
						});
					});
				}else{
					var errors = [
						{	
							param: 'confirm',
							msg: 'New password and confirm password do not match.'
						}
					]
					res.status(422).json({
						success: false,
						errors
					});
				}
			}else{
				var errors = [
					{	
						param: 'current',
						msg: 'Invalid current password. Try again.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}
		});
	}
}

exports.attendance = function(req, res){
	let user = res.locals.user;
	let year = req.body.year;
	let month = req.body.month;
	let period = req.body.period ? req.body.period : 'A';

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		let cutoff = json.cutoff;
		let day_a = period == 'A' ? cutoff.A_from : cutoff.B_from;
		let day_b = period == 'A' ? cutoff.A_to : cutoff.B_to;
		let start_date = year +'-'+ month +'-'+day_a;
			start_date = res.locals.moment(new Date(start_date)).format('YYYY-MM-DD');
		if(period == 'A'){
			start_date = res.locals.moment(start_date);
			start_date = start_date.subtract(1, 'months');
			start_date = res.locals.moment(new Date(start_date)).format('YYYY-MM-DD');
		}
		let end_date   = year +'-'+ month +'-'+day_b;
			end_date = res.locals.moment(new Date(end_date)).format('YYYY-MM-DD');
		
		return ShiftsModel.findAll({
			where: {
				user_id: user.id,
				date: {
					$between: [start_date, end_date]
				},
				primary_status: 2
			},
			include: [
				{
					model: OvertimesModel,
					required: false,
					where:{
						start_date: {$col: 'shifts.date'}
					},
					attributes: ['start_date','end_date','start_time','end_time','no_of_hours']
				}
			],
			order: [
				['date', 'ASC']
			],
		});
	}).then(function(data){
		attendance = data;
		res.status(200).json({
			success: true,
            attendance: attendance
		});
	});
}

exports.events = function(req, res){
	let user = res.locals.user;
	let date = req.body.date;
	let startOf = res.locals.moment(date).startOf('month').format('YYYY-MM-DD hh:mm:ss');
	let endOf   = res.locals.moment(date).endOf('month').format('YYYY-MM-DD hh:mm:ss');
	HolidaysModel.findAll({
		where: {
			status: 1,
			date: {
				$between: [startOf, endOf]
			}
		},
		attributes: ['date', 'title','type']
	}).then(function(data){
		holidays = data;
		res.status(200).json({
			success: true,
			holidays: holidays
		});
	});
	
}

exports.fetch = function(req, res){
	let user = res.locals.user;
	let gender = user.gender;
	let company_id = user.company_branch_id ? user.company_branch_id : '';
	let department = user.department_id ? user.department_id : '';

	LoanModel.findAll({
		where: {
			user_id: user.id,
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
	}).then(function(data){
		loans = data;
		return LeavePolicyModel.findAll({
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
			attributes: ['name'],
			include: [
				{
					model: LeaveCreditPolicyModel,
					where: {
						user_id: user.id
					},
					attributes: ['balance', 'utilized']
				}
			]
		});
		
	}).then(function(data){
		policy =  data;
		return UsersModel.findOne({
			where: {
				id: user.id
			},
			include: [
				{
					model: TwoFactorAuthModel,
					as: 'twoFactor'
				}
			],
			attributes: ['id', 'email']
		});
		
	}).then(function(data){
		user_account = data;
		return IncentiveModel.findAll({
			where: {
				user_id: user.id
			},
			raw: true
		});
	}).then(function(data){
		incentive = data;
		return SalaryModel.findOne({
			where: {
				user_id: user.id
			},
			order:[
				['id','desc']
			],
			raw: true
		});
		
	}).then(function(data){
		salary = data;
		
		return Payroll.findAll({
			order:[
				['id','desc']
			],
			limit: 24
		});
		
	}).then(function(data){
		payroll = data;
		res.status(200).json({
			success: true,
            loans: loans,
            salary: salary,
            policy: policy,
            incentive: incentive,
            user: user_account,
            payroll: payroll
		});
	});
}

exports.update_avatar = function(req, res){
	
	let user = res.locals.user;
	
	let uploadPath = './assets/uploads/avatar/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;

		let image 	= files.file;
		let size = image.size;
		let user_id = req.body.user_id ? req.body.user_id : user.id;

		req.body.file = size ? size: '';
		req.checkBody('file').notEmpty().withMessage('Please select image.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			UsersModel.findByPk(user_id).then(function(data){
				account = data;
				let avatar = null;
				if(image.size > 0){
					if(account.avatar){
						
						fs.exists(uploadPath + account.avatar, function(exists) {
						    if (exists) {
						        fs.unlink(uploadPath + account.avatar, function (err) {
									if (err) throw err;
								});
						    }
						});
					}
					avatar = resize(image.path, uploadPath, 215,215);
					fs.unlink(image.path, function(err){});
				}
				let reqData = {
					avatar: avatar
				}
				UsersModel.update(reqData, {
					where: {
						id: user_id
					}
				}).then(function(data){
					res.status(201).json({
						success: true,
						action: 'refresh',
						msg: 'Avatar has been updated.'
					});
				});
			});
			
		}
	});
}

exports.payslip = function(req, res){
	let user = res.locals.user;
	
	let user_id = user.id;
	let period = req.body.period ? req.body.period : '';

	Payslip.findOne({
		where:{
			user_id: user_id,
			payroll_period: period
		},
		raw: true
	}).then(function(data){
		payslip = data;
		res.status(201).json({
			success: false,
            payslip: payslip
		});
	});
}