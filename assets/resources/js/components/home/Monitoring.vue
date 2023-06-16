<script>
    module.exports = {
        data: function(){
            return{
                records: [],
                schedule: [],
                users:[], 
                records:null,
                fetching: true,
                keyword: '',
                counts: 0,
                minDate: "",
                maxDate: "",
                baseUrl:base_url,
                retain_param: true,

                param: {
                    // employee    : '',
                    // start       : '',
                    // end         : '',
                    status      : '',
                    type        : '1',
                    type_status : '1',
                    limit       : 25,
                    key         : '',
                    page        : 1,
                },
            }
        },

        watch:{
            start(){
                this.minDate = this.param.start;
                if(!this.isFirstLoad) {
                    this.param.end = '';
                }
            },
            end(){
                this.isFirstLoad = false;
            },
            'param.limit'(){
                this.param.page = 1;
                this.fetchRecord();
            },
            'param.status'(){
                this.fetchRecord();
            },
            'param.key'(){
                this.param.key = this.param.key.trim();
                this.fetchRecord();
            },
            'param.type'(){
                this.fetchRecord();
            },
            'param.type_status'(){
                this.fetchRecord();
            }
        },

        mounted(){
            this.fetchRecord();
        },
        mixins:[
            Alert,
        ],
        methods: {
            deleteRecord(shift_id){
                let REST = base_url + 'log-issue-monitoring/delete'

                axios.post(REST,{shift_id: shift_id}).then(response => {
                    let msg = response.data.msg;
                    this.showSuccessAlertFetch(msg);
                });
            },
            fetchRecord(){
                this.fetching = true;
                this.counts   = 0;

                let REST = base_url + 'log-issue-monitoring/fetch';

                let reqData = {
                    type            : this.param.type,
                    type_status     : this.param.type_status,
                    key             : this.param.key.trim().toUpperCase(),
                    page            : this.param.page,
                    limit           : this.param.limit
                };
                axios.post(REST,reqData).then(response => {
                    this.records        = response.data.records;
                    let total_records   = parseInt(response.data.total_rows);

                    // LIST OF PROBLEMS AND SOLUTIONS IN TYPE 1
                    let type_1_problems = [
                        'NO ACTUAL TIME IN AND TIME OUT',
                        'NO ACTUAL TIME IN',
                        'NO ACTUAL TIME OUT',
                        'NO SHIFT TYPE'
                    ];
                    let type_1_solutions = [
                        'PLEASE USE <b>CHANGE LOG</b> AND CLICK THE <b>REPROCESS</b>',
                        'TRY FETCHING THE ATTENDANCE USING <b>ADD ATTENDANCE</b> AND CLICK <b>REPROCESS</b>',
                        'TRY FETCHING THE ATTENDANCE USING <b>ADD ATTENDANCE</b> AND CLICK <b>REPROCESS</b>',
                        'FILE A <b>CHANGE SHIFT</b> AND <b>REPROCESS</b>'
                    ];
                    // LIST OF PROBLEMS AND SOLUTIONS IN TYPE 2
                    let type_2_problems = [
                        'REPROCESSING ERROR',
                        'THE SHIFT HAS ATTENDANCE',
                        'DOUBLE SHIFT OR DOUBLE TSS DATA'
                    ];
                    let type_2_solutions = [
                        'PLEASE CLICK THE <b>REPROCESS</b> IN THE DTR MANAGEMENT',
                        'PLEASE FILE A CHANGE LOG WITHOUT <b>BOTH</b> THE TIME IN AND TIME OUT TO EMPTY THE ATTENDANCE',
                        'PLEASE CONTACT THE ADMINISTRATOR TO RESOLVE THE ISSUE'
                    ];

                    // CHECK THE CHOSEN TYPE
                    /*
                        1. TIME OUT AND TIME IN
                        2. TSS DATA WITHOUT SHIFT
                        3. APPROVED OT W/O ACTUAL TIME IN AND OUT OR NO SHIFT
                        4. DUPLICATE TSS DATA RECORD
                        5. DUPLICATE SHIFT
                    */
                    //FILTER RECORDS
                    let type = this.param.type;
                    if(type == '1'){
                        this.records.forEach(el => {
                            if(!el.actual_check_in && !el.actual_check_out){
                                el.problem  = type_1_problems[0];
                                el.solution = type_1_solutions[0];
                            }
                            else if(!el.actual_check_in && el.actual_check_out){
                                el.problem  = type_1_problems[1];
                                el.solution = type_1_solutions[1];
                            }
                            else if(el.actual_check_in && !el.actual_check_out){
                                el.problem  = type_1_problems[2];
                                el.solution = type_1_solutions[2];
                            }
                            if(!el.shift_type){
                                el.problem  += ", " + type_1_problems[3];
                                el.solution += ", " + type_1_solutions[3];
                            }
                        });
                    }
                    if(type == '2'){
                        // is_double_shift
                        this.records.forEach(el => {
                            if (el.is_double_shift) {
                                el.problem = type_2_problems[2];
                                el.solution = type_2_solutions[2];
                            }
                            else if (el.actual_check_in || el.actual_check_out) {
                                el.problem = type_2_problems[1];
                                el.solution = type_2_solutions[1];
                            }
                            else {
                                el.problem = type_2_problems[0];
                                el.solution = type_2_solutions[0];
                            }
                        });
                    }
                    //NUMBER OF PAGES
                    let limit           = this.param.limit;
                    let limit_records   = parseFloat(total_records/limit);
                    this.counts         = total_records<=limit?1:limit_records % parseInt(limit_records)>0?parseInt(limit_records+1):parseInt(limit_records);
                    this.fetching       = false; 
                  
                }); 
            },
            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },
            reset(){
                this.param = {
                    status      : '',
                    limit       : 25,
                    key         : '',
                    type        : '1',
                    type_status : '1',
                    page        : 1,
                }
                this.records = [];
                this.fetchRecord();
            },
            
        }
    }
</script>