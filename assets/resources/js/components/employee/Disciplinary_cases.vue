<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add New Case',
                error: {},
                form: {},
                method: '',
                caseInfo: false,
                cases: []
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
            
            addCases(user_id){
                this.method = 'post';
                this.form = {
                    user_id: user_id,
                    incident_report: '',
                    prepared_by: '',
                    received_by: '',
                    incident_date: '',
                    code: '',
                    decision_serve: '',
                    start_date: '',
                    end_date: ''
                }
                this.caseInfo = true;
            },

            editCases(index){
                let caseInfo = this.cases[index];
                this.form = {
                    id: caseInfo.id,
                    user_id: caseInfo.user_id,
                    incident_report: caseInfo.title,
                    received_by: caseInfo.received_by,
                    prepared_by: caseInfo.prepared_by,
                    incident_date: caseInfo.incident_date,
                    code: caseInfo.code,
                    decision_serve: caseInfo.date_served,
                    start_date: caseInfo.start_date,
                    end_date: caseInfo.end_date,
                }

                this.method = 'put';
                this.modalText = 'Edit Case';
                this.caseInfo = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/disciplinary-cases/record/fetch';
                axios.post(API, {
                    slug: slug
                }).then(response =>{
                    this.cases = response.data.cases;
                }).catch(error =>{
                    console.log(`The Error: ${error}`);
                });
            }
        }
    }
</script>