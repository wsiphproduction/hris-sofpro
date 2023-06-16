 <script>
	
	module.exports = {
		data: function(){
			return{
				modal: false,
				method: 'post',
	            form: {},
	            errors: {},
	            loading: false,
	            modalText: 'Department Detail',
				records: [],
				counts: 0,
				fetching: true,
				divisions:[],
				users:[],
				param: {
                    status: '',
                    limit: 25,
                    page: 1
                },
                isImport: true,
                form_action: '',
                form_attrs:{}
			}
		},

		mixins: [
			Form,
			Alert,
			Archive
		],

		computed:{
			status(){
                return this.param.status;
            },
            limit(){
                return this.param.limit;
            }
		},
		
		watch: {
            status(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
        },

		mounted(){
			this.fetchRecord();
			this.init();
		},

        methods: {
			generateCode(){
				let split_name 	= this.form.department_name.trim().split(" ");
				let aplhabet 	= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
				let list_recs	= this.records;
				let code 		= "";
				let isUnique	= true;

				// CHECK IF THERE ARE MORE THAN 1 WORD
				if(split_name.length>1){
					// get first letter of each word
					for(index in split_name){
						code += split_name[index].substr(0,1).toUpperCase();
					}
				}else{
					// get the first four letters of the word
					code = split_name[0].substr(0,4).toUpperCase();
				}

				// CHECK IF THE CODE ALREADY EXIST
				do{
					isUnique = true;
					for(index in list_recs){
						if(code == list_recs[index].department_code){
							isUnique = false;
							code += aplhabet[Math.floor(Math.random() * aplhabet.length)];
						}
					}
				}while(!isUnique);

				// SET THE CODE TO THE department_code
				this.form.department_code = code;
			},
        	openImport(){
        		this.modalText = 'Import Department';
        		this.isImport = true;
        		this.form_action = base_url+'settings/department/import';
        		this.form_attrs = {}
        		this.form_attrs.enctype = 'multipart/form-data';
        		this.method = 'post';
        		this.form={}
				this.modal = true;
				this.loading = false;
				this.form = {}
				this.form = {
					operation:'',
				}
        	},

        	openModal(){
        		this.form_attrs = {}
        		this.modalText = 'Department Details';
        		this.form_action = base_url+'settings/department';
        		this.isImport = false;
        		this.method = 'post';
				this.modal = true;
				this.loading = false;
				this.form={}
				this.form = {
					division: '',
					department_name: '',
					department_code: '',
					manager:'',
					assistant_manager:'',
					secretary:'',
					alternate_secretary:'',
					description: '',
					status: '1',
				}
        	},

        	closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},

			reset(){
                this.param = {
                    status: '',
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
        		this.fetching = true;
        		let form_data = this.param;
        		let REST = base_url +'settings/department/fetch';
        		axios.post(REST, form_data).then(response => {
        			this.records = response.data.records;
        			this.fetching = false;
                    this.counts = response.data.count;
				});
        	},

        	init(){
        		let REST = base_url +'settings/department/init';
        		axios.post(REST).then(response => {
        			this.divisions = response.data.divisions;
					this.users = response.data.users;
				});
        	},

			edit(index){
				this.form_attrs = {}
				let record = this.records;
					record = record[index];
				this.modalText = 'Department Details';
				this.isImport = false;
				this.form_action = base_url+'settings/department';
				this.form={}
				this.form = {
					id: record.id,
					division: record.division_id,
					department_name: record.department_name,
					department_code: record.department_code,
					manager: record.manager_id,
					assistant_manager: record.assistant_manager_id,
					secretary: record.secretary_id,
					alternate_secretary: record.alternate_secretary,
					hr_generalist: record.hr_generalist_id,
					description: record.description,
					status: record.status,
				}
				this.method = 'put';
				this.modal = true;
				this.loading = false;
				this.errors = {}
			},

		}

	}

</script>