const fs = require('fs');
const $env   = require('dotenv').config();
const moment = require('moment-timezone');
      moment.tz.setDefault($env.parsed.TIMEZONE);

function Logger(){

	this.createLog = function(errors){
		if($env.parsed.PRODUCTION){
            let fileName = moment().format('MM-YYYY') + '.txt';
			let filePath = './logs/';
			fs.appendFile(filePath + fileName, errors, function (err) {
				if (err){
				  	console.log('Failed!');
				}
			});
        }else{
            console.log(errors);
        }
		
	}

}

module.exports = new Logger();