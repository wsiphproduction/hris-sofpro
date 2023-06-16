const UserRole = require('../Helper/UserRole');
const _ = require('underscore');
const { convertCSVToArray } = require('convert-csv-to-array');
const csv = require('csv-parser')
const fs = require('fs');
const formidable = require('formidable');
const Excel = require('exceljs');
const GlobalHelper = require('../Helper/GlobalHelper');
const { 
	Op,
	UsersModel,
	LeavesModel,
	LeavePolicyModel,
	BranchesModel,
	CompanyModel,
	TaxonomyModel,
	LeaveCreditPolicyModel,
	EmploymentsModel
} = require('../../config/Sequelize');
const LeaveCreditPolicy = require('../Models/LeaveCreditPolicy');

exports.index = function(req, res){
	let user = res.locals.user;

	UserRole.get_role(user, 'employee-leave-credit').then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			BranchesModel.findAll({
				where: {
					status: 1
				},
				include: [ CompanyModel ]
			}).then(function(data){
				company = data;
				return TaxonomyModel.findAll({
					where: {
						parent_id: 1,
						status: 1
					},
					order: [
						['title', 'ASC']
					]
				});
			}).then(function(data){
				department = data;
				return TaxonomyModel.findAll({
					where: {
						parent_id: 2,
						status: 1
					},
					order: [
						['title', 'ASC']
					]
				});
			}).then(function(data){
				jobs = data;
				return UserRole.allRead(user);
				
			}).then(function(data){
				usrRole = data;
				return UsersModel.findAll({
					where: {
						status: 1
					},
					order: [
						['first_name', 'ASC']
					],
					attributes: ['id','first_name','last_name']
				});
				
			}).then(function(data){
				users = data;
				res.render('Employee/LeaveCredit/index',{
					company: company,
					department: department,
					jobs: jobs,
					user_role: user_role,
					usrRole: usrRole,
					users: users,
					route: 'employee-leave-credit'
				});
			});
		}
	});
}

exports.fetch = function(req, res){
	let company = req.body.company;
	let department = req.body.department;
	let section = req.body.section;
	let division = req.body.division;
	let userId = req.body.user;
	let limit = parseInt(req.body.limit);
	let page = req.body.page;
	let offset   = (parseInt(page) - 1) * parseInt(limit);

	let where  = {}
	if(company){
		where.company_id = company;
	}
	if(division){
		where.division_id = division;
	}
	if(department){
		where.department_id = department;
	}
	if(section){
		where.section_id = section;
	}
	let whereUser = {}
	EmploymentsModel.findAll({
		where: where,
		attributes: ['id','user_id'],
		raw: true
	}).then(data=>{
		employment = data;

		let user_id = [];
		if(employment && employment.length){
			for(let i in employment){
				user_id.push(employment[i].user_id);
			}
		}
		user_id = [...new Set(user_id)];
		
		if(!_.isEmpty(where)){
			whereUser.id = {
				[Op.in]: user_id
			}
		}
		let records = [];
		let policy = [];
		UsersModel.findAndCountAll({
			where: whereUser,
			limit: limit,
            offset: offset,
            order: [
            	['last_name','asc']
            ],
            include: [
	    		{
	    			model: LeaveCreditPolicyModel,
	    			attributes: ['balance','id','policy_id','user_id','utilized']
	    		}
	    	],
        }).then(data=>{
        	records = data;
        	return LeavePolicyModel.findAll({
				where: {
					status: 1
				},
				order: [
					['name','asc']
				],
			});
        }).then(data=>{
        	policy = data;
        	let numrows = records.count;
	        let count = 0;
	        if(limit < numrows){
	            count = numrows / limit;
	            count = Math.ceil(count);
	        }else{
	            count = 0;
	        }
	        res.status(200).json({
				success: true,
	            records: records.rows,
	            count: count,
	            policy: policy
			});
        });
		
	});

}

exports.edit = function(req, res){
	let user_id = req.body.user_id;
	UsersModel.findOne({
		where: {
			id: user_id
		},
		attributes: ['id', 'gender','first_name','last_name','company_branch_id','department_id','job_title_id']
	}).then(function(data){
		user = data;
		let gender = user.gender;
		let company_id = user.company_branch_id ? user.company_branch_id : '';
		let department = user.department_id ? user.department_id : '';
		
		return LeavePolicyModel.findAll({
			where: {
				status: 1,
				gender: {
					$or: [null, '', gender]
				},
				company: {
					$or: [null, '', company_id]
				},
				department: {
					$or: [null, '', department]
				}
			},
			attributes: ['id','name'],
			include: [
				{
					model: LeaveCreditPolicyModel,
					where: {
						user_id: user_id
					},
					required: false,
					attributes: ['id','user_id','policy_id','balance', 'utilized']
				}
			]
		});
	}).then(function(data){
		policy = data;
		res.status(200).json({
			success: true,
			policy: policy
		});
	});
}

exports.update = function(req, res){
	let credit = req.body.credit;
	if(credit){
		for(let key in credit){
			let id = credit[key]['id'];
			let reqData = {
				balance: credit[key]['balance'],
				utilized: credit[key]['utilized']
			}
			if(id){
				LeaveCreditPolicyModel.update(reqData, {
					where: {
						id: id
					}
				});
			}else{
				reqData.user_id = credit[key]['user_id'];
				reqData.policy_id = credit[key]['policy_id'];
				LeaveCreditPolicyModel.create(reqData);
			}
		}
	}
	res.status(201).json({
		success: true,
		action: 'fetch',
		msg: 'Leave credit has been successfully updated.'
	});
	//console.log(req.body)
}

exports.import = async(req, res)=>{
	let uploadPath = './assets/uploads/leave_credit/';
	let form = new formidable.IncomingForm();
	
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let attachment 	= files.csv;
		let size = typeof attachment != 'undefined' ?  attachment.size : 0;
		req.body.csv = size ? size: '';
		req.checkBody('csv').notEmpty().withMessage('The csv field is required.');
		let errors = req.validationErrors();
		
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			let date = res.locals.moment().format('YYYY-MM-DD');
			let filename = 'LEAVE-CREDIT-'+res.locals.moment().format('YYMMDDHHmmss')+'.csv';
			if(attachment && attachment.size > 0){
				const results = [];
				let error = '';
				let path = attachment.path;
				let origFileName = attachment.name;
				let ext = origFileName.split(".");
					ext = ext.pop()
				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err){
							res.status(200).json({
								success: true,
								action: 'fetch',
								msg: 'Cant find '+ filename
							});
						}else{
							raw = fs.createReadStream('./assets/uploads/leave_credit/'+ filename);
							raw.on('error', function(error){
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
								if(!(header.includes('employee_number') 
									&& header.includes('policy_code')
									&& header.includes('balance')
									&& header.includes('utilized')
									)) {
									error = 'File import failed. Please follow the given format and try again.';
								}
							})
							.on('data', (data) => results.push(data))
							.on('end', async() => {
								if(error != ''){
									fs.unlink(uploadPath + filename, function (err) {
										if (err) throw err;
										console.log('File deleted!');
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
										let employee_number_list = results.map(({ employee_number }) => employee_number);
										let employee_not_existing_list = await getEmployeeNotExistingList(employee_number_list);
										
										if(employee_not_existing_list.length < 1) {
											for(let i in results){
												let employee_number = results[i].employee_number.trim();
												let policy_code = results[i].policy_code.trim();
												let balance =  results[i].balance.trim();
												let utilized =  results[i].utilized.trim();

												await proccessLeaveCredit(employee_number, policy_code, balance, utilized);
											}
											res.status(201).json({
												success: true,
												action: 'fetch',
												msg: 'Leave Credit files has been uploaded.'
											});
										} else {
											fs.unlink(uploadPath + filename, function (err) {
												if (err) throw err;
												console.log('File deleted!');
											});
											message = 'Failed to update Leave Credits. Employee Number/s doesn\'t exist  [ '
											for(let ctr in employee_not_existing_list){
												message = message + employee_not_existing_list[ctr] + ","
											}
											message = message.slice(0, -1);
											message = message + " ]."

											var errorData = [
												{	
													param: 'csv_format',
													msg: message
												}
											]
											res.status(422).json({
												success: false,
												errors: errorData
											});
										}
									}
								}
							});
						}
					});
				});				
			}else{
				res.status(422).json({
					success: false,
		            errors: [
		            	{
		            		location: "body",
							msg: "Unknown error, please try again or contact administratot.",
							param: "csv"
		            	}
		            ]
				});
			}
		}
	});

	const getEmployeeNotExistingList =  async (employee_number_list)=>{
		let results;
		await UsersModel.findAll({
			where: {
				employee_number: {
					$in: employee_number_list
				}
			},
			raw: false,
		}).then(data=>{
			let employee = data;
			if(employee) {
				let employee_existing_list_existing = employee.map(({ employee_number }) => employee_number);
				results = employee_number_list.filter( ( el ) => !employee_existing_list_existing.includes( el ) );
				results = results.filter((v, i, a) => a.indexOf(v) === i);
			}
		});

		return results
	}
	const proccessLeaveCredit =  async (employee_number, policy_code, balance, utilized)=>{

		await UsersModel.findOne({
			where: {
				employee_number: employee_number
			},
			attributes: ['id','first_name','last_name'],
			raw: false,
		}).then(data=>{
			let employee = data;
			let user_id = employee.id;
			return LeavePolicyModel.findOne({
				where: {
					code: policy_code.toUpperCase()
				},
				attributes: ['id'],
				raw: false,
			}).then(function(data){
				policy_id = data.id;
				
				return LeaveCreditPolicyModel.findOne({
					where: {
						user_id: user_id,
						policy_id: policy_id
					},
					attributes: ['id', 'balance', 'utilized'],
					raw: false,
				}).then(function(data){
					leave_records = data
					let reqData = {
						balance: balance,
						utilized: utilized
					}

					if(leave_records){
						let id = leave_records.id;
						LeaveCreditPolicyModel.update(reqData, {
							where: {
								id: id
							}
						});
					}else{
						reqData.user_id = user_id;
						reqData.policy_id = policy_id;
						LeaveCreditPolicyModel.create(reqData);
					}
				});
			});
		});
	}
}