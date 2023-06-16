const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const MailHelper   = require('./MailHelper');
const _ = require('underscore');
const {  
	Op,
	UsersModel,
	BusinessTripsModel,
	ApproversModel,
	UndertimeModel,
	OvertimesModel,
	LeavesModel,
	LeavePolicyModel,
	DisputeModel
} = require('../../config/Sequelize');
const { result } = require('lodash');

function PrepareMail(){
	/*
	|------------------------------------------------------
	| FORM APPLICATION
	|------------------------------------------------------
	*/ 
	this.business_trip = function(insertId, base_url){
		BusinessTripsModel.findOne({
			where: {
				id: insertId
			},
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
			attributes: ['note', '_token'],
		}).then(function(data){
			result = data;
			let subject = 'Business Trip';
			let applicant = result.applicant.first_name +' '+ result.applicant.last_name;
			let formInfo = `
			<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
				<div>
					<small><strong>Applicant</strong></small>
					<p style="margin-top: 0">`+ applicant +`</p>
				</div>
				<div>
					<small><strong>Start Date</strong></small>
					<p style="margin-top: 0">`+ moment(result.date_start).format('LL') +`</p>
				</div>
				<div>
					<small><strong>End Date</strong></small>
					<p style="margin-top: 0">`+ moment(result.date_end).format('LL') +`</p>
				</div>
				<div>
					<small><strong>Note</strong></small>
					<p style="margin-top: 0">`+ result.note +`</p>
				</div>
			</div>
			`;
			let btnLink = {
				approve: base_url + '/approvals/update?status=approve&form=business-trip&_token='+ result._token,
				decline: base_url + '/approvals/update?status=decline&form=business-trip&_token='+ result._token,
				more: base_url + '/approvals/business-trip'
			}
			// if(result.backup && result.backup.email){
			// 	let backupApprover = {
			// 		first_name: result.backup.first_name,
			// 		email: result.backup.email,
			// 	}
			// 	MailHelper.notify_approver(backupApprover, subject, applicant, formInfo, btnLink);
			// }
			if(result.primary && result.primary.email){
				let primaryApprover = {
					first_name: result.primary.first_name,
					email: result.primary.email,
				}
				MailHelper.notify_approver(primaryApprover, subject, applicant, formInfo, btnLink);
			}
		});
	}

	this.undertime = function(insertId, base_url){
		UndertimeModel.findOne({
			where: {
				id: insertId
			},
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
		}).then(function(data){
			result = data;
			let subject = 'Undertime';
			let applicant = result.applicant.first_name +' '+ result.applicant.last_name;
			let date = new Date(result.date +' '+ result.time);
			let formInfo = `
			<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
				<div>
					<small><strong>Applicant</strong></small>
					<p style="margin-top: 0">`+ applicant +`</p>
				</div>
				<div>
					<small><strong>Date</strong></small>
					<p style="margin-top: 0">`+ moment(date).format('LLL') +`</p>
				</div>
				<div>
					<small><strong>Reason</strong></small>
					<p style="margin-top: 0">`+ result.reason +`</p>
				</div>
			</div>
			`;
			let btnLink = {
				approve: base_url + '/approvals/update?status=approve&form=undertime&_token='+ result._token,
				decline: base_url + '/approvals/update?status=decline&form=undertime&_token='+ result._token,
				more: base_url + '/approvals/undertime'
			}
			// if(result.backup && result.backup.email){
			// 	let backupApprover = {
			// 		first_name: result.backup.first_name,
			// 		email: result.backup.email,
			// 	}
			// 	MailHelper.notify_approver(backupApprover, subject, applicant, formInfo, btnLink);
			// }
			if(result.primary && result.primary.email){
				let primaryApprover = {
					first_name: result.primary.first_name,
					email: result.primary.email,
				}
				MailHelper.notify_approver(primaryApprover, subject, applicant, formInfo, btnLink);
			}
		});
	}

	this.overtime = function(insertId, base_url){
		OvertimesModel.findOne({
			where: {
				id: insertId
			},
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
		}).then(function(data){
			result = data;
			let subject = 'Overtime';
			let applicant = result.applicant.first_name +' '+ result.applicant.last_name;
			let from = new Date(result.start_date +' '+ result.start_time);
			let to = new Date(result.end_date +' '+ result.end_time);
			let type = ``;
			if(result.type == 1){
				type = `Regular Overtime`;
			}else if(result.type == 2){
				type = `Restday or Special Holiday`;
			}else if(result.type == 3){
				type = `Regular Holiday`;
			}else if(result.type == 4){
				type = `Restday and Special Holiday`;
			}else if(result.type == 5){
				type = `Restday and Regular Holiday`;
			}
			let formInfo = `
			<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
				<div>
					<small><strong>Applicant</strong></small>
					<p style="margin-top: 0">`+ applicant +`</p>
				</div>
				<div>
					<small><strong>From</strong></small>
					<p style="margin-top: 0">`+ moment(from).format('LLL') +`</p>
				</div>
				<div>
					<small><strong>To</strong></small>
					<p style="margin-top: 0">`+ moment(to).format('LLL') +`</p>
				</div>
				<div>
					<small><strong>Number of hour(s)</strong></small>
					<p style="margin-top: 0">`+ result.no_of_hours +` hour(s)</p>
				</div>
				<div>
					<small><strong>Type</strong></small>
					<p style="margin-top: 0">`+ type +`</p>
				</div>
				<div>
					<small><strong>Purpose</strong></small>
					<p style="margin-top: 0">`+ result.purpose +`</p>
				</div>
			</div>
			`;
			let btnLink = {
				approve: base_url + '/approvals/update?status=approve&form=overtime&_token='+ result._token,
				decline: base_url + '/approvals/update?status=decline&form=overtime&_token='+ result._token,
				more: base_url + '/approvals/overtime'
			}
			// if(result.backup && result.backup.email){
			// 	let backupApprover = {
			// 		first_name: result.backup.first_name,
			// 		email: result.backup.email,
			// 	}
			// 	MailHelper.notify_approver(backupApprover, subject, applicant, formInfo, btnLink);
			// }
			if(result.primary && result.primary.email){
				let primaryApprover = {
					first_name: result.primary.first_name,
					email: result.primary.email,
				}
				MailHelper.notify_approver(primaryApprover, subject, applicant, formInfo, btnLink);
			}
		});
	}

	this.dispute = function(insertId, base_url){
		DisputeModel.findOne({
			where: {
				id: insertId
			},
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
		}).then(function(data){
			result = data;
			let subject = 'Dispute';
			let applicant = result.applicant.first_name +' '+ result.applicant.last_name;
			let from = new Date(result.start_date +' '+ result.start_time);
			let to = new Date(result.end_date +' '+ result.end_time);
			let type = ``;
			let label = ``;
			if(result.type == 1){
				label = `<small><strong>No. of hours</strong></small> <p style="margin-top: 0">`+ result.hour +` hour(s)</p>`;
				type = `Rest Day Pay`;
			}else if(result.type == 2){
				label = `<small><strong>No. of hours</strong></small> <p style="margin-top: 0">`+ result.hour +` hour(s)</p>`;
				type = `Overtime`;
			}else if(result.type == 3){
				label = `<small><strong>No. of days</strong></small> <p style="margin-top: 0">`+ result.hour +` day(s)</p>`;
				type = `Leave`;
			}else if(result.type == 4){
				type = `No Time in / Time out`;
			}
			let formInfo = `
			<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
				<div>
					<small><strong>Applicant</strong></small>
					<p style="margin-top: 0">`+ applicant +`</p>
				</div>
				<div>
					<small><strong>Type</strong></small>
					<p style="margin-top: 0">`+ type +`</p>
				</div>
				<div>
					`+ label +`
				</div>
				<div>
					<small><strong>Note</strong></small>
					<p style="margin-top: 0">`+ result.note +`</p>
				</div>
			</div>
			`;
			let btnLink = {
				approve: base_url + '/approvals/update?status=approve&form=dispute&_token='+ result._token,
				decline: base_url + '/approvals/update?status=decline&form=dispute&_token='+ result._token,
				more: base_url + '/approvals/dispute'
			}
			// if(result.backup && result.backup.email){
			// 	let backupApprover = {
			// 		first_name: result.backup.first_name,
			// 		email: result.backup.email,
			// 	}
			// 	MailHelper.notify_approver(backupApprover, subject, applicant, formInfo, btnLink);
			// }
			if(result.primary && result.primary.email){
				let primaryApprover = {
					first_name: result.primary.first_name,
					email: result.primary.email,
				}
				MailHelper.notify_approver(primaryApprover, subject, applicant, formInfo, btnLink);
			}
		});
	}

	this.leave = function(insertId, base_url, custom = null){
		LeavesModel.findOne({
			where: {
				id: insertId
			},
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: LeavePolicyModel,
					attributes: ['name']
				}
			],
		}).then(function(data){
			result = data;
			let subject = 'Leave';
			let applicant = result.applicant.first_name +' '+ result.applicant.last_name;
			let from = new Date(result.start_date);
			let to = new Date(result.end_date);
			let credit = result.credit == 1 ? 'With Pay':'Without Pay';
			let formInfo = `
			<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
				<div>
					<small><strong>Applicant</strong></small>
					<p style="margin-top: 0">`+ applicant +`</p>
				</div>
				<div>
					<small><strong>Type</strong></small>
					<p style="margin-top: 0">`+ result.leave_policy.name +`</p>
				</div>
				<div>
					<small><strong>Credit</strong></small>
					<p style="margin-top: 0">`+ credit +`</p>
				</div>
				<div>
					<small><strong>Number of day(s)</strong></small>
					<p style="margin-top: 0">`+ result.no_of_days +` day(s)</p>
				</div>
				<div>
					<small><strong>From</strong></small>
					<p style="margin-top: 0">`+ moment(from).format('LL') +`</p>
				</div>
				<div>
					<small><strong>To</strong></small>
					<p style="margin-top: 0">`+ moment(to).format('LL') +`</p>
				</div>
				<div>
					<small><strong>Reason</strong></small>
					<p style="margin-top: 0">`+ result.reason +`</p>
				</div>
			</div>
			`;
			let btnLink = {
				approve: base_url + '/approvals/update?status=approve&form=leave&_token='+ result._token,
				decline: base_url + '/approvals/update?status=decline&form=leave&_token='+ result._token,
				more: base_url + '/approvals/leave'
			}
			if(result.backup && result.backup.email){
				let backupApprover = {
					first_name: result.backup.first_name,
					email: result.backup.email,
				}
				MailHelper.notify_approver(backupApprover, subject, applicant, formInfo, btnLink, custom);
			}
			if(result.primary && result.primary.email){
				let primaryApprover = {
					first_name: result.primary.first_name,
					email: result.primary.email,
				}
				MailHelper.notify_approver(primaryApprover, subject, applicant, formInfo, btnLink, custom);
			}
		});
	}
	/*
	|------------------------------------------------------
	| Batch Email
	|------------------------------------------------------
	*/ 
	this.business_trip_batch = function(){
		let base_url = $env.parsed.APP_URL
		let whereUser = {}
		whereUser.$or = [
			{
				primary_status: 1
			},{
				backup_status: 1
			}
		]

		BusinessTripsModel.findAll({
			where: whereUser,
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
			order: [
				['user_id', 'asc']
			],
			attributes: ['id', 'note', '_token'],
			
		}).then(function(data){
			businessTripData = data;
			
			let subject = 'Business Trip';
			let businessTripEmailContentList = [];
			
			for(businessTrip in businessTripData) {
				
				let applicant = businessTripData[businessTrip].applicant.first_name +' '+ businessTripData[businessTrip].applicant.last_name;
				let formInfo = `
				<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
					<div>
						<small><strong>Applicant</strong></small>
						<p style="margin-top: 0">`+ applicant +`</p>
					</div>
					<div>
						<small><strong>Start Date</strong></small>
						<p style="margin-top: 0">`+ moment(businessTripData[businessTrip].date_start).format('LL') +`</p>
					</div>
					<div>
						<small><strong>End Date</strong></small>
						<p style="margin-top: 0">`+ moment(businessTripData[businessTrip].date_end).format('LL') +`</p>
					</div>
					<div>
						<small><strong>Note</strong></small>
						<p style="margin-top: 0">`+ businessTripData[businessTrip].note +`</p>
					</div>
				</div>
				`;
				let btnLink = {
					approve: base_url + '/approvals/update?status=approve&form=business-trip&_token='+ businessTripData[businessTrip]._token,
					decline: base_url + '/approvals/update?status=decline&form=business-trip&_token='+ businessTripData[businessTrip]._token,
					more: base_url + '/approvals/business-trip'
				}
			
				let primaryApprover = {}
				if(businessTripData[businessTrip].primary && businessTripData[businessTrip].primary.email){
					primaryApprover = {
						first_name: businessTripData[businessTrip].primary.first_name,
						email: businessTripData[businessTrip].primary.email,
					}
				} else {
					primaryApprover = {
						first_name: businessTripData[businessTrip].backup.first_name,
						email: businessTripData[businessTrip].backup.email,
					}
				}
				let emailInfo = {
					applicant: applicant,
					formInfo: formInfo,
					btnLink: btnLink,
					primaryApprover: primaryApprover
				}

				businessTripEmailContentList.push(emailInfo)
			}
			MailHelper.notify_approver_batch(subject, businessTripEmailContentList);
		});
	}

	this.undertime_batch = function(){
		let base_url = $env.parsed.APP_URL
		let whereUser = {}
		whereUser.$or = [
			{
				primary_status: 1
			},{
				backup_status: 1
			}
		]

		UndertimeModel.findAll({
			where: whereUser,
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
			order: [
				['user_id', 'asc']
			],
			
		}).then(function(data){
			undertimeData = data;
			
			let subject = 'Undertime';
			let undertimeDataEmailContentList = [];
			
			for(undertime in undertimeData) {
				let applicant = undertimeData[undertime].applicant.first_name +' '+ undertimeData[undertime].applicant.last_name;
				let time = moment(new Date(undertimeData[undertime].time)).utc().format('HH:mm');
				let date = new Date(undertimeData[undertime].date +' '+ time);
				
				let formInfo = `
				<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
					<div>
						<small><strong>Applicant</strong></small>
						<p style="margin-top: 0">`+ applicant +`</p>
					</div>
					<div>
						<small><strong>Date</strong></small>
						<p style="margin-top: 0">`+ moment(date).format('LLL') +`</p>
					</div>
					<div>
						<small><strong>Reason</strong></small>
						<p style="margin-top: 0">`+ undertimeData[undertime].reason +`</p>
					</div>
				</div>
				`;
				let btnLink = {
					approve: base_url + '/approvals/update?status=approve&form=undertime&_token='+ undertimeData[undertime]._token,
					decline: base_url + '/approvals/update?status=decline&form=undertime&_token='+ undertimeData[undertime]._token,
					more: base_url + '/approvals/undertime'
				}
			
				let primaryApprover = {}
				if(undertimeData[undertime].primary && undertimeData[undertime].primary.email){
					primaryApprover = {
						first_name: undertimeData[undertime].primary.first_name,
						email: undertimeData[undertime].primary.email,
					}
				} else {
					primaryApprover = {
						first_name: undertimeData[undertime].backup.first_name,
						email: undertimeData[undertime].backup.email,
					}
				}
				let emailInfo = {
					applicant: applicant,
					formInfo: formInfo,
					btnLink: btnLink,
					primaryApprover: primaryApprover
				}

				undertimeDataEmailContentList.push(emailInfo)
			}
			MailHelper.notify_approver_batch(subject, undertimeDataEmailContentList);
		});
	}

	this.overtime_batch = function(){
		let base_url = $env.parsed.APP_URL
		let whereUser = {}
		whereUser.$or = [
			{
				primary_status: 1
			},{
				backup_status: 1
			}
		]

		OvertimesModel.findAll({
			where: whereUser,
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
			order: [
				['user_id', 'asc']
			],
			
		}).then(function(data){
			overtimeData = data;
			
			let subject = 'Overtime';
			let overtimeDataEmailContentList = [];
			
			for(overtime in overtimeData) {
				
				let applicant = overtimeData[overtime].applicant.first_name +' '+ overtimeData[overtime].applicant.last_name;
				let start_time = moment(new Date(overtimeData[overtime].start_time)).utc().format('HH:mm');
				let from = new Date(overtimeData[overtime].start_date +' '+ start_time);
				let end_time = moment(new Date(overtimeData[overtime].end_time)).utc().format('HH:mm');
				let to = new Date(overtimeData[overtime].end_date +' '+ end_time);
				let type = ``;
				if(overtimeData[overtime].type == 1){
					type = `Regular Overtime`;
				}else if(overtimeData[overtime].type == 2){
					type = `Restday or Special Holiday`;
				}else if(overtimeData[overtime].type == 3){
					type = `Regular Holiday`;
				}else if(overtimeData[overtime].type == 4){
					type = `Restday and Special Holiday`;
				}else if(overtimeData[overtime].type == 5){
					type = `Restday and Regular Holiday`;
				}
				let formInfo = `
				<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
					<div>
						<small><strong>Applicant</strong></small>
						<p style="margin-top: 0">`+ applicant +`</p>
					</div>
					<div>
						<small><strong>From</strong></small>
						<p style="margin-top: 0">`+ moment(from).format('LLL') +`</p>
					</div>
					<div>
						<small><strong>To</strong></small>
						<p style="margin-top: 0">`+ moment(to).format('LLL') +`</p>
					</div>
					<div>
						<small><strong>Number of hour(s)</strong></small>
						<p style="margin-top: 0">`+ overtimeData[overtime].no_of_hours +` hour(s)</p>
					</div>
					<div>
						<small><strong>Type</strong></small>
						<p style="margin-top: 0">`+ type +`</p>
					</div>
					<div>
						<small><strong>Purpose</strong></small>
						<p style="margin-top: 0">`+ overtimeData[overtime].purpose +`</p>
					</div>
				</div>
				`;
				let btnLink = {
					approve: base_url + '/approvals/update?status=approve&form=overtime&_token='+ overtimeData[overtime]._token,
					decline: base_url + '/approvals/update?status=decline&form=overtime&_token='+ overtimeData[overtime]._token,
					more: base_url + '/approvals/overtime'
				}
			
				let primaryApprover = {}
				if(overtimeData[overtime].primary && overtimeData[overtime].primary.email){
					primaryApprover = {
						first_name: overtimeData[overtime].primary.first_name,
						email: overtimeData[overtime].primary.email,
					}
				} else {
					primaryApprover = {
						first_name: overtimeData[overtime].backup.first_name,
						email: overtimeData[overtime].backup.email,
					}
				}
				let emailInfo = {
					applicant: applicant,
					formInfo: formInfo,
					btnLink: btnLink,
					primaryApprover: primaryApprover
				}

				overtimeDataEmailContentList.push(emailInfo)
			}
			MailHelper.notify_approver_batch(subject, overtimeDataEmailContentList);
		});
	}

	this.dispute_batch = function(){
		let base_url = $env.parsed.APP_URL
		let whereUser = {}
		whereUser.$or = [
			{
				primary_status: 1
			},{
				backup_status: 1
			}
		]

		DisputeModel.findAll({
			where: whereUser,
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
			],
			order: [
				['user_id', 'asc']
			],
			
		}).then(function(data){
			disputeData = data;
			
			let subject = 'Dispute';
			let disputeDataEmailContentList = [];
			
			for(dispute in disputeData) {
				
				let applicant = disputeData[dispute].applicant.first_name +' '+ disputeData[dispute].applicant.last_name;
				let from = new Date(disputeData[dispute].start_date +' '+ disputeData[dispute].start_time);
				let to = new Date(disputeData[dispute].end_date +' '+ disputeData[dispute].end_time);
				let type = ``;
				let label = ``;
				if(disputeData[dispute].type == 1){
					label = `<small><strong>No. of hours</strong></small> <p style="margin-top: 0">`+ disputeData[dispute].hour +` hour(s)</p>`;
					type = `Rest Day Pay`;
				}else if(disputeData[dispute].type == 2){
					label = `<small><strong>No. of hours</strong></small> <p style="margin-top: 0">`+ disputeData[dispute].hour +` hour(s)</p>`;
					type = `Overtime`;
				}else if(disputeData[dispute].type == 3){
					label = `<small><strong>No. of days</strong></small> <p style="margin-top: 0">`+ disputeData[dispute].hour +` day(s)</p>`;
					type = `Leave`;
				}else if(disputeData[dispute].type == 4){
					type = `No Time in / Time out`;
				}
				let formInfo = `
				<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
					<div>
						<small><strong>Applicant</strong></small>
						<p style="margin-top: 0">`+ applicant +`</p>
					</div>
					<div>
						<small><strong>Type</strong></small>
						<p style="margin-top: 0">`+ type +`</p>
					</div>
					<div>
						`+ label +`
					</div>
					<div>
						<small><strong>Note</strong></small>
						<p style="margin-top: 0">`+ disputeData[dispute].note +`</p>
					</div>
				</div>
				`;
				let btnLink = {
					approve: base_url + '/approvals/update?status=approve&form=dispute&_token='+ disputeData[dispute]._token,
					decline: base_url + '/approvals/update?status=decline&form=dispute&_token='+ disputeData[dispute]._token,
					more: base_url + '/approvals/dispute'
				}
			
				let primaryApprover = {}
				if(disputeData[dispute].primary && disputeData[dispute].primary.email){
					primaryApprover = {
						first_name: disputeData[dispute].primary.first_name,
						email: disputeData[dispute].primary.email,
					}
				} else {
					primaryApprover = {
						first_name: disputeData[dispute].backup.first_name,
						email: disputeData[dispute].backup.email,
					}
				}
				let emailInfo = {
					applicant: applicant,
					formInfo: formInfo,
					btnLink: btnLink,
					primaryApprover: primaryApprover
				}

				disputeDataEmailContentList.push(emailInfo)
			}
			MailHelper.notify_approver_batch(subject, disputeDataEmailContentList);
		});
	}

	this.leave_batch = function(){
		let base_url = $env.parsed.APP_URL
		let whereUser = {}
		whereUser.$or = [
			{
				primary_status: 1
			},{
				backup_status: 1
			}
		]

		LeavesModel.findAll({
			where: whereUser,
			include: [
				{
					model: UsersModel,
					as: 'primary',
					attributes: ['id', 'first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'backup',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: UsersModel,
					as: 'applicant',
					attributes: ['id','first_name', 'last_name', 'email']
				},
				{
					model: LeavePolicyModel,
					attributes: ['name']
				}
			],
			order: [
				['user_id', 'asc']
			],
			
		}).then(function(data){
			leavesData = data;
			
			let subject = 'Leave';
			let leavesDataEmailContentList = [];
			
			for(leaves in leavesData) {
								
				let applicant = leavesData[leaves].applicant.first_name +' '+ leavesData[leaves].applicant.last_name;
				let from = new Date(leavesData[leaves].start_date);
				let to = new Date(leavesData[leaves].end_date);
				let credit = leavesData[leaves].credit == 1 ? 'With Pay':'Without Pay';
				let formInfo = `
				<div style="border: #e0e0e0 dashed 1px; padding: 25px; font-size: 13px">
					<div>
						<small><strong>Applicant</strong></small>
						<p style="margin-top: 0">`+ applicant +`</p>
					</div>
					<div>
						<small><strong>Type</strong></small>
						<p style="margin-top: 0">`+ leavesData[leaves].leave_policy.name +`</p>
					</div>
					<div>
						<small><strong>Credit</strong></small>
						<p style="margin-top: 0">`+ credit +`</p>
					</div>
					<div>
						<small><strong>Number of day(s)</strong></small>
						<p style="margin-top: 0">`+ leavesData[leaves].no_of_days +` day(s)</p>
					</div>
					<div>
						<small><strong>From</strong></small>
						<p style="margin-top: 0">`+ moment(from).format('LL') +`</p>
					</div>
					<div>
						<small><strong>To</strong></small>
						<p style="margin-top: 0">`+ moment(to).format('LL') +`</p>
					</div>
					<div>
						<small><strong>Reason</strong></small>
						<p style="margin-top: 0">`+ leavesData[leaves].reason +`</p>
					</div>
				</div>
				`;
				let btnLink = {
					approve: base_url + '/approvals/update?status=approve&form=leave&_token='+ leavesData[leaves]._token,
					decline: base_url + '/approvals/update?status=decline&form=leave&_token='+ leavesData[leaves]._token,
					more: base_url + '/approvals/leave'
				}
			
				let primaryApprover = {}
				if(leavesData[leaves].primary && leavesData[leaves].primary.email){
					primaryApprover = {
						first_name: leavesData[leaves].primary.first_name,
						email: leavesData[leaves].primary.email,
					}
				} else {
					primaryApprover = {
						first_name: leavesData[leaves].backup.first_name,
						email: leavesData[leaves].backup.email,
					}
				}
				let emailInfo = {
					applicant: applicant,
					formInfo: formInfo,
					btnLink: btnLink,
					primaryApprover: primaryApprover
				}

				leavesDataEmailContentList.push(emailInfo)
			}
			MailHelper.notify_approver_batch(subject, leavesDataEmailContentList);
		});
	}
}

module.exports = new PrepareMail();
