const UserRole = require('../Helper/UserRole');
const { 
	BiometricModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-biometric');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Biometric/index',{
				user_role: user_role,
				usrRole: usrRole,
				route: 'biometric'
			});
		}
	});
	
}


exports.store = function(req, res){
	let user_id = req.session.user ? req.session.user.id : null;
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('site').notEmpty().withMessage('The ip address field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			label: req.body.label,
			site: req.body.site,
			status: req.body.status
		}
		BiometricModel.create(reqData).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'New record has been created.'
			});
		});
	}
}

exports.update = function(req, res){
	let id = req.body.id;
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	req.checkBody('site').notEmpty().withMessage('The ip address field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			label: req.body.label,
			site: req.body.site,
			status: req.body.status
		}
		// console.log(reqData);
		BiometricModel.update(reqData,{
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'New record has been updated.'
			});
		});
	}
}

exports.fetch = function(req, res){
	BiometricModel.findAll({
		order: [
			['site', 'ASC']
		]
	}).then(function(data){
		records = data;
		res.status(200).json({
			success: true,
			records: records
		});
	});
}

exports.edit = function(req, res){
	let id = req.body.id;
	BiometricModel.findByPk(id).then(function(data){
		record = data;
		res.status(200).json({
			success: true,
			record: record
		});
	});
}
