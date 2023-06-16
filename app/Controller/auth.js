const bcrypt = require('bcryptjs');
const saltRounds = 10;
const MailHelper = require('../Helper/MailHelper');
const shortid = require('shortid');
const moment = require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	UsersModel,
	TwoFactorAuthModel
} = require('../../config/Sequelize');

exports.login = function(req, res){
	//console.log(makeid(6));
	if(req.session.user) {
		res.redirect('/');
	}else{
		res.render('Auth/login');
	}

}

exports.auth = function(req, res){
	let email = req.body.email;
	let password = req.body.password;
	req.checkBody('email', 'The email field is required.').notEmpty();
	req.checkBody('password', 'The password field is required.').notEmpty();
	var errors = req.validationErrors();
	if(!errors){
		UsersModel.findOne({
			where: {
				email: email,
				status: 1
			}
		}).then(function(data){
			user = data;
			if(user){
				let user_id = user.id;
				let hashPassword = user.password;
				let compare = bcrypt.compareSync(password, hashPassword);
				if(compare){
					TwoFactorAuthModel.findOne({
						where: {
							user_id: user_id
						}
					}).then(function(data){
						twoFactor = data;
						if(twoFactor && twoFactor.status == 1){
							let authCode = user_id+makeid(6);
							let auth_id = twoFactor.id;
							let mailReceiver = {
								first_name: user.first_name,
								email: user.email
							}
							let mailMessage = `Your Confirmation Code: <strong>`+ authCode +`</strong>`;
							let mailSubject = 'Confirmation Code';
							let reqData = {
								code: authCode
							}
							TwoFactorAuthModel.update(reqData,{
								where: {
									id: auth_id
								}
							}).then(function(data){
								//SEND MAIL
								MailHelper.send_mail(mailReceiver, mailMessage, mailSubject);
								var errors = [
									{	
										param: 'twoFactor',
										msg: 'twoFactor'
									}
								]
								res.status(422).json({
									success: false,
									errors
								});
							});
							
						}else{
							let month_date = moment().format('YYYY-MM-DDTHH:mm:ssZ');
                    		let period = 'A';
							let session = {
								id: user.id,
								parent_id: user.parent_id,
								shortid: user.shortid,
								first_name: user.first_name,
								last_name: user.last_name,
								email: user.email,
								gender: user.gender,
								birthdate: user.birthdate,
								avatar: user.avatar,
								first_login: true,
								default_month_date: month_date,
								default_period: period
							}
							req.session.user = session;
							res.status(200).json({
								success: true,
								action: 'refresh'
							});
						}
					});
					
				}else{
					var errors = [
						{	
							param: 'server',
							msg: 'Login failed! Invalid login credentials. Please try again.'
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
						param: 'server',
						msg: 'Login failed! Invalid login credentials. Please try again.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}
		});
	}else{
		res.status(422).json({
			success: false,
            errors
		});
	}
}

exports.verify = function(req, res){
	req.checkBody('code', 'The code is required.').notEmpty();
	var errors = req.validationErrors();

	if(errors){
		errors.push({
			param: 'twoFactor',
			msg: 'twoFactor'
		});
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let code = req.body.code;
		TwoFactorAuthModel.findOne({
			where: {
				code: code
			}
		}).then(function(data){
			result = data;
			if(result){
				let user_id = result.user_id;
				UsersModel.findOne({
					where: {
						id: user_id
					}
				}).then(function(data){
					user = data;
					let redData = {
						code: ''
					}
					TwoFactorAuthModel.update(redData,{
						where: {
							id: result.id
						}
					});
					let session = {
						id: user.id,
						parent_id: user.parent_id,
						shortid: user.shortid,
						first_name: user.first_name,
						last_name: user.last_name,
						email: user.email,
						gender: user.gender,
						birthdate: user.birthdate,
						avatar: user.avatar,
						username: user.username
					}
					req.session.user = session;
					res.status(200).json({
						success: true,
						action: 'refresh'
					});
				});
			}else{
				var errors = [
					{	
						param: 'server',
						msg: 'Failed! Invalid verification code.'
					},
					{	
						param: 'twoFactor',
						msg: 'twoFactor'
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

exports.logout = function(req, res){
	req.session.destroy();
	res.redirect('/login');
}

const makeid = function(length) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}