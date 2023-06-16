<script>
const { isRegExp } = require('util');

    module.exports = {
          
        data: function(){

            return{
                addOT: true,
                previewModal: false,
                modal: false,
                required: true,
                modalText: 'Create New',
                form: {
                    start_date: null,
                    end_date: null,
                    no_of_hours: 0,
                    shift_id: '',
                },
                param: {
                    employee: '',
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1,
                    key: '',
                },
                validation: {
                    isValueZeroOrNegative: false,
                    errorMessage: 'Number of hours must not be 0 or negative value.'
                },
                counts: 0,
                minDate: '',
                minOt: '',
                records: [],
                shift_types: [],
                approver: null,
                fetching: true,
                users: [],
                shifts: [],
                exportLink: '',
                keyword: '',
                key: '',
                hasShift: true,
                config: null,
                session: null,
                isFirstLoad: true,
                selected_user_shifts:{},
                editOt: false, 
                actual_shift_type: {},
            }
        },

        components: {
            
        },

        mounted(){
            this.initForm();
            this.fetchRecord();
        },


        computed: {
            start_date(){
                return this.form.start_date;
            },
            end_date(){
                return this.form.end_date;
            },
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
            start_date(){
                this.minOt = this.form.start_date;
                this.computeNoOfHours();
                this.onChangeDate();

                if(this.form.start_date!= '' && this.form.employee != ''){
                    this.fetchSelectedUserShift();
                }
            },
            end_date(){
                this.computeNoOfHours();
            },
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
            computeNoOfHours(){
                let start_date = this.form.start_date
                let end_date = this.form.end_date
                
                if(start_date != null && end_date != null){
                    var ms = moment(new Date(end_date),"DD/MM/YYYY HH:mm:ss").diff(moment(new Date(start_date),"DD/MM/YYYY HH:mm:ss"));
                    var d = moment.duration(ms);
                    
                    if(this.form.breakHours > 0) {
                        let no_of_hours =  d.asHours();
                        let shift_type = this.form.shift_type_obj;

                        if (shift_type.break_in && shift_type.break_out){
                            const format = 'HH:mm:ss';

                            start_date = moment(start_date).format(format)
                            end_date = moment(end_date).format(format)
                            let break_in = moment(shift_type.break_in).utc().format(format)
                            let break_out = moment(shift_type.break_out).utc().format(format)

                            timein = moment(break_in ,format)
                            timeout = moment(break_out ,format)
                            beforeTime = moment(start_date, format)
                            afterTime = moment(end_date, format)

                            let is_break_in_in_between = timein.isBetween(beforeTime, afterTime)
                            let is_break_out_in_between = timeout.isBetween(beforeTime, afterTime)

                            if(is_break_in_in_between || is_break_out_in_between) {
                                no_of_hours = no_of_hours - this.form.breakHours;
                            }
                        } 
                        
                        this.form.no_of_hours = no_of_hours;
                        
                        if(this.form.no_of_hours <= 0) {
                            this.validation.isValueZeroOrNegative = true;
                        } else {
                            this.validation.isValueZeroOrNegative = false;
                        }
                        
                    } else {
                        this.form.no_of_hours = d.asHours();
                    }
                } else {
                    this.form.no_of_hours = 0;
                }
            },
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
                let URL = base_url +'custom/overtime/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
            },

            setBreakHours(event){
                let shift_type_id = event.target.value
                let shift_type_obj = this.shift_types.filter(shifts => shifts.id == shift_type_id)[0];
                
                this.form.shift_type_obj = shift_type_obj
                if(shift_type_obj) {
                    this.form.breakHours = shift_type_obj.break_hours
                }
                
                this.computeNoOfHours();
            },

            onChangeDate(){
                let date = moment(this.form.start_date).format('YYYY-MM-DD');
                let userID = this.form.employee
                this.form.no_of_hours = null
                
                if(this.form.start_date != "") {
                    let obj = this.shifts.filter(shifts => shifts.date == date && shifts.user_id == userID)[0];
                    
                    if (obj) {
                        let shift_type = obj.shift_type
                        let shift_type_obj = this.shift_types.filter(shift_id => shift_id.shift_id == shift_type)[0];
                        if(shift_type_obj) {
                            this.hasShift = true
                            this.form.shift_type = shift_type_obj.id
                            this.form.breakHours = shift_type_obj.break_hours ? shift_type_obj.break_hours : 0;
                            this.form.shift_type_obj = shift_type_obj;

                            // Enable selection if Shift type is NONE
                            if (shift_type_obj.shift_id == 'NONE'){
                                this.hasShift = false;
                            }
                        }
                    } else {
                        this.hasShift = false
                        this.form.shift_type = ""
                    }
                } 

            },

            fetchSelectedUserShift(){
                let REST = base_url + 'custom/overtime/fetch-user-shifts';

                let data = {
                    user_id : this.form.employee,
                    date    : this.form.start_date,
                };

                axios.post(REST,data).then(response => {
                    let shifts  = response.data.shifts? response.data.shifts: null;
                    let error   = response.data.error? response.data.error: null;
                    if(error){
                        this.errors.shift_id        = error;
                        this.form.shift_id          = '';
                        this.selected_user_shifts   = []; 
                    }
                    if(shifts){
                        console.log(shifts);
                        this.actual_shift_type     = this.editOt ? shifts.filter(el => el.id == this.form.shift_id)[0] : null;
                        let edit_shift_type        = this.editOt ? this.shift_types.filter(el => el.id == this.actual_shift_type.type_of_shift.id)[0] : null;

                        let ot_shift_target       = shifts;
                        let selected_shift_id     = ot_shift_target.filter(el => el.date == moment(this.form.start_date).format("YYYY-MM-DD"));
                        //this.form.shift_id        = selected_shift_id.length?selected_shift_id[0].id : ot_shift_target[0].id;
                        this.form.shift_id        = this.editOt ? this.form.shift_id : selected_shift_id.length ? selected_shift_id[0].id : ot_shift_target[0].id;
                        ot_shift_target           = ot_shift_target.sort((a, b) => { return new Date(a.date) - new Date(b.date) });
                        this.errors.shift_id      = null;
                        this.selected_user_shifts = ot_shift_target;
                        this.form.shift_type    = this.editOt ? edit_shift_type.id : this.form.shift_id ? this.selected_user_shifts.type_of_shift.id : null;

                        if(this.editOt == true){this.editOt = false;}
                    }
                });
            },

        	onChangeEmployee(event){
        		let userID = event.target.value;
        		let users = this.users;
        		let obj = users.filter(user => user.id == userID)[0];
				this.form.approver_id = '';
				this.form.approver_name = '';
                this.form.approver_secondary_id = '';
				this.form.approver_secondary_name = '';
                this.form.shift_id = '';
        		if(obj && obj.employments){
        			let employment = obj.employments ? obj.employments[0] : null;
        			if(employment){
        				let organization = employment.approving_organization;
        				if(organization == 'division'){
							let approver = employment.division;
							this.form.approver_id = approver.manager_id;
							this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_manager_id;
							this.form.approver_secondary_name = approver.assistant_manager ? approver.assistant_manager.first_name+' '+approver.assistant_manager.last_name : "";
						}else if(organization == 'department'){
							let approver = employment.department;
							this.form.approver_id = approver.manager_id;
							this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_manager_id;
							this.form.approver_secondary_name = approver.assistant_manager ? approver.assistant_manager.first_name+' '+approver.assistant_manager.last_name : "";
						}else if(organization == 'section'){
							let approver = employment.section;
							this.form.approver_id = approver.manager_id;
							this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_supervisor_id;
							this.form.approver_secondary_name = approver.assistant_supervisor ? approver.assistant_supervisor.first_name+' '+approver.assistant_supervisor.last_name : "";
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

            editOvertime(index){
                this.editOt = true;
                this.fetchSelectedUserShift();
                this.addOT = false;
                this.loading = false;
                this.method = 'put';
                this.modalText = 'Edit Overtime';
                let record = this.records;
                    record = record[index];
                let start_date = moment(record.start_date).format('YYYY-MM-DD')+' '+moment(record.start_time).utc().format('HH:mm:ss');
                    start_date = new Date(start_date);
                    start_date = start_date.toISOString();
                let end_date = moment(record.end_date).format('YYYY-MM-DD')+' '+moment(record.end_time).utc().format('HH:mm:ss');
                    end_date = new Date(end_date);
                    end_date = end_date.toISOString();
                    
                this.form = {
                    id: record.id,
                    start_date: start_date,
                    end_date: end_date,
                    shift_id: record.shift_id,
                    purpose: record.purpose,
                    employee: record.user_id,
                    attachment: record.attachment
                }

                this.modal = true;
                
            },

            closeModal(){
                this.addOT = true;
                this.errors = {}
                this.form = {
                    undertime: [{}],
                    shift_id : ''
                }
                this.modal = false;
                this.loading = false;
                this.errors.shift_id = null;
                this.selected_user_shifts   = []; 
            },

            openModal(){
                this.modalText= 'Create New',
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
                let url = base_url + 'custom/overtime/init';
                axios.post(url).then(response =>{
                    this.users = response.data.users;
                    this.shifts = response.data.shifts;
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
                let REST = base_url + 'custom/overtime/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.shift_types = response.data.shifts;
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
