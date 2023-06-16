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
		ZKTecoHelper.getAttendance().then((data)=>{
			row = data.rows;
			if(row.length){
				for(let i in row){
					process(row[i], data.bio);
				}
			}
		}).catch(error=>{
			// console.log('error');
		});
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