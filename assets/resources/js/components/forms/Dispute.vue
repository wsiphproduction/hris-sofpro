<script>
	module.exports = {
		  
		data: function(){

			return{
				previewModal: false,
				modal: false,
				modalText: 'Create New',
                form: {
                	type: ''
                },
                param: {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                records: [],
                fetching: true,
                approver: null,
                minDate: '',
			}
		},

        components: {
            
        },

		mounted(){
			this.initForm();
            this.getApprover();
            this.fetchRecord();
		},

		mixins: [
			Form,
			Alert,
            Archive
		],

		computed: {
            start_date(){
                return this.form.start_date;
            },
            end_date(){
                return this.form.end_date;
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
            start_date(){
                //this.form.end_date = this.form.start_date;
                this.minOt = this.form.start_date;
            },
            end_date(){
                //this.validateDate();
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

        methods: {
            isNumber(event){
                if(this.form.type != 3 && event.key==='.'){
                    event.preventDefault();
                }
            },

            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            onAttachmentChange(element){
	    		let file = element.target.files[0];
	    		this.form.attachment = file;
	    	},
            
            getApprover(){
                let url = base_url + 'settings/approvers/get';
                axios.post(url).then(response =>{
                    let approver = response.data.approver;
                    this.approver = approver;
                    this.form.approver_id = approver ? approver.user_id:'';
                    this.form.approver_name = approver ? approver.first_name+' '+approver.last_name:'';
 					this.form.approver_secondary_id =  approver ? approver.secondary_user_id:'';
					this.form.approver_secondary_name =  approver ? approver.secondary_first_name+' '+approver.secondary_last_name:'';
                });
            },

        	edit(index){
				this.loading = false;
        		this.method = 'put';
        		this.modalText = 'Edit Dispute';
                let record = this.records;
                    record = record[index];
                let date = new Date(record.date);
                    date = date.toISOString();
                let hour = record.hour;
                if(record.type == 3){
                    hour = hour / 8;
                }
                this.form = {
                    id: record.id,
                    type: record.type,
                    date: date,
                    hours: hour,
                    note: record.note
                }
                    
                this.modal = true;
        	},

        	closeModal(){
				this.errors = {}
				this.form = {
					type: ''
				}
				this.modal = false;
				this.loading = false;
			},

			openModal(){
                modalText: 'Create New',
                this.form.type = '';
                this.form.approver_id = this.approver ? this.approver.user_id:'';
                this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
				this.method = 'post';
				this.modal = true;
				this.loading = false;
			},

        	initForm(){
        		//this.form.no_of_hours.value = null;	
				//let url = base_url + 'employee/init-form';

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
                let REST = base_url + 'forms/dispute/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

		}

	}

</script>