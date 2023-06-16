<script>
    module.exports = {
          
        data: function(){

            return{
                form:{},
                user: null,
                method: 'put',
                fetching: true
            }
        },

        mixins: [
            Form,
        ],

        mounted(){
            this.fetchRecord();
        },

        methods: {

            fetchRecord(){
                this.fetching = true;
                let REST = window.location.href;
                axios.post(REST).then(response => {
                    let user = response.data.user;
                    this.user = user;
                    this.form = {
                        id: user ? user.id : '',
                        first_name: user ? user.first_name : '',
                        last_name: user ? user.last_name : '',
                    }
                    this.fetching = false;
                });
            }

        }

    }

</script>