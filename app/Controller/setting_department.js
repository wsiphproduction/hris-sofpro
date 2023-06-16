const UserRole = require('../Helper/UserRole');
const { Parser } = require('json2csv');
const _ = require('underscore');
const { 
	Op,
	ConfigModel,
	Division,
	UsersModel,
	sequelize,
	CompanyModel,
	Department,
	EmploymentsModel
} = require('../../config/Sequelize');
const formidable = require('formidable');
const fs = require('fs');
const csv = require('csv-parser');
const ApproverHelper = require('../Helper/ApproverHelper');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-department');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Department/index',{
				user_role: user_role,
				route: 'department',
				usrRole: usrRole
			});
		}
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('division').notEmpty().withMessage('The division field is required.');
	req.checkBody('department_name').notEmpty().withMessage('The type department name is required.');
	req.checkBody('department_code').notEmpty().withMessage('The department code field is required.');
	req.checkBody('manager').notEmpty().withMessage('The manager field is required.');
	req.checkBody('secretary').notEmpty().withMessage('The secretary field is required.');
	req.checkBody('hr_generalist').notEmpty().withMessage('The HR Generalist field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{

		Department.count({
			where:{
				department_code: req.body.department_code
			}
		}).then(data=>{
			count = data;
			let reqData = {
				division_id: req.body.division,
				department_name: req.body.department_name,
				department_code: req.body.department_code,
				manager_id: req.body.manager,
				assistant_manager_id: req.body.assistant_manager,
				secretary_id: req.body.secretary,
				alternate_secretary: req.body.alternate_secretary,
				hr_generalist_id: req.body.hr_generalist,
				description: req.body.description,
				status: req.body.status,
			}
			if(count){
				var errors = [
					{	
						param: 'department_code',
						msg: 'The department code has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				Department.create(reqData).then(data=>{
					res.status(201).json({
						success: true,
						action: 'fetch',
						msg: 'Record has been successfully saved.'
					});
				});
			}
		});
	}
}

exports.update = function(req, res){
	let user = res.locals.user;
	req.checkBody('division').notEmpty().withMessage('The division field is required.');
	req.checkBody('department_name').notEmpty().withMessage('The type department name is required.');
	req.checkBody('department_code').notEmpty().withMessage('The department code field is required.');
	req.checkBody('manager').notEmpty().withMessage('The manager field is required.');
	req.checkBody('secretary').notEmpty().withMessage('The secretary field is required.');
	req.checkBody('hr_generalist').notEmpty().withMessage('The HR Generalist field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let id = req.body.id;
		let reqData = {
			division_id: req.body.division,
			department_name: req.body.department_name,
			department_code: req.body.department_code,
			manager_id: req.body.manager,
			assistant_manager_id: req.body.assistant_manager,
			secretary_id: req.body.secretary,
			alternate_secretary: req.body.alternate_secretary,
			hr_generalist_id: req.body.hr_generalist,
			description: req.body.description,
			status: req.body.status,
		}
		Department.count({
			where:{
				id:{
					$ne: id
				},
				department_code: reqData.department_code
			}
		}).then(function(data){
			count = data;
			if(count){
				var errors = [
					{	
						param: 'department_code',
						msg: 'The department code has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{

				// Find all employees with approving org of this department
				EmploymentsModel.findAll({
					where: {
						department_id: id,
						approving_organization: "department"
					},
					raw: false,
				}).then(data=>{
					users = data;

					if(users && users.length){
						let userIDs = _.pluck(users, 'user_id');
						userIDs = [...new Set(userIDs)];

						let userFilter = {
							id: {
									[Op.in]: userIDs
								},
						}

            			let reqDataUser = {
							approver_id: req.body.manager,
							secondary_approver_id: req.body.assistant_manager,
							secretary_id: req.body.secretary,
							alternate_secretary: req.body.alternate_secretary,
							hr_generalist_id: req.body.hr_generalist,
						}

						UsersModel.update(reqDataUser,{
							where:userFilter
						}).then(data=>{

							Department.update(reqData,{
								where:{
									id:id
								}
							}).then(data=>{
								res.status(201).json({
									success: true,
									action: 'fetch',
									msg: 'Record has been successfully updated.'
								});
							});
						});
					}
				});
			}
		});
	}
}

exports.fetch = function(req, res){
	let status = req.body.status;
	let limit = req.body.limit ? parseInt(req.body.limit) : 25;
    let page = req.body.page ? req.body.page : 1;
    let offset   = (parseInt(page) - 1) * parseInt(limit);
    
    let where = {
    	deletedAt: null
    }
    if(status != ''){
    	where.status = status;
    }
    Department.findAndCountAll({
    	where: where,
    	limit: limit,
        offset: offset,
        include:[
        	{
        		model: Division,
        		as: 'division',
        		attributes: ['id','name','code']
        	},
        	{
        		model: UsersModel,
        		as: 'manager',
        		attributes: ['id','first_name','last_name']
        	},
        	{
        		model: UsersModel,
        		as: 'assistant_manager',
        		attributes: ['id','first_name','last_name']
        	},
        	{
        		model: UsersModel,
        		as: 'secretary',
        		attributes: ['id','first_name','last_name']
        	},
        	{
        		model: UsersModel,
        		as: 'alt_secretary',
        		attributes: ['id','first_name','last_name']
        	},
        	{
        		model: UsersModel,
        		as: 'hr_generalist',
        		attributes: ['id','first_name','last_name']
        	}
        ],
    	order:[
    		['department_name','asc']
    	],
    	raw: false,
    }).then(data=>{
    	divisions = data;
    	numrows = divisions.count;
        count = 0;
        if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
            count = 0;
        }
        res.status(200).json({
            success: true,
            count: count,
            records: divisions.rows,
            numrows: numrows,
        });
    });
}

exports.export = function(req, res){
	Department.findAll({
		include:[
        	{
        		model: Division,
        		as: 'division',
        		attributes: ['id','name','code']
        	},
        	{
        		model: UsersModel,
        		as: 'manager',
        		attributes: ['id','first_name','last_name','employee_number']
        	},
        	{
        		model: UsersModel,
        		as: 'assistant_manager',
        		attributes: ['id','first_name','last_name','employee_number']
        	},
        	{
        		model: UsersModel,
        		as: 'secretary',
        		attributes: ['id','first_name','last_name','employee_number']
        	},
        	{
        		model: UsersModel,
        		as: 'alt_secretary',
        		attributes: ['id','first_name','last_name','employee_number']
        	},
        	{
        		model: UsersModel,
        		as: 'hr_generalist',
        		attributes: ['id','first_name','last_name']
        	}
        ],
		order: [
			['department_name','asc']
		]
	}).then(data=>{
		record = data;
		let array = [];
		let fields = ['id','division_code', 'department_name', 'department_code', 'manager_id', 'assistant_manager_id', 'secretary_id','description'];
		if(record){
			for(let i in record){
				array.push({
					id: record[i].id,
					division_code: record[i].division ? record[i].division.code : '',
					department_name: record[i].department_name,
					department_code: record[i].department_code,
					manager_id: record[i].manager ? record[i].manager.employee_number : '',
					assistant_manager_id: record[i].assistant_manager ? record[i].assistant_manager.employee_number : '',
					secretary_id: record[i].secretary ? record[i].secretary.employee_number : '',
					alternate_secretary: record[i].alt_secretary ? record[i].alt_secretary.employee_number : '',
					hr_generalist_id: record[i].hr_generalist ? record[i].hr_generalist.employee_number : '',
					description: record[i].description,
				});
			}
		}
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(array);
		res.attachment('departments.csv');
		res.status(200).send(csv);

	});
}

exports.import = function(req, res){
	let prefix = 'department_';
	let uploadPath = './assets/uploads/imports/';
    let form = new formidable.IncomingForm();
    let result = [];
    form.parse(req, function (err, fields, files) {
    	// console.log(files);
    	req.body = fields;
    	let error = '';
		let attachment 	= files.csv;
		let size = '';
		let operation = req.body.operation;
		if(typeof attachment != 'undefined'){
			size = attachment.size;
		}
		req.body.file = size ? size: '';
		req.checkBody('file').notEmpty().withMessage('The attachment field is required.');
		req.checkBody('operation').notEmpty().withMessage('The operation field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			try{
				let filename = res.locals.moment().format('YYYYMMDDHHmmss');
				let path = attachment.path;
				let origFileName = attachment.name;
				filename = prefix+filename + '.csv';
				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){
		  						
						});
						raw = fs.createReadStream(uploadPath + filename);
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
							let arrayHeader = [
							  'division_code',
							  'department_name',
							  'department_code',
							  'manager_id',
							]
							if(operation == 'update'){
								arrayHeader.push('id');
							}
							let allFounded = arrayHeader.every( ai => header.includes(ai) );
							if(!allFounded){
								// error = 'File import failed. Please follow the given format and try again.';
							}
						})
						.on('data', (data) => result.push(data))
						.on('end', async() => {
							if(!error){
								if(result.length){
									for(let i in result){
										await processImport(result[i], operation);
									}
								}
								
								res.status(200).json({
									success: true,
									action: 'fetch',
									msg: 'New record has been successfully saved.'
								});
							}else{
								var errors = [
									{	
										param: 'file',
										msg: error
									}
								]
								res.status(422).json({
									success: false,
									errors
								});
							}
						});
					});
				});
			}catch(error){

			}
		}
    });
}

const processImport = function(result, operation){
	return new Promise((resolve, reject) => {
		let department_name = result['department_name'];
		let department_code = result['department_code'];
		let division_code = result['division_code'];
		let manager_id = result['manager_id'];
		let assistant_manager_id = result['assistant_manager_id'];
		let secretary_id = result['secretary_id'];
		let hr_generalist_id = result['hr_generalist'];
		let description = result['description'];
		let manager = null;
		let assistant_manager = null;
		let secretary = null;
		let division = null;
		if(department_name && department_code && division_code && manager_id){
			UsersModel.findOne({
				where:{
					employee_number: manager_id
				},
				attributes:['id','employee_number'],
				raw: true
			}).then(data=>{
				manager = data;
				return UsersModel.findOne({
					where:{
						employee_number: assistant_manager_id
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				assistant_manager = data;
				return UsersModel.findOne({
					where:{
						employee_number: secretary_id
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				secretary = data;
				return UsersModel.findOne({
					where:{
						employee_number: hr_generalist_id
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				hr_generalist = data;
				return Division.findOne({
					where:{
						code: division_code
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				division = data;
				if(manager && division_code){
					// console.log('sdf');
					let ID = operation == 'create' ? '' : result.id;
					let reqData = {
						division_id: division.id,
						department_name: department_name,
						department_code: department_code,
						manager_id: manager ? manager.id : null,
						assistant_manager_id: assistant_manager ? assistant_manager.id : null,
						secretary_id: secretary ? secretary.id : null,
						hr_generalist_id: hr_generalist ? hr_generalist.id : null,
						description: description,
						status: 1,
						deletedAt: null
					}
					let where = {
						department_code: reqData.department_code
					}
					if(ID){
						where.id = {
							$ne: ID
						}
					}
					Department.count({
						where: where
					}).then(data=>{
						count = data;
						if(!count){
							if(ID){
								Department.update(reqData,{
									where:{
										id: ID
									}
								});
							}else{
								Department.create(reqData);	
							}
						}
					});
					return resolve();
				}
			});

		}else{
			return resolve();
		}
	});
}

exports.init = function(req, res){
	UsersModel.findAll({
		where:{
			status: 1
		},
		order:[
			['first_name','asc']
		],
		attributes:['id','first_name','last_name']
	}).then(data=>{
		users = data;
		return Division.findAll({
			where:{
				status: 1
			},
			order:[
				['name','asc']
			],
			attributes:['id','name']
		});
	}).then(data=>{
		divisions = data;
		res.status(200).json({
			success: true,
            users,
            divisions
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	Department.update({
        deletedAt: res.locals.moment(req.body.birthdate).format('YYYY-MM-DD HH:mm:ss')
    },{
        where: {
            id: id
        }
    }).then(data => {
        res.status(201).json({
            success: true
        });
    })
}