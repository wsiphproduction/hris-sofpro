const UserRole = require('../Helper/UserRole');
const { 
	BranchesModel,
	CompanyModel,
	UsersModel, 
	CandidateProfileModel,
	TaxonomyModel,
	RequirementModel,
	EmploymentsModel,
	ApproversModel
} = require('../../config/Sequelize');

const shortid = require('shortid');
const GlobalHelper = require('../Helper/GlobalHelper');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'recruitment-joining').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/403');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Recruitment/Joining/index',{
					usrRole: usrRole,
					user_role: user_role,
					route: 'recruitment-joining'
				});
			});
		}
	});	
}

exports.fetch = function(req, res){
	CandidateProfileModel.findAll({
		where: {
			interview_status: 3
		}
	}).then(function(data){
		records = data;
		res.status(200).json({
            success: true,
            records: records,
        });
	});
}

exports.edit = function(req, res){
	let id = req.body.id;
	CandidateProfileModel.findOne({
		where: {
			id: id
		}
	}).then(function(data){
		candidate = data;
		return RequirementModel.count({
			where: {
				candidate_id: id
			}
		});
		
	}).then(function(data){
		numRows = data;
		if(numRows){
			return RequirementModel.findAll({
				where: {
					candidate_id: id
				}
			});
		}else{
			return TaxonomyModel.findAll({
				where: {
					parent_id: 26
				},
				attributes: ['title']
			});
		}
	}).then(function(data){
		requirements = data;
		res.status(200).json({
            success: true,
            candidate: candidate,
            requirements: requirements
        });
	});
}

exports.update = function(req, res){
	let id = req.body.id;
	let user_id  = req.session.user ? req.session.user.id : null;
	req.checkBody('position').notEmpty().withMessage('The position field is required.');
	req.checkBody('first_name').notEmpty().withMessage('The first name field is required.');
	req.checkBody('last_name').notEmpty().withMessage('The last name field is required.');
	req.checkBody('nationality').notEmpty().withMessage('The nationality field is required.');
	req.checkBody('marital_status').notEmpty().withMessage('The marital status field is required.');
	req.checkBody('gender').notEmpty().withMessage('The gender field is required.');
	req.checkBody('birthday').notEmpty().withMessage('The birthday field is required.');
	req.checkBody('phone_number').notEmpty().withMessage('The phone number field is required.');
	req.checkBody('current_address').notEmpty().withMessage('The current address field is required.');
	if(req.body.status == 5){
		req.checkBody('start_date').notEmpty().withMessage('The start date field is required.');
	}
	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		shortid.characters('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$-');
		let shortidStr = shortid.generate();
		let requirements = req.body.requirements;
		let birthday = res.locals.moment(new Date(req.body.birthday)).format('YYYY-MM-DD');
		let start_date = req.body.start_date ? res.locals.moment(new Date(req.body.start_date)).format('YYYY-MM-DD') : '';
		let reqBody = {
			position_applying_for: req.body.position,
			first_name: req.body.first_name,
			last_name: req.body.last_name,
			current_address: req.body.current_address,
			permanent_address: req.body.permanent_address,
			email: req.body.email,
			phone_number: req.body.phone_number,
			alternate_number: req.body.alternate_number,
			birthday: birthday,
			gender: req.body.gender,
			marital_status: req.body.marital_status,
			nationality: req.body.nationality,
			sss_number: req.body.sss_number,
			pagibig_number: req.body.pagibig_number,
			tin_number: req.body.tin_number,
			philhealth_number: req.body.philhealth_number,
			status: req.body.status,
			company: req.body.company,
			department: req.body.department,
			job_title: req.body.job_title,
			start_date: start_date,
		}
		if(req.body.status == 5){
			reqBody.shortid = shortidStr;
		}
		if(requirements){
			for(let x in requirements){
				let reqId = requirements[x]['id'];
				let requirementsBody = {
					candidate_id: id,
					title: requirements[x]['title'],
					status: requirements[x]['status'] == '' ? 1 : requirements[x]['status']
				}
				
				if(reqId){
					RequirementModel.update(requirementsBody, {
						where: {
							id: reqId
						}
					});
				}else{
					RequirementModel.create(requirementsBody);
				}
			}
		}
		
		CandidateProfileModel.update(reqBody, {
			where: {
				id: id
			}
		}).then(function(data){
			// If Completed, move to employee record
			if(req.body.status == 5){
				
				
				let company_branch_id = req.body.company;
				let department_id = req.body.department;
				let employeeBody = {
					shortid: shortidStr,
					first_name: req.body.first_name,
					middle_name: req.body.middle_name,
					last_name: req.body.last_name,
					gender: req.body.gender,
					birthdate: birthday,
					present_address: req.body.current_address,
					permanent_address: req.body.permanent_address,
					nationality: req.body.nationality,
					marital_status: req.body.marital_status,
					contact_number: req.body.phone_number,
					status: 1,
					created_by: user_id,
					sss_number: req.body.sss_number,
					pagibig_number: req.body.pagibig_number,
					tin_number: req.body.tin_number,
					philhealth_number: req.body.philhealth_number,
					company_branch_id: department_id,
					department_id: req.body.department,
					job_title_id: req.body.job_title,
					date_entry: start_date,
				}
				
				UsersModel.create(employeeBody).then(function(data){
					result = data;
					let insertId = result.id;
					
					BranchesModel.findOne({
						where: {
							id: company_branch_id
						},
						include: [ CompanyModel ]
					}).then(function(data){
						result = data;
						company = result.company;
						let code = company.code;
						let year = req.body.start_date ? res.locals.moment(new Date(req.body.start_date)).format('YYYY') : '';
						//console.log(year);
						let employee_number = GlobalHelper.generate_employee_number(code, year, insertId);
						//console.log(employee_number);
						let userData = {
							employee_number: employee_number
						}
						UsersModel.update(userData, {
							where: {
								id: insertId
							}
						});
					});
					
				});

				//Check Approvers and Create or Update if Any
				ApproversModel.findOne({
					where: {
						company_location_id: company_branch_id,
						department_id: department_id
					}
				}).then(function(data){
					record = data;
					if(!record){
						let approverData = {
							company_location_id: company_branch_id,
							department_id: department_id
						}
						ApproversModel.create(approverData);
					}
				});
				
			}
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Record has been updated.'
			});
		});

	}
}