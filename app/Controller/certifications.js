const UserRole = require('../Helper/UserRole');
const { 
	UsersModel, 
    CertificationsModel,
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
			},
		});
	}).then(function(data){
		employee = data;
		if(!employee){
			res.render('Errors/404');
		}else{
			UserRole.get_role(user, 'certifications').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/Certifications/index', {
						employee: employee,
						segment: segment,
						user_role: user_role,
						usrRole: usrRole,
						route: 'employee'
					});
				}
			});
		}
	});
}

exports.fetch = function(req, res){
    UsersModel.findOne({
        where: {
            shortid: req.body.shortid
        }
    }).then(data => {
        userID = data.id;

        return CertificationsModel.findAll({
            where: {
                user_id: userID
            }
        }).then(data => {
            certifications = data;
            res.status(200).json({
                success: true,
                certifications
            })
        })
    })   
}

exports.store = function(req, res){
    UsersModel.findOne({
        where: {
            shortId: req.params.id
        }
    }).then(data => {
        let userID = data.id;
        
        let reqData = {
            user_id: userID,
            name: req.body.name,
            description: req.body.description,
            date_issued: req.body.date_issued ? req.body.date_issued : null,
            start_date: req.body.start_date ? req.body.start_date : null,
            end_date: req.body.end_date ? req.body.end_date : null,
            expiry_date: req.body.expiry_date ? req.body.expiry_date : null,
        };

        CertificationsModel.create(reqData).then(data => {
            res.status(200).json({
                success: true,
                action: 'fetch',
                msg: 'Record has been successfully created.'
            })
        })
    })
}

exports.update = function(req, res){
    UsersModel.findOne({
        where: {
            shortId: req.params.id
        }
    }).then(data => {
        userID = data.id;

        let reqData = {
            user_id: userID,
            name: req.body.name,
            description: req.body.description,
            date_issued: req.body.date_issued ? req.body.date_issued : null,
            start_date: req.body.start_date ? req.body.start_date : null,
            end_date: req.body.end_date ? req.body.end_date : null,
            expiry_date: req.body.expiry_date ? req.body.expiry_date : null,
        };

        CertificationsModel.update(reqData, {
            where: {
                id: req.body.id
            }
        }).then(data => {
            res.status(200).json({
                success: true,
                action: 'fetch',
                msg: 'Record has been successfully updated.'
            })
        })
    })
}