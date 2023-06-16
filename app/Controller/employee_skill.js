const UserRole = require('../Helper/UserRole');
const { 
	ConfigModel,
	UsersModel,
	OvertimesModel,
	ShiftsModel,
	SkillModel
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
			UserRole.get_role(user, 'employee-skill').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/Skill/index',{
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
	req.checkBody('skill').notEmpty().withMessage('The skill field is required.');
	req.checkBody('remark').notEmpty().withMessage('The remark field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			user_id: req.body.user_id,
			skill: req.body.skill,
			remark: req.body.remark,
			status: '1'
		}

		SkillModel.create(reqData).then(function (data){
			result = data;
			res.status(201).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		}).catch((err) => {
			console.log(`Error creating skill data ${err}`);
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
		return SkillModel.findAll({
			where: {
				user_id: user.id,
				status: '1'
			}
		}).then(data => {
			skills = data;
			res.status(200).json({
				success: true,
				skills
			})
		})
	})
}

exports.update = function(req, res){
	let id = req.body.id; 
	let user_id = req.body.user_id;

	req.checkBody('skill').notEmpty().withMessage('The skill field is required.');
	req.checkBody('remark').notEmpty().withMessage('The remark field is required.');

	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
			errors
		});
	}else{
		let reqData = {
			user_id: req.body.user_id,
			skill: req.body.skill,
			remark: req.body.remark,
		}

		SkillModel.update(reqData,{
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
	
	SkillModel.update(reqData, {
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