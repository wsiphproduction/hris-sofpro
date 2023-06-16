<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Create New',
                form:{},
                previewModal: false,
                events: [],
                date: null,
                errors: {},
                method: 'post',
                candidate: [],
                current: null,
                fetching: true
            }
        },

        mixins: [
            Form,
            Alert,
            Archive
        ],

        mounted(){
            this.init();
        },

        methods: {
            closeModal(){
                this.errors = {}
                this.form = {}
                this.form.candidate = '';
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.method = 'post';
                this.modal = true;
                this.loading = false;
                this.form.candidate = '';
                this.current = null;
                this.init();
            },
                
            initCalendar(date){
                this.date = moment(date).format('YYYY-MM-DD');
                this.fetchRecord();
            },

            eventClick(events){
                let id = events.tId;

                this.method = 'put';
                this.current = id;
                this.init();

                let API = base_url + 'recruitment/schedule/edit';
                
                axios.post(API, {id:id}).then(response => {
                    let record = response.data.record;
                    let date = new Date(record.interview_schedule);
                        date = date.toISOString();
                    this.form = {
                        candidate: id,
                        date_time: date,
                        note: record.note,
                        status: record.interview_status
                    }
                    this.modal = true;
                    this.loading = false;
                });
            },

            fetchRecord(){
                this.fetching = true;
                let data = {
                    date: this.date
                }
                let API = base_url + 'recruitment/schedule/get';
                axios.post(API, data).then(response => {
                    let record = response.data.events;
                    let events = [];
                    if(record.length){
                        for(let i in record){
                            let time = moment(record[i].interview_schedule).format('hh:mmA');
                            let state = ``;
                            let cssClass = '';
                            if(record[i].interview_status == 1){
                                state = 'Pending';
                                cssClass = 'bg-primary text-white';
                            }else if(record[i].interview_status == 2){
                                state = 'Cancelled';
                                cssClass = 'bg-warning text-white';
                            }else if(record[i].interview_status == 3){
                                state = 'Pass';
                                cssClass = 'bg-success text-white';
                            }else if(record[i].interview_status == 4){
                                state = 'Failed';
                                cssClass = 'bg-danger text-white';
                            }
                            let title = `<strong>`+ record[i].first_name +` `+record[i].last_name +`</strong><br>`+ time +` <i class="pull-right">`+ state +`</i>`;
                            events.push({
                                tId: record[i].id,
                                title: title,
                                start: moment(record[i].interview_schedule).format('YYYY-MM-DD'),
                                cssClass: cssClass,
                                textEscape: false
                            });
                        }
                    }
                    this.fetching = false;
                    this.events = events;
                });
            },

            init(){
                let API = base_url + 'recruitment/schedule/init';
                let data = {
                    id: this.current
                }
                axios.post(API, data).then(response => {
                    let candidate = response.data.candidate;
                    this.candidate = candidate;
                });
            }
        }

    }

</script>