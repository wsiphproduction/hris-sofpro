const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const ZKTecoHelper = require('../Helper/ZKTecoHelper');
const { 
	sequelize,
	BiometricLog,
	BiometricModel
} = require('../../config/Sequelize');



function Biometric(){
	
	this.execute = function(){
		BiometricModel.findAll({
			where: {
				status: 1
			},
			raw: true
		}).then(async(data)=>{
			biometric = data;
			if(biometric && biometric.length > 0){
				for(let i in biometric){
					let host = biometric[i].site;
					await getBiometric(biometric[i].site);
					
					// console.log(biometric[i].site);
					// ZKTecoHelper.getAttendance(biometric[i].site).then((data)=>{
					// 	row = data.rows;
					// 	console.log(row);
					// 	if(row.length){
					// 		for(let i in row){
					// 			// process(row[i], data.bio);
					// 		}
					// 	}
					// }).catch(error=>{
					// 	console.log('error');
					// });
				}
			}
			// console.log(biometric);
		});
		// ZKTecoHelper.getAttendance('192.168.0.105').then((data)=>{
		// 	row = data.rows;
		// 	console.log(row);
		// 	if(row.length){
		// 		for(let i in row){
		// 			// process(row[i], data.bio);
		// 		}
		// 	}
		// }).catch(error=>{
		// 	console.log(error);
		// });
	}
	
}

module.exports = new Biometric();

const getBiometric = function(host){
	return new Promise((resolve, reject) => {
    	ZKTecoHelper.getAttendance(host).then((data)=>{
			row = data.rows;
			let count = row.length;
			if(count){
				for(let i in row){
					process(row[i], data.bio);
					// if(parseInt(i)+1==count){
					// 	resolve();
					// }
				}
			}
			resolve();
		}).catch(error=>{
			resolve();
		});
    });
}


const process = function(row, bio = null){
	// console.log(row);
	let userId = row.uid;
	let status = row.inOutStatus;
	let date = moment(new Date(row.timestamp)).format('YYYY-MM-DD HH:mm:ss');
	
	BiometricLog.count({
		where:{
			ip_address: bio.ip,
			userId: userId,
			date: date,
			status: status,
			source: 'biometric'
		}
	}).then(count=>{
		if(count <= 0){
			BiometricLog.create({
				ip_address: bio.ip,
				userId: userId,
				state: row.state,
				date: date,
				status: status,
				source: 'biometric'
			});
		}
	});
}