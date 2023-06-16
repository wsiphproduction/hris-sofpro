<script>
    let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                records: [],
                fetching: true,
                currentMonth: this.initPeriod(),
                monthYear: ''
			}
		},

        computed: {
            month_year(){
                return this.monthYear;
            },
        },

        watch: {
            month_year(){
                this.fetchRecord();
            },
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

            initPeriod(){
                return parseInt(moment(new Date()).format('YYYY-MM'));
            },

            fetchRecord(){
                let monthYear = this.monthYear;
                    monthYear = monthYear ? moment(monthYear.from).format('YYYY-MM') : moment().format('YYYY-MM');
                this.fetching = true;
                let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
                
                let REST = base_url + 'employee/attendance/record/fetch';
                let request = {
                    date: monthYear,
                    shortid: shortid
                }
                axios.post(REST, request).then(response => {
                    //this.records = response.data.records;
                    let grace_period = response.data.config.shift && response.data.config.shift.grace_period ? response.data.config.shift.grace_period +1 : 0;  // Consider seconds after minute grace period
                    this.records = response.data.records;
                    this.fetching = false;
                });
            }

		}

	}

</script>