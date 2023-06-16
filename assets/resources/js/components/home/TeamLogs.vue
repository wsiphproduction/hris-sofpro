<script>
    module.exports = {
        data: function(){
            return{
                records: [],
                schedule: [],
                users:[], 
                shift_types:[],
                log_data: null,
                fetching: true,
                keyword: '',
                counts: 0,
                // minDate: "",
                // maxDate: "",

                param: {
                    // employee    : '',
                    // start       : '',
                    // end         : '',
                    status      : '',
                    limit       : 25,
                    key         : '',
                    page        : 1,
                    rec_start   : 0,
                    rec_end     : 0,
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
            }
        },

        mounted(){
            this.fetchRecord();
        },

        methods: {
            fetchRecord(){
                this.fetching = true;
                this.counts   = 0;

                let REST = base_url + 'fetch';
                axios.post(REST).then(response => {
                    this.schedule           = response.data.schedule;
                    this.users              = response.data.users;
                    this.log_data           = response.data.log_data;

                    //TRANSFORM USER SHIFTS TO RECORD
                    let users_copy          = this.users;
                    this.records            = [];
                    this.shift_types        = [];

                    let record_transform    = [];
                    let shift_types_raw     = [];

                    for(index in users_copy){
                        if(users_copy[index].shifts.length){
                            for(ctr in users_copy[index].shifts){

                                data = {
                                    employee_number : users_copy[index].employee_number,
                                    full_name       : users_copy[index].last_name + ', ' + users_copy[index].first_name,
                                    shift_type      : users_copy[index].shifts[ctr].shift_type,
                                    check_in        : users_copy[index].shifts[ctr].check_in,
                                    check_out       : users_copy[index].shifts[ctr].check_out,
                                    actual_check_in : users_copy[index].shifts[ctr].actual_check_in,
                                    actual_check_out: users_copy[index].shifts[ctr].actual_check_out,
                                };

                                record_transform.push(data);

                                //GET SHIFT TYPES
                                if(shift_types_raw.indexOf(users_copy[index].shifts[ctr].shift_type)==-1){
                                    shift_types_raw.push(users_copy[index].shifts[ctr].shift_type);
                                }
                            }
                        }
                    }

                    this.records     = record_transform;
                    this.shift_types = shift_types_raw;


                    //GET RECORDS
                    let rec_copy             = this.records; 
                    
                    //SEARCH KEYWORD
                    let search_keyword      = this.param.key.toUpperCase();
                    let search_status       = this.param.status;
                    this.records            = rec_copy.filter(el => (el.employee_number.includes(search_keyword) || el.full_name.includes(search_keyword))&&el.shift_type.includes(search_status));            

                    // FOR PAGINATION
                    console.log(rec_copy.length);
                    let raw_divide 			= parseFloat(this.records.length/this.param.limit);
                    let get_whole_number 	= parseInt(raw_divide);
                    let get_decimal			= parseFloat(raw_divide%1);
                    
                    if(get_decimal > 0)
                    {
                        get_whole_number++;
                    }

                    //NUMBER OF PAGES
                    this.counts = parseInt(get_whole_number);
                    
                    //PAGE BASIS
                    this.param.rec_start    = 0;
                    this.param.rec_end      = this.param.limit;
                    

                    this.fetching = false; 
                  
                }); 
            },
            setPage(page){
                this.param.page = page;
                this.param.rec_end    = page * this.param.limit;
                this.param.rec_start  = this.param.rec_end - this.param.limit;
            },
            reset(){
                this.param = {
                    status      : '',
                    limit       : 25,
                    key         : '',
                    page        : 1,
                    rec_start   : 0,
                    rec_end     : 0,
                }
                this.records = [];
                this.fetchRecord();
            },
            
        }
    }
</script>