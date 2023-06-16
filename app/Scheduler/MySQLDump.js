const mysqlBackup = require('mysql-backup');
const mysqldump = require('mysqldump');
const fs = require('fs');
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');

const $env 		= require('dotenv').config();

function MySQLDump(){
	
	this.backup = function(){
		let path = './assets/backup/';
		let filename = moment().format('YYYY-MM-DD hhmm A') + '.sql';

		let dumpToFile = './assets/backup/' + filename;
		
		mysqldump({
		    connection: {
		        host: $env.parsed.DB_HOST,
		        user: $env.parsed.DB_USER,
		        password: $env.parsed.DB_PASS,
		        database: $env.parsed.DB_DATABASE,
		    },
		    dumpToFile: dumpToFile,
		});
	}

}

module.exports = new MySQLDump();