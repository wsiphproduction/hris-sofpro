<script>
	let Cover = require('./Cover.vue');
	module.exports = {
		data: function(){
            return {
            	modal: false,
                modalText: '',
                payrollInformation: [],
            }
		},

		mixins: [
			Form,
			Alert,
			Cover
		],

        mounted(){
			this.fetchRecord();
		},

		methods: {
			add(){
				this.method = 'post';
				this.modalText = 'Add Payroll Information';
                this.form = {};
                this.form = {
                    rate_type: '',
                    payee_location: '',
                    payment_type: '',
                    currency_id: 'Peso(Php)',
                    bank_id: '',
                    bank_name: '',
                    bank_acct_number: '',
                    basic_monthly_rate: '',
                    basic_daily_rate: '',
                    e_cola_daily: '',
                    allowance: '',
                    allowance_effective_date: '',
                    incentive: '',
                    incentive_effective_date: '',
                    benefit: '',
                    benefit_effective_date: ''
                };
				this.modal = true;
			},

			edit(index){
				this.method = 'put';
				this.modalText = 'Edit Payroll Information';
                let payrollInfo = this.payrollInformation[index];
                this.form = {};
                this.form = {
                    id: payrollInfo.id,
                    rate_type: payrollInfo.rate_type,
                    payee_location: payrollInfo.payee_location,
                    payment_type: payrollInfo.payment_type,
                    currency_id: payrollInfo.currency_id,
                    bank_id: payrollInfo.bank_id    ,
                    bank_name: payrollInfo.bank_name,
                    bank_acct_number: payrollInfo.bank_acct_number,
                    basic_monthly_rate: payrollInfo.basic_monthly_rate,
                    basic_daily_rate: payrollInfo.basic_daily_rate,
                    e_cola_daily: payrollInfo.e_cola_daily,
                    allowance: payrollInfo.allowance,
                    allowance_effective_date: payrollInfo.allowance_effective_date,
                    incentive: payrollInfo.incentive,
                    incentive_effective_date: payrollInfo.incentive_effective_date,
                    benefit: payrollInfo.benefit,
                    benefit_effective_date: payrollInfo.benefit_effective_date,
                };
				this.modal = true;
			},

			fetchRecord(){
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/payroll-information/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
                	this.payrollInformation = response.data.payrollInformation;
                });
			}
		}
	}
</script>