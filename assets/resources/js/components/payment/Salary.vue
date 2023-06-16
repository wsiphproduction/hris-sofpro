<script>
    
    module.exports = {
        
        data: function(){
            return{
                companies: [],
                departments: [],
                jobs: [],
                selectedMonth: '',
                param: {
                    year: moment().format('YYYY'),
                    month: moment().format('MM'),
                    period: 'A',
                    company: '',
                    department: '',
                    job_title: '',
                    limit: 25,
                    page: 1
                },
                dateArray: [],
                periodDate: '',
                tableStyle: '',
                records: [],
                counts: 0,
                fetching: true,
                config: ''
            }
        },

        components: {
            
        },

        computed: {
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

            department(){
                return this.param.department;
            },

            job_title(){
                return this.param.job_title;
            },

            limit(){
                this.param.page = 1;
                return this.param.limit;
            },
        },

        watch:{
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

            department(){
                this.fetchRecord();
            },

            job_title(){
                this.fetchRecord();
            },

            limit(){
                this.fetchRecord();
            },

        },

        mounted(){
            this.initForm();
            this.fetchRecord();
        },

        methods: {
            
            reset(){
                this.param = {
                    company: '',
                    department: '',
                    job_title: '',
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
                this.records = [];
                this.fetching = true;
                let form_data = {
                    year: this.param.year,
                    month: this.param.month,
                    company: this.param.company,
                    department: this.param.department,
                    designation: this.param.job_title,
                    limit: this.param.limit,
                    page: this.param.page,
                    period: this.param.period,
                }

                let REST = base_url + 'payment/salary/fetch';
                axios.post(REST, form_data).then(response => {
                    //console.log(response.data.records);
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            },

            initForm(){
                let REST = base_url + 'attendance/shift-management/initForm';
                axios.post(REST).then(response => {
                    this.companies = response.data.company;
                    this.departments = response.data.department;
                    this.jobs = response.data.jobs;
                });
            }
        }
    }

</script>