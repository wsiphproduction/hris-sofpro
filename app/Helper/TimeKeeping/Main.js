const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const Salary = require('../SalaryComputation');
const { 
	OvertimesModel,
	HolidaysModel
} = require('../../../config/Sequelize');

function Main(){

	this.calculate = function(record, holiday, setting, createPriod, absenteeism){
		let holidays = JSON.parse(JSON.stringify(holiday));
		let summary = [];
		if(record){
			for(let key in record){
				//console.log("recordsss: ", record[key]['shifts']);
				let user_setting = record[key]['user_setting'];
					user_setting = user_setting ? JSON.parse(JSON.stringify(user_setting)) : null;
				//console.log(user_setting);
				let incentive = record[key]['incentives'];
					incentive = incentive ? JSON.parse(JSON.stringify(incentive)) : [];
				let dispute = record[key]['disputes'];
					dispute = dispute ? JSON.parse(JSON.stringify(dispute)) : [];
				let adjustment = record[key]['adjustments'];
					adjustment = adjustment ? JSON.parse(JSON.stringify(adjustment)) : [];
					
				let loans = record[key]['loan_payments'];
					loans = loans ? JSON.parse(JSON.stringify(loans)) : [];
				let overtimes 	= record[key]['overtimes'];
					overtimes   = overtimes ? JSON.parse(JSON.stringify(overtimes)) : [];
				//console.log(loans);
				let branch      = record[key]['branch'];
				let salary 		= record[key]['salary'];
				let shifts 		= record[key]['shifts'];
				let leaves 		= record[key]['leaves_dates'];
				let holiday_off = user_setting && user_setting.has_holiday ? user_setting.has_holiday : 1; //record[key]['holiday_off'];
				//console.log(holiday_off);
				let salaryMonth = 0;
				let salaryBasic = 0;
				let salaryDay   = 0;
				let salaryHour  = 0;
				let salaryMinute= 0;
				
				let incentiveData = [];
				if(incentive.length){
					for(let inc in incentive){
						let amount = incentive[inc].amount;
						if(incentive[inc].period == 2){
							amount = amount / 2;
						}
						incentiveData.push({
							label: incentive[inc].label,
							amount: amount
						});
					}
				}

				if(salary && salary.amount){
					if(salary.mode == 0){
						salaryMonth = salary.amount;
						salaryBasic = salary ? salaryMonth / 2 : 0;
						salaryDay   = salaryMonth ? salaryMonth * 12 / 261 : 0;
						salaryHour  = salaryDay ? salaryDay / 8 : 0;
						salaryMinute= salaryHour ? salaryHour / 60 : 0;
					}else if(salary.mode == 2){
						salaryMonth = '??';
						salaryBasic = '??';
						salaryDay   = salary.amount;
						salaryHour  = salaryDay ? salaryDay / 8 : 0;
						salaryMinute= salaryHour ? salaryHour / 60 : 0;
					}else if(salary.mode == 3){
						salaryMonth = '??';
						salaryBasic = '??';
						salaryDay   = '??';
						salaryHour  = salary.amount;
						salaryMinute= salaryHour ? salaryHour / 60 : 0;
					}
				}


				let salaryInfo = {
					month: salaryMonth,
					basic: salaryBasic,
					day: salaryDay,
					hour: salaryHour,
					minute: salaryMinute
				}
				let company = {
					logo: branch && branch.company ? branch.company.logo : '',
					name: branch && branch.company ? branch.company.name : '',
					location: branch ? branch.location : '',
					address: branch ? branch.address : '',
				}
				if(shifts){
					if(shifts.length){
						let summaries = this.summary(shifts, leaves, overtimes, holidays, dispute, setting, holiday_off);
						let payment  = Salary.calculate(summaries, salaryInfo, loans, adjustment, dispute, incentive, setting);
						let shiftsHolder = record[key]['shifts']
						
						if(absenteeism) {
							let absenteeismShifts = this.absenteeism(shifts, absenteeism);
							shiftsHolder = absenteeismShifts;
						}
						
						summary.push({
							id: record[key]['id'],
							shortid: record[key]['shortid'],
							period: createPriod,
							employee_number: record[key]['employee_number'],
							first_name: record[key]['first_name'],
							middle_name: record[key]['middle_name'],
							last_name: record[key]['last_name'],
							salary_type: record[key]['salary_type'],
							suffix: record[key]['suffix'],
							designation: record[key]['job_title'] ? record[key]['job_title'].title : '',
							department: record[key]['department'] ? record[key]['department'].title : '',
							company: company,
							shifts: shiftsHolder,
							leave_dates: record[key]['leaves_dates'],
							overtimes: overtimes,
							payment: payment,
							salary: salaryInfo,
							summary: summaries,
							loans: loans,
							adjustment: adjustment,
							incentive: incentiveData
						});	
									
					}
				}
				
			}
		}

		return summary;
	}

	/*
	|-----------------------------------------------------------
	| Calculate Absent
	|-----------------------------------------------------------
	*/

	this.absenteeism = function(shift, absenteeism){
		let absenteeismShift = [];
		let tempAbsenteeismShift = [];
		let isLate = false;
		let noLoginCount = 0;
		let noLogoutCount = 0;

		for(let key in shift){
			isLate = false;

			switch(absenteeism) {
				case "1":
					if(shift[key].late != null) {
						isLate = true;
					} else if(shift[key].undertime != null) {
						isLate = true;
					}
				  	break;
				case "2":
					  if(!shift[key].actual_check_out) {
						  noLogoutCount++;
						  tempAbsenteeismShift.push(shift[key]);
					  }
					  break;
				case "3":
					if(!shift[key].actual_check_in) {
						noLoginCount++;
						tempAbsenteeismShift.push(shift[key]);
					}
				  	break;
				default:
				  	break;
			}
			if(isLate) {
				absenteeismShift.push(shift[key]);
			}
		}
		
		if(noLoginCount >= 2 || noLogoutCount >= 2) {
			absenteeismShift = tempAbsenteeismShift;
		}

		return absenteeismShift;
	}

	this.summary = function(shift, leave, overtime, holidays, dispute, setting, holiday_off){
		//console.log(holiday);
		let data = {
			Absent: 0, //OK
			PaidLeave: 0, //OK
			NightShift: 0, //OK
			LateUndertime: 0, //OK
			Overtime: 0, //OK
			OvertimeND: 0, //OK
			RestDayPay: 0,
			RestDayPayND: 0,
			RestDayOvertime: 0,
			RestDayOvertimeND: 0,
			SpecialHoliday: 0, //OK
			SpecialHolidayND: 0, //OK
			SpecialHolidayOvertime: 0, //OK
			SpecialHolidayOvertimeND: 0, //OK
			SpecialHolidayRestDay: 0,
			SpecialHolidayRestDayND: 0,
			SpecialHolidayRestDayOvertime: 0,
			SpecialHolidayRestDayOvertimeND: 0,
			LegalHoliday: 0, //OK
			LegalHolidayND: 0, //OK
			LegalHolidayOvertime: 0, //OK
			LegalHolidayOvertimeND: 0, //OK
			LegalHolidayRestDay: 0,
			LegalHolidayRestDayND: 0,
			LegalHolidayRestDayOvertime: 0,
			LegalHolidayRestDayOvertimeND: 0,
			DaysWorked: 0, //OK
			disputeRestDay: 0,
			disputeOvertime: 0,
			disputeLeave: 0,
			disputeNolog: 0
		};
		
		if(shift.length){
			//let DaysWorked = 0;
			for(let key in shift){
				let onsite = shift[key].onsite; // 0 = No, 1 = Yes
				let type = shift[key].type; // 1 = Fix Shift, 2 = Flexible, 3 = Flexible Between
				let setDate = this.setDate(type, shift[key], setting);
				let NightShift = this.NightShift(setDate.start_date, setDate.end_date);
				let findHoliday = this.findHoliday(holidays, shift[key].date);
				let getAbsent = this.absent(leave, onsite, shift[key], type, setDate.start_date, setDate.end_date, holiday_off);
				let absent = holiday_off == 1 && findHoliday ? 0 : getAbsent;
				let lateUndertime = this.lateUndertime(leave, shift[key], setDate.start_date, setDate.end_date, setting);
				//console.log(findHoliday);
				let holiday = null;
				let holidayND = null;
				if(findHoliday){
					holiday = this.holiday(8, findHoliday.type, findHoliday.date, setDate.start_date, setDate.end_date, onsite);
					let resultHolidayND = this.holidayND(findHoliday.date, setDate.start_date, setDate.end_date);
					if(findHoliday.type == 1){
						data.LegalHolidayND += resultHolidayND.holiday_nd > 0 ? resultHolidayND.holiday_nd : 0;
					}else{
						data.SpecialHolidayND += resultHolidayND.holiday_nd > 0 ? resultHolidayND.holiday_nd : 0;
					}
					//data.NightShift    += resultHolidayND.nd;
				}else{
					//data.NightShift     += NightShift;
				}
				
				data.NightShift     += NightShift > 0 ? NightShift : 0;
				data.Absent 		+= (absent + lateUndertime.absent) > 0 ? (absent + lateUndertime.absent) : 0;
				data.LateUndertime 	+= lateUndertime.lates > 0 ? lateUndertime.lates : 0;
				
				data.LegalHoliday 	+= holiday ? holiday.legal : 0;
				data.SpecialHoliday += holiday ? holiday.special : 0;
				data.DaysWorked		+= 1;
			}
		}

		if(overtime.length){
			for(let key in overtime){
				let type = overtime[key].type;
				let start = new Date(overtime[key].start_date +' '+ overtime[key].start_time);
					start = moment(start);
				let end = new Date(overtime[key].end_date +' '+ overtime[key].end_time);
					end = moment(end);
					
				let holiday = null;

				let findHoliday = this.findHoliday(holidays, overtime[key].start_date);
				//Regular Overtime
				if(type == 1){
					end = this.setOvertimeEnd(shift, overtime[key].start_date, overtime[key].end_date);
					if(end){
						let NightShift = this.NightShift(start, end);
						let duration = moment.duration(end.diff(start));
							duration = duration.asHours();
							duration = Math.floor(duration);

						if(findHoliday){
							let holidayDate = findHoliday.date;
							let holidayType = findHoliday.type;
							if(holidayType == 1){
								let LegalHolidayOvertime = duration - NightShift;
								data.LegalHolidayOvertime 	+= LegalHolidayOvertime > 0 ? LegalHolidayOvertime : 0;
								data.LegalHolidayOvertimeND += NightShift > 0 ? NightShift : 0;
							}else{
								let SpecialHolidayOvertime = duration - NightShift;
								data.SpecialHolidayOvertime   += SpecialHolidayOvertime > 0 ? SpecialHolidayOvertime : 0;
								data.SpecialHolidayOvertimeND += NightShift > 0 ? NightShift : 0;
							}
						}else{
							let OT = duration - NightShift;
							data.Overtime	+= OT > 0 ? OT : 0;
							data.OvertimeND	+= NightShift > 0 ? NightShift : 0;
						}
					}
				}else{// Rest Day

					let restday = this.restDay(overtime[key], start, end);
					//If has holiday
					if(findHoliday){
						let holidayType = findHoliday.type;
						if(holidayType == 1){
							data.LegalHolidayRestDay 			 += restday.RestDayPay > 0 ? restday.RestDayPay : 0;
							data.LegalHolidayRestDayND 			 += restday.RestDayPayND > 0 ? restday.RestDayPayND : 0;
							data.LegalHolidayRestDayOvertime   	 += restday.RestDayOvertime > 0 ? restday.RestDayOvertime : 0;
							data.LegalHolidayRestDayOvertimeND 	 += restday.RestDayOvertimeND > 0 ? restday.RestDayOvertimeND : 0;
						}else{
							data.SpecialHolidayRestDay 			 += restday.RestDayPay > 0 ? restday.RestDayPay : 0;
							data.SpecialHolidayRestDayND 		 += restday.RestDayPayND > 0 ? restday.RestDayPayND : 0;
							data.SpecialHolidayRestDayOvertime   += restday.RestDayOvertime > 0 ? restday.RestDayOvertime : 0;
							data.SpecialHolidayRestDayOvertimeND += restday.RestDayOvertimeND > 0 ? restday.RestDayOvertimeND : 0;
						}
					}else{
						data.RestDayOvertime 	+= restday.RestDayOvertime > 0 ? restday.RestDayOvertime : 0;
						data.RestDayOvertimeND 	+= restday.RestDayOvertimeND > 0 ? restday.RestDayOvertimeND : 0;
						data.RestDayPay 		+= restday.RestDayPay > 0 ? restday.RestDayPay : 0;
						data.RestDayPayND 		+= restday.RestDayPayND > 0 ? restday.RestDayPayND : 0;
					}

				}
			}
		}

		if(dispute.length){
			for(let d in dispute){
				let number = dispute[d]['hour'];
				if(dispute[d]['type'] == 1){
					data.disputeRestDay += number;
				}
				if(dispute[d]['type'] == 2){
					data.disputeOvertime += number;
				}
				if(dispute[d]['type'] == 3){
					data.disputeLeave += number;
				}
				if(dispute[d]['type'] == 4){
					data.disputeNolog += number;
				}
			}
		}

		return data;
	}

	this.restDay = function(object, start, end){
		let result = {};
		let base_number = parseInt(object.no_of_hours + 8);
		//console.log(object);
		let duration = moment.duration(end.diff(start));
			duration = duration.asHours();
			duration = Math.floor(duration);
		
		// Has overtime if duration
		// is greater than base number
		if(duration > base_number){
			let start_date = start;

			let end_date = moment(start);
				end_date = end_date.add(base_number, 'hours');

			let overtime_start = end_date;
				overtime_start = moment(overtime_start);
			let overtime_end = end;
				overtime_end = moment(overtime_end);

			let otDuration = moment.duration(overtime_end.diff(overtime_start));
				otDuration = otDuration.asHours();
				otDuration = Math.floor(otDuration);
			
			let restDayNDOT = this.NightShift(overtime_start, overtime_end);
			let restDayND = this.NightShift(start_date, end_date);

			result.RestDayOvertime = otDuration;
			result.RestDayOvertimeND = restDayNDOT;
			result.RestDayPay = 8;
			result.RestDayPayND = restDayND;
		}else{
			let start_date = start;
			let end_date = moment(start);
				end_date = end_date.add(base_number, 'hours');
			let NightShift = this.NightShift(start_date, end_date);
			
			result.RestDayPay = duration > 5 ? duration - object.no_of_hours : duration;
			result.RestDayPayND = NightShift;
		}
		
		return result;
	}

	/*
	|-----------------------------------------------------------
	| Holiday Night Shift
	|-----------------------------------------------------------
	*/
	this.holidayND = function(holiday, start_date, end_date){
		let nd = this.NightShift(start_date, end_date);
		let result = {}

		let start_night = '22:00:00';
		let end_night 	= '06:00:00';
		let start_day 	= '00:00:00';
		let end_day		= '23:59:59';

		let start = start_date;
		let end = end_date;
		if(!(moment(start_date).format('YYYY-MM-DD') == moment(end_date).format('YYYY-MM-DD'))){
			end = new Date(end_date);
			end.setHours(00);
			end.setMinutes(00);
			end.setSeconds(00);
		}
		let holidayND = this.NightShift(start, end);
		
		result = {
			'holiday_nd': holidayND,
			'nd': nd - holidayND
		}
		return result;
	}


	/*
	|-----------------------------------------------------------
	| Holiday
	|-----------------------------------------------------------
	*/
	this.holiday = function(max, type, holiday, start_date, end_date, onsite){
		let result 	= 0;
		let legal 	= 0;
		let special = 0;
		//console.log(end_date);
		if(start_date && end_date){
			let set_holiday_date = moment(holiday).format('YYYY-MM-DD');
			let set_start_date = moment(start_date).format('YYYY-MM-DD');
			let set_end_date = moment(end_date).format('YYYY-MM-DD');
			let start = '';
			let end = '';
			if(set_holiday_date == set_start_date && set_holiday_date == set_end_date){
				start = new Date(start_date);
				end = new Date(end_date);
			}else if(set_holiday_date == set_start_date && set_holiday_date != set_end_date){
				start = new Date(start_date);
				end = new Date(end_date);
				end.setHours(00);
				end.setMinutes(00);
				end.setSeconds(00);
			}else if(set_holiday_date != set_start_date && set_holiday_date == set_end_date){
				start = new Date(end_date);
				start.setHours(00);
				start.setMinutes(00);
				start.setSeconds(00);
				end = new Date(end_date);
			}

			start = moment(start);
			end = moment(end);
			let duration = moment.duration(end.diff(start));
				duration = duration.asHours();
				duration = duration > 0 ? duration : 0;
				duration = Math.floor(duration);
				/*
				if(duration <= 4){
					duration = duration;
				}else{
					duration = duration - 1;
					duration = duration > max ? max : duration;
				}
				*/
				duration = duration > max ? max : duration;
			result = duration;
			//console.log(start, end, result);
		}else{
			//IF Onsite
			if(onsite == 1){
				result = 8;
			}
		}
		if(type == 1){
			legal = result;
		}
		if(type == 2){
			special = result;
		}
		let data = {
			legal: legal,
			special: special,
		}
		//console.log(data);
		return data;
	}

	/*
	|-----------------------------------------------------------
	| Night Diffirential
	|-----------------------------------------------------------
	*/
	this.NightShift = function(start_date, end_date){
		let start_work = new Date(start_date);
		let end_work = new Date(end_date);
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
					start.setHours(22);
					start.setMinutes(00);
					start.setSeconds(00);
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
							start.setHours(22);
							start.setMinutes(00);
							start.setSeconds(00);

							end   = end_work;
							end.setHours(06);
							end.setMinutes(00);
							end.setSeconds(00);
						}
					}
				}
				if(start && end){
					start = moment(start);
					end   = moment(end);
					let duration = moment.duration(end.diff(start));
					result = duration.asHours();
					result = result > 0 ? Math.floor(result) : 0;
				}
			}else{
				start = start_work;
				end   = end_work;
				if(end_work_time >= end_night && end_work_time < start_night){
					end.setHours(06);
					end.setMinutes(00);
					end.setSeconds(00);
				}
				start = moment(start);
				end   = moment(end);
				let duration = moment.duration(end.diff(start));
				result = duration.asHours();
				result = result > 0 ? Math.floor(result) : 0;
				if(start_work_time < end_night && end_work_time > start_night){
					result = result - 16;
				}				
			}

			
		}
		result = parseInt(result) > 16 ? (parseInt(result) - 16) : result;

		return result;
	}

	/*
	|-----------------------------------------------------------
	| Calculate Absent
	|-----------------------------------------------------------
	*/
	this.absent = function(leave, onsite, shift, type, start_date, end_date, holiday_off){
		let absent = 0;
		if(onsite == 0 && (!start_date && !end_date)){
			//let leave = leaves_dates
			let object = leave.find(obj => obj.date == shift.date);
			
			if(!(object && object.leave && object.leave.primary_status == 2 && object.leave.credit == 1)){
				absent = 1;
			}
			
		}
		return absent;
	}

	/*
	|-----------------------------------------------------------
	| Lates/Undertime
	|-----------------------------------------------------------
	*/
	this.lateUndertime = function(leave, shift, start_date, end_date, setting){
		let grace_period = parseInt(setting.grace_period) + 1;	// Consider seconds after the minute grace period
		let halfDayinMinutes = parseInt(setting.halfDayinMinutes);
		let login = 0;
		let logout = 0;
		let late = 0;
		let undertime = 0;
		if(shift.onsite == 0){
			//FIX
			if(shift.type == 1){
				//Has Check in
				if(shift.actual_check_in){
					let check_in = new Date(shift.date +' '+ shift.check_in.toLocaleTimeString());
						check_in = moment(check_in);
						check_in = check_in.add(grace_period, 'minutes');
						check_in = check_in.format('YYYY-MM-DD HH:mm:ss');
						
						console.log(start_date , new Date(check_in));
					if(new Date(start_date) > new Date(check_in)){

					
						//Calculate Diffirence in minute
						let date1 = moment(check_in);
						let date2 = moment(start_date);
						let duration = moment.duration(date2.diff(date1));
							duration = duration.asMinutes();
							duration = parseInt(duration + grace_period);
						if(duration > halfDayinMinutes){
							let object = leave.find(obj => obj.date == shift.date);
			
							if(!(object && object.leave && object.leave.primary_status == 2 && object.leave.credit == 1)){
								login = 0.5;
							}
						}else{
							late = duration;
						}
					}
				}else{
					//If no login, check setting if halfday or not
					login = setting.noLog == 1 ? 0.5 : 1;
				}
				//Has Logout
				if(shift.actual_check_out){
					let check_out = new Date(shift.date +' '+ shift.check_out);
					if(shift.check_in > shift.check_out){
						check_out = moment(check_out);
						check_out = check_out.add(1, 'days');
						check_out = check_out.format('YYYY-MM-DD HH:mm:ss');
					}
					//console.log(end_date);
					if(new Date(end_date) < check_out){
						let date1 = moment(end_date);
						let date2 = moment(check_out);
						let duration = moment.duration(date2.diff(date1));
							duration = duration.asMinutes();
							duration = parseInt(duration);
						if(duration > halfDayinMinutes){
							let object = leave.find(obj => obj.date == shift.date);
			
							if(!(object && object.leave && object.leave.primary_status == 2 && object.leave.credit == 1)){
								logout = 0.5;
							}
						}else{
							undertime = duration;
						}
					}
				}else{
					logout = setting.noLog == 1 ? 0.5 : 1;
				}
			}else if(shift.type == 2){ //Flexible
				if(start_date && end_date){
					let base = shift.shift_length;
						base = parseInt(base * 60);
					//console.log(base);
					let date1 = moment(start_date);
					let date2 = moment(end_date);
					let duration = moment.duration(date2.diff(date1));
						duration = duration.asMinutes();
						duration = parseInt(duration);
					if(duration < base){
						duration = parseInt(base - duration);
						if(duration > halfDayinMinutes){
							let object = leave.find(obj => obj.date == shift.date);
			
							if(!(object && object.leave && object.leave.primary_status == 2 && object.leave.credit == 1)){
								logout = 0.5;
							}
						}else{
							late = duration;
						}
					}
				}else{
					if(!shift.actual_check_in){
						login = setting.noLog == 1 ? 0.5 : 1;
					}
					if(!shift.actual_check_out){
						logout = setting.noLog == 1 ? 0.5 : 1;
					}
				}
			}else{ // Semi Flexible
				let check_out = new Date(shift.date +' '+ shift.between_start);
					check_out = moment(check_out);
					check_out = check_out.add(shift.shift_length, 'hours');
					check_out = new Date(check_out);
				if(shift.actual_check_in){
					let check_in = new Date(shift.date +' '+ shift.between_end);
					if(start_date > check_in){
						let date1 = moment(check_in);
						let date2 = moment(start_date);
						let duration = moment.duration(date2.diff(date1));
							duration = duration.asMinutes();
							duration = parseInt(duration);
						if(duration > halfDayinMinutes){
							let object = leave.find(obj => obj.date == shift.date);
			
							if(!(object && object.leave && object.leave.primary_status == 2 && object.leave.credit == 1)){
								login = 0.5;
							}
						}else{
							late = duration;
						}
					}
				}else{
					login = setting.noLog == 1 ? 0.5 : 1;
				}

				if(shift.actual_check_out){
					if(end_date < check_out){
						let date1 = moment(end_date);
						let date2 = moment(check_out);
						let duration = moment.duration(date2.diff(date1));
							duration = duration.asMinutes();
							duration = parseInt(duration);
						if(duration > halfDayinMinutes){
							let object = leave.find(obj => obj.date == shift.date);
			
							if(!(object && object.leave && object.leave.primary_status == 2 && object.leave.credit == 1)){
								logout = 0.5;
							}
						}else{
							undertime = duration;
						}
					}
				}else{
					logout = setting.noLog == 1 ? 0.5 : 1;
				}
			}
		}
		
		let data = {
			lates: parseInt(late) + parseInt(undertime),
			absent: parseInt(login) + parseInt(logout)
		}
		//console.log(data);
		return data;
	}


	this.setDate = function(type, shift, setting){
		let start_date = '';
		let end_date = '';
		let check_in  	= new Date(shift.date +' '+ shift.check_in);
		let check_out 	= new Date(shift.date +' '+ shift.check_out);
		let time_in 	= '';
		let time_out 	= '';
		if(type == 1){ //FIX
			if(shift.actual_check_in && shift.actual_check_out){
				time_in   = shift.date +' '+ shift.actual_check_in;
				time_out   = shift.date +' '+ shift.actual_check_out;
			}else if(shift.actual_check_in && !shift.actual_check_out){
				if(setting.noLog == 1){
					time_in   = shift.date +' '+ shift.actual_check_in;
					time_out  = new Date(time_in) >= check_in ? new Date(time_in) : check_in;
					time_out  = moment(time_out);
					time_out  = time_out.add(4, 'hours');
					time_out  = time_out.format('YYYY-MM-DD HH:mm:ss');
				}
			}else if(!shift.actual_check_in && shift.actual_check_out){
				if(setting.noLog == 1){
					time_out   = shift.date +' '+ shift.actual_check_out;
					time_in  = new Date(time_out) <= check_out ? new Date(time_out) : check_out;
					time_in  = moment(time_in);
					time_in  = time_in.subtract(4, 'hours');
					time_in  = time_in.format('YYYY-MM-DD HH:mm:ss');
				}
			}
			if(time_in && time_out){
				start_date = new Date(time_in) >= check_in ? new Date(time_in) : check_in;
				start_date = moment(start_date).format('YYYY-MM-DD HH:mm:ss');
				end_date   = new Date(time_out) <= check_out ? new Date(time_out) : check_out;
				end_date   = moment(end_date).format('YYYY-MM-DD HH:mm:ss');
				if(new Date(end_date) < new Date(start_date)){
					end_date = moment(end_date);
					end_date = end_date.add(1,'days');
					end_date = end_date.format('YYYY-MM-DD HH:mm:ss');
				}
			}
		}else if(type == 2){ //Flexible
			if(shift.actual_check_in && shift.actual_check_out){
				time_in   = shift.date +' '+ shift.actual_check_in;
				time_out   = shift.date +' '+ shift.actual_check_out;
			}else if(shift.actual_check_in && !shift.actual_check_out){
				if(setting.noLog == 1){
					time_in   = shift.date +' '+ shift.actual_check_in;
					time_out  = new Date(time_in);
					time_out  = moment(time_out);
					time_out  = time_out.add(4, 'hours');
					time_out  = time_out.format('YYYY-MM-DD HH:mm:ss');
				}
			}else if(!shift.actual_check_in && shift.actual_check_out){
				if(setting.noLog == 1){
					time_out   = shift.date +' '+ shift.actual_check_out;
					time_in  = new Date(time_out);
					time_in  = moment(time_in);
					time_in  = time_in.subtract(4, 'hours');
					time_in  = time_in.format('YYYY-MM-DD HH:mm:ss');
				}
			}
			if(time_in && time_out){
				start_date = new Date(time_in);
				end_date   = new Date(time_out);
			}
		}else{//Semi Flexible
			let start = new Date(shift.date +' '+ shift.between_start);
			let end = new Date(shift.date +' '+ shift.between_end);
			if(end < start){
				end = moment(end);
				end = end.add(1, 'days');
				end = end.format('YYYY-MM-DD HH:mm:ss');
				end = new Date(end);
			}

			if(shift.actual_check_in && shift.actual_check_out){
				time_in   = shift.date +' '+ shift.actual_check_in;
				time_out   = shift.date +' '+ shift.actual_check_out;
			}else if(shift.actual_check_in && !shift.actual_check_out){
				if(setting.noLog == 1){
					time_in   = shift.date +' '+ shift.actual_check_in;
					if(new Date(time_in) < start){
						time_out = start;
					}else if(new Date(time_in) >= start && new Date(time_in) <= end){
						time_out = time_in;
					}else if(new Date(time_in) > end){
						time_out = end;
					}
					time_out = moment(time_out);
					time_out  = time_out.add(4, 'hours');
					time_out  = time_out.format('YYYY-MM-DD HH:mm:ss');
				}
			}else if(!shift.actual_check_in && shift.actual_check_out){
				if(setting.noLog == 1){
					time_out   = shift.date +' '+ shift.actual_check_out;
					time_in  = new Date(time_out);
					time_in  = moment(time_in);
					time_in  = time_in.subtract(4, 'hours');
					time_in  = time_in.format('YYYY-MM-DD HH:mm:ss');
				}
			}
			if(time_in && time_out){
				start_date = new Date(time_in);
				end_date   = new Date(time_out);
			}
		}
		let obj = {
			start_date: start_date,
			end_date: end_date
		}
		return obj;
	}

	this.findHoliday = function(array, date){
		let result = array.find(obj => obj.date == date);
		return result ? result : null;
	}

	this.setOvertimeEnd = function(array, date, end_date){
		let result = array.find(obj => obj.date == date);
		let data = '';
		if(result){
			data = new Date(end_date +' '+ result.actual_check_out);
			data = moment(data);
		}
		return data;
	}
}

module.exports = new Main();