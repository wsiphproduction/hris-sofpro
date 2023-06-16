const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	PerformanceReview,
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
			UserRole.get_role(user, 'employee-performance-review').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/PerformanceReview/index',{
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
	req.checkBody('evaluation_date').notEmpty().withMessage('The evaluation date field is required.');
	req.checkBody('evaluator').notEmpty().withMessage('The evaluator field is required.');
	req.checkBody('rating').notEmpty().withMessage('The rating field is required.');
	req.checkBody('recommendation').notEmpty().withMessage('The recommendation field is required.');
	req.checkBody('remarks').notEmpty().withMessage('The remarks field is required.');
	req.checkBody('points').notEmpty().withMessage('The points field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');

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
			evaluation_date: req.body.evaluation_date,
			evaluator: req.body.evaluator,
			rating: req.body.rating,
			recommendation: req.body.recommendation,
			remarks: req.body.remarks,
			points: req.body.points,
			description: req.body.description,
			status: '1'
		}

		PerformanceReview.create(reqData).then(function (data){
			result = data;
			res.status(201).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		}).catch((err) => {
			console.log(`Error${err}`);
		})
	}
}

exports.fetch = function(req, res){
	UsersModel.findOne({
		where: {
			shortid: req.body.slug,
		}
	}).then(data => {
		user = data;
		return PerformanceReview.findAll({
			where: {
				user_id: user.id,
				status: '1'
			}
		}).then(data => {
			review = data;
			
			res.status(200).json({
				success: true,
				review
			})
		})
	})
}

exports.update = function(req, res){
	let id = req.body.id; 
	let user_id = req.body.user_id;

	req.checkBody('title').notEmpty().withMessage('The title field is required.');
	req.checkBody('evaluation_date').notEmpty().withMessage('The evaluation date field is required.');
	req.checkBody('evaluator').notEmpty().withMessage('The evaluator field is required.');
	req.checkBody('rating').notEmpty().withMessage('The rating field is required.');
	req.checkBody('recommendation').notEmpty().withMessage('The recommendation field is required.');
	req.checkBody('remarks').notEmpty().withMessage('The remarks field is required.');
	req.checkBody('points').notEmpty().withMessage('The points field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');

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
			evaluation_date: req.body.evaluation_date,
			evaluator: req.body.evaluator,
			rating: req.body.rating,
			recommendation: req.body.recommendation,
			remarks: req.body.remarks,
			points: req.body.points,
			description: req.body.description,
		}

		PerformanceReview.update(reqData,{
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
	
	PerformanceReview.update(reqData, {
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