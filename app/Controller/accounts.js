const UserRole = require('../Helper/UserRole');
const {
	UsersModel,
	CrmChaseModel,
	CrmCloneModel,
	CrmMemberModel,
	TaxonomyModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'accounts');
	}).then(function(data){
		user_role = data;
		res.render('Account/index',{
			route: 'accounts',
			user_role: user_role,
			usrRole: usrRole
		});
	});
}

exports.fetchChase = function(req, res){
	let user    = res.locals.user;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	CrmChaseModel.findAll({
		order: [
			['id','desc']
		]
	}).then(function(data){
		chase = data;
		res.status(200).json({
			success: true,
			chase: chase
		});
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('account').notEmpty().withMessage('The account field is required.');
	req.checkBody('site').notEmpty().withMessage('The project site field is required.');
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	req.checkBody('revenue').notEmpty().withMessage('The revenue field is required.');
	req.checkBody('sales').notEmpty().withMessage('The sales field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			account: req.body.account,
			project_site: req.body.site,
			type: req.body.type,
			revenue: req.body.revenue,
			sales: req.body.sales,
			created_by: user.id
		}
		CrmChaseModel.create(reqData).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'New record has been successfully created.'
			});
		});
	}
}

exports.storeWin = function(req, res){
	let user = res.locals.user;
	let member = req.body.member;
	let chase_id = req.body.chase_id;
	let count = 0;
	if(member){
		for(let x in member){
			if(member[x].user_id != ''){
				count ++;
			}
		}
	}
	req.body.members = 'ok';
	if(count <= 0){
		req.body.members = '';
	}
	req.checkBody('sqm').notEmpty().withMessage('The sqm field is required.');
	req.checkBody('members').notEmpty().withMessage('Select member.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqData = {
			chase_id: chase_id,
			sqm: req.body.sqm,
			flag: 1,
			created_by: user.id
		}
		
		CrmCloneModel.create(reqData).then(function(data){
			win_id = data.id;
			if(member.length){
				for(let i in member){
					if(member[i].user_id){
						let memberData = {
							win_id: win_id,
							user_id: member[i].user_id
						}
						CrmMemberModel.create(memberData);
					}
				}
			}
			res.status(200).json({
				success: true,
				action: 'fetch',
				methods: ['fetchWin'],
				msg: 'New record has been successfully created.'
			});
		});
//
	}
}

exports.init = function(req, res){
	TaxonomyModel.findAll({
		where: {
			parent_id: 33,
			status: 1
		},
		order: [
			['id', 'asc']
		],
		attributes: ['title']
	}).then(function(data){
		sale_option = data;
		return UsersModel.findAll({
			where: {
				status: 1
			},
			order: [
				['first_name', 'asc']
			],
			attributes: ['id','first_name','last_name']
		});
		
	}).then(function(data){
		members = data;
		res.status(200).json({
			success: true,
			sale_option: sale_option,
			members: members
		});
	});
}