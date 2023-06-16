const UserRole = require('../Helper/UserRole');
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');

const { 
	ConfigModel,
	UsersModel,
	ShiftsModel,
	AttachmentModel,
	
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
			UserRole.get_role(user, 'employee-attachments').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/Attachments/index',{
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
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();

	form.parse(req, function (err, fields, files) {
		req.body = fields;

		req.checkBody('description').notEmpty().withMessage('The description field is required.');
		req.checkBody('document_number').notEmpty().withMessage('The document_number field is required.');
		req.checkBody('place_of_issue').notEmpty().withMessage('The place of issue field is required.');
		req.checkBody('document_type').notEmpty().withMessage('The document_type is required.');
		//req.checkBody('remarks').notEmpty().withMessage('The remarks field is required.');

		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			//UPLOADING OF FILES
			let attachment = files.attachment;
			let filename = null;

			if(attachment && attachment.size > 0){
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				filename = uuidv4(origFileName) + '.'+ ext;
				

				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){});
					});
				});
			}

			let reqData = {
				user_id: req.body.user_id,
				description: req.body.description,
				document_number: req.body.document_number,
				document_type: req.body.document_type,
				place_of_issue: req.body.place_of_issue,
				remarks: req.body.remarks,
				status: '1',

			}

			if(attachment && attachment.size > 0){
                reqData.attachment = filename
            }

			AttachmentModel.create(reqData).then(function (data){
				result = data;
				res.status(201).json({
					success: true,
					action: 'close',
					msg: 'Record has been successfully created.'
				});
			}).catch((err) => {
				console.log(`Error cases IR cases data ${err}`);
			})
		}
	});
}

exports.fetch = function(req, res){
	UsersModel.findOne({
		where: {
			shortid: req.body.slug
		}
	}).then(data => {
		user = data;
		return AttachmentModel.findAll({
			where: {
				user_id: user.id,
				status: '1',
			}
		}).then(data => {
			attachments = data;
			
			res.status(200).json({
				success: true,
				attachments
			})
		})
	})
}

exports.update = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();

	form.parse(req, function (err, fields, files) {
		req.body = fields;

		req.checkBody('description').notEmpty().withMessage('The description field is required.');
		req.checkBody('document_number').notEmpty().withMessage('The document_number field is required.');
		req.checkBody('place_of_issue').notEmpty().withMessage('The place of issue field is required.');
		req.checkBody('document_type').notEmpty().withMessage('The document_type is required.');
		//req.checkBody('remarks').notEmpty().withMessage('The remarks field is required.');

		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			let id = req.body.id; 
			let user_id = req.body.user_id;

			//UPLOADING OF FILES
			let attachment = files.attachment;
			let filename = null;

			if(attachment && attachment.size > 0){
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				filename = uuidv4(origFileName) + '.'+ ext;
				

				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){});
					});
				});
			}

			let reqData = {
				description: req.body.description,
				document_number: req.body.document_number,
				document_type: req.body.document_type,
				place_of_issue: req.body.place_of_issue,
				remarks: req.body.remarks,
			}

			if(attachment && attachment.size > 0){
                reqData.attachment = filename
            }
	
			AttachmentModel.update(reqData,{
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
	});

}

exports.archive = function(req, res){
	let reqData = {
		status: '2'
	};
	
	AttachmentModel.update(reqData, {
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
