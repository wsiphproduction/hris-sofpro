const UserRole = require('../Helper/UserRole');
const { 
	LeavePolicyModel,
	BranchesModel,
	CompanyModel,
	TaxonomyModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-leave-policy');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			BranchesModel.findAll({
				where: {
					status: 1
				},
				order: [
					// ['location', 'ASC']
				],
				include: [ CompanyModel ]
			}).then(function(data){
				company = data;
				return TaxonomyModel.findAll({
					where: {
						parent_id: 1,
						status: 1
					},
					order: [
						['title', 'ASC']
					]
				});
			}).then(function(data){
				department = data;
				res.render('Settings/LeavePolicy/index',{
					user_role: user_role,
					usrRole: usrRole,
					company: company,
					department: department,
					route: 'leave-policy'
				});
			});
		}
	});
}

exports.store = function(req, res){
	req.checkBody('name').notEmpty().withMessage('The leave name field is required.');
	req.checkBody('code').notEmpty().withMessage('The code name field is required.');
	req.checkBody('total').notEmpty().isNumeric().withMessage('The total number of leave per year field is required  and must be an integer.');
	req.checkBody('probation_validity').notEmpty().isNumeric().withMessage('The probation period before validity field is required  and must be an integer.');
	req.checkBody('cycle').notEmpty().withMessage('The cycle field is required.');
	//req.checkBody('increment').notEmpty().isNumeric().withMessage('The increment per cycle field is required  and must be an integer.');
	//req.checkBody('max').notEmpty().isNumeric().withMessage('The maximum increment field is required and must be an integer.');
	req.checkBody('initial').notEmpty().isNumeric().withMessage('The Initial leave credit field is required and must be an integer.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('carry_over').notEmpty().withMessage('The carry over is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			name: req.body.name,
			code: req.body.code,
			total_per_year: req.body.total,
			gender: req.body.gender,
			probation_validity: req.body.probation_validity,
			initial: req.body.initial,
			cycle: req.body.cycle,
			company: req.body.company ? req.body.company : null,
			department: req.body.department ? req.body.department : null,
			status: req.body.status,
			description: req.body.description,
			carry_over: req.body.carry_over,
		}
		LeavePolicyModel.create(reqData).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'New record has been successfully created.'
			});
		});
	}
}

exports.update = function(req, res){
	req.checkBody('name').notEmpty().withMessage('The leave name field is required.');
	req.checkBody('code').notEmpty().withMessage('The code name field is required.');
	req.checkBody('total').notEmpty().isNumeric().withMessage('The total number of leave per year field is required  and must be an integer.');
	req.checkBody('probation_validity').notEmpty().isNumeric().withMessage('The probation period before validity field is required  and must be an integer.');
	req.checkBody('cycle').notEmpty().withMessage('The cycle field is required.');
	//req.checkBody('increment').notEmpty().isNumeric().withMessage('The increment per cycle field is required  and must be an integer.');
	//req.checkBody('max').notEmpty().isNumeric().withMessage('The maximum increment field is required and must be an integer.');
	req.checkBody('initial').notEmpty().isNumeric().withMessage('The Initial leave credit field is required and must be an integer.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	req.checkBody('carry_over').notEmpty().withMessage('The carry over is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		let reqData = {
			name: req.body.name,
			code: req.body.code,
			total_per_year: req.body.total,
			gender: req.body.gender,
			probation_validity: req.body.probation_validity,
			initial: req.body.initial,
			cycle: req.body.cycle,
			company: req.body.company ? req.body.company : null,
			department: req.body.department ? req.body.department : null,
			status: req.body.status,
			description: req.body.description,
			carry_over: req.body.carry_over,
		}
		LeavePolicyModel.update(reqData,{
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

exports.fetch = function(req, res){
	LeavePolicyModel.findAll({
		where: {
			status: {
				$ne: 9
			}
		},
		order: [
			['name', 'asc']
		],
		include: [
			{
				model: TaxonomyModel,
				attributes: ['title']
			},
			{
    			model: BranchesModel,
    			// attributes: ['location'],
    			include: [
    				{
    					model: CompanyModel,
    					attributes: ['name'],
    				}
    			]
    		}
		]
	}).then(function(data){
		records = data;
		res.status(200).json({
			success: true,
			records: records
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	let reqData = {
		status: 9
	}
	LeavePolicyModel.update(reqData,{
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}