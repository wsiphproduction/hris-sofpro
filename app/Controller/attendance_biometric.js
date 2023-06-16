const { convertCSVToArray } = require('convert-csv-to-array');
const csv = require('csv-parser');
const fs = require('fs');
var _ = require('underscore');
const formidable = require('formidable');
const UserRole = require('../Helper/UserRole');
const AttendanceHelper= require('../Helper/AttendanceHelper');
const csvtojson = require('csvtojson')
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	UsersModel,
	BiometricNumberModel,
	ShiftsModel,
	BiometricModel,
	BiometricCsvModel,
	BiometricLog
} = require('../../config/Sequelize');

exports.index = async(req, res)=>{
	let user = res.locals.user;
	AttendanceHelper.proccess('csv');
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'attendance-biometric');
	}).then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/403');
		}else{
			res.render('Attendance/Biometric/index',{
				route: 'attendance-biometric',
				usrRole: usrRole,
				user_role: user_role
			});
		}
	});
}

exports.store = function(req, res){
	let uploadPath = './assets/uploads/biometric/';
	let form = new formidable.IncomingForm();
	let invalidDates = [];

	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let attachment 	= files.csv;
		let size 		= attachment.size;
		req.body.csv 	= size ? size: '';

		req.checkBody('site').notEmpty().withMessage('The site field is required.');
		req.checkBody('csv').notEmpty().withMessage('The site field is required.');
		let errors = req.validationErrors();

		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let date 		= res.locals.moment().format('YYYY-MM-DD');
			let filename 	= res.locals.moment().format('YYYYMMDDHHmmss');
			if(attachment && attachment.size > 0){
				let path 			= attachment.path;
				let origFileName 	= attachment.name;
				let ext 			= origFileName.split(".");
					ext 			= ext.pop()
				filename = filename + '.'+ ext;

				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){});
					});
				});
			}
			let reqData = {
				site	 : req.body.site,
				filename : filename,
				date	 : date
			};
			
			BiometricModel.findOne({
				where:{
					id: reqData.site
				}
			}).then(data=>{
				biometric = data;
			
				BiometricCsvModel.create(reqData).then(function(data){
					let insertedId = data.id;
					let ip_address = req.body.site;
					const results = [];
					let error = '';
					let csvType = 0;

					raw = fs.createReadStream('./assets/uploads/biometric/'+ filename);
					raw.on('error', function(){
						res.status(200).json({
							success: true,
							action: 'fetch',
							msg: 'Cant find '+ filename
						});
					});
					raw.pipe(csv({
						mapHeaders: ({ header, index }) => header.toLowerCase()
					}))
					.on('headers', (headers) => {
						let header = headers.map(function(v) {
						  return v.toLowerCase();
						});
						if(!(header.includes('userid') && header.includes('date_time') && header.includes('status'))){
							// error = 'File import failed. Please follow the given format and try again.';
						}
					})
					.on('data', (data) => results.push(data))
					.on('end', async() => {
						if(error != ''){
							//Delete uploaded csv
							fs.unlink('./assets/uploads/biometric/'+ filename, function (err) {
								if (err) throw err;
								console.log('File deleted!');
							}); 
							//Delete Record in DB
							BiometricCsvModel.destroy({
								where: {
									id: insertedId
								}
							});
							var errorData = [
								{	
									param: 'csv_format',
									msg: error
								}
							]
							res.status(422).json({
								success: false,
								errors: errorData
							});
						}else{
							if(results && results.length){
								let dateFormats = [
									'MM/DD/YYYY HH:mm',
									'MM/DD/YYYY H:mm',
									'MM/DD/YYYY H:m',
									'MM/DD/YYYY HH:m',
									'M/DD/YYYY H:m',
									'M/DD/YYYY HH:m',
									'M/DD/YYYY HH:mm',
									'M/DD/YYYY H:mm',
									'MM/D/YYYY H:m',
									'MM/D/YYYY HH:m',
									'MM/D/YYYY HH:mm',
									'MM/D/YYYY H:mm',
								];
								
								for (let i in results){
									if (!moment(results[i].date_time, dateFormats, true).isValid()){
										invalidDates.push(results[i].date_time);
									}
								}

								if (!invalidDates.length){
									results.map(result => asyncProcess(result, biometric.site));
								}
							}
							
							AttendanceHelper.proccess('csv');
							let message = invalidDates.length ? 'Unable to update Biometric logs. Please check date formats and try again.' : 'Biometric logs updated.';
							let action = invalidDates.length ? 'failed' : 'fetch';
							res.status(201).json({
								success: true,
								action: action,
								msg: message
							});
						}
						
					});
				});
			});
		}
	});
}

exports.fetch = function(req, res){
	BiometricCsvModel.findAll({
		order: [
			['date', 'DESC']
		],
		include: [
			{
				model: BiometricModel
			}
		]
	}).then(function(data){
		records = data;
		return BiometricModel.findAll({
			where: {
				status: 1
			},
			// order: [
			// 	['site', 'ASC']
			// ]
		});
	}).then(function(data){
		biometric = data;
		res.status(200).json({
			success: true,
			records: records,
			biometric: biometric
		})
	});
}

const findUser = function(array, biometric){
	let obj = array.find(o => o.biometric_number == biometric);
	return obj;
}

const updateLogin = function(time, id){
	let reqData = {
		actual_check_in: time
	}
	ShiftsModel.findOne({
		where: {
			id: id
		}
	}).then(function(data){
		if(!data.actual_check_in){
			ShiftsModel.update(reqData, {
				where: {
					id: id
				}
			});
		}
	});
	
}

const updateLogout = function(time, id){
	let reqData = {
		actual_check_out: time
	}
	ShiftsModel.update(reqData, {
		where: {
			id: id
		}
	});
}

const asyncProcess = function(row, ip_address){
	let userId = row.userid;
	let status = row.status;
	let date = moment(new Date(row.date_time)).format('YYYY-MM-DD HH:mm:ss');
	
	if(date != 'Invalid Date' && typeof userId !='undefined' && typeof status !='undefined' && typeof row.date_time !='undefined' && ip_address){
		BiometricLog.count({
			where:{
				ip_address: ip_address,
				userId: userId,
				date: date,
				status: status,
				source: 'csv'
			}
		}).then(count=>{
			if(count <= 0){
				BiometricLog.create({
					ip_address: ip_address,
					userId: userId,
					state: 1,
					date: date,
					status: status,
					source: 'csv'
				});
			}
		});	
	}
	
	// return true;
}

const findHeader = function(row, key){
	let result = false;
	for(let i in row){
		let column = row[i].toString();
		let k = key.toString();
		console.log(column===k);
		if(column == k){
			if(result == false){
				result = true;
			}
			
		}
	}
	return result;
}
