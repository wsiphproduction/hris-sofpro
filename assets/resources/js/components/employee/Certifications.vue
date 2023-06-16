<script>
	let Cover = require('./Cover.vue');
    
	module.exports = {
		data: function(){
            return {
            	modal: false,
                modalText: '',
                certifications: []
            }
		},

		mixins: [
			Form,
			Alert,
			Cover
		],

        mounted(){
			this.fetchRecord();
		},

		methods: {
            add(){
				this.method = 'post';
				this.modalText = 'Add Certifications';
                this.form = {};
                this.form = {
                    name: '',
                    description: '',
                    date_issued: '',
                    start_date: '',
                    end_date: '',
                    expiry_date: '',
                };
				this.modal = true;
			},

            edit(index){
				this.method = 'put';
				this.modalText = 'Edit Certifications';
                let certifications = this.certifications[index];
                this.form = {};
                this.form = {
                    id: certifications.id,
                    name: certifications.name,
                    description: certifications.description,
                    date_issued: certifications.date_issued,
                    start_date: certifications.start_date,
                    end_date: certifications.end_date,
                    expiry_date: certifications.expiry_date,
                };
				this.modal = true;
			},

			fetchRecord(){
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/certifications/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
                	this.certifications = response.data.certifications;
                });
			}
		}
	}
</script>