const resize = require('../Helper/Resize');
const fs = require('fs');
const formidable = require('formidable');
const UserRole = require('../Helper/UserRole');
const {
	UsersModel,
	AnnouncementModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'announcement');
	}).then(function(data){
		user_role = data;
		res.render('Announcement/index',{
			route: 'announcement',
			user_role: user_role,
			usrRole: usrRole
		});
	});
}

exports.fetch = function(req, res){
	let user = res.locals.user;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	let where = {}
	if((start && end) && (start <= end)){
		where.date_time = {
	        $between: [start, end]
	    }
	}
	AnnouncementModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return AnnouncementModel.findAll({
			where: where,
			order: [
				['created_at', 'DESC']
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		records = data;
		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
        res.status(200).json({
            success: true,
            records: records,
			count: count,
        });
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('subject').notEmpty().withMessage('The subject field is required.');
	req.checkBody('short_description').notEmpty().withMessage('The short description field is required.');
	req.checkBody('description').notEmpty().withMessage('The detailed description field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			subject: req.body.subject,
			short_description: req.body.short_description,
			description: req.body.description,
			created_by: user.id
		}
		AnnouncementModel.create(reqData).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Record has been successfully created.'
			});
		});
	}
	
}

exports.update = function(req, res){
	let user = res.locals.user;
	req.checkBody('subject').notEmpty().withMessage('The subject field is required.');
	req.checkBody('short_description').notEmpty().withMessage('The short description field is required.');
	req.checkBody('description').notEmpty().withMessage('The detailed description field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		let reqData = {
			subject: req.body.subject,
			short_description: req.body.short_description,
			description: req.body.description
		}
		AnnouncementModel.update(reqData,{
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Record has been successfully updated.'
			});
		});
	}
}

exports.archive = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;
	AnnouncementModel.destroy({
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}

exports.upload = function(req, res){
	let uploadPath = './assets/uploads/announcement/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		let image 	= files.upload;
		if(image.size > 0){
			let result = resize(image.path, uploadPath, 800, 800);
			fs.unlink(image.path, function(err){});
			res.status(200).json({
				uploaded: true,
				url: './uploads/announcement/'+ result
			});
		}else{
			res.json({
				uploaded: false,
				error: {
					message: 'Could not upload this image.'
				}
			});
		}
	});
}