const UserRole = require('../Helper/UserRole');
const { 
	ConfigModel,
	UsersModel,
	OvertimesModel,
	ShiftsModel,
	MemoModel
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
			UserRole.get_role(user, 'employee-memorandum').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/Memorandum/index',{
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
	req.checkBody('memo').notEmpty().withMessage('The memo field is required.');
	req.checkBody('subject').notEmpty().withMessage('The subject field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('issued_by').notEmpty().withMessage('The issued by field is required.');
	req.checkBody('issued_to').notEmpty().withMessage('The issued to field is required.');
	req.checkBody('effectivity_date').notEmpty().withMessage('The effectivity date field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		
		let reqData = {
			user_id: req.body.user_id,
			memo: req.body.memo,
			subject: req.body.subject,
			description: req.body.description,
			date: req.body.date,
			issued_by: req.body.issued_by,
			issued_to: req.body.issued_to,
			effectivity_date: req.body.effectivity_date,
			status: '1'
		}

		MemoModel.create(reqData).then(function (data){
			result = data;
			res.status(201).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		}).catch((err) => {
			console.log(`Error creating memo data ${err}`);
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
		return MemoModel.findAll({
			where: {
				user_id: user.id,
				status: '1'
			}
		}).then(data => {
			memo = data;
			
			res.status(200).json({
				success: true,
				memo
			})
		})
	})
}

exports.update = function(req, res){
	let id = req.body.id; 
	let user_id = req.body.user_id;

	req.checkBody('memo').notEmpty().withMessage('The memo field is required.');
	req.checkBody('subject').notEmpty().withMessage('The subject field is required.');
	req.checkBody('description').notEmpty().withMessage('The description field is required.');
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('issued_by').notEmpty().withMessage('The issued by field is required.');
	req.checkBody('issued_to').notEmpty().withMessage('The issued to field is required.');
	req.checkBody('effectivity_date').notEmpty().withMessage('The effectivity date field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
			errors
		});
	}else{
		let reqData = {
			user_id: req.body.user_id,
			memo: req.body.memo,
			subject: req.body.subject,
			description: req.body.description,
			date: req.body.date,
			issued_by: req.body.issued_by,
			issued_to: req.body.issued_to,
			effectivity_date: req.body.effectivity_date
		}

		MemoModel.update(reqData,{
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

	MemoModel.update(reqData, {
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