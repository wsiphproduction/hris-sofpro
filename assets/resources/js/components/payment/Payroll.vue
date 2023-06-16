<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Create New',
                param: {
                    limit: 25,
                    page: 1
                },
                counts: 0,
                records: [],
                fetching: true,
            }
        },

        components: {
            
        },

        mounted(){
            this.fetchRecord();
        },

        mixins: [
            Form,
            Alert
        ],

        computed: {},

        watch: {},

        methods: {

            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.form = {
                    period: '',
                }
                this.modalText = 'Upload';
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
                    limit: 50,
                    page: 1
                }
                this.fetchRecord();
            },

            fetchRecord(){
                this.fetching = true;
                this.records = [];
                let form_data = {
                    limit: this.param.limit,
                    page: this.param.page,
                }
                let REST = base_url + 'payment/payroll/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

        }

    }

</script>