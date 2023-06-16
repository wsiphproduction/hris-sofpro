const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	sequelize,
	UsersModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	LeaveDateModel
} = require('../../config/Sequelize');

function LeaveSet(){
	this.test = function(){
		//console.log('LeaveReset');
	}

	this.reset = function(){
		// console.log('sdfsdf');
		LeavePolicyModel.findAll({
			where: {
				status: 1
			},
			raw: true
		}).then(function(data){
			policy = data;
			if(policy.length){
				for(let i in policy){
					newPolicy(policy[i]);
				}
			}
		});
		/*
		LeavePolicyModel.findAll({
			where: {
				status: 1
			},
			raw: true
		}).then(function(data){
			policy = data;
			if(policy.length){
				for(let i in policy){
					let cycle = policy[i].cycle;
					let id = policy[i].id;
					//Every Year
					if(cycle == 12){
						let month0 = moment().format('YYYY-MM-DD');
						let dates = {
							month0: month0
						}
						everyYear(policy[i], dates);
					}else if(cycle == 6){ //Every 6 Months
						let now = moment();
						let month0 = moment().format('YYYY-MM-DD');
						let month1 = now.subtract(6, 'months').format('YYYY-MM-DD');
						let dates = {
							month0: month0,
							month1: month1
						}
						everySixMonth(policy[i], dates);
					}else if(cycle == 4){ //Every 4 Months
						let now = moment();
						let month0 = moment().format('YYYY-MM-DD');
						let month1 = now.subtract(4, 'months').format('YYYY-MM-DD');
						let month2 = now.subtract(4, 'months').format('YYYY-MM-DD');
						let dates = {
							month0: month0,
							month1: month1,
							month2: month2
						}
						everyFourMonth(policy[i], dates);
					}else if(cycle == 3){ //Every 3 Months
						let now = moment();
						let month0 = moment().format('YYYY-MM-DD');
						let month1 = now.subtract(3, 'months').format('YYYY-MM-DD');
						let month2 = now.subtract(3, 'months').format('YYYY-MM-DD');
						let month3 = now.subtract(3, 'months').format('YYYY-MM-DD');
						let dates = {
							month0: month0,
							month1: month1,
							month2: month2,
							month3: month3
						}
						everyThreeMonth(policy[i], dates);
					}
				}
			}
		});*/
	}
	
}

const newPolicy = function(policy){
	let now = moment();
	let policy_id = policy.id;
	let carry_over = policy.carry_over;
	let policy_name = policy.name;
	    policy_name = policy_name.toLowerCase();
	let where = {
		resignation_date: null
	}
	if(policy.gender == 'Female'){
		where.gender = 'Female';
	}else if(policy.gender == 'Male'){
		where.gender = 'Male';
	}

	if(policy.company){
		where.company_branch_id = policy.company;
	}
	if(policy.department){
		where.department_id = policy.department;
	}
	// where.$and = [
	// 	sequelize.where(sequelize.fn('MONTH', sequelize.col("date_entry")), month),
	// 	sequelize.where(sequelize.fn('DAY', sequelize.col("date_entry")), day),
	// ]

	//console.log(where);
	UsersModel.findAll({
		where: where,
		raw: true,
		attributes: ['id','first_name','last_name','gender','company_branch_id','department_id','date_entry']
	}).then(function(data){
		users = data;
		if(users.length){
			for(let x in users){
				let user_id = users[x].id;
				let start_date = users[x].date_entry;
				let year = 0;
				if(start_date){
					year = moment().diff(start_date, 'years',true);
				}
				if(year > 0){
					LeaveCreditPolicyModel.findOne({
						where: {
							user_id: user_id,
							policy_id: policy_id 
						},
						raw: true
					}).then(function(data){
						result = data;

						if(result){
							let prevBalance = result.balance;

							let balance = policy.total_per_year;
							if(carry_over == 1){
								balance = parseInt(balance) + parseInt(prevBalance);
							}
							let resetData = {
								utilized: 0
							}

							if(policy_name == 'paternity leave' || policy_name == 'maternity leave'){
								resetData.balance = 0;
							}else{
								resetData.balance = balance;
							}

							LeaveCreditPolicyModel.update(resetData, {
								where: {
									id: result.id
								}
							});
						}else{
							let resetData = {
								utilized: 0,
								user_id: user_id,
								policy_id: policy_id
							}
							if(policy_name == 'paternity leave' || policy_name == 'maternity leave'){
								resetData.balance = 0;
							}else{
								resetData.balance = policy.total_per_year;
							}
							LeaveCreditPolicyModel.create(resetData);
						}
					});
				}
			}
		}
	});
}

const everyYear = function(policy, date){
	let policy_id = policy.id;
	let month = moment(date.month0).format('MM');
	let day = moment(date.month0).format('DD');

	let where = {}
	if(policy.gender == 'Female'){
		where.gender = 'Female';
	}else if(policy.gender == 'Male'){
		where.gender = 'Male';
	}

	if(policy.company){
		where.company_branch_id = policy.company;
	}
	if(policy.department){
		where.department_id = policy.department;
	}
	where.$and = [
		sequelize.where(sequelize.fn('MONTH', sequelize.col("date_entry")), month),
		sequelize.where(sequelize.fn('DAY', sequelize.col("date_entry")), day),
	]
	//console.log(where);
	UsersModel.findAll({
		where: where,
		raw: true,
		attributes: ['id','first_name','last_name','gender','company_branch_id','department_id']
	}).then(function(data){
		users = data;
		if(users.length){
			for(let x in users){
				let user_id = users[x].id;
				LeaveCreditPolicyModel.findOne({
					where: {
						user_id: user_id,
						policy_id: policy_id 
					},
					raw: true
				}).then(function(data){
					result = data;
					
					let resetData = {
						balance: policy.total_per_year,
						utilized: 0
					}

					//Update
					if(result){
						LeaveCreditPolicyModel.update(resetData, {
							where: {
								id: result.id
							}
						});
					}else{//Create
						resetData.user_id = user_id;
						resetData.policy_id = policy_id;
						LeaveCreditPolicyModel.create(resetData);
					}
					//Success
				});
			}
		}
	});
}

const everySixMonth = function(policy, date){
	let policy_id = policy.id;
	let perYear   = policy.total_per_year;
	let date0 = moment(date.month0).format('MM-DD');
	let date1 = moment(date.month1).format('MM-DD');
	let where = {}
	if(policy.gender == 'Female'){
		where.gender = 'Female';
	}else if(policy.gender == 'Male'){
		where.gender = 'Male';
	}

	if(policy.company){
		where.company_branch_id = policy.company;
	}
	if(policy.department){
		where.department_id = policy.department;
	}
	where.$or = [
		sequelize.where(sequelize.fn('DATE_FORMAT', sequelize.col('date_entry'),  '%m-%d'), date0),
		sequelize.where(sequelize.fn('DATE_FORMAT', sequelize.col('date_entry'),  '%m-%d'), date1),
	]

	UsersModel.findAll({
		where: where,
		raw: true,
		attributes: ['id','first_name','last_name','gender','company_branch_id','department_id','date_entry']
	}).then(function(data){
		users = data;
		if(users.length){
			for(let x in users){
				let user_id = users[x].id;
				let entryDate = moment(users[x].date_entry).format('MM-DD');
				LeaveCreditPolicyModel.findOne({
					where: {
						user_id: user_id,
						policy_id: policy_id 
					},
					raw: true
				}).then(function(data){
					result = data;
					if(result){
						let balance = result.balance;
						let utilized = date0 == entryDate ? 0 : result.utilized;
						//console.log(balance);
						let total = date0 == entryDate ? perYear : balance + (perYear / 2);
						let resetData = {
							balance: total,
							utilized: utilized
						}
						LeaveCreditPolicyModel.update(resetData, {
							where: {
								id: result.id
							}
						});
					}else{
						let balance = 0;
						let total = date0 == entryDate ? perYear : balance + (perYear / 2);
						let utilized = date0 == entryDate ? 0 : 0;
						let resetData = {
							user_id: user_id,
							policy_id: policy_id,
							balance: total,
							utilized: utilized
						}
						LeaveCreditPolicyModel.create(resetData);
					}
					//Success
				});
			}
		}
	});
	
}

module.exports = new LeaveSet();