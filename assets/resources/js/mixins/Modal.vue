<script>
	module.exports = {

		data(){
			return{
				modal: false,
				modalText: 'Create New'
			}
		},

		methods:{
			closeModal(){
				this.errors = {}
				this.form = {}
				this.modal = false;
				this.loading = false;
			},


			openModal(){
				this.modalText = 'Create New';
				this.method = 'post';
				this.modal = true;
				this.loading = false;
			}

		}

	}
</script>