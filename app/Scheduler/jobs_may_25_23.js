const cron 			= require('node-cron');
const $env 			= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const fs         	= require('fs');
//Tasks
const LeaveReset 	= require('./LeaveReset');
const MySQLDump		= require('./MySQLDump');
const LoanPayment 	= require('./LoanPayment');
const WorkShift		= require('./WorkShift');
const Biometric		= require('./Biometric');
const DTR 			= require('./DTR');	
const Holiday 		= require('./Holiday');		
const AttendanceHelper= require('../Helper/AttendanceHelper');
const TSSHelper     = require('../Helper/TSSHelper');
const TSSDataHelper = require('../Helper/TSSDataHelper');
const OvertimeHelper= require('../Helper/OvertimeHelper');
const currentTime 	= moment().format('YYYY-MM-DD HH:mm:ss');
const PrepareMail = require('../Helper/PrepareMail');
const CronJobHelper = require('../Helper/CronJobHelper');
const DTSReprocessHelper = require('../Helper/DTSReprocessHelper');

const scheduled 	= $env.parsed.CRON;

const {
	CronJobModel
} = require('../../config/Sequelize');

// console.log(scheduled);
/*
|------------------------------------------------------------------
| At minute 0 past every 12th hour.
|------------------------------------------------------------------
*/
// cron.schedule('0 1 * * *', () => {
//   	MySQLDump.backup();
//   	let fileTxt  = currentTime + ', BACKUP, Database backup created! \n';
//   	createLog(fileTxt);
// },{
// 	scheduled: scheduled
// });


/*
|------------------------------------------------------------------
| At 00:00.
|------------------------------------------------------------------
*/
// cron.schedule('0 0 * * *', () => {
// 	LeaveReset.reset();
// 	let fileTxt  = currentTime + ', LEAVE, Leave credit created! \n';
// 	createLog(fileTxt);
// },{
// 	scheduled: scheduled
// });

//Reset every Year
// cron.schedule('0 0 1 1 *', () => {
// // cron.schedule('*/15 * * * * *', () => {
// 	LeaveReset.reset();
// 	let fileTxt  = currentTime + ', LEAVE, Leave credit created! \n';
// 	createLog(fileTxt);
// },{
// 	scheduled: true
// });
/*
|------------------------------------------------------------------
| At minute 0 past every 6th hour.
|------------------------------------------------------------------
*/
// cron.schedule('0 */6 * * *', () => {
// 	LoanPayment.execute();
// 	let fileTxt  = currentTime + ', LOAN, Loan created! \n';
// 	createLog(fileTxt);
// },{
// 	scheduled: scheduled
// });



/*
|------------------------------------------------------------------
| At minute 0 past every 1 hour.
|------------------------------------------------------------------
*/
cron.schedule('0 50 */4 * * *', () => {
	WorkShift.execute();
},{
	scheduled: false
});

// /*
// |------------------------------------------------------------------
// | At minute 0 past every 1 hour.
// |------------------------------------------------------------------
// */
cron.schedule('0 0 */6 * * *', () => {
  	Biometric.execute();
},{
	scheduled: false
});

// //15mins
// cron.schedule('0 */15 * * * *', () => {
//   	AttendanceHelper.proccess('biometric');
//   	AttendanceHelper.proccess('csv');
//   	OvertimeHelper.process();
//   	// Execute After 2 minutes
//   	setTimeout(function(){
//   		TSSDataHelper.process();
//   		TSSHelper.process();
//   	}, 120000);
// },{
// 	scheduled: scheduled
// });

// //30mins
// cron.schedule('0 */15 * * * *', () => {
//   	// DTR.proccess();
//   	Holiday.proccess();
// },{
// 	scheduled: scheduled
// });


// cron.schedule('0 */15 * * * *', () => {
// 	// TSSDataHelper.process();
//   	// TSSHelper.process();
// },{
// 	scheduled: scheduled
// });


// /*
// * Create Schedule log
// * for monitoring purposes
// */
// const createLog = function(fileTxt){
// 	let fileName = moment().format('MM-YYYY') + '.txt';
// 	let filePath = './assets/logs/schedule/';
// 	fs.appendFile(filePath + fileName, fileTxt, function (err) {
// 		if (err){
// 		  	console.log('Failed!');
// 		}
// 	});
// }

// /*
// |------------------------------------------------------
// | Run Every 7am every day
// |------------------------------------------------------
// */

// cron.schedule("0 0 7 * * *", function() {
// 	PrepareMail.business_trip_batch();
// 	PrepareMail.undertime_batch();
// 	PrepareMail.dispute_batch();
// 	PrepareMail.overtime_batch();
// 	PrepareMail.leave_batch();
// });


// Run at 11:00 PM
cron.schedule('0 15 23 * * *', () => {
    var datetime = moment().format('YYYY-MM-DD HH:mm:ss');
    DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;
    START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
    
    let reqData = {
        datetime_initiated: datetime,
        target_date: START_DATE,
        status: 4
    }
    CronJobModel.create(reqData).then(async function(data){
		cron_id = data.id;

		AttendanceHelper.proccess('biometric');
		// setTimeout(function(){
		// 		AttendanceHelper.proccess('csv');
		// 	}, 120000);		// after 2 mins
		
		setTimeout(function(){
			OvertimeHelper.process();
		}, 300000);			// after 5 mins
		
		setTimeout(function(){
			TSSDataHelper.process();
		}, 600000);			// after 10 mins
		
		setTimeout(function(){
			TSSHelper.process();
			CronJobHelper.update(cron_id, 1);
		}, 900000);			// after 15 mins
	});
},{
	scheduled: false
});

// Run at 11:20 PM to set status all processing to failed
cron.schedule('0 35 23 * * *', () => {
	CronJobHelper.update_processing_to_failed();
},{
	scheduled: scheduled
});

// Run at 2 AM - test
cron.schedule('0 20 2 * * *', () => {
    var datetime = moment().format('YYYY-MM-DD HH:mm:ss');
    DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;
    START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
    
    let reqData = {
        datetime_initiated: datetime,
        target_date: START_DATE,
        status: 4
    }
    CronJobModel.create(reqData).then(async function(data){
		cron_id = data.id;

		AttendanceHelper.proccess('biometric');
		// setTimeout(function(){
		// 		AttendanceHelper.proccess('csv');
		// 	}, 120000);		// after 2 mins
		
		setTimeout(function(){
			OvertimeHelper.process();
		}, 300000);			// after 5 mins
		
		setTimeout(function(){
			TSSDataHelper.process();
		}, 600000);			// after 10 mins
		
		setTimeout(function(){
			TSSHelper.process();
			CronJobHelper.update(cron_id, 1);
		}, 900000);			// after 15 mins
	});
},{
	scheduled: false
});

// Run at 3 AM - test
cron.schedule('0 20 3 * * *', () => {

	let targetDate = '2022-08-16';

	AttendanceHelper.proccess2('biometric',targetDate);

	setTimeout(function(){
		OvertimeHelper.process(targetDate);
	}, 300000);			// after 5 mins
	
	setTimeout(function(){
		TSSDataHelper.process(targetDate);
	}, 600000);			// after 10 mins
	
	setTimeout(function(){
		TSSHelper.process(targetDate);
	}, 900000);			// after 15 mins
},{
	scheduled: false
});

// Run at 4 AM - test
cron.schedule('0 20 4 * * *', () => {

	let targetDate = '2022-08-17';

	AttendanceHelper.proccess2('biometric',targetDate);

	setTimeout(function(){
		OvertimeHelper.process(targetDate);
	}, 300000);			// after 5 mins
	
	setTimeout(function(){
		TSSDataHelper.process(targetDate);
	}, 600000);			// after 10 mins
	
	setTimeout(function(){
		TSSHelper.process(targetDate);
	}, 900000);			// after 15 mins
},{
	scheduled: false
});

// Run at 5 AM - test
cron.schedule('0 06 8 * * *', () => {

	let targetDate = '2022-08-11';

	AttendanceHelper.proccess2('biometric',targetDate);
	
},{
	scheduled: false
});

//// ---
cron.schedule('0 1 15 * * *', () => {
	let targetDate = '2022-08-21';
	DTSReprocessHelper.process4(targetDate);
},{
	scheduled: false
});
cron.schedule('0 5 15 * * *', () => {
	let targetDate = '2022-08-22';
	DTSReprocessHelper.process4(targetDate);
},{
	scheduled: false
});
cron.schedule('0 10 15 * * *', () => {
	let targetDate = '2022-08-23';
	DTSReprocessHelper.process4(targetDate);
},{
	scheduled: false
});
cron.schedule('0 15 15 * * *', () => {
	let targetDate = '2022-08-24';
	DTSReprocessHelper.process4(targetDate);
},{
	scheduled: false
});
cron.schedule('0 20 15 * * *', () => {
	let targetDate = '2022-08-25';
	DTSReprocessHelper.process4(targetDate);
},{
	scheduled: true
});
cron.schedule('0 25 15 * * *', () => {
	let targetDate = '2022-08-11';
	DTSReprocessHelper.process4(targetDate);
},{
	scheduled: false
});

//// ---


// Run at 02:20 AM to set status all processing to failed
cron.schedule('0 50 2 * * *', () => {
	CronJobHelper.update_processing_to_failed();
},{
	scheduled: false
});

// Every 6 hours
cron.schedule('0 15 */6 * * *', () => {
    Holiday.proccess();
},{
  scheduled: false
});

/*
* Create Schedule log
* for monitoring purposes
*/
const createLog = function(fileTxt){
  let fileName = moment().format('MM-YYYY') + '.txt';
  let filePath = './assets/logs/schedule/';
  fs.appendFile(filePath + fileName, fileTxt, function (err) {
    if (err){
        console.log('Failed!');
    }
  });
}

/*
|------------------------------------------------------
| Run Every 7am every day
|------------------------------------------------------
*/

// cron.schedule("0 0 7 * * *", function() {
//  PrepareMail.business_trip_batch();
//  PrepareMail.undertime_batch();
//  PrepareMail.dispute_batch();
//  PrepareMail.overtime_batch();
//  PrepareMail.leave_batch();
// });
