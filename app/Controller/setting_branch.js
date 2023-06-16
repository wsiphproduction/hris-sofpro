const sprintf = require('../Helper/sprintf');
const UserRole = require('../Helper/UserRole');
const { 
	BranchesModel,
	CompanyModel,
	CountryModel,
	Location
} = require('../../config/Sequelize');


exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-branch');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			BranchesModel.findAll({
				include:[
					{
						model: CompanyModel
					},
					{
						model: CountryModel
					},
					{
						model: Location
					},
				]
			}).then(function(data){
				record = data;
				res.render('Settings/Branch/index',{
					record: record,
					user_role: user_role,
					usrRole: usrRole,
					route: 'branch'
				});
			});
		}
	});
}

exports.store = function(req, res){
	req.checkBody('company').notEmpty().withMessage(sprintf.require('company'));
	req.checkBody('address').notEmpty().withMessage(sprintf.require('address'));
	req.checkBody('location').notEmpty().withMessage(sprintf.require('location'));
	req.checkBody('country').notEmpty().withMessage(sprintf.require('country'));
	req.checkBody('status').notEmpty().withMessage(sprintf.require('status'));

	let errors = req.validationErrors();

	if(errors){
		
		res.status(422).json({
			success: false,
            errors
		});

	}else{

		let user_id = req.session.user ? req.session.user.id : null;

		let data = {
			address: req.body.address,
			country_id: req.body.location,
			country_id: req.body.country,
			company_id: req.body.company,
			description: req.body.description,
			status: req.body.status,
			created_by: user_id
		}

		BranchesModel.create(data).then(function(data){
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'New record has been successfully saved.'
			});
		});
	}

}

exports.edit = function(req, res){
	
	let id = req.body.id;
	
	BranchesModel.findByPk(id).then(function(data){
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

	req.checkBody('company').notEmpty().withMessage(sprintf.require('company'));
	req.checkBody('address').notEmpty().withMessage(sprintf.require('address'));
	req.checkBody('location').notEmpty().withMessage(sprintf.require('location'));
	req.checkBody('country').notEmpty().withMessage(sprintf.require('country'));
	req.checkBody('status').notEmpty().withMessage(sprintf.require('status'));

	let errors = req.validationErrors();

	if(errors){
		
		res.status(422).json({
			success: false,
            errors
		});

	}else{

		let user_id = req.session.user ? req.session.user.id : null;

		let id = req.body.id;

		let data = {
			address: req.body.address,
			country_id: req.body.location,
			country_id: req.body.country,
			company_id: req.body.company,
			description: req.body.description,
			status: req.body.status,
			updated_by: user_id
		}

		BranchesModel.update(data, {
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

exports.get_branch = function(req, res){
	BranchesModel.findAll().then(function(data){
		branches = data;
		res.status(200).json({
			branches: branches
		});
	})
}

exports.init_form = function(req, res){
	CompanyModel.findAll({
		order: [
			['name','ASC']
		]
	}).then(function(data){
		companies = data;
		return CountryModel.findAll({
			order: [
				['name', 'ASC']
			]
		});
	}).then(function(data){
		countries = data;
		return Location.findAll({
			order:[
				['location','asc']
			]
		});
		
	}).then(function(data){
		location = data;
		res.status(200).json({
			companies: companies,
			countries: countries,
			location: location
		});
	});

}