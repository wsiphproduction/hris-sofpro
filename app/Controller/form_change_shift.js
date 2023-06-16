const UserRole = require('../Helper/UserRole');
const DateHelper = require('../Helper/DateHelper');
const fs = require('fs');
const formidable = require('formidable');
const uuidv4 = require('uuid/v4');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	Op,
	UsersModel,
	ShiftsModel,
	ApproversModel,
	ShiftType
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'forms-change-shift').then(function(data){
		user_role = data;
		// console.log(user_role);
		if(!user_role.read){
			res.render('Errors/404');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Form/Changeshift/index', {
					route: 'forms-change-shift',
					usrRole: usrRole,
					user_role: user_role
				});
			});
		}
	});
}

exports.store = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
		let id = req.body.id;
		req.checkBody('old_date').notEmpty().withMessage('The old field is required.');
		req.checkBody('approver_id').notEmpty().withMessage('The approver field is required.');
		req.checkBody('new_date').notEmpty().withMessage('The new date field is required.');
		req.checkBody('shift_type').notEmpty().withMessage('The shift type field is required.');
		let errors = req.validationErrors();
		// console.log(req);
		// ShiftType
		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			ShiftsModel.findOne({
				where:{
					id:id
				}
			}).then(data=>{
				shift = data;
				return ShiftType.findOne({
					where: {
						id: req.body.shift_type
					}
				});
				
			}).then(data=>{
				shift_type = data;
				

				let old_checkin = shift ? shift.check_in ? res.locals.moment(shift.check_in).utc().format('HH:mm:ss'): null : null;
				let old_checkout = shift ? shift.check_out ? res.locals.moment(shift.check_out).utc().format('HH:mm:ss'): null : null;

				if(old_checkin > old_checkout){
					old_checkout = res.locals.moment(old_checkout).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
				}

				let new_checkin = shift_type ? shift_type.shift_id == 'NONE' ? null : res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_in).utc().format('HH:mm:ss') : null;
				let new_checkout = shift_type ? shift_type.shift_id == 'NONE' ? null : res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_out).utc().format('HH:mm:ss') : null;


				if(new_checkin > new_checkout){
					new_checkout = res.locals.moment(new_checkout).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
				}

				//UPLOADING OF FILES
				let attachment 	= files.attachment;			
				let filename = null;
	
				if(attachment && attachment.size > 0){
					let path = attachment.path;
					let origFileName = attachment.name;
					let ext = origFileName.split(".");
						ext = ext.pop()
					filename = uuidv4(origFileName) + '.'+ ext;
					
	
					fs.readFile(path, function(err, data){
						fs.writeFile(uploadPath + filename, data, function(err){
							if (err) console.log(err);
							fs.unlink(path, function(err){});
						});
					});
				}
	
				let reqData = {
					primary_status: 1,
					backup_status: 1,
					primary_approver: req.body.approver_id,
					backup_approver: req.body.approver_secondary_id,
					new_checkin: new_checkin,
					new_checkout: new_checkout,
					is_change_shift: 1,
					old_checkin: old_checkin,
					old_checkout: old_checkout,
					new_shift_type: shift_type.shift_id
				}

				if(attachment && attachment.size > 0){                
					reqData.attachment = filename
				}

				ShiftsModel.update(reqData,{
					where:{
						id: id
					}
				}).then(data=>{
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'New record has been successfully created.'
					});
				});
			});
		}
	});
}

exports.update = function(req, res){
	let uploadPath = './assets/uploads/attachments/';
	let form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
		req.body = fields;
		let id = req.body.id;
		req.checkBody('new_date').notEmpty().withMessage('The new date field is required.');
		req.checkBody('shift_type').notEmpty().withMessage('The shift type field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
				errors
			});
		}else{
			ShiftsModel.findOne({
				where:{
					id:id
				}
			}).then(data=>{
				shift = data;
				return ShiftType.findOne({
					where: {
						shift_id: req.body.shift_type
					}
				});
				
			}).then(data=>{
				shift_type = data;
				let new_checkin = res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_in).utc().format('HH:mm:ss');
				let new_checkout = res.locals.moment(req.body.new_date).format('YYYY-MM-DD')+' '+ res.locals.moment(shift_type.time_out).utc().format('HH:mm:ss');
				if(new_checkin > new_checkout){
					new_checkout = res.locals.moment(new_checkout).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
				}

				//UPLOADING OF FILES
				let attachment 	= files.attachment;			
				let filename = null;
	
				if(attachment && attachment.size > 0){
					let path = attachment.path;
					let origFileName = attachment.name;
					let ext = origFileName.split(".");
						ext = ext.pop()
					filename = uuidv4(origFileName) + '.'+ ext;
					
	
					fs.readFile(path, function(err, data){
						fs.writeFile(uploadPath + filename, data, function(err){
							if (err) console.log(err);
							fs.unlink(path, function(err){});
						});
					});
				}

				let reqData = {
					new_checkin: new_checkin,
					new_checkout: new_checkout,
					new_shift_type: shift_type.shift_id
				}

				if(attachment && attachment.size > 0){                
					reqData.attachment = filename
				}

				ShiftsModel.update(reqData,{
					where:{
						id:id
					}
				}).then(data=>{
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'New record has been successfully created.'
					});
				});
			});
		}
	});
}

exports.fetch = function(req, res){
	let user    = res.locals.user;
	let start 	= req.body.start;
	let end 	= req.body.end;
	let status 	= req.body.status;
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let where = {
		user_id: user.id,
		is_change_shift: 1
	}
	if(status){
		where.primary_status = status;
	}else{
		where.primary_status = {
			$ne: 4
		}
	}
	if((start && end) && (start <= end)){
		where.date = {
	        $between: [start, end]
	    }
	}
	console.log("where: ", where)
	ShiftsModel.findAndCountAll({
		where: where,
		limit: limit,
        offset: offset,
        order: [
        	['id','desc']
        ],
        include:[
        	{
        		model: UsersModel,
        		as: 'primary'
        	},
			{
        		model: UsersModel,
        		as: 'backup'
        	}
        ]
	}).then(data=>{
		records = data;
		numrows = records.count;
        count = 0;
        if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
            count = 0;
        }

        res.status(201).json({
            success: true,
            count: count,
            records: records.rows,
            numrows: numrows,
        });
	})
}

exports.archive = function(req, res){

}

exports.initform = function(req, res){
	let user = res.locals.user;
	let date = res.locals.moment().subtract(15, 'days').format('YYYY-MM-DD');
	ShiftsModel.findAll({
		where: {
			user_id: user.id,
			new_checkin: {
				[Op.eq]: null
			},
			date: {
				[Op.gte]: date
			}
		},
		order:[
			['date','desc']
		],
		raw: true
	}).then(data=>{
		shifts = data;
		return ShiftType.findAll({
			order: [
				['shift_id','ASC']
			]
		});
	}).then(data=>{
		shift_type = data;
		res.status(201).json({
			shift_type: shift_type,
			shifts: shifts
		});
	});
}
