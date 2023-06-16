<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Create New',
                param: {
                    year: '',
                    month: '',
                    period: '',
                    company: '',
                    department: '',
                    job_title: '',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                records: [],
                fetching: true,
                years: [],
                previewModal: false,
                preview: {},
                companies: [],
                departments: [],
                jobs: [],
                applicant: [],
            }
        },

        components: {
            
        },

        mounted(){
            this.initForm();
            this.fetchRecord();
            this.setYears();
        },

        mixins: [
            Form,
            Alert,
            Archive
        ],

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

        watch: {
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

        methods: {
            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            setYears(){
                let year = moment().format('Y');
                let obj = [];
                for(let i = year; i >= 2018; i--){
                    obj.push(i);
                }
                this.years = obj;
            },

            openModal(){
                this.form = {
                    year: moment().format('YYYY'),
                    month: moment().format('MM'),
                    period: 'A',
                    applicant: '',
                    amount: '',
                    status: '',
                }
                this.modalText = 'Create New';
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            edit(index){
                this.method = 'put';
                let record = this.records;
                    record = record[index];
                    
                this.form = {
                    id: record.id,
                    applicant: record.user_id,
                    amount: record.amount,
                    year: record.year ? record.year : moment().format('YYYY'),
                    month: record.month ? record.month : moment().format('MM'),
                    period: record.period ? record.period : 'A',
                    status: record.status,
                }
                this.modalText = 'Edit';
                this.modal = true;
                this.loading = false;
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

                let REST = base_url + 'payment/adjustment/fetch';
                axios.post(REST, form_data).then(response => {
                    this.applicant = response.data.applicant;
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