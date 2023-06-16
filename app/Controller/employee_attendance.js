const UserRole = require('../Helper/UserRole');
const { 
	ConfigModel,
	UsersModel,
	OvertimesModel,
	ShiftsModel,
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
			UserRole.get_role(user, 'employee-attendance').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					UserRole.allRead(user).then(function(data){
						usrRole = data;
						res.render('Employee/Attendance/index',{
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

exports.fetch = function(req, res){
	
	let shortid = req.body.shortid;
	let date = new Date(req.body.date);
	let startOf = new res.locals.moment(date).startOf("month").format("YYYY-MM-DD");
	let endOf = new res.locals.moment(date).endOf("month").format("YYYY-MM-DD");
	
	UsersModel.findOne({
		where: {
			shortid: shortid
		}
	}).then(function(data){
		employee = data;
		return ShiftsModel.findAll({
			where: {
				user_id: employee.id,
				date: {
					$between: [startOf, endOf]
				}
			},
			include: [
				{
					model: OvertimesModel,
					required: false,
					where:{
						start_date: {$col: 'shifts.date'}
					},
					attributes: ['start_date','end_date','start_time','end_time','no_of_hours']
				}
			],
			order: [
				['date', 'ASC']
			],
		});
	}).then(function(data){
		records = data;
		return ConfigModel.findOne({
			where: {
				id: 1
			}
		});
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		res.status(200).json({
			success: true,
			config: json,
            records: records
		});
		
	});
}