<script>
	module.exports = {
		  
		data: function(){

			return{
                fetching: true,
                form:{
                    gender: '',
                    marital_status: '',
                    nationality: '177',
                    company: 1,
                    department: '',
                    job_title: '',
                    user_roles: []
                },
                init:{
                    nationalities: {},
                    companies: {},
                    departments: {},
                    job_titles: {},
                    teams: {},
                    user_role: {},
                    user_logged_id: {},
                },
                exports:{
                    company: '',
                    division: '',
                    department: '',
                    section: '',
                },
                dateFormat:'MM/dd/yyyy',
                inputClass: 'form-control',
                accountModal: false,
                modalText: '',
                accountDetail: false,
                keyword: null,
                showResult: false,
                searchResult: [],
                param: {
                    company:'',
                    location:'',
                    division:'',
                    department:'',
                    section:'',
                    position:'',
                    status:'',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                records: [],
                roleModal: false,
                exportEmployee: false,
                action: 'default',
                setTeam: [],
                setDesignation: [],
                companies:[],
                divisions:[],
                departments:[],
                sections:[],
                positions:[],
                locations:[],
                isHRGeneralist: null
			}
		},

        components: {
            
        },

		mounted(){
			this.initForm();
            
		},

		mixins: [
			Form,
			Alert
		],

        computed:{
            company(){
                return this.param.company;
            },
            location(){
                return this.param.location;
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
            position(){
                return this.param.position;
            },

            status(){
                return this.param.status;
            },

            limit(){
                this.param.page = 1;
                return this.param.limit;
            },

            formStatus(){
                return this.form.status;
            },
        },

        watch:{
            keyUp(){
                
                this.find();
            },

            company(){
                this.fetchRecord();
            },
            location(){
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
            position(){
                this.fetchRecord();
            },

            status(){
                this.fetchRecord();
            },

            formStatus(){
                this.setResignationDate();
            },

            limit(){
                this.fetchRecord();
            },

        },

        methods: {

            setResignationDate(){
                let status = this.form.status;
                let resignation_date = this.form.resignation_date;
                if(status == 3 || status == 4){
                    if(!resignation_date){
                        let date = new Date();
                        this.form.resignation_date = date.toISOString();
                    }
                }else{
                    this.form.resignation_date = '';
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
                            this.showResult = false;
                            this.fetchRecord();
                        }
                    }, 1);
                }
            },

            openAccount(type){
                if(type == 'import'){
                    this.modalText = 'Import';
                    this.action = 'import';
                }else{
                    this.modalText = 'Create New';
                    this.action = 'default';
                }
                this.method = 'post';
                this.accountModal = true;
                this.accountDetail = true;
                this.loading = false;
                this.form = {
                    company: 1,
                    nationality: 177,
                    gender:'',
                    marital_status: ''
                }
            },
            
            closeAccount(){
                this.action = 'default';
                this.loading = false;
                this.accountModal = false;
            },
            

            editAccount(id){
                this.action = 'default';
                this.errors = {}
                this.accountDetail = true;
                this.populateForm(id, 'info');
            },

            exportEmp(){
                this.exportEmployee = true;
            },

            closeExport(){
                this.exportEmployee = false;
            },

            editLogin(id){
                this.action = 'default';
                this.errors = {}
                this.loading = false;
                this.accountDetail = false;
                this.populateForm(id, 'login');
            },

            populateForm(id, type){
                this.method = 'put';

                this.modalText = type == 'info' ? 'Edit account detail' : 'Edit login detail';

                let url = base_url + 'employee/edit';

                axios.post(url, {id: id}).then(response => {
                    let record = response.data.record;
                    this.form = {}
                    
                    if(type == 'info'){
                        let date_entry = '';
                        
                        if(record.date_entry){
                            date_entry = new Date(record.date_entry);
                            date_entry = date_entry.toISOString();
                        }
                        
                        
                        this.form = {
                            id: record.id,
                            emp_id: record.emp_id,
                            type: 'info',
                            old_employee_number: record.old_employee_number,
                            user_type: record.user_type,
                            first_name: record.first_name,
                            middle_name: record.middle_name,
                            last_name: record.last_name,
                            suffix: record.suffix,
                            nick_name: record.nick_name,
                            gender: record.gender,
                            birthday: record.birthdate,
                            marital_status: record.marital_status,
                            email: record.email,
                            team: record.team_id,
                            contact_number: record.contact_number,
                            nationality: record.nationality,
                            current_address: record.present_address,
                            permanent_address: record.permanent_address,
                            sss_number: record.sss_number,
                            pagibig_number: record.pagibig_number,
                            tin_number: record.tin_number,
                            philhealth_number: record.philhealth_number,
                            company: record.company_branch_id,
                            department: record.department_id,
                            job_title: record.job_title_id,
                            start_date: date_entry,
                            
                        }
                    }else{
                        let resignation_date = '';
                        if(record.resignation_date){
                            resignation_date = new Date(record.resignation_date);
                            resignation_date = resignation_date.toISOString();
                        }
                        this.form = {
                            id: record.id,
                            type: 'login',
                            email: record.email,
                            password: '',
                            status: record.status,
                            resignation_date: resignation_date,
                        }
                    }
                    
                    this.accountModal = true;

                }).catch(error => {
                    if(error.response.status === 404){
                        this.showErrorAlert(error.response.data.msg);
                    }
                });
            },

        	initForm(){
        		
				let url = base_url + 'employee/init-form';

                axios.post(url).then(response =>{

                    let companies = [];
                    let nationalities = [];
                    let departments = [];
                    let user_role = {};
                    let user_logged_id = {};
                    let job_titles = [];

                    let company = response.data.companies;
                    let nationality = response.data.nationalities;
                    let department = response.data.departments;
                    let job_title = response.data.job_titles;
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
                            
                    // if(job_title.length){
                    //     for(let key in job_title){
                    //         job_titles.push({
                    //             text: job_title[key]['title'],
                    //             value: job_title[key]['id']
                    //         });
                    //     }
                    // }
                    
                    user_role = response.data.user_role;
                    user_logged_id = response.data.user_logged_id;
                    this.isHRGeneralist = response.data.isHRGeneralist;

                    this.init = {
                        nationalities: nationalities,
                        companies: companies,
                        departments: departments,
                        //job_titles: job_titles,
                        teams: teams,
                        user_role: user_role,
                        user_logged_id: user_logged_id
                    }
                    /**/
                    this.fetchRecord();
                }).catch(error =>{

                });

        	},

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    team: '',
                    department: '',
                    job_title: '',
                    status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            getWorkSchedule(index){
                let string = '';
                let record = this.records;
                    record = record[index];
                let result = record.work_schedule;
                let arr = [];
                if(result){
                    if(result.monday == 1){
                        arr.push('Mon');
                    }
                    if(result.tuesday == 1){
                        arr.push('Tue');
                    }
                    if(result.wednesday == 1){
                        arr.push('Wed');
                    }
                    if(result.thursday == 1){
                        arr.push('Thu');
                    }
                    if(result.friday == 1){
                        arr.push('Fri');
                    }
                    if(result.saturday == 1){
                        arr.push('Sat');
                    }
                    if(result.sunday == 1){
                        arr.push('Sun');
                    }

                    string = arr.join(', ');
                }else{
                    string = '—';
                }
                
                return string;
                
            },

            fetchRecord(){
                this.fetching = true;
                let form_data = this.param;
                let API = base_url + 'employee/get';
                axios.post(API, form_data).then(response => {
                    let records = response.data.records;
                    // console.log(records);
                    this.records = records;
                    this.counts = response.data.count;
                    this.setTeam = response.data.team;
                    this.setDesignation = response.data.designation;
                    this.fetching = false;
                });
            },

            checkHRGeneralist(record, user_role){
                let result = true
                let role_action = null

                switch(user_role) {
				    case "modify":
                        role_action = this.init.user_role.modify
                    case "destroy":
                        role_action = this.init.user_role.destroy
                    default:
                }

                if (this.isHRGeneralist) {
                    if ((this.init.user_logged_id == record.hr_generalist_id) && this.init.user_role.modify){
                        result = false
                    }
                } else {
                    result = !role_action 
                }

                return result;
            },

            editRole(id, userRole){
                let REST = base_url + 'employee/get-role';
                axios.post(REST, {id: id}).then(response =>{
                    let roles = response.data.roles;
                    let user_role = userRole ? userRole.split(',') : [];
                    let array = [];
                    if(roles.length){
                        for(let x in roles){
                            let roleId = roles[x]['id'].toString();
                            array.push({
                                id: roleId,
                                role_id: user_role.includes(roleId),
                                label: roles[x]['label']
                            });
                        }
                    }
                    this.method = 'post';
                    this.form.user_id = id;
                    this.form.user_roles = array;
                    this.roleModal = true;
                });
                
            },

            closeRole(){
                this.roleModal = false;
                this.loading = false;
            },

            updateRole(element) {
                this.startLoading();
                this.errors = {}
                let action = element.target.action;
                let formData = this.form;
                let METHOD = '';
                if(this.method === 'get'){
                    METHOD = axios.get(action, formData);
                }else if(this.method === 'put'){
                    METHOD = axios.put(action, formData);
                }else{
                    METHOD = axios.post(action, formData);
                }

                METHOD.then(response => {
                    if(response.data.action === 'refresh'){
                        window.location = window.location;
                    }else if(response.data.action === 'close'){
                        this.showSuccessAlert(response.data.msg);
                    }else if(response.data.action === 'fetch'){
                        this.showSuccessAlertFetch(response.data.msg);
                    }
                }).catch(error => {
                    let errData = [];
                    if(error.response.status == 422){
                        let errors = error.response.data.errors;
                        for(let key in errors){
                            errData[errors[key].param] = errors[key].msg;
                        }
                    }else{
                        errData['server'] = error.response.statusText;
                    }
                    this.errors = errData;
                    this.stopLoading();
                });
            }

		}

	}

</script>