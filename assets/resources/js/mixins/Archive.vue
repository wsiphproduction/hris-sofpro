<script>
	module.exports = {
		data: function() {
			return {
				archive_id: null,
				archive_path: null
			}
		},

		methods: {          
			archive(id, path){
				this.showConfirmAlert('Are you sure you want to archive this item?');
				this.archive_id = id;
				this.archive_path = path;
			},

			Confirm(){
				let id = this.archive_id;
				let path = this.archive_path;
				let REST = base_url + path;
				// this.alert = {};
				axios.post(REST, {id: id}).then(response => {
					let action = response.data.action;
					if(action == 'close'){
						window.location = window.location;
					}else{
						this.alert.confirm = '';
						this.fetchRecord();
					}
				}).catch(error => {
					this.showErrorAlert(error.response.data.message);
				});
			},
		}
	}

</script>