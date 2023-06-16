const Excel = require('exceljs');
const conversion = require("phantom-html-to-pdf")();
const fs = require('fs');
const UserRole = require('../Helper/UserRole');
const TSSHelper = require('../Helper/TSSHelper');
const TSSDataHelper = require('../Helper/TSSDataHelper');
const TimeKeeping = require('../Helper/TimeKeeping/Main');
const OvertimeHelper= require('../Helper/OvertimeHelper');
const AttendanceHelper= require('../Helper/AttendanceHelper');
const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const _ = require('underscore');
const DTR = require('../Scheduler/DTR');
const {
	Op,
	UsersModel,
	BranchesModel,
	CompanyModel,
	TaxonomyModel,
	ShiftsModel,
	ConfigModel,
	LeavesModel,
	LeaveDateModel,
	OvertimesModel,
	HolidaysModel,
	UserSettingModel,
	EmploymentsModel,
	Division,
	Department,
	Section,
	Position,
	PositionClassification,
	PositionCategory,
	WorkArea,
	ShiftType,
	LeavePolicyModel,
	TSSData,
	BiometricLog
} = require('../../config/Sequelize');


exports.index = function(req, res){
	// TSSDataHelper.process();
	// TSSHelper.process();
	// OvertimeHelper.process();
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		UserRole.get_role(user, 'attendance-summary').then(function(data){
			user_role = data;
			if(!(user_role.read || res.locals.isSupervisor > 0)){
				res.render('Errors/403');
			}else{
				res.render('Attendance/Summary/index',{
					route: 'attendance-summary',
					usrRole: usrRole,
					user_role: user_role
				});
			}
		});
	});
}


exports.download = function(req, res){
	let user = res.locals.user;
	let isSupervisor = res.locals.isSupervisor;
	let isHRGeneralist = res.locals.isHRGeneralist
	let company = req.query.company ? req.query.company : '';
	let division = req.query.division ? req.query.division : '';
	let department = req.query.department ? req.query.department : '';
	let section = req.query.section ? req.query.section : '';
	let start_date = req.query.start ? res.locals.moment(new Date( req.query.start )).format('YYYY-MM-DD') :  null;
	let end_date = req.query.end ? res.locals.moment(new Date( req.query.end )).format('YYYY-MM-DD') :  null;
	let absenteeism = req.query.absenteeism ?  req.query.absenteeism : '';
	let key = req.query.key;
	let option = req.query.option;
	let limit = req.query.limit ? req.query.limit : 25;
	
	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		
		let cutoff = json.cutoff;
		let month_date = req.query.month_date;
		let period = req.query.period;
		if(req.query.filter == 2 && month_date && period){
			
			let start = '';
			let end = '';
			month_date = moment(new Date(month_date)).format('YYYY-MM');

			if(period =='A'){
				start = month_date+'-'+cutoff.A_from;
				start = moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.A_to;
				end = moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}else{
				start = month_date+'-'+cutoff.B_from;
				start = moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.B_to;
				end = moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}
			start_date = start;
			end_date = end;
		}
		
		let where = {};
		let whereUser = {};
		
		if(company){
			where.company_id = company;
		}
		if(division){
			where.division_id = division;
		}
		if(department){
			where.department_id = department;
		}
		if(section){
			where.section_id = section;
		}
		
		EmploymentsModel.findAll({
			where: where,
			include:[
				{
					model: CompanyModel,
					as: 'company'
				},{
					model: Division,
					as: 'division',
					include: [
						{
							model: UsersModel,
							as: 'manager',
							attributes:['first_name','last_name']
						}
					]
				},{
					model: Department,
					as: 'department',
					include: [
						{
							model: UsersModel,
							as: 'manager',
							attributes:['first_name','last_name']
						}
					]
				},{
					model: Section,
					as: 'section',
					include: [
						{
							model: UsersModel,
							as: 'supervisor',
							attributes:['first_name','last_name']
						}
					]
				},{
					model: Position,
					as: 'position'
				},{
					model: PositionClassification,
					as: 'position_classification'
				},{
					model: PositionCategory,
					as: 'position_category'
				},{
					model: WorkArea,
					as: 'work_area'
				}
			],
			raw: false
		}).then(function(data){
			employment = data;
			let whereUserFilter = {};
			
			if(isSupervisor > 0){
				whereUserFilter[Op.or] = {
					approver_id: user.id,
					secondary_approver_id: user.id,
					secretary_id: user.id,
					alternate_secretary: user.id,
				}
			}
			if(isHRGeneralist > 0){
				whereUserFilter = {
					hr_generalist_id: user.id,
				}
			}
			
			return UsersModel.findAll({
				where: whereUserFilter,
				attributes: ['id'],
				raw: true
			});
			}).then(function(data){
				userIDS = data;
				userIDS = _.pluck(userIDS, 'id');
				return UserRole.get_role(user, 'attendance-shift');
			}).then(function(data){
				user_role = data;
				let user_id = [];
				if(employment && employment.length){
					for(let i in employment){
						user_id.push(employment[i].user_id);
					}
				}
				user_id = [...new Set(user_id)];
				
				if(!_.isEmpty(where)){
					whereUser.id = {
						[Op.in]: user_id
					}
				}
				if(user_role.modify){
					if(!_.isEmpty(where)){
						whereUser.id = {
							[Op.in]: user_id
						}
					}
				}else if(isSupervisor > 0){
					whereUser.id = {
						[Op.in]: userIDS
					}
				}else if(isHRGeneralist > 0){
					whereUser.id = {
						[Op.in]: userIDS
					}
				}
				
				if(key) {
					whereUser[Op.or] = {
						first_name : {
							[Op.like] : '%'+ key +'%'
						},
						last_name : {
							[Op.like] : '%'+ key +'%'
						},
						middle_name : {
							[Op.like] : '%'+ key +'%'
						},
						email : {
							[Op.like] : '%'+ key +'%'
						},
						username : {
							[Op.like] : '%'+ key +'%'
						},
						employee_number : {
							[Op.like] : '%'+ key +'%'
						},
					}
				}

				// whereUser support on display of resigned employees
				whereUser.resignation_date = {
					[Op.or] : {
						[Op.gte]: start_date,
						[Op.eq]: null
					}
				}
		
			return UsersModel.count({
				where: whereUser
			}).then(function(data){				
				numrows = data;
				return UsersModel.findAll({
					where: whereUser,
					include: [
						{
							model: ShiftsModel,
							required: false,
							include: [
								{
									model: TSSData,
									as: 'tss'
								}
							],
							where: {
								//primary_status: 2,
								date: {
									$between: [start_date, end_date]
								}
							},
							// attributes: ['id','user_id','type','date','check_in','check_out','actual_check_in','actual_check_out','between_start','between_end','shift_length','paid_hours', 'onsite', 'reg_holiday_work_hrs', 'reg_holiday_rest_day_work_hrs', 'reg_special_holiday_restday_work_hrs', 'double_reg_holiday', 'special_holiday', 'special_holiday_restday', 'late', 'absent', 'undertime', 'awol', 'actual_work_hours'],
							order: [
								['date','asc']
							],
							separate: true,
						},
						{
							model: OvertimesModel,
							required: false,
							where: {
								primary_status: 2,
								start_date: {
									$between: [start_date, end_date]
								}
							},
							attributes: ['type','start_date','end_date','start_time','end_time','actual_check_in','actual_check_out','no_of_hours']
						},
						{
							model: LeaveDateModel,
							required: false,
							where: {
								date: {
									$between: [start_date, end_date]
								}
							},
							include: [
								{
									model: LeavesModel,
									where: {
										primary_status: 2
									},
									attributes: ['start_date','leave_type','no_of_days','credit','primary_status']
								}
							]
						},
						{
							model: UserSettingModel,
							required: false
						}
					],
					order: [
						['last_name','asc']
					],
					attributes: ['id','shortid','employee_number','first_name','last_name','company_branch_id','department_id','job_title_id','salary_type'],
					// offset: offset,
				// 	limit: limit,
				});

			}).then(function(data){
				shifts = data;
				return LeavePolicyModel.findAll({
					attributes: ['id', 'name'],
					raw: true
				});
			}).then(function(data){
				leave_policy = data;
				return ShiftType.findAll({
					attributes: ['id', 'shift_id','shift_desc'],
					raw: true
				});
			}).then(function(data){
				shift_types = data;
				return HolidaysModel.findAll({
					where: {
						country_id: 177,
						status: 1,
						date: {
							$between: [start_date, end_date]
						}
					},
					attributes: ['date','type']
				});
			}).then(function(data){
				holiday = data;
				if(limit < numrows){
					count = numrows / limit;
					count = Math.ceil(count);
				}else{
					count = 0;
				}
				let summary = TimeKeeping.calculate(shifts, holiday, '', absenteeism);

		  			//Initiate Excel
					let filenameStartDate = moment(start_date).format('MMM DD');
					let filenameEndDate = moment(end_date).format('MMM DD');
					let filenameYear = moment(end_date).format('YYYY');
					let filenamePrefix = option == 1 ? "DTR (" : "DTR Summary (";
		  			let filename  = filenamePrefix + filenameStartDate + " - " + filenameEndDate + ")-" + filenameYear;

		  			if(option == 1){
			  			let workbook  = new Excel.Workbook();
			  			let sheet     = workbook.addWorksheet(filename);
			  			let border = {
							top:    { style:'thin' },
						    left:   { style:'thin' },
						    bottom: { style:'thin' },
						    right:  { style:'thin' },
						}
						let fill = {
							type: 'pattern',
					        pattern:'solid',
							fgColor:{argb:'ffff00'},
						    bgColor:{argb:'ffff00'}
						}
						let shift_schedule_fill = {
							type: 'pattern',
					        pattern:'solid',
							fgColor:{argb:'04ac54'},
						    bgColor:{argb:'04ac54'}
						}
						let align_center = {
							vertical: 'middle',
							horizontal: 'left'
						}
						let text_font = {
							name: 'Calibri',
							size: 8,
							bold: true
						}

						var columns = [
							{ header: '', key: 'col1', width: 5},
							{ header: '', key: 'col2', width: 10},
							{ header: '', key: 'col3', width: 15},
							{ header: '', key: 'col4', width: 10},
							{ header: '', key: 'col5', width: 15},
							{ header: '', key: 'col6', width: 10},
							{ header: '', key: 'col7', width: 10},
							{ header: '', key: 'col8', width: 50},
							{ header: '', key: 'col9', width: 20},
							{ header: '', key: 'col10', width: 20},
							{ header: '', key: 'col11', width: 10},
							{ header: '', key: 'col12', width: 22},
							{ header: '', key: 'col13', width: 10},
						];

						var center = {
							horizontal: 'center'
						}

						var middleCenter = {
							vertical: 'middle', 
							horizontal: 'center'
						}

						workbook.eachSheet(function(worksheet, sheetId) {
							worksheet.views = [
							    {
							    	//state: 'frozen'
							    }
							];
							worksheet.columns = columns;

							
							if(summary.length){
								let employeeHeader = 13;
								let summaryStart = 2;
								let countSummary = 0;
								let next = 4;
								let i = 0;
									
								let start = moment(start_date);
								let end = moment(end_date);
								var duration = moment.duration(end.diff(start));
								var days = duration.asDays();
								
								
								let row2Details = [];
								let row3Details = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
								let row4Details = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
								row2Details.push('','SN','EMP ID','FAMILY NAME','FIRST NAME','MIDDLE NAME','SUFFIX','POSITION','DIVISION','DEPARTMENT','UNIT','DEPARTMENT MANAGER\'S NAME','RATE TYPE');
								
								
								for(ctr=0; ctr<days + 1; ctr++) {
									//console.log(ctr);
									var new_date = moment(start_date, "YYYY-MM-DD").add('days', ctr);
									let date = moment(new_date).format('MMMM DD, YYYY - ddd');
									row2Details.push(date.toString().toUpperCase(), '', '');
									row3Details.push('SHIFT ID', 'SHIFT DESCRIPTION', '');
									row4Details.push('', 'TIME IN', 'TIME OUT');
									//console.log(date.toString().toUpperCase());
								}

								worksheet.addRow(['','EMPLOYEE DETAILS','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', 'REGULAR SHIFT SCHEDULE']);
								worksheet.addRow(row2Details);
								worksheet.addRow(row3Details);
								worksheet.addRow(row4Details);
								summaryStart += next + 1;
								


								let headStart = summaryStart - next - 1;
								let employeeMerge = headStart + 1;
								//console.log(headStart, shifts.length, summaryStart, next, employeeMerge);
								
								let regularShiftScheduleEndHeader = convertToColumnLetter(employeeHeader + ((days + 1) * 3));

								worksheet.mergeCells('B'+ headStart, 'M'+ headStart);
								worksheet.mergeCells('B'+ 3, 'B'+ 5);
								worksheet.mergeCells('C'+ 3, 'C'+ 5);
								worksheet.mergeCells('D'+ 3, 'D'+ 5);
								worksheet.mergeCells('E'+ 3, 'E'+ 5);
								worksheet.mergeCells('F'+ 3, 'F'+ 5);
								worksheet.mergeCells('G'+ 3, 'G'+ 5);
								worksheet.mergeCells('H'+ 3, 'H'+ 5);
								worksheet.mergeCells('I'+ 3, 'I'+ 5);
								worksheet.mergeCells('J'+ 3, 'J'+ 5);
								worksheet.mergeCells('K'+ 3, 'K'+ 5);
								worksheet.mergeCells('L'+ 3, 'L'+ 5);
								worksheet.mergeCells('M'+ 3, 'M'+ 5);
								worksheet.mergeCells('N'+ headStart, regularShiftScheduleEndHeader + headStart);
								
								//Header Border
								worksheet.getCell('B'+ headStart).border = border;
								worksheet.getCell('B'+ 3).border = border;
								worksheet.getCell('C'+ 3).border = border;
								worksheet.getCell('D'+ 3).border = border;
								worksheet.getCell('E'+ 3).border = border;
								worksheet.getCell('F'+ 3).border = border;
								worksheet.getCell('G'+ 3).border = border;
								worksheet.getCell('H'+ 3).border = border;
								worksheet.getCell('I'+ 3).border = border;
								worksheet.getCell('J'+ 3).border = border;
								worksheet.getCell('K'+ 3).border = border;
								worksheet.getCell('L'+ 3).border = border;
								worksheet.getCell('M'+ 3).border = border;
								worksheet.getCell('N'+ headStart).border = border;

								//Header Alignment
								worksheet.getCell('B'+ headStart).alignment = middleCenter;
								worksheet.getCell('B'+ 3).alignment = middleCenter;
								worksheet.getCell('C'+ 3).alignment = middleCenter;
								worksheet.getCell('D'+ 3).alignment = middleCenter;
								worksheet.getCell('E'+ 3).alignment = middleCenter;
								worksheet.getCell('F'+ 3).alignment = middleCenter;
								worksheet.getCell('G'+ 3).alignment = middleCenter;
								worksheet.getCell('H'+ 3).alignment = middleCenter;
								worksheet.getCell('I'+ 3).alignment = middleCenter;
								worksheet.getCell('J'+ 3).alignment = middleCenter;
								worksheet.getCell('K'+ 3).alignment = middleCenter;
								worksheet.getCell('L'+ 3).alignment = middleCenter;
								worksheet.getCell('M'+ 3).alignment = middleCenter;
								worksheet.getCell('N'+ headStart).alignment = middleCenter;
								
								//Header Background
								worksheet.getCell('B'+ headStart).fill = fill;
								worksheet.getCell('B'+ 3).fill = fill;
								worksheet.getCell('C'+ 3).fill = fill;
								worksheet.getCell('D'+ 3).fill = fill;
								worksheet.getCell('E'+ 3).fill = fill;
								worksheet.getCell('F'+ 3).fill = fill;
								worksheet.getCell('G'+ 3).fill = fill;
								worksheet.getCell('H'+ 3).fill = fill;
								worksheet.getCell('I'+ 3).fill = fill;
								worksheet.getCell('J'+ 3).fill = fill;
								worksheet.getCell('K'+ 3).fill = fill;
								worksheet.getCell('L'+ 3).fill = fill;
								worksheet.getCell('M'+ 3).fill = fill;
								worksheet.getCell('N'+ headStart).fill = shift_schedule_fill;
								
								//Text Font
								worksheet.getCell('B'+ headStart).font = text_font;
								worksheet.getCell('B'+ 3).font = text_font;
								worksheet.getCell('C'+ 3).font = text_font;
								worksheet.getCell('D'+ 3).font = text_font;
								worksheet.getCell('E'+ 3).font = text_font;
								worksheet.getCell('F'+ 3).font = text_font;
								worksheet.getCell('G'+ 3).font = text_font;
								worksheet.getCell('H'+ 3).font = text_font;
								worksheet.getCell('I'+ 3).font = text_font;
								worksheet.getCell('J'+ 3).font = text_font;
								worksheet.getCell('K'+ 3).font = text_font;
								worksheet.getCell('L'+ 3).font = text_font;
								worksheet.getCell('M'+ 3).font = text_font;
								worksheet.getCell('N'+ headStart).font = text_font;

								for(ctr=0; ctr<days + 1; ctr++) {
									//console.log("Ctr: ", ctr);
									// Date Time Header merge. Sample (NOVEMBER 26, 2018 - MON)
									//console.log((ctr * 3) + 1);
									worksheet.mergeCells(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3,
														 convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 3);
									// //SHIFT ID Header merge
									worksheet.mergeCells(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4, 
														 convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 5);
									// //SHIFT DESCRIPTION Header merge
									worksheet.mergeCells(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4, 
														 convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 4);
														 
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 5).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 5).font = text_font;

									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).fill = shift_schedule_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).fill = shift_schedule_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).fill = shift_schedule_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 5).fill = shift_schedule_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 5).fill = shift_schedule_fill;
									
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 5).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 5).alignment = middleCenter;

									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 3).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 1) + 4).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 4).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 2) + 5).border = border;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 3) + 3) + 5).border = border;
								}
								
								let sumCount = summary.length;
								let recordsIDNumber = 0;
								
								for(let key in summary){
									recordsIDNumber++;
									let dtrRecords = [];
									let shifts = summary[key]['shifts'];
									let summaries = summary[key]['summary'];
									let shiftCount = shifts.length;
									
									let user_id = summary[key].id;
									let employementObject = employment.find(x => x.user_id === user_id)

									let manager = "";

									if(employementObject.approving_organization === 'division') {
										manager = employementObject.division.manager.first_name+' '+ employementObject.division.manager.last_name;
									} else if(employementObject.approving_organization === 'department') {
										manager = employementObject.department.manager.first_name+' '+ employementObject.department.manager.last_name;
									} else if(employementObject.approving_organization === 'section') {
										manager = employementObject.section.supervisor.first_name+' '+ employementObject.section.supervisor.last_name;
									}
									
									dtrRecords.push('', 
													recordsIDNumber, 
													summary[key]['employee_number'],
													summary[key]['last_name'],
													summary[key]['first_name'],
													summary[key]['middle_name'], 
													summary[key]['suffix'],
													employementObject.position ? employementObject.position.name:'-',
													employementObject.division ? employementObject.division.name:'-',
													employementObject.department ? employementObject.department.department_name:'-',
													employementObject.section ? employementObject.section.section_name:'-',
													manager,
													"MONTHLY");

									if(shiftCount){
										
										let startOf = moment(start_date).format('YYYY-MM-DD');
										let endOf = moment(end_date).format('YYYY-MM-DD');
										for (var m = moment(startOf); m.isBefore(endOf); m.add(1, 'days')) {
											let shift_type_name = 'REST DAY';
											let startDate = '0';
											let endDate = '0';
											let shftDate = m.format('YYYY-MM-DD');
											var findShift = shifts.filter(obj=>obj.date===shftDate);
											if(findShift.length){
												findShift = findShift[0];
												let shift_type = findShift.shift_type ? findShift.shift_type : '--';
												startDate = findShift.actual_check_in ? moment(findShift.actual_check_in).utc().format('hh:mmA') : '--';
												endDate = findShift.actual_check_out ? moment(findShift.actual_check_out).utc().format('hh:mmA') : '--';
												dtrRecords.push(shift_type, startDate, endDate);
											}else{
												dtrRecords.push(shift_type_name, startDate, endDate);
											}
										}
									}
									worksheet.addRow(dtrRecords);
								}
								let totalColumns = employeeHeader + ((days + 1) * 3);
								let dataStart = 6;
								
								for(let dataCol = 0; dataCol < sumCount; dataCol++){
									for(let dataRow = 1; dataRow < totalColumns; dataRow++) {
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).border = border;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).alignment = middleCenter;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).font = text_font;
									}
									dataStart++;
								}
								
							}
							
						});
						let path = 'assets/reports/timekeeping/'+ filename +'.xlsx';
						workbook.xlsx.writeFile(path).then(function() {
							res.download(path);
						});
					} else if (option == 2){
						let workbook  = new Excel.Workbook();
						let sheet     = workbook.addWorksheet(filename);
						let border = {
							top:    { style:'thin' },
							left:   { style:'thin' },
							bottom: { style:'thin' },
							right:  { style:'thin' },
						}
						let fill = {
							type: 'pattern',
							pattern:'solid',
							fgColor:{argb:'ffff00'},
							bgColor:{argb:'ffff00'}
						}
						let shift_schedule_fill = {
							type: 'pattern',
							pattern:'solid',
							fgColor:{argb:'04ac54'},
							bgColor:{argb:'04ac54'}
						}
						let align_center = {
							vertical: 'middle',
							horizontal: 'left'
						}
						let text_font = {
							name: 'Calibri',
							size: 8,
							bold: true
						}

						var columns = [
							{ header: '', key: 'col1', width: 5},
							{ header: '', key: 'col2', width: 10},
							{ header: '', key: 'col3', width: 15},
							{ header: '', key: 'col4', width: 10},
							{ header: '', key: 'col5', width: 15},
							{ header: '', key: 'col6', width: 10},
							{ header: '', key: 'col7', width: 10},
							{ header: '', key: 'col8', width: 50},
							{ header: '', key: 'col9', width: 20},
							{ header: '', key: 'col10', width: 20},
							{ header: '', key: 'col11', width: 10},
							{ header: '', key: 'col12', width: 22},
							{ header: '', key: 'col13', width: 10},
						];

						var center = {
							horizontal: 'center'
						}

						var middleCenter = {
							vertical: 'middle', 
							horizontal: 'center'
						}

						workbook.eachSheet(function(worksheet, sheetId) {
							worksheet.views = [
								{
									//state: 'frozen'
								}
							];
							worksheet.columns = columns;

							
							if(summary.length){
								let employeeHeader = 12;
								let summaryStart = 2;
								let countSummary = 0;
								let next = 4;
								let i = 0;
								let start = moment(start_date);
								let end = moment(end_date);
								var duration = moment.duration(end.diff(start));
								var days = duration.asDays();
								
								let row1Details = ['','EMPLOYEE DETAILS','', '', '', '', '', '', '', '', '', '', 'ATTENDANCE REPORT'];
								let row2Details = [];
								let row3Details = ['', '', '', '', '', '', '', '', '', '', '', ''];
								row2Details.push('','SN','EMP ID','FAMILY NAME','FIRST NAME','MIDDLE NAME','SUFFIX','POSITION','DIVISION','DEPARTMENT','SECTION','DEPARTMENT MANAGER\'S NAME');
								
								
								for(ctr=0; ctr<days + 1; ctr++) {
									//console.log(ctr);
									var new_date = moment(start_date, "YYYY-MM-DD").add('days', ctr);
									let date = moment(new_date).format('MMMM DD, YYYY - ddd');
									row1Details.push('', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
									row2Details.push(date.toString().toUpperCase(), '', '', '', '', '', '', '', '', '', '', '', '', '', '');
									row3Details.push('HW', 'HL', 'UT', 'OT', 'VL', 'SL', 'ML', 'PL', 'NSH', 'PTL', 'SIL', 'VAWCL', 'SLW', 'A', 'AA');
									//console.log(date.toString().toUpperCase());
								}
								row1Details.splice(-1);
								row1Details.push('TOTAL');
								row3Details.push('HW', 'HL', 'UT', 'OT', 'VL', 'SL', 'ML', 'PL', 'NSH', 'PTL', 'SIL', 'VAWCL', 'SLW', 'A', 'AA');
								
								worksheet.addRow(row1Details);
								worksheet.addRow(row2Details);
								worksheet.addRow(row3Details);
								summaryStart += next + 1;
								


								let headStart = summaryStart - next - 1;
								let employeeMerge = headStart + 1;
								let totalHeaderColumn = convertToColumnLetter(employeeHeader + ((days + 1) * 15) + 1);
								
								worksheet.mergeCells('B'+ headStart					, 'L'+ headStart);
								worksheet.mergeCells('B'+ 3		   					, 'B'+ 4);
								worksheet.mergeCells('C'+ 3		   					, 'C'+ 4);
								worksheet.mergeCells('D'+ 3		   					, 'D'+ 4);
								worksheet.mergeCells('E'+ 3		   					, 'E'+ 4);
								worksheet.mergeCells('F'+ 3		   					, 'F'+ 4);
								worksheet.mergeCells('G'+ 3		   					, 'G'+ 4);
								worksheet.mergeCells('H'+ 3		   					, 'H'+ 4);
								worksheet.mergeCells('I'+ 3		   					, 'I'+ 4);
								worksheet.mergeCells('J'+ 3		   					, 'J'+ 4);
								worksheet.mergeCells('K'+ 3		   					, 'K'+ 4);
								worksheet.mergeCells('L'+ 3		   					, 'L'+ 4);
								worksheet.mergeCells('M'+ headStart					, convertToColumnLetter(employeeHeader + ((days + 1) * 15)) + headStart);
								worksheet.mergeCells(totalHeaderColumn + headStart	, convertToColumnLetter(employeeHeader + ((days + 1) * 15) + 15) + headStart);
								
								//Header Border
								worksheet.getCell('B'+ headStart).border = border;
								worksheet.getCell('B'+ 3).border = border;
								worksheet.getCell('C'+ 3).border = border;
								worksheet.getCell('D'+ 3).border = border;
								worksheet.getCell('E'+ 3).border = border;
								worksheet.getCell('F'+ 3).border = border;
								worksheet.getCell('G'+ 3).border = border;
								worksheet.getCell('H'+ 3).border = border;
								worksheet.getCell('I'+ 3).border = border;
								worksheet.getCell('J'+ 3).border = border;
								worksheet.getCell('K'+ 3).border = border;
								worksheet.getCell('L'+ 3).border = border;
								worksheet.getCell('M'+ headStart).border = border;
								worksheet.getCell(totalHeaderColumn + headStart).border = border;

								//Header Alignment
								worksheet.getCell('B'+ headStart).alignment = middleCenter;
								worksheet.getCell('B'+ 3).alignment = middleCenter;
								worksheet.getCell('C'+ 3).alignment = middleCenter;
								worksheet.getCell('D'+ 3).alignment = middleCenter;
								worksheet.getCell('E'+ 3).alignment = middleCenter;
								worksheet.getCell('F'+ 3).alignment = middleCenter;
								worksheet.getCell('G'+ 3).alignment = middleCenter;
								worksheet.getCell('H'+ 3).alignment = middleCenter;
								worksheet.getCell('I'+ 3).alignment = middleCenter;
								worksheet.getCell('J'+ 3).alignment = middleCenter;
								worksheet.getCell('K'+ 3).alignment = middleCenter;
								worksheet.getCell('L'+ 3).alignment = middleCenter;
								worksheet.getCell('M'+ headStart).alignment = middleCenter;
								worksheet.getCell(totalHeaderColumn + headStart).alignment = middleCenter;
								
								//Header Background
								worksheet.getCell('B'+ headStart).fill = fill;
								worksheet.getCell('B'+ 3).fill = fill;
								worksheet.getCell('C'+ 3).fill = fill;
								worksheet.getCell('D'+ 3).fill = fill;
								worksheet.getCell('E'+ 3).fill = fill;
								worksheet.getCell('F'+ 3).fill = fill;
								worksheet.getCell('G'+ 3).fill = fill;
								worksheet.getCell('H'+ 3).fill = fill;
								worksheet.getCell('I'+ 3).fill = fill;
								worksheet.getCell('J'+ 3).fill = fill;
								worksheet.getCell('K'+ 3).fill = fill;
								worksheet.getCell('L'+ 3).fill = fill;
								worksheet.getCell('M'+ headStart).fill = shift_schedule_fill;
								worksheet.getCell(totalHeaderColumn + headStart).fill = shift_schedule_fill;
								
								//Text Font
								worksheet.getCell('B'+ headStart).font = text_font;
								worksheet.getCell('B'+ 3).font = text_font;
								worksheet.getCell('C'+ 3).font = text_font;
								worksheet.getCell('D'+ 3).font = text_font;
								worksheet.getCell('E'+ 3).font = text_font;
								worksheet.getCell('F'+ 3).font = text_font;
								worksheet.getCell('G'+ 3).font = text_font;
								worksheet.getCell('H'+ 3).font = text_font;
								worksheet.getCell('I'+ 3).font = text_font;
								worksheet.getCell('J'+ 3).font = text_font;
								worksheet.getCell('K'+ 3).font = text_font;
								worksheet.getCell('L'+ 3).font = text_font;
								worksheet.getCell('M'+ headStart).font = text_font;
								worksheet.getCell(totalHeaderColumn + headStart).font = text_font;

								for(ctr=0; ctr<days + 2; ctr++) {
									//console.log("Ctr: ", ctr);
									// Date Time Header merge. Sample (NOVEMBER 26, 2018 - MON)
									worksheet.mergeCells(convertToColumnLetter(employeeHeader + (ctr * 15) + 1) + 3,
														convertToColumnLetter(employeeHeader + (ctr * 15) + 15) + 3);	

									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + 1) + 3).font = text_font;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + 1) + 3).fill = shift_schedule_fill;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + 1) + 3).alignment = middleCenter;
									worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + 1) + 3).border = border;
									
									for(let summaryCtr = 1; summaryCtr < 16; summaryCtr++) {
										worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + summaryCtr) + 4).font = text_font;
										worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + summaryCtr) + 4).fill = shift_schedule_fill;
										worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + summaryCtr) + 4).alignment = middleCenter;
										worksheet.getCell(convertToColumnLetter(employeeHeader + (ctr * 15) + summaryCtr) + 4).border = border;
									}
								}

								let sumCount = summary.length;
								let recordsIDNumber = 0;

								for(let key in summary){
									recordsIDNumber++;
									let dtrRecords = [];
									let shifts = summary[key]['shifts'];
									let summaries = summary[key]['summary'];
									let shiftCount = shifts.length;
									let user_id = summary[key].id;
									let employementObject = employment.find(x => x.user_id === user_id)
									let leaveDates = summary[key]['leave_dates'];
									let overtimes = summary[key]['overtimes'];

									getLeaves(shifts, leaveDates, leave_policy);
									getOvertimes(shifts, overtimes);

									let manager = "";

									if(employementObject.approving_organization === 'division') {
										manager = employementObject.division.manager.first_name+' '+ employementObject.division.manager.last_name;
									} else if(employementObject.approving_organization === 'department') {
										manager = employementObject.department.manager.first_name+' '+ employementObject.department.manager.last_name;
									} else if(employementObject.approving_organization === 'section') {
										manager = employementObject.section.supervisor.first_name+' '+ employementObject.section.supervisor.last_name;
									}
									dtrRecords.push('', 
													recordsIDNumber, 
													summary[key]['employee_number'],
													summary[key]['last_name'],
													summary[key]['first_name'],
													summary[key]['middle_name'], 
													summary[key]['suffix'],
													employementObject.position ? employementObject.position.name:'-',
													employementObject.division ? employementObject.division.name:'-',
													employementObject.department ? employementObject.department.department_name:'-',
													employementObject.section ? employementObject.section.section_name : '',
													manager);

									if(shiftCount){
										let daysIncremental = 0;
										var new_start_date = "";

										// DTR Related
										let hoursWorked = 0;
										let hoursLate = 0;
										let underTime = 0;
										let overtime = 0;
										//awol
										let absent = 0;
										let authorizedAbsence = 0;
										let nightShiftHours = 0;

										// Leaves
										// change value base on leave_policy (ID)
										let vacationLeave = 0; // 1
										let sickLeave = 0; // 3
										let maternityLeave = 0; // 2
										let paternityLeave = 0; // 4
										let parentalLeave = 0; // 7
										let serviceIncentiveLeave = 0; // 8
										//violence against women and children leave
										let vawacL = 0; // 9
										let specialLeaveForWomen = 0; // 10
										
										let hoursWorkedTotal = 0;
										let hoursLateTotal = 0;
										let underTimeTotal = 0;
										let overtimeTotal = 0;
										let vacationLeaveTotal = 0; 
										let sickLeaveTotal = 0; 
										let maternityLeaveTotal = 0; 
										let paternityLeaveTotal = 0; 
										let nightShiftHoursTotal = 0;
										let parentalLeaveTotal = 0; 
										let serviceIncentiveLeaveTotal = 0;
										let vawacLTotal = 0;
										let specialLeaveForWomenTotal = 0;
										let absentTotal = 0;
										let authorizedAbsenceTotal = 0;

										let lastDayInShift = 0;

										let startOf = moment(start_date).format('YYYY-MM-DD');
										let endOf = moment(end_date).format('YYYY-MM-DD');
										for (var m = moment(startOf); m.isBefore(endOf); m.add(1, 'days')) {
											let shift_type_name = 'REST DAY';
											let startDate = '0';
											let endDate = '0';
											let shftDate = m.format('YYYY-MM-DD');
											var findShift = shifts.filter(obj=>obj.date===shftDate);
											if(findShift.length){
												findShift = findShift[0];
												let tss = findShift.tss;
													tss = tss ? tss : null;
												if(tss){
													dtrRecords.push(
														tss.RegHrs ? tss.RegHrs : 0,
														tss.LateHrs ? tss.LateHrs : 0,
														tss.UndertimeHrs ? tss.UndertimeHrs : 0,
														tss.OTHrs01 ? tss.OTHrs01 : 0,
														tss.Leave03 ? tss.Leave03 : 0, 
														tss.Leave01 ? tss.Leave01 : 0, 
														tss.Leave04 ? tss.Leave04 : 0, 
														tss.Leave05 ? tss.Leave05 : 0, 
														tss.NDHrs ? tss.NDHrs : 0,
														0, 
														serviceIncentiveLeaveTotal,
														vawacLTotal,
														specialLeaveForWomenTotal,
														tss.Absent ? tss.Absent : 0,
														authorizedAbsenceTotal
													);
												}else{
													dtrRecords.push(
														hoursWorkedTotal,
														hoursLateTotal,
														underTimeTotal,
														overtimeTotal,
														vacationLeaveTotal, 
														sickLeaveTotal, 
														maternityLeaveTotal, 
														paternityLeaveTotal, 
														nightShiftHoursTotal,
														parentalLeaveTotal, 
														serviceIncentiveLeaveTotal,
														vawacLTotal,
														specialLeaveForWomenTotal,
														absentTotal,
														authorizedAbsenceTotal
													);
												}
											}else{
												dtrRecords.push(
													hoursWorkedTotal,
													hoursLateTotal,
													underTimeTotal,
													overtimeTotal,
													vacationLeaveTotal, 
													sickLeaveTotal, 
													maternityLeaveTotal, 
													paternityLeaveTotal, 
													nightShiftHoursTotal,
													parentalLeaveTotal, 
													serviceIncentiveLeaveTotal,
													vawacLTotal,
													specialLeaveForWomenTotal,
													absentTotal,
													authorizedAbsenceTotal
												);
											}
										}

									}
									
									worksheet.addRow(dtrRecords);
								}

								let totalColumns = employeeHeader + ((days + 2) * 15);
								let dataStart = 5;
								
								for(let dataCol = 0; dataCol < sumCount; dataCol++){
									for(let dataRow = 1; dataRow < totalColumns; dataRow++) {
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).border = border;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).alignment = middleCenter;
										worksheet.getCell(convertToColumnLetter(dataRow + 1) + dataStart).font = text_font;
									}
									dataStart++;
								}
							}
							
						});
						let path = 'assets/reports/timekeeping/'+ filename +'.xlsx';
						workbook.xlsx.writeFile(path).then(function() {
							res.download(path);
						});
				  	} else if (option == 3){
						let workbook  = new Excel.Workbook();
						let sheet     = workbook.addWorksheet(filename);
						let border = {
						  top:    { style:'thin' },
						  left:   { style:'thin' },
						  bottom: { style:'thin' },
						  right:  { style:'thin' },
					  }
					  let fill = {
						  type: 'pattern',
						  pattern:'solid',
						  fgColor:{argb:'eeeeee'},
						  bgColor:{argb:'eeeeee'}
					  }
					  let align_center = {
						  vertical: 'middle',
						  horizontal: 'left'
					  }
					  var columns = [
						  { header: '', key: 'col1', width: 1},
						  { header: '', key: 'col2', width: 1},
						  { header: '', key: 'col3', width: 15},
						  { header: '', key: 'col4', width: 15},
						  { header: '', key: 'col5', width: 20},
						  { header: '', key: 'col6', width: 15},
						  { header: '', key: 'col7', width: 15},
						  { header: '', key: 'col8', width: 10},
					  ];

					  var center = {
						  horizontal: 'center'
					  }

					  var middleCenter = {
						  vertical: 'middle', 
						  horizontal: 'center'
					  }

					  workbook.eachSheet(function(worksheet, sheetId) {
						  worksheet.views = [
							  {
								  //state: 'frozen'
							  }
						  ];
						  worksheet.columns = columns;

						  
						  if(summary.length){
							  let summaryStart = 2;
							  let next = 4;
							  let i = 0;
							  
							  for(let key in summary){
								  i++;
								  let shifts = summary[key]['shifts'];
								  let summaries = summary[key]['summary']
								  let shiftCount = shifts.length;
								  let countSummary = 0;
								  //console.log(summaries);
								  if(summaries.Absent){
									  countSummary += 1;
								  }
								  if(summaries.PaidLeave){
									  countSummary += 1;
								  }
								  if(summaries.NightShift){
									  countSummary += 1;
								  }
								  if(summaries.LateUndertime){
									  countSummary += 1;
								  }
								  if(summaries.Overtime){
									  countSummary += 1;
								  }
								  if(summaries.OvertimeND){
									  countSummary += 1;
								  }
								  if(summaries.RestDayPay){
									  countSummary += 1;
								  }
								  if(summaries.RestDayPayND){
									  countSummary += 1;
								  }
								  if(summaries.RestDayOvertime){
									  countSummary += 1;
								  }
								  if(summaries.RestDayOvertimeND){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHoliday){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayND){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayOvertime){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayOvertimeND){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayRestDay){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayRestDayND){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayRestDayOvertime){
									  countSummary += 1;
								  }
								  if(summaries.SpecialHolidayRestDayOvertimeND){
									  countSummary += 1;
								  }
								  if(summaries.LegalHoliday){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayND){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayOvertime){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayOvertimeND){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayRestDay){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayRestDayND){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayRestDayOvertime){
									  countSummary += 1;
								  }
								  if(summaries.LegalHolidayRestDayOvertimeND){
									  countSummary += 1;
								  }
								  if(summaries.DaysWorked){
									  countSummary += 1;
								  }

								  summaryStart += shiftCount + next + 2 + countSummary;
								  
								  let headStart = summaryStart - shiftCount - countSummary - next - 1;
								  let employeeMerge = headStart + 1;
								  //console.log(headStart, shifts.length);
								  let name 	= summary[key].last_name +', '+ summary[key].first_name;
								  let emp_no_disp	= summary[key].employee_number;
								  let salary = summary[key].salary_type && summary[key].salary_type == 1 ? 'Daily' : 'Monthly';

							  	  worksheet.addRow(['', '', emp_no_disp, name, '', salary, '', '', '', '', '', '', '', '', '']);
								  worksheet.addRow(['','','Period','','Shift','Daily Time Record','','Work','Late','UT','ND','Absent','Leave','ROT','Holiday','RDD','LHD','SHD']);
								  worksheet.addRow(['','','Date','Day','','Time-in','Time-out','Hrs','Hrs','Hrs','Hrs','Hrs','Hrs','Hrs','','Hrs','Hrs','Hrs']);

								  worksheet.mergeCells('B'+ headStart, 'B'+ employeeMerge);
								  worksheet.mergeCells('E'+ headStart, 'E'+ employeeMerge);
								  worksheet.mergeCells('C'+ headStart, 'D'+ headStart);
								  worksheet.mergeCells('F'+ headStart, 'G'+ headStart);
								  //Header Border
								  //worksheet.getCell('B'+ headStart).border = border;
								  worksheet.getCell('C'+ headStart).border = border;
								  worksheet.getCell('E'+ headStart).border = border;
								  worksheet.getCell('F'+ headStart).border = border;
								  worksheet.getCell('H'+ headStart).border = border;
								  worksheet.getCell('I'+ headStart).border = border;
								  worksheet.getCell('J'+ headStart).border = border;
								  worksheet.getCell('K'+ headStart).border = border;
								  worksheet.getCell('L'+ headStart).border = border;
								  worksheet.getCell('M'+ headStart).border = border;
								  worksheet.getCell('N'+ headStart).border = border;
								  worksheet.getCell('O'+ headStart).border = border;
								  worksheet.getCell('P'+ headStart).border = border;
								  worksheet.getCell('Q'+ headStart).border = border;
								  worksheet.getCell('R'+ headStart).border = border;

								  worksheet.getCell('C'+ employeeMerge).border = border;
								  worksheet.getCell('D'+ employeeMerge).border = border;
								  worksheet.getCell('E'+ employeeMerge).border = border;
								  worksheet.getCell('F'+ employeeMerge).border = border;
								  worksheet.getCell('G'+ employeeMerge).border = border;
								  worksheet.getCell('H'+ employeeMerge).border = border;
								  worksheet.getCell('I'+ employeeMerge).border = border;
								  worksheet.getCell('J'+ employeeMerge).border = border;
								  worksheet.getCell('K'+ employeeMerge).border = border;
								  worksheet.getCell('L'+ employeeMerge).border = border;
								  worksheet.getCell('M'+ employeeMerge).border = border;
								  worksheet.getCell('N'+ employeeMerge).border = border;
								  worksheet.getCell('O'+ employeeMerge).border = border;
								  worksheet.getCell('P'+ employeeMerge).border = border;
								  worksheet.getCell('Q'+ employeeMerge).border = border;
								  worksheet.getCell('R'+ employeeMerge).border = border;
								  
								  //Header Alignment
								  //worksheet.getCell('B'+ headStart).alignment = middleCenter;
								  worksheet.getCell('C'+ headStart).alignment = middleCenter;
								  worksheet.getCell('E'+ headStart).alignment = middleCenter;
								  worksheet.getCell('F'+ headStart).alignment = middleCenter;
								  worksheet.getCell('H'+ headStart).alignment = middleCenter;
								  worksheet.getCell('I'+ headStart).alignment = middleCenter;
								  worksheet.getCell('J'+ headStart).alignment = middleCenter;
								  worksheet.getCell('K'+ headStart).alignment = middleCenter;
								  worksheet.getCell('L'+ headStart).alignment = middleCenter;
								  worksheet.getCell('M'+ headStart).alignment = middleCenter;
								  worksheet.getCell('N'+ headStart).alignment = middleCenter;
								  worksheet.getCell('O'+ headStart).alignment = middleCenter;
								  worksheet.getCell('P'+ headStart).alignment = middleCenter;
								  worksheet.getCell('Q'+ headStart).alignment = middleCenter;
								  worksheet.getCell('R'+ headStart).alignment = middleCenter;

								  worksheet.getCell('C'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('D'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('E'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('F'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('G'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('H'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('I'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('J'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('K'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('L'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('M'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('N'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('O'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('P'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('Q'+ employeeMerge).alignment = middleCenter;
								  worksheet.getCell('R'+ employeeMerge).alignment = middleCenter;
								  
								  //Header Background
								  //worksheet.getCell('B'+ headStart).fill = fill;
								  worksheet.getCell('C'+ headStart).fill = fill;
								  worksheet.getCell('E'+ headStart).fill = fill;
								  worksheet.getCell('F'+ headStart).fill = fill;
								  worksheet.getCell('H'+ headStart).fill = fill;
								  worksheet.getCell('I'+ headStart).fill = fill;
								  worksheet.getCell('J'+ headStart).fill = fill;
								  worksheet.getCell('K'+ headStart).fill = fill;
								  worksheet.getCell('L'+ headStart).fill = fill;
								  worksheet.getCell('M'+ headStart).fill = fill;
								  worksheet.getCell('N'+ headStart).fill = fill;
								  worksheet.getCell('O'+ headStart).fill = fill;
								  worksheet.getCell('P'+ headStart).fill = fill;
								  worksheet.getCell('Q'+ headStart).fill = fill;
								  worksheet.getCell('R'+ headStart).fill = fill;
								  
								  worksheet.getCell('C'+ employeeMerge).fill = fill;
								  worksheet.getCell('D'+ employeeMerge).fill = fill;
								  worksheet.getCell('E'+ employeeMerge).fill = fill;
								  worksheet.getCell('F'+ employeeMerge).fill = fill;
								  worksheet.getCell('G'+ employeeMerge).fill = fill;
								  worksheet.getCell('H'+ employeeMerge).fill = fill;
								  worksheet.getCell('I'+ employeeMerge).fill = fill;
								  worksheet.getCell('J'+ employeeMerge).fill = fill;
								  worksheet.getCell('K'+ employeeMerge).fill = fill;
								  worksheet.getCell('L'+ employeeMerge).fill = fill;
								  worksheet.getCell('M'+ employeeMerge).fill = fill;
								  worksheet.getCell('N'+ employeeMerge).fill = fill;
								  worksheet.getCell('O'+ employeeMerge).fill = fill;
								  worksheet.getCell('P'+ employeeMerge).fill = fill;
								  worksheet.getCell('Q'+ employeeMerge).fill = fill;
								  worksheet.getCell('R'+ employeeMerge).fill = fill;

								  if(shiftCount){
									  let nextLine = employeeMerge;
									  let rows = nextLine;

									  let totalRegHrs = 0;
									  let totalLateHrs = 0;
									  let totalUTHrs = 0;
									  let totalNDHrs = 0;
									  let totalAbsentHrs = 0;
									  let totalLeaveDays = 0;
									  let totalOTHrs = 0;		// ROT
									  let totalRDD = 0;			// RDD
									  let totalLHD = 0;			// LHD
									  let totalSHD = 0;			// SHD

									  for(let x in shifts){
										  rows ++;

										  let type    = shifts[x].type;
										  let date 	= res.locals.moment(shifts[x].date).format('MM/DD/YYYY');
										  let day  	= res.locals.moment(shifts[x].date).format('dddd');
										  let start 	= '';
										  let end 	= '';
										  if(type == 1){
											  start = res.locals.moment(shifts[x].date +' '+ shifts[x].check_in).format('hh:mmA');
											  end   = res.locals.moment(shifts[x].date +' '+ shifts[x].check_out).format('hh:mmA');
										  }else if(type == 2){
											  start = 'Flexible';
										  }else{
											  start = res.locals.moment(shifts[x].date +' '+ shifts[x].between_start).format('hh:mmA') +' '+ res.locals.moment(shifts[x].date +' '+ shifts[x].between_end).format('hh:mmA');
										  }
										  let timein 	= '--';
										  if(shifts[x].actual_check_in){
											  timein = moment(shifts[x].actual_check_in).utc().format('hh:mm:ss A');
										  }
										  let timeout = '--';
										  if(shifts[x].actual_check_out){
											  timeout = moment(shifts[x].actual_check_out).utc().format('hh:mm:ss A');
										  }
										  let shift_type = '';
										  if(shifts[x].shift_type){
											shift_type = shifts[x].shift_type;
										  }

										  let tssData = shifts[x].tss;

										  if (tssData){
											// Work Hours
											let RegularHours = tssData.RegHrs ? tssData.RegHrs : 0;
											totalRegHrs = totalRegHrs + RegularHours;

											// Late Hours 
											let LateHours_display 	= tssData.LateHrs > 0 ? parseFloat(tssData.LateHrs/60).toFixed(2) : 0;
											let LateHours 			= tssData.LateHrs > 0 ? tssData.LateHrs : 0;
											totalLateHrs 			= totalLateHrs + LateHours;
											
											// UT Hours 
											let UndertimeHours_display 	= tssData.UndertimeHrs ? parseFloat(tssData.UndertimeHrs/60).toFixed(2) : 0;
											let UndertimeHours 			= tssData.UndertimeHrs ? tssData.UndertimeHrs : 0;
											totalUTHrs 					= totalUTHrs + UndertimeHours;
											
											// ND Hours
											let NigthDiffHours = tssData.NDHrs ? tssData.NDHrs : 0;
											totalNDHrs = totalNDHrs + NigthDiffHours;

											// Absent Hrs
											let AbsentHrs = tssData.Absent ? tssData.Absent : 0;
											totalAbsentHrs = totalAbsentHrs + AbsentHrs;

											// Leave Days 
											let LeaveDays = '0';
											if (tssData.Leave01 && tssData.Leave01 > 0){
												LeaveDays = tssData.Leave01 + 'SL';
												totalLeaveDays = totalLeaveDays + tssData.Leave01;
											} else if (tssData.UnpaidSL && tssData.UnpaidSL > 0){
												LeaveDays = tssData.UnpaidSL + 'USL';
												totalLeaveDays = totalLeaveDays + tssData.UnpaidSL;
											} else if (tssData.Leave02 && tssData.Leave02 > 0){
												LeaveDays = tssData.Leave02 + 'EL';
												totalLeaveDays = totalLeaveDays + tssData.Leave02;
											} else if (tssData.UnpaidEL && tssData.UnpaidEL > 0){
												LeaveDays = tssData.UnpaidEL + 'UEL';
												totalLeaveDays = totalLeaveDays + tssData.UnpaidEL;
											} else if (tssData.Leave03 && tssData.Leave03 > 0){
												LeaveDays = tssData.Leave03 + 'VL';
												totalLeaveDays = totalLeaveDays + tssData.Leave03;
											} else if (tssData.UnpaidVL && tssData.UnpaidVL > 0){
												LeaveDays = tssData.UnpaidVL + 'UVL';
												totalLeaveDays = totalLeaveDays + tssData.UnpaidVL;
											} else if (tssData.Leave04 && tssData.Leave04 > 0){
												LeaveDays = tssData.Leave04 + 'ML';
												totalLeaveDays = totalLeaveDays + tssData.Leave04;
											} else if (tssData.Leave05 && tssData.Leave05 > 0){
												LeaveDays = tssData.Leave05 + 'PL';
												totalLeaveDays = totalLeaveDays + tssData.Leave05;
											} else if (tssData.Leave10 && tssData.Leave10 > 0){
												LeaveDays = tssData.Leave010 + 'BL';
												totalLeaveDays = totalLeaveDays + tssData.Leave010;
											} else if (tssData.Leave11 && tssData.Leave11 > 0){
												LeaveDays = tssData.Leave11 + 'MML';
												totalLeaveDays = totalLeaveDays + tssData.Leave11;
											} else if (tssData.Leave08 && tssData.Leave08 > 0){
												LeaveDays = tssData.Leave08 + 'SPL';
												totalLeaveDays = totalLeaveDays + tssData.Leave08;
											} else if (tssData.Leave12 && tssData.Leave12 > 0){
												LeaveDays = tssData.Leave12 + 'SLWL';
												totalLeaveDays = totalLeaveDays + tssData.Leave12;
											} else if (tssData.Leave13 && tssData.Leave13 > 0){
												LeaveDays = tssData.Leave13 + 'VAWCL';
												totalLeaveDays = totalLeaveDays + tssData.Leave13;
											} else if (tssData.Leave14 && tssData.Leave14 > 0){
												LeaveDays = tssData.Leave14 + 'UL';
												totalLeaveDays = totalLeaveDays + tssData.Leave14;
											}
											
											// ROT Hours 
											let OvertimeHours = shifts[x].tss.OTHrs01 ? shifts[x].tss.OTHrs01 : 0;
											totalOTHrs = totalOTHrs + OvertimeHours;

											// RDD
											let rddOT = shifts[x].tss.OTHrs03 ? shifts[x].tss.OTHrs03 : 0;
											totalRDD = totalRDD + rddOT;

											// LHD
											let lhdOT = (shifts[x].tss.OTHrs05 ? shifts[x].tss.OTHrs05 : 0) + (shifts[x].tss.OTHrs07 ? shifts[x].tss.OTHrs07 : 0) + (shifts[x].tss.OTHrs10 ? shifts[x].tss.OTHrs10 : 0);
											totalLHD = totalLHD + lhdOT;

											// SHD
											let shdOT = (shifts[x].tss.OTHrs04 ? shifts[x].tss.OTHrs04 : 0) + (shifts[x].tss.OTHrs06 ? shifts[x].tss.OTHrs06 : 0) + (shifts[x].tss.OTHrs09 ? shifts[x].tss.OTHrs09 : 0);
											totalSHD = totalSHD + shdOT;

											// Holiday Days 
											let HolidayDays = '';
											if ((tssData.OTHrs04 && tssData.OTHrs04 > 0) || (tssData.OTHrs06 && tssData.OTHrs06 > 0) || (tssData.OTHrs09 && tssData.OTHrs09 > 0)){
												HolidayDays = 'Special';
											} else if ((tssData.OTHrs05 && tssData.OTHrs05 > 0) || (tssData.OTHrs07 && tssData.OTHrs07 > 0) || (tssData.OTHrs10 && tssData.OTHrs10 > 0)){
												HolidayDays = 'Regular';
											}

											worksheet.addRow(['', '', date, day, shift_type, timein, timeout, RegularHours, LateHours_display, UndertimeHours_display, NigthDiffHours, AbsentHrs, LeaveDays, OvertimeHours, HolidayDays, rddOT, lhdOT, shdOT]);
											
											//worksheet.getCell('B'+ rows).border = border;
											worksheet.getCell('C'+ rows).border = border;
											worksheet.getCell('E'+ rows).border = border;
											worksheet.getCell('G'+ rows).border = border;
											worksheet.getCell('C'+ rows).border = border;
											worksheet.getCell('D'+ rows).border = border;
											worksheet.getCell('E'+ rows).border = border;
											worksheet.getCell('F'+ rows).border = border;
											worksheet.getCell('G'+ rows).border = border;
											worksheet.getCell('H'+ rows).border = border;
											worksheet.getCell('I'+ rows).border = border;
											worksheet.getCell('J'+ rows).border = border;
											worksheet.getCell('K'+ rows).border = border;
											worksheet.getCell('L'+ rows).border = border;
											worksheet.getCell('M'+ rows).border = border;
											worksheet.getCell('N'+ rows).border = border;
											worksheet.getCell('O'+ rows).border = border;
											worksheet.getCell('P'+ rows).border = border;
											worksheet.getCell('Q'+ rows).border = border;
											worksheet.getCell('R'+ rows).border = border;

											worksheet.getCell('C'+ rows).alignment = middleCenter;
											worksheet.getCell('E'+ rows).alignment = middleCenter;
											worksheet.getCell('G'+ rows).alignment = middleCenter;
											worksheet.getCell('C'+ rows).alignment = middleCenter;
											worksheet.getCell('D'+ rows).alignment = middleCenter;
											worksheet.getCell('E'+ rows).alignment = middleCenter;
											worksheet.getCell('F'+ rows).alignment = middleCenter;
											worksheet.getCell('G'+ rows).alignment = middleCenter;
											worksheet.getCell('H'+ rows).alignment = middleCenter;
											worksheet.getCell('I'+ rows).alignment = middleCenter;
											worksheet.getCell('J'+ rows).alignment = middleCenter;
											worksheet.getCell('K'+ rows).alignment = middleCenter;
											worksheet.getCell('L'+ rows).alignment = middleCenter;
											worksheet.getCell('M'+ rows).alignment = middleCenter;
											worksheet.getCell('N'+ rows).alignment = middleCenter;
											worksheet.getCell('O'+ rows).alignment = middleCenter;
											worksheet.getCell('P'+ rows).alignment = middleCenter;
											worksheet.getCell('Q'+ rows).alignment = middleCenter;
											worksheet.getCell('R'+ rows).alignment = middleCenter;
										} else {
											worksheet.addRow(['', name, date, day, shift_type, timein, timeout, '', '', '', '', '', '', '', '']);
										}
									  }
									  // Insert here for total
									  worksheet.addRow(['', '', '', '', '', '', 'TOTAL', totalRegHrs, parseFloat(totalLateHrs/60).toFixed(2),  parseFloat(totalUTHrs/60).toFixed(2), totalNDHrs, totalAbsentHrs, totalLeaveDays, totalOTHrs, '', totalRDD, totalLHD, totalSHD]);

								  //Space
								  worksheet.addRow(['','','','','','','','']);
								  worksheet.addRow(['','','','','','','','']);
								  worksheet.addRow(['','','','','','','','']);
								}
							  }
						  }
						  
					  });

					  let path = 'assets/reports/timekeeping/'+ filename +'.xlsx';
					  workbook.xlsx.writeFile(path).then(function() {
						  res.download(path);
					  });
					}
			});
		});
	});
}

exports.biometricLogsFetch = async function(req, res){
	let userID = req.body.userID;
	let limit = req.body.limit ? parseInt(req.body.limit) : 25;
	let where = {};
	let filter = parseInt(req.body.filter);
	let start_date = req.body.start;
	let end_date = req.body.end;
	let month_date = req.body.month_date ? req.body.month_date : '';
	let period = req.body.period;

	const config = await ConfigModel.findOne({
		where: {
			id: 1
		}
	});

	json = config.json ? JSON.parse(config.json) : null;
	let cutoff = json.cutoff;

	if(filter === 2 && month_date && period){
		month_date = res.locals.moment(month_date).format('YYYY-MM');
		if(period =='A'){
			start = month_date+'-'+cutoff.A_from;
			start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
			end = month_date+'-'+cutoff.A_to;
			end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
			start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
		}else{
			start = month_date+'-'+cutoff.B_from;
			start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
			end = month_date+'-'+cutoff.B_to;
			end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
			start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
		}
		start_date = start;
		end_date = end;
		
		start_date = res.locals.moment(start_date).subtract(2, 'd').format('YYYY-MM-DD');
		end_date = res.locals.moment(end_date).add(2, 'd').format('YYYY-MM-DD');

		where.$and = {
			date: {
				$gte: start_date,
				$lte: end_date
			}
		};
		limit = 100;
	} else {
		start_date = res.locals.moment(start_date).subtract(2, 'd').format('YYYY-MM-DD');
		end_date = res.locals.moment(end_date).add(2, 'd').format('YYYY-MM-DD');
		where.$and = {
			date: {
				$gte: start_date,
				$lte: end_date
			}
		}
	}

	where.userID = userID;

	const biometric_log =  await BiometricLog.findAll({
		where: where,
		limit: limit
	})

	res.status(200).json({
		success: true,
		biometric_log: biometric_log,
	})
}

exports.fetch = function(req, res){
	let session = req.session;
	let isSupervisor = res.locals.isSupervisor;
	let isHRGeneralist = res.locals.isHRGeneralist
	let user = res.locals.user;
	let currentDate = res.locals.moment();
	let result = [];
	let validate = []; 
	let year = req.body.year ? req.body.year : currentDate.format('YYYY');
	let month = req.body.month ? req.body.month : currentDate.format('MM');
	let company = req.body.company ? req.body.company : '';
	let division = req.body.division ? req.body.division : '';
	let department = req.body.department ? req.body.department : '';
	let section = req.body.section ? req.body.section : '';
	let userId = req.body.department ? req.body.user : '';
	let designation = req.body.designation ? req.body.designation : '';
	let limit = req.body.limit ? parseInt(req.body.limit) : 25;
	let page 	= req.body.page ? parseInt(req.body.page) : 1;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let period = req.body.period ? req.body.period : 'A';
	let start_date = req.body.start ? res.locals.moment(new Date( req.body.start )).format('YYYY-MM-DD') :  '';
	let end_date = req.body.end ? res.locals.moment(new Date( req.body.end )).format('YYYY-MM-DD') :  '';
	let absenteeism = req.body.absenteeism ?  req.body.absenteeism : '';
	let key = req.body.key;
	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		
		let cutoff = json.cutoff;
		
		let month_date = req.body.month_date ? req.body.month_date : "";
		let period = req.body.period;

		// if (isSupervisor) {
		// 	month_date = session.user.default_month_date;
		// 	period = session.user.default_period;
		// }

		if(req.body.filter == 2 && month_date && period){
			month_date = res.locals.moment(month_date).format('YYYY-MM');
			if(period =='A'){
				start = month_date+'-'+cutoff.A_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.A_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}else{
				start = month_date+'-'+cutoff.B_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date+'-'+cutoff.B_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1,'months').format('YYYY-MM-DD') : start;
			}
			start_date = start;
			end_date = end;
		}
		if(start_date && end_date){
			let where = {};
			let whereUser = {};
			
			if(company){
				where.company_id = company;
			}
			if(division){
				where.division_id = division;
			}
			if(department){
				where.department_id = department;
			}
			if(section){
				where.section_id = section;
			}

			// console.log("where: ", where);
			// OvertimesModel.findAll({
			// 	where: {
			// 		primary_status: 2,
			// 		start_date: {
			// 			$between: [start_date, end_date]
			// 		}
			// 	}
			// })
			
			EmploymentsModel.findAll({
				where: where,
				attributes: ['id','user_id'],
				raw: true
			}).then(function(data){
				employment = data;
				let whereUserFilter = {};
				if(isSupervisor > 0){
					whereUserFilter[Op.or] = {
						approver_id: user.id,
						secondary_approver_id: user.id,
						secretary_id: user.id,
						alternate_secretary: user.id,
					}
				}
				if(isHRGeneralist > 0){
					whereUserFilter = {
						hr_generalist_id: user.id,
					}
				}
				return UsersModel.findAll({
					where: whereUserFilter,
					attributes: ['id'],
					raw: true
				});
			}).then(function(data){
				userIDS = data;
				userIDS = _.pluck(userIDS, 'id');
				return UserRole.get_role(user, 'attendance-shift');
			}).then(function(data){
				user_role = data;
				let user_id = [];
				if(employment && employment.length){
					for(let i in employment){
						user_id.push(employment[i].user_id);
					}
				}
				user_id = [...new Set(user_id)];
				// console.log("user_id: ", user_id);
				
				if(!_.isEmpty(where)){
					whereUser.id = {
						[Op.in]: user_id
					}
				}
				if(user_role.modify){
					if(!_.isEmpty(where)){
						whereUser.id = {
							[Op.in]: user_id
						}
					}
				}else if(isSupervisor > 0){
					whereUser.id = {
						[Op.in]: userIDS
					}
				}else if(isHRGeneralist > 0){
					whereUser.id = {
						[Op.in]: userIDS
					}
				}

				if(key) {
					whereUser[Op.or] = {
						first_name : {
							[Op.like] : '%'+ key +'%'
						},
						last_name : {
							[Op.like] : '%'+ key +'%'
						},
						middle_name : {
							[Op.like] : '%'+ key +'%'
						},
						email : {
							[Op.like] : '%'+ key +'%'
						},
						username : {
							[Op.like] : '%'+ key +'%'
						},
						employee_number : {
							[Op.like] : '%'+ key +'%'
						},
					}
				}

				// whereUser support on display of resigned employees
				whereUser.resignation_date = {
					[Op.or] : {
						[Op.gte]: start_date,
						[Op.eq]: null
					}
				}

				UsersModel.findAndCountAll({
					where: whereUser,
					include: [
						{
							model: TSSData,
							where: {
								//primary_status: 2,
								date: {
									$between: [start_date, end_date]
								}
							},
							include:[
								{
									model: ShiftsModel,
									as: 'shift',
									required: false,
									include:[
										{
											model: ShiftType,
											as: 'type_of_shift',
											attributes:['is_from_previous']
										}
									],
								},
								{
									model: OvertimesModel,
									as: 'overtime',
									required: false
								},
							],
							order: [
								['id','desc'],
							],
							separate: true,
						},
						{
							model: ShiftsModel,
							required: false,
							where: {
								//primary_status: 2,
								date: {
									$between: [start_date, end_date]
								}
							},
							include: [
								{
									model: TSSData,
									as: 'tss'
								}
							],
							attributes: ['id','user_id','type','date','check_in','check_out','actual_check_in','actual_check_out','between_start','between_end','shift_length','paid_hours', 'onsite', 'reg_holiday_work_hrs', 'reg_holiday_rest_day_work_hrs', 'reg_special_holiday_restday_work_hrs', 'double_reg_holiday', 'special_holiday', 'special_holiday_restday', 'late', 'absent', 'undertime', 'awol', 'actual_work_hours'],
							separate: true,
						},
					],
					attributes: ['id','shortid','employee_number','first_name','last_name'],
					offset: offset,
					limit: limit,
					order: [
						['last_name','asc']
					],
				}).then(function(data){
					shifts = data.rows;
					let rows = [];
					if(shifts && shifts.length){
						for(let i in shifts){
							
							let arrFilter = [];
							let shiftArray = shifts[i].shift;
							let tss_data = shifts[i].tss_data;
							let tss = tss_data.sort(function(a,b){
							  	return new Date(a.date) - new Date(b.date);
							});
							var a = moment(start_date);
							var b = moment(end_date);

							if (tss.length > 0) {
								for (var m = moment(a); m.diff(b, 'days') <= 0; m.add(1, 'days')) {
									let thisDate = m.format('YYYY-MM-DD')
									let gotTss = tss.filter(
											(v,i,a)=>a.findIndex(t=>(
											t.user_id === v.user_id && t.date===thisDate && (t.shift_id === v.shift_id)
										))===i
									);
									let result = gotTss[0] ? gotTss[0] : {date: thisDate, shift: {shift_type: "RESTDAY"}}
									arrFilter.push(result);
								}
							}
							let shift = shifts[i].shifts;
							let rowData = {
								id: shifts[i].id,
								shortid: shifts[i].shortid,
								employee_number: shifts[i].employee_number,
								first_name: shifts[i].first_name,
								last_name: shifts[i].last_name,
								tss: arrFilter,
								shifts: shift
							}
							rows.push(rowData);
						}
					}
					
					numrows = data.count;
			        count = 0;
			        if(limit < numrows){
			            count = numrows / limit;
			            count = Math.ceil(count);
			        }else{
			            count = 0;
			        }
					res.status(200).json({
						success: true,
						records: rows,
						session: session,
						count: count,
					});
				});
			});
		}else{
			res.status(200).json({
				success: true,
				records: [],
				count: 0,
			});
		}
	});
}

exports.reprocess = function(req, res){
	let user_id 	= req.body.user_id;
	let target_date = req.body.target_date;
	let shift_id 	= parseInt(req.body.shift_id);

	if(isNaN(shift_id) || shift_id == null){
		//check for the possible shift
		ShiftsModel.findOne({
			where: {
				date: target_date,
				user_id: user_id,
			}
		}).then(data => {
			if(!data){
				res.status(200).json({
					success: true,
					msg: 'NO SHIFT FOUND.'
				});
			}else{
				TSSHelper.process(target_date, user_id);
				res.status(200).json({
					success: true,
					msg: 'successfully create new data.'
				});
			}
		});
	}else{
	// CHANGE REPROCESS INSTEAD OF USER ID AND TARGET DATE USE SHIFT_ID IN QUERY
	TSSData.findOne({ 
		where: {
			shift_id: shift_id,
			user_id	: user_id
		},
		attributes: ['id','date','user_id','shift_id','overtime_id'],
		raw: true
	}).then(data=>{
		tss = data;
		let date 	 = tss.date;
		let shift_id = tss.shift_id ? tss.shift_id: null; 

		if(tss){
			let reqData = {
				RegHrs: null,
				OTHrs01: null,
				OTHrs02: null,
				OTHrs03: null,
				OTHrs04: null,
				OTHrs05: null,
				OTHrs06: null,
				OTHrs07: null,
				OTHrs08: null,
				OTHrs09: null,
				OTHrs10: null,
				OTHrs11: null,
				OTHrs12: null,
				OTHrs13: null,
				OTHrs14: null,
				OTHrs15: null,
				OTHrs16: null,
				OTHrs17: null,
				OTHrs18: null,
				OTHrs19: null,
				OTHrs20: null,
				OTHrs21: null,
				OTHrs22: null,
				OTHrs23: null,
				OTHrs24: null,
				OTHrs25: null
			}
			TSSData.update(reqData,{
				where:{
					date 	: date,
					user_id	: user_id
				}
			}).then(data=>{

				let ot_where = {
					start_date: target_date,
					primary_status: 2,
					user_id: user_id
				};

				if(shift_id){
					ot_where.$or={
						shift_id: shift_id
					};
				}

				OvertimesModel.findAll({
					where: ot_where,
				}).then((data)=>{
					let overtime_ids = data.map(el => el.id);
					if(overtime_ids.length){
						// console.log('OT REPROCESS IDS: ',overtime_ids);
						OvertimeHelper.process(null,null,overtime_ids);
					}
					TSSHelper.process(target_date, user_id,true);
				});
			});
		}

		res.status(200).json({
			success: true,
			action: 'fetch',
			msg: 'Re-processing selected Data.'
		});
	});	
	}
}

exports.add_attendance = function(req,res){
	let shift_id = req.body.shift_id;
	// RESET FIELDS IN TSS DATA
	let reqData = {
		RegHrs : null,
		LateHrs : null,
		UndertimeHrs : null,
		NDHrs : null,
		Absent : null,
		Leave01 : null,
		Leave02 : null,
		Leave03 : null,
		Leave04 : null,
		Leave05 : null,
		Leave06 : null,
		Leave07 : null,
		Leave08 : null,
		Leave09 : null,
		Leave10 : null,
		Leave11 : null,
		Leave12 : null,
		Leave13 : null,
		Leave14 : null,
		Leave15 : null,
		Leave16 : null,
		Leave17 : null,
		Leave18 : null,
		Leave19 : null,
		Leave20 : null,
		OTHrs01 : null,
		OTHrs02 : null,
		OTHrs03 : null,
		OTHrs04 : null,
		OTHrs05 : null,
		OTHrs06 : null,
		OTHrs07 : null,
		OTHrs08 : null,
		OTHrs09 : null,
		OTHrs10 : null,
		OTHrs11 : null,
		OTHrs12 : null,
		OTHrs13 : null,
		OTHrs14 : null,
		OTHrs15 : null,
		OTHrs16 : null,
		OTHrs17 : null,
		OTHrs18 : null,
		OTHrs19 : null,
		OTHrs20 : null,
		OTHrs21 : null,
		OTHrs22:null,
		OTHrs23:null,
		OTHrs24:null,
		OTHrs25:null,
		Rate:null,
		UnpaidRegHrs:null,
		UnpaidSL:null,
		UnpaidTaxSL:null,
		UnpaidVL : null,
		UnpaidTaxVL : null,
		UnpaidEL : null,
		EffectivityDate : null,
		EmpStatus : null,
		EffectivityDateResign : null,
	};
	if(!isNaN(shift_id)){
		TSSData.update(reqData,{
			where:{
				shift_id: shift_id
			}
		}).then(function(){
			AttendanceHelper.proccess2('DTR Management',null,shift_id);
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Data has been processed.'
			});
		});
	}else{
		res.status(200).json({
			success: true,
			msg: `No Shift Found.`
		});
	}
}

const convertToColumnLetter = function(input_num) {
	var result = '';
	var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	if(input_num > 702) {
		result += 'A'
	}
	else if (input_num > 26) {
		let leftHeader = Math.trunc(input_num / 26);
		let rightHeader = input_num - (leftHeader * 26);

		if(rightHeader == 0) {
			rightHeader = 26;
			leftHeader -= 1;
		}

		result += characters[leftHeader - 1];
		result += characters[rightHeader - 1];
	} else {
		result = characters[input_num - 1];
	}
	return result;
 }

const getLeaves = function(shifts, leaves, leavePolicy) {
	let leavePolicyObj = null;
	for(let keyX in shifts) {
		leavePolicyObj = {};
		for(let keyY in leaves){
			if(shifts[keyX].date == leaves[keyY].date) {
				leavePolicyObj = leavePolicy.find(x => x.id === leaves[keyY]["leave"].leave_type);
				break;
			}
		}

		shifts[keyX]["leave_obj"] = leavePolicyObj;
	}
}

const getOvertimes = function(shifts, overtime) {
	let overtimeHours = null;
	
	for(let keyX in shifts) {
		overtimeHours = "";
		for(let keyY in overtime){
			if(shifts[keyX].date == overtime[keyY].start_date) {
				overtimeHours = overtime[keyY].no_of_hours
				break;
			}
		}

		shifts[keyX]["overtime_hours"] = overtimeHours;
	}
}