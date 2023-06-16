<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modal: false,
                modalText: 'Add New',
                error: {},
                form: {},
                method: '',
                trainingInfo: false,
                trainings: []
            }
		},

        mounted(){
            this.fetchData();
        },
    
        mixins: [
			Form,
            Modal,
		    Alert,
            Archive,
            Cover
		],
      
        methods: {
            
            addTraining(user_id){
                this.method = 'post';
                this.form = {
                    user_id: user_id,
                    title: '',
                    description: '',
                    start_date: '',
                    end_date: '',
                    days: '',
                    provider: '',
                    points: '',
                    report: ''
                }
                this.trainingInfo = true;
            },

            editTraining(index){
                let trainingInfo = this.trainings[index];
                this.form = {
                    id: trainingInfo.id,
                    user_id: trainingInfo.user_id,
                    title: trainingInfo.title,
                    description: trainingInfo.description,
                    start_date: trainingInfo.start_date,
                    end_date: trainingInfo.end_date,
                    days: trainingInfo.no_days,
                    provider: trainingInfo.training_provider,
                    points: trainingInfo.cdp_points,
                    report: trainingInfo.training_report,
                }

                this.method = 'put';
                this.modalText = 'Edit Training';
                this.trainingInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/training/record/fetch';
                axios.post(API, {
                    slug: slug
                }).then(response =>{
                    this.trainings = response.data.trainings;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }
        }
    }
</script>