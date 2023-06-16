const UserRole = require('../Helper/UserRole');
const { 
	CountryModel,
	CandidateProfileModel
} = require('../../config/Sequelize');

const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'recruitment-candidate-profile').then(function(data){
		user_role = data;
		if(!user_role.read) res.render('Errors/403');
		return CountryModel.findAll({
			order:[
				['name','ASC']
			]
		});
	}).then(function(data){
		countries = data;
		return UserRole.allRead(user);
	}).then(function(data){
		usrRole = data;
		res.render('Recruitment/Profile/index',{
			countries: countries,
			usrRole: usrRole,
			user_role: user_role,
			route: 'recruitment-candidate'
		});
	});
	
}

exports.fetch = function(req, res){
	let page		= req.query.page;
	let limit       = req.query.limit ? parseInt(req.query.limit) : 25;
	let offset   = (parseInt(page) - 1) * parseInt(limit);
	CandidateProfileModel.count({
		where:{
			status: 1
		}
	}).then(function(data){
		numrows = data;
		return CandidateProfileModel.findAll({
			where:{
				status: 1
			},
			offset: offset,
			limit: limit
		});
	}).then(function(data){
		records = data;

		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
        //console.log(count);
		res.status(200).json({
            success: true,
            records: records,
			count: count,
        });
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/recruitment/';
	let form = new formidable.IncomingForm();
	
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		req.checkBody('position').notEmpty().withMessage('The position field is required.');
		req.checkBody('first_name').notEmpty().withMessage('The first name field is required.');
		req.checkBody('last_name').notEmpty().withMessage('The last name field is required.');
		req.checkBody('nationality').notEmpty().withMessage('The nationality field is required.');
		req.checkBody('marital_status').notEmpty().withMessage('The marital status field is required.');
		req.checkBody('gender').notEmpty().withMessage('The gender field is required.');
		req.checkBody('birthday').notEmpty().withMessage('The birthday field is required.');
		req.checkBody('phone_number').notEmpty().withMessage('The phone number field is required.');
		req.checkBody('current_address').notEmpty().withMessage('The current address field is required.');

		let errors = req.validationErrors();

		if(errors){

			res.status(422).json({
				success: false,
	            errors
			});

		}else{
			let attachment 	= files.attachment;
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
					});
				});
			}
			
			let reqBody = {
				position_applying_for: req.body.position,
				first_name: req.body.first_name,
				last_name: req.body.last_name,
				current_address: req.body.current_address,
				permanent_address: req.body.permanent_address,
				email: req.body.email,
				phone_number: req.body.phone_number,
				alternate_number: req.body.alternate_number,
				birthday: res.locals.moment(new Date(req.body.birthday)).format('YYYY-MM-DD'),
				gender: req.body.gender,
				marital_status: req.body.marital_status,
				nationality: req.body.nationality,
				attachment: filename,
				status: 1,
				sss_number: req.body.sss_number,
				pagibig_number: req.body.pagibig_number,
				philhealth_number: req.body.philhealth_number,
				tin_number: req.body.tin_number,
				created_by: user.id,
			}
			CandidateProfileModel.create(reqBody).then(function(data){
				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'New record has been successfully saved.'
				});
			});
		}
	});
}

exports.update = function(req, res){
	let user = res.locals.user;
	let uploadPath = './assets/uploads/recruitment/';
	let form = new formidable.IncomingForm();
	
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		req.checkBody('position').notEmpty().withMessage('The position field is required.');
		req.checkBody('first_name').notEmpty().withMessage('The first name field is required.');
		req.checkBody('last_name').notEmpty().withMessage('The last name field is required.');
		req.checkBody('nationality').notEmpty().withMessage('The nationality field is required.');
		req.checkBody('marital_status').notEmpty().withMessage('The marital status field is required.');
		req.checkBody('gender').notEmpty().withMessage('The gender field is required.');
		req.checkBody('birthday').notEmpty().withMessage('The birthday field is required.');
		req.checkBody('phone_number').notEmpty().withMessage('The phone number field is required.');
		req.checkBody('current_address').notEmpty().withMessage('The current address field is required.');

		let errors = req.validationErrors();

		if(errors){

			res.status(422).json({
				success: false,
	            errors
			});

		}else{
			let id = req.body.id;
			let attachment 	= files.attachment;
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
					});
				});
			}
			
			let reqBody = {
				position_applying_for: req.body.position,
				first_name: req.body.first_name,
				last_name: req.body.last_name,
				current_address: req.body.current_address,
				permanent_address: req.body.permanent_address,
				email: req.body.email,
				phone_number: req.body.phone_number,
				alternate_number: req.body.alternate_number,
				birthday: res.locals.moment(new Date(req.body.birthday)).format('YYYY-MM-DD'),
				gender: req.body.gender,
				marital_status: req.body.marital_status,
				nationality: req.body.nationality,
				attachment: filename,
				sss_number: req.body.sss_number,
				pagibig_number: req.body.pagibig_number,
				philhealth_number: req.body.philhealth_number,
				tin_number: req.body.tin_number,
				updated_by: user.id,
			}
			CandidateProfileModel.update(reqBody,{
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
	});
}

exports.edit = function(req, res){
	let id = req.body.id;
	CandidateProfileModel.findOne({
		where:{
			id: id
		}
	}).then(function(data){
		record = data;
		res.status(200).json({
			success: true,
			record: record
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	let reqBody = {
		status: 6
	}
	CandidateProfileModel.update(reqBody,{
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}
