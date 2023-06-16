const UserRole = require('../Helper/UserRole');
const { 
	Op,
	RoleModel,
	ModuleModel,
	RolePermissionModel
} = require('../../config/Sequelize');

//Render Page
exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-role');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Role/index',{
				user_role: user_role,
				usrRole: usrRole,
				route: 'role'
			});
		}
	});
	
}

//Create New record
exports.store = function(req, res){
	let user = res.locals.user;
	
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			label: req.body.label,
			status: req.body.status,
			created_by: user.id
		}
		//Store to database
		RoleModel.create(reqBody).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'New record has been successfully saved.'
			});
		});
	}
}

//Fetch all Roles and return json
exports.fetch = function(req, res){
	RoleModel.findAll({
		order: [
			['label', 'ASC']
		]
	}).then(function(data){
		records = data;
		res.status(200).json({
			success: true,
			records: records
		});
	});
}

// Get Role detail
exports.edit = function(req, res){
	let id = req.body.id;
	RoleModel.findByPk(id).then(function(data){
		record = data;
		res.status(200).json({
			success: true,
			record: record
		});
	});
}

//Update record
exports.update = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('label').notEmpty().withMessage('The label field is required.');
	
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			label: req.body.label,
			status: req.body.status,
			updated_by: user.id
		}
		//Save Changes
		RoleModel.update(reqBody, {
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Record has been updated.'
			});
		});
	}
}

exports.manage = function(req, res){
	let user = res.locals.user;
	let slug = req.params.slug;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return RoleModel.findOne({
			where: {
				slug: slug
			}
		});
	}).then(function(data){
		role = data;
		if(!role){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'settings-role').then(function(data){
				user_role = data;
				if(!user_role.modify) {
					res.render('Errors/403');
				}else{
					res.render('Settings/Role/manage',{
						usrRole: usrRole,
						route: 'role'
					});
				}
			});
		}
	});
	
}

exports.manage_fetch = function(req, res){
	let slug = req.params.slug;
	RoleModel.findOne({
		where: {
			slug: slug
		}
	}).then(function(data){
		role = data;
		return ModuleModel.findAll({
			where: {
				status: 1
			},
			include: [
				{
					model: RolePermissionModel,
					required: false,
					where:{
						role_id: role.id,
					},
					attributes: ['id','read','write','modify','delete']
				}
			],
			attributes: ['id','tag','title'],
			order: [
				['title','asc']
			]
		});
	}).then(function(data){
		records = data;
		res.status(201).json({
			success: true,
			records: records,
			role: role
		});
	});
}

exports.manage_update_role = function(req, res){
	let role_id = req.body.role_id;
	let module = req.body.modules;
	if(module){
		for(let key in module){
			let module_tag = module[key]['tag'];

			let reqData = {
				role_id: role_id,
				module_tag: module_tag,
				read: module[key]['read'] ? 1 : 0,
				write: module[key]['create'] ? 1 : 0,
				modify: module[key]['modify'] ? 1 : 0,
				delete: module[key]['delete'] ? 1 : 0,
			}
			RolePermissionModel.findOne({
				where: {
					role_id: role_id,
					module_tag: module_tag
				}
			}).then(function(data){
				record = data;
				if(record){
					let id = record.id;
					RolePermissionModel.update(reqData,{
						where: {
							id: id
						}
					});
				}else{
					RolePermissionModel.create(reqData);
				}
			});
		}
	}
	res.status(201).json({
		success: true,
		message: 'Success! Your changes has been saved.'
	});
}

exports.user_role = function(req, res){
	let user = res.locals.user;
	if(user){
		let role = user.user_role ? user.user_role : null;
		if(role){
			let object = role ? role.split(',') : null;
			RolePermissionModel.findAll({
				where: {
					read: 1,
					role_id: {
						[Op.in]: object
					}
				},
				group:['module_tag'],
				attributes: ['id','module_tag', 'read','write','modify','delete']
			}).then(function(data){
				roles = data;
				console.log(roles);
				res.status(200).json({
					success: true,
					roles: roles
				});
			});
		}else{
			res.status(200).json({
				success: true,
				roles: null
			});
		}
	}else{
		res.status(200).json({
			success: true,
			roles: null
		});
	}
}