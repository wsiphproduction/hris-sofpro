<script>
	module.exports = {

		data: function(){
			return{
	            form: {},
	            errors: {},
	            loading: false,
				records: [],
				counts: 0,
				param: {
					status: '',
                    limit: 25,
					start: '',
					end: '',
                    page: 1
                },
				session: null,
				config: null,
				fetching: true
			}
		},

		mounted(){
			this.fetchRecord();
		},

		mixins: [
			Form, 
			Alert
		],

		computed:{
            limit(){
                return this.param.limit;
            },
            status(){
                return this.param.status;
            }
		},

		watch: {
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
			status(){
                this.fetchRecord();
            },
        },

		methods: {

            reProcess(id, target_date){
        		this.fetching = true;
				let REST = base_url +'settings/cron-management/process';
        		axios.post(REST, {id: id, target_date: target_date}).then(response => {
        			this.fetching = false;
					
					let message = "Cron Job is being re-process." 
					this.showSuccessAlert(message);
				});
            },

			reCalculate(id, target_date){
        		this.fetching = true;
				let REST = base_url +'settings/cron-management/calculate';
        		axios.post(REST, {id: id, target_date: target_date}).then(response => {
        			this.fetching = false;
					
					let message = "Cron Job is being re-calculated." 
					this.showSuccessAlert(message);
				});
            },

            fetchRecord(){
        		this.fetching = true;
				let form_data = this.param;
        		let REST = base_url +'settings/cron-management/fetch';
        		axios.post(REST, form_data).then(response => {
        			this.records 	= response.data.records;
        			this.fetching 	= false;
					this.counts 	= response.data.count;
					this.session 	= response.data.session;
					this.config 	= response.data.config;
					this.initDateRange();			
				});
        	},

			setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

			reset(){
                this.param = {
					status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

			reprocessOT(){
				this.fetching 	= true;
				let REST  		= base_url + 'settings/cron-management/reprocess-ot';
				let form_data 	= {
					start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
					end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
				}; 
				axios.post(REST,form_data).then(response => {
					this.fetching = false;
					
					let message = response.data.msg; 
					this.showSuccessAlert(message);
				});
			},

			reprocessLeave(){
				this.fetching = true;
				let REST  = base_url + 'settings/cron-management/reprocess-leave';
				let form_data 	= {
					start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
					end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
				}; 
				axios.post(REST,form_data).then(response => {
					this.fetching = false;
					
					let message = response.data.msg; 
					this.showSuccessAlert(message);
				});
			},

			initDateRange(){
				json = this.config.json ? JSON.parse(this.config.json) : null;
                    
				let cutoff = json.cutoff;
				let month_date = null;
				let period = null;
				if (this.session.user) {
					month_date = new Date(this.session.user.default_month_date);
					period = this.session.user.default_period
				} else {
					month_date = new Date();
					period = 'A' 
				}
				month_date = moment(month_date).format('YYYY-MM');
				if (period == 'A') {
					start = month_date + '-' + cutoff.A_from;
					start = moment(new Date(start)).format('YYYY-MM-DD');
					end = month_date + '-' + cutoff.A_to;
					end = moment(new Date(end)).format('YYYY-MM-DD');
					start = start > end ? moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
				} else {
					start = month_date + '-' + cutoff.B_from;
					start = moment(new Date(start)).format('YYYY-MM-DD');
					end = month_date + '-' + cutoff.B_to;
					end = moment(new Date(end)).format('YYYY-MM-DD');
					start = start > end ? moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;
				}

				this.param.start = start;
				this.param.end = end;
			},

		}

	}

</script>