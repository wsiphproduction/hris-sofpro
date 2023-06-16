<script>
	module.exports = {
		data: function(){
			return{
                nationalities: []
			}
		},
        
		mounted(){
			this.initForm();
		},

		mixins: [
			Form,
			Alert
		],

        methods: {
        	initForm(){
				let url = base_url + 'install/init';
                axios.post(url).then(response =>{
                    this.nationalities = response.data.nationalities;
                    console.log(this.nationalities);
                });
        	},
        }

	}

</script>