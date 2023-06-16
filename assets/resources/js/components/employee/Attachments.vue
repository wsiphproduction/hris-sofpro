<script>
let Cover = require('./Cover.vue');
	module.exports = {
		  
		data: function(){

			return{
                alert:{},
                modalText: 'Add Attachment',
                error: {},
                form: {},
                method: '',
                attachment_modal: false,
                attachments: []

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

            onAttachmentChange(element){
	    		let file = element.target.files[0];
	    		this.form.attachment = file;
	    	},

            addAttachment(user_id){
                this.method = 'post',
                this.form = {
                    user_id: user_id,
                    description: '',
                    document_number: '',
                    place_of_issue: '',
                    document_type: '',
                    remarks: '',
                }
                this.attachment_modal = true;
            },

            
            edit(index){
                let info = this.attachments[index];
                this.form = {
                    id: info.id,
                    user_id: info.user_id,
                    description: info.description,
                    document_number: info.document_number,
                    place_of_issue: info.place_of_issue,
                    document_type: info.document_type,
                    remarks: info.remarks,
                }

                this.method = 'put';
                this.modalText = 'Edit Attachment';
                this.attachment_modal = true;
            },

            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/attachment/record/fetch';
                axios.post(API,{
                    slug: slug
                }).then(response =>{
                    this.attachments = response.data.attachments;
                }).catch(error =>{
                    console.log(error);
                });
            }
            
        }
    }
</script>