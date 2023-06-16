function SalaryComputation(){

	this.calculate = function(summary, salary, loans, adjustment, disputes, incentive, setting){
		//hour
		//minute
		let Basic = salary.basic ? salary.basic : 0;
		let absent = this.Absent(summary.Absent, salary);
		let NightShift = this.NightShift(summary.NightShift, salary);
		let LateUndertime = this.LateUndertime(summary.LateUndertime, salary);
		let Overtime = this.Overtime(summary.Overtime, salary);
		let OvertimeND = this.OvertimeND(summary.OvertimeND, salary);
		let RestDayPay = this.RestDayPay(summary.RestDayPay, salary);
		let RestDayPayND = this.RestDayPayND(summary.RestDayPayND, salary);
		let RestDayOvertime = this.RestDayOvertime(summary.RestDayOvertime, salary);
		let RestDayOvertimeND = this.RestDayOvertimeND(summary.RestDayOvertimeND, salary);
		let SpecialHoliday = this.SpecialHoliday(summary.SpecialHoliday, salary);
		let SpecialHolidayND = this.SpecialHolidayND(summary.SpecialHolidayND, salary);
		let SpecialHolidayOvertime = this.SpecialHolidayOvertime(summary.SpecialHolidayOvertime, salary);
		let SpecialHolidayOvertimeND = this.SpecialHolidayOvertimeND(summary.SpecialHolidayOvertimeND, salary);
		let SpecialHolidayRestDay = this.SpecialHolidayRestDay(summary.SpecialHolidayRestDay, salary);
		let SpecialHolidayRestDayND = this.SpecialHolidayRestDayND(summary.SpecialHolidayRestDayND, salary);
		let SpecialHolidayRestDayOvertime = this.SpecialHolidayRestDayOvertime(summary.SpecialHolidayRestDayOvertime, salary);
		let SpecialHolidayRestDayOvertimeND = this.SpecialHolidayRestDayOvertimeND(summary.SpecialHolidayRestDayOvertimeND, salary);
		let LegalHoliday = this.LegalHoliday(summary.LegalHoliday, salary);
		let LegalHolidayND = this.LegalHolidayND(summary.LegalHolidayND, salary);
		let LegalHolidayOvertime = this.LegalHolidayOvertime(summary.LegalHolidayOvertime, salary);
		let LegalHolidayOvertimeND = this.LegalHolidayOvertimeND(summary.LegalHolidayOvertimeND, salary);
		let LegalHolidayRestDay = this.LegalHolidayRestDay(summary.LegalHolidayRestDay, salary);
		let LegalHolidayRestDayND = this.LegalHolidayRestDayND(summary.LegalHolidayRestDayND, salary);
		let LegalHolidayRestDayOvertime = this.LegalHolidayRestDayOvertime(summary.LegalHolidayRestDayOvertime, salary);
		let LegalHolidayRestDayOvertimeND = this.LegalHolidayRestDayOvertimeND(summary.LegalHolidayRestDayOvertimeND, salary);
		let dispute = this.Dispute(disputes, salary);
		let SSS = 0;
		let Philhealth = 0;
		let Pagibig = 0;
		if(setting.sss == setting.period){
			SSS = this.SSS(salary);
		}
		if(setting.philhealth == setting.period){
			Philhealth = this.Philhealth(salary);
		}
		if(setting.pagibig == setting.period){
			Pagibig = 100;
		}
		let loanTotal = 0;
		if(loans.length){
			for(let l in loans){
				loanTotal += loans[l]['amount'];
			}
		}
		let adjustmentTotal = 0;
		if(adjustment.length){
			for(let x in adjustment){
				adjustmentTotal += adjustment[x]['amount'];
			}
		}
		//let incentiveTotal = 0;
		let incentiveTaxable = 0;
		let incentiveNonTaxable = 0;
		let PP = setting.period == 'A' ? 0 : 1;
		if(incentive.length){
			for(let x in incentive){
				let incentiveAmount = incentive[x].amount;
				if(incentive[x].period == 2){
					incentiveAmount = incentiveAmount / 2;
				}
				if(incentive[x].taxable == 0){
					incentiveNonTaxable += incentiveAmount;
				}else if(incentive[x].taxable == 1){
					incentiveTaxable += incentiveAmount;
				}
				
				//incentiveTotal += incentiveAmount;
			}
		}
		//console.log(setting);
		let earningTotal   = Basic
							+ NightShift
							+ Overtime
							+ OvertimeND
							+ RestDayPay
							+ RestDayPayND
							+ RestDayOvertime
							+ RestDayOvertimeND
							+ SpecialHoliday
							+ SpecialHolidayND
							+ SpecialHolidayOvertime
							+ SpecialHolidayOvertimeND
							+ SpecialHolidayRestDay
							+ SpecialHolidayRestDayND
							+ SpecialHolidayRestDayOvertime
							+ SpecialHolidayRestDayOvertimeND
							+ LegalHoliday
							+ LegalHolidayND
							+ LegalHolidayOvertime
							+ LegalHolidayOvertimeND
							+ LegalHolidayRestDay
							+ LegalHolidayRestDayND
							+ LegalHolidayRestDayOvertime
							+ LegalHolidayRestDayOvertimeND
							+ adjustmentTotal
							+ dispute.disputeRestDay
							+ dispute.disputeOvertime
							+ dispute.disputeLeave
							+ dispute.disputeNolog
							+ incentiveTaxable;
		let deduction 	 = absent 
							+ LateUndertime 
							+ SSS
							+ Philhealth
							+ Pagibig
							+ loanTotal;

		let taxable = earningTotal - deduction;
		let WithholdingTax = this.WithholdingTax(salary, taxable);
		let totalDeduction = deduction + WithholdingTax;
		let NetPay = (taxable + incentiveNonTaxable) - WithholdingTax;
		//console.log(incentiveNonTaxable);
		let data = {
			Basic: Basic,
			Absent: absent,
            PaidLeave: 0,
            NightShift: NightShift,
            LateUndertime: LateUndertime,
            Overtime: Overtime,
            OvertimeND: OvertimeND,
            RestDayPay: RestDayPay,
            RestDayPayND: RestDayPayND,
            RestDayOvertime: RestDayOvertime,
            RestDayOvertimeND: RestDayOvertimeND,
            SpecialHoliday: SpecialHoliday,
            SpecialHolidayND: SpecialHolidayND,
            SpecialHolidayOvertime: SpecialHolidayOvertime,
            SpecialHolidayOvertimeND: SpecialHolidayOvertimeND,
            SpecialHolidayRestDay: SpecialHolidayRestDay,
            SpecialHolidayRestDayND: SpecialHolidayRestDayND,
            SpecialHolidayRestDayOvertime: SpecialHolidayRestDayOvertime,
            SpecialHolidayRestDayOvertimeND: SpecialHolidayRestDayOvertimeND,
            LegalHoliday: LegalHoliday,
            LegalHolidayND: LegalHolidayND,
            LegalHolidayOvertime: LegalHolidayOvertime,
            LegalHolidayOvertimeND: LegalHolidayOvertimeND,
            LegalHolidayRestDay: LegalHolidayRestDay,
            LegalHolidayRestDayND: LegalHolidayRestDayND,
            LegalHolidayRestDayOvertime: LegalHolidayRestDayOvertime,
            LegalHolidayRestDayOvertimeND: LegalHolidayRestDayOvertimeND,
            earningTotal: earningTotal,
            SSS: SSS,
            Philhealth: Philhealth,
            Pagibig: Pagibig,
            Gross: earningTotal,
            totalDeduction: totalDeduction,
            WithholdingTax: WithholdingTax,
			disputeRestDay: dispute.disputeRestDay,
			disputeOvertime: dispute.disputeOvertime,
			disputeLeave: dispute.disputeLeave,
			disputeNolog: dispute.disputeNolog,
            NetPay: NetPay
		}

		
		return data;
	}

	this.Dispute = function(dispute, salary){
		let disputeRestDay = 0;
		let disputeOvertime = 0;
		let disputeLeave = 0;
		let disputeNolog = 0;
		if(dispute.length){
			for(let x in dispute){
				let number = dispute[x]['hour'];
				if(dispute[x]['type'] == 1){
					disputeRestDay += salary.hour * 1.3 * number;
				}
				if(dispute[x]['type'] == 2){
					disputeOvertime += salary.hour * 1.25 * number;
				}
				if(dispute[x]['type'] == 3){
					disputeLeave += salary.hour * number;
				}
				if(dispute[x]['type'] == 4){
					disputeNolog += salary.hour * number;
				}
			}
		}
		let data = {
			disputeRestDay: disputeRestDay,
			disputeOvertime: disputeOvertime,
			disputeLeave: disputeLeave,
			disputeNolog: disputeNolog
		}
		return data;
	}

	this.Absent = function(number, salary){

		let amount = 0;
		if(salary.hour && number){
			let absent = parseInt(number * 8);
			amount = absent * salary.hour;
		}
		return amount;
	}

	this.NightShift = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.LateUndertime = function(number, salary){
		let amount = 0;
		if(salary.minute && number){
			amount = number * salary.minute;
		}
		return amount;
	}

	this.Overtime = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = number * 1.25 * salary.hour;
		}
		return amount;
	}

	this.OvertimeND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.RestDayPay = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 1.3 * number;
		}
		return amount;
	}

	this.RestDayPayND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.RestDayOvertime = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 1.69 * number;
		}
		return amount;
	}

	this.RestDayOvertimeND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.SpecialHoliday = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 1.3 * number;
		}
		return amount;
	}

	this.SpecialHolidayND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.SpecialHolidayOvertime = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 1.69 * number;
		}
		return amount;
	}

	this.SpecialHolidayOvertimeND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.SpecialHolidayRestDay = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 1.5 * number;
		}
		return amount;
	}

	this.SpecialHolidayRestDayND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.SpecialHolidayRestDayOvertime = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * number * 1.95;
		}
		return amount;
	}

	this.SpecialHolidayRestDayOvertimeND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * number * 0.1;
		}
		return amount;
	}

	this.LegalHoliday = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 2 * number;
		}
		return amount;
	}

	this.LegalHolidayND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.LegalHolidayOvertime = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 2.6 * number;
		}
		return amount;
	}

	this.LegalHolidayOvertimeND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.LegalHolidayRestDay = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 2.6 * number;
		}
		return amount;
	}

	this.LegalHolidayRestDayND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.LegalHolidayRestDayOvertime = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 3.8 * number;
		}
		return amount;
	}

	this.LegalHolidayRestDayOvertimeND = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 0.1 * number;
		}
		return amount;
	}

	this.SSS = function(income){
		
		let salary = parseInt(income.month);
		//console.log(salary);
		switch(true) {
			case salary >= 1000 && salary <= 2249.99:
				amount = '80';
				break;
			case salary >= 2250 && salary <= 2749.99:
				amount = '100';
				break;
			case salary >= 2750 && salary <= 3249.99:
				amount = '120';
				break;
			case salary >= 3250 && salary <= 3749.99:
				amount = '140';
				break;
			case salary >= 3750 && salary <= 4249.99:
				amount = '160';
				break;
			case salary >= 4250 && salary <= 4749.99:
				amount = '180';
				break;
			case salary >= 4750 && salary <= 4249.99:
				amount = '200';
				break;
			case salary >= 5250 && salary <= 5749.99:
				amount = '220';
				break;
			case salary >= 5750 && salary <= 6249.99:
				amount = '240';
				break;
			case salary >= 6250 && salary <= 6749.99:
				amount = '260';
				break;
			case salary >= 6750 && salary <= 7219.99:
				amount = '280';
				break;
			case salary >= 7250 && salary <= 7749.99:
				amount = '300';
				break;
			case salary >= 7750 && salary <= 8249.99:
				amount = '320';
				break;
			case salary >= 8250 && salary <= 8749.99:
				amount = '340';
				break;
			case salary >= 8750 && salary <= 9249.99:
				amount = '360';
				break;
			case salary >= 8250 && salary <= 9749.99:
				amount = '380';
				break;
			case salary >= 9750 && salary <= 10249.99:
				amount = '400';
				break;
			case salary >= 10250 && salary <= 10749.99:
				amount = '420';
				break;
			case salary >= 10750 && salary <= 11249.99:
				amount = '440';
				break;
			case salary >= 11250 && salary <= 11749.99:
				amount = '460';
				break;
			case salary >= 11750 && salary <= 12249.99:
				amount = '480';
				break;
			case salary >= 12250 && salary <= 12749.99:
				amount = '500';
				break;
			case salary >= 12750 && salary <= 13249.99:
				amount = '520';
				break;
			case salary >= 13250 && salary <= 13749.99:
				amount = '540';
				break;
			case salary >= 13750 && salary <= 14249.99:
				amount = '560';
				break;
			case salary >= 14250 && salary <= 14749.99:
				amount = '580';
				break;
			case salary >= 14750 && salary <= 15249.99:
				amount = '600';
				break;
			case salary >= 15250 && salary <= 15749.99:
				amount = '620';
				break;
			case salary >= 15750 && salary <= 16249.99:
				amount = '640';
				break;
			case salary >= 16250 && salary <= 16749.99:
				amount = '660';
				break;
			case salary >= 16750 && salary <= 17249.99:
				amount = '680';
				break;
			case salary >= 17250 && salary <= 17749.99:
				amount = '700';
				break;
			case salary >= 17750 && salary <= 18249.99:
				amount = '720';
				break;
			case salary >= 18250 && salary <= 18749.99:
				amount = '740';
				break;
			case salary >= 18750 && salary <= 19249.99:
				amount = '760';
				break;
			case salary >= 19250 && salary <= 19749.99:
				amount = '780';
				break;
			case salary >= 19750:
				amount = '800';
				break;
			default:
				amount = '80';
				break;
		}
		return salary ? parseInt(amount) : 0;
	}

	this.Philhealth = function(income){
		let salary = parseInt(income.month);
		switch (true) {
			case salary >= 0 && salary <= 8999.99:
				amount = '100';
				break;		
			case salary >= 9000 && salary <= 9999.99:
				amount = '112.50';
				break;
			case salary >= 10000 && salary <= 10999.99:
				amount = '125';
				break;
			case salary >= 11000 && salary <= 11999.99:
				amount = '137.50';
				break;
			case salary >= 12000 && salary <= 12999.99:
				amount = '150';
				break;
			case salary >= 13000 && salary <= 13999.99:
				amount = '162.50';
				break;
			case salary >= 14000 && salary <= 14999.99:
				amount = '175';
				break;
			case salary >= 15000 && salary <= 15999.99:
				amount = '187.50';
				break;
			case salary >= 16000 && salary <= 16000.99:
				amount = '200';
				break;
			case salary >= 17000 && salary <= 17999.99:
				amount = '212.50';
				break;
			case salary >= 18000 && salary <= 18999.99:
				amount = '225';
				break;
			case salary >= 19000 && salary <= 19999.99:
				amount = '237.50';
				break;
			case salary >= 20000 && salary <= 20999.99:
				amount = '250';
				break;
			case salary >= 21000 && salary <= 21999.99:
				amount = '262.50';
				break;
			case salary >= 22000 && salary <= 22999.99:
				amount = '275';
				break;
			case salary >= 23000 && salary <= 23999.99:
				amount = '287.50';
				break;
			case salary >= 24000 && salary <= 24999.99:
				amount = '300';
				break;
			case salary >= 25000 && salary <= 25999.99:
				amount = '312.50';
				break;
			case salary >= 26000 && salary <= 26999.99:
				amount = '325';
				break;
			case salary >= 27000 && salary <= 27999.99:
				amount = '337.50';
				break;
			case salary >= 28000 && salary <= 28999.99:
				amount = '350';
				break;
			case salary >= 29000 && salary <= 29999.99:
				amount = '362.50';
				break;
			case salary >= 30000 && salary <= 30999.99:
				amount = '375';
				break;
			case salary >= 31000 && salary <= 31999.99:
				amount = '387.50';
				break;
			case salary >= 32000 && salary <= 32000.99:
				amount = '400';
				break;
			case salary >= 33000 && salary <= 33999.99:
				amount = '412.50';
				break;
			case salary >= 34000 && salary <= 34999.99:
				amount = '425';
				break;
			case salary > 35000:
				amount = '437.50';
				break;
			default:
				amount = '100';
				break;
		}
		return salary ? parseInt(amount) : 0;
	}

	this.WithholdingTax = function(income, taxable){

		let salary = income.month ? income.month / 2 : 0;

		let total = 0;
		let tax = 0;
		let over = 0;
		if(salary < 10417){
			tax = 0;
			over = 0;
		}else if(salary >= 10417 && salary <= 16666){
			tax = 0;
			over = (salary - 10417) * 0.20;
		}else if(salary >= 16667 && salary <= 33332){
			tax = 1250;
			over = (salary - 16667) * 0.25;
		}else if(salary >= 33333 && salary <= 83332){
			tax = 5416.67;
			over = (salary - 33333) * 0.30;
		}else if(salary >= 83333 && salary <= 333332){
			tax = 20416.67;
			over = (salary - 83333) * 0.32;
		}else if(salary >= 333333){
			tax = 100416.67;
			over = (salary - 333333) * 0.35;
		}
		total = tax + over;
		
		return salary ? total : 0;
	}

	this.Sample = function(number, salary){
		let amount = 0;
		if(salary.hour && number){
			amount = salary.hour * 1.69 * number;
		}
		return amount;
	}

}

module.exports = new SalaryComputation();