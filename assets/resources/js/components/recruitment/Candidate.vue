<script>
    module.exports = {
        data: function(){
            return{
                modal: false,
                modalText: 'Create New',
                form:{},
                previewModal: false,
                records: [],
                counts: 0,
                limit: 25,
                page: 1,
                preview: {},
                fetching: true,
                pgRole: {}
            }
        },

        mixins: [
            Form,
            Alert,
            Archive
        ],

        mounted(){
            this.fetchRecord();
            //this.setRole();
        },

        methods: {

            closeModal(){
                this.errors = {}
                this.form = {}
                this.modal = false;
                this.loading = false;
            },

            openModal(){
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            info(id){
                let API = base_url + 'recruitment/candidate-profile/edit';
                axios.post(API, {id: id}).then(response => {
                    let record = response.data.record;
                    this.preview = {
                        applicant: record.first_name +' '+ record.last_name,
                        position: record.position_applying_for,
                        birthday: moment(record.birthday).format('MMMM DD, YYYY'),
                        gender: record.gender,
                        nationality: record.country ? record.country : '—',
                        marital_status: record.marital_status ? record.marital_status : '—',
                        phone_number: record.phone_number ? record.phone_number : '—',
                        alternate_number: record.alternate_number ? record.alternate_number : '—',
                        email: record.email ? record.email : '—',
                        attachment: record.attachment ? record.attachment : '—',
                        sss_number: record.sss_number ? record.sss_number : '—',
                        pagibig_number: record.pagibig_number ? record.pagibig_number : '—',
                        philhealth_number: record.philhealth_number ? record.philhealth_number : '—',
                        tin_number: record.tin_number ? record.tin_number : '—',
                        current_address: record.current_address ? record.current_address : '—',
                        permanent_address: record.permanent_address ? record.permanent_address : '—',
                    }
                    this.previewModal = true;
                });
            },

            edit(id){
                this.method = 'put';
                let API = base_url + 'recruitment/candidate-profile/edit';
                axios.post(API, {id: id}).then(response => {
                    let record = response.data.record;
                    let birthday = new Date(record.birthday);
                        birthday = birthday.toISOString();
                    this.form = {
                        id: record.id,
                        position: record.position_applying_for,
                        first_name: record.first_name,
                        last_name: record.last_name,
                        birthday: birthday,
                        gender: record.gender,
                        nationality: record.nationality,
                        marital_status: record.marital_status,
                        phone_number: record.phone_number,
                        alternate_number: record.alternate_number,
                        email: record.email,
                        sss_number: record.sss_number,
                        pagibig_number: record.pagibig_number,
                        philhealth_number: record.philhealth_number,
                        tin_number: record.tin_number,
                        current_address: record.current_address,
                        permanent_address: record.permanent_address,
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
                let requestUrl = base_url + 'recruitment/candidate-profile/fetch?limit='+ this.limit +'&page='+ this.page;
                axios.post(requestUrl).then(response => {
                    let records = response.data.records;
                    this.records = records;
                    this.counts = response.data.count;
                    this.fetching = false;
                });
            }
        }

    }

</script>