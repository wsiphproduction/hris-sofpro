const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);

function ShiftAllocationHelper(){

	this.setRecord = function(record, startOf, json){
		let records = [];
	    let endDay = moment(startOf).daysInMonth();
	    let year = moment(startOf).format('YYYY');
	    let month = moment(startOf).format('MM');
	    if(record.length){
	        for(let k in record){
	            //console.log(record[k].shifts);
	            let schedule = [];
	            for(let day = 0; day < endDay; day ++){
	                let newDay = day + 1;
	                let date = year +'-'+ month +'-'+ newDay;
	                    date = new Date(date);
	                    date = moment(date).format('YYYY-MM-DD');
	                let getDate = this.getDate(record[k].shifts, date, json);
	                schedule.push({
	                    bg: getDate.bgColor,
	                    time: getDate.time,
	                });
	            }

	            records.push({
	                shortid: record[k].shortid,
	                first_name: record[k].first_name,
	                last_name: record[k].last_name,
	                schedule: schedule
	            });
	        }
	    }
	    return records;
	}

	this.getDate = function(shifts, date, json){
	    let obj = shifts.find( o => o.date == date);
	    let data = {
	        time: '',
	        bgColor: ''
	    }
	    if(obj){
	        if(obj.type == 1){
	            data.time = moment(obj.date +' '+ obj.check_in).format('h:mA') +'-'+ moment(obj.date +' '+ obj.check_out).format('h:mA');
	        }else if(obj.type == 2){
	            data.time = 'Flexible';
	        }else if(obj.type == 3){
	            data.time = moment(obj.date +' '+ obj.between_start).format('h:mA') +'-'+ moment(obj.date +' '+ obj.between_end).format('h:mA');
	        }
	        data.bgColor = this.setBackground(obj, json);
	    }
	    return data;
	}

	this.setBackground = function(object, json){
	    let config = json;
	    let grace_period = config.shift && config.shift.grace_period ? config.shift.grace_period + 1 : 0;	// Consider seconds after the grace period minute
	    let currentDate = moment().format('YYYY-MM-DD');
	    let bgColor = '';
	    if(object.date < currentDate){
	        if(!object.actual_check_in && !object.actual_check_out){
	            bgColor = 'bg-absent';
	        }else if((!object.actual_check_in && object.actual_check_out) || (object.actual_check_in && !object.actual_check_out)){
	            bgColor = 'bg-tardy';
	        }else if(object.actual_check_in && object.actual_check_out){
	            //Actual Log based on biometric
	            let actualIn = new Date(object.date +' '+ object.actual_check_in);
	                actualIn = moment(actualIn).format('YYYY-MM-DD HH:mm:ss');
	            let actualOut = new Date(object.date +' '+ object.actual_check_out);
	                actualOut = moment(actualOut).format('YYYY-MM-DD HH:mm:ss');
	            if(object.type == 1){
	                //Login based on shift plus grace period
	                let shiftIn = new Date(object.date +' '+ object.check_in);
	                    shiftIn = moment(shiftIn).add(grace_period, 'minutes').format('YYYY-MM-DD HH:mm:ss');
	                let shiftOut = new Date(object.date +' '+ object.check_out);
	                    shiftOut = moment(shiftOut).format('YYYY-MM-DD HH:mm:ss');
	                
	                if((actualIn > shiftIn) || (actualOut < shiftOut)){
	                    bgColor = 'bg-tardy';
	                }else{
	                    bgColor = 'bg-perfect';
	                }
	            }else if(object.type == 2){
	                let shiftLength = parseInt(object.shift_length);
	                    shiftLength = shiftLength * 60;
	                let now = moment(actualIn);
	                var end = moment(actualOut);
	                var minutes = end.diff(now, 'minutes');
	                if(minutes >= shiftLength){
	                    bgColor = 'bg-perfect';
	                }else{
	                    bgColor = 'bg-tardy';
	                }
	            }else if(object.type == 3){
	                let shiftLength = parseInt(object.shift_length);
	                    shiftLength = shiftLength * 60;
	                //Login based on shift between time ex: 8AM and 10AM
	                let shiftInStart = new Date(object.date +' '+ object.between_start);
	                    shiftInStart = moment(shiftInStart).format('YYYY-MM-DD HH:mm:ss');
	                let shiftInEnd = new Date(object.date +' '+ object.between_end);
	                    shiftInEnd = moment(shiftInEnd).format('YYYY-MM-DD HH:mm:ss');

	                if(actualIn <= shiftInEnd){//OK but check number of hours
	                    //check shift length
	                    let now = (actualIn >= shiftInStart && actualIn <= shiftInEnd) ? moment(actualIn) : moment(shiftInStart);
	                    var end = moment(actualOut);
	                    var minutes = end.diff(now, 'minutes');
	                    if(minutes >= shiftLength){
	                        bgColor = 'bg-perfect';
	                    }else{
	                        bgColor = 'bg-tardy';
	                    }                           
	                }else{
	                    bgColor = 'bg-tardy';
	                }
	            }
	        }
	    }
	    return bgColor;
	}

}

module.exports = new ShiftAllocationHelper();