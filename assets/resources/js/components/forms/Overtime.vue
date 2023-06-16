<script>
    module.exports = {
          
        data: function(){

            return{
                addOT: true,
                previewModal: false,
                modal: false,
                required: true,
                modalText: 'Create New',
                form: {
                    type: '1',
                    no_of_hours: 0
                },
                param: {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                },
                validation: {
                    isValueZeroOrNegative: false,
                    errorMessage: 'Number of hours must not be 0 or negative value.'
                },
                counts: 0,
                minDate: '',
                minOt: '',
                records: [],
                approver: null,
                fetching: true
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
            validateDate(){
                this.validation.isValueZeroOrNegative = false;
                let start_date = this.form.start_date
                let end_date = this.form.end_date
                if(start_date != 0 && end_date != 0){

                    var ms = moment(new Date(end_date),"DD/MM/YYYY HH:mm:ss").diff(moment(new Date(start_date),"DD/MM/YYYY HH:mm:ss"));
                    var d = moment.duration(ms);
                    this.form.no_of_hours = d.asHours()

                    if(d.asHours() <= 0) {
                        this.validation.isValueZeroOrNegative = true;
                    }                    
                }
            },

            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            overview(id){
                let url = base_url + 'forms/overtime/edit';
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
            
            editOvertime(index){
                this.addOT = false;
                
                this.loading = false;
                
                this.method = 'put';

                this.modalText = 'Edit Overtime';
                let record = this.records;
                    record = record[index];
                    
                let start_date = record.start_date +' '+ moment(record.start_time).utc().format('HH:mm:ss');
                    start_date = new Date(start_date);
                    start_date = start_date.toISOString();
                    // start_date = start_date.toISOString();
                let end_date = record.end_date +' '+ moment(record.end_time).utc().format('HH:mm:ss');
                    end_date = new Date(end_date);
                    end_date = end_date.toISOString();
                this.form = {
                    id: record.id,
                    start_date: start_date,
                    end_date: end_date,
                    type: record.type,
                    no_of_hours: record.no_of_hours,
                    purpose: record.purpose,
                    attachment: record.attachment
                }
                    
                this.modal = true;
            },

            closeModal(){
                this.addOT = true;
                this.errors = {}
                this.form = {
                    overtime: [{}]
                }
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                modalText: 'Create New',
                this.addOT = true;
                this.method = 'post';
                this.form.approver_id = this.approver ? this.approver.user_id:'';
                this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
                this.modal = true;
                this.loading = false;
            },

            addOvertime(){
                this.form.id = null;
                this.form.overtime.push({
                    start_date: '',
                    end_date: '',
                    no_of_hours: 0,
                });
            },

            removeOvertime(index){
                if(index == 0){
                    alert("Error: You can't remove this line.");
                }else{
                    this.form.overtime.splice(index, 1);
                }
            },

            initForm(){
                //this.form.no_of_hours.value = null;   
                //let url = base_url + 'employee/init-form';

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
                let REST = base_url + 'forms/overtime/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

        }

    }

</script>
