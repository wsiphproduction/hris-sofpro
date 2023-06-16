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
                    key: '',
                    page: 1
                },
                counts: 0,
                minDate: '',
                minOt: '',
                records: [],
                approver: null,
                fetching: true,
                users: [],
                shifts: [],
                shift_types: [],
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
            // this.getApprover();
            this.fetchRecord();
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
            },
            // old_date(){
            //     return this.form.old_date;
            // },
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
            // old_date(){
            //     this.setOldDate();
            //     console.log('sdf');
            // },
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
                let URL = base_url +'custom/change-shift/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
            },
            setOldDate(event){
                let old_date = event.target.value;
                if(this.form.type != 'update'){
                    let id = this.form.old_date;
                    let shifts = this.shifts;
                    let result = shifts.filter(function(arr){return arr.id == old_date})[0];
                    this.form.id = old_date;
                    if(result){
                        this.form.old_login = result.check_in ? moment(result.check_in).utc().format('HH:mm'):'';
                        this.form.old_logout = result.check_out ? moment(result.check_out).utc().format('HH:mm'):'';
                        this.form.cur_shift_type = result.shift_type ? result.shift_type:'';
                        this.minDate = result.date;
                        this.form.new_date = result.date;
                    }else{
                        this.form.old_login = '';
                        this.form.old_logout = '';
                    }
                }
            },

        	onChangeEmployee(event){
                this.shifts = [];
                // this.shift_types = [];
                this.form.old_date = '';
                this.form.old_login = '';
                this.form.old_logout = '';
                this.form.shift_type = '';
                this.form.new_date = '';
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
        		
                let url = base_url + 'custom/change-shift/getshift';
                axios.post(url, {id: userID}).then(response => {
                    if(this.form.approver_name) {
                        this.shifts = this.fillShiftDate(response.data.shifts)
                    }
                })
        	},

            fillShiftDate(shifts){
                let shiftResults = [];
                let ctr = 0;
                
			    let date_today = new Date()
                let start_date = date_today.setDate(date_today.getDate() - 20)
                
			    date_today = new Date()
                let end_date = date_today.setDate(date_today.getDate() + 11)

			    for (var m = moment(start_date); m.diff(end_date, 'days') <= 0; m.add(1, 'days')) {
			    	let thisDate = m.format('YYYY-MM-DD')
			    	let gotShifts = shifts.filter(
			    			(v,i,a)=>a.findIndex(t=>(
			    			t.user_id === v.user_id && t.date===thisDate && (t.shift_id === v.shift_id)
			    		))===i
			    	);
			    	let result = gotShifts[0] ? gotShifts[0] : {id: ctr, date: thisDate}
			    	shiftResults.push(result);
                    ctr++
			    }

                return shiftResults;
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
            
            editShift(index){
                this.loading = false;
                this.method = 'put';
                let record = this.records;
                    record = record[index];
                let new_checkin = new Date(record.new_checkin);
                    new_checkin = new_checkin.toISOString();
                this.form = {
                    id: record.id,
                    type: 'update',
                    employee: record.user_id,
                    approver_id: this.approver ? this.approver.user_id:'',
                    approver_name: this.approver ? this.approver.first_name+' '+this.approver.last_name:'',
                    old_date:   record.old_checkin != null ? moment(record.old_checkin).format('ll'):moment(new_checkin).format('ll'),
                    old_login:  record.old_checkin != null ? moment(record.old_checkin).utc().format('HH:mm'):'',
                    old_logout: record.old_checkout != null ? moment(record.old_checkout).utc().format('HH:mm'):'',
                    new_date: new_checkin,
                    cur_shift_type: record.shift_type != null ? record.shift_type : record.new_shift_type,
                    shift_type: record.new_shift_type,
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
                modalText: 'Create New',
                this.addOT = true;
                this.method = 'post';
                this.form.approver_id = this.approver ? this.approver.user_id:'';
                this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
                this.modal = true;
                this.loading = false;
            },

            initForm(){
                //this.form.no_of_hours.value = null;   
                let url = base_url + 'custom/change-shift/init';
                axios.post(url).then(response =>{
                    this.users = response.data.users;
                    this.shift_types = response.data.shift_type;
                });
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
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
                let REST = base_url + 'custom/change-shift/fetch';
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
