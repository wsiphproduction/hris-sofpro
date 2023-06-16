<script>
	
	module.exports = {
		data: function(){
			return {
				modal: false,
				modalText: 'Create New',
				disabled: false
			}
		},

		mixins: [
			Form, 
			Alert,
			Archive
		],

		mounted(){
			this.initForm();
		},

		methods: {
			closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},


			openModal(){
				this.disabled = false;
				this.form.status = '1';
				this.method = 'post';
				this.modal = true;
				this.loading = false;
			},

			initForm(){
				
				this.form.status = '';
				this.form.parent = 0;

				this.status = [
					{
						text: 'Active',
						value: 1
					},
					{
						text: 'Inactive',
						value: 2
					},
				];
			},

			// remove(id){
			// 	let url = base_url + 'settings/taxonomy/remove';

			// 	console.log(id);
			// },

			edit(id){

				this.method = 'put';

				this.modalText = 'Edit job title';

				let url = base_url + 'settings/taxonomy/edit';

				axios.post(url, {id: id}).then(response => {
					
					this.form = {
						parent: response.data.record.parent_id,
						title: response.data.record.title,
						code: response.data.record.code,
						description: response.data.record.description,
						status: response.data.record.status,
						id: response.data.record.id
					}
					if(response.data.record.system_role == 0){
						this.disabled = false;
					}else{
						this.disabled = true;
					}
					this.modal = true;

				}).catch(error => {
					if(error.response.status === 404){
						this.showErrorAlert(error.response.data.msg);
					}
				});

			}

		}

	}

</script>