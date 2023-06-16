<script>
    let Cover = require('./Cover.vue');
    module.exports = {
        data: function(){
            return{
                events: [],
                date: null,
            }
        },
        mixins: [
            Form,
            Alert,
            Cover
        ],
        methods: {
            initCalendar(date){
                this.date = moment(date).format('YYYY-MM-DD');
                this.fetch();
            },

            eventClick(event, jsEvent, pos) {
                //console.log(event);
            },

            fetch(){
                let API = window.location.origin + window.location.pathname;
                let data = {
                    date: this.date
                }
                axios.post(API, data).then(response => {
                    let events = [];
                    let record = response.data.records;
                    if(record.length){
                        for(let x in record){
                            let bg = '';
                            let start = moment(record[x]['date']).format('YYYY-MM-DD');
                            let title = '';

                            if(record[x]['type'] == 1){
                                let bDate = moment(record[x]['date'] +' '+ record[x]['check_in']).format('hh:mmA') +'-'+ moment(record[x]['date'] +' '+ record[x]['check_out']).format('hh:mmA');
                                title = bDate;
                            }else if(record[x]['type']==2){
                                title = 'Flexible';
                            }else if(record[x]['type']==3){
                                let bDate = moment(record[x]['date'] +' '+ record[x]['between_start']).format('hh:mmA') +'-'+ moment(record[x]['date'] +' '+ record[x]['between_end']).format('hh:mmA');
                                title = bDate;
                            }

                            if(record[x]['primary_status'] == 1){
                                bg = 'bg-primary-light';
                            }else if(record[x]['primary_status'] == 2){
                                bg = 'bg-success-light';
                            }else if(record[x]['primary_status'] == 3){
                                bg = 'bg-warning-light';
                            }else if(record[x]['primary_status'] == 4){
                                bg = 'bg-dark';
                            }
                            events.push({
                                //tid: record[x],
                                title: title,
                                start: start,
                                cssClass: bg+ ' text-white',
                                textEscape: false
                            });
                        }
                    }
                    this.events = events;
                });
            }
        }
    }
</script>