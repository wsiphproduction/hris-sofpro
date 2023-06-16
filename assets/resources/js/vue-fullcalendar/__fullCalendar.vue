<template>
    <full-calendar :events="events" lang="en"></full-calendar>
</template>
<script type="text/babel">
    
    export default {
        data () {
            return {
                events : [
                    {
                        title : 'Sunny Out of Office',
                        start : '2019-05-05'
                    },
                    {
                        title : 'Sunny Out of Office',
                        start : '2019-05-10'
                    }
                ]
            }
        },
        components : {
            'full-calendar': require('vue-fullcalendar')  
        }
    }
</script>
