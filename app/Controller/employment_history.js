const UserRole = require('../Helper/UserRole');
const { 
	UsersModel, 
    EmploymentHistoryModel,
    AddressModel
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
			UserRole.get_role(user, 'employment-history').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/EmploymentHistory/index', {
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
        user = data;
        return EmploymentHistoryModel.findAll({
            where: {
                user_id: user.id
            },
			include: [
				{
					model: AddressModel
				}
			]
        }).then(data => {
            employmentHistory = data;
            res.status(200).json({
                success: true,
                employmentHistory
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

        let employmentHistoryData = {
            user_id: userID,
            company: req.body.company,
            position: req.body.position,
            date_started: req.body.date_started ? req.body.date_started : null,
            date_ended: req.body.date_ended ? req.body.date_ended : null, 
            reason_of_leaving: req.body.reason_of_leaving
        };
        
        EmploymentHistoryModel.create(employmentHistoryData).then(data => {
            let employment_history = data;
			let employment_history_id = employment_history.id;

            let permanentAddressData = {
				unit_building_residence_number: req.body.unit_building_residence_number,
				street: req.body.street,
				brgy: req.body.brgy,
				city: req.body.city,
				state_or_province: req.body.state_or_province,
				region: req.body.region,
				country: req.body.country,
				zip_code: req.body.zip_code,
				state_or_province: req.body.state_or_province,
			};

			AddressModel.create(permanentAddressData).then(function(data){
				let permanent_address_id = data.id;
				let employmentHistoryData = {
					address_id: permanent_address_id
				};

				EmploymentHistoryModel.update(employmentHistoryData, {
					where: {
						id: employment_history_id
					}
				})
			});

            res.status(200).json({
                success: true,
                action: 'fetch'
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
			company: req.body.company,
			position: req.body.position,
			date_started: req.body.date_started ? req.body.date_started : null,
			date_ended: req.body.date_ended ? req.body.date_ended : null,
			reason_of_leaving: req.body.reason_of_leaving
		}; 

		EmploymentHistoryModel.update(reqData, {
			where: {
				id: req.body.id
			}
		}).then(data => {
			let permanentAddressData = {
				unit_building_residence_number: req.body.unit_building_residence_number,
				street: req.body.street,
				brgy: req.body.brgy,
				city: req.body.city,
				state_or_province: req.body.state_or_province,
				region: req.body.region,
				country: req.body.country,
				zip_code: req.body.zip_code,
			};

			AddressModel.update(permanentAddressData, {
				where: {
					id: req.body.address_id.id
				}
			})
			
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Record has been successfully updated.'
			});
		})  
	})
}