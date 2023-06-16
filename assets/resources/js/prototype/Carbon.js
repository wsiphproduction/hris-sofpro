'use strict';

module.exports = Carbon;

function Carbon(date){
	let setDate = moment(date).utc().format('YYYY-MM-DD HH:mm:ss');
	let str = '';
	let nDate 	 = new Date(setDate);
	let now      = moment();
	let second	 = moment(nDate).startOf('second').fromNow();
	let minute	 = moment(nDate).startOf('minute').fromNow();
	//let hour	 = moment(nDate).startOf('hour').fromNow();
	//let day	 	 = moment(nDate).startOf('day').fromNow();
	//let week	 = moment(nDate).startOf('week').fromNow();
	//let month	 = moment(nDate).startOf('month').fromNow();
	//let year	 = moment(nDate).startOf('year').fromNow();
	var start 	 = moment(nDate);
	let dayDiff  = moment().diff(start, 'days');

	if(dayDiff <= 7){
		str = second;
	}else{
		str = moment(nDate).format('ll');
	}

	return str;
}