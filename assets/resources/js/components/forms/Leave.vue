<script>
    module.exports = {
          
        data: function(){

            return{
                disabledDate: [],
                modal: false,
                modalText: 'Create New',
                form:{
                    start: '',
                    end: '',
                    dates: '', //05/13/2020, 05/14/2020, 05/15/2020
                    leave_type: '',
                    credit: '',
                    no_of_days: '',
                    leave_duration: '',
                    leave_object_string_converted: '',
                    has_errors: false,
                    start_date: '',
                    end_date: '',
                },
                withPay: false,
                previewModal: false,
                dateValue: null,
                others: false,
                disabled: true,
                numday: 1,
                calendarVal: '',
                minDate: '',
                maxDate: '',
                leave_duration: 0,
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
                approver: null,
                policy: [],
                fetching: true,
                step: '0.5',
                readonly: false,
                balance: 30,
                currentDate: [],
                leave_object: [],
                diffDays: 0,
                leave_credit_errors: {},
                leave_duration_errors: {},
                file_leave_error: '',
                max_date_to_file: 30,
                leave_balance: 0,
                max_with_pay_reach: {},
                array_with_pay: [],
                not_first_open_edit:false,
                addLeave:true,
                form_open:false,
                vacation_leave: [],
                preview: [],
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
            leave_type(){
                return this.form.leave_type;
            }
        },

        watch: {
            fcredit(){
                //this.form.dates = ""
                this.InitCalendar();
            },
            cDate(){
                this.updateDate();
            },
            start_date(){
                if(this.not_first_open_edit||this.modalText !== 'Edit Leave'){
                    if(this.form.leave_type == 13) {
                        this.max_date_to_file = 105
                    }

                    this.minDate = this.form.start_date;
                    this.maxDate = moment(this.form.start_date).add(this.max_date_to_file,'days').utc().format();
                    this.form.end_date = '';
                    this.leave_credit_errors = {};
                    this.leave_duration_errors = {};
                    this.diffDays = 0;
                    this.validateDate();
                }
            },
            end_date(){
                if(this.not_first_open_edit||this.modalText !== 'Edit Leave'){
                    this.validateDate();
                    if(this.form.leave_type == this.vacation_leave.id)
                    {
                        this.checkIfVLisInRange();
                    }
                }
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
            leave_type(){
                this.not_first_open_edit = true;
                if(this.form_open)
                {
                    this.getBalance();
                }
            },
        },

        mounted(){
            this.initForm();
            this.getApprover();
            this.fetchRecord();
            this.getVLId();
            // this.datePicker();
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

            getVLId(){
                let REST = base_url + 'forms/leave/getvlid';
                axios.post(REST).then(response => {
                    this.vacation_leave = response.data.vl;
                });
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

            addConvertedJSONtoForm(){
                this.checkEmptyData();
                if (!this.form.has_errors) {
                    this.removeEndDateNotFiled();
                    let stringConverted = JSON.stringify(this.leave_object);
                    this.form.leave_object_string_converted = stringConverted;
                }
            },

            removeEndDateNotFiled(){
                let leave_object = this.leave_object;
                let leave_length = leave_object.length;

                if(!leave_object[leave_length-1].date_is_filed) {
                    for(let i = leave_length; i > 0; i--){
                        if(!leave_object[i-1].date_is_filed) {
                            leave_object.pop();
                        }
                    }
                }

                if(!leave_object[0].date_is_filed) {
                    for(let i = 0; i < 0; i++){
                        if(!leave_object[i].date_is_filed) {
                            leave_object.shift();
                        }
                    }
                }
            },

            checkEmptyData(){
                let leave_object = this.leave_object;
                let has_atleast_one_date_filed = false;
                this.leave_credit_errors = {}
                this.leave_duration_errors = {}
                this.form.has_errors = false

                for(i in leave_object){
                    if(leave_object[i].leave_credit == "" && leave_object[i].date_is_filed) {
                        this.leave_credit_errors[i] = "The Leave Credit field is required.";
                    }
                    if(leave_object[i].leave_duration == "" && leave_object[i].date_is_filed) {
                        this.leave_duration_errors[i] = "The Leave Duration field is required.";
                    }

                    if(leave_object[i].date_is_filed) {
                        has_atleast_one_date_filed = true;
                    }
                }
                
                let leave_credit_has_errors = Object.keys(this.leave_credit_errors).length !== 0
                let leave_duration_has_errors = Object.keys(this.leave_duration_errors).length !== 0
                
                if(leave_credit_has_errors || leave_duration_has_errors) {
                    this.form.has_errors = true;
                }

                if(!has_atleast_one_date_filed) {
                    this.file_leave_error = "File atleast one date."
                    this.form.has_errors = true;
                }
            },

            checkIfVLisInRange(){
                let start_date = this.form.start_date;
                    start_date = moment(start_date).format('MM/DD/YYYY')
                let end_date = this.form.end_date;
                let leave_type = this.form.leave_type;
                // Check if VL is 2 days in advance
                if(start_date != '' && end_date != '') {
                    let VL_ID = this.vacation_leave.id;
                    let VL_ADVANCE = this.vacation_leave.date_advance;
                    let leave_date = moment().add(VL_ADVANCE,'days').format('MM/DD/YYYY');
                    if (leave_type == VL_ID && (start_date <= leave_date)){
                        
                        this.diffDays = 0
                        this.errors.end_date = 'Vacation leave should be 2 days advance.'
                    }
                }
            },

            validateDate(){
                this.file_leave_error = ''
                let start_date = this.form.start_date;
                let end_date = this.form.end_date;
                let leave_type = this.form.leave_type;
                
                if((start_date != '' || end_date != '') && leave_type == '' && this.modal){
                    this.form.start_date = "";
                    this.form.end_date = "";
                    alert('Please provide Leave policy before selecting dates.');

                }

                if(start_date != '' && end_date != '' && leave_type != ''){
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
                        this.diffDays = diffDays + 1;
                        this.create_leave_object(start_date)
                        this.errors = {}
                    }
                }
            },

            create_leave_object(start_date) {
                this.leave_object = [];
                this.array_with_pay = [];
                for (let i = 0;i<this.diffDays;i++) {
                    date = moment(start_date).add(i,'days').format('YYYY-MM-DD');
                    let leave_object = {
                        id              : i,
                        date            : date,
                        with_pay        : this.balance ? true : false,
                        leave_credit    : '',
                        whole_day_paid  : this.balance >= 1 ? true: false,
                        leave_duration  : '',
                        date_is_filed   : true
                    }
                    this.leave_object.push(leave_object)
                }
            },

            // process_credit(index, from_credit = false){
            //     if (from_credit) {
            //         if(this.leave_object[index].leave_credit === "1") {
            //             this.leave_object[index].leave_duration = '';
            //             this.array_with_pay.push(index);
            //         } else {
            //             const index_in_array = this.array_with_pay.indexOf(index);
            //             if (index_in_array > -1) {
            //                 this.array_with_pay.splice(index_in_array, 1);
            //             }
            //         }
            //     }
                
            //     let leave_with_pay_count = 0;
            //     let leave_with_pay_duration_count = 0;
            //     let leave_has_half_day = false;
            //     this.leave_object.forEach(lo => { 
            //         if (lo.leave_credit === "1") {
            //             if(lo.leave_duration === "0") {
            //                 leave_with_pay_duration_count += 1;
            //             }
            //             if(lo.leave_duration === "1" || lo.leave_duration === "2") {
            //                 leave_with_pay_duration_count += 0.5;
            //                 leave_with_pay_count += 0.5;
            //                 leave_has_half_day = true
            //             } else {
            //                 leave_with_pay_count += 1;
            //             }
            //         } 
            //     })

            //     if(leave_with_pay_count >= this.leave_balance) {
            //         this.leave_object.forEach((lo, loIndex) => lo.with_pay = this.array_with_pay.includes(loIndex))
            //     } else {
            //         this.leave_object.map(lo=>lo.with_pay=true);
            //     }
            //     let leave_difference = this.leave_balance - leave_with_pay_duration_count
            //     if (leave_difference == 0.5 || leave_difference == 0) {
            //         this.leave_object.forEach(lo => {
            //             if (lo.leave_credit === "1" && leave_with_pay_count >= this.leave_balance) {
            //                 if(lo.leave_duration != "0") {
            //                     lo.whole_day_paid = false;
            //                 }
            //             } else {
            //                 lo.whole_day_paid = true;
            //             }
            //         })
            //     } else {
            //         this.leave_object.map(lo=>lo.whole_day_paid=true);
            //     }
            // },
            process_credit(index, from_credit = false){
                // RESET LEAVE DURATION
                this.leave_balance      = this.balance;

                let used_leave_balance  = 0;
                let obj_with_credit     = [];

                //SCAN TO ALL LEAVE OBJECTS
                for(x in this.leave_object){
                    if(this.leave_object[x].date_is_filed){
                        if(this.leave_balance > 0){
                            
                            this.leave_object[x].with_pay = true;
                            this.leave_object[x].whole_day_paid = (this.leave_balance >= 1) ? true:false;

                            if(this.leave_object[x].leave_credit=="1"){
                                if(this.leave_object[x].leave_duration != ""){
                                    used_leave_balance = (this.leave_object[x].leave_duration=="0") ? 1 : 0.5 ;
                                    this.leave_balance -= parseFloat(used_leave_balance);
                                    obj_with_credit.push(x);
                                }
                            }
                        }
                    }
                }

                // LET CHANGE ALL FIELDS THAT ARE NOT SELECTED TO WITHOUT PAY IF leave_balance < 1 AND IF 0.5 REMAINING
                if(this.leave_balance <= 0){
                    for(x in this.leave_object){
                        if(obj_with_credit.indexOf(x)==-1){
                            this.leave_object[x].with_pay       = false;
                            this.leave_object[x].whole_day_paid = true;
                            this.leave_object[x].leave_credit   = "2";
                        }
                    }
                }
                if(this.leave_balance > 0 && this.leave_balance < 1){
                    for(x in this.leave_object){
                        if(obj_with_credit.indexOf(x)==-1){
                            this.leave_object[x].with_pay       = true;
                            this.leave_object[x].whole_day_paid = false;
                        }
                    }
                }
            },
            
            process_date_filed(index, event){
        		let checked = event.target.checked;
                this.file_leave_error = ''
                this.leave_object[index].leave_credit = ''
                this.leave_object[index].leave_duration = ''
                this.leave_object[index].date_is_filed = checked
                this.process_credit(index);
            },

            updateDate() {
                let dates = this.form.date;
                if(dates){
                    let array = dates.split(",");
                    this.form.no_of_days = array.length;
                }
                
            },

            closeModal(){
                this.errors             = {}
                this.modal              = false;
                this.loading            = false;
                this.readonly           = false;
                this.leave_object       = [];
                this.diffDays           = 0;
                this.not_first_open_edit= false,
                this.form_open          = false;

                this.form = {
                    dates           : '',
                    leave_type      :'',
                    credit          :'',
                    leave_duration  :'',
                    start_date      :"",
                    end_date        :"",
                    no_of_days      : '',
                };
            },

            openModal(){
                this.currentDate        = [];
                this.method             = 'post';
                this.form.approver_id   = this.approver ? this.approver.user_id:'';
                this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
                this.modal              = true;
                this.loading            = false;
                this.readonly           = false;
                this.modalText          = "Create New";
                this.addLeave           = true;
                this.form_open          = true;
            },

            overview(index){
                this.preview        = this.records[index];
                this.previewModal   = true;
                this.modalText      = 'Leave Details';
                this.leave_object   = this.preview.leaves_dates;

                //SORT LEAVE OBJECT BY DATE
                this.leave_object.sort((a,b)=>{
                    return new Date(a.date) - new Date(b.date);
                });
            },

            previewClose(){
                this.previewModal   = false;
                this.modalText      = '';
                this.leave_object   = [];
                this.preview        = [];
            },
            
            checkCredit(){
                let leave_type      = this.form.leave_type;
                let credit          = this.findCredit(leave_type);
                let balance         = credit.leave_credit_policy ? credit.leave_credit_policy.balance ? parseFloat(credit.leave_credit_policy.balance) : 0: 0;
                this.balance        = balance;
                this.leave_balance  = this.balance;

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
                if(this.not_first_open_edit||this.addLeave)
                {
                    this.form.start_date = '';
                    this.form.end_date = '';
                    this.leave_object = [];
                    this.diffDays = null;
                }
                // else
                // {
                //     this.not_first_open_edit = true;
                // }
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

            getBalance(){
                let leave_type = this.form.leave_type;

                let credit = this.findCredit(leave_type);
                this.leave_balance = credit.leave_credit_policy ? credit.leave_credit_policy.balance ? credit.leave_credit_policy.balance : 0: 0;
            },

            editLeave(index){
                this.addLeave           = false;
                this.loading            = false;
                this.method             = 'put';
                this.modalText          = 'Edit Leave';
                this.not_first_open_edit= false;
                this.form_open          = true;

                //GET THE SELECTED RECORD DATA
                let record = this.records;
                    record = record[index];

                //GET THE LEAVES DATES
                let leaveDate   = record.leaves_dates;
                
                let dates = [];
                if(leaveDate){
                    for(let x in leaveDate){
                        dates.push(leaveDate[x].date);
                    }
                }

                let start_date = new Date(record.start_date);
                    start_date = start_date.toISOString();

                let end_date = new Date(record.end_date);
                    end_date = end_date.toISOString();
                
                this.currentDate = dates;


                //ASSIGN VALUES TO FORM
                this.form = {
                    id                      : record.id,
                    employee                : record.user_id,
                    leave_type              : record.leave_type,
                    dates                   : dates,
                    credit                  : record.credit,
                    other                   : record.other,
                    reason                  : record.reason,
                    leave_duration          : record.leave_duration,
                    start_date              : start_date,
                    end_date                : end_date,
                    approver_id             : this.approver.user_id,
                    approver_name           : this.approver.first_name + " " + this.approver.last_name,
                    approver_secondary_id   : this.approver.secondary_user_id
                }

                // VALIDATE THE DATES IN THE FORM
                this.validateDate();

                //TRANSER RECORDS OF LEAVE DATES 
                this.leave_object = [];     

                //TRANSER RECORDS OF LEAVE DATES 
                this.leave_object = [];                
                for(x in leaveDate){
                    this.leave_object[x]                =leaveDate[x];
                    this.leave_object[x].leave_credit   =leaveDate[x].credit;
                    this.leave_object[x].leave_duration =leaveDate[x].leave_duration.toString();
                    this.leave_object[x].date_is_filed  =leaveDate[x].date_is_filed? true:false;
                    this.leave_object[x].with_pay       =leaveDate[x].credit=="1"? true:false;
                    this.leave_object[x].whole_day_paid =leaveDate[x].leave_duration == "0" || leaveDate[x].credit=="2"?true:false;
                }

                //SORT this.leave_object by date
                this.leave_object.sort((a,b)=>{
                    return new Date(a.date) - new Date(b.date);
                });

                this.checkCredit();
                this.modal = true;
            },

            changeStatus(){
                this.not_first_open_edit = true;
            },

            getLeaveCredit(credit){
                result = ""
                credit = credit.split(",")
                if(credit.every( (val, i, arr) => val === arr[0] )) {
                    if(credit.includes("1")) {
                        result = "With Pay"
                    } else {
                        result = "Without Pay"
                    }
                } else {
                    result = "Combination"
                }

                return result;
            },

            initForm(){
                let url = base_url + 'forms/leave/init-form';
                axios.post(url).then(response => {
                    let policy = response.data.policy;
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
                });
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
                let REST = base_url + 'forms/leave/fetch';
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
