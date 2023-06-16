const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const ZKLib = require('zklib');
const $env 		= require('dotenv').config();

function ZKTecoHelper(){

	this.getAttendance = function(host){
		let ip_param = host && host.site ? host.site : $env.parsed.BIOMETRIC_HOST;
		let port_param = 4370;
		//console.log(ip_param);
		ZK = new ZKLib({
			ip: ip_param,
			port: port_param,
			inport: 5200,
			timeout: 15000,
			attendanceParser: 'v6.60',
			connectionType: 'tcp',
		});
		let biometric = {
			ip: ip_param,
			port: port_param
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
