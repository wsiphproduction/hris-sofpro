const Global = require('../Models/Global');
const multiparty = require('multiparty');
const formidable = require('formidable');
const sprintf = require('../Helper/sprintf');
const resize = require('../Helper/Resize');

const fs = require('fs');
const UserRole = require('../Helper/UserRole');
const { 
	CompanyModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let flash = req.flash('flash');
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-company');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			CompanyModel.findAll().then(function(data){
				res.render('Settings/Company/index',{
					flash: flash,
					record: data,
					user_role: user_role,
					usrRole: usrRole,
					route: 'company'
				});
			});
		}
	});
}

exports.store = function(req, res){
	let validate = []; 
	let user_id = req.session.user ? req.session.user.id : null;
	let uploadPath = './assets/uploads/logo/';
	//let form = new multiparty.Form();
	let form = new formidable.IncomingForm();
	form.parse(req, function(err, fields, files){
		req.body = fields;
		let logo = null;
		let code = req.body.code;
		let name = req.body.name;
		req.checkBody('name').notEmpty().withMessage(sprintf.require('name'));
		req.checkBody('status').notEmpty().withMessage(sprintf.require('status'));
		let errors = req.validationErrors();

		if(errors || validate.length){

			if(errors && validate.length){
				errors = errors.concat(validate);
			}else if(!errors && validate.length){
				errors = validate;
			}else if(errors && !validate.length){
				errors = errors;
			}
			
			res.status(422).json({
				success: false,
	            errors
			});

		}else{

			let logo = null;
			if(typeof files.file != 'undefined' && files.file.size > 0){
				let path = files.file.path;
				logo = resize(path, uploadPath, 100,100);
				fs.unlink(path, function(err){});
			}
			
			let data = {
				name: req.body.name,
				code: req.body.code,
				logo: logo,
				description: req.body.description,
				status: req.body.status,
				created_by: user_id
			}
			CompanyModel.create(data).then(function(data){
				req.flash('flash', '<i class="mdi mdi-check-circle-outline"></i> New record has been successfully saved.');
				res.status(200).json({
					success: true,
					action: 'close',
					msg: 'New record has been successfully saved.'
				});
			});
		}
	});
}

exports.edit = function(req, res){
	let id = req.body.id;
	CompanyModel.findByPk(id).then(function(data){
		if(!data) res.status(404).json({
			success: false,
			msg: 'No record found for the given selection.'
		});
		res.status(200).json({
			success: true,
			result: data
		});
	});
}

exports.update = function(req, res){
	let validate = [];
	let user_id = req.session.user ? req.session.user.id : null;
	let uploadPath = './assets/uploads/logo/';
	//let form = new multiparty.Form();
	let form = new formidable.IncomingForm();
	form.parse(req, function(err, fields, files){

		req.body = fields;
		let logo = null;
		let id   = req.body.id;
		let parameter = {
			table: 'companies',
			column: 'id',
			value: id
		}
		CompanyModel.findByPk(id).then(async(record)=>{

			if(!record) res.status(404).json({
				success: false,
				msg: 'No record found for the given selection.'
			});


			let code = req.body.code;
			let name = req.body.name;
			req.checkBody('name').notEmpty().withMessage(sprintf.require('name'));
			req.checkBody('status').notEmpty().withMessage(sprintf.require('status'));
			let errors = req.validationErrors();
			if(errors || validate.length){

				if(errors && validate.length){
					errors = errors.concat(validate);
				}else if(!errors && validate.length){
					errors = validate;
				}else if(errors && !validate.length){
					errors = errors;
				}
				
				res.status(422).json({
					success: false,
		            errors
				});

			}else{

				let logo = record.logo;
				if(typeof files.file != 'undefined' && files.file.size > 0){

					try {
						if (fs.existsSync(uploadPath + logo)) {
							fs.unlinkSync(uploadPath + logo);
						}
					} catch(err) {
						console.log('Cant find.')
					}
					let path = files.file.path;
					
					logo = resize(path, uploadPath, 100,100);
					fs.unlink(path, function(err){});
				}
				
				let data = {
					name: req.body.name,
					code: req.body.code,
					logo: logo,
					description: req.body.description,
					status: req.body.status,
					updated_by: user_id
				}

				CompanyModel.update(data, {
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
		});
	});
}