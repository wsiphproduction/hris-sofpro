const UserRole = require('../Helper/UserRole');
const AttendanceHelper= require('../Helper/AttendanceHelper');
const TSSHelper     = require('../Helper/TSSHelper');
const TSSDataHelper = require('../Helper/TSSDataHelper');
const OvertimeHelper= require('../Helper/OvertimeHelper');
const DTSReprocessHelper= require('../Helper/DTSReprocessHelper');
const ReprocessOTLeavesHelper = require('../Helper/ReprocessOTLeaveHelper');

const { 
	Op,
	CronJobModel,
	ConfigModel,
	ShiftsModel,
	LeaveDateModel,
	LeavesModel,
	TSSData,
	OvertimesModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		usrRole = data;
		return UserRole.get_role(user, 'settings-cron-management');
	}).then(function(data){
		user_role = data;
		if(!user_role.read) {
			res.render('Errors/403');
		}else{
			res.render('Settings/CronManagement/index',{
				user_role: user_role,
				route: 'settings-cron-management',
				usrRole: usrRole
			});
		}
	});
}

exports.fetch = function(req, res){
	let status = req.body.status ? req.body.status : '';
	let limit = 25;
	let page = req.body.page ? req.body.page : 1;
    let offset   = (parseInt(page) - 1) * parseInt(limit);
	let session 		= req.session;

	let where = {};

	if(status != ''){
    	where.status = status;
    }

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data) {
		config = data;
		json = config.json ? JSON.parse(config.json) : null;
		
		CronJobModel.findAndCountAll({
			where: where,
			limit: limit,
			offset: offset,
			order: [
				['id', 'DESC']
			]
		}).then(function(data){
			records = data;
			numrows = records.count;
			count = 0;
			if(limit < numrows){
				count = numrows / limit;
				count = Math.ceil(count);
			}else{
				count = 0;
			}
			res.status(200).json({
				success: true,
				records: records.rows,
				count: count,
				numrows: numrows,
				config: config,
				session: session
			});
		});
	});	
}

exports.process = function(req, res){
	let id = req.body.id;
	let target_date = req.body.target_date

	let reqData = {}
		
	reqData.status = 4
	
	CronJobModel.update(reqData,{
		where:{
			id:id
		}
	}).then(function(data){

		AttendanceHelper.proccess('biometric', target_date);
		// setTimeout(function(){
		// 	AttendanceHelper.proccess('csv', target_date);
		// }, 120000);		// after 2 mins
		
		setTimeout(function(){
			OvertimeHelper.process(target_date);
		}, 300000);			// after 5 mins
		
		setTimeout(function(){
			TSSDataHelper.process(target_date);
		}, 600000);			// after 10 mins
		
		setTimeout(function(){
			TSSHelper.process(target_date);
			reqData.status = 1
			CronJobModel.update(reqData,{
				where:{
					id:id
				}
			});
		}, 900000);			// after 15 mins

		res.status(200).json({
			success: true,
			action: 'fetch',
			msg: 'Configuration has been updated.'
		});

		setTimeout(function(){
			CronJobModel.findOne({
				where: {
					id: id
				},
			}).then(function(data){
				cron_results = data;
				if(cron_results.status == 4) {
					reqData.status = 2

					CronJobModel.update(reqData,{
						where:{
							id:id
						}
					});
				}
			});
		}, 1200000); // Run after 20mins
	});
	
}

exports.recalculate = function(req, res){
	let target_date = req.body.target_date

	DTSReprocessHelper.process4(target_date);
		res.status(200).json({
			success: true,
			action: 'fetch',
			msg: 'Configuration has been updated.'
		});

}

exports.reprocess_ot = function(req,res){
	let user 	= res.locals.user;
	let startOf = null;
	let endOf 	= null;
	let session = req.session;
	let start 	= req.body.start? req.body.start:null;
	let end 	= req.body.end?req.body.end:null;

	let where = {};
	let shift_without_ot = [];
	
	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data){
		config = data;
		json   = config.json ? JSON.parse(config.json) : null;

		let cutoff     = json.cutoff;
		let month_date = null;
		let period     = null;

		if (session.user) {
			month_date  = new Date(session.user.default_month_date);
			period 		= session.user.default_period
		} else {
			month_date = new Date();
			period     = 'A'
		}

		if ((start && end) && (start <= end)) {
			where.start_date = {
				$between: [start, end]
			}
		} else {
			month_date = res.locals.moment(month_date).format('YYYY-MM');
			if (period == 'A') {
				start = month_date + '-' + cutoff.A_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date + '-' + cutoff.A_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
			} else {
				start = month_date + '-' + cutoff.B_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date + '-' + cutoff.B_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
			}

			startOf = new Date(start);
			endOf = new Date(end);

			where.start_date = {
				$between: [startOf, endOf]
			}
		}

		where.primary_status = 2;
		where.shift_id = { [Op.ne]: null };

		console.log('WHERE OT: ', where);

		OvertimesModel.findAll({
			where: where,
			include:[
				{
					model: ShiftsModel,
					as: 'ot_shift_target',
					attributes:['id','user_id','date'],
					include:[
						{
							model: TSSData,
							as:'tss',
						}
					],
					required:true,
				},
			]
		}).then((data)=>{
			let overtime_data = data;
			let ot_tss     = overtime_data.map(el => el.ot_shift_target.tss);
			// let ot_shift_ids  = overtime_data.map(el => el.ot_shift_target.id);
			// console.log("OT SHIFT IDS: ", ot_shift_ids);
			// console.log("OT SHIFTS: ", ot_tss);

			for (i in ot_tss){
				if (ot_tss[i]) {
					let ot1 = ot_tss[i].OTHrs01 ? ot_tss[i].OTHrs01 : 0;
					let ot2 = ot_tss[i].OTHrs02 ? ot_tss[i].OTHrs02 : 0;
					let ot3 = ot_tss[i].OTHrs03 ? ot_tss[i].OTHrs03 : 0;
					let ot4 = ot_tss[i].OTHrs04 ? ot_tss[i].OTHrs04 : 0;
					let ot5 = ot_tss[i].OTHrs05 ? ot_tss[i].OTHrs05 : 0;
					let ot6 = ot_tss[i].OTHrs06 ? ot_tss[i].OTHrs06 : 0;
					let ot7 = ot_tss[i].OTHrs07 ? ot_tss[i].OTHrs07 : 0;
					let ot8 = ot_tss[i].OTHrs08 ? ot_tss[i].OTHrs08 : 0;
					let ot9 = ot_tss[i].OTHrs09 ? ot_tss[i].OTHrs09 : 0;
					let ot10 = ot_tss[i].OTHrs10 ? ot_tss[i].OTHrs10 : 0;
					let ot11 = ot_tss[i].OTHrs11 ? ot_tss[i].OTHrs11 : 0;
					let ot12 = ot_tss[i].OTHrs12 ? ot_tss[i].OTHrs12 : 0;
					let ot13 = ot_tss[i].OTHrs13 ? ot_tss[i].OTHrs13 : 0;
					let ot14 = ot_tss[i].OTHrs14 ? ot_tss[i].OTHrs14 : 0;
					let ot15 = ot_tss[i].OTHrs15 ? ot_tss[i].OTHrs15 : 0;
					let ot16 = ot_tss[i].OTHrs16 ? ot_tss[i].OTHrs16 : 0;
					let ot17 = ot_tss[i].OTHrs17 ? ot_tss[i].OTHrs17 : 0;
					let ot18 = ot_tss[i].OTHrs18 ? ot_tss[i].OTHrs18 : 0;
					let ot19 = ot_tss[i].OTHrs19 ? ot_tss[i].OTHrs19 : 0;
					let ot20 = ot_tss[i].OTHrs20 ? ot_tss[i].OTHrs20 : 0;
					let ot21 = ot_tss[i].OTHrs21 ? ot_tss[i].OTHrs21 : 0;
					let ot22 = ot_tss[i].OTHrs22 ? ot_tss[i].OTHrs22 : 0;
					let ot23 = ot_tss[i].OTHrs23 ? ot_tss[i].OTHrs23 : 0;
					let ot24 = ot_tss[i].OTHrs24 ? ot_tss[i].OTHrs24 : 0;
					let ot25 = ot_tss[i].OTHrs25 ? ot_tss[i].OTHrs25 : 0;
	
					let total_ot = (ot1 + ot2 + ot3 + ot4 + ot5 + ot6 + ot7 + ot8 + ot9 + ot10 + ot11 + ot12
						+ ot13 + ot14 + ot15 + ot16 + ot17 + ot18 + ot19 + ot20 + ot21 + ot22 + ot23 + ot24 + ot25).toFixed(4);
	
					if(total_ot <= 0){
						shift_without_ot.push(ot_tss[i].shift_id);
					}
				}
			}

			if (shift_without_ot.length) {
				ReprocessOTLeavesHelper.reprocess_ot(shift_without_ot);
			}

			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'Total reprocessed overtime that did not reflect: ' + shift_without_ot.length
			});
		});

	});
}

exports.reprocess_leave = function (req,res){
	let user 	= res.locals.user;
	let startOf = null;
	let endOf 	= null;
	let session = req.session;
	let start 	= req.body.start? req.body.start:null;
	let end 	= req.body.end?req.body.end:null;

	let where = {};
	let where_shift = {};
	let shift_without_leave = [];


	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data){
		config = data;
		json   = config.json ? JSON.parse(config.json) : null;

		let cutoff     = json.cutoff;
		let month_date = null;
		let period     = null;

		if (session.user) {
			month_date  = new Date(session.user.default_month_date);
			period 		= session.user.default_period
		} else {
			month_date = new Date();
			period     = 'A'
		}

		if ((start && end) && (start <= end)) {
			where.date = {
				$between: [start, end]
			}
			where_shift.date = {
				$between: [start, end]
			}
		} else {
			month_date = res.locals.moment(month_date).format('YYYY-MM');
			if (period == 'A') {
				start = month_date + '-' + cutoff.A_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date + '-' + cutoff.A_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
			} else {
				start = month_date + '-' + cutoff.B_from;
				start = res.locals.moment(new Date(start)).format('YYYY-MM-DD');
				end = month_date + '-' + cutoff.B_to;
				end = res.locals.moment(new Date(end)).format('YYYY-MM-DD');
				start = start > end ? res.locals.moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
			}

			startOf = new Date(start);
			endOf = new Date(end);

			where.date = {
				$between: [startOf, endOf]
			}
			where_shift.date = {
				$between: [startOf, endOf]
			}
		}

		console.log('WHERE LEAVE: ', where);

		where.date_is_filed = 1;

		LeaveDateModel.findAll({
			where:where,
			include:[
				{
					model: LeavesModel,
					where:{
						primary_status:2
					}
				}
			],
			order:[
				['date','ASC']
			]
		}).then((data)=>{
			let user_leaves = data;
			// where_shift.shift_type = {[Op.ne]:'NONE'}
			return ShiftsModel.findAll({
				where: where_shift,
				include: [
					{
						model: TSSData,
						as: 'tss',
						required:true,
					}
				],
				order: [
					['date', 'ASC']
				]
			}).then(function (data) {
				let shifts = data;

				for (ctr in user_leaves){
					// console.log("USER LEAVE ID: ", user_leaves[ctr].id, " LEAVE USER_ID: ", user_leaves[ctr].user_id, " DATE: ", user_leaves[ctr].date);
					if(user_leaves[ctr].credit == 1){
						let user_shift = shifts.filter(el => el.user_id == user_leaves[ctr].user_id && el.date == user_leaves[ctr].date );
						if (user_shift.length) {
							if(user_shift[0].check_in && user_shift[0].check_out){
								let tss_data = user_shift[0].tss;

								let l1 = tss_data.Leave01 ? tss_data.Leave01 : 0;
								let l2 = tss_data.Leave02 ? tss_data.Leave02 : 0;
								let l3 = tss_data.Leave03 ? tss_data.Leave03 : 0;
								let l4 = tss_data.Leave04 ? tss_data.Leave04 : 0;
								let l5 = tss_data.Leave05 ? tss_data.Leave05 : 0;
								let l6 = tss_data.Leave06 ? tss_data.Leave06 : 0;
								let l7 = tss_data.Leave07 ? tss_data.Leave07 : 0;
								let l8 = tss_data.Leave08 ? tss_data.Leave08 : 0;
								let l9 = tss_data.Leave09 ? tss_data.Leave09 : 0;
								let l10 = tss_data.Leave10 ? tss_data.Leave10 : 0;
								let l11 = tss_data.Leave11 ? tss_data.Leave11 : 0;
								let l12 = tss_data.Leave12 ? tss_data.Leave12 : 0;
								let l13 = tss_data.Leave13 ? tss_data.Leave13 : 0;
								let l14 = tss_data.Leave14 ? tss_data.Leave14 : 0;


								let total_leave = (l1 + l2 + l3 + l4 + l5 + l6 + l7 + l8 + l9 + l10 + l11 + l12 + l13 + l14).toFixed(4);
								// console.log("TOTAL LEAVE: ", total_leave);
								if (total_leave <= 0) {
									shift_without_leave.push(user_shift[0].id);
								}

								// console.log("LEAVES DOES NOT REFLECT: ", shift_without_leave);
							}
						}
					}
					
				}
				
				if(shift_without_leave.length){
					ReprocessOTLeavesHelper.reprocess_leaves(shift_without_leave);
				}

				res.status(200).json({
					success: true,
					action: 'fetch',
					msg: 'Total reprocessed leave that did not reflect: ' + shift_without_leave.length
				});
			});
		});

	});
}
