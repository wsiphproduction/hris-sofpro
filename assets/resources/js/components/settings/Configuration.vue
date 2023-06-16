<script>
	module.exports = {

		data: function(){
			return{
				form: {}
			}
		},

		mounted(){
			this.fetchRecord();
		},

		mixins: [
			Form, 
			Alert
		],

		methods: {

			fetchRecord(){
				let REST = base_url + 'settings/configuration/setting';
				axios.post(REST).then(response =>{
					let json = response.data.json;
					this.form = {
						grace_period: json.shift && json.shift.grace_period ? json.shift.grace_period : 0,
						//timezone: json.server && json.server.timezone ? json.server.timezone : '+08:00',
						//overtime_regular: json.overtime && json.overtime.overtime_regular ? json.overtime.overtime_regular : '0',
						//overtime_restday: json.overtime && json.overtime.overtime_restday ? json.overtime.overtime_restday : '0',
						//overtime_regular_holiday: json.overtime && json.overtime.overtime_regular_holiday ? json.overtime.overtime_regular_holiday : '0',
						//overtime_restday_special_holiday: json.overtime && json.overtime.overtime_restday_special_holiday ? json.overtime.overtime_restday_special_holiday : '0',
						//overtime_restday_regular_holiday: json.overtime && json.overtime.overtime_restday_regular_holiday ? json.overtime.overtime_restday_regular_holiday : '0',

						//smtp_host: json.smtp && json.smtp.smtp_host ? json.smtp.smtp_host : '',
						//smtp_port: json.smtp && json.smtp.smtp_port ? json.smtp.smtp_port : '',
						//smtp_username: json.smtp && json.smtp.smtp_username ? json.smtp.smtp_username : '',
						//smtp_service: json.smtp && json.smtp.smtp_service ? json.smtp.smtp_service : '',
						//smtp_password: json.smtp && json.smtp.smtp_password ? json.smtp.smtp_password : '',

						cutoff_a_from: json.cutoff && json.cutoff.A_from ? json.cutoff.A_from : '',
						cutoff_a_to: json.cutoff && json.cutoff.A_to ? json.cutoff.A_to : '',
						cutoff_a_day: json.cutoff && json.cutoff.A_day ? json.cutoff.A_day : '',
						cutoff_b_from: json.cutoff && json.cutoff.B_from ? json.cutoff.B_from : '',
						cutoff_b_to: json.cutoff && json.cutoff.B_to ? json.cutoff.B_to : '',
						cutoff_b_day: json.cutoff && json.cutoff.B_day ? json.cutoff.B_day : '',

						contribution_sss: json.contribution && json.contribution.sss ? json.contribution.sss : '',
						contribution_philhealth: json.contribution && json.contribution.philhealth ? json.contribution.philhealth : '',
						contribution_pagibig: json.contribution && json.contribution.pagibig ? json.contribution.pagibig : '',

						manual_log: json.manual_log && json.manual_log ? json.manual_log : '',

						policy_nolog: json.policy && json.policy.nolog ? json.policy.nolog : '',
					}
				});
			},

		}

	}

</script>