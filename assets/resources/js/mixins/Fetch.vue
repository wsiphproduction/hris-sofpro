<script>
	module.exports = {
		data: function() {
	        return {
	        	page: 1,
                records: []
	        }
	    },

        mounted(){
            this.allRecord();
        },

	    methods: {	    	
	    	allRecord(){
                let page = this.page;
                let url = window.location.href + '/all';
                axios.post(url, { page:page }).then(response => {
                    let records = response.data.records;
                    
                    this.records = records;
                });
            },

            setDate(date, format){
                let newDate = moment(date).format(format);
                return newDate;
            }
	    }
	}

</script>