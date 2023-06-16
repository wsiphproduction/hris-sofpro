<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Rating Detail',
                form:{},
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
                questions: [],
                label: {},
                flag: '',
                disabled: false,
                fetching: true
            }
        },

        mixins: [ 
            Form,
            Alert,
            Archive
        ],

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
                this.fetchRecord();
            },

            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
        },

        mounted(){
            this.fetchRecord();
        },

        methods: {
            closeModal(){
                this.errors = {}
                this.form = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(id, flag){
                this.method = 'post';
                this.loading = false;
                this.flag = flag;
                this.disabled = flag == 'info' ? true : false;
                this.ratingDetail(id);
            },

            validate(){
                if((this.param.start && this.param.end) && (this.param.start <= this.param.end)){
                    this.param.page = 1;
                    this.fetchRecord();
                }
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            fetchRecord(){
                this.fetching = true;
                let form_data = {
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    status: this.param.status,
                    limit: this.param.limit,
                    page: this.param.page
                }
                let API = base_url + 'recruitment/rating/get';
                axios.post(API, form_data).then(response => {
                    let records = response.data.records;
                    this.records = records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            },

            ratingDetail(id){
                this.modal = true;
                let API = base_url + 'recruitment/rating/fetch';
                axios.post(API, {id:id}).then(response => {
                    let user = response.data.user;
                    let profile = response.data.profile;
                    let interview = response.data.interview;
                    let questions = response.data.question;
                    this.questions = questions;
                    //console.log(interview);
                    this.label = {
                        candidate: profile.first_name +' '+ profile.last_name,
                        job_title: profile.position_applying_for,
                        interviewer: interview ? interview.user.first_name +' '+ interview.user.last_name : user.first_name +' '+ user.last_name
                    }

                    this.form = {
                        id: interview ? interview.id : '',
                        candidate_profile_id: id,
                        interview_date: interview ? moment(interview.interview_date).format('MMMM DD, YYYY') : moment().format('MMMM DD, YYYY'),
                        interviewer: interview ? interview.interviewer : user.id,
                        overall_assessment: interview ? interview.overall_assessment : '',
                        status: profile.interview_status,
                        ratings: []
                    }
                    if(questions){
                        for(let x in questions){
                            this.form.ratings.push({
                                id: questions[x]['id'] ? questions[x]['id'] : '',
                                title: questions[x]['title'],
                                candidate_rating: questions[x]['interview_id'] ? questions[x]['candidate_rating'] : '',
                                job_relevance: questions[x]['interview_id'] ? questions[x]['job_relevance'] : '',
                                notes: questions[x]['interview_id'] ? questions[x]['notes'] : ''
                            });
                        }
                    }

                });
            },

            init(){
                
            }
        }

    }

</script>