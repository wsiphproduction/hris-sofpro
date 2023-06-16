const UserRole = require('../Helper/UserRole');
const { 
	UsersModel, 
    FamilyBackgroundModel,
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
			UserRole.get_role(user, 'family-background').then(function(data){
				user_role = data;
				if(!user_role.read) {
					res.render('Errors/403');
				}else{
					res.render('Employee/FamilyBackground/index', {
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
        return FamilyBackgroundModel.findAll({
            where: {
                user_id: user.id
            },
			include: [
				{
					model: AddressModel
				}
			]
        }).then(data => {
            familyBackground = data;
            res.status(200).json({
                success: true,
                familyBackground
            })
        })
    })
}

exports.store = function(req, res){
	let dob = new Date(req.body.birthdate);

	// Calculate age
	let today = new Date();
	let age = today.getFullYear() - dob.getFullYear();
	let monthDiff = today.getMonth() - dob.getMonth();
	
	if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
		age--;
	}

    UsersModel.findOne({
		where: {
			shortId: req.params.id
		}
	}).then(data => {
		userID = data.id;

		let reqData = {
			user_id: userID,
			first_name: req.body.first_name,
			middle_name: req.body.middle_name,
			last_name: req.body.last_name,
			relationship: req.body.relationship,
			address: req.body.address,
			contact_number: req.body.contact_number,
			birthdate: req.body.birthdate ? req.body.birthdate : null,
			age: req.body.birthdate ? age : '',
			occupation: req.body.occupation,
			assign_as_dependent: req.body.assign_as_dependent
		}; 

		FamilyBackgroundModel.create(reqData).then(data => {
			let family_background = data;
			let family_background_id = family_background.id;

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
				let familyBackgroundData = {
					permanent_address_id: permanent_address_id
				};
				FamilyBackgroundModel.update(familyBackgroundData, {
					where: {
						id: family_background_id
					}
				})
			});
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully created.'
			});
		})  
	})
}

exports.update = function(req, res){
	let dob = new Date(req.body.birthdate);

	// Calculate age
	let today = new Date();
	let age = today.getFullYear() - dob.getFullYear();
	let monthDiff = today.getMonth() - dob.getMonth();

	if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
		age--;
	}

    UsersModel.findOne({
		where: {
			shortId: req.params.id
		}
	}).then(data => {
		userID = data.id;

		let reqData = {
			user_id: userID,
			first_name: req.body.first_name,
			middle_name: req.body.middle_name,
			last_name: req.body.last_name,
			relationship: req.body.relationship,
			address: req.body.address,
			contact_number: req.body.contact_number,
			birthdate: req.body.birthdate ? req.body.birthdate : null,
			age: req.body.birthdate ? age : '',
			occupation: req.body.occupation,
			assign_as_dependent: req.body.assign_as_dependent
		}; 

		FamilyBackgroundModel.update(reqData, {
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
					id: req.body.permanent_address_id.id
				}
			})
			
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'Record has been successfully updated.'
			});
		})  
	})
}