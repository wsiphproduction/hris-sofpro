const $env 		= require('dotenv').config();
const Sequelize = require('sequelize');
const colors = require('colors');
const Connection = require('tedious').Connection;
const moment= require('moment-timezone');
    moment.tz.setDefault($env.parsed.moment_timezone);

/*
|----------------------------------------------------------------------------------------
| Sequelize Operator Alias
|----------------------------------------------------------------------------------------
*/
Sequelize.DATE.prototype._stringify = function _stringify(date, options) {
    return this._applyTimezone(date, options).format('YYYY-MM-DD HH:mm:ss');
};
const Op = Sequelize.Op;
const operatorsAliases = {
    $eq: Op.eq,
    $ne: Op.ne,
    $gte: Op.gte,
    $gt: Op.gt,
    $lte: Op.lte,
    $lt: Op.lt,
    $not: Op.not,
    $in: Op.in,
    $notIn: Op.notIn,
    $is: Op.is,
    $like: Op.like,
    $notLike: Op.notLike,
    $iLike: Op.iLike,
    $notILike: Op.notILike,
    $regexp: Op.regexp,
    $notRegexp: Op.notRegexp,
    $iRegexp: Op.iRegexp,
    $notIRegexp: Op.notIRegexp,
    $between: Op.between,
    $notBetween: Op.notBetween,
    $overlap: Op.overlap,
    $contains: Op.contains,
    $contained: Op.contained,
    $adjacent: Op.adjacent,
    $strictLeft: Op.strictLeft,
    $strictRight: Op.strictRight,
    $noExtendRight: Op.noExtendRight,
    $noExtendLeft: Op.noExtendLeft,
    $and: Op.and,
    $or: Op.or,
    $any: Op.any,
    $all: Op.all,
    $values: Op.values,
    $col: Op.col
};

/*
|----------------------------------------------------------------------------------------
| Models
|----------------------------------------------------------------------------------------
*/
const Branding = require('../app/Models/Branding');
const Countries = require('../app/Models/Countries');
const Users = require('../app/Models/Users');
const CandidateProfile = require('../app/Models/CandidateProfile');
const Interview = require('../app/Models/Interview');
const InterviewRating = require('../app/Models/InterviewRating');
const Taxonomy = require('../app/Models/Taxonomy');
const Companies = require('../app/Models/Companies');
const Employments = require('../app/Models/Employments');
const Branches = require('../app/Models/Branches');
const Requirements = require('../app/Models/Requirements');
const Educations = require('../app/Models/Educations');
const Approvers = require('../app/Models/Approvers');
const Leaves = require('../app/Models/Leaves');
const LeaveDate = require('../app/Models/LeaveDate');
const Roles = require('../app/Models/Roles');
const RolePermission = require('../app/Models/RolePermission');
const BusinessTrip = require('../app/Models/BusinessTrip');
const Holidays = require('../app/Models/Holidays');
const Notification = require('../app/Models/Notification');
const NotificationReceiver = require('../app/Models/NotificationReceiver');
const Undertime = require('../app/Models/Undertime');
const Overtime = require('../app/Models/Overtime');
const Shift = require('../app/Models/Shift');
const Biometrics = require('../app/Models/Biometrics');
const Configuration = require('../app/Models/Configuration');
const Incentive = require('../app/Models/Incentive');
const Salary = require('../app/Models/Salary');
const Loan = require('../app/Models/Loan');
const Document = require('../app/Models/Document');
const BiometricNumber = require('../app/Models/BiometricNumber');
const BiometricCsv = require('../app/Models/BiometricCsv');
const Module = require('../app/Models/Module');
const LeavePolicy = require('../app/Models/LeavePolicy');
const LeaveCreditPolicy = require('../app/Models/LeaveCreditPolicy');
const TwoFactorAuth = require('../app/Models/TwoFactorAuth');
const Announcement = require('../app/Models/Announcement');
const TempInOut = require('../app/Models/TempInOut');
const LoanPayment = require('../app/Models/LoanPayment');
const Adjustment = require('../app/Models/Adjustment');
const Dispute = require('../app/Models/Dispute');
const CustomApprover = require('../app/Models/CustomApprover');
const UserSetting = require('../app/Models/UserSetting');
const WorkSchedule = require('../app/Models/WorkSchedule');
const Logger = require('../app/Models/Logger');
const CrmChase = require('../app/Models/CrmChase');
const CrmClone = require('../app/Models/CrmClone');
const CrmMember = require('../app/Models/CrmMember');
const Event = require('../app/Models/Event');
const PayslipModel = require('../app/Models/Payslip');
const PayrollModel = require('../app/Models/Payroll');

//New Models
const LocationModel = require('../app/Models/LocationModel');
const DivisionModel = require('../app/Models/DivisionModel');
const DepartmentModel = require('../app/Models/DepartmentModel');
const SectionModel = require('../app/Models/SectionModel');
const PositionModel = require('../app/Models/PositionModel');
const PositionCategoryModel = require('../app/Models/PositionCategoryModel');
const PositionClassificationModel = require('../app/Models/PositionClassificationModel');
const WorkAreaModel = require('../app/Models/WorkAreaModel');
const ShiftTypeModel = require('../app/Models/ShiftTypeModel');
const EmployeeTypeModel = require('../app/Models/EmployeeTypeModel');
const BiometricLogModel = require('../app/Models/BiometricLogModel');
const TSSModel = require('../app/Models/TSSModel');
const TSSDataModel = require('../app/Models/TSSDataModel');
const TSSSummaryModel = require('../app/Models/TSSSummaryModel');
const BusinessTripDateModel = require('../app/Models/BusinessTripDateModel');
const ChangeLog = require('../app/Models/ChangeLog');
const CronJob = require('../app/Models/CronJob');
const DeletedLogIssues = require('../app/Models/DeletedLogIssues');
const Training  = require('../app/Models/Training');
const Performance = require('../app/Models/Performance');
const License = require('../app/Models/License');
const Disciplinary_cases = require('../app/Models/DisciplinaryModel');
const Memorandum = require('../app/Models/Memo');
const Award = require('../app/Models/Award');
const Skill = require('../app/Models/Skill');
const EmergencyContact = require('../app/Models/EmergencyContact');
const FamilyBackground = require('../app/Models/FamilyBackground');
const Address = require('../app/Models/Address');
const EmploymentHistory = require('../app/Models/EmploymentHistory');
const Certifications = require('../app/Models/Certifications');
const Attachments = require('../app/Models/Attachment');

/*
|----------------------------------------------------------------------------------------
| Sequelize
| Database connection
|----------------------------------------------------------------------------------------
*/
const sequelize = new Sequelize($env.parsed.DB_DATABASE, $env.parsed.DB_USER, $env.parsed.DB_PASS, {
    operatorsAliases,
    dialect: 'mssql',
    host: $env.parsed.DB_HOST,
    port: $env.parsed.DB_PORT, // Default port
    connectTimeout : 600000,
    dialectOptions: {
        instanceName: 'OLIVET',
        options: { requestTimeout: 600000,
                   connectTimeout: 600000 },
        dateStrings: true,
        typeCast: function (field, next) { // for reading from database
            if (field.type === 'DATETIME') {
              return field.string()
            }
            if (field.type === 'TIME') {
              return field.string()
            }
            return next()
        },
    },
    retry: {
      match: [/Deadlock/i],
      max: 5, // Maximum rety 3 times
      backoffBase: 1000, // Initial backoff duration in ms. Default: 100,
      backoffExponent: 1.5, // Exponent to increase backoff each try. Default: 1.1
    },
    pool: {
        max: 200,
        min: 0,
        idle: 20000,
        acquire: 900000,
        timestamps: false,
        dateStrings: true
    },
    timezone: $env.parsed.timezone,
    logging: false
})
/*
const sequelize = new Sequelize($env.parsed.DB_DATABASE, $env.parsed.DB_USER, $env.parsed.DB_PASS, {
        operatorsAliases,
		host: $env.parsed.DB_HOST,
		dialect: 'mysql',
        dialectOptions:{
            dateStrings: true,
            typeCast: function (field, next) { // for reading from database
                if (field.type === 'DATETIME') {
                  return field.string()
                }
                return next()
            },
        },
		pool: {
			max: 10,
			min: 0,
			acquire: 30000,
			idle: 10000,
			timestamps: false,
            dateStrings: true
		},
        timezone: $env.parsed.timezone,
		logging: false
	}
);
*/
// console.log(sequelize);
sequelize.authenticate().then(() => {
    console.log('Nice! Database looks fine.'.green);
}).catch(err => {
    console.log(err);
    console.log('Something went wrong with the Database Connection.'.red);
});

const BrandingModel = Branding(sequelize, Sequelize);
const CountryModel = Countries(sequelize, Sequelize);
const UsersModel = Users(sequelize, Sequelize);
const CandidateProfileModel = CandidateProfile(sequelize, Sequelize);
const InterviewModel = Interview(sequelize, Sequelize);
const InterviewRatingModel = InterviewRating(sequelize, Sequelize);
const TaxonomyModel = Taxonomy(sequelize, Sequelize);
const CompanyModel = Companies(sequelize, Sequelize);
const EmploymentsModel = Employments(sequelize, Sequelize);
const BranchesModel = Branches(sequelize, Sequelize);
const RequirementModel = Requirements(sequelize, Sequelize);
const EducationsModel = Educations(sequelize, Sequelize);
const ApproversModel = Approvers(sequelize, Sequelize);
const LeavesModel = Leaves(sequelize, Sequelize);
const LeaveDateModel = LeaveDate(sequelize, Sequelize);
const RoleModel = Roles(sequelize, Sequelize);
const RolePermissionModel = RolePermission(sequelize, Sequelize);
const HolidaysModel = Holidays(sequelize, Sequelize);
const BusinessTripsModel = BusinessTrip(sequelize, Sequelize);
const NotificationsModel = Notification(sequelize, Sequelize);
const NotificationsReceiverModel = NotificationReceiver(sequelize, Sequelize);
const UndertimeModel = Undertime(sequelize, Sequelize);
const OvertimesModel = Overtime(sequelize, Sequelize);
const ShiftsModel = Shift(sequelize, Sequelize);
const BiometricModel = Biometrics(sequelize, Sequelize);
const ConfigModel = Configuration(sequelize, Sequelize);
const IncentiveModel = Incentive(sequelize, Sequelize);
const SalaryModel = Salary(sequelize, Sequelize);
const LoanModel = Loan(sequelize, Sequelize);
const DocumentModel = Document(sequelize, Sequelize);
const BiometricNumberModel = BiometricNumber(sequelize, Sequelize);
const BiometricCsvModel = BiometricCsv(sequelize, Sequelize);
const ModuleModel = Module(sequelize, Sequelize);
const LeavePolicyModel = LeavePolicy(sequelize, Sequelize);
const LeaveCreditPolicyModel = LeaveCreditPolicy(sequelize, Sequelize);
const TwoFactorAuthModel = TwoFactorAuth(sequelize, Sequelize);
const AnnouncementModel = Announcement(sequelize, Sequelize);
const TempInOutModel = TempInOut(sequelize, Sequelize);
const LoanPaymentModel = LoanPayment(sequelize, Sequelize);
const AdjustmentModel = Adjustment(sequelize, Sequelize);
const DisputeModel = Dispute(sequelize, Sequelize);
const CustomApproverModel = CustomApprover(sequelize, Sequelize);
const UserSettingModel = UserSetting(sequelize, Sequelize);
const WorkScheduleModel = WorkSchedule(sequelize, Sequelize);
const LoggerModel = Logger(sequelize, Sequelize);
const CrmChaseModel = CrmChase(sequelize, Sequelize);
//const CrmDropModel = CrmDrop(sequelize, Sequelize);
const CrmCloneModel = CrmClone(sequelize, Sequelize);
const CrmMemberModel = CrmMember(sequelize, Sequelize);
const EventModel = Event(sequelize, Sequelize);
const Payslip = PayslipModel(sequelize, Sequelize);
const Payroll = PayrollModel(sequelize, Sequelize);
const Location = LocationModel(sequelize, Sequelize);
const Division = DivisionModel(sequelize, Sequelize);
const Department = DepartmentModel(sequelize, Sequelize);
const Section = SectionModel(sequelize, Sequelize);
const Position = PositionModel(sequelize, Sequelize);
const PositionCategory = PositionCategoryModel(sequelize, Sequelize);
const PositionClassification = PositionClassificationModel(sequelize, Sequelize);
const WorkArea = WorkAreaModel(sequelize, Sequelize);
const ShiftType = ShiftTypeModel(sequelize, Sequelize);
const EmployeeType = EmployeeTypeModel(sequelize, Sequelize);
const BiometricLog = BiometricLogModel(sequelize, Sequelize);
const TSS = TSSModel(sequelize, Sequelize);
const TSSData = TSSDataModel(sequelize, Sequelize);
const TSSSummary = TSSSummaryModel(sequelize, Sequelize);
const BusinessTripDate = BusinessTripDateModel(sequelize, Sequelize);
const ChangeLogModel = ChangeLog(sequelize, Sequelize);
const CronJobModel = CronJob(sequelize, Sequelize);
const DeletedLogIssuesModel = DeletedLogIssues(sequelize, Sequelize);
const TrainingModel = Training(sequelize, Sequelize);
const PerformanceReview  = Performance(sequelize, Sequelize);
const LicenseModel = License(sequelize, Sequelize);
const DisciplinaryModel = Disciplinary_cases(sequelize, Sequelize);
const MemoModel = Memorandum(sequelize, Sequelize);
const AwardModel = Award(sequelize, Sequelize);
const SkillModel = Skill(sequelize, Sequelize);
const EmergencyContactModel = EmergencyContact(sequelize, Sequelize);
const FamilyBackgroundModel = FamilyBackground(sequelize, Sequelize);
const AddressModel = Address(sequelize, Sequelize);
const EmploymentHistoryModel = EmploymentHistory(sequelize, Sequelize);
const CertificationsModel = Certifications(sequelize, Sequelize);
const AttachmentModel = Attachments(sequelize, Sequelize);

// sequelize.sync({
//     force: true,
//     alter: false,
// });

/*
|----------------------------------------------------------------------------------------
| Table relationships
|----------------------------------------------------------------------------------------
| Candidate
|----------------------------------------------------------------------------------------
*/

CandidateProfileModel.hasOne(InterviewModel, {foreignKey: 'candidate_profile_id'});
/*
|----------------------------------------------------------------------------------------
| Branches
|----------------------------------------------------------------------------------------
*/
BranchesModel.belongsTo(CompanyModel, {foreignKey: 'company_id'});
BranchesModel.belongsTo(CountryModel, {foreignKey: 'country_id'});
/*
|----------------------------------------------------------------------------------------
| Interview
|----------------------------------------------------------------------------------------
*/
InterviewModel.belongsTo(UsersModel, { foreignKey: 'interviewer'});

/*
|----------------------------------------------------------------------------------------
| Employments
|----------------------------------------------------------------------------------------
*/
// EmploymentsModel.belongsTo(TaxonomyModel, {as: 'department', foreignKey: 'department_id'}); // department
// EmploymentsModel.belongsTo(TaxonomyModel, {as: 'job_title', foreignKey: 'job_title_id'}); // Job Title
// EmploymentsModel.belongsTo(TaxonomyModel, {as: 'team', foreignKey: 'team_id'}); // Team
EmploymentsModel.belongsTo(BranchesModel, {foreignKey: 'company_branch_id'});

EmploymentsModel.belongsTo(CompanyModel, { as:'company', foreignKey:'company_id' } );
EmploymentsModel.belongsTo(Division, { as:'division', foreignKey:'division_id' } );
EmploymentsModel.belongsTo(Department, { as:'department', foreignKey:'department_id' } );
EmploymentsModel.belongsTo(Section, { as:'section', foreignKey:'section_id' } );
EmploymentsModel.belongsTo(Position, { as:'position', foreignKey:'position_id' } );
EmploymentsModel.belongsTo(PositionClassification, { as:'position_classification', foreignKey:'position_classification_id' } );
EmploymentsModel.belongsTo(PositionCategory, { as:'position_category', foreignKey:'position_category_id' } );
EmploymentsModel.belongsTo(BranchesModel, { as:'location', foreignKey:'branch_id' } );
EmploymentsModel.belongsTo(WorkArea, { as:'work_area', foreignKey:'work_area_id' } );

// EmploymentsModel.belongsTo(CompanyModel, { as:'company', foreignKey:'company_id' } );
// EmploymentsModel.belongsTo(CompanyModel, { as:'company', foreignKey:'company_id' } );
EmploymentsModel.belongsTo(Location,{foreignKey:'location_id'});
EmploymentsModel.belongsTo(UsersModel,{as:'employment', foreignKey:'user_id'});
BranchesModel.hasOne(Location, {foreignKey:'id',targetKey:'location_id'});
/*
|----------------------------------------------------------------------------------------
| Users
|----------------------------------------------------------------------------------------
*/
UsersModel.belongsTo(TaxonomyModel, {as: 'department', foreignKey: 'department_id'}); // department
UsersModel.belongsTo(TaxonomyModel, {as: 'job_title', foreignKey: 'job_title_id'}); // department
UsersModel.belongsTo(TaxonomyModel, {as: 'team', foreignKey: 'team_id'}); // department
UsersModel.belongsTo(BranchesModel, {foreignKey: 'company_branch_id'});
UsersModel.belongsTo(WorkScheduleModel, {foreignKey: 'id', targetKey:'user_id'});
UsersModel.hasMany(EmploymentsModel, {foreignKey: 'user_id'});
UsersModel.hasOne(UserSettingModel, {foreignKey: 'user_id'});
UsersModel.hasOne(TwoFactorAuthModel, { as:'twoFactor', foreignKey: 'user_id'});
UsersModel.hasMany(ShiftsModel, { foreignKey: 'user_id'});
UsersModel.hasMany(OvertimesModel, { foreignKey: 'user_id'});
UsersModel.hasMany(LeaveDateModel, { foreignKey: 'user_id'});
UsersModel.hasOne(SalaryModel, { foreignKey: 'user_id'});
UsersModel.hasMany(SalaryModel, { as: 'getsalary',  foreignKey: 'user_id'});

UsersModel.hasMany(LoanPaymentModel, { foreignKey: 'user_id' });
UsersModel.hasMany(TSSData, { foreignKey: 'user_id' });

UsersModel.hasMany(AdjustmentModel, { foreignKey: 'user_id' });
UsersModel.hasMany(DisputeModel, { foreignKey: 'user_id' });
UsersModel.hasMany(IncentiveModel, { foreignKey: 'user_id' });
UsersModel.hasMany(ChangeLogModel, { foreignKey: 'user_id'});
TSSSummary.belongsTo(UsersModel, {foreignKey: 'user_id'});
TSSData.belongsTo(UsersModel, { as: 'users', foreignKey: 'user_id'});

UsersModel.hasMany(BusinessTripDate, { foreignKey: 'user_id'});

/*
|----------------------------------------------------------------------------------------
| Approvers
|----------------------------------------------------------------------------------------
*/
ApproversModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver_id' });
ApproversModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver_id' });
ApproversModel.belongsTo(TaxonomyModel, { as: 'department', foreignKey: 'department_id' });
ApproversModel.belongsTo(BranchesModel, { foreignKey: 'company_location_id' });

/*
|----------------------------------------------------------------------------------------
| Holidays
|----------------------------------------------------------------------------------------
*/
HolidaysModel.belongsTo(CountryModel, { foreignKey: 'country_id' });
HolidaysModel.belongsTo(Location, { foreignKey: 'location_id' });

/*
|----------------------------------------------------------------------------------------
| BusinessTrip
|----------------------------------------------------------------------------------------
*/
BusinessTripsModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
BusinessTripsModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
BusinessTripsModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });
BusinessTripsModel.belongsTo(UsersModel, { as: 'secretary', foreignKey: 'secretary_id' });
BusinessTripsModel.belongsTo(UsersModel, { as: 'alt_secretary', foreignKey: 'alternate_secretary' });

BusinessTripsModel.hasMany(BusinessTripDate, { foreignKey: 'bid' });
BusinessTripDate.belongsTo(BusinessTripsModel, { foreignKey: 'bid' });
/*
|----------------------------------------------------------------------------------------
| Undertime
|----------------------------------------------------------------------------------------
*/
UndertimeModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
UndertimeModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
UndertimeModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });
UndertimeModel.belongsTo(UsersModel, { as: 'secretary', foreignKey: 'secretary_id' });
UndertimeModel.belongsTo(UsersModel, { as: 'alt_secretary', foreignKey: 'alternate_secretary' });

UsersModel.hasMany(UndertimeModel, {foreignKey: 'secretary_id'});
/*
|----------------------------------------------------------------------------------------
| Overtime
|----------------------------------------------------------------------------------------
*/
OvertimesModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
OvertimesModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
OvertimesModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });
OvertimesModel.belongsTo(UsersModel, { as: 'secretary', foreignKey: 'secretary_id' });
OvertimesModel.belongsTo(UsersModel, { as: 'alt_secretary', foreignKey: 'alternate_secretary' });
OvertimesModel.hasOne(ShiftsModel, { as: 'ot_shift_target', foreignKey: 'id', sourceKey: 'shift_id'});

/*
|----------------------------------------------------------------------------------------
| Dispute
|----------------------------------------------------------------------------------------
*/
DisputeModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
DisputeModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
DisputeModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });


/*
|----------------------------------------------------------------------------------------
| EmergencyCotact
|----------------------------------------------------------------------------------------
*/
UsersModel.hasMany(EmergencyContactModel, { foreignKey: 'user_id' });
EmergencyContactModel.belongsTo(UsersModel, { foreignKey: 'user_id' });

AddressModel.hasOne(EmergencyContactModel, { foreignKey: 'permanent_address_id' });
EmergencyContactModel.belongsTo(AddressModel, { foreignKey: 'permanent_address_id' });

/*
|----------------------------------------------------------------------------------------
| Family Background
|----------------------------------------------------------------------------------------
*/
UsersModel.hasMany(FamilyBackgroundModel, { foreignKey: 'user_id' });
FamilyBackgroundModel.belongsTo(UsersModel, { foreignKey: 'user_id' });

AddressModel.hasOne(FamilyBackgroundModel, { foreignKey: 'permanent_address_id' });
FamilyBackgroundModel.belongsTo(AddressModel, { foreignKey: 'permanent_address_id' });

/*
|----------------------------------------------------------------------------------------
| Employment History
|----------------------------------------------------------------------------------------
*/
UsersModel.hasMany(EmploymentHistoryModel, { foreignKey: 'user_id' });
EmploymentHistoryModel.belongsTo(UsersModel, { foreignKey: 'user_id' });

AddressModel.hasOne(EmploymentHistoryModel, { foreignKey: 'address_id' });
EmploymentHistoryModel.belongsTo(AddressModel, { foreignKey: 'address_id' });

/*
|----------------------------------------------------------------------------------------
| Address
|----------------------------------------------------------------------------------------
*/

UsersModel.hasOne(AddressModel, { foreignKey: 'user_id' });
AddressModel.belongsTo(UsersModel, { foreignKey: 'user_id' });
/*
|----------------------------------------------------------------------------------------
| Certifications
|----------------------------------------------------------------------------------------
*/
UsersModel.hasMany(CertificationsModel, { foreignKey: 'user_id' });
CertificationsModel.belongsTo(UsersModel, { foreignKey: 'user_id' });

/*
|----------------------------------------------------------------------------------------
| Payroll Information
|----------------------------------------------------------------------------------------
*/
UsersModel.hasMany(Payroll, { foreignKey: 'user_id' })
Payroll.belongsTo(UsersModel, { foreignKey: 'user_id' })

/*
|----------------------------------------------------------------------------------------
| Leave
|----------------------------------------------------------------------------------------
*/
LeavesModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
LeavesModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
LeavesModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });
LeavesModel.belongsTo(LeavePolicyModel, { foreignKey: 'leave_type', targetKey: 'id' });
LeavesModel.hasMany(LeaveDateModel, { foreignKey: 'leave_id' });
LeaveDateModel.belongsTo(LeavesModel, { foreignKey: 'leave_id' });
// LeaveDateModel.hasOne(LeavesModel, {as: 'leave_info', foreignKey: 'id', targetKey: 'leave_id'});
LeavesModel.hasOne(LeaveDateModel, {as: 'leave_data', foreignKey: 'id', targetKey: 'leave_id'});
// LeavesModel.belongsTo(LeaveDateModel, {as: 'leave_info', foreignKey: 'leave_id', targetKey: 'id'});
/*
|----------------------------------------------------------------------------------------
| Users
|----------------------------------------------------------------------------------------
*/
UsersModel.hasMany(ShiftsModel, { foreignKey: 'user_id' });
UsersModel.hasMany(LeaveCreditPolicyModel, { foreignKey: 'user_id' });
// LeaveCreditPolicyModel.hasOne(LeavePolicyModel, { foreignKey: 'id', targetKey: 'policy_id'});
LeavePolicyModel.belongsTo(LeaveCreditPolicyModel, { targetKey: 'policy_id', foreignKey: 'id' });

/*
|----------------------------------------------------------------------------------------
| Shifts
|----------------------------------------------------------------------------------------
*/
ShiftsModel.belongsTo(UsersModel, {  foreignKey: 'user_id' });
ShiftsModel.belongsTo(OvertimesModel, { foreignKey: 'user_id', targetKey: 'user_id' });
ShiftsModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
ShiftsModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
ShiftsModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });
TSSData.belongsTo(ShiftsModel, { as: 'shift', foreignKey: 'shift_id' });
TSSData.belongsTo(OvertimesModel, { as: 'overtime', foreignKey: 'overtime_id' });
ShiftsModel.belongsTo(TSSData, { as: 'tss', foreignKey: 'id',targetKey: 'shift_id' });
// TSSData.hasOne(ShiftsModel, { as: 'shift', foreignKey: 'id', targetKey:'shift_id' });
ShiftsModel.hasOne(ShiftType,{as:'type_of_shift',foreignKey:'shift_id',sourceKey:'shift_type'});

ShiftsModel.belongsTo(LeavesModel, { as: 'leave', foreignKey: 'user_id', targetKey: 'user_id' });
ShiftsModel.hasMany(OvertimesModel, { as: 'ot', foreignKey: 'shift_id'});
// ShiftsModel.hasMany(BiometricNumberModel, { as:'biometric_number',foreignKey:'user_id', targetKey:'user_id' });
// ShiftsModel.hasMany(ChangeLogModel, { as: 'changelog', foreignKey: 'shift_id'});

/*
|----------------------------------------------------------------------------------------
| Change Log
|----------------------------------------------------------------------------------------
*/
ChangeLogModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });
ChangeLogModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver' });
ChangeLogModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver' });
ChangeLogModel.hasOne(ShiftsModel, { as: 'log_shift', foreignKey: 'id', sourceKey: 'shift_id' });


/*
|----------------------------------------------------------------------------------------
| Notifications
|----------------------------------------------------------------------------------------
*/
NotificationsReceiverModel.belongsTo(NotificationsModel, { foreignKey: 'notification_id' });
NotificationsModel.belongsTo(UsersModel, { foreignKey: 'sender' });

/*
|----------------------------------------------------------------------------------------
| Loan
|----------------------------------------------------------------------------------------
*/
LoanModel.belongsTo(UsersModel, { foreignKey: 'user_id' });
LoanModel.hasMany(LoanPaymentModel, { foreignKey: 'loan_id' });
LoanPaymentModel.belongsTo(LoanModel, { foreignKey: 'loan_id'});


BiometricNumberModel.belongsTo(BiometricModel, { foreignKey: 'biometric_id' });
// BiometricModel.belongsTo(BiometricNumberModel, {as: 'biometric',foreignKey: 'biometric_id'} );

BiometricCsvModel.belongsTo(BiometricModel, { foreignKey: 'site'});

ModuleModel.belongsTo(RolePermissionModel, { foreignKey: 'tag', targetKey: 'module_tag'});

/*
|----------------------------------------------------------------------------------------
| Leave Policy
|----------------------------------------------------------------------------------------
*/
LeavePolicyModel.belongsTo(TaxonomyModel, { foreignKey: 'department'});
LeavePolicyModel.belongsTo(BranchesModel, { foreignKey: 'company'});
// LeavePolicyModel.belongsTo(LeaveCreditPolicyModel, { foreignKey: 'id', targetKey: 'policy_id'});
LeavesModel.belongsTo(LeaveCreditPolicyModel, { foreignKey: 'leave_type', targetKey: 'policy_id' });

AdjustmentModel.belongsTo(UsersModel, { foreignKey: 'user_id'});

UsersModel.hasOne(CustomApproverModel, { as: 'primary', foreignKey: 'primary_approver_id' });
UsersModel.hasOne(CustomApproverModel, { as: 'backup', foreignKey: 'backup_approver_id' });
UsersModel.hasOne(CustomApproverModel, { as: 'employee', foreignKey: 'user_id' });
UsersModel.hasMany(BiometricNumberModel, { as:'biometric_number', foreignKey:'user_id' });

CustomApproverModel.belongsTo(UsersModel, { as: 'primary', foreignKey: 'primary_approver_id' });
CustomApproverModel.belongsTo(UsersModel, { as: 'backup', foreignKey: 'backup_approver_id' });
CustomApproverModel.belongsTo(UsersModel, { as: 'applicant', foreignKey: 'user_id' });

//SalaryModel.belongsTo(UsersModel, { foreignKey: 'user_id'});
//SalaryModel.belongsTo(SalaryModel, { as:'salary', foreignKey: 'user_id'});
WorkScheduleModel.belongsTo(UsersModel, { foreignKey: 'user_id'});

Division.belongsTo(CompanyModel,{ as:'company', foreignKey: 'company_id'});
Division.belongsTo(UsersModel,{ as:'manager', foreignKey: 'manager_id'});
Division.belongsTo(UsersModel,{ as:'assistant_manager', foreignKey: 'assistant_manager_id'});
Division.belongsTo(UsersModel,{ as:'secretary', foreignKey: 'secretary_id'});
Division.belongsTo(UsersModel,{ as:'alt_secretary', foreignKey: 'alternate_secretary'});

Department.belongsTo(Division,{ as:'division', foreignKey: 'division_id'});
Department.belongsTo(UsersModel,{ as:'manager', foreignKey: 'manager_id'});
Department.belongsTo(UsersModel,{ as:'assistant_manager', foreignKey: 'assistant_manager_id'});
Department.belongsTo(UsersModel,{ as:'secretary', foreignKey: 'secretary_id'});
Department.belongsTo(UsersModel,{ as:'alt_secretary', foreignKey: 'alternate_secretary'});
Department.belongsTo(UsersModel,{ as:'hr_generalist', foreignKey: 'hr_generalist_id'});

Section.belongsTo(Department,{ as:'department', foreignKey: 'department_id'});
Section.belongsTo(UsersModel,{ as:'supervisor', foreignKey: 'supervisor_id'});
Section.belongsTo(UsersModel,{ as:'assistant_supervisor', foreignKey: 'assistant_supervisor_id'});
Section.belongsTo(UsersModel,{ as:'secretary', foreignKey: 'secretary_id'});
Section.belongsTo(UsersModel,{ as:'alt_secretary', foreignKey: 'alternate_secretary'});

/*
|----------------------------------------------------------------------------------------
| Exports
|----------------------------------------------------------------------------------------
*/
module.exports = {
    Op,
    sequelize,
    BrandingModel,
    CountryModel,
	UsersModel,
	CandidateProfileModel,
	InterviewModel,
	InterviewRatingModel,
    TaxonomyModel,
    CompanyModel,
    EmploymentsModel,
    BranchesModel,
    RequirementModel,
    EducationsModel,
    ApproversModel,
    LeavesModel,
    RoleModel,
    HolidaysModel,
    BusinessTripsModel,
    NotificationsModel,
    NotificationsReceiverModel,
    UndertimeModel,
    OvertimesModel,
    ShiftsModel,
    BiometricModel,
    ConfigModel,
    IncentiveModel,
    SalaryModel,
    LoanModel,
    DocumentModel,
    BiometricNumberModel,
    BiometricCsvModel,
    ModuleModel,
    RolePermissionModel,
    LeavePolicyModel,
    LeaveCreditPolicyModel,
    LeaveDateModel,
    TwoFactorAuthModel,
    AnnouncementModel,
    TempInOutModel,
    LoanPaymentModel,
    AdjustmentModel,
    DisputeModel,
    CustomApproverModel,
    UserSettingModel,
    LoggerModel,
    WorkScheduleModel,
    CrmChaseModel,
    CrmClone,
    CrmMemberModel,
    EventModel,
    Payslip,
    Payroll,
    //New 
    Location,
    Division,
    Department,
    Section,
    Position,
    PositionCategory,
    PositionClassification,
    WorkArea,
    ShiftType,
    EmployeeType,
    BiometricLog,
    TSS,
    TSSData,
    TSSSummary,
    BusinessTripDate,
    ChangeLogModel,
    CronJobModel,
    DeletedLogIssuesModel,
    LicenseModel,
    DisciplinaryModel,
    MemoModel,
    AwardModel,
    SkillModel,
    EmergencyContactModel,
    FamilyBackgroundModel,
    AddressModel,
    TrainingModel,
    PerformanceReview,
    EmploymentHistoryModel,
    CertificationsModel,
    AttachmentModel,
}


