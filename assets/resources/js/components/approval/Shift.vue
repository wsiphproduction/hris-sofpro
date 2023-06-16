<script>
    let Approval = require('./Approval');

    module.exports = {
        data: function(){
            return{
                users:[]
            }
        },

        mixins: [
            Approval
        ],

        computed:{

        },

        watch:{

        },

        mounted(){
            this.fetch_user();
        },

        methods: {
            applicant(){
                this.fetchRecord();
            },

            fetch_user(){
                this.param.applicant = '';
                this.users = [];
                let url = base_url + 'approvals/shift/fetch-user';
                axios.post(url).then(response => {
                    let users = response.data.users;
                    this.users = users;
                });
            }
        }
    }
</script>