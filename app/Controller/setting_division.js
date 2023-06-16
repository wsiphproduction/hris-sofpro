const UserRole = require('../Helper/UserRole');
var { Parser } = require('json2csv');
const _ = require('underscore');
const { 
	Op,
	ConfigModel,
	Division,
	UsersModel,
	sequelize,
	CompanyModel,
	EmploymentsModel,
} = require('../../config/Sequelize');
const formidable = require('formidable');
const fs = require('fs');
const csv = require('csv-parser');
const ApproverHelper = require('../Helper/ApproverHelper');
const DivisionModel = require('../Models/DivisionModel');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-division');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/Division/index',{
				user_role: user_role,
				route: 'division',
				usrRole: usrRole
			});
		}
	});
}

exports.store = function(req, res){
	let user = res.locals.user;
	req.checkBody('company').notEmpty().withMessage('The company field is required.');
	req.checkBody('division_name').notEmpty().withMessage('The type division name is required.');
	req.checkBody('division_code').notEmpty().withMessage('The division code field is required.');
	req.checkBody('manager').notEmpty().withMessage('The manager field is required.');
	req.checkBody('secretary').notEmpty().withMessage('The secretary field is required.');
	req.checkBody('status').notEmpty().withMessage('The status field is required.');
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		Division.count({
			where:{
				code: req.body.division_code
			}
		}).then(data=>{
			count = data;
			let reqData = {
				company_id: req.body.company,
				name: req.body.division_name,
				code: req.body.division_code,
				manager_id: req.body.manager,
				assistant_manager_id: req.body.assistant_manager,
				secretary_id: req.body.secretary,
				secretary_id: req.body.secretary,
				alternate_secretary: req.body.alternate_secretary,
				description: req.body.description,
				status: req.body.status,
			}
			if(count){
				var errors = [
					{	
						param: 'division_code',
						msg: 'The division code has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				Division.create(reqData).then(data=>{
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
	req.checkBody('company').notEmpty().withMessage('The company field is required.');
	req.checkBody('division_name').notEmpty().withMessage('The type division name is required.');
	req.checkBody('division_code').notEmpty().withMessage('The division code field is required.');
	req.checkBody('manager').notEmpty().withMessage('The manager field is required.');
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
			company_id: req.body.company,
			name: req.body.division_name,
			code: req.body.division_code,
			manager_id: req.body.manager,
			assistant_manager_id: req.body.assistant_manager,
			secretary_id: req.body.secretary,
			alternate_secretary: req.body.alternate_secretary,
			description: req.body.description,
			status: req.body.status,
		}
		Division.count({
			where:{
				id:{
					$ne: id
				},
				code: reqData.code
			}
		}).then(function(data){
			count = data;
			if(count){
				var errors = [
					{	
						param: 'division_code',
						msg: 'The division code has already been taken.'
					}
				]
				res.status(422).json({
					success: false,
					errors
				});
			}else{
				// Find all employees with approving org of this division
				EmploymentsModel.findAll({
					where: {
						division_id: id,
						approving_organization: "division"
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
						}

						// console.log(reqDataUser);
						// console.log(userFilter);
						// console.log(reqData);

						UsersModel.update(reqDataUser,{
							where:userFilter
						}).then(data=>{

							Division.update(reqData,{
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
    Division.findAndCountAll({
    	where: where,
    	limit: limit,
        offset: offset,
        include:[
        	{
        		model: CompanyModel,
        		as: 'company',
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
        	}
       ],
    	order:[
    		['name','asc']
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
	Division.findAll({
		include:[
        	{
        		model: CompanyModel,
        		as: 'company',
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
        	}
        ],
		order: [
			['name','asc']
		]
	}).then(data=>{
		divisions = data;
		let array = [];
		let fields = ['id','division_name', 'division_code', 'company_code', 'manager_id', 'assistant_manager_id', 'secretary_id','description'];
		if(divisions){
			for(let i in divisions){
				array.push({
					id: divisions[i].id,
					division_name: divisions[i].name,
					division_code: divisions[i].code,
					company_code: divisions[i].company ? divisions[i].company.code : '',
					manager_id: divisions[i].manager ? divisions[i].manager.employee_number : '',
					assistant_manager_id: divisions[i].assistant_manager ? divisions[i].assistant_manager.employee_number : '',
					secretary_id: divisions[i].secretary ? divisions[i].secretary.employee_number : '',
					alternate_secretary: divisions[i].alt_secretary ? divisions[i].alt_secretary.employee_number : '',
					description: divisions[i].description,
				});
			}
		}
		const json2csvParser = new Parser({ fields });
		const csv = json2csvParser.parse(array);
		res.attachment('divisions.csv');
		res.status(200).send(csv);

	});
}

exports.import = function(req, res){
	let prefix = 'division_';
	let uploadPath = './assets/uploads/imports/';
    let form = new formidable.IncomingForm();
    let result = [];
    form.parse(req, function (err, fields, files) {
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
								'﻿division_name',
								'division_code',
								'company_code',
								'manager_id',
							]

							if(operation == 'update'){
								arrayHeader.push('id');
							}
							let allFounded = arrayHeader.every( ai => headers.includes(ai) );
							if(!allFounded){
								// error = 'File import failed. Please follow the given format and try again.';
							}
						})
						.on('data', (data) => result.push(data))
						.on('end', async() => {
							if(!error){
								if(result.length){
									for(let i in result){
										await createUpdateDivision(result[i],operation);
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

const createUpdateDivision = function(result, operation){
	return new Promise((resolve, reject) => {
	    let division_name = result.division_name;
		let division_code = result.division_code;
		let company_code = result.company_code;
		let manager_id = result.manager_id;
		let assistant_manager_id = result.assistant_manager_id;
		let secretary_id = result.secretary_id;
		let alternate_secretary_id = result.alternate_secretary;
		let description = result.description;
		let manager = null;
		let assistant_manager = null;
		let secretary = null;
		let alt_secretary = null;
		let company = null;
		if(﻿division_name !='' && division_code !='' && company_code !='' && manager_id !=''){
			UsersModel.findOne({
				where:{
					employee_number: manager_id
				},
				attributes:['id'],
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
						employee_number: alternate_secretary_id
					},
					attributes:['id'],
					raw: true
				});
			}).then(data=>{
				alt_secretary = data;
				return CompanyModel.findOne({
					where:{
						code: company_code
					},
					attributes:['id'],
					raw: true
				});
			}).then(async(data)=>{
				company = data;
				if(manager && company){
					let ID = operation == 'create' ? '' : result.id;
					let reqData = {
						company_id: company.id,
						name: division_name,
						code: division_code,
						manager_id: manager ? manager.id : null,
						assistant_manager_id: assistant_manager ? assistant_manager.id : null,
						secretary_id: secretary ? secretary.id : null,
						alternate_secretary: alt_secretary ? alt_secretary.id : null,
						description: description,
						status: 1,
						deletedAt: null
					}
					let where = {
						code: reqData.code
					}
					if(ID){
						where.id = {
							$ne: ID
						}
					}

					Division.count({
						where: where
					}).then(data=>{
						count = data;
						if(!count){
							if(ID){
								Division.update(reqData,{
									where:{
										id: ID
									}
								});
							}else{
								Division.create(reqData);	
							}
						}
					});
					return resolve();
				}
			});
		}else{
			return resolve();
		}
	})
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
		return CompanyModel.findAll({
			where:{
				status: 1
			},
			order:[
				['name','asc']
			],
			attributes:['id','name']
		});
	}).then(data=>{
		companies = data;
		res.status(200).json({
			success: true,
            users,
            companies
		});
	});
}

exports.archive = function(req, res){
	let id = req.body.id;
	Division.update({
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