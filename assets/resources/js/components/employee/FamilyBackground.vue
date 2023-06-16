<script>
	let Cover = require('./Cover.vue');
    var phil = require('phil-reg-prov-mun-brgy')

	module.exports = {
		data: function(){
            return {
            	modal: false,
                modalText: '',
                familyBackground: [],
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
            computedProvinces() {
                return phil.getProvincesByRegion(this.form.region)
            },
            computedCityMun() {
                return phil.getCityMunByProvince(this.form.state_or_province)
            },
            computedBrgy() {
                return phil.getBarangayByMun(this.form.city)
            },
            familyBackgroundDisplay() {
                return this.familyBackground.map((family) => {
                    const region = family.address && this.regions.find((e) => e.reg_code === family.address.region);
                    const regionName = region ? region.name : '';

                    const state_or_province = family.address && region && phil.getProvincesByRegion(region.reg_code).find((e) => e.prov_code === family.address.state_or_province);
                    const state_or_province_name = state_or_province ? state_or_province.name : '';
                    
                    const city_mun = family.address && state_or_province && phil.getCityMunByProvince(state_or_province.prov_code).find((e) => e.mun_code === family.address.city);
                    const city_mun_name = city_mun ? city_mun.name : '';
                    return {
                        ...family,
                        address: {
                            ...family.address,
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
				this.modalText = 'Add Family Background';
                this.form = {};
                this.form = {
                    first_name: '',
                    middle_name: '',
                    last_name: '',
                    relationship: '',
                    address: '',
                    contact_number: '',
                    birthdate: '',
                    occupation: '',
                    assign_as_dependent: '',
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
				this.modalText = 'Edit Family Background';
                let familyBackground = this.familyBackground[index];
                this.form = {};
                this.form = {
                    id: familyBackground.id,
                    first_name: familyBackground.first_name,
                    middle_name: familyBackground.middle_name,
                    last_name: familyBackground.last_name,
                    relationship: familyBackground.relationship,
                    address: familyBackground.address,
                    contact_number: familyBackground.contact_number,
                    birthdate: familyBackground.birthdate,
                    occupation: familyBackground.occupation,
                    assign_as_dependent: familyBackground.assign_as_dependent,
                    age: familyBackground.age,
                    unit_building_residence_number: familyBackground.address && familyBackground.address.unit_building_residence_number ? familyBackground.address.unit_building_residence_number : '',
                    street: familyBackground.address && familyBackground.address.street ? familyBackground.address.street : '',
                    brgy: familyBackground.address && familyBackground.address.brgy ? familyBackground.address.brgy : '',
                    city: familyBackground.address && familyBackground.address.city ? familyBackground.address.city : '',
                    state_or_province: familyBackground.address && familyBackground.address.state_or_province ? familyBackground.address.state_or_province : '',
                    region: familyBackground.address && familyBackground.address.region ? familyBackground.address.region : '',
                    country: familyBackground.address && familyBackground.address.country ? familyBackground.address.country : '',
                    zip_code: familyBackground.address && familyBackground.address.zip_code ? familyBackground.address.zip_code : '',
                    permanent_address_id: familyBackground.address ? familyBackground.address : ''

                };
				this.modal = true;
			},

			fetchRecord(){
				let url = new URL(window.location.href);
                let pathname = url.pathname;
                let segment = pathname.split('/');
                let shortid = segment[3];
				let REST = base_url + 'employee/family-background/fetch';
                axios.post(REST, {shortid: shortid}).then(response => {
                	this.familyBackground = response.data.familyBackground;
                });
			}
		}
	}
</script>