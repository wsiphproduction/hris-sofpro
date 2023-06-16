const { 
	UsersModel,
	NotificationsModel,
	NotificationsReceiverModel
} = require('../../config/Sequelize');

exports.get = function(req, res){
	
	let user = res.locals.user;
	NotificationsReceiverModel.findAll({
		where: {
			user_id: user.id,
			status: 0
		},
		limit: 5,
		order: [
			['created_at', 'DESC']
		],
		include: [
			{
				model: NotificationsModel,
				include: [
					{
						model: UsersModel,
						attributes: ['id','first_name','last_name', 'avatar', 'gender']
					}
				]
			}
		]
	}).then(function(data){
		record = data;
		return NotificationsReceiverModel.count({
			where: {
				user_id: user.id,
				status: 0
			}
		});
	}).then(function(data){
		count = data;
		res.status(200).json({
			success: false,
            record: record,
            count: count
		});
	});
}

exports.read = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;
	let data = {
		status: 1
	}
	NotificationsReceiverModel.update(data, {
		where: {
			notification_id: id,
			user_id: user.id
		}
	}).then(function(data){
		res.status(200).json({
			success: false,
            data
		});
	});
}