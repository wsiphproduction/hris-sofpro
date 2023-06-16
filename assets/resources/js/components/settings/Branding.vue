<script>
	module.exports = {

		data: function(){
			return{
				form: {}
			}
		},

		mounted(){
			this.form = {
				image: '<span>Select Image</span>'
			}
			this.fetchRecord();
		},

		mixins: [
			Form, 
			Alert
		],

		methods: {

			fetchRecord(){
				let REST = base_url + 'settings/branding/fetch';
				axios.post(REST).then(response =>{
					let result = response.data.record;
					var logo = '<span>Select Image</span>';
					if(result && result.logo){
						logo = '<img src="'+ base_url+'uploads/'+result.logo +'">';
					}
					this.form = {
						image: logo,
						name: result ? result.name : '',
						branding: result ? result.branding : '1',
					}
				});
			},

		}

	}

</script>