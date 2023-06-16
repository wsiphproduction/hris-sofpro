const { 
	UsersModel
} = require('../../config/Sequelize');

const uuidv4 = require('uuid/v4');
const uuidv5 = require('uuid/v5');
const bcrypt = require('bcryptjs');
const MailHelper = require('../Helper/MailHelper');

exports.forgot = function(req, res){
	if(req.session.user) {
		res.redirect('/');
	}else{
		res.render('Password/forgot');
	}
}

exports.change = function(req, res){
	let NAMESPACE = uuidv4();
	req.checkBody('email', 'The email field is required.').notEmpty();
	var errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let email = req.body.email;
		UsersModel.findOne({
			where: {
				email: email,
				status: 1
			}
		}).then(function(data){
			user = data;
			if(user){
				let reset_token = uuidv5(user.email, NAMESPACE);
				let id = user.id;
				let reqBody = {
					reset_token: reset_token
				}
				UsersModel.update(reqBody,{
					where: {
						id: id
					}
				}).then(function(data){
					let receiver = {
						first_name: user.first_name,
						email: user.email,
					}
					let link = res.locals.baseUrl + '/password/reset?token=' + reset_token
					MailHelper.forgot_password(receiver, link);
					res.status(201).json({
						success: true,
						msg: 'An email has been sent to the supplied email address. Follow the instruction in the email to reset your password.'
					});
				});
			}else{
				var errors = [
					{	
						param: 'email',
						msg: 'Email address cannot be found. Please try again.'
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

exports.reset = function(req, res){
	if(req.session.user) {
		res.redirect('/');
	}else{
		res.render('Password/reset');
	}
}

exports.validate = function(req, res){
	let token = req.query.token ? req.query.token : '';
	UsersModel.findOne({
		where: {
			reset_token: token
		},
		attributes: ['id', 'first_name', 'last_name']
	}).then(function(data){
		user = token ? data : null;
		res.status(200).json({
			success: true,
			user: user
		});
	});
}

exports.update = function(req, res){
	req.checkBody('password').notEmpty().withMessage('The new password field is required.');
	req.checkBody('confirm').notEmpty().withMessage('The confirm new password field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		let password = req.body.password;
		let confirm = req.body.confirm;
		if(password != confirm){
			var error = [
				{	
					param: 'confirm',
					msg: 'THe new password and confirmation password do not match.'
				}
			]
			res.status(422).json({
				success: false,
				errors: error
			});
		}else{
			var salt = bcrypt.genSaltSync(10);
			password = bcrypt.hashSync(password, salt);
			let reqBody = {
				password: password,
				reset_token: ''
			}
			UsersModel.update(reqBody, {
				where: {
					id: id
				}
			}).then(function(data){
				return UsersModel.findOne({
					where: {
						id: id
					}
				});
			}).then(function(data){
				user = data;
				let receiver = {
					first_name: user.first_name,
					email: user.email,
					username: user.username
				}
				MailHelper.reset_password(receiver);
				res.status(201).json({
					success: true,
					msg: 'Congrats! Your password has been changed.'
				});
			});
		}
	}
}