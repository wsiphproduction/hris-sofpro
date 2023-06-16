const UserRole = require('../Helper/UserRole');
const { 
	ConfigModel,
	UsersModel,
	OvertimesModel,
	ShiftsModel,
	TrainingModel,
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
			UserRole.get_role(user, 'employee-training').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/Training/index',{
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
	req.checkBody('title').notEmpty().withMessage('The title field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');
	req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
	req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
	req.checkBody('days').notEmpty().withMessage('The no. of days field is required.');
	req.checkBody('provider').notEmpty().withMessage('The training provider field is required.');
	req.checkBody('points').notEmpty().withMessage('The cpd points earned field is required.');
	req.checkBody('report').notEmpty().withMessage('The assessment report field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{

		let reqData = {
			user_id: req.body.user_id,
			title: req.body.title,
			description: req.body.description,
			start_date: req.body.start_date,
			end_date: req.body.end_date,
			no_days: req.body.days,
			training_provider: req.body.provider,
			cdp_points: req.body.points,
			training_report: req.body.report,
			status: '1'
		}

		TrainingModel.create(reqData).then(function (data){
			result = data;
			res.status(201).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		}).catch((err) => {
			console.log(`Error cases training cases data ${err}`);
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
		return TrainingModel.findAll({
			where: {
				user_id: user.id,
				status: '1'
			}
		}).then(data => {
			trainings = data;
			res.status(200).json({
				success: true,
				trainings
			})
		})
	})
}

exports.update = function(req, res){
	let id = req.body.id; 
	let user_id = req.body.user_id;

	req.checkBody('title').notEmpty().withMessage('The title field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');
	req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
	req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
	req.checkBody('days').notEmpty().withMessage('The no. of days field is required.');
	req.checkBody('provider').notEmpty().withMessage('The training provider field is required.');
	req.checkBody('points').notEmpty().withMessage('The cpd points earned field is required.');
	req.checkBody('report').notEmpty().withMessage('The assessment report field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
			errors
		});
	}else{
		let reqData = {
			user_id: req.body.user_id,
			title: req.body.title,
			description: req.body.description,
			start_date: req.body.start_date,
			end_date: req.body.end_date,
			no_days: req.body.days,
			training_provider: req.body.provider,
			cdp_points: req.body.points,
			training_report: req.body.report,
		}
		
		TrainingModel.update(reqData,{
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
	
	TrainingModel.update(reqData, {
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