const moment     	= require('moment-timezone');
	moment.tz.setDefault('Asia/Manila');
const { 
	sequelize,
	UsersModel,
	LoanPaymentModel,
	ConfigModel
} = require('../../config/Sequelize');

function LoanPayment(){
	
	this.execute = function(){
		let date = moment();
		let dayToday = moment(date).format('D');
		let monthToday = moment(date).format('MM');
		let yearToday = moment(date).format('YYYY');
		let daysInMonth = moment(date).daysInMonth();
		
		ConfigModel.findOne({
			where: {
				id: 1
			},
			raw: true
		}).then(function(data){
			json = data;
			json = JSON.parse(json.json);
			let cutoff = json.cutoff;
			let period = 'A';
			let payDay = '';

			if(dayToday == cutoff.A_day){
				period = 'A';
				payDay= cutoff.A_day;
			}else if(dayToday > cutoff.A_day){
				period = 'B';
				if(dayToday == cutoff.B_day){
					payDay = cutoff.B_day;
				}else{
					payDay = daysInMonth;
				}
			}
			
			//execute task
			if(dayToday == payDay){
				LoanPaymentModel.findAll({
					where: {
						year: yearToday,
						month: monthToday,
						period: period,
						status: 0
					},
					raw: true
				}).then(function(data){
					record = data;
					if(record.length){
						for(let x in record){
							let result = record[x];
							let reqData = {
								status: 1
							}
							
							otherData(result.id, result.user_id, result.loan_id);

							LoanPaymentModel.update(reqData,{
								where: {
									id: result.id
								}
							});
						}
					}
				});
			}
		});
		
	}

}

const otherData = function(id, user_id, loan_id){
	LoanPaymentModel.findAll({
		where:{
			id: {
				$lt: id
			},
			user_id: user_id,
			loan_id: loan_id
		},
		raw: true
	}).then(function(data){
		record = data;
		if(record){
			for(let i in record){
				let result = record[i];
				let reqData = {
					status: 1
				}
				LoanPaymentModel.update(reqData,{
					where: {
						id: result.id
					}
				});
			}
		}
	});
}

module.exports = new LoanPayment();