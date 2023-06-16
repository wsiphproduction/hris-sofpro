const install    			= require('../Controller/install');
const auth  				= require('../Controller/auth');
const home  				= require('../Controller/home');
const notification			= require('../Controller/notification');
const employee  			= require('../Controller/employee');
const employee_salary  		= require('../Controller/employee_salary');
const employee_general  	= require('../Controller/employee_general');
const employee_attendance  	= require('../Controller/employee_attendance');
const employee_loan  		= require('../Controller/employee_loan');
const employee_document		= require('../Controller/employee_document');
const employee_shift		= require('../Controller/employee_shift');
const employee_leave		= require('../Controller/employee_leave');
const employee_overtime		= require('../Controller/employee_overtime');
const employee_undertime	= require('../Controller/employee_undertime');
const employee_business 	= require('../Controller/employee_business');
const employee_config 		= require('../Controller/employee_config');
const employee_hierarchy	= require('../Controller/employee_hierarchy');
const employee_leave_credit	= require('../Controller/employee_leave_credit');
const employee_training		= require('../Controller/employee_training');
const employee_performance	= require('../Controller/employee_performance_review');
const employee_license		= require('../Controller/employee_license');
const employee_disciplinary_cases	= require('../Controller/employee_disciplinary_cases');
const employee_memorandum	= require('../Controller/employee_memorandum');
const employee_award		= require('../Controller/employee_award');
const employee_skill		= require('../Controller/employee_skill');
const employee_attachments	= require('../Controller/employee_attachments');
const attendance_shift  	= require('../Controller/attendance_shift_allocation');
const attendance_leave  	= require('../Controller/attendance_leave_management');
const attendance_biometric 	= require('../Controller/attendance_biometric');
const attendance_summary 	= require('../Controller/attendance_summary');
const attendance_absence 	= require('../Controller/attendance_absence');
const attendance_overtime 	= require('../Controller/attendance_overtime');
const attendance_tss     	= require('../Controller/attendance_tss');
const attendance_undertime 	= require('../Controller/attendance_undertime');
const setting_approvers 	= require('../Controller/setting_approvers');
const setting_company  		= require('../Controller/setting_company');
const setting_branch  		= require('../Controller/setting_branch');
const setting_taxonomy  	= require('../Controller/setting_taxonomy');
const setting_holiday   	= require('../Controller/setting_holiday');
const setting_biometric   	= require('../Controller/setting_biometric');
const setting_config      	= require('../Controller/setting_config');
const setting_role      	= require('../Controller/setting_role');
const setting_leave_policy 	= require('../Controller/setting_leave_policy');
const setting_section 	= require('../Controller/setting_section');
const setting_cron_management      	= require('../Controller/setting_cron_management');
const branding   			= require('../Controller/setting_branding');
const division   			= require('../Controller/setting_division');
const department   			= require('../Controller/setting_department');
const form_overtime  		= require('../Controller/form_overtime');
const form_leave  			= require('../Controller/form_leave');
const form_undertime  		= require('../Controller/form_undertime');
const form_shift  	    	= require('../Controller/form_shift');
const form_business_trip 	= require('../Controller/form_business_trip');
const form_dispute 		 	= require('../Controller/form_dispute');
const form_change_shift 	= require('../Controller/form_change_shift');
const approval_business_trip= require('../Controller/approval_business_trip');
const approval 				= require('../Controller/approval');
const approval_overtime 	= require('../Controller/approval_overtime');
const approval_undertime	= require('../Controller/approval_undertime');
const approval_leave    	= require('../Controller/approval_leave');
const approval_shift    	= require('../Controller/approval_shift');
const approval_dispute    	= require('../Controller/approval_dispute');
const approval_change_shift = require('../Controller/approval_change_shift');
const approval_change_log = require('../Controller/approval_change_log');
const recruitment_candidate = require('../Controller/recruitment_candidate');
const recruitment_schedule  = require('../Controller/recruitment_schedule');
const recruitment_rating    = require('../Controller/recruitment_rating');
const recruitment_joining   = require('../Controller/recruitment_joining');
const payment_loan   		= require('../Controller/payment_loan');
const payment_salary   		= require('../Controller/payment_salary');
const payment_adjustment	= require('../Controller/payment_adjustment');
const payment_dispute  		= require('../Controller/payment_dispute');
const payment_payroll  		= require('../Controller/payment_payroll');
const password   			= require('../Controller/password');
const myaccount   			= require('../Controller/myaccount');
const announcement   		= require('../Controller/announcement');
const accounts 		   		= require('../Controller/accounts');
const public   				= require('../Controller/public');
const custom_leave   		= require('../Controller/custom_leave');
const custom_form_leave   	= require('../Controller/custom_form_leave');
const custom_form_undertime = require('../Controller/custom_form_undertime');
const custom_form_overtime  = require('../Controller/custom_form_overtime');
const custom_form_change_shift   = require('../Controller/custom_form_change_shift');
const custom_form_change_log   	 = require('../Controller/custom_form_change_log');
const custom_form_dispute   = require('../Controller/custom_form_dispute');
const custom_form_businesstrip   = require('../Controller/custom_form_businesstrip');
const setting_shift_management = require('../Controller/setting_shift_management');
const payroll_information = require('../Controller/payroll_information');
const family_background = require('../Controller/family_background');
const employment_history = require('../Controller/employment_history');
const academic_background = require('../Controller/academic_background');
const certifications = require('../Controller/certifications');

module.exports = function (app, guard) {
	/*
	|----------------------------------------------
	| Initialization
	| Remove this line after installation
	|----------------------------------------------
	*/
	app.post('/install/register', install.register);
	app.post('/install/init', install.init);

	/*
	|----------------------------------------------
	| Login
	| Auth
	| Logout
	|----------------------------------------------
	*/
	app.get('/login', auth.login);
	app.post('/login', auth.auth);
	app.get('/logout', auth.logout);
	app.post('/login/verify', auth.verify);


	/*
	|----------------------------------------------
	| PUBLIC pAGES
	|----------------------------------------------
	*/
	app.get('/public/:slug', public.announcement);


	/*
	|----------------------------------------------
	| FORGOT PASSWORD
	|----------------------------------------------
	*/
	app.get('/password/forgot', password.forgot);
	app.post('/password/forgot', password.change);
	app.get('/password/reset', password.reset);
	app.post('/password/reset', password.validate);
	app.put('/password/reset', password.update);

	/*
	|----------------------------------------------
	| HOME PAGE
	|----------------------------------------------
	*/
	app.get('/', guard, home.index);
	app.get('/home', guard, home.index);
	app.post('/fetch', guard, home.fetch);
	app.post('/fetch/holiday', guard, home.fetch_holiday);
	app.post('/home/set-log', guard, home.setLog);
	app.post('/home/save', guard, home.save_calendar);
	app.put('/home/save', guard, home.update_calendar);
	app.post('/home/delete', guard, home.delete_calendar);
	
	app.post('/home/save/cutoff', guard, home.save_default_cut_off);

	app.get('/log-issue-monitoring', guard, home.log_issue_monitoring);
	app.post('/log-issue-monitoring/fetch', guard, home.log_issue_monitoring_fetch);
	app.post('/log-issue-monitoring/delete', guard, home.delete_activate_log);

	app.get('/team-logs', guard, home.team_logs);

	/*
	|----------------------------------------------
	| ANNOUNCEMENT
	|----------------------------------------------
	*/
	app.get('/announcement', guard, announcement.index);
	app.post('/announcement', guard, announcement.store);
	app.put('/announcement', guard, announcement.update);
	app.post('/announcement/archive', guard, announcement.archive);
	app.post('/announcement/fetch', guard, announcement.fetch);
	app.post('/announcement/upload', guard, announcement.upload);

	/*
	|----------------------------------------------
	| USER ACCOUNT
	|----------------------------------------------
	*/
	app.get('/myaccount', guard, myaccount.index);
	app.post('/myaccount/change-password', guard, myaccount.change_password);
	app.post('/myaccount/two-factor-authentication', guard, myaccount.two_factor);
	app.post('/myaccount/attendance', guard, myaccount.attendance);
	app.post('/myaccount/payslip', guard, myaccount.payslip);
	app.post('/myaccount/events', guard, myaccount.events);
	app.post('/myaccount/fetch', guard, myaccount.fetch);
	app.post('/myaccount/update-avatar', guard, myaccount.update_avatar);

	/*
	|----------------------------------------------
	| NOTIFICATION
	|----------------------------------------------
	*/
	app.post('/notifications', guard, notification.get);
	app.post('/notifications/read', guard, notification.read);

	/*
	|----------------------------------------------
	| EMPLOYEE
	| 1. List
	| 2. Hierarchy
	|----------------------------------------------
	*/
	
	app.get('/employee', guard, employee.index);
	app.put('/employee', guard, employee.update);
	app.post('/employee', guard, employee.store);
	app.post('/employee/import', guard, employee.import);
	app.get('/employee/export', guard, employee.export);
	app.post('/employee/get', guard, employee.get);
	app.post('/employee/role', guard, employee.updateRole);
	app.post('/employee/get-role', guard, employee.getRole);
	app.post('/employee/search', guard, employee.search);
	app.post('/employee/edit', guard, employee.edit);
	app.post('/employee/init-form', guard, employee.init_form);
	app.post('/employee/userinfo', guard, employee.userinfo);
	//General
	
	app.get('/employee/general/:id', guard, employee_general.index);
	app.post('/employee/general/emergency_contact', guard, employee_general.emergency_contact_create);
	app.put('/employee/general/emergency_contact', guard, employee_general.emergency_contact_update);
	app.post('/employee/general/fetch', guard, employee_general.fetch);
	app.post('/employee/general/export', guard, employee_general.export);
	app.put('/employee/general/:id', guard, employee_general.update);
	app.post('/employee/general/employment/create_update', guard, employee_general.employment_create);
	app.put('/employee/general/employment/create_update', guard, employee_general.employment_update);
	
	//Shift
	app.get('/employee/shift/:id', guard, employee_shift.index);
	app.post('/employee/shift/:id', guard, employee_shift.fetch);	
	//Leave
	app.get('/employee/leave/:id', guard, employee_leave.index);
	app.post('/employee/leave/:id', guard, employee_leave.fetch);
	//Overtime
	app.get('/employee/overtime/:id', guard, employee_overtime.index);
	app.post('/employee/overtime/:id', guard, employee_overtime.fetch);
	//Undertime
	app.get('/employee/undertime/:id', guard, employee_undertime.index);
	app.post('/employee/undertime/:id', guard, employee_undertime.fetch);
	//Business Trip
	app.get('/employee/business-trip/:id', guard, employee_business.index);
	app.post('/employee/business-trip/:id', guard, employee_business.fetch);
	//Salary
	app.get('/employee/salary/:id', guard, employee_salary.index);
	app.post('/employee/salary/:id', guard, employee_salary.store);
	app.put('/employee/salary/:id', guard, employee_salary.update);
	app.post('/employee/salary/record/fetch', guard, employee_salary.fetch);
	//Payroll Information
	app.get('/employee/payroll-information/:id', guard, payroll_information.index);
	app.post('/employee/payroll-information/fetch', guard, payroll_information.fetch);
	app.post('/employee/payroll-information/:id', guard, payroll_information.store);
	app.put('/employee/payroll-information/:id', guard, payroll_information.update);
	//Loan
	app.get('/employee/loan/:id', guard, employee_loan.index);
	app.post('/employee/loan/:id', guard, employee_loan.store);
	app.put('/employee/loan/:id', guard, employee_loan.update);
	app.post('/employee/loan/record/fetch', guard, employee_loan.fetch);
	//Document
	app.get('/employee/document/:id', guard, employee_document.index);
	app.post('/employee/document/:id', guard, employee_document.store);
	app.put('/employee/document/:id', guard, employee_document.update);
	app.post('/employee/document/record/fetch', guard, employee_document.fetch);
	//Family Background
	app.get('/employee/family-background/:id', guard, family_background.index);
	app.post('/employee/family-background/fetch', guard, family_background.fetch);
	app.post('/employee/family-background/:id', guard, family_background.store);
	app.put('/employee/family-background/:id', guard, family_background.update);
	//Employment History
	app.get('/employee/employment-history/:id', guard, employment_history.index);
	app.post('/employee/employment-history/fetch', guard, employment_history.fetch);
	app.post('/employee/employment-history/:id', guard, employment_history.store);
	app.put('/employee/employment-history/:id', guard, employment_history.update);
	//Academic Background & Qualification
	app.get('/employee/academic-background/:id', guard, academic_background.index);
	app.post('/employee/academic-background/fetch', guard, academic_background.fetch);
	app.post('/employee/academic-background/:id', guard, academic_background.store);
	app.put('/employee/academic-background/:id', guard, academic_background.update);
	//Certifications
	app.get('/employee/certifications/:id', guard, certifications.index);
	app.post('/employee/certifications/fetch', guard, certifications.fetch);
	app.post('/employee/certifications/:id', guard, certifications.store);
	app.put('/employee/certifications/:id', guard, certifications.update);
	//Attendance
	app.get('/employee/attendance/:id', guard, employee_attendance.index);
	app.post('/employee/attendance/record/fetch', guard, employee_attendance.fetch);
	//Biometric
	app.get('/employee/config/:id', guard, employee_config.index);
	app.post('/employee/config/:id', guard, employee_config.store);
	app.put('/employee/config/:id', guard, employee_config.update);
	app.post('/employee/config/record/fetch', guard, employee_config.fetch);
	app.post('/employee/config/record/delete', guard, employee_config.delete);
	app.post('/employee/config/update/setting', guard, employee_config.update_setting);
	app.post('/employee/config/update/work', guard, employee_config.update_work_schedule);
	//Leave Credit
	app.get('/employee/leave-credit', guard, employee_leave_credit.index);
	app.post('/employee/leave-credit/fetch', guard, employee_leave_credit.fetch);
	app.post('/employee/leave-credit/edit', guard, employee_leave_credit.edit);
	app.put('/employee/leave-credit/update', guard, employee_leave_credit.update);
	app.put('/employee/leave-credit/import', guard, employee_leave_credit.import);
	
	//app.get('/employee/hierarchy', guard, employee_hierarchy.index);
	//app.post('/employee/hierarchy/get', guard, employee_hierarchy.get);

	//Training
	app.get('/employee/training/:id', guard, employee_training.index);
	app.post('/employee/training/archive', guard, employee_training.archive);
	app.post('/employee/training/:id', guard, employee_training.store);
	app.post('/employee/training/record/fetch', guard, employee_training.fetch);
	app.put('/employee/training/:id', guard, employee_training.update);

	//Performance-review
	app.get('/employee/performance-review/:id', guard, employee_performance.index);
	app.post('/employee/performance-review/archive', guard, employee_performance.archive);
	app.post('/employee/performance-review/:id', guard, employee_performance.store);
	app.post('/employee/performance-review/record/fetch', guard, employee_performance.fetch);
	app.put('/employee/performance-review/:id', guard, employee_performance.update);

	//License
	app.get('/employee/license/:id', guard, employee_license.index);
	app.post('/employee/license/archive', guard, employee_license.archive);
	app.post('/employee/license/:id', guard, employee_license.store);
	app.post('/employee/license/record/fetch', guard, employee_license.fetch);
	app.put('/employee/license/:id', guard, employee_license.update);

	//Disciplinary
	app.get('/employee/disciplinary-cases/:id', guard, employee_disciplinary_cases.index);
	app.post('/employee/disciplinary-cases/archive', guard, employee_disciplinary_cases.archive);
	app.post('/employee/disciplinary-cases/:id', guard, employee_disciplinary_cases.store);
	app.post('/employee/disciplinary-cases/record/fetch', guard, employee_disciplinary_cases.fetch);
	app.put('/employee/disciplinary-cases/:id', guard, employee_disciplinary_cases.update);

	//Memo
	app.get('/employee/memorandum/:id', guard, employee_memorandum.index);
	app.post('/employee/memorandum/archive', guard, employee_memorandum.archive);
	app.post('/employee/memorandum/:id', guard, employee_memorandum.store);
	app.post('/employee/memorandum/record/fetch', guard, employee_memorandum.fetch);
	app.put('/employee/memorandum/:id', guard, employee_memorandum.update);
	

	//award
	app.get('/employee/award/:id', guard, employee_award.index);
	app.post('/employee/award/archive', guard, employee_award.archive);
	app.post('/employee/award/:id', guard, employee_award.store);
	app.post('/employee/award/record/fetch', guard, employee_award.fetch);
	app.put('/employee/award/:id', guard, employee_award.update);

	//skill
	app.get('/employee/skill/:id', guard, employee_skill.index);
	app.post('/employee/skill/archive', guard, employee_skill.archive);
	app.post('/employee/skill/:id', guard, employee_skill.store);
	app.post('/employee/skill/record/fetch', guard, employee_skill.fetch);
	app.put('/employee/skill/:id', guard, employee_skill.update);

	//attachments
	app.get('/employee/attachment/:id', guard, employee_attachments.index); 
	app.post('/employee/attachment/archive', guard, employee_attachments.archive);
	app.post('/employee/attachment/:id', guard, employee_attachments.store);
	app.post('/employee/attachment/record/fetch', guard, employee_attachments.fetch);
	app.put('/employee/attachment/:id', guard, employee_attachments.update);

	/*
	|----------------------------------------------
	| ATTENDANCE
	| 1. Shift Allocation
	| 2. Leave Management
	|----------------------------------------------
	*/
	app.get('/attendance/shift-management', guard, attendance_shift.index);
	app.post('/attendance/shift-management', guard, attendance_shift.store);
	app.post('/attendance/shift-management/initForm', guard, attendance_shift.initForm);
	app.post('/attendance/shift-management/fetch', guard, attendance_shift.fetch);
	app.get('/attendance/shift-management/export', guard, attendance_shift.export);
	app.get('/attendance/shift-management/:shortid', guard, attendance_shift.calendar);
	app.post('/attendance/shift-management/:shortid', guard, attendance_shift.yearCalendar);


	app.get('/attendance/leave-management', guard, attendance_leave.index);
	app.post('/attendance/leave-management', guard, attendance_leave.import);
	app.post('/attendance/leave-management/fetch', guard, attendance_leave.fetch);
	app.get('/attendance/leave-management/export', guard, attendance_leave.export);

	app.get('/attendance/biometric-integration', guard, attendance_biometric.index);
	app.post('/attendance/biometric-integration', guard, attendance_biometric.store);
	app.post('/attendance/biometric-integration/fetch', guard, attendance_biometric.fetch);

	app.get('/attendance/overtime', guard, attendance_overtime.index);
	app.get('/attendance/overtime/export', guard, attendance_overtime.export);
	app.post('/attendance/overtime', guard, attendance_overtime.import);
	app.post('/attendance/overtime/fetch', guard, attendance_overtime.fetch);

	app.get('/attendance/undertime', guard, attendance_undertime.index);
	app.get('/attendance/undertime/download', guard, attendance_undertime.download);
	app.post('/attendance/undertime/fetch', guard, attendance_undertime.fetch);
	app.post('/attendance/undertime/import', guard, attendance_undertime.store);


	app.get('/attendance/dtr-management', guard, attendance_summary.index);
	app.get('/attendance/dtr-management/download', guard, attendance_summary.download);
	app.post('/attendance/dtr-management/fetch', guard, attendance_summary.fetch);
	app.post('/attendance/dtr-management/biometric-logs/fetch', guard, attendance_summary.biometricLogsFetch);
	app.post('/attendance/dtr-management/reprocess', guard, attendance_summary.reprocess);
	app.post('/attendance/dtr-management/add-attendance', guard, attendance_summary.add_attendance);

	app.get('/attendance/absence', guard, attendance_absence.index);
	app.post('/attendance/absence/fetch', guard, attendance_absence.fetch);
	
	app.get('/attendance/tss', guard, attendance_tss.index);
	app.post('/attendance/tss', guard, attendance_tss.store);
	app.put('/attendance/tss', guard, attendance_tss.update);
	app.post('/attendance/tss/fetch', guard, attendance_tss.fetch);
	app.post('/attendance/tss/fetch/posted', guard, attendance_tss.fetch_posted);
	app.get('/attendance/tss/posted', guard, attendance_tss.posted);
	app.get('/attendance/tss/:id', guard, attendance_tss.summary);
	app.get('/attendance/tss/export_tss/:id', guard, attendance_tss.export);
	
	
	
	/*
	|----------------------------------------------
	| FORMS
	| 1. Overtime
	| 2. Leave
	| 3. Undertime
	| 4. Shift
	| 5. Business Trip
	|----------------------------------------------
	*/	     
	app.get('/forms/overtime', guard, form_overtime.index);
	app.post('/forms/overtime/fetch', guard, form_overtime.fetch);
	app.post('/forms/overtime', guard, form_overtime.store);
	app.post('/forms/overtime/archive', guard, form_overtime.archive);
	app.post('/forms/overtime/edit', guard, form_overtime.edit);
	app.put('/forms/overtime', guard, form_overtime.update);
	//Leave
	app.get('/forms/leave', guard, form_leave.index);
	app.post('/forms/leave/fetch', guard, form_leave.fetch);
	app.post('/forms/leave', guard, form_leave.store);
	app.post('/forms/leave/init-form', guard, form_leave.init_form);
	app.post('/forms/leave/edit', guard, form_leave.edit);
	app.put('/forms/leave', guard, form_leave.update);
	app.post('/forms/leave/archive', guard, form_leave.archive);
	app.post('/forms/leave/getvlid', guard, form_leave.get_vl_id);
	//Undertime
	app.get('/forms/undertime', guard, form_undertime.index);
	app.post('/forms/undertime/fetch', guard, form_undertime.fetch);
	app.post('/forms/undertime', guard, form_undertime.store);
	app.post('/forms/undertime/edit', guard, form_undertime.edit);
	app.put('/forms/undertime', guard, form_undertime.update);
	app.post('/forms/undertime/archive', guard, form_undertime.archive);
	//Shft
	app.get('/forms/shift', guard, form_shift.index);
	app.post('/forms/shift', guard, form_shift.store);
	app.post('/forms/shift/fetch', guard, form_shift.fetch);
	app.post('/forms/shift/calendar', guard, form_shift.calendar);
	app.post('/forms/shift/edit', guard, form_shift.edit);
	app.put('/forms/shift', guard, form_shift.update);
	app.post('/forms/shift/archive', guard, form_shift.archive);
	//Business Trip
	app.get('/forms/business-trip', guard, form_business_trip.index);
	app.post('/forms/business-trip/fetch', guard, form_business_trip.fetch);
	app.post('/forms/business-trip', guard, form_business_trip.store);
	app.post('/forms/business-trip/archive', guard, form_business_trip.archive);
	app.post('/forms/business-trip/edit', guard, form_business_trip.edit);
	app.put('/forms/business-trip', guard, form_business_trip.update);
	//Dispute Form
	app.get('/forms/dispute', guard, form_dispute.index);
	app.post('/forms/dispute', guard, form_dispute.store);
	app.put('/forms/dispute', guard, form_dispute.update);
	app.post('/forms/dispute/fetch', guard, form_dispute.fetch);
	app.post('/forms/dispute/archive', guard, form_dispute.archive);
	//Change Shift Form
	app.get('/forms/change-shift', guard, form_change_shift.index);
	app.post('/forms/change-shift', guard, form_change_shift.store);
	app.put('/forms/change-shift', guard, form_change_shift.update);
	app.post('/forms/change-shift/fetch', guard, form_change_shift.fetch);
	app.post('/forms/change-shift/archive', guard, form_change_shift.archive);
	app.post('/forms/change-shift/initform', guard, form_change_shift.initform);



	/*
	|----------------------------------------------
	| SETTINGS
	| 1. Company
	| 2. Branch
	| 3. Approver
	| 4. Taxonomy
	| 5. Holidays
	| 5. Role
	|----------------------------------------------
	*/
	app.get('/settings/company', guard, setting_company.index);
	app.post('/settings/company', guard, setting_company.store);
	app.post('/settings/company/edit', guard, setting_company.edit);
	app.put('/settings/company', guard, setting_company.update);

	app.get('/settings/branch', guard, setting_branch.index);
	app.post('/settings/branch', guard, setting_branch.store);
	app.post('/settings/branch/edit', guard, setting_branch.edit);
	app.put('/settings/branch', guard, setting_branch.update);
	app.post('/settings/branch/init-form', guard, setting_branch.init_form);
	app.post('/settings/branch/get', guard, setting_branch.get_branch);

	app.get('/settings/approvers', guard, setting_approvers.index);
	app.post('/settings/approvers/validate', guard, setting_approvers.validate);
	app.post('/settings/approvers/edit', guard, setting_approvers.edit);
	app.put('/settings/approvers', guard, setting_approvers.update);
	app.post('/settings/approvers/init-form', guard, setting_approvers.init_form);
	app.post('/settings/approvers/get', guard, setting_approvers.get_approver);
	app.post('/settings/approvers/fetch', guard, setting_approvers.fetch);

	app.get('/settings/approvers/custom', guard, setting_approvers.custom);
	app.post('/settings/approvers/custom/fetch', guard, setting_approvers.custom_fetch);
	app.post('/settings/approvers/custom/archive', guard, setting_approvers.custom_archive);
	app.post('/settings/approvers/custom', guard, setting_approvers.customStore);


	app.get('/settings/taxonomy', guard, setting_taxonomy.index);
	app.post('/settings/taxonomy', guard, setting_taxonomy.store);
	app.post('/settings/taxonomy/edit', guard, setting_taxonomy.edit);
	app.post('/settings/taxonomy/remove/:parent_id', guard, setting_taxonomy.remove);
	app.put('/settings/taxonomy', guard, setting_taxonomy.update);
	app.post('/settings/taxonomy/init-form', guard, setting_taxonomy.init_form);

	app.get('/settings/holidays', guard, setting_holiday.index);
	app.post('/settings/holidays', guard, setting_holiday.store);
	app.post('/settings/holidays/edit', guard, setting_holiday.edit);
	app.put('/settings/holidays', guard, setting_holiday.update);
	app.post('/settings/holidays/init-form', guard, setting_holiday.init_form);
	app.post('/settings/holidays/calendar', guard, setting_holiday.calendar);
	app.post('/settings/holidays/archive', guard, setting_holiday.archive);

	app.get('/settings/user-role', guard, setting_role.index);
	app.post('/settings/user-role', guard, setting_role.store);
	app.put('/settings/user-role', guard, setting_role.update);
	app.post('/settings/user-role/fetch', guard, setting_role.fetch);
	app.post('/settings/user-role/edit', guard, setting_role.edit);
	app.get('/settings/user-role/:slug', guard, setting_role.manage);
	app.post('/settings/user-role/:slug', guard, setting_role.manage_fetch);
	app.post('/settings/user-role/save/changes', guard, setting_role.manage_update_role);
	app.post('/setting/user-role/get/user-role', guard, setting_role.user_role);

	app.get('/settings/biometric', guard, setting_biometric.index);
	app.post('/settings/biometric', guard, setting_biometric.store);
	app.put('/settings/biometric', guard, setting_biometric.update);
	app.post('/settings/biometric/fetch', guard, setting_biometric.fetch);
	app.post('/settings/biometric/edit', guard, setting_biometric.edit);

	app.get('/settings/configuration', guard, setting_config.index);
	app.post('/settings/configuration/setting', guard, setting_config.setting);
	app.post('/settings/configuration', guard, setting_config.update);

	app.get('/settings/leave-policy', guard, setting_leave_policy.index);
	app.post('/settings/leave-policy', guard, setting_leave_policy.store);
	app.put('/settings/leave-policy', guard, setting_leave_policy.update);
	app.post('/settings/leave-policy/fetch', guard, setting_leave_policy.fetch);
	app.post('/settings/leave-policy/archive', guard, setting_leave_policy.archive);

	app.get('/settings/branding', guard, branding.index);
	app.post('/settings/branding', guard, branding.store);
	app.post('/settings/branding/fetch', guard, branding.fetch);


	app.get('/settings/division', guard, division.index);
	app.get('/settings/division/export', guard, division.export);
	app.post('/settings/division', guard, division.store);
	app.put('/settings/division', guard, division.update);
	app.post('/settings/division/fetch', guard, division.fetch);
	app.post('/settings/division/init', guard, division.init);
	app.post('/settings/division/import', guard, division.import);
	app.post('/settings/division/archive', guard, division.archive);

	app.get('/settings/shift-management', guard, setting_shift_management.index);
	app.post('/settings/shift-management', guard, setting_shift_management.store);
	app.put('/settings/shift-management', guard, setting_shift_management.update);
	app.post('/settings/shift-management/fetch', guard, setting_shift_management.fetch);
	app.post('/settings/shift-management/init', guard, setting_shift_management.init);
	app.post('/settings/shift-management/archive', guard, setting_shift_management.archive);



	app.get('/settings/department', guard, department.index);
	app.get('/settings/department/export', guard, department.export);
	app.post('/settings/department', guard, department.store);
	app.put('/settings/department', guard, department.update);
	app.post('/settings/department/fetch', guard, department.fetch);
	app.post('/settings/department/init', guard, department.init);
	app.post('/settings/department/import', guard, department.import);
	app.post('/settings/department/archive', guard, department.archive);

	app.get('/settings/section', guard, setting_section.index);
	app.get('/settings/section/export', guard, setting_section.export);
	app.post('/settings/section', guard, setting_section.store);
	app.put('/settings/section', guard, setting_section.update);
	app.post('/settings/section/fetch', guard, setting_section.fetch);
	app.post('/settings/section/init', guard, setting_section.init);
	app.post('/settings/section/import', guard, setting_section.import);
	app.post('/settings/section/archive', guard, setting_section.archive);

	app.get('/settings/cron-management', guard, setting_cron_management.index);
	app.post('/settings/cron-management/fetch', guard, setting_cron_management.fetch);
	app.post('/settings/cron-management/process', guard, setting_cron_management.process);
	app.post('/settings/cron-management/calculate', guard, setting_cron_management.recalculate);
	app.post('/settings/cron-management/reprocess-ot',guard,setting_cron_management.reprocess_ot);
	app.post('/settings/cron-management/reprocess-leave',guard,setting_cron_management.reprocess_leave);


	/*
	|----------------------------------------------
	| APPROVALS
	| 1. Business Trip
	| 2. Overtime
	| 3. Undertime
	| 4. Leave
	| 5. Holidays
	|----------------------------------------------
	*/
	
	app.get('/approvals/update', guard, approval.update);

	app.get('/approvals/business-trip', guard, approval_business_trip.index);
	app.post('/approvals/business-trip', guard, approval_business_trip.fetch);
	app.put('/approvals/business-trip', guard, approval_business_trip.update);
	app.post('/approvals/business-trip/archive', guard, approval_business_trip.archive);
	app.get('/approvals/business-trip/export', guard, approval_business_trip.export);
	app.post('/approvals/business-trip/cancel', guard, approval_business_trip.cancel);

	app.get('/approvals/overtime', guard, approval_overtime.index);
	app.post('/approvals/overtime', guard, approval_overtime.fetch);
	app.post('/approvals/overtime/archive', guard, approval_overtime.archive);
	app.put('/approvals/overtime', guard, approval_overtime.update);
	app.get('/approvals/overtime/export', guard, approval_overtime.export);
	app.post('/approvals/overtime/cancel', guard, approval_overtime.cancel);
	
	app.get('/approvals/undertime', guard, approval_undertime.index);
	app.post('/approvals/undertime', guard, approval_undertime.fetch);
	app.post('/approvals/undertime/archive', guard, approval_undertime.archive);
	app.put('/approvals/undertime', guard, approval_undertime.update);
	app.get('/approvals/undertime/export', guard, approval_undertime.export);
	app.post('/approvals/undertime/cancel', guard, approval_undertime.cancel);

	app.get('/approvals/leave', guard, approval_leave.index);
	app.post('/approvals/leave', guard, approval_leave.fetch);
	app.post('/approvals/getpolicy', guard, approval_leave.get_policy);
	app.post('/approvals/leave/archive', guard, approval_leave.archive);
	app.put('/approvals/leave', guard, approval_leave.update);
	app.post('/approvals/leave/init', guard, approval_leave.init);
	app.get('/approvals/leave/export', guard, approval_leave.export);
	app.post('/approvals/leave/cancel', guard, approval_leave.cancel);

	app.get('/approvals/dispute', guard, approval_dispute.index);
	app.post('/approvals/dispute', guard, approval_dispute.fetch);
	app.post('/approvals/dispute/archive', guard, approval_dispute.archive);
	app.put('/approvals/dispute', guard, approval_dispute.update);
	app.get('/approvals/dispute/export', guard, approval_dispute.export);
	app.post('/approvals/dispute/cancel', guard, approval_dispute.cancel);

	app.get('/approvals/shift', guard, approval_shift.index);
	app.post('/approvals/shift/events', guard, approval_shift.events);
	app.post('/approvals/shift', guard, approval_shift.fetch);
	app.post('/approvals/shift/fetch-user', guard, approval_shift.fetch_user);
	app.put('/approvals/shift', guard, approval_shift.update);
	app.get('/approvals/shift/calendar', guard, approval_shift.calendar);
	app.post('/approvals/shift/calendar', guard, approval_shift.calendar_fetch);
	app.post('/approvals/shift/archive', guard, approval_shift.archive);


	app.get('/approvals/change-shift', guard, approval_change_shift.index);
	app.post('/approvals/change-shift', guard, approval_change_shift.fetch);
	app.post('/approvals/change-shift/archive', guard, approval_change_shift.archive);
	app.put('/approvals/change-shift', guard, approval_change_shift.update);
	app.get('/approvals/change-shift/export', guard, approval_change_shift.export);
	
	app.get('/approvals/change-log', guard, approval_change_log.index);
	app.post('/approvals/change-log', guard, approval_change_log.fetch);
	app.post('/approvals/change-log/archive', guard, approval_change_log.archive);
	app.put('/approvals/change-log', guard, approval_change_log.update);
	app.get('/approvals/change-log/export', guard, approval_change_log.export);

	/*
	|----------------------------------------------
	| RECRUITMENT
	| 1. Candidate Profile
	| 2. Schedule
	| 3. Rating
	| 4. Joining
	|----------------------------------------------
	*/
	app.get('/recruitment/candidate-profile', guard, recruitment_candidate.index);
	app.post('/recruitment/candidate-profile', guard, recruitment_candidate.store);
	app.put('/recruitment/candidate-profile', guard, recruitment_candidate.update);
	app.post('/recruitment/candidate-profile/edit', guard, recruitment_candidate.edit);
	app.post('/recruitment/candidate-profile/fetch', guard, recruitment_candidate.fetch);
	app.post('/recruitment/candidate-profile/archive', guard, recruitment_candidate.archive);
	
	app.get('/recruitment/schedule', guard, recruitment_schedule.index);
	app.post('/recruitment/schedule', guard, recruitment_schedule.store);
	app.put('/recruitment/schedule', guard, recruitment_schedule.update);
	app.post('/recruitment/schedule/get', guard, recruitment_schedule.get);
	app.post('/recruitment/schedule/init', guard, recruitment_schedule.init);
	app.post('/recruitment/schedule/edit', guard, recruitment_schedule.edit);

	app.get('/recruitment/rating', guard, recruitment_rating.index);
	app.post('/recruitment/rating', guard, recruitment_rating.store);
	app.post('/recruitment/rating/get', guard, recruitment_rating.get);
	app.post('/recruitment/rating/fetch', guard, recruitment_rating.fetch);
	
	app.get('/recruitment/joining', guard, recruitment_joining.index);
	app.post('/recruitment/joining', guard, recruitment_joining.update);
	app.post('/recruitment/joining/fetch', guard, recruitment_joining.fetch);
	app.post('/recruitment/joining/edit', guard, recruitment_joining.edit);

	/*
	|----------------------------------------------
	| PAYMENT
	| 1. Loan/ Advance Payment
	| 2. Salary
	|----------------------------------------------
	*/
	app.get('/payment/loan-advance-payment', guard, payment_loan.index);
	app.post('/payment/loan-advance-payment', guard, payment_loan.store);
	app.put('/payment/loan-advance-payment', guard, payment_loan.update);
	app.post('/payment/loan-advance-payment/fetch', guard, payment_loan.fetch);

	app.get('/payment/salary', guard, payment_salary.index);
	app.get('/payment/salary/download', guard, payment_salary.download);
	app.post('/payment/salary/fetch', guard, payment_salary.fetch);

	app.get('/payment/adjustment', guard, payment_adjustment.index);
	app.post('/payment/adjustment', guard, payment_adjustment.store);
	app.put('/payment/adjustment', guard, payment_adjustment.update);
	app.post('/payment/adjustment/archive', guard, payment_adjustment.archive);
	app.post('/payment/adjustment/fetch', guard, payment_adjustment.fetch);

	app.get('/payment/dispute', guard, payment_dispute.index);
	app.post('/payment/dispute', guard, payment_dispute.store);
	app.put('/payment/dispute', guard, payment_dispute.update);
	app.post('/payment/dispute/fetch', guard, payment_dispute.fetch);

	app.get('/payment/payroll', guard, payment_payroll.index);
	app.post('/payment/payroll', guard, payment_payroll.upload);
	app.post('/payment/payroll/fetch', guard, payment_payroll.fetch);

	/*
	|----------------------------------------------
	| CRM - ACCOUNT
	|----------------------------------------------
	*/
	app.get('/accounts', guard, accounts.index);
	app.post('/accounts', guard, accounts.store);
	app.post('/accounts/win', guard, accounts.storeWin);
	app.post('/accounts/init', guard, accounts.init);
	app.post('/accounts/fetch/chase', guard, accounts.fetchChase);

	app.get('/custom-leave', guard, custom_leave.index);
	app.post('/custom-leave', guard, custom_leave.store);
	app.post('/custom-leave/init-form', guard, custom_leave.init_form);
	app.post('/custom-leave/fetch', guard, custom_leave.fetch);
	app.get('/custom-leave/migrate/:start_date/:end_date', guard, custom_leave.migrate);


	app.get('/custom/leave', guard, custom_form_leave.index);
	app.post('/custom/leave', guard, custom_form_leave.store);
	app.put('/custom/leave', guard, custom_form_leave.update);
	app.post('/custom/leave/fetch', guard, custom_form_leave.fetch);
	app.post('/custom/leave/archive', guard, custom_form_leave.delete);
	app.post('/custom/leave/init', guard, custom_form_leave.init);
	app.post('/custom/leave/get_policy', guard, custom_form_leave.get_policy);
	app.get('/custom/leave/export', guard, custom_form_leave.export);
	app.post('/custom/leave/getvlid', guard, custom_form_leave.get_vl_id);


	app.get('/custom/undertime', guard, custom_form_undertime.index);
	app.post('/custom/undertime', guard, custom_form_undertime.store);
	app.put('/custom/undertime', guard, custom_form_undertime.update);
	app.post('/custom/undertime/fetch', guard, custom_form_undertime.fetch);
	app.post('/custom/undertime/init', guard, custom_form_undertime.init);
	app.post('/custom/undertime/archive', guard, custom_form_undertime.delete);
	app.get('/custom/undertime/export', guard, custom_form_undertime.export);


	app.get('/custom/overtime', guard, custom_form_overtime.index);
	app.post('/custom/overtime', guard, custom_form_overtime.store);
	app.put('/custom/overtime', guard, custom_form_overtime.update);
	app.post('/custom/overtime/fetch', guard, custom_form_overtime.fetch);
	app.post('/custom/overtime/archive', guard, custom_form_overtime.delete);
	app.post('/custom/overtime/init', guard, custom_form_overtime.init);
	app.get('/custom/overtime/export', guard, custom_form_overtime.export);
	app.post('/custom/overtime/fetch-user-shifts', guard, custom_form_overtime.fetch_user_shifts);

	app.get('/custom/change-shift', guard, custom_form_change_shift.index);
	app.post('/custom/change-shift', guard, custom_form_change_shift.store);
	app.put('/custom/change-shift', guard, custom_form_change_shift.update);
	app.post('/custom/change-shift/fetch', guard, custom_form_change_shift.fetch);
	app.post('/custom/change-shift/archive', guard, custom_form_change_shift.delete);
	app.post('/custom/change-shift/init', guard, custom_form_change_shift.init);
	app.post('/custom/change-shift/getshift', guard, custom_form_change_shift.getshift);
	app.get('/custom/change-shift/export', guard, custom_form_change_shift.export);

	app.get('/custom/change-log', guard, custom_form_change_log.index);
	app.post('/custom/change-log', guard, custom_form_change_log.store);
	app.put('/custom/change-log', guard, custom_form_change_log.update);
	app.post('/custom/change-log/fetch', guard, custom_form_change_log.fetch);
	app.post('/custom/change-log/archive', guard, custom_form_change_log.delete);
	app.post('/custom/change-log/init', guard, custom_form_change_log.init);
	app.post('/custom/change-log/getlog', guard, custom_form_change_log.getlog);
	app.get('/custom/change-log/export', guard, custom_form_change_log.export);

	app.get('/custom/dispute', guard, custom_form_dispute.index);
	app.post('/custom/dispute', guard, custom_form_dispute.store);
	app.put('/custom/dispute', guard, custom_form_dispute.update);
	app.post('/custom/dispute/fetch', guard, custom_form_dispute.fetch);
	app.post('/custom/dispute/archive', guard, custom_form_dispute.delete);
	app.post('/custom/dispute/init', guard, custom_form_dispute.init);
	app.get('/custom/dispute/export', guard, custom_form_dispute.export);

	app.get('/custom/businesstrip', guard, custom_form_businesstrip.index);
	app.post('/custom/businesstrip', guard, custom_form_businesstrip.store);
	app.put('/custom/businesstrip', guard, custom_form_businesstrip.update);
	app.post('/custom/businesstrip/fetch', guard, custom_form_businesstrip.fetch);
	app.post('/custom/businesstrip/archive', guard, custom_form_businesstrip.delete);
	app.post('/custom/businesstrip/init', guard, custom_form_businesstrip.init);
	app.get('/custom/businesstrip/export', guard, custom_form_businesstrip.export);
}
