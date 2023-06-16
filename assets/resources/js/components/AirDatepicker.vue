<template>
	<input type="text" class="form-control">
</template>

<script>

	export default {

		data: function(){
			return {
				balance: 30
			}
		},
		mounted() {
			this.datePicker();
		},

		beforeDestroy: function() {
			
		},
		
		computed:{
			fcredit(){
                return this.$parent.form.leave_type;
            },
            clearDate(){
                return this.$parent.form.dates;
            },
		},
		
		watch:{
			fcredit(){
				this.balance = this.$parent.balance;
				this.$parent.form.dates = "";
				this.datePicker();
			},
			clearDate(){
				this.datePicker();
			}
		},

		methods:{
			datePicker(){
				var disabledDates = this.$parent.disabledDate;
				var self = this;
				let parent = this.$parent; 
                let dates = parent.form.dates;
                let balance = this.balance;

                let xDate = [];
                let currDate = this.$parent.currentDate;
                if(typeof currDate != 'undefined' && currDate.length){
                	let date1 = disabledDates;
                	let dateArr = currDate.split(',');
                	let date2 = [];
                	for(let x in dateArr){
                		date2.push(moment(new Date(dateArr[x])).format('YYYY.M.D'));
                	}
                	// console.log(date2);
                	xDate = date1.filter( function( el ) {
					  return date2.indexOf( el ) < 0;
					} );
                }else{
                	xDate = disabledDates;
                }
                // console.log(xDate);
                let picker = $(this.$el).datepicker({
                	language:'en',
                	multipleDates: balance <= 0 || parent.form.credit == 2 ? 30 : balance,
                	multipleDatesSeparator: ',',
                    onSelect: function(date){
                        self.$emit('update-date', date);
                    },
                    onRenderCell: function(d, type) {
				    	if (type == 'day') {
							var disabled = false,
				      		formatted = moment(d).format('YYYY.M.D');// this.getFormattedDate(d);
				          	
				          	disabled = xDate.filter(function(date){
				          		return date == formatted;
				          	}).length;
				      
							return {
				          		disabled: disabled
				          	}
				    	}
				    }
                }).data('datepicker');
                if(dates != '' && typeof dates != 'undefined'){
                	
                	let dateArray = dates.split(',');
                	let newDate = [];
                	for(let x in dateArray){
                		newDate.push(new Date(dateArray[x]));
                	}
                	picker.selectDate(newDate);
                }else{
                	picker.clear();
                }   
			}
		}
	}

</script>