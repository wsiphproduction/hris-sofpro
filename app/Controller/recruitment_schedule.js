const UserRole = require('../Helper/UserRole');
const { 
	CandidateProfileModel 
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'recruitment-schedule').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/403');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Recruitment/Scheduling/index',{
					user_role: user_role,
					usrRole: usrRole,
					route: 'recruitment-schedule'
				});
			});
		}
	});	
}

exports.init = function(req, res){
	let id = req.body.id;
	let where = {}
	if(id){
		where.id = id;
	}else{
		where.status=1;
	}
	CandidateProfileModel.findAll({
		where: where
	}).then(function(data){
		candidate = data;
		//console.log(candidate);
		res.status(200).json({
			success: true,
			candidate: candidate
		});
	});
}

exports.get = function(req, res){
	
	let date = req.body.date;
	let start = new Date(date);
		start.setMonth(start.getMonth() - 1);
		start.setDate(15);
		start = res.locals.moment(start).format('YYYY-MM-DD');
	let end = new Date(date);
		end.setMonth(end.getMonth() + 1);
		end.setDate(15);
		end = res.locals.moment(end).format('YYYY-MM-DD');

	CandidateProfileModel.findAll({
		where: {
			interview_schedule: {
				$between: [start, end]
			}
		}
	}).then(function(data){
		events = data;
		res.status(200).json({
			success: true,
			events: events
		});
	});
}

exports.store = function(req, res){
	let id = req.body.candidate;
	let date = res.locals.moment(req.body.date_time).format('YYYY-MM-DD HH:mm:ss');
	req.checkBody('candidate').notEmpty().withMessage('The candidate field is required.');
	req.checkBody('date_time').notEmpty().withMessage('The date and time field is required.');
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			status: 2,
			interview_schedule: date
		}
		CandidateProfileModel.update(reqBody, {
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

exports.update = function(req, res){
	let id = req.body.candidate;
	let date = res.locals.moment(req.body.date_time).format('YYYY-MM-DD HH:mm:ss');
	req.checkBody('candidate').notEmpty().withMessage('The candidate field is required.');
	req.checkBody('date_time').notEmpty().withMessage('The date and time field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();

	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			interview_status: req.body.status,
			interview_schedule: req.body.date_time,
			note: req.body.note
		}
		
		CandidateProfileModel.update(reqBody, {
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

exports.edit = function(req, res){
	let id = req.body.id;
	CandidateProfileModel.findOne({
		where: {
			id:id
		}
	}).then(function(data){
		record = data;
		res.status(200).json({
			success: true,
			record: record
		});
	});
}