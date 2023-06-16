<script>
	
	module.exports = {
		data: function(){
			return{
				method: 'put',
	            form: {},
	            errors: {},
	            loading: false,
				records: [],
				role: null,
				fetching: true,
				success: {}
			}
		},

		mixins: [
			Form,
			Alert
		],

		mounted(){
			this.fetchRecord();
		},

		computed: {

        },

        watch: {

        },

        methods: {

        	updateRole(){        		
        		this.showConfirmAlert('Do you want to save changes?');
        	},

        	Confirm(){
        		let form_data = this.form;
        		let REST = base_url + 'settings/user-role/save/changes'
        		axios.post(REST, form_data).then(response => {
        			this.alert = {};
        			this.success.message = response.data.message + `<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>`;
        		});
        	},

        	fullControl(index, event){
        		let checked = event.target.checked; 
        		let data = this.form.modules;
        			data = data[index];
        		this.form.modules[index]['read'] = checked;
        		this.form.modules[index]['create'] = checked;
        		this.form.modules[index]['modify'] = checked;
        		this.form.modules[index]['delete'] = checked;
        	},

        	fetchRecord(){
        		this.fetching = true;
        		let REST = window.location.href;
        		axios.post(REST).then(response => {
        			let records = response.data.records;
        			let role = response.data.role;
        			this.role = role;
        			this.fetching = false;
        			this.form = {
        				role_id: role.id,
        				modules: []
        			}
        			if(records){
        				for(let key in records){
        					this.form.modules.push({
								title: records[key]['title'],
								tag: records[key]['tag'],
								read: records[key]['role_permission'] && records[key]['role_permission']['read'] == '1' ? true : false,
								create: records[key]['role_permission'] && records[key]['role_permission']['write'] == '1' ? true : false,
								modify: records[key]['role_permission'] && records[key]['role_permission']['modify'] == '1' ? true : false,
								delete: records[key]['role_permission'] && records[key]['role_permission']['delete'] == '1' ? true : false
        					});
        				}
        			}
				});
        	},

		}

	}

</script>