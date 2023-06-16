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
const currentTime 	= moment().format('YYYY-MM-DD HH:mm:ss');
const scheduled 	= $env.parsed.APP_ENV == 'production' ? true : false;

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
cron.schedule('0 */1 * * *', () => {
	WorkShift.execute();
},{
	scheduled: true
});


cron.schedule('0 */15 * * * *', () => {
	console.log('run biometric');
  	Biometric.execute();
},{
	scheduled: true
});


//15mins
cron.schedule('0 */15 * * * *', () => {
  	AttendanceHelper.proccess('biometric');
},{
	scheduled: true
});

//30mins
cron.schedule('0 */30 * * * *', () => {
  	DTR.proccess();
  	Holiday.proccess();
},{
	scheduled: true
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