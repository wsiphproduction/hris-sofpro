const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	LeavesModel,
	LeavePolicyModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	let id 		= req.params.id;
	let path    = req.path.split('/');
	let segment = path[2];

	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UsersModel.findOne({
			where: {
				shortid: id
			}
		})
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'employee-leave').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/Leave/index',{
						employee: employee,
						segment: segment,
						usrRole: usrRole,
						route: 'employee'
					});
				}
			});
		}
	});
}

exports.fetch = function(req, res){

	let id 		= req.params.id;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);

	
	UsersModel.findOne({
		where: {
			shortid: id
		}
	}).then(function(data){
		employee = data;
		let where = {
			user_id: employee.id
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
		if((start && end) && (start <= end)){
			where.start_date = {
		        $between: [start, end]
		    }
		}
		LeavesModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return LeavesModel.findAll({
				where: where,
				order: [
					['created_at', 'DESC']
				],
				include: [
					{
						model: LeavePolicyModel,
						attributes: ['name']
					},
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
	});
}