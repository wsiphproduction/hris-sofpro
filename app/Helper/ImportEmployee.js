const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const GlobalHelper   = require('./GlobalHelper');

const {
	UsersModel,
	BranchesModel,
	TaxonomyModel,
	ApproversModel,
	CompanyModel
} = require('../../config/Sequelize');

function ImportEmployee(){

	this.createDepartment = function(department){
		if(department){
			for(let x in department){
				let title = department[x].title;

				TaxonomyModel.findOrCreate({
					where: {
						parent_id: 1,
						title: title
					}, defaults: {
						parent_id: 1,
						title: title,
						status: 1
					}
				});
			}
		}
	}

	this.createDesignation = function(designation){
		if(designation){
			for(let x in designation){
				let title = designation[x].title;

				TaxonomyModel.findOrCreate({
					where: {
						parent_id: 2,
						title: title
					}, defaults: {
						parent_id: 2,
						title: title,
						status: 1
					}
				});
			}
		}
	}

	this.createEmployee = function(users, operation){
		if(users){
			for(let i in users){
				createUser(users[i], operation);
			}
		}
	}

	

}


const createUser = function(user, operation){

	let uID = user.id;
	let department = user.department;
	let designation = user.designation;

	let userData = user;
	delete userData.id;
	delete userData.department;
	delete userData.designation;
	//console.log(userData);
	if(typeof department != 'undefined'){
		TaxonomyModel.findOne({
			where: {
				parent_id: 1,
				title: department
			},
			raw: true
		}).then(function(data){
			//console.log(data);
			department_id = data ? data.id : '';
			userData.department_id = department_id;
			return TaxonomyModel.findOne({
				where: {
					parent_id: 2,
					title: designation
				},
				raw: true
			});	
		}).then(function(data){
			designation_id = data ? data.id : '';
			userData.job_title_id = designation_id;
			if(operation == 'insert'){
				UsersModel.create(userData).then(function(data){
					let user_id = data.id;
					UsersModel.findOne({
						where: {
							id: user_id
						},
						raw: true
					}).then(function(data){
						user = data;
						//Set Employee Number
						BranchesModel.findOne({
							where: {
								id: user.company_branch_id
							},
							include: [
								{
									model: CompanyModel
								}
							]
						}).then(function(data){
							branch = data;
							let code = branch ? branch.company.code : '';
							let year = user.date_entry ? moment(new Date(user.date_entry)).format('YYYY') : '';
							let employee_number = GlobalHelper.generate_employee_number(code, year, user_id);
							let user_data = {
								employee_number: employee_number
							}
							UsersModel.update(user_data, {
								where: {
									id: user_id
								}
							});
						});
						
					});
				});
			}else if(operation == 'update' && uID != ''){
				UsersModel.update(userData, {
					where: {
						id: uID
					}
				}).then(function(data){
					user_id = uID;
					UsersModel.findOne({
						where: {
							id: user_id
						},
						raw: true
					});
				});
			}
		});
	}
}

module.exports = new ImportEmployee();