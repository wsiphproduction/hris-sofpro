const nodemailer = require('nodemailer');
const $env 			= require('dotenv').config();

function Mailer(){
	
	this.transporter = nodemailer.createTransport({
		//service: $env.parsed.MAIL_SERVICE,
		host: $env.parsed.MAIL_HOST,
    	port: $env.parsed.MAIL_PORT,
    	service: $env.parsed.MAIL_SERVICE,
    	secure: true,
		auth: {
			user: $env.parsed.MAIL_USER,
			pass: $env.parsed.MAIL_PASS
		}
	});
	
}

module.exports = new Mailer();