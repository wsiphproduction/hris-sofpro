const moment     	= require('moment-timezone');
const $env 	= require('dotenv').config();
const TSSHelper = require('../Helper/TSSHelper');
const { 
	Op,
	UsersModel,
	ShiftsModel,
	TSSData,
	OvertimesModel
} = require('../../config/Sequelize');

exports.process = function(){
	console.log("Re-Proccessing of DTR")
	let start_date = $env.parsed.DTS_START_DATE;
	let end_date = $env.parsed.DTS_DATE_DIFF;
    
	console.log(start_date + ' --- ' + end_date);
	
    let whereUser = {}

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

                if(arrFilter.length > 0) {
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
            for(i in rows){
                let tss = rows[i].tss
                for(i in tss) {
                    let target_date = tss[i].date
                    let user_id = tss[i].user_id

                    if(tss[i].RegHrs <= 0 || tss[i].RegHrs == null) {
                        if(tss[i].shift) {
                            if(tss[i].shift.actual_check_in || tss[i].shift.actual_check_out) {
                                TSSHelper.process(target_date, user_id);
                            }
                        }
                    }
                }
            }
        }

    });
}

exports.process2 = function(){
	console.log("Re-Proccessing2 of DTR")
	let start_date = $env.parsed.DTS_START_DATE;
	let end_date = $env.parsed.DTS_DATE_DIFF;
    
	console.log(start_date + ' --- ' + end_date);

    let whereTSS = {
        date: {
            $between: [start_date, end_date]
        },
        RegHrs: {
            [Op.or] : {
                [Op.lte]: 0,
                [Op.eq]: null
            }
        }
    };

    TSSData.findAll({
        where: whereTSS,
        include: [
            {
                model: ShiftsModel,
                as: 'shift'
            }
        ],
    }).then(function(data){
        tsses = data;

        if(tsses && tsses.length){
            console.log('Query result size: ', tsses.length);
            for(let i in tsses){
                let shifts = tsses[i].shift;
                if (shifts && shifts.length){
                    TSSHelper.process(shifts[0].date, shifts[0].user_id);
                }
            }
        }
    });
}

exports.process3 = function(){
	console.log("Re-Proccessing of DTR3")
	let start_date = $env.parsed.DTS_START_DATE;
	let end_date = $env.parsed.DTS_DATE_DIFF;
    
	console.log(start_date + ' --- ' + end_date);
	
    let whereUser = {}

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
        order: [
            ['last_name','asc']
        ],
    }).then(function(data){
        shifts = data.rows;

        let rows = [];
        let user_ids = [];
        let process_date = start_date;
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

                if(arrFilter.length > 0) {
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
            for(i in rows){
                let tss = rows[i].tss
                for(i in tss) {
                    let target_date = tss[i].date
                    let user_id = tss[i].user_id

                    if(tss[i].RegHrs <= 0 || tss[i].RegHrs == null) {
                        if(tss[i].shift) {
                            if(tss[i].shift.actual_check_in || tss[i].shift.actual_check_out) {
                                user_ids.push(user_id);
                            }
                        }
                    }
                }
            }
            if (user_ids && user_ids.length){
                TSSHelper.process2(process_date, user_ids);
            }
            
        }

    });
}

exports.process4 = function(process_date){
	console.log("Re-Proccessing of DTR4")
	let start_date = process_date;
	let end_date = process_date;
    
	console.log(start_date + ' --- ' + end_date);
	
    let whereUser = {}

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
        order: [
            ['last_name','asc']
        ],
    }).then(function(data){
        shifts = data.rows;

        let rows = [];
        let user_ids = [];
        let process_date = start_date;
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

                if(arrFilter.length > 0) {
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
            for(i in rows){
                let tss = rows[i].tss
                for(i in tss) {
                    let target_date = tss[i].date
                    let user_id = tss[i].user_id

                    if(tss[i].RegHrs <= 0 || tss[i].RegHrs == null) {
                        if(tss[i].shift) {
                            if(tss[i].shift.actual_check_in || tss[i].shift.actual_check_out) {
                                user_ids.push(user_id);
                            }
                        }
                    }
                }
            }
            if (user_ids && user_ids.length){
                TSSHelper.process(process_date, user_ids);
            }
            
        }

    });
}