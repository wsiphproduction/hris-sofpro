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
            }
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
            posting(){
                this.form = {}
                this.modal = true;
                this.loading = false;

            },

            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
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
                    month_date: new Date(record.month_year +'-01'),
                    period: record.period,
                }
                    
                this.modal = true;
            },

            fetchRecord(){
                // if(this.param)
                this.records = [];
                this.fetching = true;
                let REST = base_url + 'attendance/tss/fetch/posted';
                axios.post(REST, this.param).then(response => {
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
                    this.divisions = response.data.division;
                    this.sections = response.data.section;

                    this.users = response.data.user;
                });
            }
        }
    }

</script>