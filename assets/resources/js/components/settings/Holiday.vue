
<template>
  <div>
    <multiselect 
        v-model="form.location"
        :options="locations">
    </multiselect>
  </div>
</template>

<script>
	module.exports = {

		data: function(){
			return{
                modalText: 'Create New',
                modal: false,
                form:{
                    location: [],
                    type: '',
                    status: 1,
                },
                previewModal: false,
                locations: {},
                events: [],
			}
		},

		mounted(){
			this.initForm();
		},

		mixins: [
			Form,
			Alert,
            Archive
		],

		computed: {

		},

		watch: {

		},

        methods: {
            open(){
                this.errors = {}
                this.method = 'post';
                this.modal = true;
                this.loading = false;
            },

            close(){
                this.errors = {}
                this.form = {
                    location: [],
                    type: '',
                    status: 1,
                }
                this.modal = false;
                this.loading = false;
            },

            preview(id){
                let url = base_url + 'forms/leave/edit';
            },

            previewClose(){
                this.previewModal = false;
            },

        	edit(id){

        		this.loading = false;
        		this.method = 'put';
        		this.modalText = 'Edit Holiday';
        		let url = base_url + 'settings/holidays/edit';
        		axios.post(url, {id: id}).then(response => {
        			let record = response.data.record;
                    let date = new Date(record.date);
                        date = date.toISOString();
                    
                    let location_array = []
                    //location_array.push(record.location_id)
                    location_array = this.locations.filter(({id}) => record.location_id.includes(id));
                    console.log("location_array: ", location_array)
        			this.form = {
        				id: record.id,
                        location: location_array,
                        type: record.type,
                        date: date,
                        title: record.title,
                        note: record.note,
                        status: record.status,
        			}

        			this.modal = true;

        		})
        	},

        	initForm(){
                let url = base_url + 'settings/holidays/init-form';
                axios.post(url).then(response =>{
                    this.locations = response.data.locations;

                })
        	},

            initCalendar(date){

                let url = new URL(window.location.href);

                let view = url.searchParams.get('view');

                if(view == 'calendar'){

                    let url = base_url + 'settings/holidays/calendar';

                    axios.post(url, { date:date }).then(response => {
                        let events = [];
                        let record = response.data.record;
                        if(record.length){
                            for(let x in record){
                                
                                let start = moment(record[x]['date']).format('YYYY-MM-DD');
                                events.push({
                                    title: record[x]['title'],
                                    start: start,
                                    cssClass: 'bg-primary text-white',
                                    textEscape: false
                                });
                            }
                        }

                        this.events = events;
                        
                    });

                }
            }

		}

	}

</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>