<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add New Review',
                error: {},
                form: {},
                method: '',
                performanceInfo: false,
                reviews:[]
                
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

            addReview(user_id){
                this.method = 'post'
                this.form = {
                    user_id: user_id,
                    title: '',
                    evaluation_date: '',
                    evaluator: '',
                    rating: '',
                    recommendation: '',
                    remarks: '',
                    points: '',
                    description: '',
                }
                this.performanceInfo = true;
            },

            editReview(index){
                let performanceInfo = this.reviews[index];
                this.form = {
                    id: performanceInfo.id,
                    user_id: performanceInfo.user_id,
                    title: performanceInfo.title,
                    evaluation_date: performanceInfo.evaluation_date,
                    evaluator: performanceInfo.evaluator,
                    rating: performanceInfo.rating,
                    recommendation: performanceInfo.recommendation,
                    remarks: performanceInfo.remarks,
                    points: performanceInfo.points,
                    description: performanceInfo.points
                }

                this.method = 'put';
                this.modalText = 'Edit Performance Review';
                this.performanceInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/performance-review/record/fetch';
                axios.post(API, {
                    slug: slug
                }).then(response =>{
                    this.reviews = response.data.review;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }

        }
    }
</script>