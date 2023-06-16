const bcrypt = require('bcryptjs');
const shortid = require('shortid');
const {
	CountryModel,
	UsersModel
} = require('../../config/Sequelize');

exports.register = function(req, res){
	req.session.destroy();
	req.checkBody('first_name').notEmpty().withMessage('The first name field is required.');
	req.checkBody('last_name').notEmpty().withMessage('The last name field is required.');
	req.checkBody('gender').notEmpty().withMessage('The gender field is required.');
	req.checkBody('email').notEmpty().isEmail().withMessage('The email field must be a valid email address.');
	// req.checkBody('nationality').notEmpty().withMessage('The nationality field is required.');
	req.checkBody('password').notEmpty().withMessage('The password field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		shortid.characters('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$-');
		let shrtid = shortid.generate();
		var salt = bcrypt.genSaltSync(10);
		let password = req.body.password;
			password = bcrypt.hashSync(password, salt);

		let reqBody = {
			id: 1,
			shortid: shrtid,
			first_name: req.body.first_name,
			last_name: req.body.last_name,
			email: req.body.email,
			username: req.body.username,
			nationality: req.body.nationality,
			password: password,
			gender: req.body.gender,
			employee_number: '0000000000',
			status: 1,
			user_role: 1
		}

		UsersModel.create(reqBody).then(function(data){
			res.status(200).json({
				success: true,
				action: 'refresh'
			});
		});
	}
}

exports.init = function(req, res){
	CountryModel.findAll({
		order:[
			['name','ASC']
		]
	}).then(function(data){
		countries = data;
		res.status(200).json({
			nationalities: countries,
		});
	});
}