var path = require('path');

function Attendance(){

	this.actualTime = function(date, time, label = null){
		let current = moment();
		let newDate = moment(new Date(date));
		let string = '--';
		if(newDate <= current){
			if(time){
				time = moment(new Date(time)).utc().format('HH:mm');
				string = moment(new Date(date +' '+ time)).format('h:mmA');
			}else{
				string = '??';
			}
		} else {
			if(label == 'shift-in' || label == 'shift-out') {
				string = " "
			}
		}
		
		return string;
	}
}

module.exports = new Attendance();