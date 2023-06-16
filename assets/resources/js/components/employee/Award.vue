<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add Award',
                error: {},
                form: {},
                method: '',
                awardInfo: false,
                awards: []

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

            addAward(user_id){
                this.method = 'post',
                this.form = {
                    user_id: user_id,
                    title: '',
                    date: '',
                    givenBy: ''
                }
                this.awardInfo = true;
            },

            editAward(index){
                let awardInfo = this.awards[index];
                this.form = {
                    id: awardInfo.id,
                    user_id: awardInfo.user_id,
                    title: awardInfo.title,
                    date_given: awardInfo.date,
                    given_by: awardInfo.given_by
                }

                this.method = 'put';
                this.modalText = 'Edit Award';
                this.awardInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/award/record/fetch';
                axios.post(API, {
                    slug: slug
                }).then(response =>{
                    this.awards = response.data.awards;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }
        }
    }
</script>