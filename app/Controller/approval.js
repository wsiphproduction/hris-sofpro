const Notification = require('../Helper/Notification');
const MailHelper = require('../Helper/MailHelper');
const Logger = require('../Helper/LoggerHelper');
const { 
	UsersModel,
	LeavesModel,
	ApproversModel,
	LeavePolicyModel,
	LeaveCreditPolicyModel,
	BusinessTripsModel,
	UndertimeModel,
	OvertimesModel,
	ShiftsModel,
	DisputeModel
} = require('../../config/Sequelize');

exports.update = function(req, res){
	let user = res.locals.user;
	let status = req.query.status;
	let form_array = ['business-trip','undertime','overtime','leave','shift','dispute'];
	let form = req.query.form;
	let token = req.query._token;
	if(user){
		if(token && form && form_array.includes(form) && status){
			if(status == 'approve'){
				status = 2;
			}else{
				status = 3;
			}
			if(form == 'business-trip'){
				businessTrip(req, res, token, status);
			}else if(form == 'undertime'){// Update undertime
				undertime(req, res, token, status);
			}else if(form == 'overtime'){
				overtime(req, res, token, status);
			}else if(form == 'leave'){
				leave(req, res, token, status);
			}else if(form == 'shift'){
				
			}else if(form == 'dispute'){
				dispute(req, res, token, status);
			}
		}else{
			res.render('Approvals/message',{
				year: res.locals.moment().format('YYYY'),
				status: 'error',
				app_name: res.locals.APP_NAME,
				message: 'Oh no there\'s a problem: Invalid or expired token.',
				title: 'Invalid!'
			});
		}
	}else{
		res.render('Approvals/message',{
			year: res.locals.moment().format('YYYY'),
			status: 'error',
			app_name: res.locals.APP_NAME,
			message: 'Oh no there\'s a problem: Please login to perform this action.',
			title: 'Error!'
		});
	}
	
}

/*
|--------------------------------------------------------------
| Update Leave
|--------------------------------------------------------------
*/

const leave = function(req, res, token, status){
	let user = res.locals.user;
	LeavesModel.findOne({
		where: {
			_token: token
		},
		include: [
			{
				model: LeaveCreditPolicyModel,
				required: false,
				where: {
					user_id: { $col: 'leaves.user_id' }
				},
				attributes: ['id', 'balance', 'utilized']
			},
			{
				model: UsersModel,
				as: 'applicant',
				attributes: ['email', 'first_name', 'last_name']
			}
		]
	}).then(function(data){
		result = data;
		if(result){
			let id = result.id;
			let credit = result.leave_credit_policy;
			if(status == 2 && credit){
				//console.log('APPP');
				let creditID = credit.id;
				let creditScore = credit && credit.balance ? parseFloat(credit.balance) : 0;
					creditScore = parseFloat(creditScore);
				let no_of_days = parseFloat(result.no_of_days);
				
				/*
				Decline if credit score is less than no_of_days or equal to zero.
				*/
				if(creditScore <= 0 || creditScore < no_of_days){
					let reqData = {
						backup_status: 3,
						_token: ''
					}
					let where = {
						id: id
					}
					if(user.id == result.primary_approver){
						reqData.primary_status = 3;
						where.primary_status = 1;
					}else{
						where.backup_status = 1;
					}
					LeavesModel.update(reqData, {
						where: where
					}).then(function(data){
						let title = 'Declined';
						let notificationMessage = {
							sender: user.id,
							content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your leave application.',
							url: 'forms/leave'
						}
						let receiver = [result.user_id];
						Notification.notify(notificationMessage, receiver, null, null);

						//MAIL Notification
						let mailMessage = `<p>Your leave application has been declined.</p>`;
						let subject = 'Leave Application';
						let applicant = {
							first_name: result.applicant.first_name,
							email: result.applicant.email
						}
						MailHelper.send_mail(applicant, mailMessage, subject);

						res.render('Approvals/message',{
							year: res.locals.moment().format('YYYY'),
							app_name: res.locals.APP_NAME,
							status: 'success',
							message: 'Leave application has been '+ title.toLowerCase() +'.',
							title: title +'!'
						});
					});
				}else{
					let reqData = {
						backup_status: 2,
						_token: ''
					}
					let where = {
						id: id
					}
					if(user.id == result.primary_approver){
						reqData.primary_status = 2;
						where.primary_status = 1;
						//Deduct Leave Credit if Final Approver
						let balance = creditScore - no_of_days;
						let utilized = credit && credit.utilized ? parseFloat(credit.utilized) : 0;
							utilized = utilized + no_of_days;
						let reqCredit = {
							balance: balance,
							utilized: utilized
						}
						LeaveCreditPolicyModel.update(reqCredit, {
							where: {
								id: creditID
							}
						});
					}else{
						where.backup_status = 1;
					}
					LeavesModel.update(reqData, {
						where: where
					}).then(function(data){
						let title = 'Approved';
						let notificationMessage = {
							sender: user.id,
							content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your leave application.',
							url: 'forms/leave'
						}
						let receiver = [result.user_id];
						Notification.notify(notificationMessage, receiver, null, null);

						//MAIL Notification
						let mailMessage = `<p>Your leave application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
						let subject = 'Leave Application';
						let applicant = {
							first_name: result.applicant.first_name,
							email: result.applicant.email
						}
						MailHelper.send_mail(applicant, mailMessage, subject);

						res.render('Approvals/message',{
							year: res.locals.moment().format('YYYY'),
							app_name: res.locals.APP_NAME,
							status: 'success',
							message: 'Leave application has been '+ title.toLowerCase() +'.',
							title: title +'!'
						});
					});
				}
			}else{ // Decline all application. No leave credit found.
				let reqData = {
					backup_status: 3,
					_token: ''
				}
				let where = {
					id: id
				}
				if(user.id == result.primary_approver){
					reqData.primary_status = 3;
					where.primary_status = 1;
				}else{
					where.backup_status = 1;
				}
				LeavesModel.update(reqData, {
					where: where
				}).then(function(data){
					let title = 'Declined';
					let notificationMessage = {
						sender: user.id,
						content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your leave application.',
						url: 'forms/leave'
					}
					let receiver = [result.user_id];
					Notification.notify(notificationMessage, receiver, null, null);

					//MAIL Notification
					let mailMessage = `<p>Your leave application has been declined.</p>`;
					let subject = 'Leave Application';
					let applicant = {
						first_name: result.applicant.first_name,
						email: result.applicant.email
					}
					MailHelper.send_mail(applicant, mailMessage, subject);

					res.render('Approvals/message',{
						year: res.locals.moment().format('YYYY'),
						app_name: res.locals.APP_NAME,
						status: 'success',
						message: 'Leave application has been '+ title.toLowerCase() +'.',
						title: title +'!'
					});
				});
			}
		}else{
			
			res.render('Approvals/message',{
				year: res.locals.moment().format('YYYY'),
				status: 'error',
				app_name: res.locals.APP_NAME,
				message: 'Oh no there\'s a problem: Invalid or expired token.',
				title: 'Invalid!'
			});
		}
	});
}


/*
|--------------------------------------------------------------
| Update Overtime
|--------------------------------------------------------------
*/
const overtime = function(req, res, token, status){
	let user = res.locals.user;
	OvertimesModel.findOne({
		where: {
			_token: token
		},
		include: [
			{
				model: UsersModel,
				as: 'applicant',
				attributes: ['email', 'first_name', 'last_name']
			}
		]
	}).then(function(data){
		result = data;
		if(result){
			let id = result.id;
			let primary_approver = result.primary_approver;
			let backup_approver = result.backup_approver;
			let title = status == 2 ? 'Approved':'Declined';
			let reqData = {
				backup_status: status,
				_token: ''
			}
			if(primary_approver && backup_approver){
				reqData.primary_status = status;
			}
			OvertimesModel.update(reqData, {
				where: {
					id: id
				}
			}).then(function(data){
				//APP Notification
				let notificationMessage = {
					sender: user.id,
					content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your overtime application.',
					url: 'forms/overtime'
				}
				let receiver = [result.user_id];
				Notification.notify(notificationMessage, receiver, null, null);

				//MAIL Notification
				let mailMessage = `<p>Your overtime application has been declined.</p>`;
				if(status == 2){
					mailMessage = `<p>Your overtime application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
				}
				let subject = 'Overtime Application';
				let applicant = {
					first_name: result.applicant.first_name,
					email: result.applicant.email
				}
				MailHelper.send_mail(applicant, mailMessage, subject);

				//RENDER view
				res.render('Approvals/message',{
					year: res.locals.moment().format('YYYY'),
					app_name: res.locals.APP_NAME,
					status: 'success',
					message: 'Overtime application has been '+ title.toLowerCase() +'.',
					title: title +'!'
				});
			});
		}else{
			res.render('Approvals/message',{
				year: res.locals.moment().format('YYYY'),
				status: 'error',
				app_name: res.locals.APP_NAME,
				message: 'Oh no there\'s a problem: Invalid or expired token.',
				title: 'Invalid!'
			});
		}
	});
}

/*
|--------------------------------------------------------------
| Update Dispute
|--------------------------------------------------------------
*/
const dispute = function(req, res, token, status){
	
	let user = res.locals.user;
	DisputeModel.findOne({
		where: {
			_token: token
		},
		include: [
			{
				model: UsersModel,
				as: 'applicant',
				attributes: ['email', 'first_name', 'last_name']
			}
		]
	}).then(function(data){
		result = data;
		if(result){
			let id = result.id;
			let primary_approver = result.primary_approver;
			let backup_approver = result.backup_approver;
			let title = status == 2 ? 'Approved':'Declined';
			let reqData = {
				backup_status: status,
				_token: ''
			}
			if(primary_approver && backup_approver){
				reqData.primary_status = status;
			}
			DisputeModel.update(reqData, {
				where: {
					id: id
				}
			}).then(function(data){
				//APP Notification
				let notificationMessage = {
					sender: user.id,
					content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your dispute application.',
					url: 'forms/dispute'
				}
				let receiver = [result.user_id];
				Notification.notify(notificationMessage, receiver, null, null);

				//MAIL Notification
				let mailMessage = `<p>Your dispute application has been declined.</p>`;
				if(status == 2){
					mailMessage = `<p>Your dispute application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
				}
				let subject = 'Dispute Application';
				let applicant = {
					first_name: result.applicant.first_name,
					email: result.applicant.email
				}
				MailHelper.send_mail(applicant, mailMessage, subject);

				//RENDER view
				res.render('Approvals/message',{
					year: res.locals.moment().format('YYYY'),
					app_name: res.locals.APP_NAME,
					status: 'success',
					message: 'Dispute application has been '+ title.toLowerCase() +'.',
					title: title +'!'
				});
			});
		}else{
			res.render('Approvals/message',{
				year: res.locals.moment().format('YYYY'),
				status: 'error',
				app_name: res.locals.APP_NAME,
				message: 'Oh no there\'s a problem: Invalid or expired token.',
				title: 'Invalid!'
			});
		}
	});
}


/*
|--------------------------------------------------------------
| Update Business Trip
|--------------------------------------------------------------
*/

const businessTrip = function(req, res, token, status){
	let user = res.locals.user;
	BusinessTripsModel.findOne({
		where: {
			_token: token
		},
		include: [
			{
				model: UsersModel,
				as: 'applicant',
				attributes: ['email', 'first_name', 'last_name']
			}
		]
	}).then(function(data){
		result = data;
		if(result){
			let id = result.id;
			let primary_approver = result.primary_approver;
			let backup_approver = result.backup_approver;
			let title = status == 2 ? 'Approved':'Declined';
			let reqData = {
				backup_status: status,
				_token: ''
			}
			if(primary_approver && backup_approver){
				reqData.primary_status = status;
			}
			BusinessTripsModel.update(reqData, {
				where: {
					id: id
				}
			}).then(function(data){
				//APP Notification
				let notificationMessage = {
					sender: user.id,
					content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your business trip application.',
					url: 'forms/business-trip'
				}
				let receiver = [result.user_id];
				Notification.notify(notificationMessage, receiver, null, null);

				//MAIL Notification
				let mailMessage = `<p>Your business trip application has been declined.</p>`;
				if(status == 2){
					mailMessage = `<p>Your business trip application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
				}
				let subject = 'Business Trip Application';
				let applicant = {
					first_name: result.applicant.first_name,
					email: result.applicant.email
				}
				MailHelper.send_mail(applicant, mailMessage, subject);

				//RENDER view
				res.render('Approvals/message',{
					year: res.locals.moment().format('YYYY'),
					app_name: res.locals.APP_NAME,
					status: 'success',
					message: 'Business Trip application has been '+ title.toLowerCase() +'.',
					title: title +'!'
				});
			});
		}else{
			res.render('Approvals/message',{
				year: res.locals.moment().format('YYYY'),
				status: 'error',
				app_name: res.locals.APP_NAME,
				message: 'Oh no there\'s a problem: Invalid or expired token.',
				title: 'Invalid!'
			});
		}
	});
}


/*
|--------------------------------------------------------------
| Update Undertime
|--------------------------------------------------------------
*/
const undertime = function(req, res, token, status){
	let user = res.locals.user;
	UndertimeModel.findOne({
		where: {
			_token: token
		},
		include: [
			{
				model: UsersModel,
				as: 'applicant',
				attributes: ['email', 'first_name', 'last_name']
			}
		]
	}).then(function(data){
		result = data;
		if(result){
			let id = result.id;
			let primary_approver = result.primary_approver;
			let backup_approver = result.backup_approver;
			let title = status == 2 ? 'Approved':'Declined';
			let reqData = {
				backup_status: status,
				_token: ''
			}
			if(primary_approver && backup_approver){
				reqData.primary_status = status;
			}
			UndertimeModel.update(reqData, {
				where: {
					id: id
				}
			}).then(function(data){
				//APP Notification
				let notificationMessage = {
					sender: user.id,
					content: '<strong>'+user.first_name +' '+ user.last_name +'</strong> '+ title.toLowerCase() +' your undertime application.',
					url: 'forms/undertime'
				}
				let receiver = [result.user_id];
				Notification.notify(notificationMessage, receiver, null, null);

				//MAIL Notification
				let mailMessage = `<p>Your undertime application has been declined.</p>`;
				if(status == 2){
					mailMessage = `<p>Your undertime application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
				}
				let subject = 'Undertime Application';
				let applicant = {
					first_name: result.applicant.first_name,
					email: result.applicant.email
				}
				MailHelper.send_mail(applicant, mailMessage, subject);

				//RENDER view
				res.render('Approvals/message',{
					year: res.locals.moment().format('YYYY'),
					app_name: res.locals.APP_NAME,
					status: 'success',
					message: 'Undertime application has been '+ title.toLowerCase() +'.',
					title: title +'!'
				});
			});
		}else{
			res.render('Approvals/message',{
				year: res.locals.moment().format('YYYY'),
				status: 'error',
				app_name: res.locals.APP_NAME,
				message: 'Oh no there\'s a problem: Invalid or expired token.',
				title: 'Invalid!'
			});
		}
	});
}