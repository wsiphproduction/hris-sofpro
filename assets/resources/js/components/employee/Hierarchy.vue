<script>
	module.exports = {
		  
		data: function(){

			return{
                filter: {
                    company: ''
                },
                companies: [],
                company_id: ''
			}
		},

		mounted(){
            this.init();
            //this.getUser();
            //console.log(this.$refs['tree']);
		},

		mixins: [
			Form,
			Alert
		],

        methods: {
            remove(id){
                console.log("Removed ID: ", id);
            },

            filterCompany(){
                let id = this.filter.company;
                let location = base_url + 'employee/hierarchy/?company='+ id;
                window.location = location;
                //this.getUser();
            },

            // renderTree(tree){
            //     var e, html, _i, _len;

            //     html = `<ul>`;

            //     for (_i = 0, _len = tree.length; _i < _len; _i++) {
            //         e = tree[_i];
            //         html += `<li><span class="button">` + e.first_name +' '+ e.last_name + `</span><span class="remove" v-on:click="remove()"><i class="mdi mdi-close"></i></span>`;
            //             if (e.children != null) {
            //                 html += this.renderTree(e.children);
            //             }
            //         html += `</li>`;
            //     }

            //     html += `</ul>`;

            //     return html;
            // },

            init(){
                let url     = new URL(window.location.href);
                this.filter.company = url.searchParams.get('company');
                let REST = base_url + 'settings/branch/get';
                axios.post(REST).then(response =>{
                    this.companies = response.data.branches;
                });
            },

            // getUser(){
            //     let data = {
            //         id: this.filter.company ? this.filter.company : ''
            //     }
            //     let REST = base_url + 'employee/hierarchy/get';
            //     axios.post(REST, data).then(response => {
            //         let users = response.data.users;
            //         let tree  = arrayToTree(users);
            //         this.users = users.length ? tree : '';
            //         //console.log(response.data.users);
            //     });
            // }
		}

	}

</script>