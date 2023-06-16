<template>
    <div class="full-calendar-header">
        <div class="header-left">
            <span class="prev-month" @click.stop="goPrev" v-html="leftArrow"></span>
        </div>
        
        <div class="header-center">
            <span class="title" v-text="title"></span>
        </div>

        <div class="header-right">
            <span class="next-month" @click.stop="goNext" v-html="rightArrow"></span>
        </div>
    </div>
</template>

<script type="text/babel">
    import dateFunc from './dateFunc'

    export default {
        created () {
            this.dispatchEvent()
        },

        props : {
            currentDate : {},
            titleFormat : {},
            firstDay    : {},
            monthNames  : {}
        },
        
        data () {
            return {
                title      : '',
                leftArrow  : '<i class="mdi mdi-arrow-left"></i>',
                rightArrow : '<i class="mdi mdi-arrow-right"></i>',
                headDate : new Date()
            }
        },

        watch : {
            currentDate (val) {
                if (!val) return
                this.headDate = val;
            }
        },

        methods : {
            goPrev () {
                this.headDate = this.changeMonth(this.headDate, -1)
                this.dispatchEvent()
            },

            goNext () {
                this.headDate = this.changeMonth(this.headDate, 1)
                this.dispatchEvent()
            },
            
            changeMonth (date, num) {
                let dt = new Date(date)
                return new Date(dt.setMonth(dt.getMonth() + num))
            },
            
            dispatchEvent() {
                this.title = dateFunc.format(this.headDate, this.titleFormat, this.monthNames);

                let startDate = dateFunc.getStartDate(this.headDate);
                let curWeekDay = startDate.getDay()

                let diff = parseInt(this.firstDay) - curWeekDay;

                if (diff) diff -= 7
                startDate.setDate(startDate.getDate() + diff) ;

                // the month view is 6*7
                let endDate = dateFunc.changeDay(startDate, 41);

                // 1st day of current month
                let currentDate = dateFunc.getStartDate(this.headDate);

                this.$emit('change', 
                    dateFunc.format(startDate, 'yyyy-MM-dd'),
                    dateFunc.format(endDate, 'yyyy-MM-dd'),
                    dateFunc.format(currentDate,'yyyy-MM-dd'),
                    this.headDate
                );
            }
        }
    }
</script>