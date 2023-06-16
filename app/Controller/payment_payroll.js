const UserRole = require('../Helper/UserRole');
const Excel 	   = require('exceljs');
const fs = require('fs');
const csv = require('csv-parser');
const formidable = require('formidable');
const { 
	UsersModel,
	LoanModel,
	ConfigModel,
	Payslip,
	Payroll
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let uploadPath = './assets/uploads/';
	let filename = 'JPM Payrol.csv';
	// processCsv(uploadPath, filename);
	

	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		UserRole.get_role(user, 'payment-payroll').then(function(data){
			user_role = data;
			if(!user_role.read) {
				res.render('Errors/403');
			}else{
				res.render('Payment/Payroll/index', {
					route: 'payment-payroll',
					usrRole: usrRole,
					user_role: user_role
				});
			}
		});
	});
}

exports.fetch = function(req, res){
	let limit   = parseInt(req.body.limit);
	let page 	= req.body.page;
	let offset  = (parseInt(page) - 1) * parseInt(limit);
	
	Payroll.count().then(function(data){
		numrows = data;
		return Payroll.findAll({
			order: [
				['id', 'DESC']
			],
			offset: offset,
	    	limit: limit,
		});
	}).then(function(data){
		records = data;
		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
		res.status(200).json({
            success: true,
            records: records,
			count: count,
        });
	});
}

exports.upload = function(req, res){
	let result = [];
	let error = '';
	let uploadPath = './assets/uploads/import/';
	let form = new formidable.IncomingForm();
	form.parse(req, function (err, fields, files) {
		req.body = fields;
		let attachment 	= files.file;
		let size = attachment.size;
		let operation = req.body.operation;
		req.body.file = size ? size : '';
		req.checkBody('period').notEmpty().withMessage('The payroll period field is required.');
		req.checkBody('file').notEmpty().withMessage('The attachment field is required.');
		let errors = req.validationErrors();
		if(errors){
			res.status(422).json({
				success: false,
	            errors
			});
		}else{
			try{
				let date = res.locals.moment().format('YYYY-MM-DD');
				
				let period = req.body.period;
				let filename = req.body.period;
				let path = attachment.path;
				let origFileName = attachment.name;
				filename = filename + '.csv';
				fs.readFile(path, function(err, data){
					fs.writeFile(uploadPath + filename, data, function(err){
						if (err) console.log(err);
						fs.unlink(path, function(err){
		  						
						});
						raw = fs.createReadStream(uploadPath + filename);
						raw.on('error', function(){
							console.log(error);
						});
						raw.pipe(csv({
							mapHeaders: ({ header, index }) => header.toLowerCase()
						}))
						.on('headers', (headers) => {		
							let header = headers.map(function(v) {
							  return v.toLowerCase();
							});
							let arrayHeader = [
								'employee number',
								'employee name',
								'monthly rate',
								'this pay',
								'absence',
								'overtime hrs.',
								'amount',
								'gross pay',
								'deminimis',
								'reimburseable allowance/de minimis',
								'other fees & allowances',
								'total pay',
								'tax',
								'30th sss',
								'30th phic',
								'30th pag-ibig',
								'other deductions',
								'15th sss loan',
								'15th pagibig loan',
								'employee charges',
								'intellicare',
								'net pay'
							];
							//console.log(arrayHeader);
							let allFounded = arrayHeader.every( ai => header.includes(ai) );
							
							if(!allFounded){
								error = 'File import failed. Please follow the given format and try again.';
							}
						})
						.on('data', (data) => result.push(data))
						.on('end', () => {
							if(!error){

								if(result && result.length){
									Payroll.findOne({
										where: {
											period: period
										}
									}).then(function(data){
										payroll = data;
										if(payroll){
											payroll_id = payroll.id;
											processCsv(uploadPath, filename, payroll_id);
										}else{
											Payroll.create({
												period: period,
												attachment: filename,
												date: res.locals.moment().format('YYYY-MM-DD HH:ss:ss')
											}).then(function(data){
												payroll_id = data.id;
												processCsv(uploadPath, filename, payroll_id);
											});
										}
									});
									
								}
								res.status(200).json({
									success: true,
									action: 'close',
									msg: 'New record has been successfully saved.'
								});
							}else{
								var errors = [
									{	
										param: 'file',
										msg: error
									}
								]
								res.status(422).json({
									success: false,
									errors
								});
							}
						});
					});
				});
			}catch(error){

			}
		}
	});
}

const processCsv = function(uploadPath, filename, payroll_period=''){
	let result = [];
	let error = '';
	raw = fs.createReadStream(uploadPath + filename);
	raw.on('error', function(){
		console.log(error);
	});
	raw.pipe(csv({
		mapHeaders: ({ header, index }) => header.toLowerCase()
	}))
	.on('headers', (headers) => {		
		let header = headers.map(function(v) {
		  return v.toLowerCase();
		});
		let arrayHeader = [
			'employee number',
			'employee name',
			'monthly rate',
			'this pay',
			'absence',
			'overtime hrs.',
			'amount',
			'gross pay',
			'deminimis',
			'reimburseable allowance/de minimis',
			'other fees & allowances',
			'total pay',
			'tax',
			'30th sss',
			'30th phic',
			'30th pag-ibig',
			'other deductions',
			'15th sss loan',
			'15th pagibig loan',
			'employee charges',
			'intellicare',
			'net pay'
		];
		//console.log(arrayHeader);
		let allFounded = arrayHeader.every( ai => header.includes(ai) );
		
		if(!allFounded){
			error = 'File import failed. Please follow the given format and try again.';
		}
	})
	.on('data', (data) => result.push(data))
	.on('end', () => {
		if(!error && (result && result.length)){
			for(let i in result){
				let employee_number = result[i]['employee number'];
				let employee_name = result[i]['employee name'];
					employee_name = employee_name.split(',');
				let lname = employee_name[0];
				let fname = employee_name[1];
				
				let where = {}
				if(employee_number){
					where.employee_number = employee_number;
				}else if(lname){
					where.last_name = lname;
					where.first_name = fname;
				}

				UsersModel.findOne({
					where: where,
					attributes: ['id','first_name','last_name','employee_number'],
					raw: true
				}).then(function(data){
					user = data;
					if(user){
						let reqData ={
							user_id: user.id,
							payroll_period: payroll_period,
							employee_number: user.employee_number,
							employee_name: '',
							monthly_rate: result[i]['monthly rate'],
							this_pay: result[i]['this pay'],
							absence: result[i]['absence'],
							overtime_hrs: result[i]['overtime hrs.'],
							amount: result[i]['amount'],
							gross_pay: result[i]['gross pay'],
							reimburseable_allowance: result[i]['reimburseable allowance/de minimis'],
							other_fees_allowances: result[i]['other fees & allowances'],
							total_pay: result[i]['total pay'],
							tax: result[i]['tax'],
							sss30th: result[i]['30th sss'],
							phic30th: result[i]['30th phic'],
							pagibig30th: result[i]['30th pag-ibig'],
							other_deductions: result[i]['other deductions'],
							sss_loan15th: result[i]['15th sss loan'],
							pagibig_loan15th: result[i]['15th pagibig loan'],
							employee_charges: result[i]['employee charges'],
							intellicare: result[i]['intellicare'],
							net_pay: result[i]['net pay'],
						}
						Payslip.findOne({
							where:{
								payroll_period: payroll_period
							}
						}).then(function(data){
							payslip  = data;
							if(payslip){
								Payslip.update(reqData,{
									where:{
										id: payslip.id
									}
								});
							}else{
								Payslip.create(reqData);
							}
						});
					}
				});
				// console.log(result[i]);
			}
		}else{
			console.log(error);
		}
	});
}