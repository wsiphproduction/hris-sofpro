<script>

	module.exports = {

		data: function() {
        
	        return {
	        	method: 'post',
	            form: {},
	            errors: {},
	            loading: false,
	            successMessage: ''
	        }
	    
	    },

	    methods: {
	  		fileUpload(element,name){
	  			let file = element.target.files[0];
	  			this.form[name] = file;
	  		},

	    	onAttachmentChange(element){
	    		let file = element.target.files[0];
	    		this.form.attachment = file;
	    	},

	        onImageChange(element){
	            let file        = element.target.files[0];
	            let elementId   = element.target.id;
	            if(file) {
					var reader = new FileReader();

					this.form.file = file;
					reader.onload = () => {
						this.form.image = '<img src="'+ reader.result +'">';
					}
					reader.readAsDataURL(file);
				}else{
					this.form.image = '<span>Select Image</span>';
				}
	        },

	        startLoading() {
	            this.loading = true;
	        },

	        stopLoading() {
	            this.loading = false;
	        },

	        onSubmit(element) {
	            // this.startLoading();
	            // this.errors = {}
	            // let action = element.target.action;
	            // let enctype = element.target.enctype;
             //    let formData = this.form;
             //    if(enctype === 'multipart/form-data'){
	            //     formData = new FormData(element.target);
             //    }
             //    let METHOD = '';
             //    if(this.method === 'get'){
             //    	METHOD = axios.get(action, formData);
             //    }else if(this.method === 'put'){
             //    	METHOD = axios.put(action, formData);
             //    }else{
             //    	METHOD = axios.post(action, formData);
             //    }

                this.startLoading();
	            this.errors = {}
	            let action = element.target.action;
	            let enctype = element.target.enctype;
	            let form = this.form;
                let formData = form;
                let config = {}
                if(enctype === 'multipart/form-data'){
	                formData = new FormData();
	                config.header = {
	                	'Content-Type': 'multipart/form-data'
	                }
	                for(var key in form) {
					    if (form.hasOwnProperty(key)) {
					    	formData.append(key, form[key]);
					    }
					}
                }
                let METHOD = '';
                if(this.method === 'get'){
                	METHOD = axios.get(action, formData, config);
                }else if(this.method === 'put'){
                	METHOD = axios.put(action, formData, config);
                }else{
                	METHOD = axios.post(action, formData, config);
                }

	            METHOD.then(response => {
	            	this.modal = false;
					this.modal_edit = false;
	            	this.loading = false;
	            	this.roleModal = false;
            		if(response.data.action === 'refresh'){
            			window.location = window.location;
            		}else if(response.data.action === 'close'){
						this.showSuccessAlert(response.data.msg);
            		}else if(response.data.action === 'fetch'){
            			let fetchMethod = response.data.methods ? response.data.methods : null;
						this.showSuccessAlertFetch(response.data.msg, fetchMethod);
            		}else if(response.data.action === 'failed'){
            			this.showErrorAlert(response.data.msg);
            		}else{
            			this.successMessage = response.data.msg;
            			this.form = {}
            		}
            	}).catch(error => {
            		let errData = [];
    				if(error.response.status == 422){
    					let errors = error.response.data.errors;
    					for(let key in errors){
                            errData[errors[key].param] = errors[key].msg;
                        }
    				}else{
    					errData['server'] = error.response.statusText;
    				}
    				this.errors = errData;
    				this.stopLoading();
            	});
	        }

	    }

    }

</script>