<script>
	
	module.exports = {
		data: function(){
			return{
				modal: false,
				method: 'post',
	            form: {},
	            errors: {},
	            loading: false,
	            modalText: 'Shift Management Detail',
				records: [],
				counts: 0,
				fetching: true,
				companies:[],
				users:[],
				param: {
                    status: '',
                    limit: 25,
                    page: 1
                },
                isImport: true,
                form_action: '',
                form_attrs:{}
			}
		},

		mixins: [
			Form,
			Alert,
			Archive
		],

		computed:{
			status(){
                return this.param.status;
            },
            limit(){
                return this.param.limit;
            }
		},
		
		watch: {
            status(){
                this.fetchRecord();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
        },

		mounted(){
			this.fetchRecord();
			this.init();
		},

        methods: {

            convertTime(time){
                let string = '--';
                console.log(time)
                if(time){
                    string = moment(new Date(time)).utc().format('h:mmA');
                    
                }
                return string;
            },

            convertDateAndTime(dateAndTime){
                let string = '--';
                
                if(dateAndTime){
                    string = moment(new Date(dateAndTime)).utc().format('YYYY-MM-DD h:mmA');
                    
                }
                return string;
            },

            changeIfEmptyString(input){
                let string = '--'

                if(input){
                    string = input;
                }

                return string;
            },

            changeIfEmptyInt(input){
                let int = 0

                if(input){
                    int = input;
                }

                return int;
            },

        	openImport(){
        		this.modalText = 'Import Shift Management';
        		this.isImport = true;
        		this.form_action = base_url+'settings/shift-management/import';
        		this.form_attrs = {}
        		this.form_attrs.enctype = 'multipart/form-data';
        		this.method = 'post';
        		this.form={}
				this.modal = true;
				this.loading = false;
				this.form = {}
				this.form = {
					operation:'',
				}
        	},

        	openModal(){
        		this.form_attrs = {}
        		this.modalText = 'Shift Management Details';
        		this.form_action = base_url+'settings/shift-management';
        		this.isImport = false;
        		this.method = 'post';
				this.modal = true;
				this.loading = false;
				this.form={}
				this.form = {
					shift_id: '',
					shift_desc: '',
					shift_opt: '',
					credit_time_in: '',
					credit_time_out: '',
					time_in: '',
					time_out: '',
					gp: '',
					break_in: '',
					break_out: '',
					num_hours: '',
					cbamin: '',
					cbamout: '',
					cbpmin: '',
					cbpmout: '',
					trig_late: '',
					trig_under: '',
					early_in: '',
					early_out: '',
					late_in: '',
					late_out: '',
					flex_am_break: '',
					flex_pm_break: '',
					flex_break: '',
					min_ot: '',
					hday_by_late: '',
					ot_type: '',
					break_hours: '',
					seq_id: '',
					gp2: '',
					trig_absent: '',
					min_workhours_1h: '',
					min_workhours_2h: '',
					terminal: '',
					is_from_previous: '',
					status: '',
				}
        	},

        	closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},

			reset(){
                this.param = {
                    status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

        	fetchRecord(){
        		this.fetching = true;
        		let form_data = this.param;
        		let REST = base_url +'settings/shift-management/fetch';
        		axios.post(REST, form_data).then(response => {
        			this.records = response.data.records;
        			this.fetching = false;
                    this.counts = response.data.count;
				});
        	},

        	init(){
        		let REST = base_url +'settings/shift-management/init';
        		axios.post(REST).then(response => {
        			this.companies = response.data.companies;
					this.users = response.data.users;
				});
        	},
			
			edit(index){
				this.form_attrs = {}
				let record = this.records;
					record = record[index];
				this.modalText = 'Shift Management Details';
				this.isImport = false;
				this.form_action = base_url+'settings/shift-management';
				this.form={}
				this.form = {
					id: record.id,
					shift_id : record.shift_id,
					shift_desc : record.shift_desc,
					shift_opt : record.shift_opt,
					
					credit_time_in : moment(record.credit_time_in).utc().format('HH:mm:ss'),
					credit_time_out : moment(record.credit_time_out).utc().format('HH:mm:ss'),
					time_in : moment(record.time_in).utc().format('HH:mm:ss'),
					time_out : moment(record.time_out).utc().format('HH:mm:ss'),
					gp : record.gp,

					break_in : moment(record.break_in).utc().format('HH:mm:ss'),
					break_out : moment(record.break_out).utc().format('HH:mm:ss'),

					num_hours : record.num_hours,

					cbamin : moment(record.cbamin).utc().format('HH:mm:ss'),
					cbamout : moment(record.cbamout).utc().format('HH:mm:ss'),
					cbpmin : moment(record.cbpmin).utc().format('HH:mm:ss'),
					cbpmout : moment(record.cbpmout).utc().format('HH:mm:ss'),

					trig_late : moment(record.trig_late).utc().format('HH:mm:ss'),
					trig_under : moment(record.trig_under).utc().format('HH:mm:ss'),
					early_in : moment(record.early_in).utc().format('HH:mm:ss'),
					early_out : moment(record.early_out).utc().format('HH:mm:ss'),
					late_in : moment(record.late_in).utc().format('HH:mm:ss'),
					late_out : moment(record.late_out).utc().format('HH:mm:ss'),

					flex_am_break : record.flex_am_break,
					flex_pm_break : record.flex_pm_break,
					flex_break : record.flex_break,
					min_ot : record.min_ot,
					hday_by_late : record.hday_by_late,
					ot_type : record.ot_type,
					break_hours : record.break_hours,
					seq_id : record.seq_id,
					gp2 : record.gp2,
					trig_absent : record.trig_absent,
					min_workhours_1h : record.min_workhours_1h,
					min_workhours_2h : record.min_workhours_2h,
					terminal : record.created_terminal ? record.created_terminal : record.updated_terminal,
					status : record.status,
					is_from_previous : record.is_from_previous
				}
				this.method = 'put';
				this.modal = true;
				this.loading = false;
				this.errors = {}
			},

		}

	}

</script>