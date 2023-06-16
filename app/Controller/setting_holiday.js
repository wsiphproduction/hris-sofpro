const pagination  = require('../Helper/Pagination');
const UserRole = require('../Helper/UserRole');
const { 
	Op,
	HolidaysModel,
	CountryModel,
	Location
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-holidays');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			let view = req.query.view;
			if(typeof view != 'undefined' && view == 'calendar'){
				res.render('Settings/Holiday/calendar',{
					user_role: user_role,
					route: 'holidays'
				});
			}else{
				var page		= req.query.page;
				let limit       = 100;
				if(typeof page == 'undefined' || page < 1){
					page = 1;
				}
				let offset   = (parseInt(page) - 1) * parseInt(limit);
				let link = '/settings/holidays?page=';
				HolidaysModel.count().then(function(data){
					count = data;
					return HolidaysModel.findAll({
						offset: offset,
			    		limit: limit,
			    		// include: [
			    		// 	{
			    		// 		model: Location,
			    		// 		attributes: ['location', 'id']
			    		// 	}
			    		// ],
			    		order: [
			    			['date','DESC']
			    		],
						raw: true
					});
				}).then(function(data){
					holidays_data = data;
					let unique_location_id_array = []
					
					unique_location_id_array += (holidays_data.map(a => a.location_id.split(",").map(Number)))
					unique_location_id_array = [...new Set(unique_location_id_array.split(",").map(Number))]
					return Location.findAll({
						where: {
							id: {
									[Op.in]: unique_location_id_array
							}
						},
					}).then(function(data){
						locations_data = data;

						for (let i in holidays_data){
							var loc_id = holidays_data[i].location_id
							var loc_id_array = loc_id.split(",").map(Number);
							let results = locations_data.filter(x => loc_id_array.includes(x.id));
							holidays_data[i]['location'] = results.map(x => x.location).toString()
						}
						
						let paginate = pagination.generate(count, limit, page, link);
						res.render('Settings/Holiday/index',{
							user_role: user_role,
							record: holidays_data,
							paginate: paginate,
							usrRole: usrRole,
							route: 'holidays'
						});
					});
				});
			}
		}
	});
	
}

exports.store = function(req, res){
	let user = res.locals.user;
	let location_id_list = req.body.location.map(a => a.id);
	req.checkBody('location').notEmpty().withMessage('The location field is required.');
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('title').notEmpty().withMessage('The holiday field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let date = res.locals.moment(req.body.date).format('YYYY-MM-DD');
		let data = {
			location_id: location_id_list.toString(),
			date: date,
			title: req.body.title,
			type: req.body.type,
			status: req.body.status,
			note: req.body.note,
			created_by: user.id
		}
		HolidaysModel.create(data).then(function(data){
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'New record has been successfully saved.'
			});
		});
	}
}

exports.edit = function(req, res){
	let id = req.body.id;
	HolidaysModel.findByPk(id).then(function(data){
		if(!data) res.status(404).json({
			success: false,
			msg: 'No record found for the given selection.'
		});
		res.status(200).json({
			success: true,
			record: data
		});
	});
}

exports.update = function(req, res){
	let id = req.body.id;
	let user = res.locals.user;
	let location_id_list = req.body.location.map(a => a.id);

	req.checkBody('location').notEmpty().withMessage('The location field is required.');
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('title').notEmpty().withMessage('The holiday field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let date = res.locals.moment(req.body.date).format('YYYY-MM-DD');
		let data = {
			location_id: location_id_list.toString(),
			date: date,
			title: req.body.title,
			type: req.body.type,
			status: req.body.status,
			note: req.body.note,
			updated_by: user.id
		}
		HolidaysModel.update(data, {
			where: {
				id: id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'close',
				msg: 'New record has been successfully saved.'
			});
		});
	}
}

exports.init_form = function(req, res){
	Location.findAll({
		order: [
			['location', 'ASC']
		]
	}).then(function(data){
		locations = data;
		res.status(200).json({
			locations: locations
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	let user = res.locals.user;
	let data = {
		status: 3,
		updated_by: user.id
	}
	HolidaysModel.destroy({
		where: {
			id: id
		}
	}).then(function(data){
		res.status(200).json({
			success: true,
			action: 'close',
		});
	});
}

exports.calendar = function(req, res){
	let start = new Date(req.body.date);
		start.setMonth(start.getMonth() - 1);
		start.setDate(15);

		start = res.locals.moment(start).format('YYYY-MM-DD');
	let end = new Date(req.body.date);
		end.setMonth(end.getMonth() + 1);
		end.setDate(15);

		end = res.locals.moment(end).format('YYYY-MM-DD');
	
	HolidaysModel.findAll({
		where: {
			date: {
				$between: [start, end]
			}
		},
		include: [
			{
				model: Location,
				attributes: ['location', 'id']
			}
		]
	}).then(function(data){
		record = data;
		res.status(200).json({
			success: true,
            record
		});
	});
}