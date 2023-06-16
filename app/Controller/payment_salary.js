const Excel = require('exceljs');
const conversion = require("phantom-html-to-pdf")();
const fs = require('fs');
const JsBarcode = require('jsbarcode');
//const { Canvas } = require("canvas");
const UserRole = require('../Helper/UserRole');
const TimeKeeping = require('../Helper/TimeKeeping/Main');
const { 
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
	LoanModel,
	SalaryModel,
	EmploymentsModel,
	LoanPaymentModel,
	AdjustmentModel,
	DisputeModel,
	IncentiveModel,
	UserSettingModel
} = require('../../config/Sequelize');

exports.index = function(req, res){

	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		UserRole.get_role(user, 'employee-leave').then(function(data){
			user_role = data;
			if(!user_role.read) {
				res.render('Errors/403');
			}else{
				res.render('Payment/Salary/index', {
					route: 'payment-salary',
					usrRole: usrRole,
					user_role: user_role
				});
			}
		});
	});
}

exports.fetch = function(req, res){
	let currentDate = res.locals.moment();
	let result = [];
	let year = req.body.year ? req.body.year : currentDate.format('YYYY');
	let month = req.body.month ? req.body.month : currentDate.format('MM');
	let company = req.body.company ? req.body.company : '';
	let department = req.body.department ? req.body.department : '';
	let designation = req.body.designation ? req.body.designation : '';
	let limit = req.body.limit ? req.body.limit : 25;
	let page 	= req.body.page ? req.body.page : 1;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let period = req.body.period ? req.body.period : 'A';
	let PP = period == 'A' ? 0 : 1;

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		
		let cutoff = json.cutoff;
		let contribution = json.contribution;
		let policy = json.policy;
		
		let setting = {
			noLog: policy && policy.nolog ? policy.nolog : 1, // 0 = whole day, 1 = half day
			grace_period: json.shift ? json.shift.grace_period : 0,
			halfDayinMinutes: 120,
 			sss: contribution.sss, 
 			philhealth: contribution.philhealth, 
 			pagibig: contribution.pagibig,
 			period: period
		}

		let day_a = period == 'A' ? cutoff.A_from : cutoff.B_from;
		let day_b = period == 'A' ? cutoff.A_to : cutoff.B_to;
		let start_date = year +'-'+ month +'-'+day_a;
			start_date = res.locals.moment(new Date(start_date)).format('YYYY-MM-DD');
		if(period == 'A'){
			start_date = res.locals.moment(start_date);
			start_date = start_date.subtract(1, 'months');
			start_date = res.locals.moment(new Date(start_date)).format('YYYY-MM-DD');
		}
		let end_date   = year +'-'+ month +'-'+day_b;
			end_date = res.locals.moment(new Date(end_date)).format('YYYY-MM-DD');
		//console.log(start_date, end_date);

		let createPriod = '('+ res.locals.moment(start_date).format('MM/DD/YY') +' - '+ res.locals.moment(end_date).format('MM/DD/YY') +') — '+year+''+period;
		let where = {};
		if(company){
			where.company_branch_id = company;
		}
		if(department){
			where.department_id = department;
		}
		if(designation){
			where.job_title_id = designation;
		}
		UsersModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return UsersModel.findAll({
	  			where: where,
	  			include: [
	  				{
	  					model: ShiftsModel,
	  					required: false,
	  					where: {
	  						primary_status: 2,
	  						date: {
	  							$between: [start_date, end_date]
	  						}
	  					},
	  					attributes: ['id','user_id','type','date','check_in','check_out','actual_check_in','actual_check_out','between_start','between_end','shift_length','paid_hours', 'onsite']
	  				},{
	  					model: OvertimesModel,
	  					required: false,
	  					where: {
	  						primary_status: 2,
		  					start_date: {
								$between: [start_date, end_date]
							}
	  					},
	  					attributes: ['type','start_date','end_date','start_time','end_time','actual_check_in','actual_check_out','no_of_hours']
	  				},{
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
	  				},{
	  					model: SalaryModel,
	  					required: false,
	  					where:{
	  						start_date:{
	  							$lte: start_date
	  						}
	  					},
	  					order: [
	  						['start_date','DESC']
	  					],
	  					attributes: ['start_date','amount','mode']
	  				},{
		    			model: TaxonomyModel, as: 'job_title',
		    			required: false,
		    			attributes: ['title']
		    		},{
		    			model: TaxonomyModel, as: 'department',
		    			required: false,
		    			attributes: ['title']
		    		},{
		    			model: BranchesModel,
		    			required: false,
		    			attributes: ['location','address'],
		    			include: [
		    				{
		    					model: CompanyModel,
		    					attributes: ['name','logo'],
		    				}
		    			]
		    		},{
		    			model: LoanPaymentModel,
		    			required: false,
		    			where: {
		    				year: year,
		    				month: month,
		    				period: period,
		    			},
		    			include: [
		    				{
		    					model: LoanModel,
		    					where: {
		    						status: 1
		    					},
		    					attributes: ['label']
		    				}
		    			],
		    			attributes: ['amount']
		    		},{
		    			model: AdjustmentModel,
		    			required: false,
		    			where: {
		    				status: 1,
		    				year: year,
		    				month: month,
		    				period: period,
		    			}
		    		},{
		    			model: DisputeModel,
		    			required: false,
		    			where: {
		    				admin_status: 2,
		    				year: year,
		    				month: month,
		    				period: period,
		    			},
		    			attributes: ['hour','type','date']
		    		},{
		    			model: IncentiveModel,
		    			required: false,
		    			where: {
		    				status: 1,
		    				mode: 2,
		    				$or: [
		    					{
		    						to: null
		    					},{
		    						to: ''
		    					},{
		    						to: {
		    							$lte: start_date
		    						}
		    					}
		    				],
		    				$or: [
		    					{
		    						period: 2
		    					},{
		    						period: PP
		    					}
		    				]
		    			},
		    			attributes: ['label','amount','period', 'taxable']
		    		},{
	  					model: UserSettingModel,
	  					required: false
	  				}
	  			],
	  			attributes: ['id','shortid','employee_number','first_name','last_name','company_branch_id','department_id','job_title_id'],
	  			// offset: offset,
	    	// 	limit: limit,
	  		});

		}).then(function(data){
  			shifts = data;
  			shifts   = JSON.parse(JSON.stringify(shifts));
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
  			let summary = TimeKeeping.calculate(shifts, holiday, setting ,createPriod);
  			//console.log(summary);
  			res.status(200).json({
  				success: true,
  				records: summary,
  				count: count,
  			});
  			// res.header("Content-Type",'application/json');
  			// res.send(JSON.stringify(summary, null, 4));
  		});
		
	});
	
}

exports.download = function(req, res){
	let currentDate = res.locals.moment();
	let result = [];
	let year = req.query.year ? req.query.year : currentDate.format('YYYY');
	let month = req.query.month ? req.query.month : currentDate.format('MM');
	let company = req.query.company ? req.query.company : '';
	let department = req.query.department ? req.query.department : '';
	let designation = req.query.designation ? req.query.designation : '';
	let limit = req.query.limit ? req.query.limit : 25;
	let page 	= req.query.page ? req.query.page : 1;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	let period = req.query.period ? req.query.period : 'A';
	let PP = period == 'A' ? 0 : 1;

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		
		let cutoff = json.cutoff;
		let contribution = json.contribution;
		let policy = json.policy;
		
		let setting = {
			noLog: policy && policy.nolog ? policy.nolog : 1, // 0 = whole day, 1 = half day
			grace_period: json.shift ? json.shift.grace_period : 0,
			halfDayinMinutes: 120,
 			sss: contribution.sss, 
 			philhealth: contribution.philhealth, 
 			pagibig: contribution.pagibig,
 			period: period
		}

		let day_a = period == 'A' ? cutoff.A_from : cutoff.B_from;
		let day_b = period == 'A' ? cutoff.A_to : cutoff.B_to;
		let start_date = year +'-'+ month +'-'+day_a;
			start_date = res.locals.moment(new Date(start_date)).format('YYYY-MM-DD');
		if(period == 'A'){
			start_date = res.locals.moment(start_date);
			start_date = start_date.subtract(1, 'months');
			start_date = res.locals.moment(new Date(start_date)).format('YYYY-MM-DD');
		}
		let end_date   = year +'-'+ month +'-'+day_b;
			end_date = res.locals.moment(new Date(end_date)).format('YYYY-MM-DD');
		//console.log(start_date, end_date);

		let createPriod = '('+ res.locals.moment(start_date).format('MM/DD/YY') +' - '+ res.locals.moment(end_date).format('MM/DD/YY') +') — '+year+''+period;
		let where = {};
		if(company){
			where.company_branch_id = company;
		}
		if(department){
			where.department_id = department;
		}
		if(designation){
			where.job_title_id = designation;
		}
		UsersModel.count({
			where: where
		}).then(function(data){
			numrows = data;
			return UsersModel.findAll({
	  			where: where,
	  			include: [
	  				{
	  					model: ShiftsModel,
	  					required: false,
	  					where: {
	  						primary_status: 2,
	  						date: {
	  							$between: [start_date, end_date]
	  						}
	  					},
	  					attributes: ['id','user_id','type','date','check_in','check_out','actual_check_in','actual_check_out','between_start','between_end','shift_length','paid_hours', 'onsite']
	  				},{
	  					model: OvertimesModel,
	  					required: false,
	  					where: {
	  						primary_status: 2,
		  					start_date: {
								$between: [start_date, end_date]
							}
	  					},
	  					attributes: ['type','start_date','end_date','start_time','end_time','actual_check_in','actual_check_out','no_of_hours']
	  				},{
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
	  				},{
	  					model: SalaryModel,
	  					required: false,
	  					where:{
	  						start_date:{
	  							$lte: start_date
	  						}
	  					},
	  					order: [
	  						['start_date','DESC']
	  					],
	  					attributes: ['start_date','amount','mode']
	  				},{
		    			model: TaxonomyModel, as: 'job_title',
		    			required: false,
		    			attributes: ['title']
		    		},{
		    			model: TaxonomyModel, as: 'department',
		    			required: false,
		    			attributes: ['title']
		    		},{
		    			model: BranchesModel,
		    			required: false,
		    			attributes: ['location','address'],
		    			include: [
		    				{
		    					model: CompanyModel,
		    					attributes: ['name','logo'],
		    				}
		    			]
		    		},{
		    			model: LoanPaymentModel,
		    			required: false,
		    			where: {
		    				year: year,
		    				month: month,
		    				period: period,
		    			},
		    			include: [
		    				{
		    					model: LoanModel,
		    					where: {
		    						status: 1
		    					},
		    					attributes: ['label']
		    				}
		    			],
		    			attributes: ['amount']
		    		},{
		    			model: AdjustmentModel,
		    			required: false,
		    			where: {
		    				status: 1,
		    				year: year,
		    				month: month,
		    				period: period,
		    			}
		    		},{
		    			model: DisputeModel,
		    			required: false,
		    			where: {
		    				admin_status: 2,
		    				year: year,
		    				month: month,
		    				period: period,
		    			},
		    			attributes: ['hour','type','date']
		    		},{
		    			model: IncentiveModel,
		    			required: false,
		    			where: {
		    				status: 1,
		    				mode: 2,
		    				$or: [
		    					{
		    						to: null
		    					},{
		    						to: ''
		    					},{
		    						to: {
		    							$lte: start_date
		    						}
		    					}
		    				],
		    				$or: [
		    					{
		    						period: 2
		    					},{
		    						period: PP
		    					}
		    				]
		    			},
		    			attributes: ['label','amount','period','taxable']
		    		},{
	  					model: UserSettingModel,
	  					required: false
	  				}
	  			],
	  			attributes: ['id','shortid','employee_number','first_name','last_name','company_branch_id','department_id','job_title_id'],
	  			// offset: offset,
	    	// 	limit: limit,
	  		});

		}).then(function(data){
  			shifts = data;
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
  			let record = TimeKeeping.calculate(shifts, holiday, setting ,createPriod);
  			let container = ``;
  			if(record.length){
  				let i = 0;
  				for(let key in record){
  					i++;
  					let incentive = record[key].incentive;
  					
  					let adjustment = record[key].adjustment;
  					let loan = record[key].loans;
  					let company = record[key].company;
  					let summary = record[key].summary;
  					//console.log(record);
  					let payment = record[key].payment;
  					let logo  = company ? company.logo : '';
  					let src = logo ? res.locals.baseUrl + '/uploads/logo/'+ logo : res.locals.baseUrl + '/img/logo.png';
  					
  					let companyName = company ? company.name : '';
  					let location = company ? company.location : '';
  					let address = company ? company.address : '';
  					let earnings = ``;
  					let deductions = ``;
  					let loanData = ``;
  					let incentiveData = ``;
  					let salaryAdjustment = ``;

  					if(adjustment.length){
  						for(let a in adjustment){
  							salaryAdjustment += `<li>
								<span>Salary Adjusment</span>
								<span>`+ currency(adjustment[a].amount) +`</span>
							</li>`;
  						}
  					}

  					if(loan.length){
  						for(let l in loan){
  							loanData += `<li>
								<span>`+ loan[l].loan.label +`</span>
								<span>`+ currency(loan[l].amount) +`</span>
							</li>`;
  						}
  					}
  					if(incentive.length){
  						for(let inc in incentive){
  							incentiveData += `<li>
								<span>`+ incentive[inc].label +`</span>
								<span>`+ currency(incentive[inc].amount) +`</span>
							</li>`;
  						}
  					}

  					if(payment.Basic){
  						earnings += `<li>
							<span>Basic Pay</span>
							<span>`+ currency(payment.Basic) +`</span>
						</li>`;
  					}
					if(summary.PaidLeave){
  						earnings += `<li>
							<span>Paid Leave (`+ summary.PaidLeave +`Hr)</span>
							<span>`+ currency(payment.PaidLeave) +`</span>
						</li>`;
  					}
					if(summary.NightShift){
  						earnings += `<li>
							<span>Night Shift (`+ summary.NightShift +`Hr)</span>
							<span>`+ currency(payment.NightShift) +`</span>
						</li>`;
  					}
					if(summary.Overtime){
  						earnings += `<li>
							<span>Regular Overtime (`+ summary.Overtime +`Hr)</span>
							<span>`+ currency(payment.Overtime) +`</span>
						</li>`;
	  				}
					if(summary.OvertimeND){
  						earnings += `<li>
							<span>Regular Overtime : Night Shift (`+ summary.OvertimeND +`Hr)</span>
							<span>`+ currency(payment.OvertimeND) +`</span>
						</li>`;
	  				}
					if(summary.RestDayPay){
  						earnings += `<li>
							<span>Rest Day Pay (`+ summary.RestDayPay +`Hr)</span>
							<span>`+ currency(payment.RestDayPay) +`</span>
						</li>`;
	  				}
					if(summary.RestDayPayND){
  						earnings += `<li>
							<span>Rest Day Pay : Night Shift (`+ summary.RestDayPayND +`Hr)</span>
							<span>`+ currency(payment.RestDayPayND) +`</span>
						</li>`;
	  				}
					if(summary.RestDayOvertime){
  						earnings += `<li>
							<span>Rest Day : Overtime (`+ summary.RestDayOvertime +`Hr)</span>
							<span>`+ currency(payment.RestDayOvertime) +`</span>
						</li>`;
	  				}
					if(summary.RestDayOvertimeND){
  						earnings += `<li>
							<span>Rest Day Overtime : Night Shift (`+ summary.RestDayOvertimeND +`Hr)</span>
							<span>`+ currency(payment.RestDayOvertimeND) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHoliday){
  						earnings += `<li>
							<span>Special Holiday (`+ summary.SpecialHoliday +`Hr)</span>
							<span>`+ currency(payment.SpecialHoliday) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayND){
  						earnings += `<li>
							<span>Special Holiday : Night Shift (`+ summary.SpecialHolidayND +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayND) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayOvertime){
  						earnings += `<li>
							<span>Special Holiday : Overtime (`+ summary.SpecialHolidayOvertime +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayOvertime) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayOvertimeND){
  						earnings += `<li>
							<span>Special Holiday : Overtime : Night Shift (`+ summary.SpecialHolidayOvertimeND +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayOvertimeND) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayRestDay){
  						earnings += `<li>
							<span>Special Holiday : Rest Day (`+ summary.SpecialHolidayRestDay +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayRestDay) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayRestDayND){
  						earnings += `<li>
							<span>Special Holiday : Rest Day : Night Shift (`+ summary.SpecialHolidayRestDayND +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayRestDayND) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayRestDayOvertime){
  						earnings += `<li>
							<span>Special Holiday : Rest Day Overtime (`+ summary.SpecialHolidayRestDayOvertime +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayRestDayOvertime) +`</span>
						</li>`;
	  				}
					if(summary.SpecialHolidayRestDayOvertimeND){
  						earnings += `<li>
							<span>Special Holiday : Rest Day Overtime : Night Shift (`+ summary.SpecialHolidayRestDayOvertimeND +`Hr)</span>
							<span>`+ currency(payment.SpecialHolidayRestDayOvertimeND) +`</span>
						</li>`;
	  				}
					if(summary.LegalHoliday){
  						earnings += `<li>
							<span>Legal Holiday (`+ summary.LegalHoliday +`Hr)</span>
							<span>`+ currency(payment.LegalHoliday) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayND){
  						earnings += `<li>
							<span>Legal Holiday : Night Shift (`+ summary.LegalHolidayND +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayND) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayOvertime){
  						earnings += `<li>
							<span>Legal Holiday : Overtime (`+ summary.LegalHolidayOvertime +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayOvertime) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayOvertimeND){
  						earnings += `<li>
							<span>Legal Holiday : Overtime : Night Shift (`+ summary.LegalHolidayOvertimeND +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayOvertimeND) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayRestDay){
  						earnings += `<li>
							<span>Legal Holiday : Rest Day (`+ summary.LegalHolidayRestDay +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayRestDay) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayRestDayND){
  						earnings += `<li>
							<span>Legal Holiday : Rest Day : Night Shift (`+ summary.LegalHolidayRestDayND +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayRestDayND) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayRestDayOvertime){
  						earnings += `<li>
							<span>Legal Holiday : Rest Day Overtime (`+ summary.LegalHolidayRestDayOvertime +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayRestDayOvertime) +`</span>
						</li>`;
	  				}
					if(summary.LegalHolidayRestDayOvertimeND){
  						earnings += `<li>
							<span>Legal Holiday : Rest Day Overtime : Night Shift (`+ summary.LegalHolidayRestDayOvertimeND +`Hr)</span>
							<span>`+ currency(payment.LegalHolidayRestDayOvertimeND) +`</span>
						</li>`;
	  				}
	  				if(summary.disputeRestDay){
  						earnings += `<li>
							<span>Dispute : Rest Day (`+ summary.disputeRestDay +`Hr)</span>
							<span>`+ currency(payment.disputeRestDay) +`</span>
						</li>`;
	  				}
	  				if(summary.disputeOvertime){
  						earnings += `<li>
							<span>Dispute : Overtime (`+ summary.disputeOvertime +`Hr)</span>
							<span>`+ currency(payment.disputeOvertime) +`</span>
						</li>`;
	  				}
	  				if(summary.disputeLeave){
  						earnings += `<li>
							<span>Dispute : Leave with pay (`+ summary.disputeOvertime +`Hr)</span>
							<span>`+ currency(payment.disputeOvertime) +`</span>
						</li>`;
	  				}
	  				if(summary.disputeNolog){
  						earnings += `<li>
							<span>Dispute : No time in/ time out (`+ summary.disputeNolog +`Hr)</span>
							<span>`+ currency(payment.disputeNolog) +`</span>
						</li>`;
	  				}

					if(summary.Absent){
  						deductions += `<li>
							<span>Absent (`+ summary.Absent +`Day)</span>
							<span>`+ currency(payment.Absent) +`</span>
						</li>`;
	  				}
					if(summary.LateUndertime){
  						deductions += `<li>
							<span>Late/Undertime (`+ summary.LateUndertime +`Min)</span>
							<span>`+ currency(payment.LateUndertime) +`</span>
						</li>`;
	  				}
					deductions += `<li>
						<span>SSS Contribution</span>
						<span>`+ currency(payment.SSS) +`</span>
					</li>`;
					deductions += `<li>
						<span>Philhealth Contribution</span>
						<span>`+ currency(payment.Philhealth) +`</span>
					</li>`;
					deductions += `<li>
						<span>Pagibig Contribution</span>
						<span>`+ currency(payment.Pagibig) +`</span>
					</li>`;
					deductions += `	<li>
						<span>Withholding Tax</span>
						<span>`+ currency(payment.WithholdingTax) +`</span>
					</li>`;

	  				let fullName = record[key].first_name +` `+ record[key].last_name;
	  				let createCode = fullName.toUpperCase() +' '+ year + month + period;
	  				//var canvas = new Canvas();
					//let code = JsBarcode(canvas, createCode);
					//const dataUrl = canvas.toDataURL();
					//console.log(dataUrl);

  					container += `
		  				<div class="container">
							<div class="company">
								<img src="`+ src +`">
								<h1>`+ companyName +`</h1>
								<div>
									<span>`+ address +`</span><br>
									<span>`+ location +`</span>
								</div>
							</div>
							<div class="employee">
								<h4>`+ record[key].first_name +` `+ record[key].last_name +`</h4>
								<div>Payroll Period: <span>`+ record[key].period +`</span></div>
								<div>Department: <span>`+ record[key].department +`</span></div>
								<div>Designation: <span>`+ record[key].designation +`</span></div>
								<div>Rate: <span>`+ currency(record[key].salary.month) +`</span></div>
							</div>

							<table>
								<thead>
									<tr>
										<td width="50%">
											<span>Earnings</span>
											<span class="float-right">Amount</span>
										</td>
										<td width="50%">
											<span>Deductions</span>
											<span class="float-right">Amount</span>
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<ul>
												`+ earnings +`
												`+ salaryAdjustment +`
											</ul>
										</td>
										<td>
											<ul>
												`+ deductions +`
												<li>-------------------------</li>
												`+ loanData +`
												`+ incentiveData +`
											</ul>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="tbl">
								<div class="td">
									<h5>GROSS PAY : <span class="float-right">`+ currency(payment.Gross) +`</span></h5>
								</div>
								<div class="td">
									<h5>TOTAL DEDUCTIONS : <span class="float-right">`+ currency(payment.totalDeduction) +`</span></h5>
									<h3>NET PAY : <span class="float-right">`+ currency(payment.NetPay) +`</span></h3>
								</div>
							</div>
							
						</div>
						
  					`;
  					if(i < record.length){
  						container += `<div class='page-break'></div>`;
  					}
  				}
  			}

  			let html = `
				<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
				<link href="`+ res.locals.baseUrl +`/css/courier.css" rel="stylesheet">
				<style>
					.container{
						width: 100%;
						margin: 0 auto;
						border: #000 solid 0;
						font-size: 10px;
						font-family: 'Courier New';
					}
					.company{
						text-align: center;
						margin-bottom: 25px;
					}
					h1{
						font-size: 24px;
						margin-bottom: 0;
					}
					h3{
						font-size: 18px;
						margin: 0;
					}
					h4{
						font-size: 22px;
						margin-bottom: 5px;
					}
					h5{
						margin-bottom: 5px;
						font-size: 15px;
					}
					img{
						max-height: 80px;
					}
					.employee{
						margin-bottom: 15px;
					}
					.employee span{
						
					}
					table{
						border-collapse: collapse;
						width: 100%;
					}
					thead td{
						background: #eeeeee;
					}
					td{
						border: #616161 solid 1px;
						padding: 0.75rem 0.75rem;
						font-size: 14px;
						vertical-align: top;
					}
					.float-right{
						float: right;
					}
					ul{
						margin: 0;
						padding: 0;
						list-style: none;
						overflow-x: hidden;
					}
					li{
						font-size: 10px;
						line-height: 20px;
					}
					li span:first-child{
						background: #fff;
						padding-right: 0.33em;
					}
					li span + span{
						float: right;
						background: #fff;
						padding-left: 0.33em;
					}
					.center{
						text-align: center;
					}
					.page-break{ 
						display: block; 
						page-break-before: always; 
					}
					.tbl{
						margin-top: 15px;
						display: table;
						width: 100%;
					}
					.td{
						display: table-cell;
						vertical-align: top;
						width: 50%;
						padding: 0.75rem 0.75rem;
					}
					.code{
						height: 50px;
					}
					.code span{
						display: inline-block;
						height: 35px;
						width: 3px;
						background: #212121;
						margin-right: 3px;
					}
				</style>
				
  			` + container;

  			let filename = 'Payment-'+ year + month + period +'.pdf';
  			conversion({ 
				html: html,
				paperSize:'A4',
				format: {
			        quality: 100
			    }
			}, function(err, pdf) {
				res.setHeader('Content-Type', 'application/pdf');
				res.setHeader('Content-Disposition', 'attachment; filename='+ filename);
				pdf.stream.pipe(res);
				//SAVE To Server
				//let path = 'assets/reports/payment/'+ filename;
				//var output = fs.createWriteStream(path);
				//pdf.stream.pipe(output);				
			});
  		});
		
	});
}

const currency = function(num){
	if(num){
		return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
	}else{
		return 0.00;
	}
}