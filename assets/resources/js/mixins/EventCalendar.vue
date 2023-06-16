<script>
    module.exports = {
        data: function(){
            return{
                showCalendar: false,
                activeCalId: null,
                style: '',
            }
        },

        methods: {
            closeCalendar(){
                this.showCalendar = false;
            },

            showEvent(id, dates, event, infinite = null){
                let eY = parseInt(event.pageY) - 15;
                let eX = parseInt(event.pageX) + 15;
                let style = 'top:'+eY+'px; left: '+eX+'px';
                this.style = style;
                
                this.picker(id, dates, infinite);
            },
            
            picker(id, dates, infinite){
                
                if(this.activeCalId != id){
                    this.showCalendar = true;
                }else{
                    this.showCalendar = !this.showCalendar;
                }
                
                this.activeCalId = id;
                let events = [];

                let defaultDate = new Date();
                if(dates){
                    if(infinite){
                        let date = dates.split(',');
                        
                        let start = date[0];
                        let end = new Date(date[1]);

                        let arr = new Array();
                        let dt = new Date(start);
                        while (dt <= end) {
                            arr.push(new Date(dt));
                            dt.setDate(dt.getDate() + 1);
                        }
                        defaultDate = new Date(arr[0]);
                        for(let x in arr){
                            let newDate = moment(arr[x]).format('YYYY-MM-DD');
                            events.push(newDate);
                        }
                    }else{
                        let date = dates.split(',');
                        defaultDate = new Date(date[0]);
                        for(let x in date){
                            let newDate = new Date(date[x]);
                                newDate = moment(newDate).format('YYYY-MM-DD');
                            events.push(newDate);
                        }
                    }
                    
                }

                $(".calendarPicker").datepicker({
                    language: 'en',
                    startDate: defaultDate,
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
            },

            dateRange(date){
                let data = '—';
                if(date != null){
                    let array = date.split(',');
                    let cnt = array.length - 1;
                    let first = array[0] ? array[0] : '';
                    let last = array[cnt] ? array[cnt] : '';
                    if(array.length <= 1){
                        data = first;
                    }else{
                        data = first +'—'+ last;
                    }
                }
                return data;
            }
        }
    }
</script>