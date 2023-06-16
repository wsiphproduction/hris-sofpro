<script>

    let Cover = require('./Cover.vue');
    var phil = require('phil-reg-prov-mun-brgy')

    module.exports = {
        data: function(){
            return {
                alert: {},
                type: {},
                dateFormat:'MM/dd/yyyy',
                inputClass: 'form-control', 
                companies:[],
                divisions:[],
                departments:[],
                sections:[],
                positions:[],
                position_classifications:[],
                position_categories:[],
                locations:[],
                work_areas:[],
                nationalities:[],
                employment: false,
                emergencyContact: false,
                init:{},
                employments:[],
                emergencyContacts: [],
                regions: phil.regions,
                provinces: [],
                city_mun: [],
                barangays: [],
                address: [],
                bp_provinces: [],
                pa_provinces: [],
                ta_provinces: [],
                bp_city_mun: [],
                pa_city_mun: [],
                ta_city_mun: [],
                bp_brgy: [],
                pa_brgy: [],
                ta_brgy: [],     
                biometric_number: ''
            }
        },

        components: {
            
        },

        mounted(){
            this.initForm();
            this.fetchData();
        },

        mixins: [
            Form, 
            Modal, 
            Alert,
            Cover
        ],

        computed:{
            computedProvinces() {
                return phil.getProvincesByRegion(this.form.region)
            },
            computedCityMun() {
                return phil.getCityMunByProvince(this.form.state_or_province)
            },
            computedBrgy() {
                return phil.getBarangayByMun(this.form.city)
            },
            computedBpProvinces() {
                return phil.getProvincesByRegion(this.form.bp_region)
            },
            computedBpCityMun() {
                return phil.getCityMunByProvince(this.form.bp_state_or_province)
            },
            computedBpBrgy() {
                return phil.getBarangayByMun(this.form.bp_city_mun)
            },
            computedPaProvinces() {
                return phil.getProvincesByRegion(this.form.pa_region)
            },
            computedPaCityMun() {
                return phil.getCityMunByProvince(this.form.pa_state_or_province)
            },
            computedPaBrgy() {
                return phil.getBarangayByMun(this.form.pa_city_mun)
            },
            computedTaProvinces() {
                return phil.getProvincesByRegion(this.form.ta_region)
            },
            computedTaCityMun() {
                return phil.getCityMunByProvince(this.form.ta_state_or_province)
            },
            computedTaBrgy() {
                return phil.getBarangayByMun(this.form.ta_city_mun)
            },
            division(){
                return this.form.division;
            },
            department(){
                return this.form.department;
            },
            approving_organization(){
                return this.form.approving_organization;
            },
            emergencyContactsDisplay() {
                return this.emergencyContacts.map((emergencyContact) => {
                    const region = emergencyContact.address && this.regions.find((e) => e.reg_code === emergencyContact.address.region);
                    const regionName = region ? region.name : '';
                    
                    const state_or_province = emergencyContact.address && region && phil.getProvincesByRegion(region.reg_code).find((e) => e.prov_code ===  emergencyContact.address.state_or_province);
                    const state_or_province_name = state_or_province ? state_or_province.name : '';
                    
                    const city_mun = emergencyContact.address && state_or_province && phil.getCityMunByProvince(state_or_province.prov_code).find((e) => e.mun_code === emergencyContact.address.city);
                    const city_mun_name = city_mun ? city_mun.name : '';
                    return {
                        ...emergencyContact,
                        address: {
                            ...emergencyContact.address,
                            region: regionName,
                            state_or_province: state_or_province_name,
                            city: city_mun_name
                        },
                    };
                });
            },
            birthplace() {
                const bpAddress = this.address.find(address => address.type === 'bp');
                
                if (bpAddress) {
                    const region = this.regions.find((e) => e.reg_code === bpAddress.region);
                    const regionName = region ? region.name : '';
                    
                    const state_or_province = region && phil.getProvincesByRegion(region.reg_code).find((e) => e.prov_code === bpAddress.state_or_province);
                    const state_or_province_name = state_or_province ? state_or_province.name : '';    

                    const city_mun = state_or_province && phil.getCityMunByProvince(state_or_province.prov_code).find((e) => e.mun_code === bpAddress.city);
                    const city_mun_name = city_mun ? city_mun.name : '';
                    
                    return {
                        ...bpAddress,
                        birthPlaceAddress: bpAddress,
                        region: regionName,
                        state_or_province: state_or_province_name,
                        city: city_mun_name,
                    };
                } else {
                    return null; // Or any other value to indicate that no 'bp' address was found
                }
            },

            permanentAddress() {
                const paAddress = this.address.find(address => address.type === 'pa');
                if (paAddress) {
                    const region = this.regions.find((e) => e.reg_code === paAddress.region);
                    const regionName = region ? region.name : '';
                    
                    const state_or_province = region && phil.getProvincesByRegion(region.reg_code).find((e) => e.prov_code === paAddress.state_or_province);
                    const state_or_province_name = state_or_province ? state_or_province.name : '';
    
                    const city_mun = state_or_province && phil.getCityMunByProvince(state_or_province.prov_code).find((e) => e.mun_code === paAddress.city);
                    const city_mun_name = city_mun ? city_mun.name : '';
                    
                    return {
                        ...paAddress,
                        userPermanentAddress: paAddress,
                        region: regionName,
                        state_or_province: state_or_province_name,
                        city: city_mun_name
                    };
                } else {
                    return null; // Or any other value to indicate that no 'pa' address was found
                }
            },
            temporaryAddress() {
                const taAddress = this.address.find(address => address.type === 'ta');
                if (taAddress) {
                    const region = this.regions.find((e) => e.reg_code === taAddress.region);
                    const regionName = region ? region.name : '';
                    
                    const state_or_province = region && phil.getProvincesByRegion(region.reg_code).find((e) => e.prov_code === taAddress.state_or_province);
                    const state_or_province_name = state_or_province ? state_or_province.name : '';
                    
                    const city_mun = state_or_province && phil.getCityMunByProvince(state_or_province.prov_code).find((e) => e.mun_code === taAddress.city);
                    const city_mun_name = city_mun ? city_mun.name : '';
                    
                    return {
                        ...taAddress,
                        userTemporaryAddress: taAddress,
                        region: regionName,
                        state_or_province: state_or_province_name,
                        city: city_mun_name
                    };
                } else {
                    return null; // Or any other value to indicate that no 'ta' address was found
                }
            }
        },

        watch:{
            division(){
                this.departments=[];
                this.sections=[];
                // this.form.department='';
                // this.form.section='';
                // this.form.approving_organization = '';
                // this.form.approving_manager = '';
                let division_id = this.form.division;
                let departments = this.init.departments;
                this.departments = departments.filter(function(arr){return arr.division_id == division_id});
            },
            department(){
                this.sections=[];
                // this.form.section='';
                // this.form.approving_organization = '';
                // this.form.approving_manager = '';
                let department_id = this.form.department;
                let array = this.init.sections;
                this.sections = array.filter(function(arr){return arr.department_id == department_id});
            },
            approving_organization(){
                let org = this.form.approving_organization;
                this.form.approving_manager = '';
                if(org == 'division'){
                    let array = this.divisions;
                    let id = this.form.division;
                    let obj = array.filter(function(arr){return arr.id == id})[0];
                    if(typeof obj != 'undefined' && obj && obj.manager){
                        this.form.approving_manager_id = obj.manager ? obj.manager.id : '';
                        this.form.approving_manager = obj.manager ? obj.manager.first_name+' '+obj.manager.last_name:'';
                        this.form.secondary_approver_id = obj.assistant_manager_id ? obj.assistant_manager_id : '';
                    }
                    this.form.secretary_id = obj.secretary_id ? obj.secretary_id : '';
                    this.form.alternate_secretary = obj.alternate_secretary ? obj.alternate_secretary : '';
                    
                }else if(org=='department'){
                    let array = this.departments;
                    let id = this.form.department;
                    let obj = array.filter(function(arr){return arr.id == id})[0];
                    if(typeof obj != 'undefined' && obj && obj.manager){
                        this.form.approving_manager_id = obj.manager ? obj.manager.id : '';
                        this.form.approving_manager = obj.manager ? obj.manager.first_name+' '+obj.manager.last_name:'';
                        this.form.secondary_approver_id = obj.assistant_manager_id ? obj.assistant_manager_id : '';
                    }
                    this.form.secretary_id = obj.secretary_id ? obj.secretary_id : '';
                    this.form.alternate_secretary = obj.alternate_secretary ? obj.alternate_secretary : '';
                    this.form.hr_generalist_id = obj.hr_generalist_id ? obj.hr_generalist_id : '';
                }else if(org=='section'){
                    let array = this.sections;
                    let id = this.form.section;
                    let obj = array.filter(function(arr){return arr.id == id})[0];
                    if(typeof obj != 'undefined' && obj && obj.supervisor){
                        this.form.approving_manager_id = obj.supervisor ? obj.supervisor.id : '';
                        this.form.approving_manager = obj.supervisor ? obj.supervisor.first_name+' '+obj.supervisor.last_name:'';
                        this.form.secondary_approver_id = obj.assistant_supervisor_id ? obj.assistant_supervisor_id : '';
                    }
                    this.form.secretary_id = obj.secretary_id ? obj.secretary_id : '';
                    this.form.alternate_secretary = obj.alternate_secretary ? obj.alternate_secretary : '';
                }
            }
        },

        methods: {
            onRegionChange(type) {
                // Filter provinces based on the selected region
                switch (type) {
                    case 'birth_place':
                        if (this.form.bp_region) {
                            let bp_provinces = phil.getProvincesByRegion(this.form.bp_region);
                            this.bp_provinces = bp_provinces;
                        }
                        break;
                    case 'permanent_address':
                        if (this.form.pa_region){
                            let pa_provinces = phil.getProvincesByRegion(this.form.pa_region);
                            this.pa_provinces = pa_provinces;
                        }
                        break;
                    case 'temporary_address':
                        if (this.form.ta_region){
                            let ta_provinces = phil.getProvincesByRegion(this.form.ta_region);
                            this.ta_provinces = ta_provinces;
                        }
                        break;
                    default:
                        if (this.form.region){
                            let provinces = phil.getProvincesByRegion(this.form.region);
                            this.provinces = provinces;
                        }
                        break;
                }

            },
            onProvinceChange(type) {
                // Filter cities based on the selected province
                switch (type) {
                    case 'birth_place':
                        if (this.form.bp_state_or_province){
                            let bp_city_mun = phil.getCityMunByProvince(this.form.bp_state_or_province);
                            this.bp_city_mun = bp_city_mun;
                        }
                        break;
                    case 'permanent_address':
                        if (this.form.pa_state_or_province){
                            let pa_city_mun = phil.getCityMunByProvince(this.form.pa_state_or_province);
                            this.pa_city_mun = pa_city_mun;
                        }
                        break;
                    case 'temporary_address':
                        if (this.form.ta_state_or_province){
                            let ta_city_mun = phil.getCityMunByProvince(this.form.ta_state_or_province);
                            this.ta_city_mun = ta_city_mun;
                        }
                        break;
                    default:
                        if (this.form.state_or_province){
                            let city_mun = phil.getCityMunByProvince(this.form.state_or_province);
                            this.city_mun = city_mun;
                        }
                        break;
                }
            },
            onCityChange(type) {
                // Filter barangays based on the selected city
                switch (type) {
                    case 'birth_place':
                        if (this.form.bp_city){
                            let bp_brgy = phil.getBarangayByMun(this.form.bp_city);
                            this.bp_brgy = bp_brgy;
                        }
                        break;
                    case 'permanent_address':
                        if (this.form.pa_city){
                            let pa_brgy = phil.getBarangayByMun(this.form.pa_city);
                            this.pa_brgy = pa_brgy;
                        }
                        break;
                    case 'temporary_address':
                        if (this.form.ta_city){
                            let ta_brgy = phil.getBarangayByMun(this.form.ta_city);
                            this.ta_brgy = ta_brgy;
                        }
                        break;
                    default:
                        if (this.form.city){
                            let brgy = phil.getBarangayByMun(this.form.city);
                            this.barangays = brgy;
                        }
                        break;
                }
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

            exportUser(userID){
                let API = base_url + 'employee/general/export';
                let filename = moment().format('YYYYMMDDHHmmss');
                axios.post(API, { userID: userID })
                .then(response => {
                    const url = window.URL.createObjectURL(new Blob([response.data]));
                    const link = document.createElement('a');
                    link.href = url;
                    link.setAttribute('download', `${filename}.csv`);
                    document.body.appendChild(link);
                    link.click();
                })
                .catch(error => {
                    console.error(error);
                });
            },
            addEmergencyContact(user_id){
                this.method = 'post';
                this.modalText = 'Add Emergency Contact';
                this.form = {
                    user_id: user_id,
                    first_name: '',
                    middle_name: '',
                    last_name: '',
                    relationship: '',
                    contact_number: '',
                    unit_building_residence_number: '',
                    street: '',
                    brgy: '',
                    city: '',
                    state_or_province: '',
                    region: '',
                    country: '',
                    zip_code: '',

                };
                this.emergencyContact = true;
            },
            addEmployment(user_id){
                this.method = 'post';
                this.modalText = 'Add Employment';
                this.form = {
                    user_id: user_id,
                    company: '',
                    division:'',
                    department: '',
                    section:'',
                    position:'',
                    position_classification:'',
                    position_category:'',
                    location:'',
                    work_area:'',
                    approving_organization:'',
                    approving_manager:'',
                    start_date: '',
                    employee_type: '',
                    status: '',
                    employee_number: '',
                    cost_center: '',
                    union_member: '',
                    insurance_entitlement: '',
                    type_of_separation: '',
                    statutory_number: '',
                    medical_condition: '',
                    job_description: ''
                }
                this.employment = true;
            },

            editEmergencyContact(index){
                let emergencyContact = this.emergencyContacts[index]
                this.form = {
                    id: emergencyContact.id,
                    user_id: emergencyContact.user_id,
                    first_name: emergencyContact.first_name,
                    middle_name: emergencyContact.middle_name,
                    last_name: emergencyContact.last_name,
                    relationship: emergencyContact.relationship,
                    contact_number: emergencyContact.contact_number, 
                    unit_building_residence_number: emergencyContact.address && emergencyContact.address.unit_building_residence_number ? emergencyContact.address.unit_building_residence_number : '',
                    street: emergencyContact.address && emergencyContact.address.street ? emergencyContact.address.street : '',
                    brgy: emergencyContact.address && emergencyContact.address.brgy ? emergencyContact.address.brgy : '',
                    city: emergencyContact.address && emergencyContact.address.city ? emergencyContact.address.city : '',
                    state_or_province: emergencyContact.address && emergencyContact.address.state_or_province ? emergencyContact.address.state_or_province : '',
                    region: emergencyContact.address && emergencyContact.address.region ? emergencyContact.address.region : '',
                    country: emergencyContact.address && emergencyContact.address.country ? emergencyContact.address.country : '',
                    zip_code: emergencyContact.address && emergencyContact.address.zip_code ? emergencyContact.address.zip_code : '',
                    permanent_address_id: emergencyContact.address ? emergencyContact.address : ''                    
                };
                this.method = 'put';
                this.modalText = 'Edit Emergency Contact';
                this.emergencyContact = true;
            },

            editEmployement(index){
                let employment = this.employments[index]
                let start_date = new Date(employment.date_entry);
                    start_date = start_date.toISOString();
                this.form = {
                    id: employment.id,
                    user_id: employment.user_id,
                    company: employment.company_id,
                    division: employment.division_id,
                    department: employment.department_id,
                    section: employment.section_id,
                    position: employment.position_id,
                    position_classification: employment.position_classification_id,
                    position_category: employment.position_category_id,
                    location: employment.location_id,
                    work_area: employment.work_area_id,
                    approving_organization: employment.approving_organization,
                    // approving_manager: '',
                    start_date: start_date,
                    status: employment.employment.status,
                    approving_manager_id: employment.approving_manager_id,
                    secretary_id: employment.secretary_id,
                    alternate_secretary: employment.alternate_secretary,
                    employee_type: employment.employee_type,
                    employee_number: employment.employment.employee_number,
                    cost_center: employment.cost_center,
                    union_member: employment.union_member,
                    insurance_entitlement: employment.insurance_entitlement,
                    type_of_separation: employment.type_of_separation,
                    statutory_number: employment.statutory_number,
                    medical_condition: employment.medical_condition,
                    job_description: employment.job_description,
                    biometric_number: this.biometric_number,
                }
                
                this.method = 'put';
                this.modalText = 'Edit Employment';
                // this.form = {
                //     id: id,
                //     company: company,
                //     department: department,
                //     job_title: job_title,
                //     team: team,
                //     start_date: date ? date_entry : ''
                // }
                this.employment = true;
            },

            closeEmployment(){
                this.employment = false;
                this.loading = false;
                this.errors = {}
                this.form = {}
            },
            fetchData(){
                let pathname = window.location.pathname;
                let slug = pathname.split('/');
                    slug = slug[slug.length - 1];
                let API = base_url + 'employee/general/fetch';
                axios.post(API,{
                    slug: slug
                }).then(response =>{
                    this.employments = response.data.employments;
                    this.emergencyContacts = response.data.emergencyContacts;
                    this.address = response.data.address;
                    this.biometric_number = response.data.biometric_number;
                }).catch(error =>{
                    console.log(error)
                });
            },

            initForm(){
                
                let url = base_url + 'employee/init-form';

                axios.post(url).then(response =>{
                    let nationalities = [];
                    let employee_types = [];

                    this.companies = response.data.companies;
                    this.divisions = response.data.divisions;
                    
                    this.init.departments = response.data.departments;
                    this.init.sections = response.data.sections;
                    let nationality = response.data.nationalities;
                    let employee_type = response.data.employee_type;
                    this.positions = response.data.positions;
                    this.position_classifications = response.data.position_classifications;
                    this.position_categories = response.data.position_categories;
                    this.locations = response.data.locations;
                    this.work_areas = response.data.work_areas;
                
                    if(nationality.length){
                        for(let key in nationality){
                            nationalities.push({
                                text: nationality[key]['name'],
                                value: nationality[key]['id']
                            });
                        }
                    }  

                    if(employee_type.length){
                        for(let key in employee_type){
                            employee_types.push({
                                text: employee_type[key]['name'],
                                value: employee_type[key]['id']
                            });
                        }
                    } 
                    this.init.nationalities = nationalities;
                    this.init.employee_types = employee_types;
                    // this.init = {
                    //     nationalities: nationalities,
                    //     employee_types: employee_types
                    // }
                }).catch(error =>{

                });

            },

            edit(id, type, form=null){

                this.form = {};
                this.type = {};
                this.method = 'put';
                
                let url = base_url + 'employee/userinfo';
                
                axios.post(url, {id: id}).then(response =>{
                    
                    let record = response.data.record;
                    if(type == 'personal'){
                        //let bday = record.employee.birthdate.split('-');
                        this.modalText = 'Edit Personal';

                        this.type.personal = true;
                        let birthday = new Date(record.employee.birthdate);
                            birthday = birthday.toISOString();
                        this.form = {
                            id: record.employee.id,
                            user_id: record.employee.id,
                            employee_number: record.employee.employee_number,
                            first_name: record.employee.first_name,
                            middle_name: record.employee.middle_name,
                            last_name: record.employee.last_name,
                            suffix: record.employee.suffix,
                            nick_name: record.employee.nick_name,
                            team: record.employee.team_id,
                            gender: record.employee.gender,
                            birthday: birthday,
                            marital_status: record.employee.marital_status,
                            email: record.employee.email,
                            contact_number: record.employee.contact_number,
                            nationality: record.employee.nationality,
                            current_address: record.employee.present_address,
                            permanent_address: record.employee.permanent_address,
                            sss_number: record.employee.sss_number,
                            pagibig_number: record.employee.pagibig_number,
                            tin_number: record.employee.tin_number,
                            philhealth_number: record.employee.philhealth_number,
                            type: type,
                            user_type: record.employee.user_type,
                            employee_type: record.employee.employee_type,
                            salary_type: record.employee.salary_type,
                            tribe: record.employee.tribe,
                            height: record.employee.height,
                            weight: record.employee.weight,
                            religion: record.employee.religion,
                            blood_type: record.employee.blood_type,
                            is_solo_parent: record.employee.is_solo_parent,
                            is_with_disability: record.employee.is_with_disability,
                            citizenship: record.employee.citizenship,
                            break_type: record.employee.break_type,
                            roster_break: record.employee.roster_break,
                            birthplace: record.employee.birthplace,
                            destination_entitlement: record.employee.destination_entitlement,
                            type_of_disability: record.employee.type_of_disability,
                            
                            bp_country: this.birthplace && this.birthplace.country ? this.birthplace.country : null,
                            bp_region: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.region : null,
                            bp_state_or_province: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.state_or_province : null,
                            bp_city_mun: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.city : null,
                            bp_brgy: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.brgy : null,
                            bp_unit_building_residence_number: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.unit_building_residence_number : null,
                            bp_street: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.street : null,
                            bp_zip_code: this.birthplace && this.birthplace.birthPlaceAddress ? this.birthplace.birthPlaceAddress.zip_code : null,
                            
                            pa_country: this.permanentAddress && this.permanentAddress.country ? this.permanentAddress.country : null,
                            pa_region: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.region : null,
                            pa_state_or_province: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.state_or_province : null,
                            pa_city_mun: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.city : null,
                            pa_brgy: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.brgy : null,
                            pa_unit_building_residence_number: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.unit_building_residence_number : null,
                            pa_street: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.street : null,
                            pa_zip_code: this.permanentAddress && this.permanentAddress.userPermanentAddress ? this.permanentAddress.userPermanentAddress.zip_code : null,
                    
                            ta_country: this.temporaryAddress && this.temporaryAddress.country ? this.temporaryAddress.country : null,
                            ta_region: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.region : null,
                            ta_state_or_province: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.state_or_province : null,
                            ta_city_mun: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.city : null,
                            ta_brgy: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.brgy : null,
                            ta_unit_building_residence_number: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.unit_building_residence_number : null,
                            ta_street: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.street : null,
                            ta_zip_code: this.temporaryAddress && this.temporaryAddress.userTemporaryAddress ? this.temporaryAddress.userTemporaryAddress.zip_code : null
                        }
                        
                    }else if(type == 'login'){

                        this.modalText = 'Edit Login';
                        this.type.login = true;
                        this.form = {
                            id: record.employee.id,
                            email: record.employee.email,
                            status: record.employee.status,
                            type: type
                        }
                    }else if(type == 'education'){
                        
                        this.modalText = 'Edit Educational';
                        this.type.education = true;
                        let school_id = record.education != null && record.education.id != null ? record.education.id : '';
                        let school = record.education != null && record.education.school != null ? record.education.school : '';
                        let degree = record.education != null && record.education.degree != null ? record.education.degree : '';
                        let year_attended = record.education != null && record.education.year_attended != null ? record.education.year_attended : '';
                        let post_graduate = record.education != null && record.education.post_graduate != null ? record.education.post_graduate : '';
                        let others = record.education != null && record.education.others != null ? record.education.others : '';
                        this.form = {
                            id: record.employee.id,
                            school_id: school_id,
                            school: school,
                            degree: degree,
                            year_attended: year_attended,
                            post_graduate: post_graduate,
                            others: others,
                            type: type
                        }
                    }else if(type == 'work'){
                        this.modalText = 'Edit Employment';
                        this.type.work = true;
                        let date_entry = new Date(record.employee.date_entry);
                            date_entry = date_entry.toISOString();
                        this.form = {
                            id: record.employee.id,
                            company: record.employee.company_branch_id,
                            department: record.employee.department_id,
                            job_title: record.employee.job_title_id,
                            team: record.employee.team_id,
                            start_date: date_entry,
                            team: record.employee.team_id,
                            type: type,
                        } 
                    }
                    this.modal = true;

                });
            }

        }

    }

</script>