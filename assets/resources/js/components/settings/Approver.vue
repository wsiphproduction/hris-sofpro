<script>
	module.exports = {

	data: function(){

		return{
			disabled: true,
			isEdit: false,
			modal: false,
			modalText: 'Create New',
			init: {
				companies: {},
				departments: {},
				users: {},
			},
			form: {
				company: '',
				department: '',
				primary_approver: '',
				backup_approver: ''
			},
			records: [],
			fetching: true
		}
	},

	mounted(){
		this.initForm();
		this.fetchRecord();
	},

	mixins: [
		Form,
		Alert
	],

	methods: {

		closeModal(){
			this.errors = {}
			this.form = {
				company: '',
				department: '',
				primary_approver: '',
				backup_approver: ''
			}
			this.modal = false;
			this.loading = false;
		},


		openModal(){
			this.isEdit = false;
			this.method = 'post';
			this.modal = true;
			this.loading = false;
		},

		fetchRecord(){
  			this.fetching = true;
    		let REST = base_url +'settings/approvers/fetch';
    		axios.post(REST).then(response => {
    			this.records = response.data.records;
    			this.fetching = false;
			});
		},

		initForm(){

			let url = base_url + 'settings/approvers/init-form';

			axios.post(url).then(response => {

				let companies = [];
				let departments = [];
				let users = []

				let company = response.data.companies;
				let department = response.data.departments;
				let user = response.data.users;      			

				if(company.length){
					for(let key in company){
						companies.push({
							text: company[key]['company'] +'—'+ company[key]['location'],
							value: company[key]['id']
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

				if(user.length){
					for(let key in user){
						users.push({
							text: user[key]['first_name'] +' '+ user[key]['last_name'],
							value: user[key]['id']
						});
					}
				}

				this.init.companies = companies;
				this.init.departments = departments;
				this.init.users = users;

			}).catch(error =>{

			});

		},

		validateData(){

			if(this.form.company !='' && this.form.department != ''){

				let data = {
					company: this.form.company,
					department: this.form.department
				}
				let url = base_url + 'settings/approvers/validate';

				axios.post(url, data).then(response => {

					if(response.data.count == 0){
						this.disabled = false;
					}else{
						alert('Company and Department already registered.');
						this.disabled = true;
					}

				}).catch(error => {
					this.showErrorAlert(error.response.data.msg);
					this.disabled = true;
				});

			}else{
				this.disabled = true;
			}
		},

		editApprover(id){
			this.isEdit = true;
			this.disabled = false;
			this.method = 'put';
			this.modalText = 'Edit Approver';

			let url = base_url + 'settings/approvers/edit';

			axios.post(url, {id: id}).then(response => {
				let record = response.data.record;
				this.form = {
					id: record.id,
					company: record.branch.company.name +' -- '+ record.branch.location,
					department: record.department.title,
					primary_approver: record.primary_approver_id ? record.primary_approver_id : '',
					backup_approver: record.backup_approver_id ? record.backup_approver_id : ''
				}

				this.modal = true;

				}).catch(error => {
					if(error.response.status === 404){
						this.showErrorAlert(error.response.data.msg);
					}
				});
			}

		},

		// fetchRecord(){
  
  //   	},

	}

</script>