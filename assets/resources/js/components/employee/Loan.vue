<script>
    let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                modal: false,
                modalText: 'Loan Detail',
                form:{
                    mode: '',
                    status: '0'
                },
                records: [],
                fetching: true,
                method: 'post',
                previewModal: false,
                preview:{}
			}
		},

        computed: {
            
        },

        watch: {

        },

		mounted(){
            this.fetchRecord();
		},

		mixins: [
			Form,
			Alert,
            Archive,
            Cover
		],

        methods: {
            previewClose(){
                this.preview = {};
                this.previewModal = false;
            },

            openModal(){
                this.loading = false;
                this.errors = {}
                this.method = 'post';
                this.modal = true;
            },
            
            closeModal(){
                this.loading = false;
                this.errors = {}
                this.modal = false;
            },
            
            info(index){
                let record = this.records;
                    record = record[index];
                record.balance = this.computeBalance(record.loan_payments, record.amount);

                this.preview = record;
                this.previewModal = true;
            },

            computeBalance(array, amount){
                let balance = amount
                let total = 0;
                if(array.length){
                    for(let i in array){
                        let obj = array[i];
                        if(obj.status == 1){
                            total += obj.amount;
                        }
                        
                    }
                }
                balance = parseFloat(balance - total);
                if(balance > 0){
                    balance = balance.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                }else{
                    balance = 0;
                }
                return balance;
            },

            edit(index){

                this.method = 'put';
                this.modal = true;
                let record = this.records;
                    record = record[index];
                
                let date = new Date(record.date_to_pay);
                    date = date.toISOString();
                this.form = {
                    id: record.id,
                    label: record.label,
                    amount: record.amount,
                    mode: record.mode_of_payment,
                    date_to_pay: date,
                    frequency: record.frequency,
                    loan_type: record.loan_type,
                    status: record.status,
                }

            },

            fetchRecord(){
                this.fetching = true;
                let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
                
                let REST = base_url + 'employee/loan/record/fetch';
                axios.post(REST, { shortid:shortid }).then(response => {
                    this.records = response.data.records;
                    this.fetching = false;
                });
            }

		}

	}

</script>