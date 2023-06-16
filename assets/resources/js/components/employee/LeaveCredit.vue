<script>
	module.exports = {
		  
		data: function(){

			return{
                modal: false,
                modal_edit: false,
                method: 'put',
                fetching: true,
                param: {
                    user: '',
                    company: '',
                    department: '',
                    section: '',
                    division: '',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                records: [],
                policies: [],
                companies:[],
                departments:[],
                divisions: [],
                sections: [],
                users: [],
                minDate: '',
                user_role: {},
                user_logged_id: {},
                isHRGeneralist: null,
			}
		},

        components: {
            
        },

		mounted(){
            this.fetchRecord();
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
        },

        watch:{
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

            limit(){
                this.fetchRecord();
            },

        },

        methods: {
            openModal(){
                this.loading = false;
                this.modal = true;
                this.firstLoad = true;
            },
            
            closeModal(){
                this.errors = {}
                this.form = {}
                this.modal = false;
                this.modal_edit = false;
                this.loading = false;
            },

            openModalEdit(){
                this.loading = false;
                this.modal_edit = true;
                this.firstLoad = true;
            },
            
            closeModalEdit(){
                this.errors = {}
                this.form = {}
                this.modal_edit = false;
                this.loading = false;
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    company: '',
                    division: '',
                    department: '',
                    section: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            setCredit(array, policy_id){
                let balance = 0;
                let utilized = 0;
                let result = array.find( obj => obj.policy_id === policy_id);
                if(typeof result != 'undefined'){
                    balance = result.balance ? result.balance : 0;
                    utilized = result.utilized ? result.utilized : 0;
                }
                return `
                    <div class="policy-tbl">
                        <div class="td">`+ balance +`</div>
                        <div class="td">`+ utilized +`</div>
                    </div>`;
            },

            totalBalance(credits){
                let total = 0;
                if(credits.length){
                    for(let x in credits){
                        total += credits[x]['balance']
                    }
                }
                return total;
            },

            editLeaveCredit(user_id){
                this.form = {}
                this.method = 'put';
                this.loading = false;
                let API = base_url + 'employee/leave-credit/edit';
                axios.post(API, {user_id: user_id}).then(response => {
                    let policy = response.data.policy;
                    let array = [];
                    if(policy){
                        for(let key in policy){
                            let credit = policy[key]['leave_credit_policy'];
                            array.push({
                                id: credit ? credit.id : null,
                                label: policy[key]['name'],
                                user_id: user_id,
                                policy_id: policy[key]['id'],
                                balance: credit && credit.balance ? credit.balance : '0',
                                utilized: credit && credit.utilized ? credit.utilized : '0',
                            });
                        }
                    }
                    this.form.credit = array;
                    this.modal_edit = true;
                });
            },

            checkHRGeneralist(record, user_role){
                let result = true
                let role_action = null
                
                switch(user_role) {
				    case "modify":
                        role_action = this.user_role.modify
                    case "destroy":
                        role_action = this.user_role.destroy
                    default:
                }

                if (this.isHRGeneralist) {
                    if ((this.user_logged_id == record.hr_generalist_id) && this.user_role.modify){
                        result = false
                    }
                } else {
                    result = !role_action
                }

                return result;
            },

            fetchRecord(){
                this.records = [];
                this.fetching = true;
                let API = base_url + 'employee/leave-credit/fetch';
                axios.post(API, this.param).then(response => {
                    let records = response.data.records;
                    this.policies = response.data.policy;
                    this.records = records;
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
                    this.user_role = response.data.user_role;
                    this.user_logged_id = response.data.user_logged_id;
                    this.isHRGeneralist = response.data.isHRGeneralist;
                });
            }
		}

	}

</script>