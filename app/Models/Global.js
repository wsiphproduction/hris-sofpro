const conn = require('../../config/database');
const {
	Op,
	UsersModel,
} = require('../../config/Sequelize');
function Global(){

	this.count  = function(){
		let query = conn.sync.query('SELECT COUNT(*) as count FROM users');
		return query[0];
	}

	this.session = function(id){
		let query = conn.sync.query(`
				SELECT 
				id, 
				shortid, 
				first_name, 
				last_name,
				gender, 
				birthdate, 
				avatar,
				nationality,
				marital_status,
				email,
				username,
				status,
				user_role,
				company_branch_id,
				department_id
				FROM 
				users 
				WHERE id = `+ id);
		return query[0];
	}
	
	this._validate = async (params)=>{
		var split = params.split(":");
		let ModelName = split[0];
		let where = split[1].split(",");
		let not = split[2].split(",");
		let column = where[0];
		let value  = where[1];
		let isNot = "";
		// console.log(params);

		// console.log(ModelName);
		try{
			let where ={}
				where[column] = value;

			if(not[0] != 'null' && not[1] != 'null'){
				let notCol = not[0];
				    notCol = notCol.replace('!=','');
				    notCol = notCol.trim();
				let notVal = not[1];
				where[notCol] = {
					[Op.ne]: notVal
				}
			}
			const foundUser = await UsersModel.count({
				where:where
			});
			return foundUser > 0 ? true:false;
		}catch(error){
			return false;
		}
	}

	this.branding = function() {
		return null;
		// let result = conn.sync.query("SELECT * FROM branding");
		// return result.length ? result[0] : null;
	}
	
	// this._update = function(table, data, column, id){
	// 	return new Promise(function(resolve, reject){
	// 		conn.pool.query('UPDATE '+ table +' SET ? WHERE '+column+'=?', [data, id], function(err, result){
	// 			if(err) {
	// 				console.log(err);
	// 			}
	// 			return resolve(JSON.parse(JSON.stringify(result)));
	// 		});
	// 	});
	// }

}

module.exports = new Global();