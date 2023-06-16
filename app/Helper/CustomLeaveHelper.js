const Notification = require('./Notification');
const MailHelper = require('./MailHelper');

const {
	Op,
	LeavesModel,
	LeaveDateModel,
	LeaveCreditPolicyModel,
	UsersModel
} = require('../../config/Sequelize');

function CustomLeaveHelper(){

	this._set = function(id){
		let status = 2;

		LeavesModel.findOne({
			where: {
				id: id
			},
			attributes: ['id','user_id','primary_approver', 'backup_approver', 'no_of_days', 'leave_type'],
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
			return UsersModel.findByPk(result.user_id);
		}).then(function(data){
			user = data;
			let credit = result.leave_credit_policy;
			let type = result.leave_type;
			if(status == 2 && credit){
				//console.log('APPP');
				let creditID = credit.id;
				let creditScore = credit && credit.balance ? parseFloat(credit.balance) : 0;
					creditScore = parseFloat(creditScore);

				let no_of_days = parseFloat(result.no_of_days);
				
				//Decline if credit score is less than no_of_days or equal to zero.
				if(creditScore <= 0 || creditScore < no_of_days){
					let reqData = {
						backup_status: 3,
						_token: '',
						primary_status: 3
					}
					let where = {
						id: id,
						primary_status: 1
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
						// Notification.notify(notificationMessage, receiver, null, null);

						//MAIL Notification
						// let mailMessage = `<p>Your leave application has been declined.</p>`;
						// let subject = 'Leave Application';
						// let applicant = {
						// 	first_name: result.applicant.first_name,
						// 	email: result.applicant.email
						// }
						// MailHelper.send_mail(applicant, mailMessage, subject);
					});
				}else{
					let reqData = {
						backup_status: 2,
						_token: '',
						primary_status: 2
					}
					let where = {
						id: id,
						primary_status: 1
					}
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

						// MAIL Notification
						let mailMessage = `<p>Your leave application has been approved by `+ user.first_name +` `+ user.last_name +`</p>`;
						let subject = 'Leave Application';
						let applicant = {
							first_name: result.applicant.first_name,
							email: result.applicant.email
						}
						MailHelper.send_mail(applicant, mailMessage, subject);
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
				});
			}
		});
	}

	this.migrate = function(start_date, end_date){
		console.log(start_date + ' -- ' + end_date);

		let where = {
			date : {
				$between: [start_date, end_date]
			}
		};

		let withPayID = [];
		let withoutPayID = [];
		let wholeDay = [];
		let firstHalf = [];
		let secondHalf = [];

		LeaveDateModel.findAll({
			where: where,
			include: [
				{
					model: LeavesModel,
				},
			]
		}).then(function(data){
			leaveDates = data;
			
			for(let i in leaveDates){
				// Leave Credit
				if (leaveDates[i].leave.credit == '1'){
					withPayID.push(leaveDates[i].id);
				} else {
					withoutPayID.push(leaveDates[i].id);
				}

				// Leave Duration
				if (leaveDates[i].leave.leave_duration == 0){
					wholeDay.push(leaveDates[i].id);
				} else if (leaveDates[i].leave.leave_duration == 1){
					firstHalf.push(leaveDates[i].id);
				} else if (leaveDates[i].leave.leave_duration == 2){
					secondHalf.push(leaveDates[i].id);
				}
			}

			var reqCredit = {
				credit: '1',
			};
			var reqDuration = {
				leave_duration: '1',
			};

			console.log(withPayID);
			if (withPayID && withPayID.length > 0){
				LeaveDateModel.update(reqCredit, {
					where: {
						id : {
							[Op.in]: withPayID
						}
					}
				})
			}

			console.log(withoutPayID);
			if (withoutPayID && withoutPayID.length > 0){
				reqCredit.credit = '2';
				LeaveDateModel.update(reqCredit, {
					where: {
						id : {
							[Op.in]: withoutPayID
						}
					}
				})
			}

			console.log(wholeDay);
			if (wholeDay && wholeDay.length > 0){
				LeaveDateModel.update(reqDuration, {
					where: {
						id : {
							[Op.in]: wholeDay
						}
					}
				})
			}

			console.log(firstHalf);
			if (firstHalf && firstHalf.length > 0){
				reqDuration.leave_duration = 1;
				LeaveDateModel.update(reqDuration, {
					where: {
						id : { 
							[Op.in]: firstHalf
						}
					}
				})	
			}

			console.log(secondHalf);
			if (secondHalf && secondHalf.length > 0){
				reqDuration.leave_duration = 2;
				LeaveDateModel.update(reqDuration, {
					where: {
						id : {
							[Op.in]: secondHalf
						}
					}
				})
			}

		})
	}

}

module.exports = new CustomLeaveHelper();