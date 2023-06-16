const UserRole = require('../Helper/UserRole');
const formidable = require('formidable');
const resize = require('../Helper/Resize');
const fs = require('fs');

const { 
	BrandingModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-branding');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Branding/index',{
				user_role: user_role,
				usrRole: usrRole,
				route: 'branding'
			});
		}
	});
	
}

exports.fetch = function(req, res){
	BrandingModel.findOne().then(function(data){
		result = data;
		res.status(200).json({
			success: true,
			record: result
		});
	});
}

exports.store = function(req, res){
	let uploadPath = './assets/uploads/';
	let form = new formidable.IncomingForm();
	form.parse(req, function(err, fields, files){
		req.body = fields;
		let logo = null;
		req.checkBody('name').notEmpty().withMessage('The brand name field is required.');
		req.checkBody('branding').notEmpty().withMessage('The branding field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let logo = null;
			
			let recordData = {
				name: req.body.name,
				branding: req.body.branding
			}
			if(typeof files.file != 'undefined' && files.file.size > 0){
				let path = files.file.path;
				logo = resize(path, uploadPath, 300,300);
				fs.unlink(path, function(err){});
				recordData.logo = logo;
			}
			BrandingModel.findOne().then(function(data){
				result = data;
				if(result){
					if(logo){
						try {
							if (fs.existsSync(uploadPath + result.logo)) {
								fs.unlinkSync(uploadPath + result.logo);
							}
						} catch(err) {
							console.log('Cant find.')
						}
					}
				
					BrandingModel.update(recordData,{
						where:{
							id: result.id
						}
					});
				}else{
					BrandingModel.create(recordData).then(function(data){
						console.log(data);
					});
				}

				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Record has been successfully saved.'
				});
			});
		}
	});
}