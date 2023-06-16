<script>
    
    module.exports = {
        
        data: function(){

            return{
                modal: false,
                modalText: 'Import Leaves',
                companies: [],
                departments: [],
                sections:[],
                divisions:[],
                users:[],
                jobs: [],
                records: [],
                counts: '',
                fetching: true,
                minDate: '',
                param: {
                    start: '',
                    end: '',
                    user: '',
                    company: '',
                    department: '',
                    division: '',
                    section: '',
                    limit: 25,
                    page: 1,
                    key: '',
                },
                keyword: '',
                key: '',
                exportLink: '',
                isHRGeneralist: '',
            }
        },
        mixins: [
            Form,
            Alert
        ],
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
            limit(){
                return this.param.limit;
            },
            user(){
                return this.param.user;
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
            division(){
                this.fetchRecord();
            },
            section(){
                this.fetchRecord();
            },
            user(){
                this.fetchRecord();
            },
            department(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            }
        },

        mounted(){
            this.fetchRecord();
            this.initForm();
        },

        methods: {
            export_link(){
                let URL = base_url +'attendance/leave-management/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
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
            
            selectEmployee(employee){
                this.keyword = employee;
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
                    key: '',
                    page: 1
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
                this.export_link();
                this.records = [];
                this.fetching = true;
                let REST = base_url + 'attendance/leave-management/fetch';
                axios.post(REST, this.param).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.isHRGeneralist = response.data.isHRGeneralist;
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