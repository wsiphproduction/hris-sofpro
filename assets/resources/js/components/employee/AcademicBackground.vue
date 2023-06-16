<script>
	let Cover = require('./Cover.vue');
    
	module.exports = {
		data: function(){
            return {
            	modal: false,
                modalText: '',
                educations: []
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
				this.modalText = 'Add Educational Background & Qualifications';
                this.form = {};
                this.form = {
                    educational_attainment: '',
                    degree: '',
                    school: '',
                    date_from: '',
                    date_to: '',
                    course: '',
                    specialization: '',
                    honors: '',
                };
				this.modal = true;
			},

            edit(index){
				this.method = 'put';
				this.modalText = 'Edit Educational Background & Qualifications';
                let educations = this.educations[index];
                this.form = {};
                this.form = {
                    id: educations.id,
                    educational_attainment: educations.educational_attainment,
                    degree: educations.degree,
                    school: educations.school,
                    date_from: educations.date_from,
                    date_to: educations.date_to,
                    course: educations.course,
                    specialization: educations.specialization,
                    honors: educations.honors
                };
				this.modal = true;
			},

			fetchRecord(){
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/academic-background/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
                	this.educations = response.data.educations;
                });
			}
		}
	}
</script>