<script>
	
	module.exports = {
		data: function(){
			return{
				modal: false,
				method: 'post',
	            form: {},
	            errors: {},
	            loading: false,
	            modalText: 'Create New',
				records: [],
				fetching: true
			}
		},

		mixins: [
			Form,
			Alert
		],

		mounted(){
			this.fetchRecord();
		},

        methods: {

        	openModal(){
        		this.method = 'post';
				this.modal = true;
				this.loading = false;
				this.form.status = '1'
        	},

        	closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},

        	fetchRecord(){
        		this.fetching = true;
        		let REST = base_url +'settings/user-role/fetch';
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
					label: record.label,
					status: record.status
				}
				this.method = 'put';
				this.errors = {}
				this.modalText = 'Edit Record';
				this.modal = true;
				/*
				let REST = base_url +'settings/user-role/edit';
				axios.post(REST, {id: id}).then(response => {
					let record = response.data.record; 
					this.form = {
						id: record.id,
						label: record.label,
						status: record.status
					}
					this.modal = true;
				});
				*/
			},

		}

	}

</script>