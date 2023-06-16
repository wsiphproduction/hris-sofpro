const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const Mailer   = require('../../config/mailer');
const image = 'https://hris.slli.ph/jpm.png';
const globalModel = require('../../app/Models/Global');


function MailHelper(){

	/*
	|------------------------------------------------------
	| Forgot Password
	|------------------------------------------------------
	*/
	this.forgot_password = function(receiver, link){

		let message = `
			<p>We received a request to reset your password for your HRIS account: `+ receiver.email +`. We're here to help.</p>
			<p>Simply click on the button to set new password.</p>

			<div style="margin: 50px 0 25px 0; text-align: center;">
				<a href="`+ link +`" style="display: inline-block; padding: 8px 15px; background: #00c853; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Set new password.</a>
			</div>

			<p>If you didn't ask to change your password, don't worry! Your password is still safe and you can delete this email.</p>
		`;
		let subject = 'Forgot Password';
		this.send_mail(receiver, message, subject);
	}

	/*
	|------------------------------------------------------
	| Reset Password
	|------------------------------------------------------
	*/
	this.reset_password = function(receiver){
		let message = `<p>The password for username <strong>`+ receiver.username +`</strong> has been successfully changed.</p>`;
		let subject = 'Reset Password';
		this.send_mail(receiver, message, subject);
	}

	this.notify_approver = function(receiver, subject, applicant, formInfo, btnLink, custom = null){
		let message = ``;
		if(!custom){
			message = `
			<p>A new `+ subject +` request from <strong>`+ applicant +`</strong> has been registered, and it is pending for your approval. Click on the button below to submit you answer.</p>
			`+ formInfo +`
			<div style="margin: 50px 0 25px 0; text-align: center;">
				<a href="`+ btnLink.approve +`" style="display: inline-block; padding: 8px 15px; background: #00c853; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Approve</a>
				<a href="`+ btnLink.decline +`" style="display: inline-block; padding: 8px 15px; background: #ffd600; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Decline</a>
				<a href="`+ btnLink.more +`" style="display: inline-block; padding: 8px 15px; background: #00b0ff; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Learn More</a>
			</div>
			`;
		}else{
			message = `<p>This is to inform the leave application has been processed and approved by HR Admin.</p>` + formInfo;
		}
		this.send_mail(receiver, message, subject);
	}

	this.notify_approver_batch = function(subject, BusinessTripEmailContentList){
		let recieverMap = new Map();
		let receiverList = [];
		
		for (BusinessTripEmailContent in BusinessTripEmailContentList) {
			let message = ``;
			let approver = BusinessTripEmailContentList[BusinessTripEmailContent].primaryApprover;
			receiverList.push(approver)
			
			message = `
			<p>A `+ subject +` request from <strong>`+ BusinessTripEmailContentList[BusinessTripEmailContent].applicant +`</strong> has been registered, and it is pending for your approval. Click on the button below to submit you answer.</p>
			`+ BusinessTripEmailContentList[BusinessTripEmailContent].formInfo +`
			<div style="margin: 50px 0 25px 0; text-align: center;">
				<a href="`+ BusinessTripEmailContentList[BusinessTripEmailContent].btnLink.approve +`" style="display: inline-block; padding: 8px 15px; background: #00c853; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Approve</a>
				<a href="`+ BusinessTripEmailContentList[BusinessTripEmailContent].btnLink.decline +`" style="display: inline-block; padding: 8px 15px; background: #ffd600; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Decline</a>
				<a href="`+ BusinessTripEmailContentList[BusinessTripEmailContent].btnLink.more +`" style="display: inline-block; padding: 8px 15px; background: #00b0ff; border-radius: 3px; color: #ffffff; text-decoration: none; margin: 0 3px;">Learn More</a>
			</div>
			`;
			if (!recieverMap.has(approver.email)) {
				recieverMap.set(approver.email, [message]);
			} else{
				recieverMap.get(approver.email).push(message);
			}
			
		}
		receiverList = receiverList.filter((value, index, self) =>
			index === self.findIndex((t) => (
				t.first_name === value.first_name && t.email === value.email
			))
		)
		
		
		for (reciever in receiverList) {
			let messageToSend = recieverMap.get(receiverList[reciever].email)
			let receiverOfEmail = receiverList[reciever]
			
			this.send_mail(receiverOfEmail, messageToSend, subject);
		}
		
	}

	this.custom_leave_notify_manager = function(receiver, employee, type){
		let message = `
			<p>This is to inform the leave application has been processed and approved by HR Admin.</p>
			<p>
				Employee: `+ employee +`<br>
				Type: `+ type +`<br>
			</p>
		`;
		let subject = 'Leave Application';
		this.send_mail(receiver, message, subject);
	}
	/*
	|------------------------------------------------------
	| Execute Send mail
	|------------------------------------------------------
	*/
	this.send_mail = function(receiver, message, subject){
		
		const branding = globalModel.branding();

		let APP_NAME = branding && branding.name ? branding.name : $env.parsed.APP_NAME;

		let template = `
		<!DOCTYPE html>
		<html>
		<head>
			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<title>`+ APP_NAME +` : `+ subject +`</title>
			<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet" type="text/css"/>
			<style>
				body{
					background: #f5f5f5;
				}	
			</style>
		</head>
		<body style="background: #F3F3F3; margin: 0; padding: 0; font-family: 'Open Sans', Helvetica, Arial, sans-serif; font-size: 14px; color: #424242;">
			<div style="max-width: 800px; margin:0 auto; padding: 25px 15px;">
				<div style="background: #fff; padding: 15px 25px; border-radius: 5px; margin-top: 25px;">
					<p>Dear `+ receiver.first_name +`,</p>
					
					`+ message +`

					<p>
						Cheers,<br>
						`+ APP_NAME +`
					</p>
					<p style="font-size: 12px; margin-top: 35px; text-align: center; color: #757575;">You have received this notification because you have either subscribed to it, or are involved in it. <br>Do not reply.</p>
				</div>
				<div style="font-size: 12px; text-align: center; margin-top: 30px; color: #757575;">
					
					<div style="margin-bottom: 10px;">Copyright &copy; `+ moment().format('YYYY') +` `+ APP_NAME +`, All rights reserved. </div>
					<!-- <img src="`+ image +`" alt="" height="50"> -->
				</div>
			</div>
		</body>
		</html>
		`;

		let mailOptions = {
			from: APP_NAME +' <'+ $env.parsed.MAIL_USER +'>',
			to: receiver.email,
			subject: subject,
			html: template,
			//attachments: attachments
		};
		Mailer.transporter.sendMail(mailOptions, function(error, info){
			if (error) {
				console.log(error);
				console.log('Failed!');
			} else {
				console.log('Email sent: ' + info.response);
			}
		});
		
	}
}

module.exports = new MailHelper();