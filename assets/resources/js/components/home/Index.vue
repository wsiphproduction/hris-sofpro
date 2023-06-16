<script>

    module.exports = {
        data: function(){
            return{
                eventArray: [],
                eventData: {},
                number_of_records: 0,
                count_records_team_logs: 0,
                datenow: '',
                schedule: [],
                users: [],
                logMonitors: [],
                calendar:{},
                sessionUserId: '',
                calendarEvents: [],
                date: null,
                toast: '',
                isFirstLogin: true,
                complete_shift: true,
                series: [
                        {
                            name: 'Overtime',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        },{
                            name: 'Shifts',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        }, {
                            name: 'Rest Day',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        }
                ],
                chartOptions: {
                    plotOptions: {
                        bar: {
                            horizontal: false,
                            columnWidth: '55%',
                            endingShape: 'rounded'    
                        },
                    },
                    dataLabels: {
                        enabled: false
                    },
                    stroke: {
                        show: true,
                        width: 2,
                        colors: ['transparent']
                    },

                    xaxis: {
                        categories: ['Jan','Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct','Nov','Dec'],
                    },
                    yaxis: {
                        title: {
                            text: '(hours)'
                        }
                    },
                    fill: {
                        opacity: 1

                    },
                    tooltip: {
                        y: {
                            formatter: function (val) {
                                return "" + val + " hours"
                            }
                        }
                    },
                    minDate: '',
                    form: {
                        type: ''
                    },
                    
                },
                form: {
                    month_date: new Date(),
                    period: 'A',
				},
                isSupervisor: false,
                session: [],
                overtime: null,
                pending_leaves: null,
                pending_overtime: null,
                pending_undertime: null,
                pending_business_trip: null,
                pending_dispute: null,
                pending_change_shift: null,
                pending_change_logs: null,
                approvalMonitors: [],
                approval_month_date: null,
                approval_period: null,
                isApprover: false,
                log_data: null,
            }
        },
        components: {
            apexchart: VueApexCharts
        },

        mixins: [
            Form,
            Alert,
            Modal,
            Archive
        ],

        mounted(){
            this.fetchRecord();
            this.interval = setInterval(this.time, 1000);
            this.fetchHoliday();
        },

        beforeDestroy(){
            clearInterval(this.interval);
        },

        computed: {
            start_date(){
                return this.form.date;
            },
            period(){
                return this.form.period;
            },
            
            month_date(){
                return this.form.month_date;
            },
        },

        watch: {
            start_date(){
                this.form.end_date = this.form.date;
            },
            period(){
                this.fetchRecord();
            },
            
            month_date(){
                this.fetchRecord();
            },
        },

        methods: {
            
            incrementCounter(){
                this.count_records_team_logs++;
            },
            closeModal(){
                this.errors = {}
                this.isFirstLogin = false;
                this.loading = false;
            },
            setLog(event){
                let REST = base_url + 'home/set-log';
                let title = event == 'timein' ? 'Timein':'Timeout';
                let toast = `<div class="toast-list shadow-sm">
                        <div class="toast-header">
                            <strong class="mr-auto">Message</strong>
                            <small>Now</small>
                            <!--<button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>-->
                        </div>
                        <div class="toast-body">
                            Congratulations: `+ title +` has been successfully created!
                        </div>
                    </div>`;

                axios.post(REST, { event: event}).then(response => {
                    this.toast = toast;
                    this.fetchRecord();
                    setTimeout(()=>{
                       this.toast = '';
                    },5000);
                }); 
            },

            initCalendar(date){
                this.date = moment(date).format('YYYY-MM-DD');
                this.fetchHoliday();
            },

            eventClick(event, jsEvent, pos) {
                
                // console.log(event);
                this.eventData = {}
                this.eventData.type = event.eventType ? event.eventType : '';
                if(event.eventType == 'event'){
                    let events = this.eventArray;
                    let result = events.find(obj => obj.id == event.eventID);
                    if(typeof result != 'undefined'){
                        this.eventData.id = result.id;
                        this.eventData.etype = result.type;
                        this.eventData.date = moment(result.date).format('llll');
                        this.eventData.note = result.comment;
                    }
                }
                if(event.modal == 'show'){
                    $('#eventModal').modal('show');
                }
            },

            editEvent(){
                let result = this.eventData;
                this.loading = false;
                this.method = 'put';
                this.modalText = 'Edit Events';

                let currentDate = moment().format('YYYY-MM-DD HH:mm:ss');
                let cutoff = moment().format('YYYY-MM-DD') + ' 12:00:00';
                let minDate = null;
                if(currentDate >= cutoff){
                    minDate = moment().format('YYYY-MM-DD') + ' 00:00:00';
                }else{
                    minDate = moment().subtract(1,'d').format('YYYY-MM-DD') + ' 00:00:00';
                }
                minDate = new Date(minDate);
                this.minDate = minDate.toISOString();
                let date = new Date(result.date);
                    date = date.toISOString();

                let start_date = result.start_date ? new Date(result.start_date) : new Date(result.date);
                    start_date = start_date.toISOString();

                this.form = {
                    id: result.id,
                    date: date,
                    start_date: start_date,
                    type: result.etype,
                    note: result.note,
                }
                this.modal = true;
                $('#eventModal').modal('hide');
            },

            deleteEvent(){
                let result = this.eventData;
                let ans = confirm('Are you sure you want to delete this item?');
                if(ans){
                    $('#eventModal').modal('hide');
                    let REST = base_url + 'home/delete';
                    let reqData = {
                        id: result.id
                    }
                    axios.post(REST, reqData).then(response => {
                        let action = response.data.action;
                        if(action == 'close'){
                            window.location = window.location;
                        }else{
                            this.alert.confirm = '';
                            this.fetchHoliday();
                        }
                    }).catch(error => {
                        this.showErrorAlert(error.response.data.message);
                    });
                }
            },

            time() {
                let now = moment();
                let day = moment().format('ddd').toUpperCase();
                let hms = now.format('hh:mm:ss'); 
                let am = now.format('A');
                let date = now.format('LL');
                let week_name = 'MON TUE WED THU FRI SAT SUN';
                    week_name = week_name.split(' ');
                    //console.log(week_name);
                let weekdays = '';
                for(let x in week_name){
                    let active = day == week_name[x] ? ' class="active"':'';
                    weekdays += '<span'+active+'>'+ week_name[x] +'</span>';
                }
                let string = `
                    <div class="display shadow-sm">
                        <div class="weekdays">
                            `+ weekdays +`
                        </div>
                        <div class="digits">
                            <span class="time">
                                `+ hms +`
                                <span>`+ am +`</span>
                            </span>
                        </div>
                        <div class="date">`+ date +`</div>
                    </div>
                `;
                this.datenow = string;
            },

            fetchRecord(){
                let REST = base_url + 'fetch';
                axios.post(REST).then(response => {
                    this.schedule = response.data.schedule;
                    this.users = response.data.users;
                    this.number_of_records = response.data.number_of_records;

                    this.pending_leaves = response.data.pending_leaves;
                    this.pending_overtime = response.data.pending_overtime;
                    this.pending_undertime = response.data.pending_undertime;
                    this.pending_business_trip = response.data.pending_business_trip;
                    this.pending_dispute = response.data.pending_dispute;
                    this.pending_change_shift = response.data.pending_change_shift;
                    this.pending_change_logs = response.data.pending_change_logs;
                    this.log_data = response.data.log_data;
                    
                    this.session = response.data.session;

                    this.isApprover = response.data.isApprover;

                    if(this.session.user){
                        this.approval_month_date = new Date(this.session.user.default_month_date);
                        this.approval_period = this.session.user.default_period
                    }
                    
                    // RESET RECORD COUNTER
                    let record_counter = 0;
                    const num_records  = this.number_of_records;

                    if (this.pending_leaves && this.pending_leaves.length && record_counter < num_records){
                        for(let i in this.pending_leaves){
                            let userLog = this.pending_leaves[i].applicant;
                            let start_date = this.pending_leaves[i].start_date ? moment(this.pending_leaves[i].start_date).format('YYYY-MM-DD') : ' ';
                            let end_date = this.pending_leaves[i].end_date ? moment(this.pending_leaves[i].end_date).format('YYYY-MM-DD') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: start_date + ' - ' + end_date,
                                time: '--',
                                request_type: 'Leave',
                                request_type_page: '/approvals/leave'
                            };
        
                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    if (this.pending_overtime && this.pending_overtime.length && record_counter < num_records){
                        for(let i in this.pending_overtime){
                            let userLog = this.pending_overtime[i].applicant;
                            let start_date = this.pending_overtime[i].start_date ? moment(this.pending_overtime[i].start_date).format('YYYY-MM-DD') : ' ';
                            let end_date = this.pending_overtime[i].end_date ? moment(this.pending_overtime[i].end_date).format('YYYY-MM-DD') : ' ';
                            let start_time = this.pending_overtime[i].start_time ? moment(this.pending_overtime[i].start_time).format('hh:mmA') : ' ';
                            let end_time = this.pending_overtime[i].end_time ? moment(this.pending_overtime[i].end_time).format('hh:mmA') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: start_date + ' - ' + end_date,
                                time: start_time + ' - ' + end_time,
                                request_type: 'Overtime',
                                request_type_page: '/approvals/overtime'
                            };

                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    if (this.pending_undertime && this.pending_undertime.length && record_counter < num_records){
                        for(let i in this.pending_undertime){
                            let userLog = this.pending_undertime[i].applicant;
                            let date = this.pending_undertime[i].date ? moment(this.pending_undertime[i].date).format('YYYY-MM-DD') : ' ';
                            let time = this.pending_undertime[i].time ? moment(this.pending_undertime[i].time).format('hh:mmA') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: date,
                                time: time,
                                request_type: 'Undertime',
                                request_type_page: '/approvals/undertime'
                            };

                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    if (this.pending_business_trip && this.pending_business_trip.length && record_counter < num_records){
                        for(let i in this.pending_business_trip){
                            let userLog = this.pending_business_trip[i].applicant;
                            let start_date = this.pending_business_trip[i].date_start ? moment(this.pending_business_trip[i].date_start).format('YYYY-MM-DD') : ' ';
                            let end_date = this.pending_business_trip[i].date_end ? moment(this.pending_business_trip[i].date_end).format('YYYY-MM-DD') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: start_date + ' - ' + end_date,
                                time: '--',
                                request_type: 'Business Trip',
                                request_type_page: '/approvals/business-trip'
                            };

                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    if (this.pending_dispute && this.pending_dispute.length && record_counter < num_records){
                        for(let i in this.pending_dispute){
                            let userLog = this.pending_dispute[i].applicant;
                            let date = this.pending_dispute[i].date ? moment(this.pending_dispute[i].date).format('YYYY-MM-DD') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: date,
                                time: '--',
                                request_type: 'Dispute',
                                request_type_page: '/approvals/dispute'
                            };

                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    if (this.pending_change_shift && this.pending_change_shift.length && record_counter < num_records){
                        for(let i in this.pending_change_shift){
                            let userLog = this.pending_change_shift[i].applicant;
                            let date = this.pending_change_shift[i].date ? moment(this.pending_change_shift[i].date).format('YYYY-MM-DD') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: date,
                                time: '--',
                                request_type: 'Change Shift',
                                request_type_page: '/approvals/change-shift'
                            };

                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    if (this.pending_change_logs && this.pending_change_logs.length && record_counter < num_records){
                        for(let i in this.pending_change_logs){
                            let userLog = this.pending_change_logs[i].applicant;
                            let date = this.pending_change_logs[i].log_date ? moment(this.pending_change_logs[i].log_date).format('YYYY-MM-DD') : ' ';
                            
                            let monLogInfo = {
                                employee_number: userLog.employee_number ? userLog.employee_number : '--',
                                employee_name: userLog.last_name+', '+userLog.first_name,
                                date: date,
                                time: '--',
                                request_type: 'Change Log',
                                request_type_page: '/approvals/change-log'
                            };

                            this.approvalMonitors.push(monLogInfo);
                            record_counter ++;
                        }
                    }

                    this.approvalMonitors.sort((a, b) => (a.date > b.date) ? 1 : -1);

                    // Compute data for Log Issue Monitoring (exclude date today)
                    // (1) No time in or time out
                    // (2) Mismatch shift - difference of time/in is more than 6 hours
                    // (3) Problematic logs - regular hours negative value
                    
                    // RESET RECORD COUNTER
                    record_counter = 0;
                    if (this.users && this.users.length){
                        for(let i in this.users){
                            if(record_counter < num_records)
                            {
                                let userLog = this.users[i];
                                for(let j in userLog.tss_data){
                                    let tss =  userLog.tss_data[j];
                                    let monLogInfo = {
                                        employee_number: '--',
                                        employee_name: userLog.last_name+', '+userLog.first_name,
                                        dtr_date: '',
                                        shift_type: '',
                                    };

                                    if(tss.shift) {
                                        if (tss.shift.date == moment().format('YYYY-MM-DD')){   // Ignore date today
                                            continue;
                                        }

                                        monLogInfo.employee_number = userLog.employee_number ? userLog.employee_number : '--';
                                        monLogInfo.employee_name = userLog.last_name+', '+userLog.first_name;
                                        monLogInfo.dtr_date = tss.shift.date ? moment(tss.shift.date).format('YYYY-MM-DD') : '';
                                        monLogInfo.shift_type = tss.shift.shift_type ? tss.shift.shift_type : '';
                                        

                                        if (tss.RegHrs < 0){
                                            monLogInfo.reason = 'Mismatch Shift';
                                        }
                                        if (!tss.shift.actual_check_in){
                                            monLogInfo.reason = 'No time in';
                                        }
                                        if (!tss.shift.actual_check_out){
                                            monLogInfo.reason = 'No time out';
                                        }
                                        if (!tss.shift.actual_check_out && !tss.shift.actual_check_in){
                                            monLogInfo.reason = 'No time in and out';
                                        }
                                        if (tss.shift.actual_check_in && tss.shift.check_in){
                                            var end = moment(tss.shift.actual_check_in)
                                            var duration = moment.duration(end.diff(moment(tss.shift.check_in)));
                                            var hours = duration.asHours();

                                            if(hours >= 4 || hours <= -4) {
                                                monLogInfo.reason = 'Mismatch logs/shift';
                                            }
                                        }
                                        if (tss.shift.actual_check_out && tss.shift.actual_check_in){
                                            if(!tss.shift.check_out && !tss.shift.check_in){
                                                monLogInfo.reason = 'With time logs but no shift';
                                            }
                                        }
                                    } else {
                                        let hasLogs = this.log_data.filter(
                                                (v,i,a)=>a.findIndex(l=>(
                                                l.userId === userLog.id && moment(l.date).utc().format('YYYY-MM-DD') === tss.date 
                                            ))===i
                                        );

                                        if(hasLogs) {
                                            monLogInfo.employee_number = userLog.employee_number ? userLog.employee_number : '--';
                                            monLogInfo.employee_name = userLog.last_name+', '+userLog.first_name;
                                            monLogInfo.dtr_date = tss.date ? moment(tss.date).format('YYYY-MM-DD') : '';
                                            monLogInfo.shift_type = '--';
                                            monLogInfo.reason = 'With time logs but no shift';
                                        }
                                    }


                                    if (monLogInfo.reason){
                                        this.logMonitors.push(monLogInfo);
                                        record_counter ++;
                                    }
                                }
                            }
                        }
                    }
                    
                    // LIMIT logMonitors to 10
                    this.logMonitors = this.logMonitors.slice(0,this.number_of_records);

                    this.session = response.data.session;
                    this.isFirstLogin = response.data.session.user.first_login;
                    this.isSupervisor = response.data.isSupervisor ? true : false;

                    this.calendar.user = response.data.user.id;
                    this.sessionUserId = response.data.user.id;
                    let overtime = response.data.overtime;
                    let shift = response.data.shift;
                    let shiftData = this.shiftData(shift);
                    let overtimeData = this.overtimeData(overtime);
                    this.complete_shift = response.data.complete_shift;
                    this.series = [
                        {
                            name: 'Overtime',
                            data: overtimeData.overtime
                        },{
                            name: 'Shifts',
                            data: shiftData
                        }, {
                            name: 'Rest Day',
                            data: overtimeData.restDay
                        }
                    ]
                    
                });
            },

            changeUser(){
                let user_id = this.calendar.user;
                this.fetchHoliday();
            },

            fetchHoliday(){
                let date = this.date;
                let user_id = this.calendar.user;
                let reqData = {
                    date: date
                }

                if(user_id){
                    reqData.user_id = user_id;
                }
                let REST = base_url + 'fetch/holiday';
                axios.post(REST, reqData).then(response => {
                    let holiday = response.data.holidays;
                    let events = response.data.events;
                    let leave = response.data.leave;
                    let business = response.data.business;
                    // console.log(leave);
                    let holidayArray = [];

                    if(business){
                        for(let key in business){
                            holidayArray.push({
                                title: 'Business Trip',
                                start: business[key]['date_start'],
                                end: business[key]['date_end'],
                                cssClass: 'business',
                                textEscape: false,
                                modal: 'hide'
                            });
                        }
                    }
                    if(holiday){
                        for(let key in holiday){
                            holidayArray.push({
                                title: holiday[key]['title'],
                                start: holiday[key]['date'],
                                end: holiday[key]['date'],
                                cssClass: 'holiday',
                                textEscape: false,
                                modal: 'hide'
                            });
                        }
                    }
                    if(events){
                        for(let e in events){
                            holidayArray.push({
                                title: events[e]['type'],
                                start: events[e]['date'],
                                end: events[e]['end_date'] ? events[e]['end_date'] : events[e]['date'],
                                textEscape: false,
                                eventID: events[e]['id'],
                                eventType: 'event',
                                cssClass: 'events',
                                modal: 'show'
                            });
                        }
                    }

                    if(leave){
                        for(let l in leave){
                            let leaveTitle = leave[l].leave_policy;
                            holidayArray.push({
                                title: leaveTitle ? leaveTitle.name : '',
                                start: leave[l].start_date,
                                end: leave[l].end_date,
                                textEscape: false,
                                eventID: leave[l].id,
                                eventType: 'leave',
                                cssClass: 'leave',
                                modal: 'hide'
                            });
                        }
                    }
                    this.eventArray = events;
                    this.calendarEvents = holidayArray;
                });
            },

            shiftData(shift){
                let array = [];
                for(let i = 1; i <= 12; i++){
                    let result = shift.find(obj => obj.month == i);
                    let total  = result ? result.total : 0;
                        total  = parseInt(total);
                    array.push(total);
                }
                return array;
            },

            overtimeData(record){
                let overtimeArray = this.groupOvertime(record);
                let overtime = [];
                let restDay = [];
                for(let i = 1; i <= 12; i++){
                    
                    let result = overtimeArray[i];
                    if(result){
                        if(result.length){
                            let totalOT = 0;
                            let totalRD = 0;
                            for(let x in result){
                                let object = result[x];
                                let start = new Date(object.start_date +' '+ object.start_time); 
                                    start = moment(start);
                                let end   = new Date(object.end_date +' '+ object.end_time); 
                                    end   = moment(end);
                                let duration = moment.duration(end.diff(start));
                                let asHours = duration.asHours();
                                if(object.type == 1){
                                    totalOT += asHours;
                                }else{
                                    totalRD += asHours;
                                }
                            }
                            overtime.push(Math.floor(totalOT));
                            restDay.push(Math.floor(totalRD));
                        }
                    }else{
                        overtime.push(0);
                        restDay.push(0);
                    }
                }
                let data = {
                    overtime: overtime,
                    restDay: restDay
                }
                return data;
            },

            groupOvertime(record){
                var outObject = record.reduce(function(a, e) {
                    let estKey = (e['month']); 

                    (a[estKey] ? a[estKey] : (a[estKey] = null || [])).push(e);
                    return a;
                }, {});

                return outObject;
            },

            dayClick(todate,jsEvent){
                let to_date = moment(new Date(todate)).format('YYYY-MM-DD');

                let currentDate = moment().format('YYYY-MM-DD HH:mm:ss');
                let cutoff = moment().format('YYYY-MM-DD') + ' 12:00:00';
                let minDate = null;
                let defaultDate = null;
                if(currentDate >= cutoff){
                    minDate = moment().format('YYYY-MM-DD') + ' 00:00:00';
                }else{
                    minDate = moment().subtract(1,'d').format('YYYY-MM-DD') + ' 00:00:00';
                }
                if(to_date >= moment().format('YYYY-MM-DD')){
                    defaultDate = to_date;
                }else{
                    defaultDate = moment(cutoff).format('YYYY-MM-DD');
                }
                minDate = new Date(minDate);
                this.minDate = minDate.toISOString();
                
                this.form = {
                    type: '',
                    date: defaultDate
                }

                this.method = 'post';
                this.modalText = 'Create Events';
                this.modal = true;
            },

        }

    }

</script>