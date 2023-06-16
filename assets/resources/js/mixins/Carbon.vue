<script>
	module.exports = {
	    methods: {	    	
	    	difference(date){
	    		let str = '';
				let nDate 	 = new Date(date);
				let second	 = moment(nDate).startOf('second').fromNow();
				let minute	 = moment(nDate).startOf('minute').fromNow();
				let hour	 = moment(nDate).startOf('hour').fromNow();
				let day	 	 = moment(nDate).startOf('day').fromNow();
				let week	 = moment(nDate).startOf('week').fromNow();
				let month	 = moment(nDate).startOf('month').fromNow();
				let year	 = moment(nDate).startOf('year').fromNow();
				if(second <= 1){
					str = second + ' second ago.';
				}else if(second >= 2 && second <= 59){
					str = second + ' seconds ago.';
				}else if(minute <= 1){
					str = minute + ' minute ago.';
				}else if(minute >= 2 && minute <= 59){
					str = minute + ' minutes ago.';
				}else if(hour <= 1){
					str = hour + ' hour ago.';
				}else if(hour >= 2 && hour <= 23){
					str = hour + ' hours ago.';
				}else if(day <= 1){
					str = day + ' day ago.';
				}else{
					str = moment(nDate).format('MM/DD/YYYY hh:mm:A');
				}

				return str;
			},
	    }
	}
</script>