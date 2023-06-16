<script>
    module.exports = {
        data: function(){
            return{
                form:{},
                previewModal: false,
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
                approver: null,
                fetching: true
            }
        },

        components: {
            
        },

        mounted(){
            this.getApprover();
            this.fetchRecord();
        },

        mixins: [
            Form,
            Alert,
            Modal,
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
                this.minDate = this.form.start_date;
                this.validateDate();
            },
            end_date(){
                this.validateDate();
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
            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            close(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            overview(id){
                let url = base_url + 'forms/business-trip/edit';
                axios.post(url, {id: id}).then(response => {
                    this.preview = response.data.record;
                    this.previewModal = true;
                })
            },

            previewClose(){
                this.previewModal = false;
            },

            onAttachmentChange(element){
	    		let file = element.target.files[0];
	    		this.form.attachment = file;
	    	},
            
            edit(index){
                this.loading = false;
                this.method = 'put';
                this.modalText = 'Edit Business Trip';
                let record = this.records;
                    record = record[index];

                let start_date = new Date(record.date_start);
                    start_date = start_date.toISOString();

                let end_date = new Date(record.date_end);
                    end_date = end_date.toISOString();
                
                this.form = {
                    id: record.id,
                    start_date: start_date,
                    end_date: end_date,
                    title: record.title,
                    note: record.note
                }
                this.modal = true;
            },

            validateDate(){
                let start_date = this.form.start_date;
                let end_date = this.form.end_date;

                if(start_date != '' && end_date != ''){
                    let flag  = false;
                    let date1 = new Date(start_date);
                    let date2 = new Date(end_date);
                    let diffTime = Math.abs(date2.getTime() - date1.getTime());
                    let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                    
                    if (date2 < date1){
                        this.disabled = true;
                        this.form.no_of_days = '';
                        alert('End date must greated than or equal to start date. Please try again.');
                    }else{
                        diffDays = diffDays + 1;
                        this.form.no_of_days = diffDays;
                        this.disabled = false;
                    }
                }
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
                let REST = base_url + 'forms/business-trip/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

        }

    }

</script>