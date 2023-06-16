<script>
    
    module.exports = {
        
        data: function(){

            return{
                records: [],
                fetching: false,
                tooltip: null,
                dataSource: [],
                style: 'custom'
            }
        },

        components: {
            'yearcalendar': YearCalendar
        },

        computed: {
        },

        watch:{
        },

        mounted(){
            
        },

        methods: {
            yearChanged(e){
                this.fetchRecord(e.currentYear);
                
            },

            mouseOnDay(e) {
              if (e.events.length > 0) {
                var content = '';
                for (var i in e.events) {
                    content += `
                        <div class="event-tooltip-content">
                            <div class="event-name small strong">` + e.events[i].name + `</div>
                            <div class="small">`+ e.events[i].time +`</div>
                        </div>
                    `;
                }

                $(e.element).popover({
                    placement: 'top',
                    trigger: 'manual',
                    container: 'body',
                    html: true,
                    content: content
                });
                
                $(e.element).popover('show');
              }
            },

            mouseOutDay(e) {
                if(e.events.length > 0) {
                    $(e.element).popover('hide');
                }
            },

            fetchRecord(year){
                let REST = new URL(window.location.href);
                    REST = REST.href;
                axios.post(REST, {year:year}).then(response => {
                    let record = response.data.record;
                    let dataSource = [];
                    if(record.length){
                        for(let x in record){
                            let year = moment(record[x].date).format('YYYY');
                            let month = moment(record[x].date).format('M');
                                month = month - 1;
                            let day = moment(record[x].date).format('D');
                            let time = '';
                            time = moment(record[x].check_in).utc().format('hh:mmA') +'—'+ moment(record[x].check_out).utc().format('hh:mmA');
                            dataSource.push({
                                id: x,
                                name: moment(record[x].date).format('LL'),
                                time: time,
                                color: '#ff0000',
                                startDate: new Date(year, month, day),
                                endDate: new Date(year, month, day),
                            });
                        }
                    }

                    this.dataSource = dataSource;
                    //console.log(record);
                    setTimeout(function(){$('td[style^="box-shadow"]').addClass('shift').css('box-shadow','')}, 100);
//                     dataSource
// {
//                       id: 0,
//                       name: 'Google I/O',
//                       location: 'San Francisco, CA',
//                       startDate: new Date(2019, 4, 28),
//                       endDate: new Date(2019, 4, 29)
//                     }
                });
            },
        }
    }

</script>