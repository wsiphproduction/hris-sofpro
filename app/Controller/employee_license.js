const UserRole = require('../Helper/UserRole');
const { 
	Op,
	ConfigModel,
	UsersModel,
	OvertimesModel,
	ShiftsModel,
	LicenseModel,
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	let id 		= req.params.id;
	let path    = req.path.split('/');
	let segment = path[2];

	UsersModel.findOne({
		where: {
			shortid: id
		}
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'employee-license').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/License/index',{
							employee: employee,
							segment: segment,
							user_role: user_role,
							usrRole: usrRole,
							route: 'employee'
						});
					});
				}
			});
		}
	})
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('license').notEmpty().withMessage('The license field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');
	req.checkBody('date_issued').notEmpty().withMessage('The date issued field is required.');
    req.checkBody('expiration').notEmpty().withMessage('The expiration field is required.');
	req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
	req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			user_id: req.body.user_id,
			license: req.body.license,
			description: req.body.description,
			date_issued: req.body.date_issued,
            expiration: req.body.expiration,
            start_date: req.body.start_date,
            end_date: req.body.end_date,
			status: '1'
		}

		LicenseModel.create(reqData).then(function (data){
			result = data;
			res.status(201).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		}).catch((err) => {
			console.log(`Error creating license data ${err}`);
		})
	}
}

exports.fetch = function(req, res){
	UsersModel.findOne({
		where: {
			shortid: req.body.slug
		}
	}).then(data => {
		user = data;
		return LicenseModel.findAll({
			where: {
				user_id: user.id,
				status: '1'
			}
		}).then(data => {
			license = data;
			
			res.status(200).json({
				success: true,
				license
			})
		})
	})
}

exports.update = function(req, res){
	let id = req.body.id; 
	let user_id = req.body.user_id;

	req.checkBody('license').notEmpty().withMessage('The license field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');
	req.checkBody('date_issued').notEmpty().withMessage('The date issued field is required.');
    req.checkBody('expiration').notEmpty().withMessage('The expiration field is required.');
	req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
	req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
			errors
		});
	}else{
		let reqData = {
			user_id: user_id,
			license: req.body.license,
			description: req.body.description,
			date_issued: req.body.date_issued,
            expiration: req.body.expiration,
            start_date: req.body.start_date,
            end_date: req.body.end_date,
		}

		LicenseModel.update(reqData,{
			where: {
				id: id,
				user_id: user_id
			}
		}).then(data => {
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully updated.'
			});
		});
	}
}

exports.archive = function(req, res){
	let reqData = {
		status: '2'
	};
	
	LicenseModel.update(reqData, {
		where: {
			id: req.body.id
		}
	}).then(data => {
		res.status(200).json({
			success: true,
			action: 'close',
		})
	})
}
