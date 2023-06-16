<script>
	let Cover = require('./Cover.vue');
	module.exports = {
		data: function(){
            return {
            	modal: false,
                type: '',
                modalText: '',
                salary: [],
				incentive: []
            }
		},

		mixins: [
			Form,
			Alert,
			Cover
		],

		components: {
            
        },

        mounted(){
			this.fetchRecord();
		},

		methods: {
			add(type){
				this.method = 'post';
				this.type = type;
				this.modalText = type == 'salary' ? 'Basic Pay' : 'Allowance';
				if(type == 'salary'){
					this.form = {}
					this.form = {
						type: type,
						mode: ''
					};
				}else{
					this.form = {
						type: type,
						mode: '',
						status: '',
						period: ''
					};
				}
				this.modal = true;
			},

			edit(type, index){
				this.method = 'put';
				this.type = type;
				this.modalText = type == 'salary' ? 'Basic Pay' : 'Allowance';
				if(type == 'salary'){
					let salary = this.salary;
						salary = salary[index];
					let start_date = salary.start_date ? new Date(salary.start_date).toISOString() : '';
					let end_date = salary.end_date ? new Date(salary.end_date).toISOString() : '';
					this.form = {}
					this.form = {
						id: salary.id,
						type: type,
						from: start_date,
						to: end_date,
						basic_pay: salary.amount,
						mode: salary.mode,
					}
				}else{
					let incentive = this.incentive;
						incentive = index != null ? incentive[index] : null;
					let start_date = incentive.from ? new Date(incentive.from).toISOString() : '';
					let end_date = incentive.to ? new Date(incentive.to).toISOString() : '';
					this.form = {}
					this.form = {
						id: incentive.id,
						type: type,
						from: start_date,
						to: end_date,
						amount: incentive.amount,
						mode: incentive.mode,
						label: incentive.label,
						period: incentive.period,
						status: incentive.status,
					}
				}
				this.modal = true;
			},

			closeModal(){
				this.errors = {}
				this.loading = null;
				this.modal = false;
			},

			fetchRecord(){
				this.incentive = [];
				this.salary = [];
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/salary/record/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
                	this.salary = response.data.salary;
                	this.incentive = response.data.incentive;
                });
			}
		}
	}
</script>