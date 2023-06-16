const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const ZKLib = require('zklib');
const $env 		= require('dotenv').config();

function ZKTecoHelper(){

	this.getAttendance = function(host=null){
//console.log('ZK', $env.parsed.BIOMETRIC_HOST, $env.parsed.BIOMETRIC_PORT);
		ZK = new ZKLib({
			ip: $env.parsed.BIOMETRIC_HOST,
			port: $env.parsed.BIOMETRIC_PORT,
			inport: 5200,
			timeout: 5000,
			attendanceParser: 'v6.60'
		});
console.log(ZK);
		let biometric = {
			ip: $env.parsed.BIOMETRIC_HOST,
			port: $env.parsed.BIOMETRIC_PORT
		}
		return new Promise(function(resolve, reject) {
		  	ZK.connect(function(err, ok){
				console.log(ok);
		  		if (err){
		  			reject(err);
		  		}else{
		  			ZK.getAttendance(function(err, result) {
			        	ZK.disconnect();
				        if(err){
console.log(err);
				        	reject(err);
				        }else{
						console.log(result);
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