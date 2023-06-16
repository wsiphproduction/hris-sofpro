

const development = true;

if(!development){
	console.log = function() {}
}
/*
|------------------------------------------------
| Packages
|------------------------------------------------
*/
let moment = require('moment-timezone');
moment.tz.setDefault('Asia/Manila');
let token = document.head.querySelector('meta[name="csrf-token"]');
let base_url = document.getElementsByTagName('base')[0].href;
window._ = require('lodash');
/*
|------------------------------------------------
| Import Axios
|------------------------------------------------
*/
window.axios = require('axios');
window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

if (token) {
    window.axios.defaults.headers.common['CSRF-Token'] = token.content;
    window.token = token.content;
} else {
    console.error('CSRF token not found.');
}

/*
|------------------------------------------------
| Package Import
|------------------------------------------------
*/
import { Datetime } from 'vue-datetime';
import Calendar from './vue-fullcalendar/Calendar.vue';
import YearCalendar from 'v-year-calendar';
import MonthPickerInput from './month-picker/src/MonthPickerInput.vue'
import PrettyCheck from 'pretty-checkbox-vue/check';
import PrettyRadio from 'pretty-checkbox-vue/radio';
import Carbon from './prototype/Carbon.js';
import Global from './prototype/Global.js';
import Attendance from './prototype/Attendance.js';
import vuescroll from 'vuescroll';
import VCalendar from 'v-calendar';
import DatePicker from './components/AirDatepicker';
import {_} from 'vue-underscore';
import DatePicker2 from 'vue2-datepicker';
import Multiselect from 'vue-multiselect'
/*
|------------------------------------------------
| Requires
|------------------------------------------------
*/

window.Vue 		= require('vue');
window.base_url = base_url;
window.moment 	= moment;
window.Form 	= require('./mixins/Form.vue');
window.Alert 	= require('./mixins/Alert.vue');
window.Modal 	= require('./mixins/Modal.vue');
window.Archive 	= require('./mixins/Archive.vue');
window.Fetch    = require('./mixins/Fetch.vue');
window.EventCalendar = require('./mixins/EventCalendar.vue');
window.arrayToTree = require('array-to-tree');
window.YearCalendar = YearCalendar;


/*
|------------------------------------------------
| Components
|------------------------------------------------
*/
require('./components/Install');
require('./components/Password');
require('./components/Auth');
require('./components/Global');
require('./components/Home');
require('./components/Employee');
require('./components/Forms');
require('./components/Attendance');
require('./components/Settings');
require('./components/Approval');
require('./components/Recruitment');
require('./components/Payment');
require('./components/Myaccount');
require('./components/Announcement');
require('./components/accounts');
require('./components/CustomLeave');
require('./components/CustomForm');
//GROUPS
//Vue.component('air-datepicker', AirDatepicker);
Vue.component('datetime', Datetime);
Vue.component('date-picker-2', DatePicker2);
Vue.component('Calendar', Calendar);
Vue.component('p-check', PrettyCheck);
Vue.component('p-radio', PrettyRadio);
Vue.component('date-picker', DatePicker);
Vue.component('month-picker-input', MonthPickerInput);
Vue.component('multiselect', Multiselect)
//Prototype
Vue.prototype.moment = moment;
//Vue.prototype.$escape = escape;
Vue.prototype.$Carbon = Carbon;
Vue.prototype.$Global = Global;
Vue.prototype.$Attendance = Attendance;
if(typeof CKEditor != 'undefined'){
    Vue.use( CKEditor );
}
//Vue.use( AirDatepicker );
Vue.use(VCalendar, {
    componentPrefix: 'vc',
});
Vue.use(vuescroll, {
    ops: {
        bar: {
            background: '#6c757d',
            opacity: 0.8,
        }
    },
    name: 'vuescroll', // customize component name, default -> vueScroll

});
/*
|------------------------------------------------
| Vue Instance
|------------------------------------------------
*/
new Vue({
    el: '#app',

    data(){
    	return{
            user_role: {},
            //userRole: {},
    		fluid: false,
            winWidth: document.documentElement.clientWidth,
    	}
    },

    mounted(){
        this.handleResize();
    },

    beforeDestroy(){
    },

    created(){
        window.addEventListener('resize', this.handleResize);
    },

    destroyed(){
        window.removeEventListener('resize', this.handleResize);
    },

    methods:{
    	fullWidth(){
    		this.fluid = !this.fluid;
    	},

        handleResize(e){
            this.winWidth = document.documentElement.clientWidth;
            
            if(this.winWidth < 960){
                this.fluid = true;
            }else{
                this.fluid = false;
            }
        },
    },

    
});