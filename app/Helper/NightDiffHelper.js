const $env 	= require('dotenv').config();
const moment= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);

function NightDiffHelper(){

	this.init = function(start_date=null, end_date=null){
		let start_work = start_date;
		let end_work = end_date;

		let start_work_time = moment(start_work).format('HH:mm:ss');
		let end_work_time = moment(end_work).format('HH:mm:ss');
		let start_night = '22:00:00';
		let end_night = '06:00:00';
		let start = null;
		let end = null;
		let result = 0;
		
		if((start_work && end_work) && (Date.parse(start_work) < Date.parse(end_work))){
			if(start_work_time >= end_night && start_work_time < start_night){
				if(!(end_work_time >= end_night && end_work_time < start_night)){
					start = start_work;
					start = moment(start).format('YYYY-MM-DD')+' 22:00:00';
					// start.setHours(22);
					// start.setMinutes(00);
					// start.setSeconds(00);
					end   = end_work;
				}else{
					let checkStart = moment(start_work).format('YYYY-MM-DD');
					let checkEnd = moment(end_work).format('YYYY-MM-DD');
					if(checkStart != checkEnd){
						let diffStart = moment(checkStart);
						let diffEnd = moment(checkEnd);
						let duration = moment.duration(diffEnd.diff(diffStart));
							duration = duration.asDays();
						if(duration == 1){
							start = start_work;
							start = moment(start).format('YYYY-MM-DD')+' 22:00:00';
							// start.setHours(22);
							// start.setMinutes(00);
							// start.setSeconds(00);

							end   = end_work;
							end = moment(end).format('YYYY-MM-DD')+' 06:00:00';
							// end.setHours(06);
							// end.setMinutes(00);
							// end.setSeconds(00);
						}
					}
				}
				if(start && end){
					start = moment(start);
					end   = moment(end);
					let duration = moment.duration(end.diff(start));
					result = duration.asHours();
					result = result > 0 ? result : 0;
				}
			}else{
				start = start_work;
				end   = end_work;
				
				if(end_work_time >= end_night && end_work_time < start_night){
					end = moment(end).format('YYYY-MM-DD')+' 06:00:00';
					// end.setHours(06);
					// end.setMinutes(00);
					// end.setSeconds(00);
				}
				start = moment(start);
				end   = moment(end);
				let duration = moment.duration(end.diff(start));
				result = duration.asHours();
				// console.log(result);
				result = result > 0 ? result : 0;
				if(start_work_time < end_night && end_work_time > start_night){
					result = result - 16;
				}
			}

			
		}
		result = parseInt(result) > 16 ? (parseInt(result) - 16) : result;
		return result;
	}

}

module.exports = new NightDiffHelper();