<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add License',
                error: {},
                form: {},
                method: '',
                licenseInfo: false,
                license: []

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

            addLicense(user_id){
                this.method = 'post',
                this.form = {
                    user_id: user_id,
                    license: '',
                    description: '',
                    date_issued: '',
                    expiration: '',
                    start_date: '',
                    end_date: '',
                }
                this.licenseInfo = true;
            },

            editLicense(index){
                let licenseInfo = this.license[index];
                this.form = {
                    id: licenseInfo.id,
                    user_id: licenseInfo.user_id,
                    license: licenseInfo.license,
                    description: licenseInfo. description,
                    date_issued: licenseInfo.date_issued,
                    expiration: licenseInfo.expiration,
                    start_date: licenseInfo.start_date,
                    end_date: licenseInfo.end_date,
                }

                this.method = 'put';
                this.modalText = 'Edit License';
                this.licenseInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/license/record/fetch';
                axios.post(API, {
                    slug: slug
                }).then(response =>{
                    this.license = response.data.license;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }
        }
    }
</script>