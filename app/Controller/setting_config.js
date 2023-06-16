const UserRole = require('../Helper/UserRole');
const { 
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-configuration');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Configuration/index',{
				user_role: user_role,
				route: 'configuration',
				usrRole: usrRole
			});
		}
	});
}

exports.setting = function(req, res){
	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		res.status(200).json({
			success: true,
			json: json
		});
	});
	
}

exports.update = function(req, res){
	//req.checkBody('timezone').notEmpty().withMessage('The timezone field is required.');
	req.checkBody('grace_period').notEmpty().isNumeric().withMessage('The grace period must be a number.');
	//req.checkBody('overtime_regular').notEmpty().isNumeric().withMessage('The regular overtime must be a number.');
	//req.checkBody('overtime_restday').notEmpty().isNumeric().withMessage('The restday or special holiday field is required.');
	//req.checkBody('overtime_regular_holiday').notEmpty().isNumeric().withMessage('The regular holiday field is required.');
	//req.checkBody('overtime_restday_special_holiday').notEmpty().isNumeric().withMessage('The restday and special holiday field is required.');
	//req.checkBody('overtime_restday_regular_holiday').notEmpty().isNumeric().withMessage('The restday and regular holiday field is required.');
	//req.checkBody('smtp_host').notEmpty().withMessage('The smtp host field is required.');
	//req.checkBody('smtp_port').notEmpty().withMessage('The smtp port field is required.');
	//req.checkBody('smtp_username').notEmpty().withMessage('The smtp username field is required.');
	//req.checkBody('smtp_password').notEmpty().withMessage('The smtp password field is required.');
	//req.checkBody('smtp_service').notEmpty().withMessage('The service field is required.');

	req.checkBody('cutoff_a_from').notEmpty().withMessage('Required.');
	req.checkBody('cutoff_a_to').notEmpty().withMessage('Required.');
	req.checkBody('cutoff_a_day').notEmpty().withMessage('Required.');
	req.checkBody('cutoff_b_from').notEmpty().withMessage('Required.');
	req.checkBody('cutoff_b_to').notEmpty().withMessage('Required.');
	req.checkBody('cutoff_b_day').notEmpty().withMessage('Required.');

	req.checkBody('contribution_sss').notEmpty().withMessage('The sss contribution field is required.');
	req.checkBody('contribution_philhealth').notEmpty().withMessage('The philhealth contribution field is required.');
	req.checkBody('contribution_pagibig').notEmpty().withMessage('The pagibig contribution field is required.');
	req.checkBody('manual_log').notEmpty().withMessage('The manual timein/timeout field is required.');

	req.checkBody('policy_nolog').notEmpty().withMessage('The no time in/ time out policy field is required.');
	
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let object = `{
			"server":{
				"timezone": "`+ req.body.timezone +`"
			},
			"shift": {
				"grace_period": "`+ req.body.grace_period +`"
			},
			"overtime": {
				"overtime_regular": "`+ req.body.overtime_regular +`",
				"overtime_restday": "`+ req.body.overtime_restday +`",
				"overtime_regular_holiday": "`+ req.body.overtime_regular_holiday +`",
				"overtime_restday_special_holiday": "`+ req.body.overtime_restday_special_holiday +`",
				"overtime_restday_regular_holiday": "`+ req.body.overtime_restday_regular_holiday +`"
			},
			"smtp": {
				"smtp_host": "`+ req.body.smtp_host +`",
				"smtp_port": "`+ req.body.smtp_port +`",
				"smtp_username": "`+ req.body.smtp_username +`",
				"smtp_password": "`+ req.body.smtp_password +`",
				"smtp_service": "`+ req.body.smtp_service +`"
			},
			"cutoff": {
				"A_from": "`+ req.body.cutoff_a_from +`",
				"A_to": "`+ req.body.cutoff_a_to +`",
				"A_day": "`+ req.body.cutoff_a_day +`",
				"B_from": "`+ req.body.cutoff_b_from +`",
				"B_to": "`+ req.body.cutoff_b_to +`",
				"B_day": "`+ req.body.cutoff_b_day +`"
			},
			"contribution":{
				"sss": "`+ req.body.contribution_sss +`",
				"philhealth": "`+ req.body.contribution_philhealth +`",
				"pagibig": "`+ req.body.contribution_pagibig +`"
			},
			"manual_log": "`+ req.body.manual_log +`",
			"policy": {
				"nolog": "`+ req.body.policy_nolog +`"
			}
		}`;

		let reqData = {
			json: object.replace(/\s/g, "")
		}
		ConfigModel.update(reqData, {
			where: {
				id: 1
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Configuration has been updated.'
			});
		});
	}
}
