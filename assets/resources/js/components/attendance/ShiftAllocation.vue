<script>
	
	module.exports = {
		
		data: function(){

			return{
				companies: [],
				departments: [],
                divisions: [],
                sections: [],
				selectedMonth: '',
                users: [],
				param: {
                    company:'',
                    division:'',
                    division:'',
                    department:'',
                    section:'',
                    month_date:'',
                    period: 'A',
                    user: '',
					limit: 25,
                    key: '',
					page: 1
				},
				dateArray: [],
				periodDate: '',
				currentMonth: this.initPeriod(),
				tableStyle: '',
				records: [],
				counts: 0,
				fetching: false,
				config: '',
                years: [],
                modal: false,
                modalText: 'Upload Shift',
                exportLink: '',
                startOf: '',
                endOf: '',
                key: '',
                keyword: '',
                session: [],
                isHRGeneralist: '',
			}
		},

		components: {
            
        },

        mixins: [
            Form,
            Alert
        ],

        computed: {
            company(){
                return this.param.company;
            },
            division(){
                return this.param.division;
            },
            department(){
                return this.param.department;
            },
            section(){
                return this.param.section;
            },
            status(){
                return this.param.status;
            },

            // date(){
            //     return this.param.date;
            // },

            period(){
                return this.param.period;
            },
            
            month_date(){
                return this.param.month_date;
            },
            
            user(){
                return this.param.user;
            },

            limit(){
                this.param.page = 1;
                return this.param.limit;
            },
        },

        watch:{
            company(){
                this.fetchRecord();
            },
            division(){
                this.fetchRecord();
            },
            department(){
                this.fetchRecord();
            },
            section(){
                this.fetchRecord();
            },
            user(){
                this.fetchRecord();
            },

            // date(){
            //     this.fetchRecord();
            // },

            period(){
                this.fetchRecord();
            },
            
            month_date(){
                this.fetchRecord();
            },

            limit(){
                this.fetchRecord();
            },

        },

        mounted(){
        	this.initForm();
            this.fetchRecord();
            this.setYear();
        },

        methods: {

            clear(){
                if(this.keyword) {
                    setTimeout(() => {
                        let keyword = this.keyword.trim();
                        let length = keyword.length;
                        this.searchResult = [];

                        if(length == 0){ 
                            this.param.key = null
                            this.keyword = null
                            this.key = null
                            this.fetchRecord();
                        }
                    }, 1);
                }
            },
            
            find(){
                let keyword = this.keyword.trim();
                let length = keyword.length;
                this.searchResult = [];
                
                if(length >= 2 || length == 0){ 
                    // let url = base_url + 'employee/search';

                    // axios.post(url, {key: keyword}).then(response => {
                    //     let record = response.data.records;
                    //     this.searchResult = record;
                    //     this.showResult = true;
                    // });
                    this.key = keyword
                    this.fetchRecord();
                }else{
                    this.showResult = false;
                }
            },

            export_link(){
                let URL = base_url +'attendance/shift-management/export';
                let params = this.param;
                this.exportLink = URL +'?'+ new URLSearchParams(params).toString();
            },

        	closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.form = {
                }
                this.modal = true;
                this.loading = false;
            },

            setYear(){
                let data = [];
                for(let y = moment().format('YYYY'); y >= 2018; y--){
                    data.push(y);
                }
                this.years = data;
            },

        	initPeriod(){
        		return parseInt(moment(new Date()).format('MM'));
        	},

        	reset(){
                this.param = {
                    company: '',
					department: '',
					job_title: '',
					status: '',
                    period: 'A',
					limit: 25,
					page: 1
                }
                this.fetchRecord();
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },


            isUserHRGeneralist(){
                let result = true
                if (this.isHRGeneralist) {
                    result = false
                }

                return result
            },

        	fetchRecord(){
                if(this.config) {
                    this.fetching = true;
                    
                    cutoffFrom = this.param.period == 'A' ? this.config.cutoff.A_from : this.config.cutoff.B_from
                    cutoffTo = this.param.period == 'A' ? this.config.cutoff.A_to : this.config.cutoff.B_to
                    cutoff = this.config.cutoff
                    let month_date = moment(this.param.month_date).format('YYYY-MM');

                    start = month_date + '-' + cutoffFrom;
                    start = moment(new Date(start)).format('YYYY-MM-DD');
                    end = month_date + '-' + cutoffTo;
                    end = moment(new Date(end)).format('YYYY-MM-DD');
                    start = start > end ? moment(start).subtract(1, 'months').format('YYYY-MM-DD') : start;

                    let dateArray = [];
                    let startOf = new Date(start);
                    let endOf   = new Date(end);
                    
                    this.startOf = new Date(start);
                    this.endOf = new Date(end);

                    for (var d = startOf; d <= endOf; d.setDate(d.getDate() + 1)) {
                        let dd = moment(new Date(d)).format('YYYY-MM-DD')
                        dateArray.push(dd);
                    }

                    this.dateArray = dateArray;

                    // FOR TESTING
                    // console.log(this.month_date);
                    // console.log(this.startOf);
                    // console.log(this.endOf);

                    let form_data = {
                        // period: period,
                        company: this.param.company,
                        division: this.param.division,
                        department: this.param.department,
                        section: this.param.section,
                        // date: date,
                        key: this.key,
                        month_date: this.param.month_date,
                        period: this.param.period,
                        user: this.param.user,
                        limit: this.param.limit,
                        page: this.param.page
                    }
                    
                    this.export_link();
                    let REST = base_url + 'attendance/shift-management/fetch';
                    axios.post(REST, form_data).then(response => {
                        let records = response.data.records;
                        // this.records = this.setRecord(records, date);
                        this.records = this.setRecord(records, this.startOf, this.endOf);
                        this.counts = response.data.count;
                        this.config = response.data.config;
                        this.isHRGeneralist = response.data.isHRGeneralist;
                        this.fetching = false;

                        this.session = response.data.session;
                    });
                } else {
                    return
                }
        	},

        	initForm(){
        		let REST = base_url + 'attendance/shift-management/initForm';
                axios.post(REST).then(response => {
                	this.companies = response.data.company;
                	this.departments = response.data.department;
                    this.divisions = response.data.division;
                    this.sections = response.data.section;
                    this.config = response.data.config;
                    this.session = response.data.session;
                    
                    if(this.session.user){
                        this.param.month_date = new Date(this.session.user.default_month_date);
                        this.param.period = this.session.user.default_period
                    } else {
                        this.param.month_date = new Date();
                        this.param.period = 'A'
                    }
                    this.fetchRecord();
                });
        	},

            setRecord(record, startOf, endOf){
                let records = [];
                // let endDay = moment(date).daysInMonth();
                if(record.length){
                    for(let k in record){
                        let schedule = [];
                        let dayIteration = 0
                        let endDay = Math.round((endOf-startOf)/(1000*60*60*24)) + 1;
                        let lastDayOfMonth = moment(startOf).daysInMonth();
                        let days = moment(startOf).format('DD');
                        let year = moment(startOf).format('YYYY');
                        let month = moment(startOf).format('MM');
                        let start_month = month;
                        let start_year  = year;

                        for(let day = 0; day < endDay; day ++){
                            let newDay = parseInt(days) + parseInt(dayIteration);
                            
                            if (newDay > lastDayOfMonth) {
                                month = moment(startOf).add(1, 'months').format('MM')
                                days = 0
                                dayIteration = 1
                                newDay = 1
                            }
                            if(start_month == '12' && month == '01' && year == start_year){
                                year = moment(year).add(1,'years').format('YYYY');
                            }
                            let date = year +'-'+ month +'-'+ newDay;
                                date = new Date(date);
                                date = moment(date).format('YYYY-MM-DD');
                            let getDate = this.getDate(record[k].shifts, record[k].leaves_dates, record[k].business_trip_dates, date);
                            schedule.push({
                                bg: getDate.bgColor,
                                time: getDate.time,
                                actualTime : getDate.actualTime,
                            });
                            dayIteration++
                        }

                        records.push({
                            shortid: record[k].shortid,
                            first_name: record[k].first_name,
                            last_name: record[k].last_name,
                            schedule: schedule,
                            employee_number: record[k].employee_number,
                        });
                    }
                }
                
                return records;
            },

            getDate(shifts, leaves, business_trips, date){
                
                let obj = shifts.filter( o => o.date == date)[0];
                let leave = leaves.filter( o => o.date == date)[0];
                let business_trip = business_trips.filter( o => o.date == date)[0];
                let data = {
                    actualTime: '-',
                    time: '',
                    bgColor: ''
                }
                
                if(obj && obj.check_in && obj.check_out){
                    data.time = moment(obj.check_in).utc().format('hh:mmA') +'-'+ moment(obj.check_out).utc().format('hh:mmA');
                    data.bgColor = this.setBackground(obj, leave, business_trip);
                }

                if(obj && (obj.actual_check_in || obj.actual_check_out)){
                    let actual_check_in_time = obj.actual_check_in ? moment(obj.actual_check_in).utc().format('hh:mmA') : "NO LOGIN"
                    let actual_check_out_time = obj.actual_check_out ? moment(obj.actual_check_out).utc().format('hh:mmA') : "NO LOGOUT"

                    data.actualTime = actual_check_in_time +'-'+ actual_check_out_time;
                }

                return data;
            },

            setBackground(object, leave = null, business_trip = null){
                let config = this.config;
                let grace_period = config.shift && config.shift.grace_period ? Number(config.shift.grace_period) + 1 : 0;   // Consider the seconds after minutes grace period
                let currentDate = moment().format('YYYY-MM-DD');
                let bgColor = '';
                if(object.date < currentDate){
                    if(!object.actual_check_in && !object.actual_check_out){
                        if(leave) {
                            bgColor = leave.leave && leave.leave.primary_status == 2 ? 'bg-leave' : 'bg-absent';
                        } else if(business_trip) {
                            bgColor = business_trip.business_trip && business_trip.business_trip.primary_status == 2 ? 'bg-perfect' : 'bg-absent';
                        } else {
                            bgColor = 'bg-absent';
                        }
                    }else if((!object.actual_check_in && object.actual_check_out) || (object.actual_check_in && !object.actual_check_out)){
                        bgColor = 'bg-tardy';
                    }else if(object.actual_check_in && object.actual_check_out){
                        //Actual Log based on biometric
                        let actualIn = new Date(object.actual_check_in);
                            actualIn = moment(actualIn).utc().format('HH:mm:ss');
                            actualIn = object.date +' '+ actualIn;
                        let actualOut = new Date(object.actual_check_out);
                            actualOut = moment(actualOut).utc().format('HH:mm:ss');
                            actualOut = object.date +' '+ actualOut;
                            actualOut = actualIn > actualOut ? moment(actualOut).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : actualOut;

                        //Login based on shift plus grace period
                        let shiftIn = new Date(object.check_in);
                            shiftIn = moment(shiftIn).add(grace_period, 'minutes').utc().format('HH:mm:ss');
                            shiftIn = object.date +' '+ shiftIn;
                        let shiftOut = new Date(object.check_out);
                            shiftOut = moment(shiftOut).utc().format('YYYY-MM-DD HH:mm:ss');
                            shiftOut = shiftIn > shiftOut ? moment(shiftOut).add(1,'days').format('YYYY-MM-DD HH:mm:ss') : shiftOut;

                        if((actualIn >= shiftIn) || (actualOut < shiftOut)){
                            bgColor = 'bg-tardy';
                        }else{
                            bgColor = 'bg-perfect';
                        }
                    }
                }
                return bgColor;
            },
		}
	}

</script>