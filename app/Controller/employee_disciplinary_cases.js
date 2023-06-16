const UserRole = require('../Helper/UserRole');
const { 
	ConfigModel,
	UsersModel,
	OvertimesModel,
	ShiftsModel,
	DisciplinaryModel
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
			UserRole.get_role(user, 'employee-disciplinary-cases').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/disciplinary-cases/index',{
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
	req.checkBody('incident_report').notEmpty().withMessage('The incident title field is required.');
	req.checkBody('prepared_by').notEmpty().withMessage('The prepared By field is required.');
	req.checkBody('received_by').notEmpty().withMessage('The Received By field is required.');
	req.checkBody('incident_date').notEmpty().withMessage('The Incident Date field is required.');
	req.checkBody('code').notEmpty().withMessage('The code field is required.');
	req.checkBody('decision_serve').notEmpty().withMessage('The decision serve date field is required.');
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
			title: req.body.incident_report,
			incident_date: req.body.incident_date,
			prepared_by: req.body.prepared_by,
			received_by: req.body.received_by,
			code: req.body.code,
			date_served: req.body.decision_serve,
			start_date: req.body.start_date,
			end_date: req.body.end_date,
			status: '1'
		}

		DisciplinaryModel.create(reqData).then(function (data){
			result = data;
			res.status(201).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		}).catch((err) => {
			console.log(`Error cases IR cases data ${err}`);
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
		return DisciplinaryModel.findAll({
			where: {
				user_id: user.id,
				status: '1'
			}
		}).then(data => {
			cases = data;
			
			res.status(200).json({
				success: true,
				cases
			})
		})
	})
}

exports.update = function(req, res){
	let id = req.body.id; 
	let user_id = req.body.user_id;

	req.checkBody('incident_report').notEmpty().withMessage('The incident title field is required.');
	req.checkBody('prepared_by').notEmpty().withMessage('The prepared By field is required.');
	req.checkBody('received_by').notEmpty().withMessage('The Received By field is required.');
	req.checkBody('incident_date').notEmpty().withMessage('The Incident Date field is required.');
	req.checkBody('code').notEmpty().withMessage('The code field is required.');
	req.checkBody('decision_serve').notEmpty().withMessage('The decision serve date field is required.');
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
			title: req.body.incident_report,
			incident_date: req.body.incident_date,
			prepared_by: req.body.prepared_by,
			received_by: req.body.received_by,
			code: req.body.code,
			date_served: req.body.decision_serve,
			start_date: req.body.start_date,
			end_date: req.body.end_date
		}

		DisciplinaryModel.update(reqData,{
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
	
	DisciplinaryModel.update(reqData, {
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