const cron      = require('node-cron');
const $env      = require('dotenv').config();
const moment      = require('moment-timezone');
  moment.tz.setDefault('Asia/Manila');
const fs          = require('fs');
//Tasks
const LeaveReset  = require('./LeaveReset');
const MySQLDump   = require('./MySQLDump');
const LoanPayment   = require('./LoanPayment');
const WorkShift   = require('./WorkShift');
const Biometric   = require('./Biometric');
const DTR       = require('./DTR'); 
const Holiday     = require('./Holiday');   
const AttendanceHelper= require('../Helper/AttendanceHelper');
const TSSHelper     = require('../Helper/TSSHelper');
const TSSDataHelper = require('../Helper/TSSDataHelper');
const OvertimeHelper= require('../Helper/OvertimeHelper');
const currentTime   = moment().format('YYYY-MM-DD HH:mm:ss');
const PrepareMail = require('../Helper/PrepareMail');
const CronJobHelper = require('../Helper/CronJobHelper');
const scheduled   = $env.parsed.CRON;

// console.log(scheduled);
/*
|------------------------------------------------------------------
| At minute 0 past every 12th hour.
|------------------------------------------------------------------
*/
// cron.schedule('0 1 * * *', () => {
//    MySQLDump.backup();
//    let fileTxt  = currentTime + ', BACKUP, Database backup created! \n';
//    createLog(fileTxt);
// },{
//  scheduled: scheduled
// });


/*
|------------------------------------------------------------------
| At 00:00.
|------------------------------------------------------------------
*/
// cron.schedule('0 0 * * *', () => {
//  LeaveReset.reset();
//  let fileTxt  = currentTime + ', LEAVE, Leave credit created! \n';
//  createLog(fileTxt);
// },{
//  scheduled: scheduled
// });

//Reset every Year
// cron.schedule('0 0 1 1 *', () => {
// // cron.schedule('*/15 * * * * *', () => {
//  LeaveReset.reset();
//  let fileTxt  = currentTime + ', LEAVE, Leave credit created! \n';
//  createLog(fileTxt);
// },{
//  scheduled: true
// });
/*
|------------------------------------------------------------------
| At minute 0 past every 6th hour.
|------------------------------------------------------------------
*/
// cron.schedule('0 */6 * * *', () => {
//  LoanPayment.execute();
//  let fileTxt  = currentTime + ', LOAN, Loan created! \n';
//  createLog(fileTxt);
// },{
//  scheduled: scheduled
// });



/*
|------------------------------------------------------------------
| At minute 0 past every 1 hour.
|------------------------------------------------------------------
*/
// cron.schedule('0 0 */1 * * *', () => {
//  WorkShift.execute();
// },{
//  scheduled: scheduled
// });

// /*
// |------------------------------------------------------------------
// | At minute 0 past every 1 hour.
// |------------------------------------------------------------------
// */
// cron.schedule('0 0 */1 * * *', () => {
//    Biometric.execute();
// },{
//  scheduled: scheduled
// });

// //15mins
// cron.schedule('0 */15 * * * *', () => {
//    AttendanceHelper.proccess('biometric');
//    AttendanceHelper.proccess('csv');
//    OvertimeHelper.process();
//    // Execute After 2 minutes
//    setTimeout(function(){
//      TSSDataHelper.process();
//      TSSHelper.process();
//    }, 120000);
// },{
//  scheduled: scheduled
// });

// //30mins
// cron.schedule('0 */15 * * * *', () => {
//    // DTR.proccess();
//    Holiday.proccess();
// },{
//  scheduled: scheduled
// });


// cron.schedule('0 */15 * * * *', () => {
//  // TSSDataHelper.process();
//    // TSSHelper.process();
// },{
//  scheduled: scheduled
// });


// /*
// * Create Schedule log
// * for monitoring purposes
// */
// const createLog = function(fileTxt){
//  let fileName = moment().format('MM-YYYY') + '.txt';
//  let filePath = './assets/logs/schedule/';
//  fs.appendFile(filePath + fileName, fileTxt, function (err) {
//    if (err){
//        console.log('Failed!');
//    }
//  });
// }

// /*
// |------------------------------------------------------
// | Run Every 7am every day
// |------------------------------------------------------
// */

// cron.schedule("0 0 7 * * *", function() {
//  PrepareMail.business_trip_batch();
//  PrepareMail.undertime_batch();
//  PrepareMail.dispute_batch();
//  PrepareMail.overtime_batch();
//  PrepareMail.leave_batch();
// });


// Run at 11:00 PM
//cron.schedule('0 0 23 * * *', async () => {
//  let cron_id = await CronJobHelper.create();
//  AttendanceHelper.proccess('biometric');
//  setTimeout(function(){
//      AttendanceHelper.proccess('csv');
//    }, 120000);   // after 2 mins
//    
//  setTimeout(function(){
//      OvertimeHelper.process();
//    }, 300000);     // after 5 mins
  
cron.schedule('0 50 */4 * * *', () => {
  WorkShift.execute();
},{
  scheduled: scheduled
});

/*
|------------------------------------------------------------------
| At minute 0 past every 1 hour.
|------------------------------------------------------------------
*/
// Run every 6 hours
cron.schedule('0 0 */6 * * *', () => {
    Biometric.execute();
},{
  scheduled: scheduled
});

// Run every 11 PM
cron.schedule('0 20 23 * * *', () => {
    let cron_id = CronJobHelper.create();
    AttendanceHelper.proccess('biometric');

    // // Execute after 3 minutes
    setTimeout(function(){
      OvertimeHelper.process();
    }, 180000);

    // Execute after 4 minutes
    setTimeout(function(){
      try {
        TSSDataHelper.process();
      } catch (err){
        console.log(err.message);
      }
    }, 240000);

    // Execute After 6 minutes
    setTimeout(function(){
      try {
        TSSHelper.process();
        CronJobHelper.update(cron_id, 1);
      } catch (err){
        console.log(err.message);
      }
     }, 360000);

},{
  scheduled: scheduled
});

// Set the cron process failed if not finished above
cron.schedule('0 50 23 * * *', () => {
  CronJobHelper.update_processing_to_failed();
},{
  scheduled: scheduled
});

// Run every 2 AM
cron.schedule('0 20 2 * * *', () => {
    let cron_id = CronJobHelper.create();
    AttendanceHelper.proccess('biometric');

    // // Execute after 3 minutes
    setTimeout(function(){
      OvertimeHelper.process();
    }, 180000);

    // Execute after 4 minutes
    setTimeout(function(){
      try {
        TSSDataHelper.process();
      } catch (err){
        console.log(err.message);
      }
    }, 240000);

    // Execute After 6 minutes
    setTimeout(function(){
      try {
        TSSHelper.process();
        CronJobHelper.update(cron_id, 1);
      } catch (err){
        console.log(err.message);
      }
     }, 360000);

},{
  scheduled: scheduled
});

// Set the cron process failed if not finished above
cron.schedule('0 50 2 * * *', () => {
  CronJobHelper.update_processing_to_failed();
},{
  scheduled: scheduled
});


// Every 6 hours
cron.schedule('0 15 */6 * * *', () => {
    Holiday.proccess();
},{
  scheduled: scheduled
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
