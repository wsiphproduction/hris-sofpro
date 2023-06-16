<script>
	
	module.exports = {

		mixins: [
			Form, 
			Modal, 
			Alert
		],

		mounted(){
			
			this.form = {
				image: '<span>Select Image</span>'
			}

			this.initForm();
		},

        methods: {

        	initForm(){
        		
				this.form.status = '';

				this.status = [
					{
						text: '--Select--',
						value: ''
					},
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

			editCompany(id){
				
				this.method = 'put';

				this.errors = {}

				this.modalText = 'Edit Company';

				let url = base_url +'settings/company/edit';

				axios.post(url, {id: id}).then(response => {

					var logo = '<span>Select Image</span>';
					
					if(response.data.result.logo != ''){
						logo = '<img src="'+ base_url+'uploads/logo/'+response.data.result.logo +'">';
					}

					this.form = {
						id: response.data.result.id,
						name: response.data.result.name,
						code: response.data.result.code,
						description: response.data.result.description,
						status: response.data.result.status,
						image: logo
					}

					this.modal = true;

				}).catch(error => {
					
					if(error.response.status === 404){

						this.showErrorAlert(error.response.data.msg);

					}

				});

			},

			

		}

	}

</script>