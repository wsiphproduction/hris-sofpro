<script>
	
	module.exports = {
		data: function(){
			return{
				modal: false,
				method: 'post',
	            form: {},
	            errors: {},
	            loading: false,
	            modalText: 'Policy Detail.',
				records: [],
				fetching: true
			}
		},

		mixins: [
			Form,
			Alert,
			Archive
		],

		mounted(){
			this.fetchRecord();
		},

        methods: {

        	openModal(){
        		this.method = 'post';
				this.modal = true;
				this.loading = false;
				this.form = {
					code: '',
					company: '',
					department: '',
					gender: '',
					cycle: '12',
					status: '1',
				}
        	},

        	closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},

        	fetchRecord(){
        		this.fetching = true;
        		let REST = base_url +'settings/leave-policy/fetch';
        		axios.post(REST).then(response => {
        			this.records = response.data.records;
        			this.fetching = false;
				});
        	},

			edit(index){
				let record = this.records;
					record = record[index];
				this.form = {
					id: record.id,
					name: record.name,
					code: record.code,
					total: record.total_per_year,
					gender: record.gender,
					probation_validity: record.probation_validity,
					cycle: record.cycle,
					initial: record.initial,
					increment: record.increment,
					max: record.max_increment,
					company: record.company ? record.company : '',
					department: record.department ? record.department : '',
					description: record.description,
					status: record.status,
					carry_over: record.carry_over && record.carry_over == 1 ? 1:0,
				}
				this.method = 'put';
				this.modal = true;
				this.loading = false;
				this.errors = {}
			},

		}

	}

</script>