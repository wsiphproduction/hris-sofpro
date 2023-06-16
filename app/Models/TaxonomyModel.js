const conn = require('../../config/database');

function TaxonomyModel(){

	this.getAll = function(){
		return new Promise(function(resolve, reject){
			conn.pool.query(`SELECT * FROM taxonomy ORDER BY title ASC`, function(err, result){
				if(err) {
					console.log(err);
				}
				return resolve(JSON.parse(JSON.stringify(result)));
			});
		});
	}

	this._count = function(parent_id){
		return new Promise(function(resolve, reject){
			conn.pool.query(`SELECT COUNT(*) as COUNT FROM taxonomy WHERE parent_id = ?`, [parent_id], function(err, result){
				if(err) {
					console.log(err);
				}
				let res = JSON.parse(JSON.stringify(result))[0];
				return resolve(res);
			});
		});
	}

	this._get = function(parent = 0, spacing = ''){
			
		let array = null;

		let query = conn.sync.query(`SELECT * FROM taxonomy WHERE parent_id = '+ parent +' ORDER BY title ASC`);

		if(query.length){
			
			array = [];

			for(let key in query){

				let parent_id = query[key]['id'];

				array.push({
					id: parent_id,
					title: spacing + query[key]['title'],
					code: query[key]['code'],
					status: query[key]['status']
				});

				let loop = this._get(parent_id, '&nbsp; &nbsp; → ');

				for(let x in loop){
					array.push({
						id: loop[x]['id'],
						title: loop[x]['title'],
						code: loop[x]['code'],
						status: loop[x]['status']
					});
				}
				
			}
		}
		
		return array;
	}

}

module.exports = new TaxonomyModel();