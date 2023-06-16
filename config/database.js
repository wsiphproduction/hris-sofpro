const mysql 	= require('mysql');
const sync      = require('sync-mysql');
const $env 		= require('dotenv').config();

function MySQL(){

	this.pool = mysql.createPool({
		
		connectionLimit: 1,
		host     : $env.parsed.DB_HOST,
		user     : $env.parsed.DB_USER,
		password : $env.parsed.DB_PASS,
		database : $env.parsed.DB_DATABASE,
		dateStrings: true
 
	});

	this.sync = new sync({

		host 	 : $env.parsed.DB_HOST,
		user 	 : $env.parsed.DB_USER,
		password : $env.parsed.DB_PASS,
		database : $env.parsed.DB_DATABASE,
		
	});

}

module.exports = new MySQL();