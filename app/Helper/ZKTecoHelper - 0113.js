const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const ZKLib = require('zklib');
const $env 		= require('dotenv').config();

function ZKTecoHelper(){

	this.getAttendance = function(host=null){
		ZK = new ZKLib({
			ip: $env.parsed.BIOMETRIC_HOST,
			port: $env.parsed.BIOMETRIC_PORT,
			inport: 5200,
			timeout: 5000,
			attendanceParser: 'v6.60',
			connectionType: 'tcp'
		});
		let biometric = {
			ip: $env.parsed.BIOMETRIC_HOST,
			port: $env.parsed.BIOMETRIC_PORT
		}
		return new Promise(function(resolve, reject) {
		  	ZK.connect(function(err){
		  		if (err){
		  			reject(err);
		  		}else{
		  			ZK.getAttendance(function(err, result) {
			        	ZK.disconnect();
				        if(err){
				        	reject(err);
				        }else{
				        	resolve({
				        		bio: biometric,
				        		rows: result
				        	});
				        }
				    });
		  		}
		  	});
		});
	}

}

module.exports = new ZKTecoHelper();