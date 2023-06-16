<script>
	module.exports = {

		data: function(){
			return{
				companies: {},
				countries: {},
				locations: []
			}
		},

		mounted(){
			this.initForm();
		},

		mixins: [
			Form, 
			Modal, 
			Alert
		],

		methods: {

			initForm(){
				this.form.company = '';
				this.form.status = '';
				this.form.country = '';
				this.form.location = '';
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

				let url = base_url + 'settings/branch/init-form';

				axios.post(url).then(response =>{
					let companies = [];
					let countries = [];
					let company = response.data.companies;
					let country = response.data.countries;        			

					if(company.length){
						for(let key in company){
							companies.push({
								text: company[key]['name'],
								value: company[key]['id']
							});
						}
					}

					if(country.length){
						for(let key in country){
							countries.push({
								text: country[key]['name'],
								value: country[key]['id']
							});
						}
					}
					this.locations = response.data.location;
					this.companies = companies;
					this.countries = countries;

				}).catch(error =>{

				});

			},

			editBranch(id){
				this.method = 'put';
				this.modalText = 'Edit Branch';
				let url = base_url + 'settings/branch/edit';
				axios.post(url, {id: id}).then(response => {
					this.form = {
						id: response.data.record.id,
						company: response.data.record.company_id,
						address: response.data.record.address,
						location: response.data.record.location_id,
						country: response.data.record.country_id,
						description: response.data.record.description,
						status: response.data.record.status
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