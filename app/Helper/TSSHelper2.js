const moment     	= require('moment-timezone');
const $env 	= require('dotenv').config();
const { 
	Op,
	UsersModel,
	ShiftsModel,
	EmploymentsModel,
	TSS,
	TSSData,
	OvertimesModel,
	UndertimeModel,
	HolidaysModel,
	LeavesModel,
	LeaveDateModel,
	LeavePolicyModel,
	BiometricLog,
	BiometricNumberModel,
	BiometricModel,
	ConfigModel,
	BusinessTripsModel,
	BusinessTripDate
} = require('../../config/Sequelize');

let config = null;
let holidays = null;
let overtimes = null;
let shift = null;
let shifts = null;
let actualShifts = [];
let leaves = [];
let business_trips = [];

exports.process = function(target_date = null, user_id = null){
	console.log("Proccessing TSS Helper")
	let DATE_DIFF = null;
	let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
	let START_DATE = null;
	let END_DATE = null;

	if(target_date != null) {
		START_DATE = moment(target_date).format('YYYY-MM-DD');
		END_DATE = moment(target_date).add(Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	} else {
		DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

		START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
		END_DATE = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	}
	console.log(START_DATE + ' --- ' + END_DATE);
	let where_shift = {}
	let where_holiday = {}
	let where_overtime = {}
	let where_leave = {}
	let where_business = {}

	where_shift.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}

	where_holiday.status = 1
	where_holiday.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}
	
	where_overtime.primary_status = 2
	where_overtime.start_date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}
	
	where_leave.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}

	where_business.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}

	if(user_id != null) {
		where_shift.user_id = user_id
		where_overtime.user_id = user_id
		where_leave.user_id = user_id
		where_business.user_id = user_id
	}

	ConfigModel.findOne({
		where: {
			id: 1
		},
		raw: true
	}).then(data=>{
		config = data;
		config = config && config.json ? JSON.parse(config.json) : null;
		return ShiftsModel.findAll({
			where: where_shift,
			include: [
				{
					model: OvertimesModel,
					as: 'ot'
				}
			],
			raw: false
		});
	}).then(data=>{
		shift = data;
		shifts = shift;
		return HolidaysModel.findAll({
			where: where_holiday,
			raw: true
		});
		
	}).then(data=>{
		holidays = data;
		return OvertimesModel.findAll({
			where: where_overtime,
			raw: true
		});
		
	}).then(data=>{
		overtimes = data;
		return LeaveDateModel.findAll({
			where: where_leave
		});
		
	}).then(data=>{
		leaves = data;
		return BusinessTripDate.findAll({
			where: where_business
		});
		
	}).then(data=>{
		business_trips = data;
		if(shift && shift.length){
			for(let i in shift){
				let date = shift[i].date;
				let check_in = shift[i].check_in ? date +' '+moment(shift[i].check_in).utc().format('HH:mm:ss') : null;
				let check_out = shift[i].check_out ? date +' '+moment(shift[i].check_out).utc().format('HH:mm:ss') : null;
					check_out = check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD') : moment(check_out).format('YYYY-MM-DD');
				actualShifts.push({
					id: shift[i].id,
					date: check_out,
					user_id: shift[i].user_id
				});

				setTssData(shift[i]);
				//setOvertime(shift[i]);
			}
		}
		if(overtimes && overtimes.length){
			for(let i in overtimes){
				Overtime(overtimes[i]);
			}
		}
	});
	
}

exports.process2 = function(target_date = null, user_ids = null){
	console.log("Proccessing TSS Helper")
	let DATE_DIFF = null;
	let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
	let START_DATE = null;
	let END_DATE = null;

	if(target_date != null) {
		START_DATE = moment(target_date).format('YYYY-MM-DD');
		END_DATE = moment(target_date).add(Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	} else {
		DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

		START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
		END_DATE = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	}
	console.log(START_DATE + ' --- ' + END_DATE);
	let where_shift = {}
	let where_holiday = {}
	let where_overtime = {}
	let where_leave = {}
	let where_business = {}

	where_shift.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}

	where_holiday.status = 1
	where_holiday.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}
	
	where_overtime.primary_status = 2
	where_overtime.start_date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}
	
	where_leave.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}

	where_business.date = {
		[Op.gte]: START_DATE,
		[Op.lte]: END_DATE
	}

	if(user_ids && user_ids.length) {
		where_shift.user_id = {[Op.in]: user_ids};
		where_overtime.user_id = {[Op.in]: user_ids};
		where_leave.user_id = {[Op.in]: user_ids};
		where_business.user_id ={[Op.in]: user_ids};
	}

	ConfigModel.findOne({
		where: {
			id: 1
		},
		raw: true
	}).then(data=>{
		config = data;
		config = config && config.json ? JSON.parse(config.json) : null;
		return ShiftsModel.findAll({
			where: where_shift,
			include: [
				{
					model: OvertimesModel,
					as: 'ot'
				}
			],
			raw: false
		});
	}).then(data=>{
		shift = data;
		shifts = shift;
		return HolidaysModel.findAll({
			where: where_holiday,
			raw: true
		});
		
	}).then(data=>{
		holidays = data;
		return OvertimesModel.findAll({
			where: where_overtime,
			raw: true
		});
		
	}).then(data=>{
		overtimes = data;
		return LeaveDateModel.findAll({
			where: where_leave
		});
		
	}).then(data=>{
		leaves = data;
		return BusinessTripDate.findAll({
			where: where_business
		});
		
	}).then(data=>{
		business_trips = data;
		if(shift && shift.length){
			for(let i in shift){
				let date = shift[i].date;
				let check_in = shift[i].check_in ? date +' '+moment(shift[i].check_in).utc().format('HH:mm:ss') : null;
				let check_out = shift[i].check_out ? date +' '+moment(shift[i].check_out).utc().format('HH:mm:ss') : null;
					check_out = check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD') : moment(check_out).format('YYYY-MM-DD');
				actualShifts.push({
					id: shift[i].id,
					date: check_out,
					user_id: shift[i].user_id
				});

				setTssData(shift[i]);
				//setOvertime(shift[i]);
			}
		}
		if(overtimes && overtimes.length){
			for(let i in overtimes){
				Overtime(overtimes[i]);
			}
		}
	});
	
}

const setOvertime = function(shift){

	let date = shift.date;
	// Shift in/out
	let check_in = shift.check_in ? date +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
	let check_out = shift.check_out ? date +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
	   check_out = check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : moment(check_out).format('YYYY-MM-DD HH:mm:ss');

	// Actual time-in/out
	let actual_check_in = shift.actual_check_in ? date +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
	let actual_check_out = shift.actual_check_out ? date +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
		actual_check_out = actual_check_in > actual_check_out ? moment(actual_check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : moment(actual_check_out).format('YYYY-MM-DD HH:mm:ss');

	let overtime = shift.ot;
	if(overtime && overtime.length){
		let OTHrs01 = 0;
		let OTHrs02 = 0;
		for(let i in overtime){
			let no_of_hours = parseFloat(overtime[i].no_of_hours).toFixed(2);
			let night_diff = parseFloat(overtime[i].night_diff).toFixed(2);
			let ot_hours = 0;
			let ot_mins = 0;
			let break_hours = overtime[i].break_hours ? overtime[i].break_hours : 0;

			// Check for actual time
			let ot_in = overtime[i].start_date +' '+moment(overtime[i].start_time).utc().format('HH:mm:ss');
			let ot_out = overtime[i].end_date +' '+moment(overtime[i].end_time).utc().format('HH:mm:ss');

			// if (shift.user_id == 159){
			// 	console.log(check_in + ' : ' + check_out + ' : ' + actual_check_in + ' : ' + actual_check_out + ' : ' + ot_in + ' : ' + ot_out);
			// }

			// Pre work OT
			if (ot_in < check_in && actual_check_in < check_in){
				if (ot_in < actual_check_in){	// Actual time in is later than OT request
					ot_hours = parseInt(moment(ot_out).diff(moment(actual_check_in), 'hours'));
					ot_mins = parseInt(moment(ot_out).diff(moment(actual_check_in), 'minutes')) - (ot_hours * 60);	
				} else {						// Actual time in is on or before OT request
					ot_hours = parseInt(moment(ot_out).diff(moment(ot_in), 'hours'));
					ot_mins = parseInt(moment(ot_out).diff(moment(ot_in), 'minutes')) - (ot_hours * 60);	
				}
				let cur_no_of_hours = parseFloat(ot_hours+(ot_mins/60));
				if (cur_no_of_hours < no_of_hours){
					no_of_hours = cur_no_of_hours;
				}
			}

			// Post work OT
			if (ot_out > check_out  && actual_check_out > check_out){
				if (ot_out > actual_check_out){	// Actual time out is before OT request
					ot_hours = parseInt(moment(actual_check_out).diff(moment(ot_in), 'hours'));
					ot_mins = parseInt(moment(actual_check_out).diff(moment(ot_in), 'minutes')) - (ot_hours * 60);	
				} else {						// Actual time out is after OT request
					ot_hours = parseInt(moment(ot_out).diff(moment(ot_in), 'hours'));
					ot_mins = parseInt(moment(ot_out).diff(moment(ot_in), 'minutes')) - (ot_hours * 60);	
				}
				let cur_no_of_hours = parseFloat(ot_hours+(ot_mins/60)).toFixed(2);
				if (cur_no_of_hours < no_of_hours){
					no_of_hours = cur_no_of_hours;
				}
			}

			OTHrs01 += no_of_hours;
			OTHrs02 += night_diff;
		}
		let reqData = {
			user_id: shift.user_id,
			date: shift.date,
		}
		if(OTHrs01 > 0){
			reqData.OTHrs01 = OTHrs01;
		}
		if(OTHrs02 > 0){
			reqData.OTHrs02 = OTHrs02;
		}
		// if(OTHrs01 > 0 && OTHrs02 > 0){
		// 	updateTssData(reqData);
		// }
		if(OTHrs01 > 0){
			// if (shift.user_id == 159){
			// 	console.log(shift.user_id + ' : ' + shift.date + ' : ' + OTHrs01);
			// }
			updateTssData(reqData);
		}

	}

// 	let reqData = {
// 				user_id: shift.user_id,
// 				date: shift.date,
// 				OTHrs01: OTHrs01 > 0 ? parseFloat(OTHrs01) : null
// 			}
// // nightDifferencial(shift.user_id, shift.date, start_date, end_date,'OTHrs02');
}

const Overtime = function(row){
	let user_id = row.user_id;
	let date = row.start_date;
	// if(user_id == 148){
	let start_date = date+' '+ moment(row.start_time).utc().format('HH:mm:ss');
	let end_date = date+' '+ moment(row.end_time).utc().format('HH:mm:ss');
	    end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;
	let break_hours = row.break_hours ? row.break_hours : 0;

	let search = actualShifts.filter(function(arr){
			return arr.date == date && arr.user_id == row.user_id
		})[0];
	//Regular Overtime
	if(search){
		let shift = shifts.filter(function(arr){
			return arr.id == search.id
		})[0];
		if(shift){
			regularOvertime(row, date, start_date, end_date, shift);
		}

	}else{ //Rest Day
		start_date = start_date;
		end_date = end_date;
		let actualIn = row.actual_check_in ? date+' '+moment(row.actual_check_in).utc().format('HH:mm:ss'):null;
		let actualOut = row.actual_check_out ? date+' '+moment(row.actual_check_out).utc().format('HH:mm:ss') : null;

		if(actualIn){
			start_date = start_date >= actualIn ? start_date : actualIn;
		}
		if(actualOut){
			actualOut = actualIn > actualOut ? moment(actualOut).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : actualOut;
			end_date = end_date < actualOut ? end_date : actualOut;
		}

		RestDayOvertime(row, user_id, date, start_date, end_date, break_hours);
	}
	// }
}

const regularOvertime = function(overtime, date, startdate, enddate, shift){
	// console.log(date, startdate, enddate);
	// if(shift.actual_check_in){
		let shiftDate = shift.date;
		let shiftIn = shiftDate+' '+moment(shift.check_in).utc().format('HH:mm:ss');
		let shiftOut = shiftDate+' '+moment(shift.check_out).utc().format('HH:mm:ss');
		let shiftActual = shift.actual_check_out ? shiftDate+' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
			if(shiftActual && shiftIn > shiftDate+' '+shiftActual){
				shiftActual = moment(shiftActual).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
			}
		let start_date = startdate >= shiftDate ? startdate : shiftDate;
		let end_date = enddate;
			end_date = shiftActual && shiftActual < end_date ? shiftActual : end_date;

		let shift_break = shift.break_hour ? shift.break_hour : 0;

		if(start_date && end_date){
			let OTHrs01 = parseInt(moment(end_date).diff(moment(start_date), 'hours'));
			let OTHrs01Mins = parseInt(moment(end_date).diff(moment(start_date), 'minutes')) - OTHrs01 * 60;
			// this.night_differencial(shift[i].id, start_date, end_date);
				OTHrs01 = OTHrs01  ? OTHrs01+'.'+OTHrs01Mins : null;
				OTHrs01 = OTHrs01 ? parseFloat(OTHrs01) : null;
			/*
			let reqData = {
				user_id: shift.user_id,
				date: shift.date,
				OTHrs01: OTHrs01 > 0 ? parseFloat(OTHrs01) : null
			}
			updateTssData(reqData);
			*/
			Holiday(shift.user_id, shift.date, start_date, end_date, 'overtime', shift_break);
			// nightDifferencial(shift.user_id, shift.date, start_date, end_date,'OTHrs02');
		}		
	// }
}

const RestDayOvertime = function(row, user_id, date, start_date, end_date, break_hours){
	let OTHrs03 = parseInt(moment(end_date).diff(moment(start_date), 'hours'));
	let OTHrs03Mins = parseInt(moment(end_date).diff(moment(start_date), 'minutes')) - OTHrs03 * 60;
	
	let current_shift = shifts.filter(function(arr){
		return arr.id == row.shift_id
	})[0];
	let shift_break =  0;

	if (current_shift && current_shift.break_hour){
		shift_break =  current_shift.break_hour ? current_shift.break_hour : 0;
	} else {
		shift_break = break_hours;
	}

	if(OTHrs03 >= 5 ){
		OTHrs03 = OTHrs03 - shift_break;
	}

	let reqData = {
		user_id: user_id,
		date: date,
		OTHrs03: OTHrs03 ? parseFloat(OTHrs03+'.'+OTHrs03Mins) : null,
		overtime_id: row.id,
		shift_id: row.shift_id,
	}
	updateTssData(reqData, 'overtime');
	nightDifferencial(user_id, date, start_date, end_date,'OTHrs13');
	Holiday(user_id, date, start_date, end_date, 'restday', shift_break);

}

const nightDifferencial = function(user_id, tss_date, start_date=null, end_date=null, column = null, holiday = null){
	
	// if(user_id == 149){
	let start_work = start_date;
	let end_work = end_date;

	let start_work_time = moment(start_work).format('HH:mm:ss');
	let end_work_time = moment(end_work).format('HH:mm:ss');
	let start_night = '22:00:00';
	let end_night = '06:00:00';
	let start = null;
	let end = null;
	let result = 0;
	
	if((start_work && end_work) && (Date.parse(start_work) < Date.parse(end_work))){
		if(start_work_time >= end_night && start_work_time < start_night){
			if(!(end_work_time >= end_night && end_work_time < start_night)){
				start = start_work;
				start = moment(start).format('YYYY-MM-DD')+' 22:00:00';
				// start.setHours(22);
				// start.setMinutes(00);
				// start.setSeconds(00);
				end   = end_work;
			}else{
				let checkStart = moment(start_work).format('YYYY-MM-DD');
				let checkEnd = moment(end_work).format('YYYY-MM-DD');
				if(checkStart != checkEnd){
					let diffStart = moment(checkStart);
					let diffEnd = moment(checkEnd);
					let duration = moment.duration(diffEnd.diff(diffStart));
						duration = duration.asDays();
					if(duration == 1){
						start = start_work;
						start = moment(start).format('YYYY-MM-DD')+' 22:00:00';
						// start.setHours(22);
						// start.setMinutes(00);
						// start.setSeconds(00);

						end   = end_work;
						end = moment(end).format('YYYY-MM-DD')+' 06:00:00';
						// end.setHours(06);
						// end.setMinutes(00);
						// end.setSeconds(00);
					}
				}
			}
			if(start && end){
				start = moment(start);
				end   = moment(end);
				let duration = moment.duration(end.diff(start));
				result = duration.asHours();
				result = result > 0 ? result : 0;
			}
		}else{
			start = start_work;
			end   = end_work;
			
			if(end_work_time >= end_night && end_work_time < start_night){
				end = moment(end).format('YYYY-MM-DD')+' 06:00:00';
				// end.setHours(06);
				// end.setMinutes(00);
				// end.setSeconds(00);
			}
			start = moment(start);
			end   = moment(end);
			// console.log(user_id, tss_date, start_work,end_work, start.format('YYYY-MM-DD HH:mm:ss'), end.format('YYYY-MM-DD HH:mm:ss'), end.diff(start, 'hours'));
			// console.log(end.diff(start, 'hours'));
			let duration = moment.duration(end.diff(start));
			result = duration.asHours();
			// console.log(result);
			result = result > 0 ? result : 0;
			if(start_work_time < end_night && end_work_time > start_night){
				result = result - 16;
			}
		}

		
	}
	result = parseInt(result) > 16 ? (parseInt(result) - 16) : result;

	let reqData = {
		user_id: user_id,
		date: tss_date,
	}
	// console.log(reqData,moment(start).format('YYYY-MM-DD HH:mm:ss'),moment(end).format('YYYY-MM-DD HH:mm:ss'), result, column);
	if(column){
		reqData[column] = result ? parseFloat(result) : null;
		updateTssData(reqData);
	}
	
	// }
}

const RegHrs = function(shift){
	//console.log("shift: ", shift)
	let date = shift.date;
	let prevDate = moment(date).subtract(1,'days').format('YYYY-MM-DD');
	let nextDate = moment(date).add(1,'days').format('YYYY-MM-DD');
	let check_in = shift.check_in ? date +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
	let check_out = shift.check_out ? date +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
	//	check_out = check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : check_out;
	let actual_check_in = shift.actual_check_in ? date +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
	let actual_check_out = shift.actual_check_out ? date +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;

	// Cases for previous date check in
	if (shift.shift_type == '10PM TO 7AM' || shift.shift_type == '1ST SHIFT (1AM-9AM)' || shift.shift_type == '1ST SHIFT (12:30AM - 8:30AM)' || shift.shift_type ==  '1ST SHIFT (12am-8am)' || shift.shift_type == '1st SHIFT' || shift.shift_type ==  '1st SHIFT GEO' || shift.shift_type ==  'LEVEL 6 1' || shift.shift_type ==  'Security 1' ){
		if (check_in && check_out && (check_in > check_out)){
			check_in = shift.check_in ? prevDate +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
			check_out = shift.check_out ? date +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
		}
		if (actual_check_in && actual_check_out && (actual_check_in > actual_check_out)){
			actual_check_in = shift.actual_check_in ? prevDate +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
			actual_check_out = shift.actual_check_out ? date +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
		}
	} else {
		if (check_in && check_out && (check_in > check_out)){
			check_in = shift.check_in ? date +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
			check_out = shift.check_out ? nextDate +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
		}
		if (actual_check_in && actual_check_out && (actual_check_in > actual_check_out)){
			actual_check_in = shift.actual_check_in ? date +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
			actual_check_out = shift.actual_check_out ? nextDate +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
		}
	}

	//console.log("check_in: " + check_in + " --- " + check_out);
	//console.log("actual_check_in: " + actual_check_in + " --- " + actual_check_out);

	let grace_period = 0;
	if(config && config.shift && config.shift.grace_period){
		grace_period = parseInt(config.shift.grace_period) + 1;	// Consider seconds after the grace period
	}

	let shift_break = shift.break_hour ? shift.break_hour : 0;

	let minusLate = 0;
	let LateHrs = 0;
	let UndertimeHrs = 0;

	// With log in and log out
	if(actual_check_in && actual_check_out){
		//let chINDiff = moment(check_in).diff(moment(actual_check_in), 'hours');
		//actual_check_in = actual_check_in < check_in && chINDiff > 4 ? moment(actual_check_in).add(1,'days').format('YYYY-MM-DD HH:mm:ss') :actual_check_in;
		//actual_check_out = actual_check_in > actual_check_out ? moment(actual_check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : actual_check_out;

		let start_date = check_in > actual_check_in ? check_in : actual_check_in;
		let end_date = check_out < actual_check_out ? check_out:actual_check_out;
		//	end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;

		LeaveDateModel.findOne({
			where:{
				user_id: shift.user_id,
				date: shift.date,

			},
			include:[
				{
					model: LeavesModel,
					include: [
						{
							model: LeavePolicyModel,
							attributes: ['id','code','name']
						}
					]
					// as: 'leave_data'
				}
			]
		}).then(data=>{
			leaveData = data;

			if(actual_check_in > check_in){
				LateHrs = moment(actual_check_in).diff(moment(check_in), 'minutes');

				minusLate = LateHrs - (LateHrs%15);
				if (LateHrs%15 > 0){
					minusLate = minusLate + 15;
				}
			}

			if(actual_check_out < check_out){
				UndertimeHrs = moment(check_out).diff(moment(actual_check_out), 'minutes');
			}

			if(LateHrs < grace_period){
				LateHrs = 0;
				minusLate = 0;
			}

			var duration = moment.duration(moment(check_out).diff(moment(check_in)));

			// let hours = parseInt(duration.asHours());
			let totalMinutes = parseInt(duration.asMinutes()) - (minusLate + UndertimeHrs);
			let hours = totalMinutes / 60;
			let break_hour = shift.break_hour ? shift.break_hour : 0;
			let rhours = Math.floor(hours) - break_hour;
			let minutes = (hours - rhours) * 60;
			let rminutes = Math.round(minutes);
			//let RegHrs = rhours+'.'+rminutes;
			let RegHrs = hours - break_hour;

			if(leaveData) {
				UndertimeHrs = 0
				LateHrs = 0;
			}

			let reqData = {
				Absent: null,
				user_id: shift.user_id,
				date: date,
				RegHrs: parseFloat(RegHrs),
				LateHrs: parseFloat(LateHrs),
				UndertimeHrs: parseFloat(UndertimeHrs)
			}
			//console.log("reqData ", reqData);
			updateTssData(reqData);
			if(minusLate > 0){
				start_date = moment(check_in).add(minusLate,'minutes').format('YYYY-MM-DD HH:mm:ss');
				// console.log(date, sDate);
			}
			// console.log(date, start_date, end_date);
			Holiday(shift.user_id, shift.date, start_date, end_date, 'normal', shift_break);//Holidays

			let hasOT = overtimes.filter(function(arr){
				return arr.user_id == shift.user_id && arr.start_date == shift.date
			});
			if(hasOT.length){
				hasOT = hasOT[0];
				if(hasOT.actual_check_out){
					let otEndDate = hasOT.end_date +' '+moment(hasOT.actual_check_out).utc().format('HH:mm:ss');
					end_date = otEndDate ? otEndDate : end_date;
				}
			}
			nightDifferencial(shift.user_id, shift.date, start_date, end_date,'NDHrs');
			if(leaveData) {
				Absent(shift, RegHrs);
			}
		})
	}else{
		if(!actual_check_in && !actual_check_out){ // Absent
			// check business trip
			let findTrip = business_trips.filter(function(arr){
				return arr.date == shift.date && arr.user_id == shift.user_id
			})[0];
			if(findTrip){
				let start_date = check_in;
				let end_date = check_out;
					end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;

				var duration = moment.duration(moment(check_out).diff(moment(check_in)));

				let totalMinutes = parseInt(duration.asMinutes()) - (minusLate + UndertimeHrs);
				let hours = totalMinutes / 60;
				let break_hour = shift.break_hour ? shift.break_hour : 0;
				
				let RegHrs = hours - break_hour;
				let reqData = {
					Absent: null,
					user_id: shift.user_id,
					date: date,
					RegHrs: parseFloat(RegHrs),
				}
				updateTssData(reqData);
				// console.log(date, start_date, end_date);
				Holiday(shift.user_id, shift.date, start_date, end_date, 'normal', shift_break);//Holidays

				nightDifferencial(shift.user_id, shift.date, start_date, end_date,'NDHrs');
			}else{
				Absent(shift, null);
			}		

		}else if(!actual_check_in && actual_check_out){ // No Login
			let findTrip = business_trips.filter(function(arr){
				return arr.date == shift.date && arr.user_id == shift.user_id
			})[0];
			if(findTrip){
				let start_date = check_in;
				let end_date = check_out;
					end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;

				var duration = moment.duration(moment(check_out).diff(moment(check_in)));

				let totalMinutes = parseInt(duration.asMinutes()) - (minusLate + UndertimeHrs);
				let hours = totalMinutes / 60;
				let break_hour = shift.break_hour ? shift.break_hour : 0;
				
				let RegHrs = hours - break_hour;
				let reqData = {
					Absent: null,
					user_id: shift.user_id,
					date: date,
					RegHrs: parseFloat(RegHrs),
				}
				updateTssData(reqData);
				Holiday(shift.user_id, shift.date, start_date, end_date, 'normal', shift_break);//Holidays

				nightDifferencial(shift.user_id, shift.date, start_date, end_date,'NDHrs');
			} else {
				// Undertime computation
				if(actual_check_out < check_out){
					UndertimeHrs = moment(check_out).diff(moment(actual_check_out), 'minutes');
				}

				noLogInOut(shift, LateHrs, UndertimeHrs);
				let regHrs = shift.shift_length && shift.shift_length > 4 ? Math.floor(shift.shift_length / 2) : null;
				
				if(regHrs){
					let start_date = check_in;
					let end_date = check_out < actual_check_out ? check_out:actual_check_out;
						end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;
						start_date = moment(end_date).subtract(regHrs,'hours').format('YYYY-MM-DD HH:mm:ss');
					Holiday(shift.user_id,shift.date, start_date, end_date, 'normal', shift_break);	//Holidays
					nightDifferencial(shift.user_id, shift.date, start_date, end_date,'NDHrs');
				}
			}
		}else if(actual_check_in && !actual_check_out){ // No Logout
			let findTrip = business_trips.filter(function(arr){
				return arr.date == shift.date && arr.user_id == shift.user_id
			})[0];
			if(findTrip){
				let chINDiff = moment(check_in).diff(moment(actual_check_in), 'hours');
				actual_check_in = check_in;
				actual_check_out = check_out;

				let start_date = check_in;
				let end_date = check_out;
					end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;


				var duration = moment.duration(moment(check_out).diff(moment(check_in)));

				// let hours = parseInt(duration.asHours());
				let totalMinutes = parseInt(duration.asMinutes()) - (minusLate + UndertimeHrs);
				let hours = totalMinutes / 60;
				let break_hour = shift.break_hour ? shift.break_hour : 0;
				let rhours = Math.floor(hours) - break_hour;
				let minutes = (hours - rhours) * 60;
				let rminutes = Math.round(minutes);
				//let RegHrs = rhours+'.'+rminutes;
				let RegHrs = hours - break_hour;
				let reqData = {
					Absent: null,
					user_id: shift.user_id,
					date: date,
					RegHrs: parseFloat(RegHrs),
				}
				updateTssData(reqData);
				// console.log(date, start_date, end_date);
				Holiday(shift.user_id, shift.date, start_date, end_date, 'normal', shift_break);//Holidays

				nightDifferencial(shift.user_id, shift.date, start_date, end_date,'NDHrs');
			} else {
			// Log in late computation
				if(actual_check_in > check_in){
					LateHrs = moment(actual_check_in).diff(moment(check_in), 'minutes');
				}
				if(LateHrs < grace_period){
					LateHrs = 0;
				}

				noLogInOut(shift, LateHrs, UndertimeHrs);
				let regHrs = shift.shift_length && shift.shift_length > 4 ? Math.floor(shift.shift_length / 2) : null;
				if(regHrs){
					let start_date = check_in > actual_check_in ? check_in:actual_check_in;
					let end_date = moment(start_date).add(regHrs,'hours').format('YYYY-MM-DD HH:mm:ss');
					let diff = moment(end_date).diff(moment(start_date), 'hours');
					Holiday(shift.user_id,shift.date, start_date, end_date, 'normal', shift_break);//Holidays
					nightDifferencial(shift.user_id, shift.date, start_date, end_date, 'NDHrs');
				}
			}
		}
	}
}

const Holiday = function(user_id, shift_date, start_date, end_date, type = null, break_hour){
	let holiday = holidays;
	if(holiday.length > 0) {
		// UsersModel.findOne({
		// 	where:{
		// 		id: user_id
		// 	},
		// 	attributes: ['id','first_name','last_name'],
		// 	raw: true
		// }).then(data=>{
		// 	user = data;
			if(user_id){
				EmploymentsModel.findOne({
					where:{
						user_id: user_id
					},
					order: [
						['id','desc']
					],
					limit: 1,
					raw: true
				}).then(data=>{
					employment = data;
					if(employment){
						let regularHoliday = 0;
						let specialHoliday = 0;
						//Same day shift holiday
						if(moment(start_date).format('YYYY-MM-DD') == moment(end_date).format('YYYY-MM-DD')){
							let date1 = moment(start_date).format('YYYY-MM-DD');
							let result = holiday.filter(function(arr){
								return arr.date == date1 && arr.location_id == employment.location_id
							});
							let regHrs = parseInt(moment(end_date).diff(moment(start_date), 'hours'));
							let regHrsMins = parseInt(moment(end_date).diff(moment(start_date), 'minutes')) - regHrs * 60;
								regHrsMins = Math.round((regHrsMins / 60) * 100);

							if(result && result.length){
								for(let i in result){
									if(result[i].type == 1){
										regularHoliday += parseFloat(regHrs+'.'+regHrsMins).toFixed(2);
										if(type == 'restday'){
											nightDifferencial(user_id, shift_date, start_date, end_date, 'OTHrs17');
										}else if(type == 'normal'){
											nightDifferencial(user_id, shift_date, start_date, end_date, 'OTHrs15');
										}
									}else{
										specialHoliday += parseFloat(regHrs+'.'+regHrsMins).toFixed(2);
										if(type == 'restday'){
											nightDifferencial(user_id, shift_date, start_date, end_date, 'OTHrs16');
										}else if(type == 'normal'){
											nightDifferencial(user_id, shift_date, start_date, end_date, 'OTHrs14');
										}
									}
								}
							}
							// console.log(type, shift_date, start_date, end_date);
						}else{//Diff shift day holiday
							let date1 = moment(start_date).format('YYYY-MM-DD');
							let date2 = moment(end_date).format('YYYY-MM-DD');

							let date1_result = holiday.filter(function(arr){
								return arr.date == date1 && arr.location_id == employment.location_id
							});
							let date2_result = holiday.filter(function(arr){
								return arr.date == date2 && arr.location_id == employment.location_id
							});
							//Shift IN
							let date1_start = start_date;
							let date1_end   = moment(start_date).format('YYYY-MM-DD')+' 23:59:59';
								date1_end   = moment(date1_end).add(1,'seconds').format('YYYY-MM-DD HH:mm:ss');
							let date1RegHrs = parseInt(moment(date1_end).diff(moment(date1_start), 'hours'));
							let date1RegHrsMins = parseInt(moment(end_date).diff(moment(start_date), 'minutes')) - date1RegHrs * 60;
								date1RegHrsMins = Math.round((date1RegHrsMins / 60) * 100);
							//Shift OUt
							let date2_start = moment(end_date).format('YYYY-MM-DD')+' 00:00:00';
							let date2_end   = end_date;
							let date2RegHrs = parseInt(moment(date2_end).diff(moment(date2_start), 'hours'));
							let date2RegHrsMins = parseInt(moment(end_date).diff(moment(start_date), 'minutes')) - date2RegHrs * 60;
								date2RegHrsMins = Math.round((date2RegHrsMins / 60) * 100);
							// let reqData = {
							// 	user_id: user_id,
							// 	date: shift_date,
							// 	OTHrs14: null,
							// 	OTHrs15: null,
							// }
							// updateTssData(reqData);
							if(date1_result && date1_result.length){
								for(let i in date1_result){
									if(date1_result[i].type == 1){
										regularHoliday += parseFloat(date1RegHrs+'.'+date1RegHrsMins).toFixed(2);
										if(type == 'restday'){
											nightDifferencial(user_id, shift_date, date1_start, date1_end, 'OTHrs17');
										}else if(type == 'normal'){
											// console.log(user_id, shift_date, start_date, end_date,'RegularHoliday','OTHrs15');
											
											nightDifferencial(user_id, shift_date, date1_start, date1_end, 'OTHrs15');
										}
									}else{
										specialHoliday += parseFloat(date1RegHrs+'.'+date1RegHrsMins).toFixed(2);
										if(type == 'restday'){
											nightDifferencial(user_id, shift_date, date1_start, date1_end, 'OTHrs16');
										}else if(type == 'normal'){
											// console.log(user_id, shift_date, start_date, end_date,'specialHoliday','OTHrs14' ,type);
											nightDifferencial(user_id, shift_date, date1_start, date1_end, 'OTHrs14');
										}
									}
								}

							}

							if(date2_result && date2_result.length){
								for(let i in date2_result){
									if(date2_result[i].type == 1){
										regularHoliday += parseFloat(date2RegHrs+'.'+date2RegHrsMins).toFixed(2);
										if(type == 'restday'){
											nightDifferencial(user_id, shift_date, date2_start, date2_end, 'OTHrs17');
										}else if(type == 'normal'){
											nightDifferencial(user_id, shift_date, date2_start, date2_end, 'OTHrs15');
										}
									}else{
										specialHoliday += parseFloat(date2RegHrs+'.'+date2RegHrsMins).toFixed(2);
										if(type == 'restday'){
											nightDifferencial(user_id, shift_date, date2_start, date2_end, 'OTHrs16');
										}else if(type == 'normal'){
											nightDifferencial(user_id, shift_date, date2_start, date2_end, 'OTHrs14');
										}
									}
								}
							}
							
						}
						let reqData = {
							user_id: user_id,
							date: shift_date,
							//LateHrs: 0,
							//UndertimeHrs: 0
						}
						if(type == 'normal'){
							reqData.OTHrs04 = specialHoliday > 0 ? parseFloat(specialHoliday) : null;
							reqData.OTHrs05 = regularHoliday > 0 ? parseFloat(regularHoliday) : null;
							if (reqData.OTHrs04 && reqData.OTHrs04 > 5){
								reqData.OTHrs04 = reqData.OTHrs04 - break_hour;
							}
							if (reqData.OTHrs05 && reqData.OTHrs05 > 5){
								reqData.OTHrs05 = reqData.OTHrs05 - break_hour;
							}
						}else if(type == 'restday'){
							reqData.OTHrs06 = specialHoliday > 0 ? parseFloat(specialHoliday) : null;
							reqData.OTHrs07 = regularHoliday > 0 ? parseFloat(regularHoliday) : null;
							if (reqData.OTHrs06 && reqData.OTHrs06 > 5){
								reqData.OTHrs06 = reqData.OTHrs06 - break_hour;
							}
							if (reqData.OTHrs07 && reqData.OTHrs07 > 5){
								reqData.OTHrs07 = reqData.OTHrs07 - break_hour;
							}
						}else if(type='overtime'){
							reqData.OTHrs09 = specialHoliday > 0 ? parseFloat(specialHoliday) : null;
							reqData.OTHrs10 = regularHoliday > 0 ? parseFloat(regularHoliday) : null;
							if (reqData.OTHrs09 && reqData.OTHrs09 > 5){
								reqData.OTHrs09 = reqData.OTHrs09 - break_hour;
							}
							if (reqData.OTHrs10 && reqData.OTHrs10 > 5){
								reqData.OTHrs10 = reqData.OTHrs10 - break_hour;
							}
						}
						updateTssData(reqData);
					}				
				});
			}
		//})
	}
}

const noLogInOut = function(shift, lateMins, utMins){
	let reqData = {
		user_id: shift.user_id,
		date: shift.date,
		LateHrs: 0,
	}
	if(shift.shift_length){
		reqData.RegHrs = shift.shift_length > 4 ? parseFloat(Math.floor(shift.shift_length / 2)) : null;
		reqData.Absent = shift.shift_length > 4 ? parseFloat(Math.floor(shift.shift_length / 2)) : parseFloat(4);
	}

	if (lateMins && lateMins > 0){
		reqData.LateHrs = lateMins;
		reqData.RegHrs = reqData.RegHrs - (lateMins/60);
	}

	if (utMins && utMins > 0){
		reqData.UndertimeHrs = utMins;
		reqData.RegHrs = reqData.RegHrs - (utMins/60);
	}
	updateTssData(reqData);
}

/*
* ABSENT
*/
const Absent = function(shift, RegHrsInput){
	LeaveDateModel.findOne({
		where:{
			user_id: shift.user_id,
			date: shift.date,

		},
		include:[
			{
				model: LeavesModel,
				include: [
					{
						model: LeavePolicyModel,
						attributes: ['id','code','name']
					}
				]
				// as: 'leave_data'
			}
		]
	}).then(data=>{
		leavesData = data;
		
		let actual_check_in = shift.actual_check_in
		let actual_check_out = shift.actual_check_out

		let brkhrs = shift.break_hour ? shift.break_hour : 0;
		let start_date = shift.date+' '+moment(shift.check_in).format('HH:mm:ss');
		let end_date = shift.date+' '+moment(shift.check_out).format('HH:mm:ss');
		    end_date = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;
		let Absent = moment(end_date).diff(moment(start_date), 'hours') - brkhrs;
		if (leavesData && leavesData.leave_duration !=0){
			Absent = 4;		// Half day leave
		}
		let reqData = {
			user_id: shift.user_id,
			date: shift.date,
			RegHrs: RegHrsInput ? parseFloat(RegHrsInput) : 0
		}
		//console.log('user: ' + shift.user_id + ' : ' + leave + ' : ' + shift.date);
		if(!leavesData){
			//reqData.Absent = Absent;
			if (Absent == null || isNaN(Absent)){
				reqData.Absent = 0;
			} else {
				reqData.Absent = Absent;
			}
		}else{
			let isApproved = leavesData.leave && leavesData.leave.primary_status == 2 ? true : false;
			let isPaid = leavesData.leave && leavesData.leave.credit == 1 && isApproved ? 'paid':'unpaid';
			if(actual_check_in == null && actual_check_out == null) {
				reqData.Absent = Absent;
			} else {
				reqData.Absent = isApproved ? null : Absent;
			}
			let leave_policy_code = leavesData.leave.leave_policy.code;
			//console.log('user: ' + shift.user_id + ' : ' + leave_policy_code);
			
			if(leave_policy_code == 'SL'){					// SL - Sick Leave
				if(isPaid == 'paid'){
					reqData.Leave01 = parseFloat(Absent);
				}else{
					reqData.UnpaidSL = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'EL'){			// EL - Emergency Leave
				if(isPaid == 'paid'){
					reqData.Leave02 = parseFloat(Absent);
				}else{
					reqData.UnpaidEL = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'VL'){			// VL - Vacation Leave
				if(isPaid == 'paid'){
					reqData.Leave03 = parseFloat(Absent);
				}else{
					reqData.UnpaidVL = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'ML'){			// ML - Maternity Leave
				if(isPaid == 'paid'){
					reqData.Leave04 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'PL'){			// Paternity Leave
				if(isPaid == 'paid'){
					reqData.Leave05 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'BL'){			// Bereavement Leave
				if(isPaid == 'paid'){
					reqData.Leave10 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'MML'){			// Miscarriage Leave
				if(isPaid == 'paid'){
					reqData.Leave11 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'SPL'){			// Solo Parent Leave
				if(isPaid == 'paid'){
					reqData.Leave08 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'SLWL'){			// Special Leave for Women
				if(isPaid == 'paid'){
					reqData.Leave12 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'VAWCL'){			// VAWCI Leave
				if(isPaid == 'paid'){
					reqData.Leave13 = parseFloat(Absent);
				}
			}else if(leave_policy_code == 'UL'){			// Union Leave
				if(isPaid == 'paid'){
					reqData.Leave11 = parseFloat(Absent);
				}
			}
		}

		updateTssData(reqData);
	})
}

const updateTssData = function(row, isOvertime = null){
	let where = {
		user_id: row.user_id,
		date: row.date,
	}
	if(isOvertime && row.shift_id){
		where.shift_id = row.shift_id;
	}
	TSSData.findOne({
		where: where
	}).then(data=>{
		tss = data;
		if(!tss){
			if(isOvertime){
				TSSData.create(row);
			}
		}else{
			TSSData.update(row,{
				where:{
					user_id: row.user_id,
					date: row.date,
				}
			});
		}
	});
}

const setTssData = function(shift){
	let reqData = {
		shift_id: shift.id,
		user_id: shift.user_id,
		date: shift.date,
	}
	TSSData.findOne({
		where: reqData
	}).then(data=>{
		tss = data;
		
		if(!tss){
			 TSSData.create(reqData).then(data=>{
				RegHrs(shift);
				setOvertime(shift);
			 });
		}else{
			reqData.LateHrs = null;
			reqData.UndertimeHrs = null;
			reqData.NDHrs = null;
			reqData.Absent = null;
			reqData.Leave01 = null;
			reqData.Leave02 = null;
			reqData.Leave03 = null;
			reqData.Leave04 = null;
			reqData.Leave05 = null;
			reqData.Leave06 = null;
			reqData.Leave07 = null;
			reqData.Leave08 = null;
			reqData.Leave09 = null;
			reqData.Leave10 = null;
			reqData.Leave11 = null;
			reqData.Leave12 = null;
			reqData.Leave13 = null;
			reqData.Leave14 = null;
			reqData.Leave15 = null;
			reqData.Leave16 = null;
			reqData.Leave17 = null;
			reqData.Leave18 = null;
			reqData.Leave19 = null;
			reqData.Leave20 = null;
			reqData.OTHrs01 = null;
			reqData.OTHrs02 = null;
			reqData.OTHrs03 = null;
			reqData.OTHrs04 = null;
			reqData.OTHrs05 = null;
			reqData.OTHrs06 = null;
			reqData.OTHrs07 = null;
			reqData.OTHrs08 = null;
			reqData.OTHrs09 = null;
			reqData.OTHrs10 = null;
			reqData.OTHrs11 = null;
			reqData.OTHrs12 = null;
			reqData.OTHrs13 = null;
			reqData.OTHrs14 = null;
			reqData.OTHrs15 = null;
			reqData.OTHrs16 = null;
			reqData.OTHrs17 = null;
			reqData.OTHrs18 = null;
			reqData.OTHrs19 = null;
			reqData.OTHrs20 = null;
			reqData.OTHrs21 = null;
			reqData.OTHrs22=null;
			reqData.OTHrs23=null;
			reqData.OTHrs24=null;
			reqData.OTHrs25=null;
			reqData.Rate=null;
			reqData.UnpaidRegHrs=null;
			reqData.UnpaidSL=null;
			reqData.UnpaidTaxSL=null;
			reqData.UnpaidVL = null;
			reqData.UnpaidTaxVL = null;
			reqData.UnpaidEL = null;
			reqData.EffectivityDate = null;
			reqData.EmpStatus = null;
			reqData.EffectivityDateResign = null;
			TSSData.update(reqData,{
				where:{
					id: tss.id
				}
			}).then(data=>{
				if(data){
					RegHrs(shift);
					setOvertime(shift);
				}
			});
		}
	});
}


/*
		reqData.RegHrs = null;
		reqData.LateHrs = null;
		reqData.UndertimeHrs = null;
		reqData.NDHrs = null;
		reqData.Absent = null;
		reqData.Leave01 = null;
		reqData.Leave02 = null;
		reqData.Leave03 = null;
		reqData.Leave04 = null;
		reqData.Leave05 = null;
		reqData.Leave06 = null;
		reqData.Leave07 = null;
		reqData.Leave08 = null;
		reqData.Leave09 = null;
		reqData.Leave10 = null;
		reqData.Leave11 = null;
		reqData.Leave12 = null;
		reqData.Leave13 = null;
		reqData.Leave14 = null;
		reqData.Leave15 = null;
		reqData.Leave16 = null;
		reqData.Leave17 = null;
		reqData.Leave18 = null;
		reqData.Leave19 = null;
		reqData.Leave20 = null;
		reqData.OTHrs01 = null;
		reqData.OTHrs02 = null;
		reqData.OTHrs03 = null;
		reqData.OTHrs04 = null;
		reqData.OTHrs05 = null;
		reqData.OTHrs06 = null;
		reqData.OTHrs07 = null;
		reqData.OTHrs08 = null;
		reqData.OTHrs09 = null;
		reqData.OTHrs10 = null;
		reqData.OTHrs11 = null;
		reqData.OTHrs12 = null;
		reqData.OTHrs13 = null;
		reqData.OTHrs14 = null;
		reqData.OTHrs15 = null;
		reqData.OTHrs16 = null;
		reqData.OTHrs17 = null;
		reqData.OTHrs18 = null;
		reqData.OTHrs19 = null;
		reqData.OTHrs20 = null;
		reqData.OTHrs21 = null;
		reqData.OTHrs22=null;
		reqData.OTHrs23=null;
		reqData.OTHrs24=null;
		reqData.OTHrs25=null;
		reqData.Rate=null;
		reqData.UnpaidRegHrs=null;
		reqData.UnpaidSL=null;
		reqData.UnpaidTaxSL=null;
		reqData.UnpaidVL = null;
		reqData.UnpaidTaxVL = null;
		reqData.UnpaidEL = null;
		reqData.EffectivityDate = null;
		reqData.EmpStatus = null;
		reqData.EffectivityDateResign = null;
		*/
