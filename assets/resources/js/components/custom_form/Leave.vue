<script>
    module.exports = {
          
        data: function(){

            return{
                policyMax: {},
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
                calendarVal: '',
                minDate: '',
                maxDate: '',
                leave_duration: 0,
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
                minDates: '',
                records: [],
                approver: null,
                policy: [],
                fetching: true,
                step: '0.5',
                readonly: false,
                balance: 30,
                currentDate: [],
                users: [],
                exportLink: '',
                keyword: '',
                key: '',
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
                config: null,
                session: null,
                isFirstLoad: true,
                not_first_open_edit:false,
                addLeave:true,
                form_open:false,
                vacation_leave: [],
                preview:[],
            }
        },

        computed: {
            fcredit(){
                return this.form.credit;
            },
            employee(){
                return this.param.employee;
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
                if(this.form_open)
                {
                    this.getBalance();
                }
            },
        },

        watch: {
            fcredit(){
                //this.form.dates = ""
                this.InitCalendar();
            },
            employee(){
                this.fetchRecord();
            }, 
            cDate(){
                this.updateDate();
            },
            start_date(){
                if(this.not_first_open_edit||this.addLeave){
                    if(this.form.leave_type == 13) {
                        this.max_date_to_file = 105
                    }

                    this.minDate                = this.form.start_date;
                    this.maxDate                = moment(this.form.start_date).add(this.policyMax.leave_credit_policy.balance, 'days').utc().format();
                    this.form.end_date          = '';
                    this.leave_credit_errors    = {};
                    this.leave_duration_errors  = {};
                    this.diffDays               = 0;
                    this.validateDate();
                }
            },
            end_date(){
                if(this.not_first_open_edit||this.addLeave){
                    this.validateDate();
                    if(this.form.leave_type == this.vacation_leave.id)
                    {
                        this.checkIfVLisInRange();
                    }
                }
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
            getVLId(){
                let REST = base_url + 'custom/leave/getvlid';
                axios.post(REST).then(response => {
                    this.vacation_leave = response.data.vl;
                });
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
                let URL = base_url +'custom/leave/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
            },
            onChangeEmployee(event){
                let userID                          = event.target.value;
                let users                           = this.users;
                let obj                             = users.filter(user => user.id == userID)[0];
                this.form.approver_id               = '';
                this.form.approver_name             = '';
                this.form.approver_secondary_id     = '';
				this.form.approver_secondary_name   = '';
                this.form.leave_type                = '';
                if(obj && obj.employments){
                    let employment = obj.employments ? obj.employments[0] : null;
                    if(employment){
                        let organization = employment.approving_organization;
                        if(organization == 'division'){
                            let approver = employment.division;
                            this.form.approver_id = approver.manager_id;
                            this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_manager_id != null ? approver.assistant_manager_id: "";
							this.form.approver_secondary_name = approver.assistant_manager != null ? approver.assistant_manager.first_name+' '+approver.assistant_manager.last_name : "";
                        }else if(organization == 'department'){
                            let approver = employment.department;
                            this.form.approver_id = approver.manager_id;
                            this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_manager_id ? approver.assistant_manager_id : "";
							this.form.approver_secondary_name = approver.assistant_manager != null ? approver.assistant_manager.first_name+' '+approver.assistant_manager.last_name : "";
                        }else if(organization == 'section'){
                            let approver = employment.section;
                            this.form.approver_id = approver.manager_id;
                            this.form.approver_name = approver.manager.first_name+' '+approver.manager.last_name;
							this.form.approver_secondary_id = approver.assistant_supervisor_id != null ? approver.assistant_supervisor_id : "";
							this.form.approver_secondary_name = approver.assistant_supervisor != null ? approver.assistant_supervisor.first_name+' '+approver.assistant_supervisor.last_name : "";
                        }
                    }
                }
                
                this.setPolicy(userID);
            },
            addConvertedJSONtoForm(){
                let newArray = [];
                let b = 0;
                this.checkEmptyData();
                if (!this.form.has_errors) {
                    // this.removeEndDateNotFiled();
                    let stringConverted = JSON.stringify(this.leave_object);
                    const objectWithLeave = this.leave_object.filter(x => parseFloat(x.leave_duration) > -1 && x.date_is_filed === true);
                    for(x in objectWithLeave){
                        b = objectWithLeave[x].leave_duration == "0" ? 1 : 0.5;
                        newArray.push(b);
                    }
                    this.getBalance();
                    const sum = newArray.reduce((a,b) => a+b, 0);
                    if(this.leave_balance >= sum){
                        this.form.leave_object_string_converted = stringConverted;
                    }else{
                        this.file_leave_error = 'Unable to Process. Your leave balance is less than the selected dates';
                    }
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
            create_leave_object(start_date) {
                this.leave_object       = [];
                this.array_with_pay     = [];
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
            //     // FROM CREDIT
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

            //     let leave_with_pay_count            = 0;
            //     let leave_with_pay_duration_count   = 0;
            //     let leave_has_half_day              = false;

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
                // if(this.leave_balance <= 0){
                //     for(x in this.leave_object){
                //         if(obj_with_credit.indexOf(x)==-1){
                //             this.leave_object[x].with_pay       = false;
                //             this.leave_object[x].whole_day_paid = true;
                //             this.leave_object[x].leave_credit   = "2";
                //         }
                //     }
                // }
                if(this.leave_balance > 0 && this.leave_balance < 1){
                    for(x in this.leave_object){
                        if(obj_with_credit.indexOf(x)==-1){
                            this.leave_object[x].with_pay       = true;
                            this.leave_object[x].whole_day_paid = false;
                        }
                    }
                }
            },
            findIfTheFirstFiledDateIsEqualToFirstCredit()
            {
                let result = -1;
                let first_filed_obj = this.leave_object.map(el=>el.date_is_filed).indexOf(true);
                let firstCredit = -1;

                for(x in this.leave_object){
                    if(this.leave_object[x].date_is_filed&&this.leave_object[x].leave_credit!=''&&this.leave_object[x].leave_duration!=''){
                        firstCredit = x;
                        break;
                    }
                    else if(x==first_filed_obj && this.leave_object[x].date_is_filed&&this.leave_object[x].leave_credit!=''){
                        firstCredit = x;
                        break;
                    }
                }

                if(firstCredit == first_filed_obj){
                    result = firstCredit;
                }

                return result;
            },
            findIndexInArrayWithPay(index){
                let find = -1;
                for(x in this.array_with_pay){
                    if(this.array_with_pay[x] == index){
                        find = x;
                    }
                }
                
                return find;
            },

            process_date_filed(index, event){
        		let checked = event.target.checked;
                this.file_leave_error = ''
                this.leave_object[index].leave_credit = ''
                this.leave_object[index].leave_duration = ''
                this.leave_object[index].date_is_filed = checked
                this.process_credit(index);
            },

            setPolicy(userID, leave_type= null){
                let REST = base_url+'custom/leave/get_policy';

                axios.post(REST,{
                    id: userID
                }).then(response =>{
                    let res = response.data.policy.filter(obj => obj.leave_credit_policy != null);

                    let item_order = ["Vacation Leave", "Sick Leave", "Maternity Leave", "Paternity Leave"];
                    res.sort((a, b) => item_order.indexOf(a.name) - item_order.indexOf(b.name));
                    this.policy = res;

                    if(leave_type){
                        this.checkCredit(leave_type);
                    }
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

            validateDate(){
                this.file_leave_error   = ''
                let start_date          = this.form.start_date;
                let end_date            = this.form.end_date;
                let leave_type          = this.form.leave_type;
                
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
                        this.create_leave_object(start_date);
                        this.errors = {};
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
                this.errors             = {};
                this.modal              = false;
                this.loading            = false;
                this.readonly           = false;
                this.leave_object       = [];
                this.diffDays           = 0;
                this.not_first_open_edit= false,
                this.form_open          = false;
                this.policy             = [];
                this.array_with_pay     = [];

                this.form = {
                    dates           :'',
                    leave_type      :'',
                    credit          :'',
                    leave_duration  :'',
                    start_date      :"",
                    end_date        :"",
                    no_of_days      : '',
                };
            },

            openModal(){
                this.currentDate    = [];
                this.policy         = [];
                this.method         = 'post';
                // this.form.approver_id = this.approver ? this.approver.user_id:'';
                // this.form.approver_name = this.approver ? this.approver.first_name+' '+this.approver.last_name:'';
                this.modal          = true;
                this.loading        = false;
                this.readonly       = false;
                this.modalText      = "Create New";
                this.addLeave       = true;
                this.form_open      = true;
            },
            
            checkCredit(leavetype=null){
                let leave_type      = this.form.leave_type ? this.form.leave_type : leavetype;
                let credit          = this.findCredit(leave_type);
                let balance         = credit && typeof credit.leave_credit_policy != 'undefined' ? (credit.leave_credit_policy && credit.leave_credit_policy.balance ? parseFloat(credit.leave_credit_policy.balance) : 0): 0;
                this.balance        = balance ? balance : 0;
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
                this.leave_duration = 0;
                if(this.not_first_open_edit||this.addLeave)
                {
                    this.form.start_date = '';
                    this.form.end_date = '';
                    this.leave_object = [];
                    this.diffDays = null;
                }
                else
                {
                    this.not_first_open_edit = true;
                }
            },

            findCredit(id){
                let arr = this.policy;
                let obj = arr.find(o => o.id == id);
                this.policyMax = obj;
                return obj;
            },

            InitCalendar(){
                // this.calendarVal = '';
                // let leave_type = this.form.leave_type;
                // let credit     = this.form.credit;
                // if(leave_type && credit){
                //     if(credit == 2){
                //         this.disabled = false;
                //         this.numday = 120;
                //     }else if(credit == 1){
                //         let credit = this.findCredit(leave_type);
                //         let balance = credit.leave_credit_policy ? credit.leave_credit_policy.balance ? credit.leave_credit_policy.balance : 0: 0;
                        
                //         this.disabled = false;
                //         this.numday = Math.ceil(balance);
                //     }
                // }else{
                //     this.disabled = true;
                // }
            },

            getBalance(){
                let leave_type = this.form.leave_type;
                let credit = this.findCredit(leave_type);
                this.leave_balance = credit.leave_credit_policy ? credit.leave_credit_policy.balance ? credit.leave_credit_policy.balance : 0: 0;

                // console.log("LEAVE TYPE: " + this.form.leave_type + " - LEAVE BALANCE: " + this.leave_balance + " - DIFF DAYS: " + this.diffDays);
            },

            edit(index){
                this.addLeave           = false;
                this.loading            = false;
                this.method             = 'put';
                this.modalText          = 'Edit Leave';
                this.not_first_open_edit= false;
                this.form_open          = true;
                this.leave_balance      = this.balance;

                //GET THE RECORDS
                let record      = this.records;
                    record      = record[index];
                
                //GET THE LEAVES DATES
                let leaveDate   = record.leaves_dates;
                
                let dates = [];
                if(leaveDate){
                    for(let x in leaveDate){
                        dates.push(leaveDate[x].date);
                    }
                }

                //GET THE START AND END DATES
                let start_date  = new Date(record.start_date);
                    start_date  = start_date.toISOString();

                let end_date    = new Date(record.end_date);
                    end_date    = end_date.toISOString();

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
                    approver_id             : record.primary.id,
                    approver_name           : record.primary.last_name + ", " + record.primary.first_name,
                    approver_secondary_id   : record.backup.id
                }

                // VALIDATE THE DATES IN THE FORM
                this.validateDate();

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

                // this.checkCredit();
                this.setPolicy(record.user_id, record.leave_type);
                this.modal = true;
            },
            changeStatus(){
                this.not_first_open_edit = true;
            },

            initForm(){
                let url = base_url + 'custom/leave/init';
                axios.post(url).then(response => {
                    let policy = response.data.policy;
                    this.users = response.data.users;
                });
            },

            getApprover(){
                let url = base_url + 'settings/approvers/get';
                axios.post(url).then(response =>{
                    this.approver = response.data.approver;
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
                let REST = base_url + 'custom/leave/fetch';
                axios.post(REST, form_data).then(response => {
                    let disableDates = response.data.disableDates;
                    let array = [];
                    if(disableDates){
                        for(let x in disableDates){
                            let res = moment(new Date(disableDates[x]['date'])).format('YYYY.M.D');
                            array.push(res);
                        }
                    }
                    //this.disabledDate = array;
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
