<script>
	module.exports = {

		data: function(){
			return{
                form: {},
                records: [],
                counts: 0,
                fetching: true,
                minDate: '',
                editor: ClassicEditor,
                editorConfig: {
                    simpleUpload: {
                        uploadUrl: {
                            url: base_url + 'announcement/upload',
                            headers:{ 
                                'CSRF-Token': token 
                            } 
                        },
                    }
                },
                param: {
                    start: '',
                    end: '',
                    limit: 25,
                    page: 1
                },

			}
		},

		mounted(){
			this.fetchRecord();
		},

		mixins: [
			Form,
			Alert,
            Archive,
            Modal
		],

		computed: {
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
            limit(){
                return this.param.limit;
            }
		},

		watch: {
            start(){
                this.minDate = this.param.start;
                this.param.end = '';
                this.validate();
            },
            end(){
                this.validate();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
		},

        methods: {
            upload(){

            },

            close(){
                this.errors = {}
                this.modal = false;
                this.loading = false;
            },

        	edit(index){
                let record = this.records;
                    record = record[index];
                this.loading = false;
                this.method = 'put';
                this.modalText = 'Edit Announcement';
                this.form = {
                    id: record.id,
                    subject: record.subject,
                    short_description: record.short_description,
                    description: record.description,
                }
                this.modal = true;
        	},

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            fetchRecord(){
                this.fetching = true;
                this.records = [];
                let form_data = {
                    start: this.param.start ? moment(this.param.start).format('YYYY-MM-DD') : '',
                    end: this.param.end ? moment(this.param.end).format('YYYY-MM-DD') : '',
                    limit: this.param.limit,
                    page: this.param.page
                }
                let REST = base_url + 'announcement/fetch';
                axios.post(REST, form_data).then(response => {
                    this.records = response.data.records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }

		}

	}

</script>