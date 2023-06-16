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
	BusinessTripDate,
	ShiftType
} = require('../../config/Sequelize');

let config = null;
let holidays = null;
let overtimes = null;
let shift = null;
let shifts = null;
let actualShifts = [];
let leaves = [];
let business_trips = [];

exports.process = function(target_date = null, user_id = null,reprocess = null){
	console.log("Proccessing TSS Helper")
	let DATE_DIFF = null;
	let DATE_DIFF_TO = $env.parsed.DATE_DIFF_TO ? $env.parsed.DATE_DIFF_TO : 1;
	let START_DATE = null;
	let END_DATE = null;

	if(target_date != null) {
		if(Array.isArray(target_date)) { 
			START_DATE 	= target_date[0];
			END_DATE	= target_date.pop();
		} else {
			// START_DATE = moment(target_date).format('YYYY-MM-DD');
			// END_DATE = moment(target_date).add(Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
			START_DATE 	= target_date;
			END_DATE 	= target_date;
		}
	} else {
		DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;

		START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
		END_DATE = moment().subtract(Number(DATE_DIFF)-Number(DATE_DIFF_TO),'days').format('YYYY-MM-DD');
	}

	if(reprocess){
		if(Array.isArray(target_date)){
			START_DATE  = target_date[0];
			END_DATE	= target_date.pop();
		}
		else{
			START_DATE  = moment(target_date).format('YYYY-MM-DD');
			END_DATE	= moment(target_date).format('YYYY-MM-DD');
		}
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
		[Op.gte]: moment(START_DATE).subtract(1,'days').format('YYYY-MM-DD'),
		[Op.lte]: moment(END_DATE).add(1,'days').format('YYYY-MM-DD')
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
		if(Array.isArray(user_id)) {
			where_shift.user_id = {
				[Op.in]: user_id
			}
			where_overtime.user_id = {
				[Op.in]: user_id
			}
			where_leave.user_id = {
				[Op.in]: user_id
			}
			where_business.user_id = {
				[Op.in]: user_id
			}
		} else {
			where_shift.user_id = user_id
			where_overtime.user_id = user_id
			where_leave.user_id = user_id
			where_business.user_id = user_id
		}

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
				},
				{
					model: ShiftType,
					as: 'type_of_shift',
					attributes:['is_from_previous']
				}
			],
			raw: false
		});
	}).then(data=>{
		shift = data;
		// console.log("SHIFTS TOTAL: ", shift.length);
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
			where: where_business,
			include:[
				{
					model: BusinessTripsModel,
					where: {
						primary_status: 2,
					},
				},
			],
		});
		
	}).then(async data=>{
		business_trips = data;
		// console.log('TOTAL SHIFT: ', shift.length);
		if(shift && shift.length){
			for(let i in shift){
				if(shift[i]&&shift[i].date){
					let date = shift[i].date;
					let check_in = shift[i].check_in ? date +' '+moment(shift[i].check_in).utc().format('HH:mm:ss') : null;
					let check_out = shift[i].check_out ? date +' '+moment(shift[i].check_out).utc().format('HH:mm:ss') : null;
						check_out = check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD') : moment(check_out).format('YYYY-MM-DD');
					actualShifts.push({
						id: shift[i].id,
						date: shift[i].date,
						user_id: shift[i].user_id,
						check_in: shift[i].check_in? shift[i].check_in: null,
						check_out: shift[i].check_out? shift[i].check_out: null,
						actual_check_in: shift[i].actual_check_in ? shift[i].actual_check_in : null,
						actual_check_out: shift[i].actual_check_out ? shift[i].actual_check_out : null,
					});

					await setTssData(shift[i], overtimes);
					//setOvertime(shift[i]);
				}
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
		
	}).then(async data=>{
		business_trips = data;
		if(shift && shift.length){
			for(let i in shift){
				let date = shift[i]?.date;
				let check_in = shift[i].check_in ? date +' '+moment(shift[i].check_in).utc().format('HH:mm:ss') : null;
				let check_out = shift[i].check_out ? date +' '+moment(shift[i].check_out).utc().format('HH:mm:ss') : null;
					check_out = check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD') : moment(check_out).format('YYYY-MM-DD');
				actualShifts.push({
					id: shift[i].id,
					date: shift[i].date,
					user_id: shift[i].user_id,
					check_in: shift[i].check_in ? shift[i].check_in : null,
					check_out: shift[i].check_out ? shift[i].check_out : null,
					actual_check_in: shift[i].actual_check_in ? shift[i].actual_check_in : null,
					actual_check_out: shift[i].actual_check_out ? shift[i].actual_check_out : null,
				});

				await setTssData(shift[i], overtimes);
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

exports.set_overtime = function(shift){
	setOvertime(shift);
}

const setOvertime = function(shift){

	let date = shift.date;
	let prevDate 		= moment(date).subtract(1,'days').format('YYYY-MM-DD');
	
	// Shift in/out IN SHIFT TABLE
	let check_in 	= shift.check_in ? date +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
	let check_out 	= shift.check_out ? date +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
		check_out 	= check_in > check_out ? moment(check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : moment(check_out).format('YYYY-MM-DD HH:mm:ss');

	// Actual time-in/out IN SHIFT TABLE
	let actual_check_in 	= shift.actual_check_in ? date +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
	let actual_check_out 	= shift.actual_check_out ? date +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
		actual_check_out 	= actual_check_out? actual_check_in > actual_check_out ? moment(actual_check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : moment(actual_check_out).format('YYYY-MM-DD HH:mm:ss'):null;

	// CASES FOR PREVIOUS DAY SHIFT
	if (shift.shift_type){
		if (shift.type_of_shift){
			if (shift.type_of_shift.is_from_previous == '1') {
				// FOR FILED CHECK IN
				if (check_in && check_out && (check_in > check_out)) {
					check_in = shift.check_in ? prevDate + ' ' + moment(shift.check_in).utc().format('HH:mm:ss') : null;
					check_out = shift.check_out ? date + ' ' + moment(shift.check_out).utc().format('HH:mm:ss') : null;
				}
				if (actual_check_in && actual_check_out && (actual_check_in > actual_check_out)) {
					actual_check_in = shift.actual_check_in ? prevDate + ' ' + moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
					actual_check_out = shift.actual_check_out ? date + ' ' + moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
				}

				// NO LOGOUT
				if (actual_check_in && !actual_check_out && check_out && (actual_check_in > check_out)) {
					actual_check_in = shift.actual_check_in ? prevDate + ' ' + moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
				}
			}
		}
	} 

	// console.log("SHIFT CI: ", check_in," SHIFT CO: ", check_out, "SHIFT ACI: ", actual_check_in, "SHIFT ACO: ", actual_check_out);
	
	let overtime = shift.ot;

	// console.log("TOTAL SHIFTS: ", shift.ot.length);

	if(overtime && overtime.length){
		let OTHrs01 = 0;
		let OTHrs02 = 0;
		for(let i in overtime){

			let no_of_hours = parseFloat(overtime[i].no_of_hours).toFixed(2);
			let night_diff 	= overtime[i].night_diff? parseFloat(overtime[i].night_diff).toFixed(2):0;
			let ot_hours 	= 0;
			let break_hours = overtime[i].break_hours ? overtime[i].break_hours : 0;

			// OT FILE OUT AND IN OVERTIMES TABLE
			let ot_in 	= overtime[i].start_date +' '+moment(overtime[i].start_time).utc().format('HH:mm:ss');
			let ot_out 	= overtime[i].end_date +' '+moment(overtime[i].end_time).utc().format('HH:mm:ss');
			// OT EMPLOYEE ACTUAL TIME IN AND TIME OUT IN OVERTIMES TABLE
			let ot_time_in 	= overtime[i].actual_check_in? overtime[i].start_date + ' ' + moment(overtime[i].actual_check_in).utc().format('HH:mm:ss'):null;
			let ot_time_out = overtime[i].actual_check_out? overtime[i].end_date + ' ' + moment(overtime[i].actual_check_out).utc().format('HH:mm:ss'):null;


			// OVERTIME HAS ACTUAL TIME IN AND TIME OUT
			if(overtime[i].primary_status == 2 && (ot_time_in ||ot_time_out)){
				// Pre work OT==============================
				if (ot_in < check_in && ot_time_in){
					let start_date_diff = moment(ot_in).diff(ot_time_in,'hours');
					let threshold		= parseFloat(no_of_hours * -1);

					// console.log('PRE OT THRESHOLD: ', threshold,' DATE DIFF: ', start_date_diff);

					if(start_date_diff < threshold){
						ot_time_in  = moment(ot_time_in).subtract(1,'days').format('YYYY-MM-DD HH:mm:ss');
					}
					ot_hours = parseFloat(parseFloat(moment(ot_out).diff(moment(ot_time_in), 'minutes')).toFixed(4)/60).toFixed(4);
					//IF OTHRS IS GREATER THAN NO_OF_HOURS GET NO_OF_HOURS OR LESS THAN GET OT_HOURS
					if (ot_hours < no_of_hours){
						no_of_hours = ot_hours;
					}
				}

				// Post work OT=============================
				if (ot_out > check_out && ot_time_out){
					let end_date_diff 	= moment(ot_out).diff(ot_time_out,'hours');
					let threshold		= parseFloat(no_of_hours);

					// console.log('POST OT THRESHOLD: ', threshold,' DATE DIFF: ', end_date_diff);

					if(end_date_diff > threshold){
						ot_time_out  = moment(ot_time_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
					}
					ot_hours = parseFloat(parseFloat(moment(ot_time_out).diff(moment(ot_in), 'minutes')).toFixed(4)/60).toFixed(4);
					//IF OTHRS IS GREATER THAN NO_OF_HOURS GET NO_OF_HOURS OR LESS THAN GET OT_HOURS
					if (ot_hours < no_of_hours){
						no_of_hours = ot_hours;
					}
				}

				//Duty Rest Day=============================
				if(!check_in && (ot_time_in || ot_time_out)){
					let check_real_ti = ot_time_in? ot_in<ot_time_in? ot_time_in: ot_in : ot_in;
					let check_real_to = ot_time_out? ot_time_out<ot_out? ot_time_out: ot_out: ot_out;

					ot_hours = parseFloat(parseFloat(moment(check_real_to).diff(moment(check_real_ti), 'minutes')).toFixed(4)/60).toFixed(4);

					if (ot_hours < no_of_hours){
						no_of_hours = ot_hours;
					}
				}


				OTHrs01 = parseFloat(parseFloat(OTHrs01) + parseFloat(no_of_hours)).toFixed(4);
				OTHrs02 = parseFloat(parseFloat(OTHrs02) + parseFloat(night_diff)).toFixed(4);
			}
			// OVERTIME WITHOUT TIME IN AND AND TIME OUT
			else if(overtime[i].primary_status == 2 && !ot_time_in && !ot_time_out ){
				// Pre work OT W/O ATTENDANCE CHECK THE SHIFT ATTENDANCE
				if(ot_in < check_in && !ot_time_in){
					// CHECK IF SHIFT_ACTUAL_CHECK_IN IS LESS THAN THE OT END_TIME
					if(actual_check_in < ot_out){
						let start_date_diff = moment(ot_in).diff(actual_check_in,'hours');
						let threshold		= parseFloat(no_of_hours * -1);

						// console.log('PRE OT W/O ATT THRESHOLD: ', threshold,' DATE DIFF: ', start_date_diff);

						if(start_date_diff < threshold){
							ot_time_in  = moment(actual_check_in).subtract(1,'days').format('YYYY-MM-DD HH:mm:ss');
						}
						ot_hours = parseFloat(parseFloat(moment(ot_out).diff(moment(ot_time_in), 'minutes')).toFixed(4)/60).toFixed(4);
						//IF OTHRS IS GREATER THAN NO_OF_HOURS GET NO_OF_HOURS OR LESS THAN GET OT_HOURS
						if (ot_hours < no_of_hours){
							no_of_hours = ot_hours;
						}
						
						OTHrs01 = parseFloat(parseFloat(OTHrs01) + parseFloat(no_of_hours)).toFixed(4);
						OTHrs02 = parseFloat(parseFloat(OTHrs02) + parseFloat(night_diff)).toFixed(4);
					}
				}
				// Post work OT W/O ATTENDANCE CHECK THE SHIFT ATTENDANCE
				if(ot_out > check_out && !ot_time_out){
					// CHECK IF SHIFT_ACTUAL_CHECK_IN IS LESS THAN THE OT END_TIME
					if(actual_check_out > ot_in){
						let end_date_diff 	= moment(ot_out).diff(actual_check_out,'hours');
						let threshold		= parseFloat(no_of_hours);

						// console.log('POST OT W/O ATT THRESHOLD: ', threshold,' DATE DIFF: ', end_date_diff);

						if(end_date_diff > threshold){
							ot_time_out  = moment(actual_check_out).add(1,'days').format('YYYY-MM-DD HH:mm:ss');
						}
						ot_hours = parseFloat(parseFloat(moment(ot_time_out).diff(moment(ot_in), 'minutes')).toFixed(4)/60).toFixed(4);
						// console.log('OTHIURS: ', ot_hours);
						//IF OTHRS IS GREATER THAN NO_OF_HOURS GET NO_OF_HOURS OR LESS THAN GET OT_HOURS
						if (ot_hours < no_of_hours){
							no_of_hours = ot_hours;
						}

						OTHrs01 = parseFloat(parseFloat(OTHrs01) + parseFloat(no_of_hours)).toFixed(4);
						OTHrs02 = parseFloat(parseFloat(OTHrs02) + parseFloat(night_diff)).toFixed(4);
						// console.log("OTHRS: ", OTHrs01);
					}
				}

			}

			// console.log('OT TIME_IN: ', ot_in, " OT ACT_TI: ", ot_time_in);
			// console.log('OT TIME_OUT: ', ot_out, " OT ACT_TO: ", ot_time_out);
		}
		let reqData = {
			user_id: shift.user_id,
			date: shift.date,
		}

		
		// console.log("OTHrs01: ", OTHrs01," OTHrs02: ",OTHrs02);
		
		if(OTHrs01 > 0 && check_in && check_out){
			reqData.OTHrs01 = OTHrs01;
		}
		else{
			reqData.OTHrs03 = OTHrs01;
		}

		if(OTHrs02 > 0){
			reqData.OTHrs02 = OTHrs02;
		}
		
		if(OTHrs01 > 0){
			updateTssData(reqData);
		}

	}
}

const Overtime = function(row){
	let user_id 	= row.user_id;
	let date 		= row.start_date;
	let end_date_ot	= row.end_date;
	let no_of_hours	= row.no_of_hours;
	let shift_id 	= row.shift_id ? row.shift_id :null;

	let start_date 	= date+' '+ moment(row.start_time).utc().format('HH:mm:ss');
	let end_date 	= end_date_ot+' '+ moment(row.end_time).utc().format('HH:mm:ss');
	    end_date 	= start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;
	let break_hours = row.break_hours ? row.break_hours : 0;

	if (shift_id) {
		let search = actualShifts.filter(function (arr) {
			return arr.id == shift_id && arr.check_in
		})[0];



		//Regular Overtime
		if (search) {
			let shift = shifts.filter(function (arr) {
				return arr.id == search.id
			})[0];
			if (shift) {
				regularOvertime(row, date, start_date, end_date, shift);
			}

		}
		//Rest Day
		else {
			// GET SHIFT INFO OF THE OT
			let shift_info 	= actualShifts.filter(function (arr) {
				return arr.id == shift_id
			})[0];

			// console.log('OT SHIFT INFO: ', shift_info);

			// CHECK OT IF HAS A SHIFT DISREGARD IF NOT
			if(shift_info){
				//OT FILED START AND END DATE AND TIME
				start_date 	= start_date;
				end_date 	= end_date;

				// OT EMPLOYEE ACTUAL TIME IN AND TIME OUT
				let actualIn = row.actual_check_in ? date + ' ' + moment(row.actual_check_in).utc().format('HH:mm:ss') : null;
				let actualOut = row.actual_check_out ? end_date_ot + ' ' + moment(row.actual_check_out).utc().format('HH:mm:ss') : null;

				// console.log("OT ACT IN: ", actualIn, " ACT OUT: ",actualOut);

				if (actualIn) {
					let start_date_diff = moment(start_date).diff(actualIn, 'hours');
					let threshold = parseFloat(no_of_hours * -1);
					// console.log('OT THRESHOLD: ', threshold);
					if (start_date_diff < threshold) {
						actualIn = moment(actualIn).subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss');
					}
					start_date = start_date >= actualIn ? start_date : actualIn;
				}
				if (actualOut) {
					end_date = end_date < actualOut ? end_date : actualOut;
				}

				if((shift_info.actual_check_in||shift_info.actual_check_out)&&(actualIn||actualOut)){
					// console.log("OT START: ", start_date," OT END: ", end_date);
					RestDayOvertime(row, user_id, date, start_date, end_date, break_hours);
				}
			}
		}
	}
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
				OTHrs01 = OTHrs01 ? parseFloat(OTHrs01).toFixed(4) : null;
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
	let OTHrs03 	= parseFloat(parseFloat(moment(end_date).diff(moment(start_date), 'minutes')).toFixed(4)/60).toFixed(4);

	
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

	// console.log("OTHRS03: ", OTHrs03);

	let reqData = {
		user_id: user_id,
		date: date,
		OTHrs03: OTHrs03 ? parseFloat(OTHrs03).toFixed(4) : null,
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
		reqData[column] = result ? parseFloat(result).toFixed(4) : null;

		// console.log("NDHrs: " + result);

		updateTssData(reqData);
	}
	
	// }
}

const RegHrs = function(shift){
	let date 			= shift.date;
	let shift_length 	= shift.shift_length? shift.shift_length : 9;
	let prevDate 		= moment(date).subtract(1,'days').format('YYYY-MM-DD');
	let nextDate 		= moment(date).add(1,'days').format('YYYY-MM-DD');

	let check_in 		= shift.check_in ? date +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
	let check_out 		= shift.check_out ? date +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;

	let actual_check_in  = shift.actual_check_in ? date +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
	let actual_check_out = shift.actual_check_out ? date +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;

	// Cases for previous date check in
	if (shift.shift_type && shift.type_of_shift?.is_from_previous == '1' ){
		// FOR FILED CHECK IN
		if (check_in && check_out && (check_in > check_out)){
			check_in = shift.check_in ? prevDate +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
			check_out = shift.check_out ? date +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
		}
		if (actual_check_in && actual_check_out && (actual_check_in > actual_check_out)){
			actual_check_in = shift.actual_check_in ? prevDate +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
			actual_check_out = shift.actual_check_out ? date +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
		}

		// No logout
		if(actual_check_in && !actual_check_out && check_out && (actual_check_in > check_out)){
			actual_check_in = shift.actual_check_in ? prevDate +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
		}
	} else {
		if (check_in && check_out && (check_in > check_out)){
			check_in = shift.check_in ? date +' '+moment(shift.check_in).utc().format('HH:mm:ss') : null;
			check_out = shift.check_out ? nextDate +' '+moment(shift.check_out).utc().format('HH:mm:ss') : null;
		}

		if(actual_check_in && moment(check_in).diff(actual_check_in,'hours') < (shift_length * -1)){	
			actual_check_in	 = shift.actual_check_in ? prevDate +' '+moment(shift.actual_check_in).utc().format('HH:mm:ss') : null;
		}
		if(actual_check_out && moment(actual_check_out).diff(check_out,'hours') < (shift_length * -1)){
			actual_check_out = shift.actual_check_out ? nextDate +' '+moment(shift.actual_check_out).utc().format('HH:mm:ss') : null;
		}
		
	}

	// console.log("check_in: " + check_in + " --- " + check_out);
	// console.log("actual_check_in: " + actual_check_in + " --- " + actual_check_out);

	let grace_period = 0;
	if(config && config.shift && config.shift.grace_period){
		grace_period = parseInt(config.shift.grace_period) + 1;	// Consider seconds after the grace period
	}

	let shift_break = shift.break_hour ? shift.break_hour : 0;

	let minusLate = 0;
	let LateHrs = 0;
	let UndertimeHrs = 0;

	// With log in and log out
	if(actual_check_in && actual_check_out && check_in && check_out){

		let start_date = check_in > actual_check_in ? check_in : actual_check_in;
		let end_date = check_out < actual_check_out ? check_out:actual_check_out;

		// console.log("START_DATE: ", start_date, " END_DATE: ", end_date);

		LeaveDateModel.findOne({
			where:{
				user_id: shift.user_id,
				date: shift.date,
				date_is_filed: 1,
			},
			include:[
				{
					model: LeavesModel,
					where:{
						primary_status: 2,
					},
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
			let leaveData = data;
			
			if(actual_check_in > check_in){
				LateHrs   = moment(actual_check_in).diff(moment(check_in), 'seconds');
				LateHrs   = parseFloat(LateHrs/60).toFixed(4);
				minusLate = LateHrs;
			}

			if(actual_check_out < check_out){
				UndertimeHrs = moment(check_out).diff(moment(actual_check_out), 'seconds');
				UndertimeHrs = parseFloat(UndertimeHrs/60).toFixed(4);
			}

			if(LateHrs < grace_period){
				LateHrs = 0;
				minusLate = 0;
			}

			var duration = moment.duration(moment(check_out).diff(moment(check_in)));

			// console.log("MINUTES DURATION: " + duration.asMinutes() + " LATE: " + minusLate + " UNDERTIME: " + UndertimeHrs);
			
			// COMPUTATIONS
			let totalMinutes 	= parseInt(duration.asMinutes()) - parseFloat(parseInt(minusLate) + parseInt(UndertimeHrs)).toFixed(4);
			let hours 			= parseFloat(totalMinutes).toFixed(4) / 60;
			let break_hour 		= shift.break_hour ? shift.break_hour : 0;
			let rhours 			= Math.floor(hours) - break_hour;
			let minutes 		= (hours - rhours) * 60;
			let rminutes 		= Math.round(minutes);
			let RegHrs 			= parseFloat(hours).toFixed(4) - break_hour;
			
			if (hours <=4){
				RegHrs = hours;
			}

			if(Math.round(hours) == 5 && shift_length > 8 && break_hour >= 1 && leaveData?.leave_duration != 0){
				RegHrs = hours;
			}

			if(leaveData) {
				UndertimeHrs = 0
				LateHrs = 0;
			}

			// console.log("COMPLETE TIMEIN AND TIMEOUT REG HOURS: ", RegHrs, " TOTAL MINUTES: ", totalMinutes, " HOURS: ", hours, " BREAK HOUR: ", break_hour);

			let reqData = {
				Absent: null,
				user_id: shift.user_id,
				date: date,
				RegHrs: !isNaN(parseFloat(RegHrs)) ? parseFloat(RegHrs).toFixed(4) : null,
				LateHrs: !isNaN(parseFloat(LateHrs)) ? parseFloat(LateHrs).toFixed(4) : null,
				UndertimeHrs: !isNaN(parseFloat(UndertimeHrs)) ? parseFloat(UndertimeHrs).toFixed(4) : null,
			}
			// console.log("reqData ", reqData);
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
	}else if(check_in && check_out){
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
					RegHrs: !isNaN(parseFloat(RegHrs)) ? parseFloat(RegHrs).toFixed(4) : null,
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
					RegHrs: !isNaN(parseFloat(RegHrs)) ? parseFloat(RegHrs).toFixed(4) : null,
				}
				updateTssData(reqData);
				Holiday(shift.user_id, shift.date, start_date, end_date, 'normal', shift_break);//Holidays

				nightDifferencial(shift.user_id, shift.date, start_date, end_date,'NDHrs');
			} else {
				// Undertime computation
				if(actual_check_out < check_out){
					UndertimeHrs = moment(check_out).diff(moment(actual_check_out), 'seconds');
					UndertimeHrs = parseFloat(UndertimeHrs/60).toFixed(4);
				}

				LateHrs = 0; // Set late to zero since there is no login

				// console.log("NO LOGIN UNDERTIME: ", UndertimeHrs);

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
					RegHrs: !isNaN(parseFloat(RegHrs)) ? parseFloat(RegHrs).toFixed(4) : null,
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


				// console.log("LATE HOURS: " + LateHrs);

				UndertimeHrs = 0; // Set undertime hours to zero since there is no logout

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
								return arr.date == date1 && arr.location_id.includes(employment.location_id)

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
								return arr.date == date1 && arr.location_id.includes(employment.location_id)
							});
							let date2_result = holiday.filter(function(arr){
								return arr.date == date2 && arr.location_id.includes(employment.location_id)
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
							reqData.OTHrs04 = specialHoliday > 0 ? parseFloat(specialHoliday).toFixed(4) : null;
							reqData.OTHrs05 = regularHoliday > 0 ? parseFloat(regularHoliday).toFixed(4) : null;
							if (reqData.OTHrs04 && reqData.OTHrs04 > 5){
								reqData.OTHrs04 = reqData.OTHrs04 - break_hour;
							}
							if (reqData.OTHrs05 && reqData.OTHrs05 > 5){
								reqData.OTHrs05 = reqData.OTHrs05 - break_hour;
							}
						}else if(type == 'restday'){
							reqData.OTHrs06 = specialHoliday > 0 ? parseFloat(specialHoliday).toFixed(4) : null;
							reqData.OTHrs07 = regularHoliday > 0 ? parseFloat(regularHoliday).toFixed(4) : null;
							if (reqData.OTHrs06 && reqData.OTHrs06 > 5){
								reqData.OTHrs06 = reqData.OTHrs06 - break_hour;
							}
							if (reqData.OTHrs07 && reqData.OTHrs07 > 5){
								reqData.OTHrs07 = reqData.OTHrs07 - break_hour;
							}
						}else if(type='overtime'){
							reqData.OTHrs09 = specialHoliday > 0 ? parseFloat(specialHoliday).toFixed(4) : null;
							reqData.OTHrs10 = regularHoliday > 0 ? parseFloat(regularHoliday).toFixed(4) : null;
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
		reqData.RegHrs = shift.shift_length >= 4 ? parseFloat(Math.floor(shift.shift_length / 2)).toFixed(4) : null;
		reqData.Absent = shift.shift_length >= 4 ? parseFloat(Math.floor(shift.shift_length / 2)).toFixed(4) : parseFloat(4);
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
exports.absent = function(shift){
	Absent(shift);
}
const Absent = function(shift, RegHrsInput = null){
	// console.log("SHIFT ID", shift.id);
	LeaveDateModel.findOne({
		where:{
			user_id: shift.user_id,
			date: shift.date,
			date_is_filed:1
		},
		include:[
			{
				model: LeavesModel,
				where:{
					primary_status: 2,
				},
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
		
		let actual_check_in  = shift.actual_check_in
		let actual_check_out = shift.actual_check_out

		let brkhrs     = shift.break_hour ? shift.break_hour : 0;
		let start_date = shift.date+' '+moment(shift.check_in).format('HH:mm:ss');
		let end_date   = shift.date+' '+moment(shift.check_out).format('HH:mm:ss');
		    end_date   = start_date > end_date ? moment(end_date).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : end_date;
		let Absent     = moment(end_date).diff(moment(start_date), 'hours') - brkhrs;

		if (isNaN(Absent)){
			Absent = 0;
		}

		if (leavesData && leavesData.leave_duration !=0){
			Absent = 4;		// Half day leave
		}
		let reqData = {
			user_id: shift.user_id,
			date: shift.date,
			RegHrs: RegHrsInput ? parseFloat(RegHrsInput).toFixed(4) : 0
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
			let isPaid     = leavesData.leave && leavesData.credit == 1 && isApproved ? 'paid':'unpaid';

			if(actual_check_in == null && actual_check_out == null) {
				reqData.Absent = Absent;
			} else {
				reqData.Absent = isApproved ? null : Absent;
			}
			let leave_policy_code = leavesData.leave.leave_policy.code;
			//console.log('user: ' + shift.user_id + ' : ' + leave_policy_code);
			
			if(leave_policy_code == 'SL'){					// SL - Sick Leave
				if(isPaid == 'paid'){
					reqData.Leave01 = parseFloat(Absent).toFixed(4);
				}else{
					reqData.UnpaidSL = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'EL'){			// EL - Emergency Leave
				if(isPaid == 'paid'){
					reqData.Leave02 = parseFloat(Absent).toFixed(4);
				}else{
					reqData.UnpaidEL = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'VL'){			// VL - Vacation Leave
				if(isPaid == 'paid'){
					reqData.Leave03 = parseFloat(Absent).toFixed(4);
				}else{
					reqData.UnpaidVL = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'ML'){			// ML - Maternity Leave
				if(isPaid == 'paid'){
					reqData.Leave04 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'PL'){			// Paternity Leave
				if(isPaid == 'paid'){
					reqData.Leave05 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'BL'){			// Bereavement Leave
				if(isPaid == 'paid'){
					reqData.Leave10 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'MML' || leave_policy_code == 'MC'){			// Miscarriage Leave
				if(isPaid == 'paid'){
					reqData.Leave11 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'SPL'){			// Solo Parent Leave
				if(isPaid == 'paid'){
					reqData.Leave08 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'SLWL'){			// Special Leave for Women
				if(isPaid == 'paid'){
					reqData.Leave12 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'VAWCL'){			// VAWCI Leave
				if(isPaid == 'paid'){
					reqData.Leave13 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'UL'){			// Union Leave
				if(isPaid == 'paid'){
					reqData.Leave14 = parseFloat(Absent).toFixed(4);
				}
			}else if(leave_policy_code == 'SIL'){			// Service Incentive Leave
				if(isPaid == 'paid'){
					reqData.Leave06 = parseFloat(Absent).toFixed(4);
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
					// user_id: row.user_id,
					// date: row.date,
					id: tss.id,
				}
			});
		}
	});
}

const setTssData = function(shift, overtimes){
	return new Promise(resolve => {
		let reqData = {
			shift_id: shift.id,
			user_id: shift.user_id,
			date: shift.date,
		}
		TSSData.findOne({
			where: reqData,
		}).then(data=>{
			tss = data;
			
			if(!tss){
				TSSData.create(reqData).then(data=>{
					RegHrs(shift);
					
					let hasOT = overtimes.filter(function(arr){
							return arr.user_id == shift.user_id && arr.start_date == shift.date;
						});

					if(hasOT.length){
						setOvertime(shift);
						resolve('resolved');
					} else {
						resolve('resolved');
					}
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
						//user_id : tss.user_id,
						//date   	: tss.date
						id: tss.id
					}
				}).then(data=>{
					if(data){
						RegHrs(shift);

						let hasOT = overtimes.filter(function(arr){
							return arr.user_id == shift.user_id && arr.start_date == shift.date || arr.shift_id == shift.id;
						});

						if(hasOT.length){
							setOvertime(shift);
							resolve('resolved');
						} else {
							resolve('resolved');
						}
					} else {
						resolve('resolved');
					}
				});
			}
		});
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
