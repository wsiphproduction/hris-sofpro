<script>
	module.exports = {
		
		data: function(){
 
			return{
				companies: [],
				departments: [],
                sections:[],
                divisions:[],
				jobs: [],
                users: [],
				selectedMonth: '',
				param: {
                    // year: moment().format('YYYY'),
                    // month: moment().format('MM'),
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
                    key: ''
				},
                minDate: '',
				dateArray: [],
				periodDate: '',
				tableStyle: '',
				records: [],
				counts: 0,
				fetching: true,
                keyword: null,
                showResult: false,
				config: '',
                employeeSearched: '',
                key: '',
                firstLoad: true,
                exportDTR: false,
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


            absenteeism(){
                return this.param.absenteeism;
            },

            limit(){
                this.param.page = 1;
                return this.param.limit;
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
            exportRecords(){
                if(this.isMissingFields() && !this.firstLoad) {
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
                        period: this.param.period,
                        start: this.param.start,
                        end: this.param.end,
                        key: this.key
                    }

                    
                }
            },

            closeExport(){
                this.exportDTR = false;
            },

            selectEmployee(employee){
                this.keyword = employee;
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
                
                if(this.isMissingFields() && !this.firstLoad) {
                    this.showErrorAlert(this.message);
                    this.keyword = '';
                    return;
                } else {
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
                    
                    let REST = base_url + 'attendance/dtr-management/fetch';
                    axios.post(REST, form_data).then(response => {
                        this.records = response.data.records;
                        this.counts = response.data.count;
                        this.fetching = false;
                        this.firstLoad = false;
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
                    
                    this.init.departments = response.data.departments;
                    this.init.sections = response.data.sections;
                    this.positions = response.data.positions;

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
                    /**/
                    this.fetchRecord();
                }).catch(error =>{

                });

        	},
		}
	}

</script>