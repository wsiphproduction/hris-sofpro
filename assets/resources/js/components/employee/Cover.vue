<script>
	module.exports = {
		data: function(){
            return {
                modalAvatar: false,
            }
		},
		mixins:[
            Form,
            Alert
        ],
        
		methods: {
            changeAvatar(user_id){

                this.form = {
                    user_id: user_id,
                    image: '<span>Select Image</span>'
                }
                this.method = 'post';
                this.modalAvatar = true;
                this.loading = false;
            },

            closeAvatar(){
                this.modalAvatar = false;
                this.loading = false;
            }
		}
	}
</script>