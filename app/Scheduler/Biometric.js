const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const ZKTecoHelper = require('../Helper/ZKTecoHelper');
const { 
	sequelize,
	BiometricLog,
	BiometricModel
} = require('../../config/Sequelize');
const { jpg } = require('image-size/lib/types');



function Biometric(){
	
	this.execute = function(){
		// Search for biometrics
		let where = {
			status: 1
		}

		BiometricModel.findAll({
			where: where,
		//	limit:3,
		}).then(function(data){
			let bios = data;
			
			if(bios && bios.length){
				for(let i in bios){
					setTimeout(function(){
						ZKTecoHelper.getAttendance(bios[i]).then((data)=>{
							row = data.rows;
							console.log(bios[i].site + ' : ' + row.length);
							
							if(row.length){
								for(let j in row){
									process(row[j], data.bio);
								}
							}
						}).catch(error=>{
							console.log(error);
						});
					}, 60000 * i);
				}
			}
		});
	}
	
}

module.exports = new Biometric();


const process = function(row, bio = null){
	let userId = row.uid;
	let status = row.inOutStatus;
	let date = moment(new Date(row.timestamp)).format('YYYY-MM-DD HH:mm:ss');

	// process only the data today
	let today    = moment().format('YYYY-MM-DD');
	let dataDate = moment(new Date(row.timestamp)).format('YYYY-MM-DD');

	let diff_date =moment(row.timestamp).add(3,'days').format('YYYY-MM-DD');

	if (today < diff_date && userId && !isNaN(userId)){
		console.log(dataDate + ' : ' + userId);
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
}