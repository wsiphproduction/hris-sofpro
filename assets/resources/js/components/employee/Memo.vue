<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add New Memo',
                error: {},
                form: {},
                method: '',
                memoInfo: false,
                memos:[]
                
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

            addMemo(user_id){
                this.method = 'post'
                this.form = {
                    user_id: user_id,
                    memo: '',
                    subject: '',
                    description: '',
                    date: '',
                    issued_by: '',
                    issued_to: '',
                    effectivity_date: ''   
                }
                this.memoInfo = true;
            },

            editMemo(index){
                let memoInfo = this.memos[index];
                this.form = {
                    id: memoInfo.id,
                    user_id: memoInfo.user_id,
                    memo: memoInfo.memo,
                    subject: memoInfo.subject,
                    description: memoInfo.description,
                    date: memoInfo.date,
                    issued_by: memoInfo.issued_by,
                    issued_to: memoInfo.issued_to,
                    effectivity_date: memoInfo.effectivity_date,
                }

                this.method = 'put';
                this.modalText = 'Edit Memo';
                this.memoInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/memorandum/record/fetch';
                axios.post(API,{
                    slug: slug
                }).then(response =>{
                    this.memos = response.data.memo;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }

        }
    }
</script>