<script>
    module.exports = {
        data: function(){
            return{
                notifications: [],
                notificationsCnt: 0
            }
        },

        mounted(){
            this.getNotification();
        },

        methods: {
            getNotification(){
                let url = base_url + 'notifications';
                axios.post(url).then(response => {
                    let record = response.data.record;
                    let count = response.data.count;
                    this.notificationsCnt = count;
                    this.notifications = record;
                });
            },

            setAsRead(id, url){
                let redirect = base_url + url;
                let request_url = base_url + 'notifications/read';
                axios.post(request_url,{id:id}).then(response => {
                    window.location.href = redirect;
                });
            }

        }

    }

</script>