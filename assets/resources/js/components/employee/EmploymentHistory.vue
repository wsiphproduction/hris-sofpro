<script>
	let Cover = require('./Cover.vue');
    var phil = require('phil-reg-prov-mun-brgy')

	module.exports = {
		data: function(){
            return {
            	modal: false,
                modalText: '',
                employmentHistory: [],
                regions: phil.regions,
                provinces: [],
                city_mun: [],
                barangays: [],
            }
		},

		mixins: [
			Form,
			Alert,
			Cover
		],

        mounted(){
			this.fetchRecord();
		},

        computed: {
            employmentHistoryDisplay() {
                return this.employmentHistory.map((employment) => {
                    const region = employment.address && this.regions.find((e) => e.reg_code === employment.address.region);
                    const regionName = region ? region.name : '';
                    const state_or_province = employment.address && this.provinces.find((e) => e.prov_code === employment.address.state_or_province);
                    const state_or_province_name = state_or_province ? state_or_province.name : '';
                    const city_mun = employment.address && this.city_mun.find((e) => e.mun_code === employment.address.city);
                    const city_mun_name = city_mun ? city_mun.name : '';
                    return {
                        ...employment,
                        address: {
                            ...employment.address,
                            region: regionName,
                            state_or_province: state_or_province_name,
                            city: city_mun_name
                        },
                    };
                });
            },
        },

		methods: {
            onRegionChange() {
                // Filter provinces based on the selected region
                let provinces = phil.getProvincesByRegion(this.form.region);
                this.provinces = provinces;
            },
            onProvinceChange() {
                // Filter cities based on the selected province
                let city_mun = phil.getCityMunByProvince(this.form.state_or_province);
                this.city_mun = city_mun;
            },
            onCityChange() {
                // Filter barangays based on the selected city
                let barangays = phil.getBarangayByMun(this.form.city);
                this.barangays = barangays;
            },
            numberOnly(e) {
                // Allow: backspace, delete, tab, escape, enter, decimal point
                if ([46, 8, 9, 27, 13, 110, 190].indexOf(e.keyCode) !== -1 ||
                    // Allow: Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+X
                    (e.keyCode === 65 && e.ctrlKey === true) ||
                    (e.keyCode === 67 && e.ctrlKey === true) ||
                    (e.keyCode === 86 && e.ctrlKey === true) ||
                    (e.keyCode === 88 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // Let it happen, don't do anything
                    return
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault()
                }
            },

            add(){
				this.method = 'post';
				this.modalText = 'Add Employment History';
                this.form = {};
                this.form = {
                    company: '',
                    position: '',
                    date_started: '',
                    date_ended: '',
                    reason_of_leaving: '',
                    unit_building_residence_number: '',
                    street: '',
                    brgy: '',
                    city: '',
                    state_or_province: '',
                    region: '',
                    country: '',
                    zip_code: '',
                };
				this.modal = true;
			},

            edit(index){
				this.method = 'put';
				this.modalText = 'Edit Employment History';
                let employmentHistory = this.employmentHistory[index];
                this.form = {};
                this.form = {
                    id: employmentHistory.id,
                    company: employmentHistory.company,
                    position: employmentHistory.position,
                    date_started: employmentHistory.date_started ? employmentHistory.date_started : new Date(),
                    date_ended: employmentHistory.date_ended ? employmentHistory.date_ended : new Date(),
                    reason_of_leaving: employmentHistory.reason_of_leaving,
                    unit_building_residence_number: employmentHistory.address && employmentHistory.address.unit_building_residence_number ? employmentHistory.address.unit_building_residence_number : '',
                    street: employmentHistory.address && employmentHistory.address.street ? employmentHistory.address.street : '',
                    brgy: employmentHistory.address && employmentHistory.address.brgy ? employmentHistory.address.brgy : '',
                    city: employmentHistory.address && employmentHistory.address.city ? employmentHistory.address.city : '',
                    state_or_province: employmentHistory.address && employmentHistory.address.state_or_province ? employmentHistory.address.state_or_province : '',
                    region: employmentHistory.address && employmentHistory.address.region ? employmentHistory.address.region : '',
                    country: employmentHistory.address && employmentHistory.address.country ? employmentHistory.address.country : '',
                    zip_code: employmentHistory.address && employmentHistory.address.zip_code ? employmentHistory.address.zip_code : '',
                    address_id: employmentHistory.address ? employmentHistory.address : ''
                };
				this.modal = true;
			},

			fetchRecord(){
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/employment-history/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
                	this.employmentHistory = response.data.employmentHistory;
                });
			}
		}
	}
</script>