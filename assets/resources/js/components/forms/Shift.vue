<script>
	module.exports = {
		  
		data: function(){

			return{
				previewModal: false,
				modal: false,
				modalText: 'Create New',
                form: {
                    onsite: '0',
                    type: '',
                    repeat: '',
                    days: []
                },
                archiveId: null,
                minDate: '',
                method: 'post',
                action: 'add',
                events: [],
                param: {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                minDate: '',
                records: [],
                approver: {},
                fetching: true
			}
		},

		mounted(){
			this.getApprover();
            this.fetchRecord();
		},

        computed: {
            shift_length(){
                return this.form.shift_length;
            },
            start_date(){
                return this.form.start_date;
            },
            start_time(){
                return this.form.start_time;
            },
            between_start(){
                return this.form.between_start;
            },
            repeat(){
                return this.form.repeat;
            },
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
            status(){
                return this.param.status;
            },
            limit(){
                return this.param.limit;
            }
        },

        watch: {

            shift_length(){
                this.form.paid_hours = this.form.shift_length - 1;
            },

            start_date(){
                this.form.end_date = this.form.start_date;
                this.minDate = this.form.start_date;
            },

            start_time(){
                let hours = this.form.shift_length;
                    hours = hours ? hours : 0;
                let date  = this.form.start_time;
               
                if(date){
                    let now = new Date(date);
                        now = now.setHours(now.getHours() + parseInt(hours));
                        now = moment(now).format('YYYY-MM-DD HH:mm:ss');
                        now = new Date(now);
                    this.form.end_time = now.toISOString();
                }
                
            },

            between_start(){
                this.form.between_end = this.form.between_start;
            },

            repeat(){
                let start_date = this.form.start_date;
                if(start_date){
                    this.form.end_date = this.form.start_date;
                }else{
                    this.form.end_date = '';
                }
            },
            start(){
                this.minDate = this.param.start;
                this.param.end = '';
                this.validate();
            },
            end(){
                this.validate();
            },
            status(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
        },

		mixins: [
			Form,
			Alert,
            Archive
		],

        methods: {
            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            dayClicked(){
                alert();
            },

            open(){
                this.form = {
                    onsite: 0,
                    type: '',
                    repeat: '',
                    days: []
                }
                this.action = 'add';
                this.getApprover();
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            close(){
                this.action = 'add';
                this.errors = {}
                this.form = {
                    onsite: 0,
                    type: '',
                    repeat: '',
                    days: []
                }
                this.modal = false;
                this.loading = false;
            },

            eventClick(event, jsEvent, pos) {
                //console.log(event);
            },
            
            previewClose(){
                this.previewModal = false;
            },

            onAttachmentChange(element){
	    		let file = element.target.files[0];
	    		this.form.attachment = file;
	    	},
            
        	edit(index){
                this.action = 'edit';
				this.loading = false;
        		this.method = 'put';
        		this.modalText = 'Edit Shift';
                let record = this.records;
                    record = record[index];
                this.form.id            = record.id;
                this.form.type          = record.type;
                this.form.shift_length  = record.shift_length;
                this.form.paid_hours    = record.paid_hours;
                this.form.start_time    = record.check_in;
                this.form.end_time      = record.check_out;
                this.form.between_start = record.between_start;
                this.form.between_end   = record.between_end;
    			this.form.onsite        = record.onsite;
    			this.modal = true;
        	},

        	closeModal(){

				this.errors = {}
				this.form = {
                    type: '',
                    repeat: '',
                }
				this.modal = false;
				this.loading = false;
			},

			openModal(){
                this.modalText ='Create New';
				this.method = 'post';
				this.modal = true;
				this.loading = false;
			},

        	getApprover(){
        		let url = base_url + 'settings/approvers/get';

        		axios.post(url).then(response =>{
                    let approver = response.data.approver;
                    this.approver = {
                        backup: approver && approver.backup ? approver.backup.first_name +' '+ approver.backup.last_name : '',
                        primary: approver && approver.primary.first_name +' '+ approver.primary.last_name,
                    }
                });
        	},

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            fetchRecord(){
                this.fetching = true;
                this.records = [];
                let form_data = {
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    status: this.param.status,
                    limit: this.param.limit,
                    page: this.param.page
                }
                let REST = base_url + 'forms/shift/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            },

            initCalendar(date){
                
                let url = new URL(window.location.href);

                let view = url.searchParams.get('view');

                if(view == 'calendar'){

                    let url = base_url + 'forms/shift/calendar';

                    axios.post(url, {date:date}).then(response => {
                        let events = [];
                        let record = response.data.record;
                        
                        if(record.length){
                            for(let x in record){
                                let title = 'Flexible';
                                let cssClass= '';
                                let start = moment(record[x]['date']).format('YYYY-MM-DD');
                                if(record[x]['type'] == 1){
                                    title = moment(record[x]['date'] +' '+ record[x]['check_in']).format('hh:mmA') +'—'+ moment(record[x]['date'] +' '+ record[x]['check_out']).format('hh:mmA');
                                }else if(record[x]['type'] == 3){
                                    title = moment(record[x]['date'] +' '+ record[x]['between_start']).format('hh:mmA') +'—'+ moment(record[x]['date'] +' '+ record[x]['between_end']).format('hh:mmA');
                                }
                                
                                if(record[x]['primary_status'] == 1){
                                    cssClass = 'text-white bg-primary';
                                }else if(record[x]['primary_status'] == 2){
                                    cssClass = 'text-white bg-success';
                                }else if(record[x]['primary_status'] == 3){
                                    cssClass = 'text-white bg-warning';
                                }else if(record[x]['primary_status'] == 4){
                                    cssClass = 'text-white bg-dark';
                                }

                                events.push({
                                    title: title,
                                    start: start,
                                    cssClass: cssClass,
                                    textEscape: false
                                });
                            }
                        }

                        this.events = events;
                        
                    });

                }
            }
		},
	}

</script>