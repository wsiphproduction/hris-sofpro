<template>
	<FullCalendar class="demo-app-calendar" ref="fullCalendar" defaultView="dayGridMonth" :header="header" :plugins="calendarPlugins" :weekends="calendarWeekends" :events="events" @event-render="eventRender"></FullCalendar>
</template>

<script>

	import FullCalendar from '@fullcalendar/vue'
	import dayGridPlugin from '@fullcalendar/daygrid'

	export default {
		
		components: {
			FullCalendar
		},

		data(){
			return {
				calendarWeekends: true,
			  	calendarPlugins: [ dayGridPlugin ],
			  	events: [
			  		{ title: '<span>Hi</span>event 1', date: '2019-05-01', className: 'sample_class' },
    				{ title: 'event 2', date: '2019-05-02' }
			  	],
			  	header: {
					left: 'prev,next today',
					center: 'title',
					right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
				},
				textEscape: false,
				eventRender: function(event, $el, element){
					$(element).popover({
					html: true,
					container: '.fc-scroller',
					placement: 'auto right',
					title: event.title,
					content: 'Start: ' + event.start + '<br />End: ' + event.end
				    });
				}
			}
		},

		method:{
			eventRender(event, $el, element){
				alert();
			}
		}
	}

</script>