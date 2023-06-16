const UserRole = require('../Helper/UserRole');
const { 
	UsersModel, 
    EducationsModel,
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
			UserRole.get_role(user, 'academic-background').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/AcademicBackground/index', {
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

        return EducationsModel.findAll({
            where: {
                user_id: userID
            }
        }).then(data => {
            educations = data;
            res.status(200).json({
                success: true,
                educations
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
        userID = data.id;
        
        let reqData = {
            user_id: userID,
            educational_attainment: Object.keys(req.body).includes('others') ? req.body.others : req.body.educational_attainment,
            degree: req.body.degree,
            school: req.body.school,
            date_from: req.body.date_from ? req.body.date_from : null,
            date_to: req.body.date_to ? req.body.date_to : null,
            course: req.body.course,
            specialization: req.body.specialization,
            school: req.body.school,
            honors: req.body.honors
        };

        EducationsModel.create(reqData).then(data => {
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
            educational_attainment: Object.keys(req.body).includes('others') ? req.body.others : req.body.educational_attainment,
            degree: req.body.degree,
            school: req.body.school,
            date_from: req.body.date_from ? req.body.date_from : null,
            date_to: req.body.date_to ? req.body.date_to : null,
            course: req.body.course,
            specialization: req.body.specialization,
            school: req.body.school,
            honors: req.body.honors
        };

        EducationsModel.update(reqData, {
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