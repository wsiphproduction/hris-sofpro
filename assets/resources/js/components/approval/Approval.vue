<script>
    module.exports = {
        data: function(){
            return{
                allSelected: false,
                modal: false,
                param: {
                    employee: '',
                    start: '',
                    end: '',
                    status: '',
                    type: '',
                    limit: 25,
                    page: 1,
                    key: '',
                },
                counts: 0,
                minDate: '',
                records: [],
                checkbox: [],
                initStatus: '',
                disabled: true,
                reportUrl: null,
                appId: '',
                events: [],
                isCalendar: false,
                date: null,
                currentUser: null,
                currentName: '',
                appName: '',
                approvers: '',
                fetching: true,
                param_user: [],
                exportLinkCL: '',
                exportLinkCS: '',
                exportLinkDP: '',
                exportLinkLV: '',
                exportLinkOT: '',
                exportLinkUT: '',
                exportLinkBT: '',
                keyword: '',
                key: '',
                isHRGeneralist: '',
                isManager: '',
                confirmAlertSource: '',
                config: null,
                session: null,
                isFirstLoad: true,
                view_leave_details: false,
                modalText: '',
                leave_object:[],
                policy:[],
                leave_details:[],
            }
        },

        mixins: [
            Alert,
            EventCalendar,
        ],

        computed:{
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
            employee(){
                return this.param.employee;
            },
            status(){
                return this.param.status;
            },
            type(){
                return this.param.type;
            },
            limit(){
                return this.param.limit;
            }
        },

        watch:{
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
            employee(){
                this.fetchRecord();
            },
            status(){
                this.fetchRecord();
            },
            type(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
        },

        mounted(){
            this.initForm();
            this.fetchRecord();
        },

        methods: {
            export_link_bt(){
                let URL = base_url +'approvals/business-trip/export';
                let params = this.param;
                this.exportLinkBT = URL +'?'+ new URLSearchParams(params).toString();
            },
            export_link_cl(){
                let URL = base_url +'approvals/change-log/export';
                let params = this.param;
                this.exportLinkCL = URL +'?'+ new URLSearchParams(params).toString();
            },
            export_link_cs(){
                let URL = base_url +'approvals/change-shift/export';
                let params = this.param;
                this.exportLinkCS = URL +'?'+ new URLSearchParams(params).toString();
            },
            export_link_dp(){
                let URL = base_url +'approvals/dispute/export';
                let params = this.param;
                this.exportLinkDP = URL +'?'+ new URLSearchParams(params).toString();
            },
            export_link_lv(){
                let URL = base_url +'approvals/leave/export';
                let params = this.param;
                this.exportLinkLV = URL +'?'+ new URLSearchParams(params).toString();
            },
            export_link_ot(){
                let URL = base_url +'approvals/overtime/export';
                let params = this.param;
                this.exportLinkOT = URL +'?'+ new URLSearchParams(params).toString();
            },
            export_link_ut(){
                let URL = base_url +'approvals/undertime/export';
                let params = this.param;
                this.exportLinkUT = URL +'?'+ new URLSearchParams(params).toString();
            },
            userType(primary, backup){
                let string = '';
                if(primary == this.appId && backup == this.appId){
                    string = 'primary';
                }else{
                    if(primary == this.appId){
                        string = 'primary';
                    }else{
                        string = 'backup';
                    }
                }
                return string;
            },

            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            // toggleSelect(id){
            //     alert();
            //     if (this.checkbox.includes(id)) {
            //         this.checkbox.splice(this.checkbox.findIndex(v => v === id), 1);
            //     } else {
            //         this.checkbox.push(id);
            //     }
            // },

            isUserHRGeneralist(){
                let result = true
                if (this.isHRGeneralist) {
                    result = false
                }

                return result
            },

            isUserManager(){
                let result = false
                if (this.isManager) {
                    result = true
                }

                return result
            },

            cancel(id, path){
				this.showConfirmAlert('Are you sure you want to cancel this item?');
				this.cancel_id = id;
				this.cancel_path = path;
                this.confirmAlertSource = 'cancel'
			},

            setStatus(status){ 
                this.initStatus = status;
                this.confirmAlertSource = "status"
                
                if(status=='approve'){
                    this.showConfirmAlert('Are you sure you want to approve all the selected item?');
                }else{
                    this.showConfirmAlert('Are you sure you want to decline the selected item?');
                }
            },

            Confirm(){
                if(this.confirmAlertSource == 'status') {
                    let data = {
                        status: this.initStatus,
                        checkbox: this.checkbox,
                    }
                    let url = window.location.origin + window.location.pathname;
                    
                    axios.put(url, data).then(response => {
                        this.alert = {};
                        this.checkbox=[];
                        this.fetchRecord();
                    })
                } else if (this.confirmAlertSource == 'cancel'){
                    let id = this.cancel_id;
                    let path = this.cancel_path;
                    let REST = base_url + path;
                    
                    // this.alert = {};
                    axios.post(REST, {id: id}).then(response => {
                        let action = response.data.action;
                        if(action == 'close'){
                            window.location = window.location;
                        }else{
                            this.alert.confirm = '';
                            this.fetchRecord();
                        }
                    }).catch(error => {
                        this.showErrorAlert(error.response.data.message);
                    });
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

            selectAll(){
                let records = this.records;
                this.checkbox = [];
                if (!this.allSelected) {
                    for(let record in records){
                        if(records[record]['primary_status'] == 1 || records[record]['backup_status'] == 1){
                            this.checkbox.push(records[record]['id']);
                        }
                    }
                }
            },

            select(){
                this.allSelected = false;
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    employee: '',
                    applicant: '',
                    start: '',
                    end: '',
                    status: '',
                    type: '',
                    limit: 25,
                    page: 1,
                    key: '',
                }
                this.fetchRecord();
            },

            fetchRecord(){
                this.export_link_bt();
                this.export_link_cl();
                this.export_link_cs();
                this.export_link_dp();
                this.export_link_lv();
                this.export_link_ot();
                this.export_link_ut();
                this.records = [];
                this.fetching = true;
                let form_data = {
                    employee: this.param.employee,
                    applicant: this.param.applicant ? this.param.applicant : '',
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    status: this.param.status,
                    type: this.param.type,
                    limit: this.param.limit,
                    key: this.param.key,
                    page: this.param.page
                }
                let REST = new URL(window.location.href);
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.appId = response.data.appId;
                    this.isHRGeneralist = response.data.isHRGeneralist;
                    this.isManager = response.data.isManager;
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
            },

            openCalendar(user_id, name, appName){
                this.currentName = name;
                this.isCalendar = true;
                this.appName = appName;
                this.currentUser = user_id;
            },

            openLeaveDetails(index){
                this.leave_details      = this.records[index];
                this.view_leave_details = true;
                this.modalText          = 'Leave Details';
                this.leave_object       = this.leave_details.leaves_dates;

                //SORT LEAVE OBJECT BY DATE
                this.leave_object.sort((a,b)=>{
                    return new Date(a.date) - new Date(b.date);
                });
                
                //GET USER POLICIES
                this.getUserPolicies(this.leave_details.user_id);
            },    
            closeViewLeaveDetails(){
                this.view_leave_details = false;
                this.modalText          = '';
                this.leave_object       = [];
                this.leave_details      =[];
            },
            
            getUserPolicies(user_id)
            {
                let REST = base_url + 'approvals/getpolicy';
                METHOD = axios.post(REST,{user_id:user_id});

                METHOD.then(response => {
                    let raw_policy  = response.data.policies.filter(obj => obj.leave_credit_policy != null); 
                    if(raw_policy.length){
                        this.policy = raw_policy;
                    }
                    else{
                        this.policy = [];
                    }
                });
            },

            closeCalendar(){
                this.events = [];
                this.isCalendar = false;
            },

            initCalendar(date){
                this.fetchCalendar(date);
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
                let url = base_url+ 'approvals/leave/init';
                axios.post(url).then(response => {
                    this.param_user = response.data.users;
                })
            },

            fetchCalendar(date){
                let user_id = this.currentUser;
                let REST = window.location.href + '/events';
                let request = {
                    user_id: user_id,
                    date: date
                }
                
                axios.post(REST, request).then(response => {
                    let record = response.data.events;
                    let appId = response.data.appId;
                    let events = [];
                    if(record){
                        for(let x in record){
                            let bg = '';
                            let start = moment(record[x]['date']).format('YYYY-MM-DD');
                            let title = ``;

                            if(this.appName == 'shift'){
                                if(record[x]['type'] == 1){
                                    title += moment(record[x]['date'] +' '+ record[x]['check_in']).format('hh:mmA') +'-'+ moment(record[x]['date'] +' '+ record[x]['check_out']).format('hh:mmA');
                                }else if(record[x]['type']==2){
                                    title+= `Flexible`;
                                }else if(record[x]['type']==3){
                                    title += moment(record[x]['date'] +' '+ record[x]['between_start']).format('hh:mmA') +'-'+ moment(record[x]['date'] +' '+ record[x]['between_end']).format('hh:mmA');
                                }
                            }else if(this.appName == 'leave'){

                            }else if(this.appName == 'overtime'){

                            }else if(this.appName == 'undertime'){

                            }else if(this.appName == 'business'){

                            }
                            
                            

                            if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 1) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 1)){
                                bg = 'bg-primary-light';
                            }else if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 2) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 2)){
                                bg = 'bg-success-light';
                            }else if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 3) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 3)){
                                bg = 'bg-warning-light';
                            }else if((record[x]['primary_approver'] == appId && record[x]['primary_status'] == 4) || (record[x]['backup_approver'] == appId && record[x]['backup_status'] == 4)){
                                bg = 'bg-dark';
                            }
                            
                            events.push({
                                title: title,
                                start: start,
                                cssClass: bg+ ' text-white',
                                textEscape: false
                            });
                        }
                    }
                    this.events = events;
                });
            },

            eventClick(event, jsEvent, pos) {
                //console.log(event);
            },

            getDate(date, time){
                return moment(date).format('MM/DD/YYYY') + ' ' + moment(time).utc().format('hh:mmA')
            }
            
        }
    }
</script>