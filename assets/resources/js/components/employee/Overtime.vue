<script>
	
	let Alert = require('../../mixins/Alert.vue');

	module.exports = {
		data: function(){
            return {
                alert: {},
                filterModal: false,
                inputClass: 'form-control',
                dateFormat:'MM/dd/yyyy',
                records: [],
                counts: 0
            }
		},

		mixins: [
			Alert
		],

		components: {
            
        },

		methods: {

			filter(){
				this.filterModal = true;
			},

			closeFilter(){
				this.filterModal = false;
			}

		}
	}
</script>