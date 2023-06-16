<script>
	
	module.exports = {
		
		data: function(){

			return{
                companies: [],
                departments: [],
                jobs: [],
				records: [],
                users:[],
                counts: '',
				fetching: true,
                minDate: '',
                firstLoad: true,
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
				},
                sections: '',
                divisions: '',
                keyword: '',
                key: '',
                approvers: '',
                exportUndertime: false,
                importUndertime: false,
                isHRGeneralist: '',
			}
		},
        mixins:[
            Form,
            Alert,
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

            period(){
                return this.param.period;
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

            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },

            employeeSelect(){
            },

        },

        mounted(){
        	this.initForm();

            this.fetchRecord();

        },
        
 

        methods: {
            closeImport(){
                this.errors = {}
                this.loading = false;
                this.importUndertime = false;
            },

            openImport(){
                this.loading = false;
                this.importUndertime = true;
                this.firstLoad = true;
            },

            closeExport(){
                this.exportUndertime = false;
            },

            openExport(){
                if(this.isMissingFields() && !this.firstLoad) {
                    this.showErrorAlert(this.message);
                } else {
                    this.exportUndertime = true;
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
                        period: this.param.period,
                        start: this.param.start,
                        end: this.param.end,
                        key: this.key
                    }

                }
            },

            selectEmployee(employee){
                this.keyword = employee;
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

            find(){
                let keyword = this.keyword.trim();
                let length = keyword.length;
                this.searchResult = [];
                
                if(length >= 2 || length == 0){ 
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
            
            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    start: '',
                    end: '',
                    company: '',
                    department: '',
                    limit: 25,
                    page: 1,
                    key: '',
                }
                this.keyword = '';
                this.fetchRecord();
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

            isUserHRGeneralist(){
                let result = true
                if (this.isHRGeneralist) {
                    result = false
                }

                return result
            },

        	fetchRecord(){
                // if(this.isMissingFields() && !this.firstLoad) {
                //     this.showErrorAlert(this.message);
                //     this.keyword = '';
                //     this.fetching = false;
                //     return;
                // } else {
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
                        period: this.param.period,
                        start: this.param.start,
                        end: this.param.end,
                        key: this.key
                    }
                    this.records = [];
                    this.fetching = true;

                    let REST = base_url + 'attendance/undertime/fetch';
                    axios.post(REST, form_data).then(response => {
                        this.records = response.data.records;
                        this.counts = response.data.count;
                        this.approvers = response.data.approvers;
                        this.isHRGeneralist = response.data.isHRGeneralist;
                        this.fetching = false;
                        this.firstLoad = false;
                    });
                //}
        	},

            initForm(){
                let REST = base_url + 'employee/init-form';
                axios.post(REST).then(response => {
                    this.companies = response.data.companies;
                    this.divisions = response.data.divisions;
                    this.departments = response.data.departments;
                    this.sections = response.data.sections;
                });
            },

            getApproverName(approverID){
                let approver = "Secretary";
                
                if(approverID != 0) {
                    let approvers = this.approvers.find(x => x.id === approverID);
                    if(approvers) {
                        approver = approvers.first_name + ' ' + approvers.last_name;
                    }
                }
                return approver
            },

            getDate(date, time){
                return moment(date).utc().format('MM/DD/YYYY') + ' ' + moment(time).utc().format('hh:mmA')
            }


		}
	}

</script>
