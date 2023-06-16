/*
 Navicat SQL Server Data Transfer

 Source Server         : MSSQL
 Source Server Type    : SQL Server
 Source Server Version : 15002000
 Source Host           : JULIUSF:1433
 Source Catalog        : philsaga
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002000
 File Encoding         : 65001

 Date: 27/09/2021 12:08:10
*/


-- ----------------------------
-- Table structure for adjustment
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[adjustment]') AND type IN ('U'))
	DROP TABLE [dbo].[adjustment]
GO

CREATE TABLE [dbo].[adjustment] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [user_id] int  NOT NULL,
  [year] int  NOT NULL,
  [month] varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [period] varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [amount] real  NOT NULL,
  [status] int  NOT NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[adjustment] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for announcement
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[announcement]') AND type IN ('U'))
	DROP TABLE [dbo].[announcement]
GO

CREATE TABLE [dbo].[announcement] (
  [id] int  IDENTITY(2,1) NOT NULL,
  [subject] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [short_description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [slug] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_by] int  NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[announcement] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for approvers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[approvers]') AND type IN ('U'))
	DROP TABLE [dbo].[approvers]
GO

CREATE TABLE [dbo].[approvers] (
  [id] int  IDENTITY(26,1) NOT NULL,
  [company_location_id] int  NOT NULL,
  [department_id] int  NOT NULL,
  [primary_approver_id] int DEFAULT NULL NULL,
  [backup_approver_id] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[approvers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for biometric_csv
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[biometric_csv]') AND type IN ('U'))
	DROP TABLE [dbo].[biometric_csv]
GO

CREATE TABLE [dbo].[biometric_csv] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [site] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [filename] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [date] date  NOT NULL
)
GO

ALTER TABLE [dbo].[biometric_csv] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for biometric_logs
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[biometric_logs]') AND type IN ('U'))
	DROP TABLE [dbo].[biometric_logs]
GO

CREATE TABLE [dbo].[biometric_logs] (
  [id] bigint  IDENTITY(1,1) NOT NULL,
  [userId] int  NOT NULL,
  [state] int  NOT NULL,
  [date] datetime  NOT NULL,
  [status] int  NOT NULL,
  [ip_address] nvarchar(16) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [source] nvarchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[biometric_logs] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for biometric_number
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[biometric_number]') AND type IN ('U'))
	DROP TABLE [dbo].[biometric_number]
GO

CREATE TABLE [dbo].[biometric_number] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [user_id] int  NOT NULL,
  [biometric_id] int  NOT NULL,
  [biometric_number] int  NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[biometric_number] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for biometrics
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[biometrics]') AND type IN ('U'))
	DROP TABLE [dbo].[biometrics]
GO

CREATE TABLE [dbo].[biometrics] (
  [id] int  IDENTITY(2,1) NOT NULL,
  [site] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status] int  NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [label] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[biometrics] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for branches
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[branches]') AND type IN ('U'))
	DROP TABLE [dbo].[branches]
GO

CREATE TABLE [dbo].[branches] (
  [id] int  IDENTITY(2,1) NOT NULL,
  [location_id] int  NULL,
  [address] nvarchar(512) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [country_id] int DEFAULT NULL NULL,
  [company_id] int  NOT NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[branches] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for branding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[branding]') AND type IN ('U'))
	DROP TABLE [dbo].[branding]
GO

CREATE TABLE [dbo].[branding] (
  [id] int  IDENTITY(5,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [logo] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [branding] int DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[branding] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for business_trip
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[business_trip]') AND type IN ('U'))
	DROP TABLE [dbo].[business_trip]
GO

CREATE TABLE [dbo].[business_trip] (
  [id] int  IDENTITY(4,1) NOT NULL,
  [user_id] int  NOT NULL,
  [date_start] date  NOT NULL,
  [date_end] date  NOT NULL,
  [title] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [primary_status] int DEFAULT NULL NULL,
  [backup_status] int DEFAULT 1 NULL,
  [primary_approver] int DEFAULT NULL NULL,
  [backup_approver] int DEFAULT NULL NULL,
  [approver_note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [approved_by] int DEFAULT NULL NULL,
  [_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[business_trip] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for candidate_profile
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[candidate_profile]') AND type IN ('U'))
	DROP TABLE [dbo].[candidate_profile]
GO

CREATE TABLE [dbo].[candidate_profile] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [shortid] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [position_applying_for] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [first_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [last_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [current_address] nvarchar(512) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [permanent_address] nvarchar(512) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [email] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [phone_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [alternate_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [birthday] date DEFAULT NULL NULL,
  [gender] nvarchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [marital_status] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [nationality] int DEFAULT NULL NULL,
  [interview_schedule] datetime2(7) DEFAULT NULL NULL,
  [attachment] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [sss_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [pagibig_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [tin_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [philhealth_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [interview_status] int DEFAULT 1 NOT NULL,
  [note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [company] int DEFAULT NULL NULL,
  [department] int DEFAULT NULL NULL,
  [job_title] int DEFAULT NULL NULL,
  [start_date] date DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[candidate_profile] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for companies
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[companies]') AND type IN ('U'))
	DROP TABLE [dbo].[companies]
GO

CREATE TABLE [dbo].[companies] (
  [id] int  IDENTITY(2,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [logo] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[companies] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for configuration
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[configuration]') AND type IN ('U'))
	DROP TABLE [dbo].[configuration]
GO

CREATE TABLE [dbo].[configuration] (
  [id] int  IDENTITY(2,1) NOT NULL,
  [json] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[configuration] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for countries
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[countries]') AND type IN ('U'))
	DROP TABLE [dbo].[countries]
GO

CREATE TABLE [dbo].[countries] (
  [id] int  IDENTITY(251,1) NOT NULL,
  [iso] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [name] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [code] nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[countries] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for crm_chase
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[crm_chase]') AND type IN ('U'))
	DROP TABLE [dbo].[crm_chase]
GO

CREATE TABLE [dbo].[crm_chase] (
  [id] int  IDENTITY(6,1) NOT NULL,
  [account] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [project_site] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [type] int DEFAULT NULL NULL,
  [revenue] real DEFAULT NULL NULL,
  [sales] nvarchar(11) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[crm_chase] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for crm_clone
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[crm_clone]') AND type IN ('U'))
	DROP TABLE [dbo].[crm_clone]
GO

CREATE TABLE [dbo].[crm_clone] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [chase_id] int  NOT NULL,
  [sqm] real DEFAULT NULL NULL,
  [reason] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [flag] int  NOT NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[crm_clone] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for crm_members
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[crm_members]') AND type IN ('U'))
	DROP TABLE [dbo].[crm_members]
GO

CREATE TABLE [dbo].[crm_members] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [win_id] int  NOT NULL,
  [user_id] int  NOT NULL
)
GO

ALTER TABLE [dbo].[crm_members] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for custom_approver
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[custom_approver]') AND type IN ('U'))
	DROP TABLE [dbo].[custom_approver]
GO

CREATE TABLE [dbo].[custom_approver] (
  [id] int  IDENTITY(34,1) NOT NULL,
  [user_id] int  NOT NULL,
  [primary_approver_id] int DEFAULT NULL NULL,
  [backup_approver_id] int DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[custom_approver] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for departments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[departments]') AND type IN ('U'))
	DROP TABLE [dbo].[departments]
GO

CREATE TABLE [dbo].[departments] (
  [id] int  IDENTITY(7,1) NOT NULL,
  [division_id] int  NOT NULL,
  [department_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [department_code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [manager_id] int  NOT NULL,
  [assistant_manager_id] int DEFAULT NULL NULL,
  [secretary_id] int  NOT NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [deletedAt] datetime2(7) DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[departments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for dispute
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[dispute]') AND type IN ('U'))
	DROP TABLE [dbo].[dispute]
GO

CREATE TABLE [dbo].[dispute] (
  [id] int  IDENTITY(6,1) NOT NULL,
  [user_id] int  NOT NULL,
  [year] int DEFAULT NULL NULL,
  [month] nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [period] nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [hour] int  NOT NULL,
  [date] date DEFAULT NULL NULL,
  [type] int  NOT NULL,
  [note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [primary_status] int DEFAULT 1 NULL,
  [backup_status] int DEFAULT 1 NULL,
  [primary_approver] int DEFAULT NULL NULL,
  [backup_approver] int DEFAULT NULL NULL,
  [admin_status] int DEFAULT 1 NULL,
  [_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [document] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[dispute] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for divisions
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[divisions]') AND type IN ('U'))
	DROP TABLE [dbo].[divisions]
GO

CREATE TABLE [dbo].[divisions] (
  [id] int  IDENTITY(9,1) NOT NULL,
  [company_id] int  NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [manager_id] int DEFAULT NULL NULL,
  [assistant_manager_id] int DEFAULT NULL NULL,
  [secretary_id] int DEFAULT NULL NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT NULL NULL,
  [deletedAt] datetime2(7) DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[divisions] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for educations
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[educations]') AND type IN ('U'))
	DROP TABLE [dbo].[educations]
GO

CREATE TABLE [dbo].[educations] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [user_id] int  NOT NULL,
  [school] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [degree] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [year_attended] nvarchar(16) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [post_graduate] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [others] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[educations] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for employee_type
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[employee_type]') AND type IN ('U'))
	DROP TABLE [dbo].[employee_type]
GO

CREATE TABLE [dbo].[employee_type] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT NULL NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[employee_type] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for employments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[employments]') AND type IN ('U'))
	DROP TABLE [dbo].[employments]
GO

CREATE TABLE [dbo].[employments] (
  [id] int  IDENTITY(10,1) NOT NULL,
  [user_id] int  NOT NULL,
  [employee_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [company_id] int DEFAULT NULL NULL,
  [company_branch_id] int DEFAULT NULL NULL,
  [division_id] int DEFAULT NULL NULL,
  [department_id] int DEFAULT NULL NULL,
  [section_id] int DEFAULT NULL NULL,
  [position_id] int DEFAULT NULL NULL,
  [position_classification_id] int DEFAULT NULL NULL,
  [position_category_id] int DEFAULT NULL NULL,
  [approving_organization] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT N'' NULL,
  [work_area_id] int DEFAULT NULL NULL,
  [branch_id] int DEFAULT NULL NULL,
  [job_title_id] int  NULL,
  [date_entry] date DEFAULT NULL NULL,
  [date_exit] date DEFAULT NULL NULL,
  [comment] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [team_id] int DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [location_id] int  NULL
)
GO

ALTER TABLE [dbo].[employments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for events
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[events]') AND type IN ('U'))
	DROP TABLE [dbo].[events]
GO

CREATE TABLE [dbo].[events] (
  [id] int  IDENTITY(10,1) NOT NULL,
  [user_id] int  NOT NULL,
  [date] datetime2(7)  NOT NULL,
  [end_date] datetime2(7) DEFAULT NULL NULL,
  [type] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [comment] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[events] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for holidays
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[holidays]') AND type IN ('U'))
	DROP TABLE [dbo].[holidays]
GO

CREATE TABLE [dbo].[holidays] (
  [id] int  IDENTITY(7,1) NOT NULL,
  [country_id] int DEFAULT NULL NULL,
  [location_id] int DEFAULT NULL NULL,
  [date] date  NOT NULL,
  [title] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [type] int  NOT NULL,
  [status] int DEFAULT 1 NOT NULL,
  [note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[holidays] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for incentive
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[incentive]') AND type IN ('U'))
	DROP TABLE [dbo].[incentive]
GO

CREATE TABLE [dbo].[incentive] (
  [id] int  IDENTITY(70,1) NOT NULL,
  [user_id] int  NOT NULL,
  [from] date DEFAULT NULL NULL,
  [to] date DEFAULT NULL NULL,
  [amount] real  NOT NULL,
  [label] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [mode] int  NOT NULL,
  [status] int DEFAULT 1 NOT NULL,
  [period] int DEFAULT NULL NULL,
  [taxable] int DEFAULT 0 NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[incentive] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for interview
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[interview]') AND type IN ('U'))
	DROP TABLE [dbo].[interview]
GO

CREATE TABLE [dbo].[interview] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [candidate_profile_id] int  NOT NULL,
  [interviewer] int  NOT NULL,
  [interview_date] date  NOT NULL,
  [overall_assessment] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[interview] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for interview_ratings
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[interview_ratings]') AND type IN ('U'))
	DROP TABLE [dbo].[interview_ratings]
GO

CREATE TABLE [dbo].[interview_ratings] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [interview_id] int  NOT NULL,
  [title] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [candidate_rating] int  NOT NULL,
  [job_relevance] int  NOT NULL,
  [notes] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[interview_ratings] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for leave_credit_policy
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[leave_credit_policy]') AND type IN ('U'))
	DROP TABLE [dbo].[leave_credit_policy]
GO

CREATE TABLE [dbo].[leave_credit_policy] (
  [id] int  IDENTITY(488,1) NOT NULL,
  [user_id] int  NOT NULL,
  [policy_id] int  NOT NULL,
  [balance] real DEFAULT NULL NULL,
  [utilized] real DEFAULT NULL NULL,
  [cycle] date DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[leave_credit_policy] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for leave_policy
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[leave_policy]') AND type IN ('U'))
	DROP TABLE [dbo].[leave_policy]
GO

CREATE TABLE [dbo].[leave_policy] (
  [id] int  IDENTITY(7,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [total_per_year] int  NOT NULL,
  [gender] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [probation_validity] int  NOT NULL,
  [initial] int DEFAULT NULL NULL,
  [cycle] int  NOT NULL,
  [increment] int DEFAULT NULL NULL,
  [max_increment] int DEFAULT NULL NULL,
  [status] int  NOT NULL,
  [company] int DEFAULT NULL NULL,
  [department] int DEFAULT NULL NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [carry_over] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[leave_policy] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for leaves
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[leaves]') AND type IN ('U'))
	DROP TABLE [dbo].[leaves]
GO

CREATE TABLE [dbo].[leaves] (
  [id] int  IDENTITY(24,1) NOT NULL,
  [user_id] int  NOT NULL,
  [dates] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [start_date] date  NOT NULL,
  [end_date] date  NOT NULL,
  [leave_type] int  NOT NULL,
  [other] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [no_of_days] real  NOT NULL,
  [credit] int  NOT NULL,
  [reason] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [attachment] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [primary_status] int DEFAULT 1 NOT NULL,
  [backup_status] int DEFAULT NULL NULL,
  [primary_approver] int DEFAULT NULL NULL,
  [backup_approver] int DEFAULT NULL NULL,
  [approver_note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [is_hr] int DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [proccessed] int DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[leaves] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for leaves_date
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[leaves_date]') AND type IN ('U'))
	DROP TABLE [dbo].[leaves_date]
GO

CREATE TABLE [dbo].[leaves_date] (
  [id] int  IDENTITY(104,1) NOT NULL,
  [leave_id] int  NOT NULL,
  [user_id] int  NOT NULL,
  [date] date  NOT NULL,
  [number_of_day] real  NOT NULL
)
GO

ALTER TABLE [dbo].[leaves_date] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for loan
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[loan]') AND type IN ('U'))
	DROP TABLE [dbo].[loan]
GO

CREATE TABLE [dbo].[loan] (
  [id] int  IDENTITY(3,1) NOT NULL,
  [user_id] int  NOT NULL,
  [amount] real  NOT NULL,
  [label] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [mode_of_payment] int  NOT NULL,
  [date_to_pay] date DEFAULT NULL NULL,
  [frequency] int DEFAULT NULL NULL,
  [status] int DEFAULT NULL NULL,
  [note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [year] nvarchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [month] nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [period] nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [loan_type] int DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[loan] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for loan_payments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[loan_payments]') AND type IN ('U'))
	DROP TABLE [dbo].[loan_payments]
GO

CREATE TABLE [dbo].[loan_payments] (
  [id] int  IDENTITY(7,1) NOT NULL,
  [loan_id] int  NOT NULL,
  [user_id] int  NOT NULL,
  [year] int  NOT NULL,
  [month] nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [period] nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [amount] real DEFAULT NULL NULL,
  [status] int DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[loan_payments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for locations
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[locations]') AND type IN ('U'))
	DROP TABLE [dbo].[locations]
GO

CREATE TABLE [dbo].[locations] (
  [id] int  IDENTITY(5,1) NOT NULL,
  [location] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [createdAt] datetime DEFAULT getdate() NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[locations] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for logs
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[logs]') AND type IN ('U'))
	DROP TABLE [dbo].[logs]
GO

CREATE TABLE [dbo].[logs] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [date] datetime2(7)  NOT NULL,
  [message] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[logs] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for modules
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[modules]') AND type IN ('U'))
	DROP TABLE [dbo].[modules]
GO

CREATE TABLE [dbo].[modules] (
  [id] int  IDENTITY(72,1) NOT NULL,
  [title] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [tag] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status] int DEFAULT 1 NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[modules] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for notification
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[notification]') AND type IN ('U'))
	DROP TABLE [dbo].[notification]
GO

CREATE TABLE [dbo].[notification] (
  [id] int  IDENTITY(58,1) NOT NULL,
  [sender] int  NOT NULL,
  [content] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [url] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [date] datetime DEFAULT getdate() NULL,
  [created_by] int  NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[notification] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for notification_receiver
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[notification_receiver]') AND type IN ('U'))
	DROP TABLE [dbo].[notification_receiver]
GO

CREATE TABLE [dbo].[notification_receiver] (
  [id] bigint  IDENTITY(57,1) NOT NULL,
  [notification_id] int  NOT NULL,
  [user_id] int  NOT NULL,
  [status] int DEFAULT 0 NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[notification_receiver] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for overtimes
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[overtimes]') AND type IN ('U'))
	DROP TABLE [dbo].[overtimes]
GO

CREATE TABLE [dbo].[overtimes] (
  [id] int  IDENTITY(11,1) NOT NULL,
  [user_id] int  NOT NULL,
  [type] int DEFAULT 1 NOT NULL,
  [start_date] date DEFAULT NULL NULL,
  [end_date] date DEFAULT NULL NULL,
  [start_time] time(7) DEFAULT NULL NULL,
  [end_time] time(7) DEFAULT NULL NULL,
  [actual_check_in] time(7) DEFAULT NULL NULL,
  [actual_check_out] time(7) DEFAULT NULL NULL,
  [no_of_hours] int  NOT NULL,
  [purpose] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [primary_status] int DEFAULT NULL NULL,
  [backup_status] int DEFAULT NULL NULL,
  [primary_approver] int DEFAULT NULL NULL,
  [backup_approver] int DEFAULT NULL NULL,
  [approver_note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[overtimes] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for payroll
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[payroll]') AND type IN ('U'))
	DROP TABLE [dbo].[payroll]
GO

CREATE TABLE [dbo].[payroll] (
  [id] int  IDENTITY(8,1) NOT NULL,
  [period] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [attachment] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [date] datetime2(7) DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[payroll] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for payroll_group
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[payroll_group]') AND type IN ('U'))
	DROP TABLE [dbo].[payroll_group]
GO

CREATE TABLE [dbo].[payroll_group] (
  [id] int  IDENTITY(3,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [company_location_id] int  NOT NULL,
  [department_id] int  NOT NULL,
  [status] int DEFAULT 1 NOT NULL
)
GO

ALTER TABLE [dbo].[payroll_group] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for payroll_period
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[payroll_period]') AND type IN ('U'))
	DROP TABLE [dbo].[payroll_period]
GO

CREATE TABLE [dbo].[payroll_period] (
  [id] int  IDENTITY(3,1) NOT NULL,
  [payroll_group_id] int  NOT NULL,
  [period] nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [payroll_day] int DEFAULT NULL NULL,
  [payroll_day_from] int DEFAULT NULL NULL,
  [payroll_day_to] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[payroll_period] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for payslips
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[payslips]') AND type IN ('U'))
	DROP TABLE [dbo].[payslips]
GO

CREATE TABLE [dbo].[payslips] (
  [id] bigint  IDENTITY(371,1) NOT NULL,
  [user_id] int DEFAULT NULL NULL,
  [payroll_period] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [employee_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [employee_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [monthly_rate] real DEFAULT NULL NULL,
  [this_pay] real DEFAULT NULL NULL,
  [absence] real DEFAULT NULL NULL,
  [overtime_hrs] real DEFAULT NULL NULL,
  [amount] real DEFAULT NULL NULL,
  [gross_pay] real DEFAULT NULL NULL,
  [reimburseable_allowance] real DEFAULT NULL NULL,
  [other_fees_allowances] real DEFAULT NULL NULL,
  [total_pay] real DEFAULT NULL NULL,
  [tax] real DEFAULT NULL NULL,
  [sss30th] real DEFAULT NULL NULL,
  [phic30th] real DEFAULT NULL NULL,
  [pagibig30th] real DEFAULT NULL NULL,
  [other_deductions] real DEFAULT NULL NULL,
  [sss_loan15th] real DEFAULT NULL NULL,
  [pagibig_loan15th] real DEFAULT NULL NULL,
  [employee_charges] real DEFAULT NULL NULL,
  [intellicare] real DEFAULT NULL NULL,
  [net_pay] real DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[payslips] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for positions
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[positions]') AND type IN ('U'))
	DROP TABLE [dbo].[positions]
GO

CREATE TABLE [dbo].[positions] (
  [id] int  IDENTITY(445,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT N'' NOT NULL,
  [createdAt] datetime DEFAULT getdate() NOT NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[positions] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for positions_category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[positions_category]') AND type IN ('U'))
	DROP TABLE [dbo].[positions_category]
GO

CREATE TABLE [dbo].[positions_category] (
  [id] int  IDENTITY(26,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NOT NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[positions_category] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for positions_classification
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[positions_classification]') AND type IN ('U'))
	DROP TABLE [dbo].[positions_classification]
GO

CREATE TABLE [dbo].[positions_classification] (
  [id] int  IDENTITY(4,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NOT NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[positions_classification] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for requirements
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[requirements]') AND type IN ('U'))
	DROP TABLE [dbo].[requirements]
GO

CREATE TABLE [dbo].[requirements] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [candidate_id] int DEFAULT NULL NULL,
  [title] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[requirements] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[role]') AND type IN ('U'))
	DROP TABLE [dbo].[role]
GO

CREATE TABLE [dbo].[role] (
  [id] int  IDENTITY(9,1) NOT NULL,
  [label] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [slug] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [created_by] int  NOT NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[role] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[role_permission]') AND type IN ('U'))
	DROP TABLE [dbo].[role_permission]
GO

CREATE TABLE [dbo].[role_permission] (
  [id] int  IDENTITY(331,1) NOT NULL,
  [role_id] int DEFAULT NULL NULL,
  [module_tag] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [read] int DEFAULT 0 NULL,
  [write] int DEFAULT 0 NULL,
  [modify] int DEFAULT 0 NULL,
  [delete] int DEFAULT 0 NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[role_permission] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for salary
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[salary]') AND type IN ('U'))
	DROP TABLE [dbo].[salary]
GO

CREATE TABLE [dbo].[salary] (
  [id] int  IDENTITY(93,1) NOT NULL,
  [user_id] int  NOT NULL,
  [start_date] date DEFAULT NULL NULL,
  [end_date] date DEFAULT NULL NULL,
  [amount] real  NOT NULL,
  [mode] int  NOT NULL,
  [payroll] int DEFAULT 2 NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[salary] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for sections
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sections]') AND type IN ('U'))
	DROP TABLE [dbo].[sections]
GO

CREATE TABLE [dbo].[sections] (
  [id] int  IDENTITY(5,1) NOT NULL,
  [department_id] int  NOT NULL,
  [section_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [section_code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [supervisor_id] int DEFAULT NULL NULL,
  [assistant_supervisor_id] int DEFAULT NULL NULL,
  [secretary_id] int DEFAULT NULL NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT NULL NULL,
  [deletedAt] datetime2(7) DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sections] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for shift_type
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[shift_type]') AND type IN ('U'))
	DROP TABLE [dbo].[shift_type]
GO

CREATE TABLE [dbo].[shift_type] (
  [id] int  IDENTITY(48,1) NOT NULL,
  [shift_id] varchar(65) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [shift_desc] varchar(65) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [shift_opt] varchar(65) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [credit_time_in] time(7) DEFAULT NULL NULL,
  [credit_time_out] time(7) DEFAULT NULL NULL,
  [time_in] time(7) DEFAULT NULL NULL,
  [time_out] time(7) DEFAULT NULL NULL,
  [gp] int DEFAULT NULL NULL,
  [break_in] time(7) DEFAULT NULL NULL,
  [break_out] time(7) DEFAULT NULL NULL,
  [num_hours] int DEFAULT NULL NULL,
  [cbamin] time(7) DEFAULT NULL NULL,
  [cbamout] time(7) DEFAULT NULL NULL,
  [cbpmin] time(7) DEFAULT NULL NULL,
  [cbpmout] time(7) DEFAULT NULL NULL,
  [trig_late] time(7) DEFAULT NULL NULL,
  [trig_under] time(7) DEFAULT NULL NULL,
  [early_in] time(7) DEFAULT NULL NULL,
  [early_out] time(7) DEFAULT NULL NULL,
  [late_in] time(7) DEFAULT NULL NULL,
  [late_out] time(7) DEFAULT NULL NULL,
  [flex_am_break] int DEFAULT NULL NULL,
  [flex_pm_break] int DEFAULT NULL NULL,
  [flex_break] int DEFAULT NULL NULL,
  [min_ot] int DEFAULT NULL NULL,
  [hday_by_late] int DEFAULT NULL NULL,
  [ot_type] varchar(45) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [break_hours] int DEFAULT NULL NULL,
  [seq_id] int DEFAULT NULL NULL,
  [gp2] int DEFAULT NULL NULL,
  [trig_absent] varchar(45) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [min_workhours_1h] int DEFAULT NULL NULL,
  [min_workhours_2h] int DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_terminal] int DEFAULT NULL NULL,
  [updated_terminal] int DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NOT NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[shift_type] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for shifts
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[shifts]') AND type IN ('U'))
	DROP TABLE [dbo].[shifts]
GO

CREATE TABLE [dbo].[shifts] (
  [id] bigint  IDENTITY(9395,1) NOT NULL,
  [user_id] int  NOT NULL,
  [type] int  NULL,
  [date] date  NOT NULL,
  [check_in] time(7) DEFAULT NULL NULL,
  [check_out] time(7) DEFAULT NULL NULL,
  [actual_check_in] time(7) DEFAULT NULL NULL,
  [actual_check_out] time(7) DEFAULT NULL NULL,
  [between_start] time(7) DEFAULT NULL NULL,
  [between_end] time(7) DEFAULT NULL NULL,
  [primary_status] int DEFAULT 1 NULL,
  [backup_status] int DEFAULT NULL NULL,
  [shift_length] int DEFAULT NULL NULL,
  [paid_hours] int DEFAULT NULL NULL,
  [primary_approver] int DEFAULT NULL NULL,
  [backup_approver] int DEFAULT NULL NULL,
  [approver_note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [onsite] int DEFAULT 0 NULL,
  [_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [approved_by] int DEFAULT NULL NULL,
  [approved_at] datetime2(7) DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [reg_holiday_work_hrs] int  NULL,
  [reg_holiday_rest_day_work_hrs] int  NULL,
  [reg_special_holiday_restday_work_hrs] int  NULL,
  [double_reg_holiday] int  NULL,
  [special_holiday] int  NULL,
  [special_holiday_restday] int  NULL,
  [late] int  NULL,
  [absent] int  NULL,
  [undertime] int  NULL,
  [awol] int  NULL,
  [actual_work_hours] int  NULL,
  [reg_special_holiday] int  NULL,
  [is_restday] int DEFAULT 0 NULL,
  [night_diff] int  NULL,
  [new_checkin] datetime  NULL,
  [new_checkout] datetime  NULL,
  [old_checkin] datetime  NULL,
  [old_checkout] datetime  NULL,
  [is_change_shift] int  NULL
)
GO

ALTER TABLE [dbo].[shifts] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for taxonomy
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[taxonomy]') AND type IN ('U'))
	DROP TABLE [dbo].[taxonomy]
GO

CREATE TABLE [dbo].[taxonomy] (
  [id] int  IDENTITY(286,1) NOT NULL,
  [parent_id] int  NOT NULL,
  [title] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int  NOT NULL,
  [node] int DEFAULT NULL NULL,
  [system_role] int DEFAULT 0 NOT NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[taxonomy] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for temp_in_out
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[temp_in_out]') AND type IN ('U'))
	DROP TABLE [dbo].[temp_in_out]
GO

CREATE TABLE [dbo].[temp_in_out] (
  [id] int  IDENTITY(20,1) NOT NULL,
  [user_id] int  NOT NULL,
  [date] date  NOT NULL,
  [time] time(7)  NOT NULL,
  [type] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[temp_in_out] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for tss
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[tss]') AND type IN ('U'))
	DROP TABLE [dbo].[tss]
GO

CREATE TABLE [dbo].[tss] (
  [id] bigint  IDENTITY(1,1) NOT NULL,
  [label] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [start_date] date  NULL,
  [end_date] date  NULL,
  [created_at] datetime  NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [dbo].[tss] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for tss_data
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[tss_data]') AND type IN ('U'))
	DROP TABLE [dbo].[tss_data]
GO

CREATE TABLE [dbo].[tss_data] (
  [id] bigint  IDENTITY(1,1) NOT NULL,
  [user_id] int  NULL,
  [tss_id] bigint  NULL,
  [date] date  NULL,
  [RegHrs] int  NULL,
  [LateHrs] int  NULL,
  [UndertimeHrs] int  NULL,
  [NDHrs] int  NULL,
  [Absent] int  NULL,
  [Leave01] int  NULL,
  [Leave02] int  NULL,
  [Leave03] int  NULL,
  [Leave04] int  NULL,
  [Leave05] int  NULL,
  [Leave06] int  NULL,
  [Leave07] int  NULL,
  [Leave08] int  NULL,
  [Leave09] int  NULL,
  [Leave10] int  NULL,
  [Leave11] int  NULL,
  [Leave12] int  NULL,
  [Leave13] int  NULL,
  [Leave14] int  NULL,
  [Leave15] int  NULL,
  [Leave16] int  NULL,
  [Leave17] int  NULL,
  [Leave18] int  NULL,
  [Leave19] int  NULL,
  [Leave20] int  NULL,
  [OTHrs01] int  NULL,
  [OTHrs02] int  NULL,
  [OTHrs03] int  NULL,
  [OTHrs04] int  NULL,
  [OTHrs05] int  NULL,
  [OTHrs06] int  NULL,
  [OTHrs07] int  NULL,
  [OTHrs08] int  NULL,
  [OTHrs09] int  NULL,
  [OTHrs10] int  NULL,
  [OTHrs11] int  NULL,
  [OTHrs12] int  NULL,
  [OTHrs13] int  NULL,
  [OTHrs14] int  NULL,
  [OTHrs15] int  NULL,
  [OTHrs16] int  NULL,
  [OTHrs17] int  NULL,
  [OTHrs18] int  NULL,
  [OTHrs19] int  NULL,
  [OTHrs20] int  NULL,
  [OTHrs21] int  NULL,
  [OTHrs22] int  NULL,
  [OTHrs23] int  NULL,
  [OTHrs24] int  NULL,
  [OTHrs25] int  NULL,
  [Rate] int  NULL,
  [UnpaidRegHrs] int  NULL,
  [UnpaidSL] int  NULL,
  [UnpaidTaxSL] int  NULL,
  [UnpaidVL] int  NULL,
  [UnpaidTaxVL] int  NULL,
  [UnpaidEL] int  NULL,
  [EffectivityDate] int  NULL,
  [EmpStatus] int  NULL,
  [EffectivityDateResign] int  NULL,
  [created_at] datetime  NULL,
  [updated_at] datetime  NULL,
  [noLogInOut] int DEFAULT NULL NULL,
  [shift_id] bigint  NULL
)
GO

ALTER TABLE [dbo].[tss_data] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for tss_summary
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[tss_summary]') AND type IN ('U'))
	DROP TABLE [dbo].[tss_summary]
GO

CREATE TABLE [dbo].[tss_summary] (
  [id] bigint  IDENTITY(1,1) NOT NULL,
  [tss_id] bigint  NOT NULL,
  [RegHrs] int  NULL,
  [LateHrs] int  NULL,
  [UndertimeHrs] int  NULL,
  [NDHrs] int  NULL,
  [Absent] int  NULL,
  [Leave01] int  NULL,
  [Leave02] int  NULL,
  [Leave03] int  NULL,
  [Leave04] int  NULL,
  [Leave05] int  NULL,
  [Leave06] int  NULL,
  [Leave07] int  NULL,
  [Leave08] int  NULL,
  [Leave09] int  NULL,
  [Leave10] int  NULL,
  [Leave11] int  NULL,
  [Leave12] int  NULL,
  [Leave13] int  NULL,
  [Leave14] int  NULL,
  [Leave15] int  NULL,
  [Leave16] int  NULL,
  [Leave17] int  NULL,
  [Leave18] int  NULL,
  [Leave19] int  NULL,
  [Leave20] int  NULL,
  [OTHrs01] int  NULL,
  [OTHrs02] int  NULL,
  [OTHrs03] int  NULL,
  [OTHrs04] int  NULL,
  [OTHrs05] int  NULL,
  [OTHrs06] int  NULL,
  [OTHrs07] int  NULL,
  [OTHrs08] int  NULL,
  [OTHrs09] int  NULL,
  [OTHrs10] int  NULL,
  [OTHrs11] int  NULL,
  [OTHrs12] int  NULL,
  [OTHrs13] int  NULL,
  [OTHrs14] int  NULL,
  [OTHrs15] int  NULL,
  [OTHrs16] int  NULL,
  [OTHrs17] int  NULL,
  [OTHrs18] int  NULL,
  [OTHrs19] int  NULL,
  [OTHrs20] int  NULL,
  [OTHrs21] int  NULL,
  [OTHrs22] int  NULL,
  [OTHrs23] int  NULL,
  [OTHrs24] int  NULL,
  [OTHrs25] int  NULL,
  [Rate] int  NULL,
  [UnpaidRegHrs] int  NULL,
  [UnpaidSL] int  NULL,
  [UnpaidTaxSL] int  NULL,
  [UnpaidVL] int  NULL,
  [UnpaidTaxVL] int  NULL,
  [UnpaidEL] int  NULL,
  [EffectivityDate] int  NULL,
  [EmpStatus] int  NULL,
  [EffectivityDateResign] int  NULL,
  [created_at] datetime  NULL,
  [updated_at] datetime  NULL,
  [user_id] bigint  NULL
)
GO

ALTER TABLE [dbo].[tss_summary] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for two_factor_authentication
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[two_factor_authentication]') AND type IN ('U'))
	DROP TABLE [dbo].[two_factor_authentication]
GO

CREATE TABLE [dbo].[two_factor_authentication] (
  [id] int  IDENTITY(1,1) NOT NULL,
  [user_id] int  NOT NULL,
  [status] int DEFAULT 0 NULL,
  [code] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [validity_date] datetime2(7) DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[two_factor_authentication] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for undertime
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[undertime]') AND type IN ('U'))
	DROP TABLE [dbo].[undertime]
GO

CREATE TABLE [dbo].[undertime] (
  [id] int  IDENTITY(3,1) NOT NULL,
  [user_id] int  NOT NULL,
  [date] date DEFAULT NULL NULL,
  [time] time(7) DEFAULT NULL NULL,
  [reason] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [primary_status] int DEFAULT NULL NULL,
  [backup_status] int DEFAULT NULL NULL,
  [primary_approver] int DEFAULT NULL NULL,
  [backup_approver] int DEFAULT NULL NULL,
  [approver_note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[undertime] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for user_setting
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[user_setting]') AND type IN ('U'))
	DROP TABLE [dbo].[user_setting]
GO

CREATE TABLE [dbo].[user_setting] (
  [id] int  IDENTITY(88,1) NOT NULL,
  [user_id] int  NOT NULL,
  [has_holiday] int DEFAULT NULL NULL,
  [has_overtime] int DEFAULT NULL NULL,
  [work_schedule_method] int DEFAULT 1 NOT NULL
)
GO

ALTER TABLE [dbo].[user_setting] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for users
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type IN ('U'))
	DROP TABLE [dbo].[users]
GO

CREATE TABLE [dbo].[users] (
  [id] int  IDENTITY(119,1) NOT NULL,
  [parent_id] int DEFAULT 0 NOT NULL,
  [shortid] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [first_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [middle_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [suffix] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [nick_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [last_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [gender] nvarchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [birthdate] date DEFAULT NULL NULL,
  [avatar] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [present_address] nvarchar(512) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [permanent_address] nvarchar(512) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [nationality] int DEFAULT NULL NULL,
  [marital_status] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [contact_number] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [email] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [username] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [password] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [status] int DEFAULT 1 NOT NULL,
  [user_role] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [note] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [sss_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [pagibig_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [tin_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [philhealth_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [employee_number] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [company_branch_id] int DEFAULT NULL NULL,
  [department_id] int DEFAULT NULL NULL,
  [job_title_id] int DEFAULT NULL NULL,
  [team_id] int DEFAULT NULL NULL,
  [date_entry] date DEFAULT NULL NULL,
  [resignation_date] date DEFAULT NULL NULL,
  [reset_token] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [employee_type] int DEFAULT NULL NULL,
  [street] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [barangay] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [city] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [province] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [region] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[users] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for users_document
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[users_document]') AND type IN ('U'))
	DROP TABLE [dbo].[users_document]
GO

CREATE TABLE [dbo].[users_document] (
  [id] int  IDENTITY(6,1) NOT NULL,
  [user_id] int  NOT NULL,
  [label] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [hash] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [original_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[users_document] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for work_areas
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[work_areas]') AND type IN ('U'))
	DROP TABLE [dbo].[work_areas]
GO

CREATE TABLE [dbo].[work_areas] (
  [id] int  IDENTITY(5,1) NOT NULL,
  [name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
  [createdAt] datetime DEFAULT getdate() NOT NULL,
  [updatedAt] datetime DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[work_areas] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for work_schedule
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[work_schedule]') AND type IN ('U'))
	DROP TABLE [dbo].[work_schedule]
GO

CREATE TABLE [dbo].[work_schedule] (
  [id] int  IDENTITY(87,1) NOT NULL,
  [user_id] int  NOT NULL,
  [type] int  NOT NULL,
  [effective_date] date  NOT NULL,
  [check_in] time(7) DEFAULT NULL NULL,
  [check_out] time(7) DEFAULT NULL NULL,
  [between_start] time(7) DEFAULT NULL NULL,
  [between_end] time(7) DEFAULT NULL NULL,
  [shift_length] int  NOT NULL,
  [paid_hours] int  NOT NULL,
  [monday] int DEFAULT NULL NULL,
  [tuesday] int DEFAULT NULL NULL,
  [wednesday] int DEFAULT NULL NULL,
  [thursday] int DEFAULT NULL NULL,
  [friday] int DEFAULT NULL NULL,
  [saturday] int DEFAULT NULL NULL,
  [sunday] int DEFAULT NULL NULL,
  [onsite] int DEFAULT 0 NOT NULL,
  [created_by] int DEFAULT NULL NULL,
  [updated_by] int DEFAULT NULL NULL,
  [created_at] datetime DEFAULT getdate() NOT NULL,
  [updated_at] datetime DEFAULT NULL NULL,
  [destination_entitlement] nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [shift_type] int  NULL,
  [rooster_break] int  NULL,
  [break_type] int  NULL
)
GO

ALTER TABLE [dbo].[work_schedule] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Auto increment value for adjustment
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[adjustment]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table adjustment
-- ----------------------------
ALTER TABLE [dbo].[adjustment] ADD CONSTRAINT [PK__adjustme__3213E83F38931458] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for announcement
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[announcement]', RESEED, 2)
GO


-- ----------------------------
-- Primary Key structure for table announcement
-- ----------------------------
ALTER TABLE [dbo].[announcement] ADD CONSTRAINT [PK__announce__3213E83FF34B85B4] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for approvers
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[approvers]', RESEED, 26)
GO


-- ----------------------------
-- Primary Key structure for table approvers
-- ----------------------------
ALTER TABLE [dbo].[approvers] ADD CONSTRAINT [PK__approver__3213E83FD1101001] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for biometric_csv
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[biometric_csv]', RESEED, 1007)
GO


-- ----------------------------
-- Primary Key structure for table biometric_csv
-- ----------------------------
ALTER TABLE [dbo].[biometric_csv] ADD CONSTRAINT [PK__biometri__3213E83FF421774E] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for biometric_logs
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[biometric_logs]', RESEED, 10386)
GO


-- ----------------------------
-- Primary Key structure for table biometric_logs
-- ----------------------------
ALTER TABLE [dbo].[biometric_logs] ADD CONSTRAINT [PK__biometri__3213E83F93E10B68] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for biometric_number
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[biometric_number]', RESEED, 1003)
GO


-- ----------------------------
-- Primary Key structure for table biometric_number
-- ----------------------------
ALTER TABLE [dbo].[biometric_number] ADD CONSTRAINT [PK__biometri__3213E83F13BB5B26] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for biometrics
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[biometrics]', RESEED, 4)
GO


-- ----------------------------
-- Primary Key structure for table biometrics
-- ----------------------------
ALTER TABLE [dbo].[biometrics] ADD CONSTRAINT [PK__biometri__3213E83FC3303539] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for branches
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[branches]', RESEED, 2)
GO


-- ----------------------------
-- Primary Key structure for table branches
-- ----------------------------
ALTER TABLE [dbo].[branches] ADD CONSTRAINT [PK__branches__3213E83FACAD18A6] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for branding
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[branding]', RESEED, 5)
GO


-- ----------------------------
-- Primary Key structure for table branding
-- ----------------------------
ALTER TABLE [dbo].[branding] ADD CONSTRAINT [PK__branding__3213E83F9694342D] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for business_trip
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[business_trip]', RESEED, 4)
GO


-- ----------------------------
-- Primary Key structure for table business_trip
-- ----------------------------
ALTER TABLE [dbo].[business_trip] ADD CONSTRAINT [PK__business__3213E83F1B871DE1] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for candidate_profile
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[candidate_profile]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table candidate_profile
-- ----------------------------
ALTER TABLE [dbo].[candidate_profile] ADD CONSTRAINT [PK__candidat__3213E83F68E602CC] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for companies
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[companies]', RESEED, 2)
GO


-- ----------------------------
-- Primary Key structure for table companies
-- ----------------------------
ALTER TABLE [dbo].[companies] ADD CONSTRAINT [PK__companie__3213E83F606CD1FA] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for configuration
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[configuration]', RESEED, 2)
GO


-- ----------------------------
-- Primary Key structure for table configuration
-- ----------------------------
ALTER TABLE [dbo].[configuration] ADD CONSTRAINT [PK__configur__3213E83FCD92EDFF] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for countries
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[countries]', RESEED, 251)
GO


-- ----------------------------
-- Primary Key structure for table countries
-- ----------------------------
ALTER TABLE [dbo].[countries] ADD CONSTRAINT [PK__countrie__3213E83F171BB17A] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for crm_chase
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[crm_chase]', RESEED, 6)
GO


-- ----------------------------
-- Primary Key structure for table crm_chase
-- ----------------------------
ALTER TABLE [dbo].[crm_chase] ADD CONSTRAINT [PK__crm_chas__3213E83FB45B95E7] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for crm_clone
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[crm_clone]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table crm_clone
-- ----------------------------
ALTER TABLE [dbo].[crm_clone] ADD CONSTRAINT [PK__crm_clon__3213E83F368B8209] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for crm_members
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[crm_members]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table crm_members
-- ----------------------------
ALTER TABLE [dbo].[crm_members] ADD CONSTRAINT [PK__crm_memb__3213E83FE4780F29] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for custom_approver
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[custom_approver]', RESEED, 34)
GO


-- ----------------------------
-- Primary Key structure for table custom_approver
-- ----------------------------
ALTER TABLE [dbo].[custom_approver] ADD CONSTRAINT [PK__custom_a__3213E83F7741943A] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for departments
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[departments]', RESEED, 47)
GO


-- ----------------------------
-- Primary Key structure for table departments
-- ----------------------------
ALTER TABLE [dbo].[departments] ADD CONSTRAINT [PK__departme__3213E83F1C5FE813] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for dispute
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[dispute]', RESEED, 6)
GO


-- ----------------------------
-- Primary Key structure for table dispute
-- ----------------------------
ALTER TABLE [dbo].[dispute] ADD CONSTRAINT [PK__dispute__3213E83FC77892F2] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for divisions
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[divisions]', RESEED, 11)
GO


-- ----------------------------
-- Primary Key structure for table divisions
-- ----------------------------
ALTER TABLE [dbo].[divisions] ADD CONSTRAINT [PK__division__3213E83F468C81FF] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for educations
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[educations]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table educations
-- ----------------------------
ALTER TABLE [dbo].[educations] ADD CONSTRAINT [PK__educatio__3213E83F4329DE56] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for employee_type
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[employee_type]', RESEED, 1000)
GO


-- ----------------------------
-- Auto increment value for employments
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[employments]', RESEED, 1012)
GO


-- ----------------------------
-- Primary Key structure for table employments
-- ----------------------------
ALTER TABLE [dbo].[employments] ADD CONSTRAINT [PK__employme__3213E83F01E20F3B] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for events
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[events]', RESEED, 10)
GO


-- ----------------------------
-- Primary Key structure for table events
-- ----------------------------
ALTER TABLE [dbo].[events] ADD CONSTRAINT [PK__events__3213E83FA558DD83] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for holidays
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[holidays]', RESEED, 7)
GO


-- ----------------------------
-- Primary Key structure for table holidays
-- ----------------------------
ALTER TABLE [dbo].[holidays] ADD CONSTRAINT [PK__holidays__3213E83F24B99F76] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for incentive
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[incentive]', RESEED, 70)
GO


-- ----------------------------
-- Primary Key structure for table incentive
-- ----------------------------
ALTER TABLE [dbo].[incentive] ADD CONSTRAINT [PK__incentiv__3213E83FD2A36369] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for interview
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[interview]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table interview
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_i_cp]
ON [dbo].[interview] (
  [candidate_profile_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table interview
-- ----------------------------
ALTER TABLE [dbo].[interview] ADD CONSTRAINT [PK__intervie__3213E83FB8DE4550] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for interview_ratings
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[interview_ratings]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table interview_ratings
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_cp_id]
ON [dbo].[interview_ratings] (
  [interview_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table interview_ratings
-- ----------------------------
ALTER TABLE [dbo].[interview_ratings] ADD CONSTRAINT [PK__intervie__3213E83F1008CD9B] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for leave_credit_policy
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[leave_credit_policy]', RESEED, 488)
GO


-- ----------------------------
-- Primary Key structure for table leave_credit_policy
-- ----------------------------
ALTER TABLE [dbo].[leave_credit_policy] ADD CONSTRAINT [PK__leave_cr__3213E83F70FB1B69] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for leave_policy
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[leave_policy]', RESEED, 7)
GO


-- ----------------------------
-- Primary Key structure for table leave_policy
-- ----------------------------
ALTER TABLE [dbo].[leave_policy] ADD CONSTRAINT [PK__leave_po__3213E83F4604A810] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for leaves
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[leaves]', RESEED, 41)
GO


-- ----------------------------
-- Primary Key structure for table leaves
-- ----------------------------
ALTER TABLE [dbo].[leaves] ADD CONSTRAINT [PK__leaves__3213E83F9D9D05AD] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for leaves_date
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[leaves_date]', RESEED, 121)
GO


-- ----------------------------
-- Primary Key structure for table leaves_date
-- ----------------------------
ALTER TABLE [dbo].[leaves_date] ADD CONSTRAINT [PK__leaves_d__3213E83FC01D8D8B] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for loan
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[loan]', RESEED, 3)
GO


-- ----------------------------
-- Primary Key structure for table loan
-- ----------------------------
ALTER TABLE [dbo].[loan] ADD CONSTRAINT [PK__loan__3213E83FD5F0CB35] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for loan_payments
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[loan_payments]', RESEED, 7)
GO


-- ----------------------------
-- Primary Key structure for table loan_payments
-- ----------------------------
ALTER TABLE [dbo].[loan_payments] ADD CONSTRAINT [PK__loan_pay__3213E83F2037E6C8] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for locations
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[locations]', RESEED, 5)
GO


-- ----------------------------
-- Primary Key structure for table locations
-- ----------------------------
ALTER TABLE [dbo].[locations] ADD CONSTRAINT [PK__location__3213E83F257AD727] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for logs
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[logs]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table logs
-- ----------------------------
ALTER TABLE [dbo].[logs] ADD CONSTRAINT [PK__logs__3213E83FA670A7E5] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for modules
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[modules]', RESEED, 75)
GO


-- ----------------------------
-- Primary Key structure for table modules
-- ----------------------------
ALTER TABLE [dbo].[modules] ADD CONSTRAINT [PK__modules__3213E83FCA246176] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for notification
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[notification]', RESEED, 2077)
GO


-- ----------------------------
-- Primary Key structure for table notification
-- ----------------------------
ALTER TABLE [dbo].[notification] ADD CONSTRAINT [PK__notifica__3213E83FCBC5E38C] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for notification_receiver
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[notification_receiver]', RESEED, 20076)
GO


-- ----------------------------
-- Primary Key structure for table notification_receiver
-- ----------------------------
ALTER TABLE [dbo].[notification_receiver] ADD CONSTRAINT [PK__notifica__3213E83FC0078661] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for overtimes
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[overtimes]', RESEED, 20)
GO


-- ----------------------------
-- Primary Key structure for table overtimes
-- ----------------------------
ALTER TABLE [dbo].[overtimes] ADD CONSTRAINT [PK__overtime__3213E83F94E014AC] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for payroll
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[payroll]', RESEED, 8)
GO


-- ----------------------------
-- Primary Key structure for table payroll
-- ----------------------------
ALTER TABLE [dbo].[payroll] ADD CONSTRAINT [PK__payroll__3213E83FB59E362C] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for payroll_group
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[payroll_group]', RESEED, 3)
GO


-- ----------------------------
-- Primary Key structure for table payroll_group
-- ----------------------------
ALTER TABLE [dbo].[payroll_group] ADD CONSTRAINT [PK__payroll___3213E83F7591FB58] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for payroll_period
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[payroll_period]', RESEED, 3)
GO


-- ----------------------------
-- Primary Key structure for table payroll_period
-- ----------------------------
ALTER TABLE [dbo].[payroll_period] ADD CONSTRAINT [PK__payroll___3213E83FBD2D7CD1] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for payslips
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[payslips]', RESEED, 371)
GO


-- ----------------------------
-- Primary Key structure for table payslips
-- ----------------------------
ALTER TABLE [dbo].[payslips] ADD CONSTRAINT [PK__payslips__3213E83F6EC15418] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for positions
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[positions]', RESEED, 445)
GO


-- ----------------------------
-- Primary Key structure for table positions
-- ----------------------------
ALTER TABLE [dbo].[positions] ADD CONSTRAINT [PK__position__3213E83FE0898449] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for positions_category
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[positions_category]', RESEED, 26)
GO


-- ----------------------------
-- Primary Key structure for table positions_category
-- ----------------------------
ALTER TABLE [dbo].[positions_category] ADD CONSTRAINT [PK__position__3213E83FC0C199E0] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for positions_classification
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[positions_classification]', RESEED, 4)
GO


-- ----------------------------
-- Primary Key structure for table positions_classification
-- ----------------------------
ALTER TABLE [dbo].[positions_classification] ADD CONSTRAINT [PK__position__3213E83FAE40CF8D] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for requirements
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[requirements]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table requirements
-- ----------------------------
ALTER TABLE [dbo].[requirements] ADD CONSTRAINT [PK__requirem__3213E83FA73D9D9B] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for role
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[role]', RESEED, 9)
GO


-- ----------------------------
-- Primary Key structure for table role
-- ----------------------------
ALTER TABLE [dbo].[role] ADD CONSTRAINT [PK__role__3213E83FEDA779FE] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for role_permission
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[role_permission]', RESEED, 1335)
GO


-- ----------------------------
-- Primary Key structure for table role_permission
-- ----------------------------
ALTER TABLE [dbo].[role_permission] ADD CONSTRAINT [PK__role_per__3213E83F84265588] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for salary
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[salary]', RESEED, 93)
GO


-- ----------------------------
-- Primary Key structure for table salary
-- ----------------------------
ALTER TABLE [dbo].[salary] ADD CONSTRAINT [PK__salary__3213E83FCA10B55F] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for sections
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sections]', RESEED, 26)
GO


-- ----------------------------
-- Primary Key structure for table sections
-- ----------------------------
ALTER TABLE [dbo].[sections] ADD CONSTRAINT [PK__sections__0E31DA7DE1AF38DF] PRIMARY KEY CLUSTERED ([id], [department_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for shift_type
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[shift_type]', RESEED, 48)
GO


-- ----------------------------
-- Primary Key structure for table shift_type
-- ----------------------------
ALTER TABLE [dbo].[shift_type] ADD CONSTRAINT [PK__shift_ty__3213E83FF4D81FFD] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for shifts
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[shifts]', RESEED, 10478)
GO


-- ----------------------------
-- Primary Key structure for table shifts
-- ----------------------------
ALTER TABLE [dbo].[shifts] ADD CONSTRAINT [PK__shifts__3213E83FA1E15211] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for taxonomy
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[taxonomy]', RESEED, 286)
GO


-- ----------------------------
-- Primary Key structure for table taxonomy
-- ----------------------------
ALTER TABLE [dbo].[taxonomy] ADD CONSTRAINT [PK__taxonomy__3213E83F3BF17E30] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for temp_in_out
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[temp_in_out]', RESEED, 20)
GO


-- ----------------------------
-- Primary Key structure for table temp_in_out
-- ----------------------------
ALTER TABLE [dbo].[temp_in_out] ADD CONSTRAINT [PK__temp_in___3213E83F883F1C0D] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tss
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[tss]', RESEED, 3)
GO


-- ----------------------------
-- Primary Key structure for table tss
-- ----------------------------
ALTER TABLE [dbo].[tss] ADD CONSTRAINT [PK__tss__3213E83FF589CBC5] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tss_data
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[tss_data]', RESEED, 32)
GO


-- ----------------------------
-- Primary Key structure for table tss_data
-- ----------------------------
ALTER TABLE [dbo].[tss_data] ADD CONSTRAINT [PK__tss_data__3213E83F0E2B8751] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tss_summary
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[tss_summary]', RESEED, 3)
GO


-- ----------------------------
-- Primary Key structure for table tss_summary
-- ----------------------------
ALTER TABLE [dbo].[tss_summary] ADD CONSTRAINT [PK__tss_summ__3213E83F5969BD42] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for two_factor_authentication
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[two_factor_authentication]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table two_factor_authentication
-- ----------------------------
ALTER TABLE [dbo].[two_factor_authentication] ADD CONSTRAINT [PK__two_fact__3213E83F97288F0E] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for undertime
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[undertime]', RESEED, 5)
GO


-- ----------------------------
-- Primary Key structure for table undertime
-- ----------------------------
ALTER TABLE [dbo].[undertime] ADD CONSTRAINT [PK__undertim__3213E83F910FF3D4] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for user_setting
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[user_setting]', RESEED, 88)
GO


-- ----------------------------
-- Primary Key structure for table user_setting
-- ----------------------------
ALTER TABLE [dbo].[user_setting] ADD CONSTRAINT [PK__user_set__3213E83F20663C5F] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for users
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[users]', RESEED, 203)
GO


-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE [dbo].[users] ADD CONSTRAINT [PK__users__3213E83F317FF2E3] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for users_document
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[users_document]', RESEED, 6)
GO


-- ----------------------------
-- Primary Key structure for table users_document
-- ----------------------------
ALTER TABLE [dbo].[users_document] ADD CONSTRAINT [PK__users_do__3213E83F7FB5B10A] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for work_areas
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[work_areas]', RESEED, 5)
GO


-- ----------------------------
-- Primary Key structure for table work_areas
-- ----------------------------
ALTER TABLE [dbo].[work_areas] ADD CONSTRAINT [PK__work_are__3213E83F11207DB0] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for work_schedule
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[work_schedule]', RESEED, 1087)
GO


-- ----------------------------
-- Primary Key structure for table work_schedule
-- ----------------------------
ALTER TABLE [dbo].[work_schedule] ADD CONSTRAINT [PK__work_sch__3213E83FD853A6FE] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

