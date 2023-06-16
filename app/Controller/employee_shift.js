const UserRole = require('../Helper/UserRole');
const { 
	UsersModel,
	ShiftsModel,
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
			UserRole.get_role(user, 'employee-shift').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/Shift/index',{
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
	let start = new Date(req.body.date);
		start.setMonth(start.getMonth() - 1);
		start.setDate(15);
		start = res.locals.moment(start).format('YYYY-MM-DD');
	let end = new Date(req.body.date);
		end.setMonth(end.getMonth() + 1);
		end.setDate(15);
		end = res.locals.moment(end).format('YYYY-MM-DD');

	UsersModel.findOne({
		where: {
			shortid: id
		}
	}).then(function(data){
		employee = data;
		if(!employee) res.render('Errors/404');
		let param = {
			user_id: employee.id,
			start_date: start,
			end_date: end,
		}
		return ShiftsModel.findAll({
			where: {
				user_id: employee.id,
				date: {
					$between: [start, end]
				}
			}
		});
	}).then(function(data){
		res.status(200).json({
			success: true,
            records: data
		});
	});
}