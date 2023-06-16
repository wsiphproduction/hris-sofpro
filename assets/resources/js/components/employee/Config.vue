<script>
	let Cover = require('./Cover.vue');
	module.exports = {
		data: function(){
            return {
            	modal: false,
                modalText: 'Biometric Detail',
                records: [],
                sites: [],
                other: {},
				rrooster_break: null,
				rooster_break_options: [],
				shift_types: []
            }
		},

		mixins: [
			Form,
			Alert,
			Archive,
			Cover
		],

		computed: {
            shift_length(){
                return this.form.shift_length;
            },
            start_time(){
                return this.form.start_time;
            },
			break_type(){
				return this.form.break_type;
			},
			rooster_break(){
				return this.form.rooster_break;
			}
        },

        watch: {
            shift_length(){
                this.form.paid_hours = parseInt(this.form.shift_length) - 1;
            },
            start_time(){
                let hours = this.form.shift_length;
                    hours = hours ? hours : 0;
                let date  = this.form.start_time;
               
                if(date){
                    let now = new Date(date);
                        now = now.setHours(now.getHours() + parseInt(hours));
                        now = moment(now).format('YYYY-MM-DD HH:mm:ss');
                        now = new Date(now);
                    this.form.end_time = now.toISOString();
                }
            },
			break_type(){
				if(this.form.break_type == 2) {
					this.form.rooster_break = 4;
					this.form.destination_entitlement = null;
					
					this.rooster_break_options = [ {value:"", text:"Select"} ,
										 		   {value:"4", text:"Weekender"}];
				} else {
					this.form.rooster_break = this.rooster_break;
					this.rooster_break_options = [ {value:"", text:"Select"} ,
										 	  	   {value:"1", text:"3:1"} ,
										 	  	   {value:"2", text:"6:2"} ,
										 	  	   {value:"3", text:"8:2"} ];
					
				}
				if(this.form.break_type == '') {
					this.form.rooster_break = '';
				}
				this.form.method = 3;
			},
        },

        mounted(){
			this.fetchRecord();
		},

		methods: {
			add(){
				this.modalText='Biometric Detail';
				this.form = {}
				this.method = 'post';
				this.loading = false;
				this.modal = true;
				this.errors = {}
				this.form = {
					site: ''
				}
			},

			edit(index){
				this.modalText='Biometric Detail';
				let record = this.records;
					record = record[index];
				this.form = {}
				this.form = {
					id: record.id,
					site: record.biometric_id,
					number: record.biometric_number,
				}
				this.method = 'put';
				this.loading = false;
				this.modal = true;
				this.errors = {}
			},

			closeModal(){
				this.errors = {}
				this.loading = false;
				this.modal = false;
			},

			fetchRecord(){
				this.fetching = true;
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/config/record/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
					let employee= response.data.employee;
                	let user_setting = response.data.user_setting;
                	let workSchedule = response.data.workSchedule;
					this.shift_types = response.data.shift_types;
                	
                	let start_time = workSchedule && workSchedule.check_in ? new Date(workSchedule.effective_date +' '+ workSchedule.check_in): '';
                		start_time = start_time ? start_time.toISOString() : '';
                	let end_time = workSchedule && workSchedule.check_out ? new Date(workSchedule.effective_date +' '+ workSchedule.check_out): '';
                		end_time = end_time ? end_time.toISOString() : '';
                	let between_start = workSchedule && workSchedule.between_start ? new Date(workSchedule.effective_date +' '+ workSchedule.between_start): '';
                		between_start = between_start ? between_start.toISOString() : '';
                	let between_end = workSchedule && workSchedule.between_end ? new Date(workSchedule.effective_date +' '+ workSchedule.between_end): '';
                		between_end = between_end ? between_end.toISOString() : '';
 
                	this.records = response.data.records;
                	this.sites = response.data.sites;
					this.rrooster_break = workSchedule ? workSchedule.rooster_break : '';
                	this.form = {
                		id: user_setting ? user_setting.id : '',
                		user_id: employee.id,
                		holiday: user_setting ? user_setting.has_holiday : '',
                		overtime: user_setting ? user_setting.has_overtime : '',
                		method: user_setting ? user_setting.work_schedule_method : '',
						type: workSchedule ? workSchedule.type : '',
						effective_date: workSchedule ? workSchedule.effective_date : '',
						shift_length: workSchedule ? workSchedule.shift_length : '',
						paid_hours: workSchedule ? workSchedule.paid_hours : '',
						break_type: workSchedule ? workSchedule.break_type : '',
						rooster_break: workSchedule ? workSchedule.rooster_break : '',
						destination_entitlement: workSchedule ? workSchedule.destination_entitlement : '',
						shift_type: workSchedule ? workSchedule.shift_type : '',
						start_time: start_time,
						end_time: end_time,
						between_start: between_start,
						between_end: between_end,
						monday: workSchedule && workSchedule.monday == 1 ? true :false,
						tuesday: workSchedule && workSchedule.tuesday == 1 ? true :false,
						wednesday: workSchedule && workSchedule.wednesday == 1 ? true :false,
						thursday: workSchedule && workSchedule.thursday == 1 ? true :false,
						friday: workSchedule && workSchedule.friday == 1 ? true :false,
						saturday: workSchedule && workSchedule.saturday == 1 ? true :false,
						sunday: workSchedule && workSchedule.sunday == 1 ? true :false,
                	}
                    this.fetching = false;
                });
			}
		}
	}
</script>