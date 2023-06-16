<script>
	module.exports = {
		  
		data: function(){

			return{
                disabledDate: [],
                maxDate: 5,
                modal: false,
                modalText: 'Create New',
                form:{
                    dates: '',
                    leave_type: '',
                    credit: '',
                    no_of_days: '',
                    leave_duration: '',
                },
                withPay: false,
                previewModal: false,
                dateValue: null,
                others: false,
                disabled: true,
                numday: 1,
                leave_duration: 0,
                calendarVal: '',
                minDate: '',
                maxDate: '',
                param: {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                minDates: '',
                records: [],
                approver: {},
                policy: [],
                fetching: true,
                step: '0.5',
                readonly: false,
                balance: 30,
                currentDate: [],
                exportLink: '',
                //pickerEvent: null,['2019-05-01', '2019-05-10', '2019-05-12', '2019-05-22']
			}
		},

        computed: {
            fcredit(){
                return this.form.credit;
            },
            cDate(){
                return this.form.date;
            },
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
            },
            changeEmployee(){
                return this.form.employee;
            }
        },

        watch: {
            fcredit(){
                this.InitCalendar();
            },
            cDate(){
                this.updateDate();
            },
            start_date(){
                this.minDate = this.form.start_date;
                this.validateDate();
            },
            end_date(){
                this.validateDate();
            },
            start(){
                this.minDates = this.param.start;
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
            changeEmployee(){
                this.setForm(this.form.employee);
            }
        },

		mounted(){
            this.fetchRecord();
		},

		mixins: [
			Form,
			Alert,
            Archive
		],

        beforeDestroy: function() {
            $(this.$el).datepicker('hide').datepicker('destroy');
        },

        components: {

        },

        methods: {
            export_link(){
                let URL = base_url +'custom/leave/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
            },
            setForm(employee){
                if(employee){
                    this.initForm(employee);    
                }
            },

            setDate(date){
                this.form.dates = date;
            },

            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
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
                    if(start_date != end_date){
                        this.step = '1';
                        this.readonly = true;
                    }
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

            updateDate() {
                let dates = this.form.date;
                if(dates){
                    let array = dates.split(",");
                    this.form.no_of_days = array.length;
                }
                
            },

            closeModal(){
                this.errors = {}
                this.form = {
                    leave_type:'',
                    credit:'',
                    leave: [{
                        date:'',
                        no_of_days: ''
                    }]
                }
                this.modal = false;
                this.loading = false;
                this.readonly = false;
            },

            openModal(){
                this.currentDate = [];
                this.method = 'post';
                this.modal = true;
                this.loading = false;
                this.readonly = false;
            },

            overview(id){
                let url = base_url + 'forms/leave/edit';
                axios.post(url, {id: id}).then(response => {
                    this.preview = response.data.record;
                    this.previewModal = true;

                })
            },

            previewClose(){
                this.previewModal = false;
            },
 			
        	checkCredit(){
        		let leave_type = this.form.leave_type;
                let credit = this.findCredit(leave_type);
                let balance = credit.leave_credit_policy ? credit.leave_credit_policy.balance ? parseFloat(credit.leave_credit_policy.balance) : 0: 0;
                this.balance = balance;
        		if(balance > 0){
        			this.withPay = true;
                    this.numday = balance;
                    this.form.credit = '1';
        		}else{
                    this.withPay = false;
                    this.form.credit = '2';
        		}
                this.disabled = true;
                this.calendarVal = '';
                this.leave_duration = 0;
        	},

            findCredit(id){
                let arr = this.policy;
                let obj = arr.find(o => o.id == id);
                return obj;
            },

            InitCalendar(){
                this.calendarVal = '';
                let leave_type = this.form.leave_type;
                let credit     = this.form.credit;
                let leave_duration     = this.form.leave_duration;
                if(leave_type && credit){
                    if(credit == 2){
                        this.disabled = false;
                        this.numday = 120;
                    }else if(credit == 1){
                        let credit = this.findCredit(leave_type);
                        let balance = credit.leave_credit_policy ? credit.leave_credit_policy.balance ? credit.leave_credit_policy.balance : 0: 0;
                        
                        this.disabled = false;
                        this.numday = Math.ceil(balance);
                    }
                }else{
                    this.disabled = true;
                }
            },

        	editLeave(index){
                this.addLeave = false;
        		this.loading = false;
        		this.method = 'put';
        		this.modalText = 'Edit Leave';
                let record = this.records;
                    record = record[index];
                let start_date = new Date(record.start_date);
                    start_date = start_date.toISOString();

                let end_date = new Date(record.end_date);
                    end_date = end_date.toISOString();
                    
                let leaveDate = record.leaves_dates;
                
                let dates = [];
                if(leaveDate){
                    for(let x in leaveDate){
                        dates.push(leaveDate[x]['date']);
                    }
                }
                dates = dates.length ? dates.join(',') : dates;
                this.currentDate = dates;
                this.form = {
                    id: record.id,
                    leave_type: record.leave_type,
                    dates: dates,
                    credit: record.credit,
                    other: record.other,
                    reason: record.reason,
                    leave_duration: record.leave_duration,
                }

                this.checkCredit();
                this.modal = true;
        	},

        	initForm(id){

				let url = base_url + 'custom-leave/init-form';
				axios.post(url,{id: id}).then(response => {
                    let policy = response.data.policy;
                    let approver = response.data.approver;
                    let res = [];
                    if(policy.length){
                        for(let i in policy){
                            let name = policy[i].name;
                                name = name.toLowerCase();
                            if(name == 'paternity leave' || name == 'maternity leave'){
                                let balance = policy[i].leave_credit_policy && policy[i].leave_credit_policy.balance > 0 ? policy[i].leave_credit_policy.balance : 0;
                                if(balance > 0){
                                    res.push(policy[i]);
                                }
                            }else{
                                res.push(policy[i]);
                            }
                        }
                    }
                    let item_order = ["Vacation Leave", "Sick Leave", "Maternity Leave", "Paternity Leave"];
                    policy.sort((a, b) => item_order.indexOf(a.name) - item_order.indexOf(b.name));
                    this.policy = policy;


                    this.approver = {
                        backup: approver && approver.backup ? approver.backup.first_name +' '+ approver.backup.last_name : '',
                        primary: approver && approver.primary ? approver.primary.first_name +' '+ approver.primary.last_name : '',
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
                let REST = base_url + 'custom-leave/fetch';
                axios.post(REST, form_data).then(response => {
                    let disableDates = response.data.disableDates;
                    let array = [];
                    if(disableDates){
                        for(let x in disableDates){
                            let res = moment(new Date(disableDates[x]['date'])).format('YYYY.M.D');
                            array.push(res);
                        }
                    }
                    this.disabledDate = array;
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

		}

	}

</script>