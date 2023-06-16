<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                form:{},
                events: [],
                date: null,
                fetching: true,
                attendance: [],
                payslip: null,
                loans: [],
                policy: [],
                incentive: [],
                salary: {},
                year: this.setYear(),
                currYear: this.currentYear(),
                currMonth: this.currentMonth(),
                filter_attendance: {
                    year: this.currentYear(),
                    month: this.currentMonth(),
                    period: 'A'
                },
                payslip_form: {
                    period: ''
                },
                previewModal: false,
                preview: {},
                payrolls:[]
            }
        },
        mounted(){
            this.form = {
                image: '<span>Select Image</span>'
            }
            this.fetch_attendance();
            this.fetch_payslip();
            this.fetchRecord();
        },
        
        mixins: [
            Form,
            Alert
        ],

        computed: {
            fltrAttendanceYear(){
                return this.filter_attendance.year;
            },
            fltrAttendanceMonth(){
                return this.filter_attendance.month;
            },
            fltrAttendancePeriod(){
                return this.filter_attendance.period;
            },
            paySlipPeriod(){
                return this.payslip_form.period;
            },
        },

        watch: {
            fltrAttendanceYear(){
                this.fetch_attendance();
            },
            fltrAttendanceMonth(){
                this.fetch_attendance();
            },
            fltrAttendancePeriod(){
                this.fetch_attendance();
            },
            paySlipPeriod(){
                this.fetch_payslip();
            },
        },

        methods: {
            previewClose(){
                this.preview = {};
                this.previewModal = false;
            },

            info(index){
                let record = this.loans;
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

            changeAvatar(){
                this.modalText = 'Update Avatar';
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            closeModal(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

            currentYear(){
                return moment().format('YYYY');
            },

            currentMonth(){
                return moment().format('M');
            },

            setYear(){
                let array = [];
                let current = moment().format('YYYY');
                for(let i = current; i >= 2018; i--){
                    array.push(i);
                }
                return array;
            },

            initCalendar(date){
                this.date = moment(date).format('YYYY-MM-DD');
                this.fetch_events();
            },

            eventClick(event, jsEvent, pos) {
                //console.log(event);
            },

            fetch_payslip(){
                let form = this.payslip_form;
                let REST = base_url + 'myaccount/payslip';
                if(form.period){
                    axios.post(REST, form).then(response => {
                        this.payslip = response.data.payslip;
                    });
                }
            },

            fetch_attendance(){
                let form = this.filter_attendance;
                let REST = base_url + 'myaccount/attendance';
                if(form.year && form.month){
                    axios.post(REST, form).then(response => {
                        let attendance = response.data.attendance;
                        this.attendance = attendance;
                    });
                }
            },

            fetch_events(){
                let date = this.date;
                let REST = base_url + 'myaccount/events';
                axios.post(REST, { date: date}).then(response => {
                    let holiday = response.data.holidays;
                    let events = [];
                    if(holiday){
                        for(let key in holiday){
                            events.push({
                                title: holiday[key]['title'],
                                start: holiday[key]['date'],
                                textEscape: false
                            });
                        }
                    }
                    this.events = events;
                });
            },

            fetchRecord(){
                let REST = base_url + 'myaccount/fetch';
                axios.post(REST).then(response => {
                    let user = response.data.user;
                    this.policy = response.data.policy;
                    this.loans = response.data.loans;
                    this.incentive = response.data.incentive;
                    this.salary = response.data.salary;
                    this.form.email = user.email;
                    this.payrolls = response.data.payroll;
                    this.form.twoFactor = user.twoFactor && user.twoFactor.status == 1 ? true : false;
                });
            }
        }
    }
</script>