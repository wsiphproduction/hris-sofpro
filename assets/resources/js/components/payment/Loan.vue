<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Create New',
                param: {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                },
                counts: 0,
                minDate: '',
                records: [],
                fetching: true,
                applicant: [],
                years: [],
                previewModal: false,
                preview: {}
            }
        },

        components: {
            
        },

        mounted(){
            this.fetchRecord();
            this.setYears();
        },

        mixins: [
            Form,
            Alert
        ],

        computed: {
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
            status(){
                return this.param.status;
            },
            limit(){
                return this.param.limit;
            }
        },

        watch: {
            start(){
                this.minDate = this.param.start;
                this.param.end = '';
                this.validate();
            },
            end(){
                this.validate();
            },
            status(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
        },

        methods: {
            previewClose(){
                this.preview = {};
                this.previewModal = false;
            },

            setYears(){
                let year = moment().format('Y');
                let obj = [];
                for(let i = year; i >= 2018; i--){
                    obj.push(i);
                }
                this.years = obj;
            },

            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.form = {
                    year: moment().format('YYYY'),
                    month: moment().format('MM'),
                    period: 'A',
                    applicant: '',
                    mode: '',
                    status: '',
                    loan_type: '',
                }
                this.modalText = 'Create New';
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
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
                let record = this.records;
                    record = record[index];
                    
                this.form = {
                    id: record.id,
                    applicant: record.user_id,
                    label: record.label,
                    amount: record.amount,
                    mode: record.mode_of_payment,
                    year: record.year ? record.year : moment().format('YYYY'),
                    month: record.month ? record.month : moment().format('MM'),
                    period: record.period ? record.period : 'A',
                    frequency: record.frequency,
                    loan_type: record.loan_type,
                    status: record.status,
                }
                this.modalText = 'Edit Loan';
                this.modal = true;
                this.loading = false;
            },

            fetchRecord(){
                this.fetching = true;
                this.records = [];
                let form_data = {
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    status: this.param.status,
                    limit: this.param.limit,
                    page: this.param.page
                }
                let REST = base_url + 'payment/loan-advance-payment/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.applicant = response.data.applicant;
                    this.fetching = false;
                });
            }

        }

    }

</script>