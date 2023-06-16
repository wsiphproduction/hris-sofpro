<script>
    
    module.exports = {
        
        data: function(){

            return{
                modal: false,
                modalText: 'TSS',
                companies: [],
                departments: [],
                sections:[],
                divisions:[],
                records: [],
                users:[],
                session:[],
                counts: '',
                fetching: true,
                minDate: '',
                param: {
                    start: '',
                    end: '',
                    user: '',
                    company: '',
                    department: '',
                    section: '',
                    month_date: new Date(),
                    period: 'A',
                    division: '',
                    limit: 25,
                    page: 1
                },
            }
        },

        computed: {
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
            company(){
                return this.param.company;
            },
            department(){
                return this.param.department;
            },
            division(){
                return this.param.division;
            },
            section(){
                return this.param.section;
            },
            user(){
                return this.param.user;
            },
            limit(){
                return this.param.limit;
            },
            month_date(){
                return this.param.month_date;
            },

            period(){
                return this.param.period;
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
            company(){
                this.fetchRecord();
            },
            department(){
                this.fetchRecord();
            },
            division(){
                this.fetchRecord();
            },
            section(){
                this.fetchRecord();
            },
            user(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
            month_date(){
                this.fetchRecord();
            },
            period(){
                this.fetchRecord();
            },
        },

        mounted(){
            this.fetchRecord();
            this.initForm();
        },
        
        mixins: [
            Form,
            Alert
        ],

        methods: {
            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },
            posting(){
                if(this.records.length > 0) {
                    let REST = base_url + 'attendance/tss';
                    let month_name = moment(this.param.month_date).format('MMMM');
                    let date_year = moment(this.param.month_date).format('YYYY');
                    label = "TSS-" + month_name + "-" + this.param.period + "-" + date_year
                    this.param = {
                        label: label,
                        month_date: this.param.month_date,
                        period: this.param.period
                    }
                    
                    axios.post(REST, this.param).then(response => {
                        if(response.data.success) {
                            this.showSuccessAlert(response.data.msg);
                        } else {
                            this.showErrorAlert(response.data.msg);
                        }
                    });
                } else {
                    this.showErrorAlert("No records to Post");
                }
            },
            openModal(){
                this.form = {}
                this.modal = true;
                this.loading = false;
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
                    division: '',
                    section: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            editTss(index){
                this.method = 'put';
                this.modalText = 'TSS';
                let record = this.records;
                    record = record[index];

                let start_date = new Date(record.start_date);
                    start_date = start_date.toISOString();
                let end_date = new Date(record.end_date);
                    end_date = end_date.toISOString();
                this.form = {
                    id: record.id,
                    label: record.label,
                    start_date: start_date,
                    end_date: end_date,
                }
                    
                this.modal = true;
            },

            fetchRecord(){
                this.records = [];
                this.fetching = true;
                let REST = base_url + 'attendance/tss/fetch';
                axios.post(REST, this.param).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.session = response.data.session;
                    this.fetching = false;
                });
                
            },

            initForm(){
                let REST = base_url + 'attendance/shift-management/initForm';
                axios.post(REST).then(response => {
                    this.companies = response.data.company;
                    this.departments = response.data.department;
                    this.divisions = response.data.division;
                    this.sections = response.data.section;

                    this.users = response.data.user;
                    

                    this.param.month_date = new Date(this.session.user.default_month_date);
                    this.param.period = this.session.user.default_period;
                });
            }
        }
    }

</script>