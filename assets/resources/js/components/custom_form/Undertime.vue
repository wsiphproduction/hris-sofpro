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
                    employee: '',
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1,
                    key: '',
                },
                counts: 0,
                minDate: '',
                minOt: '',
                records: [],
                approver: null,
                fetching: true,
                users: [],
                exportLink: '',
                keyword: '',
                key: '',
                config: null,
                session: null,
                isFirstLoad: true
            }
        },

        components: {
            
        },

        mounted(){
            this.initForm();
            this.fetchRecord();
            this.getApprover();
        },


        computed: {
            date(){
                return this.form.date;
            },
            employee(){
                return this.param.employee;
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
            employee(){
                this.fetchRecord();
            },
            start(){
                this.minDate = this.param.start;
                if(!this.isFirstLoad) {
                    this.param.end = '';
                }
                this.validate();
            },
            end(){
                this.validate();
                this.isFirstLoad = false;
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
            clear(){
                if(this.keyword) {
                    setTimeout(() => {
                        let keyword = this.keyword.trim();
                        let length = keyword.length;
                        this.searchResult = [];

                        if(length == 0){ 
                            this.param.key = null
                            this.keyword = null
                            this.fetchRecord();
                        }
                    }, 1);
                }
            },

            find(){
                let keyword = this.keyword.trim();
                let length = keyword.length;
                this.searchResult = [];
                
                if(length >= 2 || length == 0){ 
                    this.param.key = keyword
                    this.fetchRecord();
                }else{
                    this.showResult = false;
                }
            },
            export_link(){
                let URL = base_url +'custom/undertime/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
            },
        	onChangeEmployee(event){
        		let userID = event.target.value;
        		let users = this.users;
        		let obj = users.filter(user => user.id == userID)[0];
				this.form.approver_id = '';
				this.form.approver_name = '';
                this.form.approver_secondary_id = '';
				this.form.approver_secondary_name = '';

        		if(obj && obj.employments){
        			let employment = obj.employments ? obj.employments[0] : null;
        			if(employment){
        				let organization = employment.approving_organization;
        				if(organization == 'division'){
							let approver = employment.division;
							this.form.approver_id = approver.manager_id;
							this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_manager_id;
							this.form.approver_secondary_name = approver.assistant_manager.first_name+' '+approver.assistant_manager.last_name;
						}else if(organization == 'department'){
							let approver = employment.department;
							this.form.approver_id = approver.manager_id;
							this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_manager_id;
							this.form.approver_secondary_name = approver.assistant_manager.first_name+' '+approver.assistant_manager.last_name;
						}else if(organization == 'section'){
							let approver = employment.section;
							this.form.approver_id = approver.manager_id;
							this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_supervisor_id;
							this.form.approver_secondary_name = approver.assistant_supervisor.first_name+' '+approver.assistant_supervisor.last_name;
						}
        			}
        		}
        		
        	},

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
                     employee: record.user_id,
                     date: date,
                     reason: record.reason
                }
                    
                this.modal = true;
            },

            closeModal(){
                this.addOT = true;
                this.errors = {}
                this.form = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                modalText: 'Create New',
                this.addOT = true;
                this.method = 'post';
                this.form.employee = ''
                this.form.date='';
                this.form.reason='';
                this.form.approver_id = this.approver ? this.approver.user_id:'';
                this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
                this.modal = true;
                this.loading = false;
            },

            initForm(){
                let url = base_url + 'custom/undertime/init';
                axios.post(url).then(response =>{
                    this.users = response.data.users;
                });
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            getApprover(){
                let url = base_url + 'settings/approvers/get';
                axios.post(url).then(response =>{
                    this.approver = response.data.approver;
                });
            },

            reset(){
                this.param = {
                    employee: '',
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    key: '',
                    page: 1
                }
                this.fetchRecord();
            },

            fetchRecord(){
                this.export_link();
                this.fetching = true;
                this.records = [];
                let form_data = {
                    employee: this.param.employee,
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    status: this.param.status,
                    limit: this.param.limit,
                    page: this.param.page,
                    key: this.param.key,
                }
                let REST = base_url + 'custom/undertime/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                    this.config = response.data.config
                    this.session = response.data.session
                    if(this.isFirstLoad) {
                        this.initDateRange();
                    }
                });
            },
            
            getDate(date, time){
                return moment(date).format('MM/DD/YYYY') + ' ' + moment(time).utc().format('hh:mmA')
            },

            initDateRange(){
                json = this.config.json ? JSON.parse(this.config.json) : null;
                    
                let cutoff = json.cutoff;
                let month_date = null;
                let period = null;
                if (this.session.user) {
                    month_date = new Date(this.session.user.default_month_date);
                    period = this.session.user.default_period
                } else {
                    month_date = new Date();
                    period = 'A' 
                }
                month_date = moment(month_date).format('YYYY-MM');
                if (period == 'A') {
                    start = month_date + '-' + cutoff.A_from;
                    start = moment(new Date(start)).format('YYYY-MM-DD');
                    end = month_date + '-' + cutoff.A_to;
                    end = moment(new Date(end)).format('YYYY-MM-DD');
                    start = start > end ? moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
                } else {
                    start = month_date + '-' + cutoff.B_from;
                    start = moment(new Date(start)).format('YYYY-MM-DD');
                    end = month_date + '-' + cutoff.B_to;
                    end = moment(new Date(end)).format('YYYY-MM-DD');
                    start = start > end ? moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
                }

                this.param.start = start;
                this.param.end = end;
            }

        }

    }

</script>
