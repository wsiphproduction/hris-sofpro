<script>
	module.exports = {
		  
		data: function(){

			return{
				previewModal: false,
				modal: false,
				modalText: 'Change Shift',
                form: {
                    old_date: '',
                	type: '',
                    approver_id:'',
                    approver_name: '',
                    shift_type: ''
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
                shift_types: [],
                fetching: true,
                approver: null,
                minDate: '',
                shifts: []
			}
		},

        components: {
            
        },

		mounted(){
			// this.initForm();
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
            old_date(){
                return this.form.old_date;
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
                // this.setOldDate();
            },
            old_date(){
                //this.form.end_date = this.form.start_date;

                //this.setOldDate();
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
            setOldDate(){
                if(this.form.type != 'update'){
                    let id = this.form.old_date;
                    let shifts = this.shifts;
                    let result = shifts.filter(function(arr){return arr.id == id})[0];
                    this.form.id = id;
                    if(result){
                        // this.shift_type = result.shift_type;
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
                let record = this.records;
                    record = record[index];
                let new_checkin = new Date(record.new_checkin);
                    new_checkin = new_checkin.toISOString();

                this.form = {
                    id: record.id,
                    type: 'update',
                    approver_id: this.approver ? this.approver.user_id:'',
                    approver_name: this.approver ? this.approver.first_name+' '+this.approver.last_name:'',
                    old_date: record.old_checkin ? moment(record.old_checkin).format('ll'): '',
                    old_login: record.old_checkin ? moment(record.old_checkin).utc().format('HH:mm'):'',
                    old_logout: record.old_checkout ? moment(record.old_checkout).utc().format('HH:mm'):'',
                    new_date: new_checkin,
                    shift_type: record.new_shift_type,
                    cur_shift_type: record.shift_type,
                }
                    
                this.modal = true;
        	},

        	closeModal(){
				this.errors = {}
				this.form = {
					old_date: '',
                    approver_id: this.approver ? this.approver.user_id:'',
                    approver_name: this.approver ? this.approver.first_name+' '+this.approver.last_name:'',
                    shift_type: ''
				}
				this.modal = false;
				this.loading = false;
			},

			openModal(){
                modalText: 'Create New',
                this.form = {
                    type: 'create',
                    old_date: '',
                    approver_id: this.approver ? this.approver.user_id:'',
                    approver_name: this.approver ? this.approver.first_name+' '+this.approver.last_name:'',
                }
				this.method = 'post';
				this.modal = true;
				this.loading = false;
			},

            onAttachmentChange(element){
	    		let file = element.target.files[0];
	    		this.form.attachment = file;
	    	},
            
        	initForm(){
				let REST = base_url + 'forms/change-shift/initform';
                axios.post(REST).then(response =>{
                    //this.shifts = response.data.shifts;
                    this.shifts = this.fillShiftDate(response.data.shifts)
                    this.shift_types = response.data.shift_type;
                });
        	},
            fillShiftDate(shifts){
                let shiftResults = [];
                let ctr = 0;
                
			    let date_today = new Date()
                let start_date = date_today.setDate(date_today.getDate() - 20)

			    date_today = new Date()
                let end_date = date_today.setDate(date_today.getDate() + 10)

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
                this.initForm();
                this.fetching = true;
                this.records = [];
                let form_data = {
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    status: this.param.status,
                    limit: this.param.limit,
                    page: this.param.page
                }
                let REST = base_url + 'forms/change-shift/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

		}

	}

</script>
