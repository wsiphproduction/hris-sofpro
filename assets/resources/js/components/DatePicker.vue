<template>
	<input type="text">
</template>

<script>

	export default {
		mounted() {
			this.datePicker();
		},

		beforeDestroy: function() {
			$(this.$el).datepicker('hide').datepicker('destroy');
		},

		methods:{
			datePicker(){
				var self = this;
				$(this.$el).datepicker({
					language: 'en',
					onSelect: function(date) {
						self.$emit('update-date', date);
					},

					onRenderCell: function(date, cellType){
						let getDate = date.getDate();
						let currentDate = moment(date).format('YYYY-MM-DD');
						if(cellType == 'day' && (events && events.indexOf(currentDate) != -1)) {
				            return {
				                html: '<div class="dp-event">'+ getDate +'<span class="dp-note">●</span></div>'
				            }
				        }
					}

				});
			}
		}
	}

</script>