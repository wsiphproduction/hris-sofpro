<script>
	module.exports = {

		data: function(){

			return{
				modal: false,
				modalText: 'Custom Approver',
				form: {},
				records: [],
				fetching: true,
				disabled: false,
				param: {
                    team: '',
                    manager: ''
                },
                approvers: []
			}
		},

		mounted(){
			this.fetchRecord();
		},

		mixins: [
			Form,
			Alert,
			Archive
		],

		computed:{
			team(){
                return this.param.team;
            },

            manager(){
                return this.param.manager;
            },
		},

		watch: {
			team(){
                this.fetchRecord();
            },

            manager(){
                this.fetchRecord();
            },
		},

		methods: {

			closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},

			openModal(){
				this.form = {
					action: 'add',
					employee: '',
					backup_approver: '',
					primary_approver: '',
				}
				this.method = 'post';
				this.modal = true;
				this.loading = false;
				this.disabled = false;
			},

			edit(index){
				let record = this.records;
					record = record[index];
				this.method = 'post';
				this.form = {
					action: 'update',
					id: record.id,
					employee: record.user_id,
					backup_approver: record.backup_approver_id,
					primary_approver: record.primary_approver_id,
				}
				this.modal = true;
				this.loading = false;
				this.disabled = true;
			},

			fetchRecord(){
        		this.fetching = true;
        		let REST = base_url +'settings/approvers/custom/fetch';
        		let param = this.param;
        		axios.post(REST, param).then(response => {
        			let data = response.data;
        			let app = data.approvers;
        			let approvers = [];
        			this.records = data.records;
        			if(app.length){
        				for(let x in app){
        					let manager = app[x].primary;
        					if(manager){
        						approvers.push(manager);	
        					}
        				}
        			}
        			if(approvers.length){
        				this.approvers = this.filterApprover(approvers, k => k.id);
        			}
        			
        			this.fetching = false;
				});
        	},

        	filterApprover(data, key){
        		return [
        			...new Map(
        				data.map(x => [key(x),x])
        			).values()
        		]
        	}

		}
	}
</script>