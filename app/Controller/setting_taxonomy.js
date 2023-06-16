const Taxonomy = require('../Models/TaxonomyModel');
const sprintf  = require('../Helper/sprintf');
const TreeHelper = require('../Helper/TreeHelper');
const arrayToTree = require('array-to-tree');
const UserRole = require('../Helper/UserRole');
const { 
	TaxonomyModel,
	UsersModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-taxonomy');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			Taxonomy.getAll().then(function(data){
				records = data;
				let numRows = records.length;
				let dataTree = arrayToTree(records);
				let tableRow = TreeHelper._taxonomyTree(dataTree, '', user_role);
				let options = TreeHelper._taxonomyOption(dataTree);
				res.render('Settings/Taxonomy/index',{
					tableRow: tableRow,
					options: options,
					numRows: numRows,
					user_role: user_role,
					usrRole: usrRole,
					route: 'taxonomy'
				});
			});
		}
	});
	
}


exports.store = function(req, res){

	let user_id  = req.session.user ? req.session.user.id : null;

	req.checkBody('parent').notEmpty().withMessage(sprintf.require('parent'));
	req.checkBody('title').notEmpty().withMessage(sprintf.require('title'));
	req.checkBody('status').notEmpty().withMessage(sprintf.require('status'));

	let errors = req.validationErrors();

	if(errors){

		res.status(422).json({
			success: false,
            errors
		});

	}else{

		let parent_id = req.body.parent;

		TaxonomyModel.count({
			where: {
				parent_id: parent_id
			}
		}).then(function(data){
			count = data;
			let node  = parseInt(count) + 1;

			let insertData = {
				parent_id: parent_id,
				title: req.body.title,
				code: req.body.code,
				description: req.body.description,
				status: req.body.status,
				node: node,
				created_by: user_id
			}

			TaxonomyModel.create(insertData).then(function(data){
				res.status(200).json({
					success: true,
					action: 'close',
					msg: 'New record has been successfully saved.'
				});
			});
		});
		
	}

}


exports.edit = function(req, res){
	let id = req.body.id;
	TaxonomyModel.findByPk(id).then(function(data){
		if(!data) res.status(404).json({
			success: false,
			msg: 'No record found for the given selection.'
		});
		res.status(200).json({
			success: true,
			record: data
		});
	});
}


exports.update = function(req, res){

	let user_id  = req.session.user ? req.session.user.id : null;

	req.checkBody('parent').notEmpty().withMessage(sprintf.require('parent'));
	req.checkBody('title').notEmpty().withMessage(sprintf.require('title'));
	req.checkBody('status').notEmpty().withMessage(sprintf.require('status'));

	let errors = req.validationErrors();

	if(errors){
		
		res.status(422).json({
			success: false,
            errors
		});

	}else{
		
		let id = req.body.id;

		let data = {
			parent_id: req.body.parent,
			title: req.body.title,
			code: req.body.code,
			description: req.body.description,
			status: req.body.status,
			updated_by: user_id
		}

		TaxonomyModel.update(data, {
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully updated.'
			});
		});
	}
}

// Remove department in taxonomy
exports.remove = function(req, res){
	let parent_id = req.params.parent_id;
	let id = req.body.id;

	let where = {}
	// Department
	if(parent_id == 1){
		where.department_id = id;
	}else if(parent_id == 2){// Designation
		where.job_title_id = id;
	}else if(parent_id == 270){ // Team
		where.team_id = id;
	}
	UsersModel.count({
		where: where
	}).then(count => {
		if(count > 0){
			res.status(403).json({
				message: 'The action can\'t be completed because some user/s are related to this item. Please contact administrator.'
			});
		}else{
			TaxonomyModel.destroy({
				where:{
					id: id
				}
			});
			res.status(201).json({
				action: 'close'
			});
		}
	});
}

exports.init_form = function(req, res){
	
	// let record = Taxonomy._get();

	// res.status(200).json({
	// 	taxonomy: record
	// });

}