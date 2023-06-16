const UserRole  = require('../Helper/UserRole');
const moment    = require('moment-timezone');
const $env 		= require('dotenv').config();
const _ = require('underscore');
	moment.tz.setDefault('Asia/Manila');
const {
	Op, 
	sequelize,
	UsersModel,
	ShiftsModel,
	RolePermissionModel,
	AnnouncementModel,
	HolidaysModel,
	ConfigModel,
	TempInOutModel,
	NotificationsModel,
	NotificationsReceiverModel,
	OvertimesModel,
	EventModel,
	LeavesModel,
	LeavePolicyModel,
	BusinessTripsModel,
	TSSData,
	UndertimeModel,
	DisputeModel,
	ChangeLogModel,
	BiometricLog,
	DeletedLogIssuesModel,
	LeaveDateModel,
} = require('../../config/Sequelize');
const WorkShift= require('../Scheduler/WorkShift');
const BusinessTrip = require('../Models/BusinessTrip');
const { where } = require('underscore');

exports.index = function(req, res){
	let user = res.locals.user;
	// WorkShift.execute();
	UserRole.allRead(user).then(function(data){
		user_role = data;
		return AnnouncementModel.findAll({
			limit: 8,
			order: [
				['created_at', 'DESC']
			]
		});
		
	}).then(function(data){
		announcement = data;
		return ConfigModel.findOne({
			where: {
				id: 1
			}
		});
		
	}).then(function(data){
		config = data;
		config = config.json ? JSON.parse(config.json) : null;
		return NotificationsReceiverModel.findAll({
			where: {
				user_id: user.id
			},
			limit: 25,
			order: [
				['created_at', 'DESC']
			],
			include: [
				{
					model: NotificationsModel,
					include: [
						{
							model: UsersModel,
							attributes: ['id','first_name','last_name', 'avatar', 'gender']
						}
					]
				}
			]
		});
	}).then(function(data){
		notification = data;
		notification   = JSON.parse(JSON.stringify(notification));
		res.render('index',{
			usrRole: user_role,
			announcement: announcement,
			notification: notification,
			config: config
		});
	});	
	/**/
}

exports.save_default_cut_off = function(req, res){
	let month_date = req.body.month_date;
	let period = req.body.period;
	let session = req.session;

	session.user.first_login = false;
	session.user.default_month_date = month_date;
	session.user.default_period = period;

	res.status(200).json({
			success: true,
			action: 'refresh'
		});
}

exports.save_calendar = function(req, res){
	let user = res.locals.user;
	let type = req.body.type;
	req.checkBody('date').notEmpty().withMessage('The date field is required.');
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	req.checkBody('end_date').notEmpty().withMessage('The end date field is required.');
	if(!(type == 'Office' || type == 'Shop/Warehouse')){
		req.checkBody('note').notEmpty().withMessage('The note field is required.');
	}

	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			user_id: user.id,
			date: res.locals.moment(new Date(req.body.date)).format('YYYY-MM-DD HH:mm:ss'),
			end_date: res.locals.moment(new Date(req.body.end_date)).format('YYYY-MM-DD HH:mm:ss'),
			type: req.body.type,
			comment: req.body.note
		}
		EventModel.create(reqBody).then(function(data){
			res.status(200).json({
				success: true,
				action: 'refresh',
				msg: 'New record has been successfully saved.'
			});
		});
	}
	// EventModel
}

exports.update_calendar = function(req, res){
	let user = res.locals.user;
	let type = req.body.type;
	let id = req.body.id;
	req.checkBody('type').notEmpty().withMessage('The type field is required.');
	if(!(type == 'Office Work' || type == 'Shop / Warehouse Visit')){
		req.checkBody('note').notEmpty().withMessage('The note field is required.');
	}

	let errors = req.validationErrors();
	if(errors){
		res.status(422).json({
			success: false,
            errors
		});
	}else{
		let reqBody = {
			type: req.body.type,
			comment: req.body.note
		}
		EventModel.update(reqBody,{
			where: {
				id:id
			}
		}).then(function(data){
			res.status(200).json({
				success: true,
				action: 'fetch',
				msg: 'New record has been successfully updated.'
			});
		});
	}
}

exports.delete_calendar = function(req, res){
	EventModel.destroy({
		where: {
			id: req.body.id
		}
	}).then(function(data){
		res.status(200).json({
			success: true
		});
	});
	
}

exports.delete_activate_log = function(req,res){
	let shift_id = req.body.shift_id;

	DeletedLogIssuesModel.findOne({
		where:{
			shift_id:shift_id,
		}
	}).then(function(data){
		let deleted_log = data;
		if(deleted_log){
			if(deleted_log.status == 1){
				return DeletedLogIssuesModel.update({status:0},{
					where:{
						shift_id:shift_id
					}
				}).then(function(data){	
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Data has been activated.'
					});
				});
			}
			else{
				return DeletedLogIssuesModel.update({status:1},{
					where:{
						shift_id:shift_id
					}
				}).then(function(data){	
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Data has been deleted.'
					});
				});
			}
		}
		else{
			return ShiftsModel.findOne({
				where:{
					id:shift_id
				},
				attributes:['id','date']
			}).then(function(data){
				let shift_info = data;
				
				return DeletedLogIssuesModel.create({
					date		: shift_info.date,
					shift_id	: shift_id,
					status		: 1
				}).then(function(data){
					res.status(200).json({
						success: true,
						action: 'fetch',
						msg: 'Data has been deleted.'
					});
				});
			});
		}
	});

}

exports.log_issue_monitoring_fetch = function(req,res){
	let user 	= res.locals.user;
	let session = req.session;
	
	//PARAMETERS
	let type 		= !req.body.type? 0: req.body.type;
	let type_status = req.body.type_status;
	let key     	= req.body.key;

	//PAGINATION
	let limit 	= parseInt(req.body.limit);
	let page	= parseInt(req.body.page == 0? 1:req.body.page);
	let offset  = parseInt(limit * (page - 1));
	
	let now = res.locals.moment().format('YYYY-MM-DD');
	let currentYear = res.locals.moment(now).format('YYYY');

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function(data){
		config = data;
		json = config.json ? JSON.parse(config.json) : null;

		let cutoff = json.cutoff;

		let month_date = session.user ? session.user.default_month_date : new Date();
		let period = session.user ? session.user.default_period : 'A';

		month_date = res.locals.moment(month_date).format('YYYY-MM');
		let start = null;
		let end = null;
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

		whereUser = {};
		whereUser[Op.or] = [
			{
				secretary_id: user.id
			}, {
				approver_id: user.id
			},{
				secondary_approver_id: user.id
			},
		];
		whereUser.status = 1;

		//SEARCH KEY
		if(key){
			whereUser.$or=[
				{employee_number:{ [Op.like]:'%' + key + '%'}},
				{last_name:{[Op.like]:'%' + key + '%'}},
				{first_name:{[Op.like]:'%' + key + '%'}}
			];
		}
		
		return UsersModel.findAll({
			where: whereUser,
			attributes: ['id'],
			order: [
				['last_name', 'ASC']
			],
		}).then(function(data){
			let user_ids = data.map(el => el.id);

			return DeletedLogIssuesModel.findAll({
				where:{
					date	:{$between:[startOf, endOf]},
					status	: 1,
				},
				attributes:['shift_id']
			}).then(function(data){
				let deleted_shift = data.map(el => el.shift_id);

				let where_shift = {};

				//USER IDS
				if(user_ids){
					where_shift.user_id = {
						[Op.in]:user_ids
					}
				}

				//WHERE DATE
				where_shift.date = {
					$between: [startOf, endOf]
				};

				//Deleted records
				if(type_status == '1' && type == '1'){
					where_shift.$and = [
						{shift_type:{[Op.ne]:'NONE'}},
						{id:{[Op.notIn]:deleted_shift}}
					];
				}
				else if(type_status == '2' && type == '1'){
					where_shift.$and = [
						{shift_type:{[Op.ne]:'NONE'}},
						{id:{[Op.in]:deleted_shift}}
					];
				}		

				// CHECK THE CHOSEN TYPE
				/*
					1. TIME OUT AND TIME IN
					2. TSS DATA WITHOUT SHIFT
					3. APPROVED OT W/O ACTUAL TIME IN AND OUT OR NO SHIFT
					4. DUPLICATE TSS DATA RECORD
					5. DUPLICATE SHIFT
				*/
				if (type == '1') {
					
					//PROBLEMS
					where_shift.$or = [
						{ actual_check_in: { [Op.is]: null } },
						{ actual_check_out: { [Op.is]: null } },
						{ shift_type: { [Op.is]: null } }
					];
					where_shift.$and = [
						{ shift_type: { [Op.ne]: 'NONE' } }
					];

					ShiftsModel.count({
						where:where_shift,
					}).then(function(data){
						let total_rows = data;

						return ShiftsModel.findAll({
							where:where_shift,
							include:[
								{
									model:UsersModel,
									required:true,
									attributes:['employee_number','last_name','first_name']
								}
							],
							order:[
								['date','DESC']
							],
							offset:offset,
							limit:limit
						}).then(function(data){
							let records = data;
							res.status(200).json({
								records    : records,
								total_rows : total_rows,
							});
						});
					});
				}
				if (type == '2') {
					let shift_without_leave = [];
					LeaveDateModel.findAll({
						where:{
							user_id: { [Op.in]: user_ids },
							date: { [Op.between]: [startOf, endOf] },
							date_is_filed: 1
						},
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
									model: UsersModel,
									required: true,
									attributes: ['employee_number', 'last_name', 'first_name']
								},
								{
									model: TSSData,
									as: 'tss',
								}
							],
							order: [
								['date', 'ASC']
							]
						}).then(function (data) {
							let shifts = data;

							for (ctr in user_leaves){
								// console.log("USER LEAVE ID: ", user_leaves[ctr].id, " LEAVE USER_ID: ", user_leaves[ctr].user_id, " DATE: ", user_leaves[ctr].date);
								let user_shift = shifts.filter(el => el.user_id == user_leaves[ctr].user_id && el.date == user_leaves[ctr].date );
								if (user_shift.length) {
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
										if (user_shift.length > 1 || user_shift[0].tss.length>1){
											user_shift[0].is_double_shift = 1;
										}
										else{
											user_shift[0].is_double_shift = 0;
										}
										shift_without_leave.push(user_shift[0]);
									}
								}
							}

							let rec_start = parseInt(limit * (req.body.page - 1) );
							let rec_end   = parseInt(rec_start + limit);
							// console.log('SHIFT ERROR LENGTH: ', shift_without_leave.length,' REC START: ', rec_start, ' REC END: ',rec_end);
							res.status(200).json({
								total_rows: shift_without_leave.length,
								records: shift_without_leave.slice(rec_start, rec_end),
							});
						});
					});
				}
			});
		});
	});
}

exports.fetch = function(req, res){
	let user 			= res.locals.user;
	let isSupervisor 	= res.locals.isSupervisor;
	let session 		= req.session;
	let complete_shift 	= true;
	
	let now = res.locals.moment().format('YYYY-MM-DD');
	let currentYear = res.locals.moment(now).format('YYYY');

	ConfigModel.findOne({
		where: {
			id: 1
		}
	}).then(function (data) {
		config = data;
		json = config.json ? JSON.parse(config.json) : null;

		let cutoff = json.cutoff;

		let month_date = session.user ? session.user.default_month_date : new Date();
		let period = session.user ? session.user.default_period : 'A';

		month_date = res.locals.moment(month_date).format('YYYY-MM');
		let start = null;
		let end = null;
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

		ShiftsModel.findAll({
			where: {
				user_id: user.id,
				date: {
					$lte: now
				}
			},
			limit: 15,
			order: [
				['date','DESC']
			],
			attributes: ['date','actual_check_in','actual_check_out']
		}).then(function(data){
			schedule = data;
			return ShiftsModel.findAll({
				where: {
					user_id: user.id,
					$and: [
					sequelize.where(sequelize.fn('YEAR', sequelize.col('date')), currentYear)
					]
				},
				group : [sequelize.fn('MONTH', sequelize.col('date'))],
				attributes: [
					[sequelize.fn('MONTH', sequelize.col('date')), 'month'],
					[sequelize.fn('SUM', sequelize.col('paid_hours')), 'total']
				],
			});
			
		}).then(function(data){
			shift = data;
			shift = shift ? JSON.parse(JSON.stringify(shift)) : [];
			return OvertimesModel.findAll({
				where: {
					user_id: user.id,
					primary_status: 2,
					$and: [
						sequelize.where(sequelize.fn('YEAR', sequelize.col('start_date')), currentYear)
					]
				},
				attributes: [
					'type',
					'start_date',
					'end_date',
					'start_time',
					'end_time',
					[sequelize.fn('MONTH', sequelize.col('start_date')), 'month']
				]
			});
			
		}).then(function(data){
			overtime = data;
			overtime = overtime ? JSON.parse(JSON.stringify(overtime)) : [];

			whereUser = {};
			whereUser[Op.or] = [
				{
					secretary_id: user.id
				}, {
					approver_id: user.id
				},{
					secondary_approver_id: user.id
				},
			];
			whereUser.status = 1;

			//end_date = moment().toDate('YYYY-MM-DD');
			//start_date = moment().toDate('YYYY-MM-DD');
			//start_date = moment().subtract(60,'days').format('YYYY-MM-DD');
			//startOf = new Date(start_date);
			//endOf = new Date(end_date);
			//startOf =  moment().subtract(15,'days').format('YYYY-MM-DD');
			//endOf = moment().subtract(0,'days').format('YYYY-MM-DD');
			// console.log(startOf + ' --- ' + endOf);
			
			return UsersModel.findAll({
				where: whereUser,
				attributes: ['id','first_name','last_name', 'shortid', 'employee_number'],
				include: [
					{
						model: ShiftsModel,
						// where : {
						// 	primary_status: 1,
						// },
						where: {
							date: {
								$between: [startOf, endOf]
							},
						},
						separate: true,
						attributes: [
							'id',
							'user_id',
							'date',
							'check_in',
							'check_out',
							'actual_check_in',
							'actual_check_out',
							'type',
							'between_start',
							'between_end',
							'shift_length',
							'onsite',
							'shift_type',
						]
					}, {
						model: TSSData,
						where: {
							//primary_status: 2,
							date: {
								$between: [startOf, endOf]
							},
						},
						include:[
							{
								model: ShiftsModel,
								as: 'shift',
								required: false
							},
							{
								model: OvertimesModel,
								as: 'overtime',
								required: false
							},
						],
						order: [
							['date','asc']
						],
						separate: true,
					}
				],
				order: [
					['last_name', 'ASC']
				],
			});
			
		}).then(function(data){
			users = data;
			
			let user_ids = [];
			let where_logs = {}
			let logs_end_of = res.locals.moment(new Date(endOf)).utc().endOf('day').format('YYYY-MM-DDTHH:mm:ssZ');
			logs_end_of = new Date(logs_end_of)

			where_logs.date = {
				$between: [startOf, logs_end_of]
			}

			if(users && users.length){
				user_ids = _.pluck(users, 'id');
				user_ids = [...new Set(user_ids)];
				where_logs.userId = {
						[Op.in]: user_ids
				}
			}

			return BiometricLog.findAll({
				where: where_logs,
				order:[
					['id','asc']
				]
			}).then(data=>{
				log_data = data;

				let where_filter = {};
				where_filter = {
					[Op.and]: [
						{
						[Op.or]: [
								{
								primary_status: 1
							},
							{
								backup_status: 1
							}
							]
						},
						{
						[Op.or]: [
								{
								primary_approver: user.id
							},
							{
								backup_approver: user.id
							}
							]
						}
					]
				}

				let leave_where_filter = {}
				leave_where_filter = {
					 [Op.and]: [
						where_filter,
						{
						[Op.or]: [
							{
								start_date: {
									$between: [startOf, endOf]
								}
							},
							{
								end_date: {
									$between: [startOf, endOf]
								}
							}
						]
						}
					]
				}
				LeavesModel.findAll({
					where: leave_where_filter,
					include: [
						{
							model: UsersModel,
							as: 'applicant',
							attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
						},
					],
					attributes: ['id', 'user_id', 'start_date','end_date', '_token', 'primary_status', 'backup_status']
				}).then(function(data){
					pending_leaves = data;

					let overtime_where_filter = {}
					overtime_where_filter = {
						[Op.and]: [
							where_filter,
							{
							[Op.or]: [
								{
									start_date: {
										$between: [startOf, endOf]
									}
								},
								{
									end_date: {
										$between: [startOf, endOf]
									}
								}
							]
							}
						]
					}

					return OvertimesModel.findAll({
						where: overtime_where_filter,
						include: [
							{
								model: UsersModel,
								as: 'applicant',
								attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
							},
						],
						attributes: ['id', 'user_id', 'start_date','end_date', 'start_time','end_time', '_token', 'primary_status', 'backup_status']
					}).then(function(data){
						pending_overtime = data;

						let undertime_where_filter = {}						
						undertime_where_filter = {
							[Op.and]: [
								where_filter,
								{
									date: {
										$between: [startOf, endOf]
									}
								}
							]
						}

						return UndertimeModel.findAll({
						where: undertime_where_filter,
						include: [
							{
								model: UsersModel,
								as: 'applicant',
								attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
							},
						],
						attributes: ['id', 'user_id', 'date','time', '_token', 'primary_status', 'backup_status']
						}).then(function(data){
							pending_undertime = data;

							let business_trip_where_filter = {}
							business_trip_where_filter = {
								[Op.and]: [
									where_filter,
									{
										[Op.or]: [
											{
												date_start: {
													$between: [startOf, endOf]
												}
											},
											{
												date_end: {
													$between: [startOf, endOf]
												}
											}
										]
									}
								]
							}

							return BusinessTripsModel.findAll({
							where: business_trip_where_filter,
							include: [
								{
									model: UsersModel,
									as: 'applicant',
									attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
								},
							],
							attributes: ['id', 'user_id', 'date_start','date_end', '_token', 'primary_status', 'backup_status']
							}).then(function(data){
								pending_business_trip = data;

								let dispute_where_filter = {}
								dispute_where_filter = {
									[Op.and]: [
										where_filter,
										{
											date: {
												$between: [startOf, endOf]
											}
										}
									]
								}

								return DisputeModel.findAll({
								where: dispute_where_filter,
								include: [
									{
										model: UsersModel,
										as: 'applicant',
										attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
									},
								],
								attributes: ['id', 'user_id', 'date', '_token', 'primary_status', 'backup_status']
								}).then(function(data){
									pending_dispute = data;

									let shifts_where_filter = {}
									shifts_where_filter = { 
										[Op.and]: [
											where_filter,
											{
												date: {
													$between: [startOf, endOf]
												},
												is_change_shift: 1,
												[Op.or]: [
													{
														new_checkin: {
															[Op.ne]: null
														}
													},
													{
														new_checkout: {
															[Op.ne]: null
														}
													}
												]
											}
										]
									}

									return ShiftsModel.findAll({
									where: shifts_where_filter,
									include: [
										{
											model: UsersModel,
											as: 'applicant',
											attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
										},
									],
									attributes: ['id', 'user_id', 'date', '_token', 'primary_status', 'backup_status']
									}).then(function(data){
										pending_change_shift = data;

										let logs_where_filter = {}
										logs_where_filter = {
											[Op.and]: [
												where_filter,
												{
													log_date: {
														$between: [startOf, endOf]
													}
												}
											]
										}

										return ChangeLogModel.findAll({
										where: logs_where_filter,
										include: [
											{
												model: UsersModel,
												as: 'applicant',
												attributes: ['id','first_name', 'last_name', 'employee_number', 'approver_id', 'secretary_id']
											},
										],
										attributes: ['id', 'user_id', 'log_date', 'primary_status', 'backup_status']
										}).then(async function(data){
											pending_change_log = data;

											for (i in users){
												if (users[i].shifts){
													if (users[i].shifts.length == 0) {
														complete_shift = false;
														break;
													}
												}
											}

											isApprover = await isUserApprover(user.id);

											res.status(200).json({
												success: true,
												schedule: schedule,
												overtime: overtime,
												shift: shift,
												users: users,
												user: user,
												startOf: startOf,
												endOf : endOf,
												isSupervisor: isSupervisor,
												isApprover: isApprover,
												session: session,
												complete_shift : complete_shift,
												number_of_records: $env.parsed.NUMBER_OF_RECORDS,
												pending_leaves: pending_leaves,
												pending_overtime: pending_overtime,
												pending_undertime: pending_undertime,
												pending_business_trip:pending_business_trip,
												pending_dispute: pending_dispute,
												pending_change_shift: pending_change_shift,
												pending_change_logs: pending_change_log,
												log_data: log_data,
											});
										});
									});
								});
							});
						});
					});
				});
			});
		});
	});
}

const isUserApprover =  async (userId)=>{
	let results = false;
	
	let queryFilter = {}
	queryFilter[Op.or] = [
		{
			primary_approver: userId
		},
		{
			backup_approver: userId
		}
	];

		await LeavesModel.findAll({
		where: queryFilter,
	}).then(async function(data){
		leaves = data;
		if(leaves && leaves.length){
			results = true;
			return results;
		} else {
			await OvertimesModel.findAll({
				where: queryFilter,
			}).then(async function(data){
				overtime = data;
				if(overtime && overtime.length){
					results = true;
					return results;
				} else {
					await UndertimeModel.findAll({
						where: queryFilter,
					}).then(async function(data){
						undertime = data;
						if(undertime && undertime.length){
							results = true;
							return results;
						} else {
							await BusinessTripsModel.findAll({
								where: queryFilter,
							}).then(async function(data){
								business_trip = data;
								if(business_trip && business_trip.length){
									results = true;
									return results;
								} else {
									await DisputeModel.findAll({
									where: queryFilter,
								}).then(async function(data){
									disputes = data;
									if(disputes && disputes.length){
										results = true;
										return results;
									} else {
										await ShiftsModel.findAll({
											where: queryFilter,
										}).then(async function(data){
											shifts = data;
											if(shifts && shifts.length){
												results = true;
												return results;
											} else {
												await ChangeLogModel.findAll({
													where: queryFilter,
												}).then(async function(data){
													change_log = data;
													if(business_trip && business_trip.length){
														results = true;
														return results;
													}
												});
											}
										});
									}
								});
								}
							});
						}
					});
				}
			});
		}
	});
	
	return results
}

exports.fetch_holiday = function(req, res){
	let user = res.locals.user;
	let event_user_id = req.body.user_id ? req.body.user_id : user.id;
	let date = req.body.date;
	let startOf = res.locals.moment(date).startOf('month').format('YYYY-MM-DD HH:mm:ss');
	let endOf   = res.locals.moment(date).endOf('month').format('YYYY-MM-DD HH:mm:ss');
	
	HolidaysModel.findAll({
		where: {
			status: 1,
			date: {
				$between: [startOf, endOf]
			}
		},
		attributes: ['date', 'title','type']
	}).then(function(data){
		holidays = data;
		return EventModel.findAll({
			where: {
				user_id: event_user_id,
				$or: [
					{
						date: {
							$between: [startOf, endOf]
						}
					},
					{
						end_date: {
							$between: [startOf, endOf]
						}
					}
				]
			},
			raw: true
		});
	}).then(function(data){
		events = data;
		return LeavesModel.findAll({
			where: {
				user_id: event_user_id,
				primary_status: 2,
				$or: [
					{
						start_date: {
							$between: [startOf, endOf]
						}
					},
					{
						end_date: {
							$between: [startOf, endOf]
						}
					}
				]
				
			},
			include: [
				{
					model: LeavePolicyModel,
					attributes: ['name']
				}
			],
			raw: false,
			logging: false
		});
	}).then(function(data){
		leave = data;
		return BusinessTripsModel.findAll({
			where: {
				user_id: event_user_id,
				primary_status: 2,
				$or: [
					{
						date_start: {
							$between: [startOf, endOf]
						}
					},
					{
						date_end: {
							$between: [startOf, endOf]
						}
					}
				]
				
			},
		});
		
	}).then(function(data){
		business = data;
		res.status(200).json({
			success: true,
			holidays: holidays,
			events: events,
			leave: leave,
			business: business
		});
	});
}

exports.setLog = function(req, res){
	let user = res.locals.user;
	let user_id = user.id;
	let type = req.body.event;
	let now = res.locals.moment();
	
	let	date = now.format('YYYY-MM-DD');
	let time = now.format('HH:mm:ss');

	let tempData = {
		user_id: user.id,
		date: date,
		time: time,
		type: type
	}
	TempInOutModel.findOne({
		where: {
			user_id: user_id,
			date: date,
			type: type
		}
	}).then(function(data){
		temp = data;
		if(temp){
			TempInOutModel.update(tempData,{
				where: {
					id: temp.id
				}
			});
		}else{
			TempInOutModel.create(tempData);
		}

		//
		ShiftsModel.findOne({
			where: {
				user_id: user_id,
				date: date
			},
			attributes: ['id', 'type', 'date', 'check_in', 'check_out', 'actual_check_in','actual_check_out']
		}).then(function(shift){
			if(shift){
				let shift_id = shift.id;
				if(shift.type == 1 || shift.type == 3){
					if(shift.check_out > shift.check_in){
						if((type == 'timein')) {
							if(!shift.actual_check_in){
								if(time < shift.check_out){
									updateLogin(time, shift_id);
								}else{
									updateLogout(time, shift_id);
								}
							}
						}
						if(type == 'timeout'){
							updateLogout(time, shift_id);
						}
					}
				}else{
					let dbDate = new Date(shift.date +' '+ shift.check_in);
					let csvDate = new Date(now);
					
					//Checkin
					if(type == 'timein'){
						if(!shift.actual_check_in){
							if(csvDate < dbDate){
								if(res.locals.moment(csvDate).format('HH:mm:ss') <= shift.check_out){//previous
									var startdate = res.locals.moment(csvDate);
										startdate = startdate.subtract(1, "days");
										startdate = startdate.format('YYYY-MM-DD');
									//console.log(moment(startdate).format('YYYY-MM-DD HH:mm:ss'));
									ShiftsModel.findOne({
										where: {
											user_id: user_id,
											date: startdate
										},
										attributes: ['id','date','check_in','check_out','actual_check_in']
									}).then(function(data){
										shft = data;
										if(shft && shft.check_in != shft.check_out){
											updateLogin(time, shft.id);
										}
									});
								}else{//current
									updateLogin(time, shift_id);
								}
							}else{
								updateLogin(time, shift_id);
							}
						}
					}else if(type == 'timeout'){//Check OUT
						let nDate = new Date(date);
							nDate = res.locals.moment(nDate);
							nDate = nDate.subtract(1, 'days');
							nDate = nDate.format('YYYY-MM-DD');
						//console.log(nDate);
						ShiftsModel.findOne({
							where: {
								user_id: user_id,
								date: nDate
							},
							attributes: ['id', 'type', 'date', 'check_in', 'check_out', 'actual_check_in','actual_check_out']
						}).then(function(shft){
							if(shft){
								let dbDate = new Date(shft.date +' '+ shft.check_out);
									dbDate = res.locals.moment(dbDate);
									dbDate = dbDate.add(1, 'days');
									dbDate = dbDate.format('YYYY-MM-DD HH:mm:ss');
								if(new Date(nDate +' '+ time) > new Date(shft.date +' '+shft.check_out) && new Date(nDate +' '+ time) < new Date(shft.date +' '+shft.check_in)){
									updateLogout(time, shft.id);
								}else{
									ShiftsModel.findOne({
										where: {
											user_id: user_id,
											date: date
										},
										attributes: ['id', 'type', 'date', 'check_in', 'check_out', 'actual_check_in','actual_check_out']
									}).then(function(data){
										if(data){
											updateLogout(time, data.id);
										}
									});
								}
							}
						});
					}
				}
			}else{
				date = new Date(date);
				date = res.locals.moment(date);
				date = date.subtract(1, 'days');
				date = date.format('YYYY-MM-DD');
				ShiftsModel.findOne({
					where: {
						user_id: user_id,
						date: date
					},
					attributes: ['id', 'type', 'date', 'check_in', 'check_out', 'actual_check_in','actual_check_out']
				}).then(function(shft){
					if(shft){
						if(shft.type == 1 && shft.check_in > shft.check_out && type == 'timeout'){
							updateLogout(time, shft.id);
						}
					}
				});
			}
			res.status(201).json({
				success: true
			});
		});
	});
}
exports.log_issue_monitoring = function(req,res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		user_role = data;
		res.render('home/log-issue-monitoring',{
			usrRole: user_role,
		});
	});
}
exports.team_logs = function(req,res){
	let user = res.locals.user;
	UserRole.allRead(user).then(function(data){
		user_role = data;
		res.render('home/team-logs',{
			usrRole: user_role,
		});
	});
}

const updateLogin = function(time, id){
	let reqData = {
		actual_check_in: time
	}
	ShiftsModel.findOne({
		where: {
			id: id
		}
	}).then(function(data){
		if(!data.actual_check_in){
			ShiftsModel.update(reqData, {
				where: {
					id: id
				}
			});
		}
	});
	
}

const updateLogout = function(time, id){
	let reqData = {
		actual_check_out: time
	}
	ShiftsModel.update(reqData, {
		where: {
			id: id
		}
	});
}

