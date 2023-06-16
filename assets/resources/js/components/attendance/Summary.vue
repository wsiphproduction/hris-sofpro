<script>
	module.exports = {
		
		data: function(){
 
			return{
                showBiometricLogModal: false,
                biometricLog: [],
				companies: [],
				departments: [],
                sections:[],
                divisions:[],
				jobs: [],
                users: [],
				selectedMonth: '',
				param: {
                    year: moment().format('YYYY'),
                    month: moment().format('MM'),
                    user: '',
					company: '',
                    division: '',
					department: '',
                    section: '',
					job_title: '',
					limit: 25,
					page: 1,
                    absenteeism: '',
                    start: '',
                    end: '',
                    key: '',
                    filter: 2,
                    month_date: '',
                    period: 'A',
				},
                minDate: '',
				dateArray: [],
				periodDate: '',
				tableStyle: '',
				records: [],
                session: [],
				counts: 0,
				fetching: true,
                keyword: null,
                showResult: false,
				config: '',
                employeeSearched: '',
                key: '',
                firstLoad: true,
                exportDTR: false,
                retain_param: true,
                searchLogs:{},
			}
		},
        mixins:[
            Alert
        ],
		components: {
            
        },

        computed: {
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
			year(){
                return this.param.year;
            },

            month(){
                return this.param.month;
            },

        	company(){
                return this.param.company;
            },

            division(){
                return this.param.division;
            },


            department(){
                return this.param.department;
            },

            section(){
                return this.param.section;
            },


            absenteeism(){
                return this.param.absenteeism;
            },

            month_date(){
                return this.param.month_date;
            },

            period(){
                return this.param.period;
            },

            limit(){
                this.param.page = 1;
                return this.param.limit;
            },

            employeeSelect(){
                
            },
        },

        watch:{
            start(){
                this.minDate = this.param.start;
                this.param.end = '';
                this.validate();
            },

            end(){
                this.validate();
            },

        	year(){
                this.fetchRecord();
            },

            month(){
                this.fetchRecord();
            },

            period(){
                this.fetchRecord();
            },

            company(){
                this.fetchRecord();
            },

            division(){
                this.fetchRecord();
            },

            department(){
                this.fetchRecord();
            },

            section(){
                this.fetchRecord();
            },

            absenteeism(){
                this.fetchRecord();
            },

            month_date(){
                this.fetchRecord();
            },
            period(){
                this.fetchRecord();
            },

            limit(){
                this.fetchRecord();
            },

            employeeSelect(){
                
            },

        },

        created() {
            window.addEventListener('beforeunload', this.changeLink);
        },
        mounted(){
        	this.initForm();
            this.searchEmployeeLog();
            this.fetchRecord();
        },

        methods: {
            fetchBiometricLogs(userID){
                let form_data = {
                    year: this.param.year,
                    month: this.param.month,
                    company: this.param.company,
                    division: this.param.division,
                    department: this.param.department,
                    section: this.param.section,
                    designation: this.param.job_title,
                    absenteeism: this.param.absenteeism,
                    limit: this.param.limit,
                    page: this.param.page,
                    start: this.param.start,
                    end: this.param.end,
                    key: this.key,
                    month_date: this.param.month_date,
                    period: this.param.period,
                    filter: this.param.filter,
                    userID: userID
                }
                let REST = base_url + 'attendance/dtr-management/biometric-logs/fetch';

                axios.post(REST, form_data)
                .then(res => {
                    if (res.status === 200){
                        this.showBiometricLogModal = true;
                        this.biometric_log = res.data.biometric_log;
                    }
                })
            },

            changeLink: function(){
                if(this.searchLogs){
                    window.open(window.location.pathname,"_self");
                    // window.location = window.location.pathname;
                }
            },
            searchEmployeeLog(){
                let url = new URL(window.location.href);
                let employee_number = url.searchParams.get("employee_number");
                let dtr_date = url.searchParams.get("dtr_date");

                if(employee_number){    
                    this.searchLogs = {
                        employee_number:employee_number,
                        dtr_date:dtr_date
                    };

                    this.key     = employee_number;
                    this.keyword = employee_number;
                }
            },
            addAttendance(shift_id){
        		this.fetching = true;
				let REST = base_url +'attendance/dtr-management/add-attendance';

        		axios.post(REST, {shift_id: shift_id}).then(response => {
        			this.fetching = false;
					let message = "Adding Actual time in and time out to the selected data"; 
					this.showSuccessAlert(message);
				});
            },
            shiftInOut(row, type){
                let isOvertime = row.overtime;
                if(row.shift_id){
                    if(type == 'in'){
                        // return row.shift && row.shift.check_in ? moment(row.shift.date).format('MM/DD/YYYY')+' '+moment(row.shift.check_in).utc().format('hh:mmA') :'--';
                        if (row.shift && row.shift.check_in && row.shift.shift_type && row.shift.type_of_shift.is_from_previous == "1"){
                            let prevDate = moment(row.shift.date).subtract(1,'days').format('MM/DD/YYYY');
                            return row.shift && row.shift.check_in ? moment(prevDate).format('MM/DD/YYYY')+' '+moment(row.shift.check_in).utc().format('hh:mmA')  :'--';
                        } else {
                            return row.shift && row.shift.check_in ? moment(row.shift.date).format('MM/DD/YYYY')+' '+moment(row.shift.check_in).utc().format('hh:mmA') :'--';
                        }
                    }else{
                        if (row.shift && row.shift.check_in && row.shift.shift_type && row.shift.type_of_shift.is_from_previous == "1"){
                            return row.shift && row.shift.check_in && row.shift.check_out ?moment(row.shift.date).format('MM/DD/YYYY')+' '+moment(row.shift.check_out).utc().format('hh:mmA'):'--';
                        } else {
                            return row.shift && row.shift.check_in && row.shift.check_out ? this.getDate(row.shift.date, row.shift.check_in, row.shift.check_out):'--';
                        }
                        //return row.shift && row.shift.check_in && row.shift.check_out ? this.getDate(row.shift.date, row.shift.check_in, row.shift.check_out):'--';
                    }
                }else if(!row.shift_id && row.overtime_id){
                    if(type == 'in'){
                        return row.overtime && row.overtime.start_time ? moment(row.overtime.start_date).format('MM/DD/YYYY')+' '+moment(row.overtime.start_time).utc().format('hh:mmA') :'--';
                    }else{
                        return row.overtime && row.overtime.start_time && row.overtime.end_time ? this.getDate(row.overtime.start_date, row.overtime.start_time, row.overtime.end_time):'--';
                    }
                } else if(row.shift.shift_type === "RESTDAY") {
                    return row.shift.shift_type
                }
            },

            actualCheckIn(row){
                let result = '--';
                if(row.shift && row.shift.actual_check_in){
                    let date = row.shift.date;
                    let prevDate = moment(date).subtract(1,'days').format('MM/DD/YYYY');
                    let check_in = row.shift.check_in ? date +' '+moment(row.shift.check_in).utc().format('HH:mm:ss') : null;
                    let actual_check_in = row.shift.actual_check_in ? date +' '+moment(row.shift.actual_check_in).utc().format('HH:mm:ss') : null;

                    if (row.shift.shift_type && row.shift.type_of_shift.is_from_previous == '1'){
                        check_in = row.shift.check_in ? prevDate +' '+moment(row.shift.check_in).utc().format('HH:mm:ss') : null;
                        actual_check_in = row.shift.actual_check_in ? prevDate +' '+moment(row.shift.actual_check_in).utc().format('HH:mm:ss') : null;
                        result = moment(actual_check_in).format('MM/DD/YYYY hh:mmA');
                    }
                    else
                    {    
                        let chINDiff = moment(check_in).diff(moment(actual_check_in), 'hours');
                        result = actual_check_in < check_in && chINDiff > 4 ? moment(actual_check_in).add(1,'days').format('MM/DD/YYYY hh:mmA') : moment(actual_check_in).format('MM/DD/YYYY hh:mmA');
                    }

                }else if(row.overtime && row.overtime.actual_check_in){
                    let date = row.overtime.start_date;
                    let check_in = row.overtime.start_time ? date +' '+moment(row.overtime.start_time).utc().format('HH:mm:ss') : null;
                    let actual_check_in = row.overtime.actual_check_in ? date +' '+moment(row.overtime.actual_check_in).utc().format('HH:mm:ss') : null;

                    let chINDiff = moment(check_in).diff(moment(actual_check_in), 'hours');
                    result = actual_check_in < check_in && chINDiff > 4 ? moment(actual_check_in).add(1,'days').format('MM/DD/YYYY hh:mmA') : moment(actual_check_in).format('MM/DD/YYYY hh:mmA');
                }
                return result;
                // \ tss.shift && tss.shift.actual_check_in ? moment(tss.shift.date).format('MM/DD/YYYY')+' '+moment(tss.shift.actual_check_in).utc().format('hh:mmA') :'--'
            },

            actualCheckOut(row){
                let result = '--';
                let date = null;
                let timein = null;
                let timeout = null;

                

                if(row.shift && row.shift.actual_check_out){

                    let date = row.shift.date;
                    let prevDate = moment(date).subtract(1,'days').format('MM/DD/YYYY');
                    let time_in = moment(row.shift.check_in).utc().format('HH:mm:ss');
                    let time_out = moment(row.shift.actual_check_out).utc().format('HH:mm:ss');
                    let startDate = date +' '+ time_in;
                    let endDate = date +' '+ time_out;

                    if(isNaN(Date.parse(startDate))){  
                        let actual_in = moment.utc(row.shift.actual_check_in).format("HH:mm:ss");
                        let actual_out = moment.utc(row.shift.actual_check_out).format("HH:mm:ss");
                        if(actual_in > actual_out){
                            result = moment(endDate).add(1,'days').format('MM/DD/YYYY hh:mmA');
                        }else{
                            result = moment(endDate).format('MM/DD/YYYY hh:mmA');
                        }
                        return result ? result : '--';   
                    }else{
                        if (row.shift.shift_type && row.shift.type_of_shift.is_from_previous == '1'){
                        startDate = prevDate +' '+ time_in;
                        }
                        let result = moment(endDate).format('MM/DD/YYYY hh:mmA');
                        
                        if(startDate > endDate){
                            result = moment(endDate).add(1,'days').format('MM/DD/YYYY hh:mmA');
                        }
                        return result ? result : '--';
                    }

                }else if(row.overtime && row.overtime.actual_check_out){
                    let date = row.overtime.start_date;
                    let time_in = moment(row.overtime.actual_check_in).utc().format('HH:mm:ss');
                    let time_out = moment(row.overtime.actual_check_out).utc().format('HH:mm:ss');
                    let startDate = date +' '+ time_in;
                    let endDate = date +' '+ time_out;
                    let result = moment(endDate).format('MM/DD/YYYY hh:mmA');
                    if(startDate > endDate){
                        result = moment(endDate).add(1,'days').format('MM/DD/YYYY hh:mmA');
                    }
                    return result ? result : '--';
                }else{
                    return '--';
                }
            },

            getDate(date, timein, timeout){
                let time_in = moment(timein).utc().format('HH:mm:ss');
                let time_out = moment(timeout).utc().format('HH:mm:ss');
                let startDate = date +' '+ time_in;
                let endDate = date +' '+ time_out;
                let result = moment(endDate).format('MM/DD/YYYY hh:mmA');
                if(startDate > endDate){
                    result = moment(endDate).add(1,'days').format('MM/DD/YYYY hh:mmA');
                }
                return timein ? result : '--';
            },

            getLeave(first_name,tss){
                let leave = 0;
                if(tss.Leave01 && tss.Leave01 > 0){
                    leave += parseInt(tss.Leave01);
                }
                if(tss.Leave02 && tss.Leave02 > 0){
                    leave += parseInt(tss.Leave02);
                }
                if(tss.Leave03 && tss.Leave03 > 0){
                    leave += parseInt(tss.Leave03);
                }
                if(tss.Leave04 && tss.Leave04 > 0){
                    leave += parseInt(tss.Leave04);
                }
                if(tss.Leave05 && tss.Leave05 > 0){
                    leave += parseInt(tss.Leave05);
                }
                if(leave){
                    console.log(first_name,leave);
                }
                return leave;
            },

            getTotal(records, column){
                let numOr0 = n => isNaN(n) ? 0 : n
                let total = 0
                
                if(records.tss.length > 0) {
                    total = records.tss.map(i=>i[column]).reduce((a,b)=>numOr0(a)+numOr0(b));
                }
                
                return total ? total : 0;
            },

            OTHoliday(OTHrs09=null,OTHrs10=null){
                let OT1 = OTHrs09;
                    OT1 = OT1 ? parseInt(OT1) : 0;
                let OT2 = OTHrs10;
                    OT2 = OT2 ? parseInt(OT2) : 0;
                return OT1 + OT2;
            },

            exportRecords(){
                if((this.isMissingFields() && !this.firstLoad) && this.param.filter == 1) {
                    this.showErrorAlert(this.message);
                } else {
                    this.exportDTR = true;
                    this.form = {
                        year: this.param.year,
                        month: this.param.month,
                        company: this.param.company,
                        division: this.param.division,
                        department: this.param.department,
                        section: this.param.section,
                        designation: this.param.job_title,
                        absenteeism: this.param.absenteeism,
                        limit: this.param.limit,
                        page: this.param.page,
                        start: this.param.start,
                        end: this.param.end,
                        key: this.key,
                        month_date: this.param.month_date,
                        period: this.param.period,
                        filter: this.param.filter,
                    }

                }
            },

            closeExport(){
                this.exportDTR = false;
            },

            selectEmployee(employee){
                this.keyword = employee;
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
                            this.key = null
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
                    // let url = base_url + 'employee/search';

                    // axios.post(url, {key: keyword}).then(response => {
                    //     let record = response.data.records;
                    //     this.searchResult = record;
                    //     this.showResult = true;
                    // });
                    this.key = keyword
                    this.fetchRecord();
                }else{
                    this.showResult = false;
                }
            },
            
        	validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

        	reset(){
                this.param = {
                    company: '',
                    division: '',
					department: '',
                    section: '',
					job_title: '',
                    absenteeism: '',
                    month_date: new Date(),
                    period: 'A',
					limit: 25,
					page: 1
                }
                this.fetchRecord();
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

        	fetchRecord(){
                if((this.isMissingFields() && !this.firstLoad) && this.param.filter == 1) {
                    this.showErrorAlert(this.message);
                    this.keyword = '';
                    return;
                } else {
                    //this.param.filter = 2;
                    this.records = [];
                    this.fetching = true;
                    let form_data = {
                        year: this.param.year,
                        month: this.param.month,
                        company: this.param.company,
                        division: this.param.division,
                        department: this.param.department,
                        section: this.param.section,
                        designation: this.param.job_title,
                        absenteeism: this.param.absenteeism,
                        limit: this.param.limit,
                        page: this.param.page,
                        start: this.param.start,
                        end: this.param.end,
                        key: this.key,
                        month_date: this.param.month_date,
                        period: this.param.period,
                        filter: this.param.filter,
                    }

                    let REST = base_url + 'attendance/dtr-management/fetch';
                    axios.post(REST, form_data).then(response => {
                        this.records = response.data.records;
                        this.counts = response.data.count;
                        this.session = response.data.session;
                        this.fetching = false;
                        this.firstLoad = false;
                        if(this.searchLogs.employee_number&&!location.hash){
                            let url = location.href;               
                            location.href = url + "#searched";                 
                            history.replaceState(null,null,url);
                        }
                    });
                }
        	},

            isMissingFields(){
                let result = false;
                let message = "Please provide ";
                if((this.param.start == "") && (this.param.end == "")) {
                    this.message = message + "Start and End Date First.";
                    result = true;
                } else if (this.param.start == "") {
                    this.message = message + "Start Date First.";
                    result = true;
                } else if (this.param.end == "") {
                    this.message = message + "End Date First.";
                    result = true;
                }
                return result;
            },
            
            reprocessRecord(user_id, target_date,shift_id = null){
        		this.fetching = true;
				let REST = base_url +'attendance/dtr-management/reprocess';
        		axios.post(REST, {user_id: user_id, target_date: target_date, shift_id:shift_id}).then(response => {
        			this.fetching = false;
					
					//let message = "Re-processing selected Data." 
					this.showSuccessAlert(response.data.msg);
				});
            },

            initForm(){
        		
				let url = base_url + 'employee/init-form';

                axios.post(url).then(response =>{
                    let companies = [];
                    let nationalities = [];
                    let departments = [];

                    let company = response.data.companies;
                    let nationality = response.data.nationalities;
                    let department = response.data.departments;
                    let teams = response.data.teams;

                    this.companies = response.data.companies;
                    this.locations = response.data.locations;
                    this.divisions = response.data.divisions;
                    this.departments = response.data.departments;
                    this.sections = response.data.sections;
                    
                    this.session = response.data.session;
                    
                    

                    if(this.session != null){
                        this.param.month_date = new Date(this.session.user.default_month_date);
                        this.param.period = this.session.user.default_period
                    } else {
                        this.param.month_date = new Date();
                        this.param.period = 'A'
                    }

                    if(company.length){
                        for(let key in company){
                            companies.push({
                                text: company[key]['company'],
                                //text: company[key]['company']['name'] +' - '+ company[key]['location'],
                                value: company[key]['id']
                            });
                        }
                    }

                    if(nationality.length){
                        for(let key in nationality){
                            nationalities.push({
                                text: nationality[key]['name'],
                                value: nationality[key]['id']
                            });
                        }
                    }
                    
                    if(department.length){
                        for(let key in department){
                            departments.push({
                                text: department[key]['title'],
                                value: department[key]['id']
                            });
                        }
                    }

                    this.init = {
                        nationalities: nationalities,
                        companies: companies,
                        departments: departments,
                        teams: teams
                    }
                    this.init.departments = response.data.departments;
                    this.init.sections = response.data.sections;
                    this.positions = response.data.positions;

                    /**/
                    this.fetchRecord();
                }).catch(error =>{

                });

        	},
		}
	}

</script>