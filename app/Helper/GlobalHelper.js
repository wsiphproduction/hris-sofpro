const $env 	= require('dotenv').config();
const moment= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const conn  = require('../../config/database');

const {
	sequelize,
	ConfigModel
} = require('../../config/Sequelize');

function GlobalHelper(){

	this.generate_employee_number = function(code, year, number){
		let length = 7;
		let my_string = '' + number;
		while (my_string.length < length) {
	        my_string = '0' + my_string;
	    }
	    return code + year + my_string;
	}

	this.cutoff = async ()=>{
		let transaction; 
		try{
			let cutoffDate = '';
			let day = moment().format('D');
			transaction = await sequelize.transaction();
			let result = await ConfigModel.findOne({ where: {
				id: 1
			}, transaction });
			if(result){
				let json = result.json;
				json = json ? JSON.parse(json) : '';
				if(json && json.cutoff){
					let cutoff = json.cutoff;
					let from = parseInt(cutoff.B_from);
					let to   = parseInt(cutoff.B_to);
					if(parseInt(day) >= from && parseInt(day) <= to){
						let m = moment().format('M');
						let d = from;
						let y = moment().format('YYYY');
						let date = m +'-'+ d+'-'+ y;
							date = new Date(date);
							date = moment(date).subtract(2,'days').format('YYYY-MM-DD');
						
						cutoffDate = date;
					}else{
						let m = moment().format('M');
						let d = to;
						let y = moment().format('YYYY');
						let date = m +'-'+ d+'-'+ y;
							date = new Date(date);
							date = moment(date).add(3,'days').format('YYYY/MM/DD');
						cutoffDate = date;
					}
				}
				return cutoffDate;
			}else{
				return cutoffDate;
			}
		}catch(err){

		}
		// let day = moment().format('D');
		// let result = conn.sync.query("SELECT * FROM configuration WHERE id='1'");
		// let cutoffDate = '';
		// if(result){
		// 	let json = result[0]['json'];
		// 		json = json ? JSON.parse(json) : '';
		// 	if(json && json.cutoff){
		// 		let cutoff = json.cutoff;
		// 		let from = parseInt(cutoff.B_from);
		// 		let to   = parseInt(cutoff.B_to);
		// 			if(parseInt(day) >= from && parseInt(day) <= to){
		// 				let m = moment().format('M');
		// 				let d = from;
		// 				let y = moment().format('YYYY');
		// 				let date = m +'-'+ d+'-'+ y;
		// 					date = new Date(date);
		// 					date = moment(date).subtract(2,'days').format('YYYY-MM-DD');
						
		// 				cutoffDate = date;
		// 			}else{
		// 				let m = moment().format('M');
		// 				let d = to;
		// 				let y = moment().format('YYYY');
		// 				let date = m +'-'+ d+'-'+ y;
		// 					date = new Date(date);
		// 					date = moment(date).add(3,'days').format('YYYY/MM/DD');
		// 				cutoffDate = date;
		// 			}
		// 		}
		// }
		
		// return cutoffDate;
	}

}

module.exports = new GlobalHelper();