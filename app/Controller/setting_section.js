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
	Section,
	EmploymentsModel,
} = require('../../config/Sequelize');
const formidable = require('formidable');
const fs = require('fs');
const csv = require('csv-parser');
const ApproverHelper = require('../Helper/ApproverHelper');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-section');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Section/index',{
				user_role: user_role,
				route: 'section',
				usrRole: usrRole
			});
		}
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('department').notEmpty().withMessage('The department field is required.');
	req.checkBody('section_name').notEmpty().withMessage('The section name is required.');
	req.checkBody('section_code').notEmpty().withMessage('The section code field is required.');
	req.checkBody('supervisor').notEmpty().withMessage('The supervisor field is required.');
	req.checkBody('secretary').notEmpty().withMessage('The secretary field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{

		Section.count({
			where:{
				section_code: req.body.section_code
			}
		}).then(data=>{
			count = data;
			let reqData = {
				department_id: req.body.department,
				section_name: req.body.section_name,
				section_code: req.body.section_code,
				supervisor_id: req.body.supervisor,
				assistant_supervisor_id: req.body.assistant_supervisor,
				secretary_id: req.body.secretary,
				alternate_secretary: req.body.alternate_secretary,
				description: req.body.description,
				status: req.body.status,
			}
			if(count){
				var errors = [
					{	
						param: 'section_code',
						msg: 'The section code has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				Section.create(reqData).then(data=>{
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
	req.checkBody('department').notEmpty().withMessage('The department field is required.');
	req.checkBody('section_name').notEmpty().withMessage('The section name is required.');
	req.checkBody('section_code').notEmpty().withMessage('The section code field is required.');
	req.checkBody('supervisor').notEmpty().withMessage('The supervisor field is required.');
	req.checkBody('secretary').notEmpty().withMessage('The secretary field is required.');
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
			department_id: req.body.department,
			section_name: req.body.section_name,
			section_code: req.body.section_code,
			supervisor_id: req.body.supervisor,
			assistant_supervisor_id: req.body.assistant_supervisor,
			secretary_id: req.body.secretary,
			alternate_secretary: req.body.alternate_secretary,
			description: req.body.description,
			status: req.body.status,
		}
		Section.count({
			where:{
				id:{
					$ne: id
				},
				section_code: reqData.section_code
			}
		}).then(function(data){
			count = data;
			if(count){
				var errors = [
					{	
						param: 'section_code',
						msg: 'The section code has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				// Find all employees with approving org of this section
				EmploymentsModel.findAll({
					where: {
						section_id: id,
						approving_organization: "section"
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
							approver_id: req.body.supervisor,
							secondary_approver_id: req.body.assistant_supervisor,
							secretary_id: req.body.secretary,
							alternate_secretary: req.body.alternate_secretary,
						}

						// console.log(reqDataUser);
						// console.log(userFilter);
						// console.log(reqData);

						UsersModel.update(reqDataUser,{
							where:userFilter
						}).then(data=>{

							Section.update(reqData,{
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
    Section.findAndCountAll({
    	where: where,
    	limit: limit,
        offset: offset,
        include:[
        	{
        		model: Department,
        		as: 'department',
        		attributes: ['id','department_name','department_code']
        	},
        	{
        		model: UsersModel,
        		as: 'supervisor',
        		attributes: ['id','first_name','last_name']
        	},
        	{
        		model: UsersModel,
        		as: 'assistant_supervisor',
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
			}
        ],
    	order:[
    		['section_name','asc']
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
	Section.findAll({
		include:[
        	{
        		model: Department,
        		as: 'department',
        		attributes: ['id','department_name','department_code']
        	},
        	{
        		model: UsersModel,
        		as: 'supervisor',
        		attributes: ['id','first_name','last_name','employee_number']
        	},
        	{
        		model: UsersModel,
        		as: 'assistant_supervisor',
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
        	}
        ],
		order: [
			['section_name','asc']
		]
	}).then(data=>{
		record = data;
		let array = [];
		let fields = ['id','department_code', 'section_name', 'section_code', 'supervisor_id', 'assistant_supervisor_id', 'secretary_id','alternate_secretary_id','description'];
		if(record){
			for(let i in record){
				array.push({
					id: record[i].id,
					department_code: record[i].department ? record[i].department.department_code : '',
					section_name: record[i].section_name,
					section_code: record[i].section_code,
					supervisor_id: record[i].manager ? record[i].supervisor.employee_number : '',
					assistant_supervisor_id: record[i].assistant_supervisor ? record[i].assistant_supervisor.employee_number : '',
					secretary_id: record[i].secretary ? record[i].secretary.employee_number : '',
					alternate_secretary_id: record[i].alt_secretary ? record[i].alt_secretary.employee_number : '',
					description: record[i].description,
				});
			}
		}
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(array);
		res.attachment('sections.csv');
		res.status(200).send(csv);

	});
}

exports.import = function(req, res){
	let prefix = 'section_';
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
							  'department_code',
							  'section_name',
							  'section_code',
							  'supervisor_id',
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
										await saveSection(result[i], operation);
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

const saveSection = function(result, operation){
	return new Promise((resolve, reject) => {
		let department_code = result.department_code;
		let section_name = result.section_name;
		let section_code = result.section_code;
		let supervisor_id = result.supervisor_id;
		let assistant_supervisor_id = result.assistant_supervisor_id;
		let secretary_id = result.secretary_id;
		let alternate_secretary_id = result.alternate_secretary;
		let description = result.description;
		// console.log(result[i]);
		let supervisor = null;
		let assistant_supervisor = null;
		let secretary = null;
		let alternate_secretary = null;
		let department = null;
		if(department_code && section_name && section_code && supervisor_id){
			UsersModel.findOne({
				where:{
					employee_number: supervisor_id
				},
				attributes:['id'],
				raw: true
			}).then(data=>{
				supervisor = data;
				return UsersModel.findOne({
					where:{
						employee_number: assistant_supervisor_id
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				assistant_supervisor = data;
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
						employee_number: alternate_secretary_id
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				alternate_secretary = data;
				return Department.findOne({
					where:{
						department_code: department_code
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				department = data;
				if(supervisor && department){
					let ID = operation == 'create' ? '' : result.id;
					let reqData = {
						department_id: department.id,
						section_name: section_name,
						section_code: section_code,
						supervisor_id: supervisor ? supervisor.id : null,
						assistant_supervisor_id: assistant_supervisor ? assistant_supervisor.id : null,
						secretary_id: secretary ? secretary.id : null,
						alternate_secretary: alternate_secretary ? alternate_secretary.id : null,
						description: description,
						status: 1,
						deletedAt: null
					}
					let where = {
						section_code: reqData.section_code
					}
					if(ID){
						where.id = {
							$ne: ID
						}
					}
					Section.count({
						where: where
					}).then(data=>{
						count = data;
						if(!count){
							if(ID){
								Section.update(reqData,{
									where:{
										id: ID
									}
								});
							}else{
								Section.create(reqData);	
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
		return Department.findAll({
			where:{
				status: 1
			},
			order:[
				['department_name','asc']
			],
			attributes:['id','department_name']
		});
	}).then(data=>{
		departments = data;
		res.status(200).json({
			success: true,
            users,
            departments
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	Section.update({
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