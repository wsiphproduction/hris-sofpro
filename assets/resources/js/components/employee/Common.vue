<script>
	
	let Alert = require('../../mixins/Alert.vue');
    let Cover = require('./Cover.vue');
	module.exports = {
		data: function(){
            return {
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
                modalAvatar: false,
            }
		},
		mixins:[
            EventCalendar,
            Form,
            Alert,
            Cover
        ],
        
		mounted(){
            this.fetch();
        },

        computed:{
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

        watch:{
            start(){
            	this.minDate = this.param.start;
            	this.param.end = '';
            	this.validate();
            },
            end(){
            	this.validate();
            },
            status(){
            	this.fetch();
            },
            limit(){
                this.param.page = 1;
            	this.fetch();
            },
        },

		methods: {
			validate(){
				if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
					this.fetch();
				}
			},

            setPage(page){
                this.param.page = page;
                this.fetch();
            },

			fetch(){
                //this.records = [];
                this.fetching = true;
				let form_data = {
					start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
					end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
					status: this.param.status,
					limit: this.param.limit,
					page: this.param.page
				}
				let API = window.location.origin + window.location.pathname;
				axios.post(API, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
			},
		}
	}
</script>