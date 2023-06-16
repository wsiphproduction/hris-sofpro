<script>
	
	module.exports = {
		
		data: function(){

			return{
                modal: false,
                modalText: 'Upload CSV',
				records: [],
				fetching: true,
                biometric: []
			}
		},

		mixins: [
            Form,
            Alert
        ],

        computed: {
			period(){
                //return this.param.period;
            },

        },

        watch:{
        	period(){
                //this.fetchRecord();
            },

        },

        mounted(){
            this.fetchRecord();
        },

        methods: {
            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.form = {
                    site: ''
                }
                this.modal = true;
                this.loading = false;
            },

        	fetchRecord(){
        		this.fetching = true;
                let REST = base_url + 'attendance/biometric-integration/fetch';
                axios.post(REST).then(response => {
                    this.biometric = response.data.biometric;
                    this.records = response.data.records;
                    this.fetching = false;
                });
        	},
		}
	}

</script>