<script>
    module.exports = {
        data: function(){
            return{
                users:[],
                modal: false,
                param: {
                    applicant: '',
                    status: '',
                    limit: 25
                },
                checkbox: [],
                events: [],
                date: null,
            }
        },

        computed:{
            status(){
                return this.param.status;
            }
        },

        watch:{
            status(){
                this.fetch();
            }
        },

        mounted(){
            this.fetch_user();
        },

        methods: {
            fetch_user(){
                this.users = [];
                let url = base_url + 'approvals/shift/fetch-user';

                axios.post(url).then(response => {
                    let users = response.data.users;
                    this.users = users;
                });
            },

            initSearch(){
                this.fetch();
            },

            initCalendar(date){
                this.date = moment(date).format('YYYY-MM-DD');
                this.initSearch();
            },

            eventClick(event, jsEvent, pos) {
                //console.log(event);
            },

            applicant(){
                this.fetch();
            },

            reset(){
                this.param = {
                    applicant: '',
                    status: ''
                }
                this.fetch();
            },

            fetch(){
                let API = base_url + 'approvals/shift/calendar';
                let form_data = {
                    applicant: this.param.applicant ? this.param.applicant : '',
                    status: this.param.status,
                    date: this.date
                }
                axios.post(API, form_data).then(response => {
                    let events = [];
                    let record = response.data.records;
                    let appId = response.data.appId;
                    if(record.length){
                        for(let x in record){
                            let bg = '';
                            let start = moment(record[x]['date']).format('YYYY-MM-DD');
                            let title = `<div>`+ record[x]['applicant']['first_name'] +' '+ record[x]['applicant']['last_name'] +` ( `;

                            if(record[x]['type'] == 1){
                                let bDate = moment(record[x]['date'] +' '+ record[x]['check_in']).format('hh:mmA') +'-'+ moment(record[x]['date'] +' '+ record[x]['check_out']).format('hh:mmA');
                                title+= `<small>`+ bDate +`</small>`;
                            }else if(record[x]['type']==2){
                                title+= `<small>Flexible</small>`;
                            }else if(record[x]['type']==3){
                                let bDate = moment(record[x]['date'] +' '+ record[x]['between_start']).format('hh:mmA') +'-'+ moment(record[x]['date'] +' '+ record[x]['between_end']).format('hh:mmA');
                                title+= `<small>`+ bDate +`</small>`;
                            }
                            
                            title += ` ) </div>`;
                            if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 1) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 1)){
                                bg = 'bg-primary';
                            }else if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 2) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 2)){
                                bg = 'bg-success';
                            }else if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 3) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 3)){
                                bg = 'bg-warning';
                            }else if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 4) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 4)){
                                bg = 'bg-dark';
                            }
                            
                            events.push({
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