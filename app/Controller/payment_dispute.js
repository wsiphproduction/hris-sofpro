const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	DisputeModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		UserRole.get_role(user, 'payment-dispute').then(function(data){
			user_role = data;
			if(!user_role.read) {
				res.render('Errors/403');
			}else{
				res.render('Payment/Dispute/index', {
					route: 'payment-dispute',
					usrRole: usrRole,
					user_role: user_role
				});
			}
		});
	});
}

exports.fetch = function(req, res){
	let year 	= req.body.year;
	let month  	= req.body.month;
	let period  	= req.body.period;
	let company  	= req.body.company;
	let department  	= req.body.department;
	let designation  = req.body.designation;
	let limit   = parseInt(req.body.limit);
	let page = req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	
	let where = {}
	let userWhere = {}
	if(year){
		where.year = year;
	}
	if(month){
		where.month = month;
	}
	if(period){
		where.period = period;
	}
	if(company){
		userWhere.company_branch_id = company;
	}
	if(department){
		userWhere.department_id = department;
	}
	if(designation){
		userWhere.job_title_id = designation;
	}
	UsersModel.findAll({
		where: {
			status: 1
		},
		order: [
			['first_name','ASC']
		]
	}).then(function(data){
		applicant = data;
		return DisputeModel.count({
			where: where,
			include: [
				{
					model: UsersModel,
					as: 'applicant',
					where: userWhere
				}
			]
		});
		
	}).then(function(data){
		numrows = data;
		return DisputeModel.findAll({
			where: where,
			include: [
				{
					model: UsersModel,
					as: 'applicant',
					where: userWhere,
					attributes: ['id','first_name','last_name']
				}
			],
			order: [
				['created_at','desc']
			],
			limit: limit,
			offset: offset
		});
		
	}).then(function(data){
		records = data;
		records   = JSON.parse(JSON.stringify(records));
		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
        //console.log(records);
		res.status(200).json({
			success: true,
			applicant: applicant,
			records: records,
			count: count,
		});
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('applicant').notEmpty().withMessage('The applicant field is required.');
	req.checkBody('year').notEmpty().withMessage('The year field is required.');
	req.checkBody('month').notEmpty().withMessage('The month field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('note').notEmpty().withMessage('The note field is required.');
	if(req.body.type != 4){
		let typeMessage = req.body.type == 3 ? 'The number day field is required.':'The number hour field is required.';
		req.checkBody('hours').notEmpty().withMessage(typeMessage);
	}
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		if(req.body.type == 1 || req.body.type == 2){
			hours = hours;
		}else if(req.body.type == 3){
			hours = parseInt(hours) * 8;
		}else if(req.body.type == 4){
			hours = 4;
		}
		let reqData = {
			user_id: req.body.applicant,
			year: req.body.year,
			month: req.body.month,
			period: req.body.period,
			hour: hours,
			date: res.locals.moment(req.body.date).format('YYYY-MM-DD'),
			type: req.body.type,
			note: req.body.note,
			admin_status: req.body.status,
		}
		DisputeModel.create(reqData).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Dispute has been created.'
			});
		});
	}
}

exports.update = function(req, res){
	let user = res.locals.user;
	req.checkBody('year').notEmpty().withMessage('The year field is required.');
	req.checkBody('month').notEmpty().withMessage('The month field is required.');
	req.checkBody('period').notEmpty().withMessage('The period field is required.');
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('note').notEmpty().withMessage('The note field is required.');
	if(req.body.type != 4){
		let typeMessage = req.body.type == 3 ? 'The number day field is required.':'The number hour field is required.';
		req.checkBody('hours').notEmpty().withMessage(typeMessage);
	}
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		let hours = req.body.hours;
		if(req.body.type == 1 || req.body.type == 2){
			hours = hours;
		}else if(req.body.type == 3){
			hours = parseInt(hours) * 8;
		}else if(req.body.type == 4){
			hours = 4;
		}
		let reqData = {
			year: req.body.year,
			month: req.body.month,
			period: req.body.period,
			hour: hours,
			date: res.locals.moment(req.body.date).format('YYYY-MM-DD'),
			type: req.body.type,
			note: req.body.note,
			admin_status: req.body.status,
		}
		DisputeModel.update(reqData,{
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Dispute has been updated.'
			});
		});
	}
}