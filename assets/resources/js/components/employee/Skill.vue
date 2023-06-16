<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add New Skill',
                method:'',
                form: {},
                error: {},
                skillInfo: false,
                skills: []
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
            addSkill(user_id){
                this.method = 'post',
                this.form = {
                    user_id: user_id,
                    skill: '',
                    remark: ''
                }
                this.skillInfo = true;
            },

            editSkill(index){
                let skillInfo = this.skills[index];
                this.form = {
                    id: skillInfo.id,
                    user_id: skillInfo.user_id,
                    skill: skillInfo.skill,
                    remark: skillInfo.remark,
                }

                this.method = 'put';
                this.modalText = 'Edit Skill';
                this.skillInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/skill/record/fetch';
                axios.post(API, {
                    slug: slug
                }).then(response =>{ 
                    this.skills = response.data.skills;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }
        }
    }
</script>