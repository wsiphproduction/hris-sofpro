const UserRole = require('../Helper/UserRole');
const { 
	ApproversModel,
	UsersModel,
	TaxonomyModel,
	CompanyModel,
	BranchesModel,
	CustomApproverModel,
	EmploymentsModel,
	Division,
	Department,
	Section
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-approvers');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			UsersModel.findAll({
				where: {
					status: 1
				},
				group: ['company_branch_id', 'department_id'],
				attributes: ['id','company_branch_id','department_id']
			}).then(function(data){
				users = data;
				let length = users.length;
				if(users){
					setApprover(users);
				}
				res.render('Settings/Approvers/index',{
					user_role: user_role,
					usrRole: usrRole,
					route: 'approvers'
				});
			});
		}
	});
	
}

exports.fetch = function(req, res){
	ApproversModel.findAll({
		include: [
			{
				model: UsersModel, 
				as: 'primary',
				attributes: ['id', 'first_name', 'last_name'] 
			},{
				model: UsersModel, 
				as: 'backup',
				attributes: ['id', 'first_name', 'last_name'] 
			},{
				model: TaxonomyModel, 
				as: 'department',
				attributes: ['title']
			},{
				model: BranchesModel,
				attributes: ['location'],
				include: [
					{
						model: CompanyModel
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

exports.custom = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-approvers');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			UsersModel.findAll({
				include: [
					{
						model: CustomApproverModel,
						as: 'employee'
					},
					{
		    			model: TaxonomyModel, 
		    			as: 'team',
		    			attributes: ['title']
		    		},
				],
				order: [
					['first_name','asc']
				],
				attributes: ['id','first_name', 'last_name']
			}).then(function(data){
				users = data;
				users   = JSON.parse(JSON.stringify(users));
				return TaxonomyModel.findAll({
					where: {
						parent_id: 270,
						status: 1
					},
					order: [
						['title', 'ASC']
					]
				});
				
			}).then(function(data){
				team = data;
				res.render('Settings/Approvers/custom', {
					record: [],
					user_role: user_role,
					usrRole: usrRole,
					route: 'approvers',
					user: user,
					users: users,
					team: team
				});
			});
			
		}
	});
	
}

exports.custom_fetch = function(req, res){
	let whereTeam = {}
	let where = {}
	if(req.body.team){
		whereTeam.team_id = req.body.team;
	}
	if(req.body.manager){
		where.primary_approver_id = req.body.manager;
	}
	CustomApproverModel.findAll({
		where: where,
		include: [
			{
				model: UsersModel,
				as: 'applicant',
				where: whereTeam,
				attributes: ['id','first_name', 'last_name'],
				include: [
					{
	    			model: TaxonomyModel, as: 'department',
		    			attributes: ['title']
		    		},
		    		{
		    			model: BranchesModel,
		    			attributes: ['location'],
		    			include: [
		    				{
		    					model: CompanyModel,
		    					attributes: ['name'],
		    				}
		    			]
		    		},
		    		{
		    			model: TaxonomyModel, 
		    			as: 'team',
		    			attributes: ['title']
		    		},
				]
			},
			{
				model: UsersModel,
				as: 'backup',
				attributes: ['id','first_name', 'last_name']
			},
			{
				model: UsersModel,
				as: 'primary',
				attributes: ['id','first_name', 'last_name']
			}
		]
	}).then(function(data){
		records = data;
		return CustomApproverModel.findAll({
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id','first_name', 'last_name']
				}
			]
		});
		
	}).then(function(data){
		approvers = data;
		res.status(200).json({
			success: true,
			records: records,
			approvers: approvers
		});
	});
}

exports.customStore = function(req, res){
	req.checkBody('employee').notEmpty().withMessage('The employee field is required.');
	req.checkBody('backup_approver').notEmpty().withMessage('The team leader field is required.');
	req.checkBody('primary_approver').notEmpty().withMessage('The manager/head field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let action = req.body.action;
		let user_id = req.body.employee;
		let reqData = {
			primary_approver_id: req.body.primary_approver,
			backup_approver_id: req.body.backup_approver,
		}
		if(action == 'add'){
			reqData.user_id = user_id;
			CustomApproverModel.count({
				where: {
					user_id: user_id
				}
			}).then(function(data){
				count = data;
				if(!count){
					CustomApproverModel.create(reqData).then(function(data){
						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'Record has been successfully updated.'
						});
					});
				}
			});
		}else{
			let id = req.body.id;
			CustomApproverModel.update(reqData,{
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
}

exports.custom_archive = function(req, res){
	let id = req.body.id;
	CustomApproverModel.destroy({
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

exports.edit = function(req, res){
	let id = req.body.id;
	ApproversModel.findOne({
		where: {
			id: id
		},
		include: [
			{
				model: BranchesModel,
				attributes: ['location'],
				include: [
					{
						model: CompanyModel,
						attributes: ['name']
					}
				]
			},
			{
				model: TaxonomyModel, as: 'department',
				attributes: ['title']
			}
		]
	}).then(function(data){
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
	req.checkBody('backup_approver').notEmpty().withMessage('The team leader field is required.');
	req.checkBody('primary_approver').notEmpty().withMessage('The manager/head field is required.');
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
			primary_approver_id: req.body.primary_approver,
			backup_approver_id: req.body.backup_approver,
			updated_by: user_id
		}
		ApproversModel.update(data, {
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

exports.validate = function(req, res){
	let company = req.body.company;
	let department = req.body.department;
	ApproversModel.count({
		where: {
			company_location_id: company,
			department_id: department,
		}
	}).then(function(data){
		res.status(200).json({
			count: data
		});
	});
}


exports.init_form = function(req, res){
	CompanyModel.findAll().then(function(data){
		companies = data;
		return TaxonomyModel.findAll({
			where: {
				parent_id: 1
			},
			order: [
				['title', 'ASC']
			]
		});
	}).then(function(data){
		departments = data;
		return UsersModel.findAll({
			where: {
				status: 1
			},
			order: [
				['first_name', 'ASC']
			]
		});
	}).then(function(data){
		users = data;
		res.status(200).json({
			companies: companies,
			departments: departments,
			users: users
		});
	});
}

exports.get_approver = function(req, res){
	let user = res.locals.user;
	let user_id = req.body.id ? req.body.id : user.id;
	console.log(user_id);
	EmploymentsModel.findOne({
		where:{
			user_id: user_id,
			status: 1
		},
		include:[{
				model: Division,
				as: 'division',
				include: [
					{
						model: UsersModel,
						as: 'manager',
						attributes:['id','first_name','last_name','email']
					},
					{
						model: UsersModel,
						as: 'assistant_manager',
						attributes:['id','first_name','last_name','email']
					}
				]
			},{
				model: Department,
				as: 'department',
				include: [
					{
						model: UsersModel,
						as: 'manager',
						attributes:['id','first_name','last_name','email']
					},
					{
						model: UsersModel,
						as: 'assistant_manager',
						attributes:['id','first_name','last_name','email']
					}
				]
			},{
				model: Section,
				as: 'section',
				include: [
					{
						model: UsersModel,
						as: 'supervisor',
						attributes:['id','first_name','last_name','email']
					},
					{
						model: UsersModel,
						as: 'assistant_supervisor',
						attributes:['id','first_name','last_name','email']
					}
				]
			}
		],
		order:[
			['id','desc']
		]
	}).then(data=>{
		approver = data;
		let result = null;
		if(approver){
			let organization = approver.approving_organization;
			if(organization == 'division'){
				let primary = approver.division;
				result = {
					user_id: primary.manager_id,
					first_name: primary.manager.first_name,
					last_name: primary.manager.last_name,
					email: primary.manager.email,
					secondary_user_id: primary.assistant_manager ? primary.assistant_manager_id : '',
					secondary_first_name: primary.assistant_manager ? primary.assistant_manager.first_name : '',
					secondary_last_name: primary.assistant_manager ? primary.assistant_manager.last_name : '',
					secondary_email: primary.assistant_manager ? primary.assistant_manager.email : '',
				}
			}else if(organization == 'department'){
				let primary = approver.department;
				result = {
					user_id: primary.manager_id,
					first_name: primary.manager.first_name,
					last_name: primary.manager.last_name,
					email: primary.manager.email,
					secondary_user_id: primary.assistant_manager ? primary.assistant_manager_id : '',
					secondary_first_name: primary.assistant_manager ? primary.assistant_manager.first_name : '',
					secondary_last_name: primary.assistant_manager ? primary.assistant_manager.last_name : '',
					secondary_email: primary.assistant_manager ? primary.assistant_manager.email : '',
				}
			}else if(organization == 'section'){
				let primary = approver.section;
				result = {
					user_id: primary.supervisor_id,
					first_name: primary.supervisor.first_name,
					last_name: primary.supervisor.last_name,
					email: primary.supervisor.email,
					secondary_user_id: primary.assistant_supervisor_id,
					secondary_first_name: primary.assistant_supervisor ? primary.assistant_supervisor.first_name : '',
					secondary_last_name: primary.assistant_supervisor ? primary.assistant_supervisor.last_name : '',
					secondary_email: primary.assistant_supervisor ? primary.assistant_supervisor.email : '',
				}
			}
			res.status(200).json({
				approver: result
			});
		}
	});

}


const setApprover = function(user){
	for(let i in user){
		let branch_id = user[i]['company_branch_id'];
		let department_id = user[i]['department_id'];
		if(branch_id > 0 && department_id > 0){
			ApproversModel.findOrCreate({
				where: {
					company_location_id: branch_id,
					department_id: department_id
				}, defaults: {
					company_location_id: branch_id,
					department_id: department_id,
				}
			});
		}
	}
}
