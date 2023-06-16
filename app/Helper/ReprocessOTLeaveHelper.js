const moment     	= require('moment-timezone');
const $env 	        = require('dotenv').config();
const TSSHelper     = require('./TSSHelper');
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


exports.reprocess_leaves = function(shift_ids){
    console.log("REPROCESSING LEAVES");
    // UPDATE TSS_DATA OR DTR
    let reqData = {
        Leave01: null,
        Leave02: null,
        Leave03: null,
        Leave04: null,
        Leave05: null,
        Leave06: null,
        Leave07: null,
        Leave08: null,
        Leave09: null,
        Leave10: null,
        Leave11: null,
        Leave12: null,
        Leave13: null,
        Leave14: null,
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
            shift_id:{[Op.in]:shift_ids}
        }
    }).then((data)=>{
        ShiftsModel.findAll({
            where:{
                id :{[Op.in]:shift_ids}
            }
        }).then((data)=>{
            let shift_data = data;
        
            for(i in shift_data){
                TSSHelper.absent(shift_data[i]);
            }
        });
    });
}

exports.reprocess_ot = function(shift_ids){
    console.log("REPROCESSING OT");
    // UPDATE TSS_DATA OR DTR
    let reqData = {
        Leave01: null,
        Leave02: null,
        Leave03: null,
        Leave04: null,
        Leave05: null,
        Leave06: null,
        Leave07: null,
        Leave08: null,
        Leave09: null,
        Leave10: null,
        Leave11: null,
        Leave12: null,
        Leave13: null,
        Leave14: null,
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
            shift_id:{[Op.in]:shift_ids}
        }
    }).then((data)=>{
        ShiftsModel.findAll({
        	where: {
                id: { [Op.in]: shift_ids }
        	},
        	include: [
        		{
        			model: OvertimesModel,
        			as: 'ot'
        		},
        		{
        			model: ShiftType,
        			as: 'type_of_shift',
        			attributes: ['is_from_previous']
        		}
        	],
        	raw: false
        }).then((data)=>{
            let shift_data = data;

            for (i in shift_data) {
                TSSHelper.set_overtime(shift_data[i]);
            }
        });
    });
}