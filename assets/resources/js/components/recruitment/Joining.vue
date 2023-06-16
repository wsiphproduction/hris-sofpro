<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Create New',
                form:{},
                previewModal: false,
                records: [],
                preview: {},
                init:{
                    nationalities: {},
                    companies: {},
                    departments: {},
                    job_titles: {},
                },
                fetching: true
            }
        },

        mixins: [
            Form,
            Alert,
            Archive
        ],

        mounted(){
            this.fetchRecord();
            this.initForm();
        },

        methods: {

            closeModal(){
                this.errors = {}
                this.form = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.modal = true;
                this.loading = false;
            },

            info(id){
                let API = base_url + 'recruitment/candidate-profile/edit';
                // axios.post(API, {id: id}).then(response => {
                //     let record = response.data.record;
                //     this.preview = {
                //         applicant: record.first_name +' '+ record.last_name,
                //         position: record.position_applying_for,
                //         birthday: moment(record.birthday).format('MMMM DD, YYYY'),
                //         gender: record.gender,
                //         nationality: record.country ? record.country : '—',
                //         marital_status: record.marital_status ? record.marital_status : '—',
                //         phone_number: record.phone_number ? record.phone_number : '—',
                //         alternate_number: record.alternate_number ? record.alternate_number : '—',
                //         email: record.email ? record.email : '—',
                //         attachment: record.attachment ? record.attachment : '—',
                //         sss_number: record.sss_number ? record.sss_number : '—',
                //         pagibig_number: record.pagibig_number ? record.pagibig_number : '—',
                //         philhealth_number: record.philhealth_number ? record.philhealth_number : '—',
                //         tin_number: record.tin_number ? record.tin_number : '—',
                //         current_address: record.current_address ? record.current_address : '—',
                //         permanent_address: record.permanent_address ? record.permanent_address : '—',
                //     }
                //     this.previewModal = true;
                // });
            },

            edit(id){
                let API = base_url + 'recruitment/joining/edit';
                axios.post(API, {id: id}).then(response => {
                    let candidate = response.data.candidate;
                    let requirements = response.data.requirements;

                    let birthday = candidate.birthday ? new Date(candidate.birthday) : '';
                        birthday = birthday ? birthday.toISOString() : '';
                    let start_date = '';
                    if(candidate.start_date && candidate.start_date != '0000-00-00'){
                        start_date = new Date(candidate.start_date);
                        start_date = start_date.toISOString();
                    }
                    
                    this.form = {
                        id: id,
                        position: candidate.position_applying_for,
                        first_name: candidate.first_name,
                        last_name: candidate.last_name,
                        birthday: birthday,
                        gender: candidate.gender,
                        nationality: candidate.nationality,
                        marital_status: candidate.marital_status,
                        phone_number: candidate.phone_number,
                        alternate_number: candidate.alternate_number,
                        email: candidate.email,
                        sss_number: candidate.sss_number,
                        pagibig_number: candidate.pagibig_number,
                        philhealth_number: candidate.philhealth_number,
                        tin_number: candidate.tin_number,
                        current_address: candidate.current_address,
                        permanent_address: candidate.permanent_address,
                        status: candidate.status,
                        company: candidate.company,
                        department: candidate.department,
                        job_title: candidate.job_title,
                        start_date: start_date,
                        requirements: []
                    }

                    if(requirements){

                        for(let i in requirements){
                            let status = requirements[i]['status'] ? requirements[i]['status'].toString() : '1';
                            this.form.requirements.push({
                                id: requirements[i]['id'] ? requirements[i]['id'] : '',
                                title: requirements[i]['title'],
                                status: status
                            });
                        }
                    }
                    this.modal = true;
                    this.loading = false;
                });
            },

            previewClose(){
                this.previewModal = false;
            },

            setPage(page){
                this.page = page;
                this.fetchRecord();
            },

            fetchRecord(){
                this.fetching = true;
                let requestUrl = base_url + 'recruitment/joining/fetch';
                axios.post(requestUrl).then(response => {
                    let records = response.data.records;
                    this.records = records;
                    this.fetching = false
                });
            },

            initForm(){
                
                let url = base_url + 'employee/init-form';

                axios.post(url).then(response =>{

                    
                    let companies = [];
                    let nationalities = [];
                    let departments = [];
                    let job_titles = [];

                    let company = response.data.companies;
                    let nationality = response.data.nationalities;
                    let department = response.data.departments;
                    let job_title = response.data.job_titles;

                    if(company.length){
                        for(let key in company){
                            companies.push({
                                text: company[key]['company']['name'] +' - '+ company[key]['location'],
                                value: company[key]['id']
                            });
                        }
                    }

                    if(nationality.length){
                        for(let key in nationality){
                            nationalities.push({
                                text: nationality[key]['name'],
                                value: nationality[key]['id']
                            });
                        }
                    }

                    if(department.length){
                        for(let key in department){
                            departments.push({
                                text: department[key]['title'],
                                value: department[key]['id']
                            });
                        }
                    }

                    if(job_title.length){
                        for(let key in job_title){
                            job_titles.push({
                                text: job_title[key]['title'],
                                value: job_title[key]['id']
                            });
                        }
                    }

                    this.init = {
                        nationalities: nationalities,
                        companies: companies,
                        departments: departments,
                        job_titles: job_titles,
                    }
                    /**/

                }).catch(error =>{

                });

            },
        }

    }

</script>