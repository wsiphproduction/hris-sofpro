const UserRole   = require('../Helper/UserRole');


const { 
	UsersModel,
	AnnouncementModel,
} = require('../../config/Sequelize');

exports.announcement = function(req, res){
	let slug = req.params.slug;
	
	AnnouncementModel.findOne({
		where: {
			slug: slug
		}
	}).then(function(data){
		record = data;
		if(record){
			res.render('Public/announcement', {
				record: record
			});
		}else{
			res.render('Errors/404');
		}
	});
	
}