function DateHelper(){

	this._set = function(date){
		let newDate = new Date(date);
		let m = ("0" + (newDate.getMonth() + 1)).slice(-2);
		let d = ("0" + newDate.getDate()).slice(-2);
		let y = newDate.getFullYear();
		let concat = y +'-'+ m +'-'+ d;
		return concat;
	}

	this.datetime = function(date){
		let newDate = new Date(date);
		let m = ("0" + (newDate.getMonth() + 1)).slice(-2);
		let d = ("0" + newDate.getDate()).slice(-2);
		let y = newDate.getFullYear();
		let hr = ("0" + newDate.getHours()).slice(-2);
		let min = ("0" + newDate.getMinutes()).slice(-2);
		let sec = ("0" + newDate.getSeconds()).slice(-2);
		let concat = y +'-'+ m +'-'+ d +' '+ hr +':'+ min +':'+sec;
		return concat;
	}

	this.date = function(date){
		let newDate = new Date(date);
		let m = ("0" + (newDate.getMonth() + 1)).slice(-2);
		let d = ("0" + newDate.getDate()).slice(-2);
		let y = newDate.getFullYear();
		let concat = y +'-'+ m +'-'+ d;
		return concat;
	}

	this.time = function(date){
		let newDate = new Date(date);
		let hr = ("0" + newDate.getHours()).slice(-2);
		let min = ("0" + newDate.getMinutes()).slice(-2);
		let sec = ("0" + newDate.getSeconds()).slice(-2);
		let concat = hr +':'+ min +':'+sec;
		return concat;
	}

	this.dateArray = function(start, end){
		let arr = new Array();
	    let dt = new Date(start);
	    while (dt <= new Date(end)) {
	        arr.push(new Date(dt));
	        dt.setDate(dt.getDate() + 1);
	    }
	    return arr;
	}

}

module.exports = new DateHelper();