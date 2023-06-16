const moment = require('moment');
const $env 	= require('dotenv').config();
const _ = require('underscore');

const {
	Op,
	CronJobModel
} = require('../../config/Sequelize');

function CronJobHelper(){
    this.create = async (date)=>{
        let id = null
        let now = moment().format('YYYY-MM-DD hh:MM:ss');
        
        DATE_DIFF = $env.parsed.DATE_DIFF ? $env.parsed.DATE_DIFF : 5;
        START_DATE = moment().subtract(DATE_DIFF,'days').format('YYYY-MM-DD');
       
        let reqData = {
            datetime_initiated: now,
            target_date: START_DATE,
            status: 4
        }
        await CronJobModel.create(reqData).then(async function(data){
			id = data.id;
            console.log("ID: ", id)
        });
        
        return id;
	}

	this.update = function(id, status){
        let reqData = {
			status: status
		}
		CronJobModel.update(reqData,{
			where: {
				id: id
			}
		});
    }

    this.update_processing_to_failed = function(){
        
        let reqData = {
			status: 2
		}
		
        CronJobModel.findAll({
            where: {
                status: 4
            }
        }).then(function(data){
            cron_job_data = data;
            if(cron_job_data && cron_job_data.length){
                let where_cron_job = {}
                let results = _.pluck(cron_job_data, 'id');
                results = [...new Set(results)];

                where_cron_job.id = {
                        [Op.in]: results
                }
                CronJobModel.update(reqData,{
                    where: where_cron_job
                });
            }
        });
    }

}

module.exports = new CronJobHelper();