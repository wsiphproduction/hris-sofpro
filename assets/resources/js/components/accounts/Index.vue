<script>
    //const draggable = require('vuedraggable');
	module.exports = {

		data: function(){
			return{
                form: {},
                records: [],
                counts: 0,
                fetching: true,
                minDate: '',
                sale_option: [],
                fetch_type: 'all',
                action: '',
                param: {
                    start: '',
                    end: '',
                    limit: 25,
                    page: 1
                },
                form_input: '',
                chase: [],
                win: [],
                loss: [],
                drops: [],
                members: []
			}
		},

        components: {
            
        },

		mounted(){
			this.fetchRecord();
            this.fetchWin();
            this.fetchLoss();
            this.fetchDrop();
            this.init();
		},

		mixins: [
			Form,
			Alert,
            Archive,
            Modal
		],

		computed: {
            start(){
                return this.param.start;
            },
            end(){
                return this.param.end;
            },
            limit(){
                return this.param.limit;
            }
		},

		watch: {
            start(){
                this.minDate = this.param.start;
                this.param.end = '';
                this.validate();
            },
            end(){
                this.validate();
            },
            limit(){
                this.param.page = 1;
                this.fetchRecord();
            },
		},

        methods: {
            openModal(){
                this.action = './accounts';
                this.form_input = 'create';
                this.modalText = 'Create New',
                this.form = {
                    type: '',
                    sales: ''
                }
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            drag(index, event){
                event.dataTransfer.setData("index", index);
                event.target.style.opacity = "1";
            },

            drop(event){
                let index = event.dataTransfer.getData("index");
                let target = event.target.id;
                event.target.classList.remove('onHover');
                this.setCollection(target, index);
            },

            allowDrop(event){
                event.preventDefault();
            },

            dragenter(event){
                event.target.classList.add('onHover');
            },

            dragleave(event){
                event.target.classList.remove('onHover');
            },

            setPage(page){
                this.param.page = page;
                this.fetchRecord();
            },

            reset(){
                this.param = {
                    start: '',
                    end: '',
                    status: '',
                    limit: 25,
                    page: 1
                }
                this.fetchRecord();
            },

            fetchRecord(){
                let REST = base_url + 'accounts/fetch/chase';
                axios.post(REST).then(response => {
                    this.chase = response.data.chase;
                });
            },

            fetchWin(){
                console.log('fetchWin');
            },

            fetchLoss(){

            },

            fetchDrop(){

            },

            init(){
                let REST = base_url + 'accounts/init';
                axios.post(REST).then(response => {
                    this.sale_option = response.data.sale_option;
                    this.members = response.data.members;
                });
            },

            isNumber(evt){
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode !== 46) {
                    evt.preventDefault();;
                } else {
                    return true;
                }
            },

            setCollection(target, index){
                if(target == 'win'){
                    this.showFormWin(index);
                }else{
                    this.showFormLossDrop(target, index);
                }
            },

            removeMember(index){
                this.form.member.splice(index, 1);
            },

            addMember(){
                this.form.member.push({
                    user_id: ''
                });
            },

            showFormWin(index){
                
                let record = this.chase;
                    record = record[index];
                   console.log(record); 
                this.action = './accounts/win';
                this.form_input = 'win';
                this.modalText = 'Create Win',
                this.form = {
                    chase_id: record.id,
                    member: [{
                        user_id: ''
                    }]
                }
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            showFormLossDrop(){

            }

		}

	}

</script>