<script>

	module.exports = {

		data: function() {
        
	        return {

	        	alert: {}

	        }
	    
	    },

	    methods: {	    	

	    	closeAlert(){
				this.alert = {};
				if(this.retain_param){
					this.fetchRecord();
				}
				else{
					window.location = window.location;
				}
			},

			closeOnly(){
				this.alert = {};
			},

			showErrorAlert(msg){
				this.form = {};
				this.modal = false;
				try{
					this.closeModal();
				}catch(err){
					this.closeOnly();
				}
				this.alerterror = msg;
				this.alert.error = msg;
			},

			showSuccessAlert(msg){
				this.form = {};
    			this.modal = false;
				try{
					this.closeModal();
				}catch(err){
					this.closeOnly();
				}
    			this.alert.success = msg;
			},

			showSuccessAlertFetch(msg, method){
				this.form = {};
    			this.modal = false;
    			try{
					this.closeModal();
				}catch(err){
					this.closeOnly();
				}
    			this.alert.successFetch = msg;
    			if(method){
    				if(method.includes('fetchWin')){
    					this.fetchWin();
    				}
    			}else{
    				this.fetchRecord();
    			}
			},

			showConfirmAlert(msg){
				//this.form = {};
				this.closeOnly();
    			this.modal = false;
    			this.alert.confirm = msg;
			},

	    }
	}

</script>