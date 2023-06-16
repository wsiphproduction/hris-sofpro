const Notification = require('../Helper/Notification');
const UserRole = require('../Helper/UserRole');
const GlobalHelper = require('../Helper/GlobalHelper');
const _ = require('underscore');
const TSSHelper = require('../Helper/TSSHelper');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const {
	Op,
	UsersModel,
	ShiftsModel,
	ApproversModel,
	ConfigModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'approvals-shift').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(async function(data){
				usrRole = data;
				res.render('Approvals/Shift/index',{
					route: 'app-shift',
					usrRole: usrRole,
					user_role: user_role,
					cutoff: await GlobalHelper.cutoff()
				});
			});
		}
	});
}

exports.fetch_user = function(req, res){
	let user = res.locals.user;
	ShiftsModel.findAll({
		where: {
			$or: [
				{
					primary_approver: user.id
				},
				{
					backup_approver: user.id
				}
			]
		},
		group: ['user_id'],
		include: [
			{
				model: UsersModel, as: 'applicant',
				attributes: ['id', 'first_name', 'last_name']
			}
		],
	}).then(function(data){
		users = data;
		res.status(200).json({
            success: true,
            users: users
        });
	});
}
exports.fetch = async(req, res)=>{
//exports.fetch = function(req, res){
	let user = res.locals.user;
	let applicant 	= req.body.applicant;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let key 	= req.body.key;
    let session = req.session;

	let whereUser = {}
	let where = {
		$or: [
			{
				primary_approver: user.id
			},
			{
				backup_approver: user.id
			}
		]
	}
	if(status){
		where.primary_status = status;
	}
	if(applicant){
		where.user_id = applicant;
	}
	if((start && end) && (start <= end)){
		where.date = {
	        $between: [start, end]
	    }
	}
	if(key) {
		whereUser[Op.or] = {
				first_name : {
					[Op.like] : '%'+ key +'%'
				},
				last_name : {
					[Op.like] : '%'+ key +'%'
				},
				middle_name : {
					[Op.like] : '%'+ key +'%'
				},
				email : {
					[Op.like] : '%'+ key +'%'
				},
				username : {
					[Op.like] : '%'+ key +'%'
				},
				employee_number : {
					[Op.like] : '%'+ key +'%'
				},
			}
		let employee_not_existing_list = await getEmployeeIDViaKey(whereUser);
		where.user_id = {
				[Op.in]: employee_not_existing_list
		}
	}
	
	ConfigModel.findOne({
        where: {
            id: 1
        }
    }).then(function (data) {
        config = data;
        json = config.json ? JSON.parse(config.json) : null;

		ShiftsModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return ShiftsModel.findAll({
				where: where,
				order: [
					['date', 'DESC']
				],
				include: [
					{
						model: UsersModel, as: 'applicant',
						attributes: ['id', 'first_name', 'last_name']
					}
				],
				offset: offset,
				limit: limit,
			});
		}).then(function(data){
			records = data;
			//records.appId = user.id;
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
				appId: user.id,
				config: config,
				session: session
			});
		});
	});
}

const getEmployeeIDViaKey =  async (queryFilter)=>{
	let results = [];
	
	await UsersModel.findAll({
		where: queryFilter,
		raw: false,
	}).then(data=>{
		users = data;
		if(users && users.length){
			results = _.pluck(users, 'id');
			results = [...new Set(results)];
		}		
	});
	
	return results
}

exports.update = function(req, res){
	let user 	 = res.locals.user;
	let status 	 = req.body.status == 'approve' ? 2 : 3;
	let checkbox = req.body.checkbox; 
	if(checkbox.length){
		for(let x in checkbox){
			let id = checkbox[x];
			ShiftsModel.findOne({
				where: {
					id: id
				},
				attributes: ['id','primary_approver', 'backup_approver'],
				
			}).then(function(data){
				let result = data;
				if(user.id == result.primary_approver || true){
					let reqData = {
						primary_status: status,
						backup_status: status,
						updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
					}
					ShiftsModel.update(reqData, {
						where: {
							id: id,
							primary_status: 1
						}
					});
				}else{
					let reqData = {
						backup_status: status,
						updated_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss"),
					}
					ShiftsModel.update(reqData, {
						where: {
							id: id,
							backup_status: 1
						}
					});
				}
			});

		}
	}

	res.status(200).json({
		success: true,
	});
}

exports.calendar = function(req, res){
	res.render('Approvals/Shift/calendar',{
		route: 'app-shift'
	});
}

exports.calendar_fetch = function(req, res){
	let user 	 = res.locals.user;
	let status = req.body.status;
	let start = new Date(req.body.date);
		start.setMonth(start.getMonth() - 1);
		start.setDate(15);
		start = res.locals.moment(start).format('YYYY-MM-DD');
	let end = new Date(req.body.date);
		end.setMonth(end.getMonth() + 1);
		end.setDate(15);
		end = res.locals.moment(end).format('YYYY-MM-DD');

	let where = {
		date: {
	        $between: [start, end]
	    }
	}

	if(status){
		where.$or = [
			{
				primary_status: status
			},{
				backup_status: status
			}
		]
	}

	ShiftsModel.findAll({
		where: where,
		include: [
			{
				model: UsersModel, as: 'applicant',
				attributes: ['id', 'first_name', 'last_name']
			}
		]
	}).then(function(data){
		records = data;
		res.status(200).json({
			success: true,
			records: records,
			appId: user.id
		});
	});
}

exports.events = function(req, res){
	let user 	 = res.locals.user;
	let user_id = req.body.user_id;
	let date    = new Date(req.body.date);
	let startOf = res.locals.moment(date).startOf('month').format('YYYY-MM-DD HH:mm:ss');
	let endOf = res.locals.moment(date).endOf('month').format('YYYY-MM-DD HH:mm:ss');
	ShiftsModel.findAll({
		where: {
			user_id: user_id,
			date: {
				$between: [startOf, endOf]
			}
		},
		//attributes: ['date', 'check_in', 'check_out','type']
	}).then(function(data){
		events = data;
		res.status(200).json({
			success: true,
			events: events,
			appId: user.id
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	ShiftsModel.destroy({
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
}
