<script>
    module.exports = {
          
        data: function(){

            return{
                addOT: true,
                previewModal: false,
                modal: false,
                required: true,
                modalText: 'Create New',
                form: {},
                param: {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
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


        computed: {
            date(){
                return this.form.date;
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
            date(){
                //this.form.end_date = this.form.start_date;
                this.minOt = this.form.date;
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
            Modal,
            Archive
        ],

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
                let url = base_url + 'forms/undertime/edit';
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
            
            editUndertime(index){
                this.addOT = false;
                
                this.loading = false;
                
                this.method = 'put';

                this.modalText = 'Edit Undertime';
                let record = this.records;
                    record = record[index];
                let date = moment(record.date).format('YYYY-MM-DD')+' '+moment(record.time).utc().format('HH:mm:ss');
                    date = new Date(date);
                    date = date.toISOString();

                this.form = {
                     id: record.id,
                     date: date,
                     reason: record.reason
                }
                    
                this.modal = true;
            },

            closeModal(){
                this.addOT = true;
                this.errors = {}
                this.form = {
                    undertime: [{}]
                }
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.modalText = 'Create New';
                this.addOT = true;
                this.method = 'post';
                this.form.approver_id = this.approver ? this.approver.user_id:'';
                this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
                this.modal = true;
                this.loading = false;
            },

            addUndertime(){
                this.form.id = null;
                this.form.undertime.push({
                    date: '',
                });
            },

            removeUndertime(index){
                if(index == 0){
                    alert("Error: You can't remove this line.");
                }else{
                    this.form.undertime.splice(index, 1);
                }
            },

            initForm(){
                //this.form.no_of_hours.value = null;   
                //let url = base_url + 'employee/init-form';
                
//})
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
                let REST = base_url + 'forms/undertime/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            },
            
            getDate(date, time){
                return moment(date).format('MM/DD/YYYY') + ' ' + moment(time).utc().format('hh:mmA')
            }

        }

    }

</script>
