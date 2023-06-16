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

 Date: 28/09/2021 01:06:43
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
-- Records of adjustment
-- ----------------------------
SET IDENTITY_INSERT [dbo].[adjustment] ON
GO

SET IDENTITY_INSERT [dbo].[adjustment] OFF
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
-- Records of announcement
-- ----------------------------
SET IDENTITY_INSERT [dbo].[announcement] ON
GO

INSERT INTO [dbo].[announcement] ([id], [subject], [short_description], [description], [slug], [created_by], [created_at], [updated_at]) VALUES (N'1', N'Welcome', N'Welcome to the new Human Resource Information System!', N'<p>Have a nice day!</p>', N'welcome', N'1', N'2019-10-01 11:14:30.000', N'2021-06-01 22:32:47.000')
GO

SET IDENTITY_INSERT [dbo].[announcement] OFF
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
-- Records of approvers
-- ----------------------------
SET IDENTITY_INSERT [dbo].[approvers] ON
GO

INSERT INTO [dbo].[approvers] ([id], [company_location_id], [department_id], [primary_approver_id], [backup_approver_id], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'1', N'1', N'8', N'18', N'18', N'2019-11-05 11:54:48.000', N'2019-11-20 17:02:04.000', NULL, N'3')
GO

INSERT INTO [dbo].[approvers] ([id], [company_location_id], [department_id], [primary_approver_id], [backup_approver_id], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'2', N'1', N'9', N'18', N'18', N'2019-11-05 11:54:48.000', N'2019-11-20 17:02:52.000', NULL, N'3')
GO

INSERT INTO [dbo].[approvers] ([id], [company_location_id], [department_id], [primary_approver_id], [backup_approver_id], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'25', N'1', N'10', NULL, NULL, N'2021-06-01 23:05:20.000', N'2021-06-01 23:05:20.000', NULL, N'0')
GO

SET IDENTITY_INSERT [dbo].[approvers] OFF
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
-- Records of biometric_csv
-- ----------------------------
SET IDENTITY_INSERT [dbo].[biometric_csv] ON
GO

INSERT INTO [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (N'1002', N'1', N'20210823204011.csv', N'2021-08-23')
GO

INSERT INTO [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (N'1003', N'1', N'20210823234544.csv', N'2021-08-23')
GO

INSERT INTO [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (N'1004', N'1', N'20210824134121.csv', N'2021-08-24')
GO

INSERT INTO [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (N'1005', N'1', N'20210914145023.csv', N'2021-09-14')
GO

INSERT INTO [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (N'1006', N'1', N'20210914145134.csv', N'2021-09-14')
GO

INSERT INTO [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (N'1007', N'1', N'20210920142757.csv', N'2021-09-20')
GO

SET IDENTITY_INSERT [dbo].[biometric_csv] OFF
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
-- Records of biometric_logs
-- ----------------------------
SET IDENTITY_INSERT [dbo].[biometric_logs] ON
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'181', N'1', N'1', N'2021-07-14 19:56:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'182', N'1', N'1', N'2021-07-14 19:57:00.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'183', N'1', N'1', N'2021-07-14 19:57:12.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'184', N'1', N'1', N'2021-07-14 19:58:20.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'185', N'1', N'1', N'2021-07-14 19:59:40.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'186', N'1', N'1', N'2021-07-14 20:02:08.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'187', N'1', N'1', N'2021-07-14 20:02:11.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'188', N'1', N'1', N'2021-07-14 20:19:47.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'189', N'1', N'1', N'2021-07-14 20:20:01.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'190', N'1', N'1', N'2021-07-14 20:20:20.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'191', N'1', N'1', N'2021-07-14 20:30:30.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'192', N'1', N'1', N'2021-07-14 20:30:38.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'193', N'1', N'1', N'2021-07-14 20:31:38.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'194', N'1', N'1', N'2021-07-14 20:32:55.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'195', N'1', N'1', N'2021-07-14 20:34:22.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'196', N'1', N'1', N'2021-07-14 20:37:58.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'197', N'1', N'1', N'2021-07-14 20:38:02.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'198', N'1', N'1', N'2021-07-14 20:38:08.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'199', N'1', N'1', N'2021-07-14 20:42:15.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'200', N'1', N'1', N'2021-07-14 20:57:33.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'201', N'1', N'1', N'2021-07-14 21:50:26.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'202', N'1', N'1', N'2021-07-16 11:13:36.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'203', N'1', N'1', N'2021-07-16 18:54:50.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'204', N'1', N'1', N'2021-07-19 08:29:59.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'205', N'1', N'1', N'2021-07-19 08:58:50.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'206', N'1', N'1', N'2021-07-19 14:43:23.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'207', N'1', N'1', N'2021-07-19 14:43:37.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'208', N'1', N'1', N'2021-07-19 14:43:48.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'209', N'1', N'1', N'2021-07-19 14:43:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'210', N'1', N'1', N'2021-07-19 14:45:41.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'211', N'1', N'1', N'2021-07-19 14:45:44.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'212', N'1', N'1', N'2021-07-19 14:45:47.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'213', N'1', N'1', N'2021-07-19 14:45:50.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'214', N'1', N'1', N'2021-07-19 14:45:52.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'215', N'1', N'1', N'2021-07-19 14:45:55.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'216', N'1', N'1', N'2021-07-19 14:46:28.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'217', N'1', N'1', N'2021-07-19 14:46:38.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'218', N'1', N'1', N'2021-07-19 14:46:41.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'219', N'1', N'1', N'2021-07-19 14:46:44.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'220', N'1', N'1', N'2021-07-19 14:46:48.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'221', N'1', N'1', N'2021-07-19 14:47:01.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'222', N'1', N'1', N'2021-07-19 14:47:04.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'223', N'1', N'1', N'2021-07-19 14:47:32.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'224', N'1', N'1', N'2021-07-19 14:47:35.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'225', N'1', N'1', N'2021-07-19 14:47:38.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'226', N'1', N'1', N'2021-07-19 14:47:41.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'227', N'1', N'1', N'2021-07-19 14:47:43.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'228', N'1', N'1', N'2021-07-19 14:48:16.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'229', N'1', N'1', N'2021-07-19 14:48:20.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'230', N'1', N'1', N'2021-07-19 14:49:30.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'231', N'1', N'1', N'2021-07-19 14:54:04.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'232', N'1', N'1', N'2021-07-19 14:54:07.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'233', N'1', N'1', N'2021-07-19 14:55:17.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'234', N'1', N'1', N'2021-07-19 14:55:40.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'235', N'1', N'1', N'2021-07-19 14:58:55.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'236', N'1', N'1', N'2021-07-19 14:58:58.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'237', N'1', N'1', N'2021-07-19 14:59:00.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'238', N'1', N'1', N'2021-07-19 14:59:03.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'239', N'1', N'1', N'2021-07-19 14:59:06.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'240', N'1', N'1', N'2021-07-19 14:59:09.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'241', N'2', N'1', N'2021-07-19 15:00:47.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'242', N'2', N'1', N'2021-07-19 15:00:50.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'243', N'2', N'1', N'2021-07-19 15:00:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'244', N'2', N'1', N'2021-07-19 15:00:55.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'245', N'1', N'1', N'2021-07-19 15:00:59.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'246', N'2', N'1', N'2021-07-19 15:01:01.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'247', N'2', N'1', N'2021-07-19 15:01:48.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'248', N'1', N'1', N'2021-07-19 15:01:51.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'249', N'1', N'1', N'2021-07-19 15:01:53.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'250', N'2', N'1', N'2021-07-19 15:01:56.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'251', N'2', N'1', N'2021-07-19 15:01:58.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'252', N'2', N'1', N'2021-07-19 15:02:01.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'253', N'2', N'1', N'2021-07-19 15:02:03.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'254', N'2', N'1', N'2021-07-19 15:02:05.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'255', N'2', N'1', N'2021-07-19 15:02:07.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'256', N'2', N'1', N'2021-07-19 15:02:09.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'257', N'1', N'1', N'2021-07-19 15:02:12.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'258', N'1', N'1', N'2021-07-19 15:02:15.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'259', N'1', N'1', N'2021-07-19 15:02:17.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'260', N'2', N'1', N'2021-07-19 15:02:19.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'261', N'2', N'1', N'2021-07-19 15:02:21.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'262', N'1', N'1', N'2021-07-19 15:02:38.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'263', N'2', N'1', N'2021-07-19 15:02:41.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'264', N'2', N'1', N'2021-07-19 15:02:44.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'265', N'2', N'1', N'2021-07-19 15:02:47.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'266', N'2', N'1', N'2021-07-19 15:02:49.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'267', N'2', N'1', N'2021-07-19 15:02:52.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'268', N'2', N'1', N'2021-07-19 15:02:54.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'269', N'2', N'1', N'2021-07-19 15:02:56.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'270', N'2', N'1', N'2021-07-19 15:02:58.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'271', N'2', N'1', N'2021-07-19 15:03:01.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'272', N'2', N'1', N'2021-07-19 15:03:03.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'273', N'2', N'1', N'2021-07-19 15:03:06.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'274', N'2', N'1', N'2021-07-19 15:03:08.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'275', N'2', N'1', N'2021-07-19 15:03:10.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'276', N'2', N'1', N'2021-07-19 15:03:12.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'277', N'2', N'1', N'2021-07-19 15:03:14.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'278', N'2', N'1', N'2021-07-19 15:03:17.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'279', N'2', N'1', N'2021-07-19 15:03:19.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'280', N'2', N'1', N'2021-07-19 15:03:21.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'281', N'2', N'1', N'2021-07-19 15:03:24.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'282', N'2', N'1', N'2021-07-19 15:03:26.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'283', N'2', N'1', N'2021-07-19 15:03:28.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'284', N'2', N'1', N'2021-07-19 15:03:31.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'285', N'2', N'1', N'2021-07-19 15:03:33.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'286', N'2', N'1', N'2021-07-19 15:03:35.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'287', N'2', N'1', N'2021-07-19 15:03:37.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'288', N'1', N'1', N'2021-07-19 15:03:40.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'289', N'1', N'1', N'2021-07-19 15:03:42.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'290', N'1', N'1', N'2021-07-19 15:03:44.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'291', N'1', N'1', N'2021-07-19 15:03:47.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'292', N'1', N'1', N'2021-07-19 15:03:50.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'293', N'1', N'1', N'2021-07-19 15:03:52.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'294', N'1', N'1', N'2021-07-19 15:03:55.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'295', N'1', N'1', N'2021-07-19 15:03:57.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'296', N'1', N'1', N'2021-07-19 15:04:00.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'297', N'1', N'1', N'2021-07-19 15:04:08.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'298', N'1', N'1', N'2021-07-19 15:04:10.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'299', N'1', N'1', N'2021-07-19 15:04:12.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'300', N'1', N'1', N'2021-07-19 15:04:16.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'301', N'1', N'1', N'2021-07-19 15:04:18.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'302', N'1', N'1', N'2021-07-19 15:04:21.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'303', N'1', N'1', N'2021-07-19 15:04:23.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'304', N'1', N'1', N'2021-07-19 15:04:26.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'305', N'1', N'1', N'2021-07-19 15:04:28.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'306', N'1', N'1', N'2021-07-19 15:04:30.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'307', N'1', N'1', N'2021-07-19 15:04:33.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'308', N'3', N'1', N'2021-07-19 15:06:50.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'309', N'3', N'1', N'2021-07-19 15:06:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'310', N'3', N'1', N'2021-07-19 15:06:56.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'311', N'3', N'1', N'2021-07-19 15:06:59.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'312', N'3', N'1', N'2021-07-19 15:07:07.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'313', N'3', N'1', N'2021-07-19 15:07:10.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'314', N'1', N'1', N'2021-07-19 15:07:13.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'315', N'2', N'1', N'2021-07-19 15:07:17.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'316', N'3', N'1', N'2021-07-19 15:07:42.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'317', N'3', N'1', N'2021-07-19 15:07:48.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'318', N'1', N'1', N'2021-07-19 15:07:50.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'319', N'1', N'1', N'2021-07-19 15:07:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'320', N'1', N'1', N'2021-07-19 15:07:58.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'321', N'2', N'1', N'2021-07-19 15:08:03.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'322', N'2', N'1', N'2021-07-19 15:08:06.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'323', N'2', N'1', N'2021-07-19 15:08:08.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'324', N'2', N'1', N'2021-07-19 15:08:10.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'325', N'3', N'1', N'2021-07-19 15:08:14.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'326', N'3', N'1', N'2021-07-19 15:08:23.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'327', N'1', N'1', N'2021-07-21 11:26:44.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'328', N'1', N'15', N'2021-07-21 11:26:51.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'329', N'2', N'1', N'2021-07-21 11:26:55.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'330', N'1', N'15', N'2021-07-21 11:27:01.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'331', N'1', N'1', N'2021-07-21 11:35:11.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'332', N'1', N'1', N'2021-07-21 11:36:36.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'333', N'1', N'1', N'2021-07-21 11:36:42.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'334', N'1', N'1', N'2021-07-21 11:36:46.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'335', N'3', N'1', N'2021-07-21 11:36:50.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'336', N'3', N'1', N'2021-07-21 11:36:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'337', N'1', N'1', N'2021-07-21 18:45:45.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'338', N'1', N'15', N'2021-07-21 19:39:36.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'339', N'1', N'15', N'2021-07-21 19:39:42.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'340', N'2', N'1', N'2021-07-22 02:41:45.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'341', N'1', N'1', N'2021-07-27 22:48:41.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'342', N'1', N'1', N'2021-07-28 12:13:59.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'343', N'1', N'1', N'2021-07-29 01:23:53.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'344', N'1', N'1', N'2021-07-29 10:23:26.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'345', N'1', N'1', N'2021-07-29 11:20:40.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'346', N'1', N'1', N'2021-07-30 16:03:08.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'347', N'1', N'1', N'2021-08-02 18:35:41.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'348', N'1', N'1', N'2021-08-03 10:39:26.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'382', N'1', N'1', N'2019-06-21 08:57:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'383', N'1', N'1', N'2019-06-21 08:57:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'384', N'1', N'1', N'2019-06-21 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'385', N'1', N'1', N'2019-06-21 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'386', N'1', N'1', N'2019-06-21 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'387', N'1', N'1', N'2019-06-22 08:58:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'388', N'1', N'1', N'2019-06-22 08:58:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'389', N'1', N'1', N'2019-06-22 18:00:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'390', N'1', N'1', N'2019-06-22 18:00:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'391', N'1', N'1', N'2019-06-22 18:02:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'392', N'1', N'1', N'2019-06-23 09:07:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'393', N'1', N'1', N'2019-06-23 09:07:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'394', N'1', N'1', N'2019-06-23 18:03:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'395', N'1', N'1', N'2019-06-23 18:03:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'396', N'1', N'1', N'2019-06-24 09:14:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'397', N'1', N'1', N'2019-06-24 19:10:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'398', N'1', N'1', N'2019-06-24 19:10:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'399', N'1', N'1', N'2019-06-25 08:42:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'400', N'1', N'1', N'2019-06-25 08:42:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'401', N'1', N'1', N'2019-06-25 19:26:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'402', N'1', N'1', N'2019-06-25 19:26:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'403', N'1', N'1', N'2019-06-28 08:41:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'404', N'1', N'1', N'2019-06-28 08:41:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'405', N'1', N'1', N'2019-06-28 18:09:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'406', N'1', N'1', N'2019-06-28 18:09:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'407', N'1', N'1', N'2019-07-02 08:31:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'408', N'1', N'1', N'2019-07-02 08:31:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'409', N'1', N'1', N'2019-07-02 18:15:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'410', N'1', N'1', N'2019-07-02 18:15:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'411', N'1', N'1', N'2019-07-05 09:34:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'412', N'1', N'1', N'2019-07-05 09:34:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'413', N'1', N'1', N'2019-07-06 09:07:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'414', N'1', N'1', N'2019-07-06 09:07:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'415', N'1', N'1', N'2021-08-03 17:08:08.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'416', N'1', N'1', N'2021-08-04 19:33:33.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'417', N'1', N'1', N'2021-08-05 11:30:33.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'418', N'1', N'1', N'2021-08-05 17:55:58.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'419', N'1', N'1', N'2021-08-06 11:22:34.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'420', N'1', N'1', N'2021-08-10 10:04:06.000', N'0', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'421', N'1', N'1', N'2021-08-10 19:32:41.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10181', N'1', N'1', N'2021-08-11 20:38:01.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10182', N'1', N'1', N'2021-08-17 18:30:39.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10183', N'1', N'1', N'2021-08-18 18:07:31.000', N'1', N'192.168.0.101', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10184', N'1', N'1', N'2021-08-19 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10185', N'1', N'1', N'2021-08-19 07:57:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10186', N'1', N'1', N'2021-08-20 07:58:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10187', N'1', N'1', N'2021-08-20 18:00:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10188', N'1', N'1', N'2021-09-08 07:57:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10189', N'1', N'1', N'2021-09-08 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10190', N'1', N'1', N'2021-09-09 07:57:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10191', N'1', N'1', N'2021-09-09 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10192', N'1', N'1', N'2021-09-10 07:57:00.000', N'0', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10193', N'1', N'1', N'2021-09-10 20:58:00.000', N'1', N'192.168.0.101', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10194', N'1', N'1', N'2021-07-14 19:56:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10195', N'1', N'1', N'2021-07-14 19:57:00.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10196', N'1', N'1', N'2021-07-14 19:57:12.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10197', N'1', N'1', N'2021-07-14 19:58:20.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10198', N'1', N'1', N'2021-07-14 19:59:40.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10199', N'1', N'1', N'2021-07-14 20:02:08.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10200', N'1', N'1', N'2021-07-14 20:19:47.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10201', N'1', N'1', N'2021-07-14 20:02:11.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10202', N'1', N'1', N'2021-07-14 20:20:01.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10203', N'1', N'1', N'2021-07-14 20:20:20.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10204', N'1', N'1', N'2021-07-14 20:30:30.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10205', N'1', N'1', N'2021-07-14 20:30:38.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10206', N'1', N'1', N'2021-07-14 20:31:38.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10207', N'1', N'1', N'2021-07-14 20:32:55.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10208', N'1', N'1', N'2021-07-14 20:34:22.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10209', N'1', N'1', N'2021-07-14 20:37:58.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10210', N'1', N'1', N'2021-07-14 20:38:02.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10211', N'1', N'1', N'2021-07-14 20:38:08.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10212', N'1', N'1', N'2021-07-14 20:42:15.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10213', N'1', N'1', N'2021-07-14 20:57:33.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10214', N'1', N'1', N'2021-07-14 21:50:26.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10215', N'1', N'1', N'2021-07-16 11:13:36.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10216', N'1', N'1', N'2021-07-16 18:54:50.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10217', N'1', N'1', N'2021-07-19 08:29:59.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10218', N'1', N'1', N'2021-07-19 08:58:50.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10219', N'1', N'1', N'2021-07-19 14:43:23.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10220', N'1', N'1', N'2021-07-19 14:43:37.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10221', N'1', N'1', N'2021-07-19 14:43:48.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10222', N'1', N'1', N'2021-07-19 14:43:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10223', N'1', N'1', N'2021-07-19 14:45:41.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10224', N'1', N'1', N'2021-07-19 14:45:44.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10225', N'1', N'1', N'2021-07-19 14:45:47.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10226', N'1', N'1', N'2021-07-19 14:45:50.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10227', N'1', N'1', N'2021-07-19 14:45:52.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10228', N'1', N'1', N'2021-07-19 14:45:55.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10229', N'1', N'1', N'2021-07-19 14:46:28.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10230', N'1', N'1', N'2021-07-19 14:46:38.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10231', N'1', N'1', N'2021-07-19 14:46:41.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10232', N'1', N'1', N'2021-07-19 14:46:44.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10233', N'1', N'1', N'2021-07-19 14:46:48.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10234', N'1', N'1', N'2021-07-19 14:47:01.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10235', N'1', N'1', N'2021-07-19 14:47:04.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10236', N'1', N'1', N'2021-07-19 14:47:32.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10237', N'1', N'1', N'2021-07-19 14:47:35.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10238', N'1', N'1', N'2021-07-19 14:47:38.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10239', N'1', N'1', N'2021-07-19 14:47:41.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10240', N'1', N'1', N'2021-07-19 14:47:43.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10241', N'1', N'1', N'2021-07-19 14:48:16.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10242', N'1', N'1', N'2021-07-19 14:48:20.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10243', N'1', N'1', N'2021-07-19 14:49:30.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10244', N'1', N'1', N'2021-07-19 14:54:04.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10245', N'1', N'1', N'2021-07-19 14:54:07.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10246', N'1', N'1', N'2021-07-19 14:55:17.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10247', N'1', N'1', N'2021-07-19 14:55:40.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10248', N'1', N'1', N'2021-07-19 14:58:55.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10249', N'1', N'1', N'2021-07-19 14:58:58.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10250', N'1', N'1', N'2021-07-19 14:59:00.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10251', N'1', N'1', N'2021-07-19 14:59:03.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10252', N'1', N'1', N'2021-07-19 14:59:06.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10253', N'1', N'1', N'2021-07-19 14:59:09.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10254', N'2', N'1', N'2021-07-19 15:00:47.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10255', N'2', N'1', N'2021-07-19 15:00:50.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10256', N'2', N'1', N'2021-07-19 15:00:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10257', N'2', N'1', N'2021-07-19 15:00:55.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10258', N'1', N'1', N'2021-07-19 15:00:59.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10259', N'2', N'1', N'2021-07-19 15:01:01.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10260', N'2', N'1', N'2021-07-19 15:01:48.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10261', N'1', N'1', N'2021-07-19 15:01:51.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10262', N'1', N'1', N'2021-07-19 15:01:53.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10263', N'2', N'1', N'2021-07-19 15:01:56.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10264', N'2', N'1', N'2021-07-19 15:01:58.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10265', N'2', N'1', N'2021-07-19 15:02:01.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10266', N'2', N'1', N'2021-07-19 15:02:03.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10267', N'2', N'1', N'2021-07-19 15:02:05.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10268', N'2', N'1', N'2021-07-19 15:02:07.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10269', N'2', N'1', N'2021-07-19 15:02:09.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10270', N'1', N'1', N'2021-07-19 15:02:12.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10271', N'1', N'1', N'2021-07-19 15:02:15.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10272', N'1', N'1', N'2021-07-19 15:02:17.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10273', N'2', N'1', N'2021-07-19 15:02:19.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10274', N'2', N'1', N'2021-07-19 15:02:21.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10275', N'1', N'1', N'2021-07-19 15:02:38.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10276', N'2', N'1', N'2021-07-19 15:02:41.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10277', N'2', N'1', N'2021-07-19 15:02:44.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10278', N'2', N'1', N'2021-07-19 15:02:47.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10279', N'2', N'1', N'2021-07-19 15:02:49.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10280', N'2', N'1', N'2021-07-19 15:02:52.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10281', N'2', N'1', N'2021-07-19 15:02:54.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10282', N'2', N'1', N'2021-07-19 15:02:56.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10283', N'2', N'1', N'2021-07-19 15:02:58.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10284', N'2', N'1', N'2021-07-19 15:03:01.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10285', N'2', N'1', N'2021-07-19 15:03:03.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10286', N'2', N'1', N'2021-07-19 15:03:06.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10287', N'2', N'1', N'2021-07-19 15:03:08.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10288', N'2', N'1', N'2021-07-19 15:03:10.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10289', N'2', N'1', N'2021-07-19 15:03:12.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10290', N'2', N'1', N'2021-07-19 15:03:14.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10291', N'2', N'1', N'2021-07-19 15:03:17.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10292', N'2', N'1', N'2021-07-19 15:03:19.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10293', N'2', N'1', N'2021-07-19 15:03:21.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10294', N'2', N'1', N'2021-07-19 15:03:24.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10295', N'2', N'1', N'2021-07-19 15:03:26.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10296', N'2', N'1', N'2021-07-19 15:03:28.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10297', N'2', N'1', N'2021-07-19 15:03:31.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10298', N'2', N'1', N'2021-07-19 15:03:33.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10299', N'2', N'1', N'2021-07-19 15:03:35.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10300', N'2', N'1', N'2021-07-19 15:03:37.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10301', N'1', N'1', N'2021-07-19 15:03:40.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10302', N'1', N'1', N'2021-07-19 15:03:42.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10303', N'1', N'1', N'2021-07-19 15:03:44.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10304', N'1', N'1', N'2021-07-19 15:03:47.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10305', N'1', N'1', N'2021-07-19 15:03:50.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10306', N'1', N'1', N'2021-07-19 15:03:52.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10307', N'1', N'1', N'2021-07-19 15:03:55.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10308', N'1', N'1', N'2021-07-19 15:03:57.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10309', N'1', N'1', N'2021-07-19 15:04:00.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10310', N'1', N'1', N'2021-07-19 15:04:08.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10311', N'1', N'1', N'2021-07-19 15:04:10.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10312', N'1', N'1', N'2021-07-19 15:04:12.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10313', N'1', N'1', N'2021-07-19 15:04:16.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10314', N'1', N'1', N'2021-07-19 15:04:18.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10315', N'1', N'1', N'2021-07-19 15:04:21.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10316', N'1', N'1', N'2021-07-19 15:04:23.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10317', N'1', N'1', N'2021-07-19 15:04:26.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10318', N'1', N'1', N'2021-07-19 15:04:28.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10319', N'1', N'1', N'2021-07-19 15:04:30.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10320', N'1', N'1', N'2021-07-19 15:04:33.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10321', N'3', N'1', N'2021-07-19 15:06:50.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10322', N'3', N'1', N'2021-07-19 15:06:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10323', N'3', N'1', N'2021-07-19 15:06:56.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10324', N'3', N'1', N'2021-07-19 15:06:59.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10325', N'3', N'1', N'2021-07-19 15:07:07.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10326', N'3', N'1', N'2021-07-19 15:07:10.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10327', N'1', N'1', N'2021-07-19 15:07:13.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10328', N'2', N'1', N'2021-07-19 15:07:17.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10329', N'3', N'1', N'2021-07-19 15:07:42.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10330', N'3', N'1', N'2021-07-19 15:07:48.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10331', N'1', N'1', N'2021-07-19 15:07:50.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10332', N'1', N'1', N'2021-07-19 15:07:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10333', N'1', N'1', N'2021-07-19 15:07:58.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10334', N'2', N'1', N'2021-07-19 15:08:03.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10335', N'2', N'1', N'2021-07-19 15:08:06.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10336', N'2', N'1', N'2021-07-19 15:08:08.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10337', N'2', N'1', N'2021-07-19 15:08:10.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10338', N'3', N'1', N'2021-07-19 15:08:14.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10339', N'3', N'1', N'2021-07-19 15:08:23.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10340', N'1', N'1', N'2021-07-21 11:26:44.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10341', N'1', N'15', N'2021-07-21 11:26:51.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10342', N'2', N'1', N'2021-07-21 11:26:55.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10343', N'1', N'15', N'2021-07-21 11:27:01.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10344', N'1', N'1', N'2021-07-21 11:35:11.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10345', N'1', N'1', N'2021-07-21 11:36:36.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10346', N'1', N'1', N'2021-07-21 11:36:42.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10347', N'1', N'1', N'2021-07-21 11:36:46.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10348', N'3', N'1', N'2021-07-21 11:36:50.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10349', N'3', N'1', N'2021-07-21 11:36:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10350', N'1', N'1', N'2021-07-21 18:45:45.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10351', N'1', N'15', N'2021-07-21 19:39:36.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10352', N'1', N'15', N'2021-07-21 19:39:42.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10353', N'2', N'1', N'2021-07-22 02:41:45.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10354', N'1', N'1', N'2021-07-27 22:48:41.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10355', N'1', N'1', N'2021-07-28 12:13:59.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10356', N'1', N'1', N'2021-07-29 01:23:53.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10357', N'1', N'1', N'2021-07-29 10:23:26.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10358', N'1', N'1', N'2021-07-29 11:20:40.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10359', N'1', N'1', N'2021-07-30 16:03:08.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10360', N'1', N'1', N'2021-08-02 18:35:41.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10361', N'1', N'1', N'2021-08-03 10:39:26.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10362', N'1', N'1', N'2021-08-03 17:08:08.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10363', N'1', N'1', N'2021-08-04 19:33:33.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10364', N'1', N'1', N'2021-08-05 11:30:33.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10365', N'1', N'1', N'2021-08-05 17:55:58.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10366', N'1', N'1', N'2021-08-06 11:22:34.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10367', N'1', N'1', N'2021-08-10 10:04:06.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10368', N'1', N'1', N'2021-08-10 19:32:41.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10369', N'1', N'1', N'2021-08-11 20:38:01.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10370', N'1', N'1', N'2021-08-17 18:30:39.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10371', N'1', N'1', N'2021-08-18 18:07:31.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10372', N'1', N'1', N'2021-09-20 10:41:28.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10373', N'1', N'1', N'2021-09-20 13:41:03.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10374', N'1', N'1', N'2021-09-11 07:57:00.000', N'0', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10375', N'1', N'1', N'2021-09-11 12:05:00.000', N'1', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10376', N'1', N'1', N'2021-09-13 17:15:00.000', N'1', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10377', N'1', N'1', N'2021-09-13 07:45:00.000', N'0', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10378', N'1', N'1', N'2021-09-14 08:05:00.000', N'0', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10379', N'1', N'1', N'2021-09-14 17:07:00.000', N'1', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10380', N'1', N'1', N'2021-09-15 17:05:00.000', N'1', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10381', N'1', N'1', N'2021-09-15 07:56:00.000', N'0', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10382', N'1', N'1', N'2021-09-16 07:58:00.000', N'0', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10383', N'1', N'1', N'2021-09-16 17:11:00.000', N'1', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10384', N'1', N'1', N'2021-09-17 08:06:00.000', N'0', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10385', N'1', N'1', N'2021-09-17 17:06:00.000', N'1', N'192.168.0.105', N'csv')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10386', N'1', N'1', N'2021-09-21 09:45:49.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10390', N'1', N'1', N'2021-09-27 21:07:06.000', N'0', NULL, NULL)
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10392', N'1', N'1', N'2021-09-27 23:07:49.000', N'1', NULL, NULL)
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10394', N'1', N'1', N'2021-09-23 23:09:08.000', N'1', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10395', N'1', N'1', N'2021-09-26 07:10:05.000', N'0', N'192.168.0.105', N'biometric')
GO

INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'10401', N'1', N'1', N'2021-09-26 17:10:46.000', N'1', N'192.168.0.105', N'biometric')
GO

SET IDENTITY_INSERT [dbo].[biometric_logs] OFF
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
-- Records of biometric_number
-- ----------------------------
SET IDENTITY_INSERT [dbo].[biometric_number] ON
GO

INSERT INTO [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (N'1', N'1', N'1', N'1', N'2021-07-27 23:17:19.000', NULL)
GO

INSERT INTO [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (N'2', N'2', N'1', N'3', N'2021-07-27 23:21:03.860', NULL)
GO

INSERT INTO [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (N'1002', N'123', N'1', N'88', N'2021-09-14 14:13:00.913', N'2021-09-14 14:13:00.913')
GO

INSERT INTO [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (N'1003', N'123', N'3', N'88', N'2021-09-14 14:13:59.690', N'2021-09-14 14:13:59.690')
GO

SET IDENTITY_INSERT [dbo].[biometric_number] OFF
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
-- Records of biometrics
-- ----------------------------
SET IDENTITY_INSERT [dbo].[biometrics] ON
GO

INSERT INTO [dbo].[biometrics] ([id], [site], [status], [created_at], [updated_at], [label]) VALUES (N'1', N'192.168.0.105', N'1', N'2021-05-17 13:14:12.000', N'2021-05-17 13:14:12.000', N'Davao')
GO

INSERT INTO [dbo].[biometrics] ([id], [site], [status], [created_at], [updated_at], [label]) VALUES (N'3', N'192.168.0.102', N'1', N'2021-07-29 11:38:57.850', NULL, N'Makati')
GO

INSERT INTO [dbo].[biometrics] ([id], [site], [status], [created_at], [updated_at], [label]) VALUES (N'4', N'192.168.0.153', N'1', N'2021-09-14 17:42:54.310', N'2021-09-14 17:42:54.310', N'Cagayan')
GO

SET IDENTITY_INSERT [dbo].[biometrics] OFF
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
-- Records of branches
-- ----------------------------
SET IDENTITY_INSERT [dbo].[branches] ON
GO

INSERT INTO [dbo].[branches] ([id], [location_id], [address], [country_id], [company_id], [description], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1', N'1', N'Ayala Avenue', N'177', N'1', NULL, N'1', NULL, NULL, N'2019-03-24 07:09:18.000', N'2019-09-26 03:05:50.000')
GO

SET IDENTITY_INSERT [dbo].[branches] OFF
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
-- Records of branding
-- ----------------------------
SET IDENTITY_INSERT [dbo].[branding] ON
GO

INSERT INTO [dbo].[branding] ([id], [name], [logo], [branding]) VALUES (N'4', N'HRIS', N'0e616b2a-d591-4052-a0dc-4f45bfa9ff0f.png', N'3')
GO

SET IDENTITY_INSERT [dbo].[branding] OFF
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
-- Records of business_trip
-- ----------------------------
SET IDENTITY_INSERT [dbo].[business_trip] ON
GO

INSERT INTO [dbo].[business_trip] ([id], [user_id], [date_start], [date_end], [title], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [approved_by], [_token], [created_at], [updated_at]) VALUES (N'1', N'1', N'2019-10-08', N'2019-10-09', NULL, N'Trips', N'2', N'2', N'1', N'1', NULL, NULL, N'', N'2019-10-03 18:03:02.000', N'2019-10-08 11:42:15.000')
GO

INSERT INTO [dbo].[business_trip] ([id], [user_id], [date_start], [date_end], [title], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [approved_by], [_token], [created_at], [updated_at]) VALUES (N'2', N'2', N'2019-10-15', N'2019-10-16', NULL, N'Go to Cebu project', N'2', N'2', N'1', N'1', NULL, NULL, N'', N'2019-10-08 10:59:27.000', N'2019-10-08 11:42:15.000')
GO

INSERT INTO [dbo].[business_trip] ([id], [user_id], [date_start], [date_end], [title], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [approved_by], [_token], [created_at], [updated_at]) VALUES (N'3', N'1', N'2021-03-10', N'2021-03-12', NULL, N'Test', N'2', N'2', N'1', N'1', NULL, NULL, N'', N'2021-03-01 12:39:12.000', N'2021-03-01 12:39:26.000')
GO

SET IDENTITY_INSERT [dbo].[business_trip] OFF
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
-- Records of candidate_profile
-- ----------------------------
SET IDENTITY_INSERT [dbo].[candidate_profile] ON
GO

SET IDENTITY_INSERT [dbo].[candidate_profile] OFF
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
-- Records of companies
-- ----------------------------
SET IDENTITY_INSERT [dbo].[companies] ON
GO

INSERT INTO [dbo].[companies] ([id], [name], [code], [logo], [description], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1', N'Philsaga Mining Corporation', N'PMC', N'4dbf5dc4-b83f-46b1-ba9e-55bb5979aa5c.png', N'', N'1', N'1', NULL, N'2019-03-23 01:47:46.000', N'2021-06-01 23:05:14.000')
GO

SET IDENTITY_INSERT [dbo].[companies] OFF
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
-- Records of configuration
-- ----------------------------
SET IDENTITY_INSERT [dbo].[configuration] ON
GO

INSERT INTO [dbo].[configuration] ([id], [json], [created_at], [updated_at]) VALUES (N'1', N'{"server":{"timezone":"undefined"},"shift":{"grace_period":"10"},"overtime":{"overtime_regular":"undefined","overtime_restday":"undefined","overtime_regular_holiday":"undefined","overtime_restday_special_holiday":"undefined","overtime_restday_regular_holiday":"undefined"},"smtp":{"smtp_host":"undefined","smtp_port":"undefined","smtp_username":"undefined","smtp_password":"undefined","smtp_service":"undefined"},"cutoff":{"A_from":"21","A_to":"5","A_day":"15","B_from":"6","B_to":"20","B_day":"30"},"contribution":{"sss":"A","philhealth":"B","pagibig":"B"},"manual_log":"no","policy":{"nolog":"1"}}', N'2019-07-13 04:29:31.000', N'2019-09-20 03:45:32.000')
GO

SET IDENTITY_INSERT [dbo].[configuration] OFF
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
-- Records of countries
-- ----------------------------
SET IDENTITY_INSERT [dbo].[countries] ON
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'1', N'ABW', N'Aruba', N'AW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'2', N'AFG', N'Afghanistan', N'AF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'3', N'AGO', N'Angola', N'AO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'4', N'AIA', N'Anguilla', N'AI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'5', N'ALA', N'Åland', N'AX')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'6', N'ALB', N'Albania', N'AL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'7', N'AND', N'Andorra', N'AD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'8', N'ARE', N'United Arab Emirates', N'AE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'9', N'ARG', N'Argentina', N'AR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'10', N'ARM', N'Armenia', N'AM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'11', N'ASM', N'American Samoa', N'AS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'12', N'ATA', N'Antarctica', N'AQ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'13', N'ATF', N'French Southern Territories', N'TF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'14', N'ATG', N'Antigua and Barbuda', N'AG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'15', N'AUS', N'Australia', N'AU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'16', N'AUT', N'Austria', N'AT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'17', N'AZE', N'Azerbaijan', N'AZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'18', N'BDI', N'Burundi', N'BI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'19', N'BEL', N'Belgium', N'BE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'20', N'BEN', N'Benin', N'BJ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'21', N'BES', N'Bonaire', N'BQ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'22', N'BFA', N'Burkina Faso', N'BF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'23', N'BGD', N'Bangladesh', N'BD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'24', N'BGR', N'Bulgaria', N'BG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'25', N'BHR', N'Bahrain', N'BH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'26', N'BHS', N'Bahamas', N'BS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'27', N'BIH', N'Bosnia and Herzegovina', N'BA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'28', N'BLM', N'Saint Barthélemy', N'BL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'29', N'BLR', N'Belarus', N'BY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'30', N'BLZ', N'Belize', N'BZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'31', N'BMU', N'Bermuda', N'BM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'32', N'BOL', N'Bolivia', N'BO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'33', N'BRA', N'Brazil', N'BR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'34', N'BRB', N'Barbados', N'BB')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'35', N'BRN', N'Brunei', N'BN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'36', N'BTN', N'Bhutan', N'BT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'37', N'BVT', N'Bouvet Island', N'BV')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'38', N'BWA', N'Botswana', N'BW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'39', N'CAF', N'Central African Republic', N'CF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'40', N'CAN', N'Canada', N'CA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'41', N'CCK', N'Cocos [Keeling] Islands', N'CC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'42', N'CHE', N'Switzerland', N'CH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'43', N'CHL', N'Chile', N'CL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'44', N'CHN', N'China', N'CN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'45', N'CIV', N'Ivory Coast', N'CI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'46', N'CMR', N'Cameroon', N'CM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'47', N'COD', N'Democratic Republic of the Congo', N'CD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'48', N'COG', N'Republic of the Congo', N'CG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'49', N'COK', N'Cook Islands', N'CK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'50', N'COL', N'Colombia', N'CO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'51', N'COM', N'Comoros', N'KM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'52', N'CPV', N'Cape Verde', N'CV')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'53', N'CRI', N'Costa Rica', N'CR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'54', N'CUB', N'Cuba', N'CU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'55', N'CUW', N'Curacao', N'CW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'56', N'CXR', N'Christmas Island', N'CX')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'57', N'CYM', N'Cayman Islands', N'KY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'58', N'CYP', N'Cyprus', N'CY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'59', N'CZE', N'Czech Republic', N'CZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'60', N'DEU', N'Germany', N'DE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'61', N'DJI', N'Djibouti', N'DJ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'62', N'DMA', N'Dominica', N'DM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'63', N'DNK', N'Denmark', N'DK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'64', N'DOM', N'Dominican Republic', N'DO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'65', N'DZA', N'Algeria', N'DZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'66', N'ECU', N'Ecuador', N'EC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'67', N'EGY', N'Egypt', N'EG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'68', N'ERI', N'Eritrea', N'ER')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'69', N'ESH', N'Western Sahara', N'EH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'70', N'ESP', N'Spain', N'ES')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'71', N'EST', N'Estonia', N'EE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'72', N'ETH', N'Ethiopia', N'ET')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'73', N'FIN', N'Finland', N'FI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'74', N'FJI', N'Fiji', N'FJ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'75', N'FLK', N'Falkland Islands', N'FK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'76', N'FRA', N'France', N'FR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'77', N'FRO', N'Faroe Islands', N'FO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'78', N'FSM', N'Micronesia', N'FM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'79', N'GAB', N'Gabon', N'GA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'80', N'GBR', N'United Kingdom', N'GB')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'81', N'GEO', N'Georgia', N'GE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'82', N'GGY', N'Guernsey', N'GG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'83', N'GHA', N'Ghana', N'GH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'84', N'GIB', N'Gibraltar', N'GI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'85', N'GIN', N'Guinea', N'GN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'86', N'GLP', N'Guadeloupe', N'GP')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'87', N'GMB', N'Gambia', N'GM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'88', N'GNB', N'Guinea-Bissau', N'GW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'89', N'GNQ', N'Equatorial Guinea', N'GQ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'90', N'GRC', N'Greece', N'GR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'91', N'GRD', N'Grenada', N'GD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'92', N'GRL', N'Greenland', N'GL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'93', N'GTM', N'Guatemala', N'GT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'94', N'GUF', N'French Guiana', N'GF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'95', N'GUM', N'Guam', N'GU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'96', N'GUY', N'Guyana', N'GY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'97', N'HKG', N'Hong Kong', N'HK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'98', N'HMD', N'Heard Island and McDonald Islands', N'HM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'99', N'HND', N'Honduras', N'HN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'100', N'HRV', N'Croatia', N'HR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'101', N'HTI', N'Haiti', N'HT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'102', N'HUN', N'Hungary', N'HU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'103', N'IDN', N'Indonesia', N'ID')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'104', N'IMN', N'Isle of Man', N'IM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'105', N'IND', N'India', N'IN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'106', N'IOT', N'British Indian Ocean Territory', N'IO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'107', N'IRL', N'Ireland', N'IE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'108', N'IRN', N'Iran', N'IR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'109', N'IRQ', N'Iraq', N'IQ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'110', N'ISL', N'Iceland', N'IS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'111', N'ISR', N'Israel', N'IL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'112', N'ITA', N'Italy', N'IT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'113', N'JAM', N'Jamaica', N'JM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'114', N'JEY', N'Jersey', N'JE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'115', N'JOR', N'Jordan', N'JO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'116', N'JPN', N'Japan', N'JP')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'117', N'KAZ', N'Kazakhstan', N'KZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'118', N'KEN', N'Kenya', N'KE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'119', N'KGZ', N'Kyrgyzstan', N'KG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'120', N'KHM', N'Cambodia', N'KH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'121', N'KIR', N'Kiribati', N'KI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'122', N'KNA', N'Saint Kitts and Nevis', N'KN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'123', N'KOR', N'South Korea', N'KR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'124', N'KWT', N'Kuwait', N'KW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'125', N'LAO', N'Laos', N'LA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'126', N'LBN', N'Lebanon', N'LB')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'127', N'LBR', N'Liberia', N'LR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'128', N'LBY', N'Libya', N'LY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'129', N'LCA', N'Saint Lucia', N'LC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'130', N'LIE', N'Liechtenstein', N'LI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'131', N'LKA', N'Sri Lanka', N'LK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'132', N'LSO', N'Lesotho', N'LS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'133', N'LTU', N'Lithuania', N'LT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'134', N'LUX', N'Luxembourg', N'LU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'135', N'LVA', N'Latvia', N'LV')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'136', N'MAC', N'Macao', N'MO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'137', N'MAF', N'Saint Martin', N'MF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'138', N'MAR', N'Morocco', N'MA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'139', N'MCO', N'Monaco', N'MC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'140', N'MDA', N'Moldova', N'MD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'141', N'MDG', N'Madagascar', N'MG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'142', N'MDV', N'Maldives', N'MV')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'143', N'MEX', N'Mexico', N'MX')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'144', N'MHL', N'Marshall Islands', N'MH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'145', N'MKD', N'Macedonia', N'MK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'146', N'MLI', N'Mali', N'ML')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'147', N'MLT', N'Malta', N'MT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'148', N'MMR', N'Myanmar [Burma]', N'MM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'149', N'MNE', N'Montenegro', N'ME')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'150', N'MNG', N'Mongolia', N'MN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'151', N'MNP', N'Northern Mariana Islands', N'MP')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'152', N'MOZ', N'Mozambique', N'MZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'153', N'MRT', N'Mauritania', N'MR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'154', N'MSR', N'Montserrat', N'MS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'155', N'MTQ', N'Martinique', N'MQ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'156', N'MUS', N'Mauritius', N'MU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'157', N'MWI', N'Malawi', N'MW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'158', N'MYS', N'Malaysia', N'MY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'159', N'MYT', N'Mayotte', N'YT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'160', N'NAM', N'Namibia', N'NA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'161', N'NCL', N'New Caledonia', N'NC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'162', N'NER', N'Niger', N'NE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'163', N'NFK', N'Norfolk Island', N'NF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'164', N'NGA', N'Nigeria', N'NG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'165', N'NIC', N'Nicaragua', N'NI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'166', N'NIU', N'Niue', N'NU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'167', N'NLD', N'Netherlands', N'NL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'168', N'NOR', N'Norway', N'NO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'169', N'NPL', N'Nepal', N'NP')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'170', N'NRU', N'Nauru', N'NR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'171', N'NZL', N'New Zealand', N'NZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'172', N'OMN', N'Oman', N'OM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'173', N'PAK', N'Pakistan', N'PK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'174', N'PAN', N'Panama', N'PA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'175', N'PCN', N'Pitcairn Islands', N'PN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'176', N'PER', N'Peru', N'PE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'177', N'PHL', N'Philippines', N'PH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'178', N'PLW', N'Palau', N'PW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'179', N'PNG', N'Papua New Guinea', N'PG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'180', N'POL', N'Poland', N'PL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'181', N'PRI', N'Puerto Rico', N'PR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'182', N'PRK', N'North Korea', N'KP')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'183', N'PRT', N'Portugal', N'PT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'184', N'PRY', N'Paraguay', N'PY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'185', N'PSE', N'Palestine', N'PS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'186', N'PYF', N'French Polynesia', N'PF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'187', N'QAT', N'Qatar', N'QA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'188', N'REU', N'Réunion', N'RE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'189', N'ROU', N'Romania', N'RO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'190', N'RUS', N'Russia', N'RU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'191', N'RWA', N'Rwanda', N'RW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'192', N'SAU', N'Saudi Arabia', N'SA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'193', N'SDN', N'Sudan', N'SD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'194', N'SEN', N'Senegal', N'SN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'195', N'SGP', N'Singapore', N'SG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'196', N'SGS', N'South Georgia and the South Sandwich Islands', N'GS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'197', N'SHN', N'Saint Helena', N'SH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'198', N'SJM', N'Svalbard and Jan Mayen', N'SJ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'199', N'SLB', N'Solomon Islands', N'SB')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'200', N'SLE', N'Sierra Leone', N'SL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'201', N'SLV', N'El Salvador', N'SV')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'202', N'SMR', N'San Marino', N'SM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'203', N'SOM', N'Somalia', N'SO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'204', N'SPM', N'Saint Pierre and Miquelon', N'PM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'205', N'SRB', N'Serbia', N'RS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'206', N'SSD', N'South Sudan', N'SS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'207', N'STP', N'São Tomé and Príncipe', N'ST')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'208', N'SUR', N'Suriname', N'SR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'209', N'SVK', N'Slovakia', N'SK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'210', N'SVN', N'Slovenia', N'SI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'211', N'SWE', N'Sweden', N'SE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'212', N'SWZ', N'Swaziland', N'SZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'213', N'SXM', N'Sint Maarten', N'SX')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'214', N'SYC', N'Seychelles', N'SC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'215', N'SYR', N'Syria', N'SY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'216', N'TCA', N'Turks and Caicos Islands', N'TC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'217', N'TCD', N'Chad', N'TD')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'218', N'TGO', N'Togo', N'TG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'219', N'THA', N'Thailand', N'TH')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'220', N'TJK', N'Tajikistan', N'TJ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'221', N'TKL', N'Tokelau', N'TK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'222', N'TKM', N'Turkmenistan', N'TM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'223', N'TLS', N'East Timor', N'TL')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'224', N'TON', N'Tonga', N'TO')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'225', N'TTO', N'Trinidad and Tobago', N'TT')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'226', N'TUN', N'Tunisia', N'TN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'227', N'TUR', N'Turkey', N'TR')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'228', N'TUV', N'Tuvalu', N'TV')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'229', N'TWN', N'Taiwan', N'TW')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'230', N'TZA', N'Tanzania', N'TZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'231', N'UGA', N'Uganda', N'UG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'232', N'UKR', N'Ukraine', N'UA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'233', N'UMI', N'U.S. Minor Outlying Islands', N'UM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'234', N'URY', N'Uruguay', N'UY')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'235', N'USA', N'United States', N'US')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'236', N'UZB', N'Uzbekistan', N'UZ')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'237', N'VAT', N'Vatican City', N'VA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'238', N'VCT', N'Saint Vincent and the Grenadines', N'VC')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'239', N'VEN', N'Venezuela', N'VE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'240', N'VGB', N'British Virgin Islands', N'VG')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'241', N'VIR', N'U.S. Virgin Islands', N'VI')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'242', N'VNM', N'Vietnam', N'VN')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'243', N'VUT', N'Vanuatu', N'VU')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'244', N'WLF', N'Wallis and Futuna', N'WF')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'245', N'WSM', N'Samoa', N'WS')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'246', N'XKX', N'Kosovo', N'XK')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'247', N'YEM', N'Yemen', N'YE')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'248', N'ZAF', N'South Africa', N'ZA')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'249', N'ZMB', N'Zambia', N'ZM')
GO

INSERT INTO [dbo].[countries] ([id], [iso], [name], [code]) VALUES (N'250', N'ZWE', N'Zimbabwe', N'ZW')
GO

SET IDENTITY_INSERT [dbo].[countries] OFF
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
-- Records of crm_chase
-- ----------------------------
SET IDENTITY_INSERT [dbo].[crm_chase] ON
GO

INSERT INTO [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1', N'Materialize', N'Bacoor, Cavite', N'2', N'52000', N'0', N'1', NULL, N'2019-09-25 22:01:16.000', N'2019-09-25 22:01:16.000')
GO

INSERT INTO [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'2', N'Dropdown', N'Ayala Ave., Makati City', N'3', N'63000', N'0', N'1', NULL, N'2019-09-25 22:03:16.000', N'2019-09-25 22:03:16.000')
GO

INSERT INTO [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'3', N'JavaScript', N'Ortigas, Pasig City', N'1', N'27800', N'0', N'1', NULL, N'2019-09-25 22:04:02.000', N'2019-09-25 22:04:02.000')
GO

INSERT INTO [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'4', N'Methods', N'Cubao, Quezon City', N'2', N'105750', N'0', N'1', NULL, N'2019-09-25 22:04:55.000', N'2019-09-25 22:04:55.000')
GO

INSERT INTO [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'5', N'Events', N'Fairview, Quezon City', N'2', N'47000', N'All', N'1', NULL, N'2019-09-25 22:41:50.000', N'2019-09-25 22:41:50.000')
GO

SET IDENTITY_INSERT [dbo].[crm_chase] OFF
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
-- Records of crm_clone
-- ----------------------------
SET IDENTITY_INSERT [dbo].[crm_clone] ON
GO

SET IDENTITY_INSERT [dbo].[crm_clone] OFF
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
-- Records of crm_members
-- ----------------------------
SET IDENTITY_INSERT [dbo].[crm_members] ON
GO

SET IDENTITY_INSERT [dbo].[crm_members] OFF
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
-- Records of custom_approver
-- ----------------------------
SET IDENTITY_INSERT [dbo].[custom_approver] ON
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'1', N'2', N'1', N'1')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'2', N'90', N'11', N'11')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'3', N'18', N'11', N'11')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'4', N'10', N'11', N'11')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'5', N'35', N'11', N'11')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'6', N'9', N'8', N'8')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'7', N'6', N'8', N'8')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'8', N'49', N'8', N'6')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'9', N'25', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'10', N'16', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'11', N'31', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'12', N'30', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'13', N'32', N'11', N'90')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'14', N'28', N'8', N'8')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'15', N'22', N'8', N'8')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'16', N'15', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'17', N'54', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'18', N'24', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'19', N'50', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'20', N'51', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'21', N'63', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'22', N'64', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'23', N'67', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'24', N'71', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'25', N'74', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'26', N'88', N'9', N'9')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'27', N'94', N'24', N'24')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'28', N'108', N'54', N'54')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'29', N'98', N'67', N'67')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'30', N'104', N'67', N'67')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'31', N'105', N'51', N'51')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'32', N'106', N'51', N'51')
GO

INSERT INTO [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (N'33', N'1', N'1', N'1')
GO

SET IDENTITY_INSERT [dbo].[custom_approver] OFF
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
-- Records of departments
-- ----------------------------
SET IDENTITY_INSERT [dbo].[departments] ON
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'1', N'8', N'Administration Office', N'AO', N'155', N'155', N'57', N'test', N'1', NULL, N'2021-06-14 17:31:37.000', N'2021-09-20 23:13:41.927')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'2', N'8', N'General Services Department', N'GSD', N'2', N'2', N'1', N'I.T.s', N'1', NULL, N'2021-06-14 17:32:41.000', N'2021-09-17 10:38:05.710')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'5', N'8', N'Human Resources Department - Admin', N'HRD', N'1', N'2', N'1', N'', N'1', NULL, N'2021-06-14 19:23:25.000', N'2021-09-20 23:13:58.210')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'6', N'8', N'Accounting Department', N'AD', N'1', N'1', N'1', N'', N'1', NULL, N'2021-06-14 19:23:25.000', N'2021-09-17 10:38:31.570')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'7', N'8', N'Information and Communications Technology Department - Admin', N'ICT', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:39:01.970', N'2021-09-17 11:00:10.223')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'8', N'8', N'Materials Control Department - Admin', N'MCD', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:39:26.160', N'2021-09-17 10:59:36.943')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'9', N'8', N'Medical Department', N'MD', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:39:43.813', N'2021-09-17 10:39:43.813')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'10', N'8', N'Security Department', N'SD', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:40:02.227', N'2021-09-17 10:40:02.227')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'11', N'8', N'Weighbridge', N'WD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:40:21.100', N'2021-09-17 10:40:21.100')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'12', N'2', N'Accounting and Finance Department', N'AFD', N'122', N'122', N'122', N'', N'1', NULL, N'2021-09-17 10:40:41.607', N'2021-09-17 10:40:41.607')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'13', N'2', N'Administration', N'A', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:41:00.270', N'2021-09-17 10:41:00.270')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'14', N'2', N'Executive', N'EX', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:41:17.893', N'2021-09-17 10:41:17.893')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'15', N'2', N'Human Resources Department - Davao', N'HRDD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:41:41.767', N'2021-09-17 10:59:21.973')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'16', N'2', N'Information and Communications Technology Department - Davao', N'ICTD', N'122', N'122', N'122', N'', N'1', NULL, N'2021-09-17 10:42:08.080', N'2021-09-17 11:00:25.350')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'17', N'2', N'Legal Department - Davao', N'LD', N'122', N'122', N'122', N'', N'1', NULL, N'2021-09-17 10:42:33.203', N'2021-09-17 11:00:38.823')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'18', N'2', N'Materials Control Department - Davao', N'MCDD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:42:53.170', N'2021-09-17 10:59:54.420')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'19', N'1', N'Civil Works Department', N'CWD', N'1', N'2', N'1', N'', N'1', NULL, N'2021-09-17 10:43:09.887', N'2021-09-20 23:14:18.987')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'20', N'1', N'Electrical Services Department', N'ESD', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:43:32.757', N'2021-09-17 10:43:32.757')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'21', N'1', N'Motorpool Department', N'MDD', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:43:54.833', N'2021-09-17 10:43:54.833')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'22', N'1', N'Technical Services Department', N'TSD', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:44:12.227', N'2021-09-17 10:44:12.227')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'23', N'7', N'Audit and Systems Improvement Engineer Department', N'ASIED', N'1', N'2', N'1', N'', N'1', NULL, N'2021-09-17 10:44:34.273', N'2021-09-20 23:14:07.770')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'24', N'7', N'Environment Department', N'ED', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:44:56.353', N'2021-09-17 10:44:56.353')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'25', N'7', N'Executive Office', N'EO', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:45:12.853', N'2021-09-17 10:45:12.853')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'26', N'7', N'Legal Department - ED', N'LDD', N'155', N'155', N'155', N'', N'1', NULL, N'2021-09-17 10:45:33.117', N'2021-09-20 23:13:33.853')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'27', N'7', N'Quality Assurance/Quality Control Department', N'QACD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:46:01.783', N'2021-09-17 10:46:01.783')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'28', N'7', N'Safety Department', N'SFD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:46:26.710', N'2021-09-17 10:46:26.710')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'29', N'7', N'Special Project', N'SP', N'1', N'0', N'1', N'', N'1', NULL, N'2021-09-17 10:46:49.000', N'2021-09-17 10:46:49.000')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'30', N'7', N'Tenements, Licensing & Community Relations (TLCR) Department', N'TLCR', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:47:09.720', N'2021-09-17 10:47:09.720')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'31', N'3', N'Admin and Finance Services', N'AFS', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:47:36.443', N'2021-09-17 10:47:36.443')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'32', N'3', N'Co-o Deparment', N'COO', N'1', N'2', N'1', N'', N'1', NULL, N'2021-09-17 10:47:54.430', N'2021-09-20 23:14:34.867')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'33', N'3', N'GIS/Data Administration/QAQC', N'QAQC', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:48:20.687', N'2021-09-17 10:48:20.687')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'34', N'3', N'Tambis', N'TBS', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:48:39.873', N'2021-09-17 10:48:39.873')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'35', N'3', N'Technical Support Services', N'TSC', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:49:03.930', N'2021-09-17 10:49:03.930')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'36', N'4', N'Mill Executive Department', N'MED', N'1', N'1', N'2', N'', N'1', NULL, N'2021-09-17 10:51:14.230', N'2021-09-17 10:51:14.230')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'37', N'4', N'Mill Maintenance Department', N'MMD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:51:32.633', N'2021-09-17 10:51:32.633')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'38', N'4', N'Mill Metallurgy Department', N'MMDD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:51:55.687', N'2021-09-17 10:51:55.687')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'39', N'4', N'Mill Operation Department', N'MOD', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:52:12.587', N'2021-09-17 10:52:12.587')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'40', N'9', N'Mine Electrical', N'ME', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:52:29.120', N'2021-09-17 10:52:29.120')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'41', N'9', N'Mine Engineering', N'MEDD', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 10:53:03.003', N'2021-09-17 10:53:03.003')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'42', N'9', N'Mine Explosive', N'MNE', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 10:53:21.530', N'2021-09-17 10:53:21.530')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'43', N'9', N'Mine Geology', N'MNG', N'122', N'122', N'122', N'', N'1', NULL, N'2021-09-17 10:53:38.450', N'2021-09-17 10:53:38.450')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'44', N'9', N'Mine Mechanical', N'MNM', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 10:53:52.643', N'2021-09-17 10:53:52.643')
GO

INSERT INTO [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'45', N'9', N'Mine Operation', N'MNO', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 10:54:09.110', N'2021-09-17 10:54:09.110')
GO

SET IDENTITY_INSERT [dbo].[departments] OFF
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
-- Records of dispute
-- ----------------------------
SET IDENTITY_INSERT [dbo].[dispute] ON
GO

INSERT INTO [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (N'1', N'1', NULL, NULL, NULL, N'4', N'2019-10-01', N'2', N'Not acounted', N'2', N'2', N'1', N'1', N'1', N'', NULL, N'2019-10-03 18:03:53.000', N'2019-10-08 11:42:29.000')
GO

INSERT INTO [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (N'2', N'2', NULL, NULL, NULL, N'2', N'2019-10-01', N'2', N'Overtime not applied', N'2', N'2', N'1', N'1', N'1', N'', NULL, N'2019-10-08 11:01:40.000', N'2019-10-08 11:42:29.000')
GO

INSERT INTO [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (N'3', N'2', NULL, NULL, NULL, N'7', N'2019-10-06', N'1', N'Work at site', N'2', N'2', N'1', N'1', N'1', N'', NULL, N'2019-10-08 11:02:29.000', N'2019-10-08 11:42:29.000')
GO

INSERT INTO [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (N'4', N'2', NULL, NULL, NULL, N'8', N'2019-10-02', N'3', N'Leave not applied', N'2', N'2', N'1', N'1', N'1', N'', NULL, N'2019-10-08 11:04:22.000', N'2019-10-08 11:42:29.000')
GO

INSERT INTO [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (N'5', N'2', NULL, NULL, NULL, N'5', N'2019-10-04', N'4', N'Forgot to log', N'2', N'2', N'1', N'1', N'1', N'', NULL, N'2019-10-08 11:06:53.000', N'2019-10-08 11:42:29.000')
GO

SET IDENTITY_INSERT [dbo].[dispute] OFF
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
-- Records of divisions
-- ----------------------------
SET IDENTITY_INSERT [dbo].[divisions] ON
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'1', N'1', N'Engineering and Construction Services Division', N'ECSD', N'111', N'125', N'166', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', N'1', NULL, N'2021-06-11 12:35:21.000', N'2021-09-20 23:12:40.463')
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'2', N'1', N'Corporate Davao', N'CD', N'57', N'111', N'57', N'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'1', NULL, N'2021-06-11 12:56:57.000', N'2021-09-20 23:12:34.657')
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'3', N'1', N'Exploration Division', N'EXD', N'155', N'155', N'57', N'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.', N'1', NULL, N'2021-06-11 13:17:25.000', N'2021-09-20 23:12:53.493')
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'4', N'1', N'Mill Division', N'MD', N'1', N'0', N'1', N'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet.', N'1', NULL, N'2021-06-11 13:22:18.000', N'2021-09-17 10:36:04.590')
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'7', N'1', N'Executive Division', N'ED', N'155', N'155', N'155', N'Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus', N'1', NULL, N'2021-06-14 19:24:01.000', N'2021-09-20 23:12:47.147')
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'8', N'1', N'Administration Division', N'AD', N'155', N'155', N'155', N'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident', N'1', NULL, N'2021-06-14 19:24:01.000', N'2021-09-20 23:12:24.647')
GO

INSERT INTO [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'9', N'1', N'Mine Division', N'MID', N'119', N'119', N'122', N'', N'1', NULL, N'2021-09-17 10:36:29.137', N'2021-09-17 10:36:29.137')
GO

SET IDENTITY_INSERT [dbo].[divisions] OFF
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
-- Records of educations
-- ----------------------------
SET IDENTITY_INSERT [dbo].[educations] ON
GO

SET IDENTITY_INSERT [dbo].[educations] OFF
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
-- Records of employee_type
-- ----------------------------
SET IDENTITY_INSERT [dbo].[employee_type] ON
GO

INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (N'1', N'Regular', N'2021-06-18 15:38:15.000', NULL)
GO

INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (N'2', N'Probationary', N'2021-06-18 15:38:31.000', NULL)
GO

INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (N'3', N'Project Based', N'2021-06-18 15:38:31.000', NULL)
GO

INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (N'4', N'Casual', N'2021-06-18 15:38:31.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[employee_type] OFF
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
-- Records of employments
-- ----------------------------
SET IDENTITY_INSERT [dbo].[employments] ON
GO

INSERT INTO [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at], [location_id]) VALUES (N'8', N'1', NULL, N'1', NULL, N'2', N'15', N'8', N'14', N'3', N'1', N'department', N'4', N'1', N'0', N'2021-06-17', NULL, NULL, N'1', NULL, N'0', N'0', N'2021-06-21 23:02:13.000', N'2021-06-17 21:02:31.000', N'1')
GO

INSERT INTO [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at], [location_id]) VALUES (N'9', N'1', NULL, N'1', NULL, N'8', N'9', N'12', N'27', N'1', N'1', N'division', N'4', N'1', N'0', N'2021-06-22', NULL, NULL, N'2', NULL, N'0', N'0', N'2021-06-22 20:50:18.000', N'2021-06-22 20:50:18.000', N'1')
GO

INSERT INTO [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at], [location_id]) VALUES (N'1013', N'157', NULL, N'1', NULL, N'8', N'6', N'1', N'27', N'3', N'1', N'division', N'4', N'1', NULL, N'2021-09-01', NULL, NULL, N'1', NULL, N'0', N'0', N'2021-09-27 18:09:25.897', N'2021-09-27 18:09:25.897', N'3')
GO

SET IDENTITY_INSERT [dbo].[employments] OFF
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
-- Records of events
-- ----------------------------
SET IDENTITY_INSERT [dbo].[events] ON
GO

INSERT INTO [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (N'4', N'1', N'2021-02-15 08:00:00.0000000', N'2021-02-17 08:00:00.0000000', N'Out of Office Meeting / Sourcing', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', N'2021-02-15 20:05:39.000', N'2021-02-15 20:05:39.000')
GO

INSERT INTO [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (N'5', N'1', N'2021-02-17 00:00:00.0000000', N'2021-02-17 00:00:00.0000000', N'Office Work', NULL, N'2021-02-15 20:42:57.000', N'2021-02-15 20:42:57.000')
GO

INSERT INTO [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (N'6', N'1', N'2021-02-17 00:00:00.0000000', N'2021-02-17 00:00:00.0000000', N'Shop / Warehouse Visit', NULL, N'2021-02-15 20:43:08.000', N'2021-02-15 20:43:08.000')
GO

INSERT INTO [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (N'7', N'1', N'2021-02-28 00:00:00.0000000', N'2021-02-28 00:00:00.0000000', N'Jobsite', N'Test', N'2021-02-16 13:11:53.000', N'2021-02-16 13:11:53.000')
GO

INSERT INTO [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (N'8', N'1', N'2021-03-01 00:00:00.0000000', N'2021-03-02 00:00:00.0000000', N'Office', NULL, N'2021-02-17 13:55:07.000', N'2021-02-17 13:55:07.000')
GO

INSERT INTO [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (N'9', N'1', N'2021-03-17 00:00:00.0000000', N'2021-03-17 00:00:00.0000000', N'Shop/Warehouse', NULL, N'2021-03-04 20:50:16.000', N'2021-03-04 20:50:16.000')
GO

SET IDENTITY_INSERT [dbo].[events] OFF
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
-- Records of holidays
-- ----------------------------
SET IDENTITY_INSERT [dbo].[holidays] ON
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'1', N'177', N'1', N'2021-08-05', N'National Heroes'' Day', N'1', N'1', NULL, N'2019-10-01 11:58:18.000', N'2021-06-11 00:36:10.000', N'1', N'1')
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'2', N'177', N'1', N'2021-09-23', N'Bonifacio Day', N'1', N'1', NULL, N'2019-10-01 12:01:07.000', N'2021-06-11 00:36:04.000', N'1', N'1')
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'3', N'177', N'1', N'2021-08-12', N'Christmas Day', N'1', N'1', NULL, N'2019-10-01 12:01:31.000', N'2021-06-11 00:35:57.000', N'1', N'1')
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'4', N'177', N'1', N'2021-08-13', N'Rizal Day', N'1', N'1', NULL, N'2019-10-01 12:01:56.000', N'2021-06-11 00:35:48.000', N'1', N'1')
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'5', N'177', N'1', N'2021-09-25', N'Chinese New Year', N'2', N'1', NULL, N'2021-02-11 12:50:32.000', N'2021-06-11 00:35:40.000', N'1', N'1')
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'6', NULL, N'1', N'2021-08-12', N'Test Holiday', N'2', N'1', NULL, N'2021-06-11 00:28:11.000', N'2021-06-11 00:28:11.000', N'1', N'1')
GO

INSERT INTO [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (N'7', NULL, N'1', N'2021-08-03', N'Regular Holiday  Test', N'1', N'1', NULL, N'2021-08-17 15:35:22.400', N'2021-08-17 15:35:22.400', N'1', N'0')
GO

SET IDENTITY_INSERT [dbo].[holidays] OFF
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
-- Records of incentive
-- ----------------------------
SET IDENTITY_INSERT [dbo].[incentive] ON
GO

INSERT INTO [dbo].[incentive] ([id], [user_id], [from], [to], [amount], [label], [mode], [status], [period], [taxable], [created_at], [updated_at]) VALUES (N'1', N'2', N'2019-11-19', NULL, N'3000', N'Rice Allowance', N'2', N'1', N'2', N'0', N'2019-11-19 11:30:19.000', N'2019-11-19 11:30:19.000')
GO

INSERT INTO [dbo].[incentive] ([id], [user_id], [from], [to], [amount], [label], [mode], [status], [period], [taxable], [created_at], [updated_at]) VALUES (N'68', N'1', N'2021-01-01', NULL, N'3500', N'Transfortation', N'2', N'1', N'2', N'0', N'2021-02-03 17:15:40.000', N'2021-02-03 17:15:40.000')
GO

INSERT INTO [dbo].[incentive] ([id], [user_id], [from], [to], [amount], [label], [mode], [status], [period], [taxable], [created_at], [updated_at]) VALUES (N'69', N'1', N'2021-01-01', NULL, N'4500', N'Rice Allowance', N'2', N'1', N'2', N'0', N'2021-02-03 17:16:53.000', N'2021-02-03 17:16:53.000')
GO

SET IDENTITY_INSERT [dbo].[incentive] OFF
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
-- Records of interview
-- ----------------------------
SET IDENTITY_INSERT [dbo].[interview] ON
GO

SET IDENTITY_INSERT [dbo].[interview] OFF
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
-- Records of interview_ratings
-- ----------------------------
SET IDENTITY_INSERT [dbo].[interview_ratings] ON
GO

SET IDENTITY_INSERT [dbo].[interview_ratings] OFF
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
-- Records of leave_credit_policy
-- ----------------------------
SET IDENTITY_INSERT [dbo].[leave_credit_policy] ON
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'1', N'1', N'1', N'198', N'17', NULL, N'2019-10-03 17:55:44.000', N'2021-02-10 22:54:48.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'2', N'1', N'3', N'0', N'10', NULL, N'2019-10-03 17:55:44.000', N'2021-02-10 22:54:48.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'3', N'1', N'4', N'0', N'0', NULL, N'2019-10-03 17:55:44.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'4', N'1', N'5', N'5', N'0', NULL, N'2019-10-03 17:55:44.000', N'2020-03-02 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'5', N'2', N'1', N'216', N'0', NULL, N'2019-10-05 15:22:17.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'6', N'2', N'3', N'10', N'0', NULL, N'2019-10-05 15:22:17.000', N'2020-06-01 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'7', N'2', N'4', N'0', N'0', NULL, N'2019-10-05 15:22:17.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'8', N'2', N'5', N'10', N'0', NULL, N'2019-10-05 15:22:17.000', N'2019-12-01 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'9', N'41', N'1', N'210', N'0', NULL, N'2019-11-01 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'10', N'41', N'2', N'0', N'0', NULL, N'2019-11-01 14:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'11', N'41', N'3', N'10', N'0', NULL, N'2019-11-01 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'12', N'41', N'5', N'5', N'0', NULL, N'2019-11-01 14:00:00.000', N'2019-11-01 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'13', N'41', N'6', N'30', N'0', NULL, N'2019-11-01 14:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'14', N'32', N'2', N'0', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'15', N'110', N'3', N'10', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'16', N'32', N'3', N'10', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'17', N'111', N'1', N'210', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'18', N'110', N'1', N'210', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'19', N'32', N'1', N'210', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'20', N'111', N'3', N'10', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'21', N'110', N'2', N'0', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'22', N'111', N'2', N'0', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'23', N'32', N'5', N'5', N'0', NULL, N'2019-11-02 14:00:00.000', N'2019-11-02 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'24', N'110', N'5', N'5', N'0', NULL, N'2019-11-02 14:00:00.000', N'2019-11-02 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'25', N'111', N'5', N'5', N'0', NULL, N'2019-11-02 14:00:00.000', N'2019-11-02 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'26', N'32', N'6', N'30', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'27', N'110', N'6', N'30', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'28', N'111', N'6', N'30', N'0', NULL, N'2019-11-02 14:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'29', N'5', N'3', N'10', N'0', NULL, N'2019-11-03 14:00:00.000', N'2019-11-03 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'30', N'5', N'4', N'0', N'0', NULL, N'2019-11-03 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'31', N'5', N'5', N'10', N'0', NULL, N'2019-11-03 14:00:00.000', N'2019-11-03 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'32', N'5', N'1', N'216', N'0', NULL, N'2019-11-03 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'33', N'34', N'1', N'210', N'0', NULL, N'2019-11-05 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'34', N'34', N'3', N'10', N'0', NULL, N'2019-11-05 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'35', N'34', N'4', N'0', N'0', NULL, N'2019-11-05 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'36', N'34', N'5', N'5', N'0', NULL, N'2019-11-05 15:00:00.000', N'2019-11-05 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'37', N'39', N'4', N'0', N'0', NULL, N'2019-11-11 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'38', N'39', N'5', N'15', N'0', NULL, N'2019-11-11 15:00:01.000', N'2020-05-11 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'39', N'39', N'3', N'10', N'0', NULL, N'2019-11-11 15:00:01.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'40', N'39', N'1', N'222', N'0', NULL, N'2019-11-11 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'41', N'42', N'1', N'216', N'0', NULL, N'2019-11-13 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'42', N'35', N'1', N'216', N'0', NULL, N'2019-11-13 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'43', N'35', N'3', N'10', N'0', NULL, N'2019-11-13 15:00:00.000', N'2020-05-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'44', N'42', N'3', N'10', N'0', NULL, N'2019-11-13 15:00:00.000', N'2020-05-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'45', N'35', N'4', N'0', N'0', NULL, N'2019-11-13 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'46', N'42', N'4', N'0', N'0', NULL, N'2019-11-13 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'47', N'35', N'5', N'10', N'0', NULL, N'2019-11-13 15:00:00.000', N'2020-05-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'48', N'42', N'5', N'10', N'0', NULL, N'2019-11-13 15:00:00.000', N'2020-05-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'49', N'19', N'1', N'216', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'50', N'33', N'1', N'216', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'51', N'47', N'1', N'222', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'52', N'54', N'1', N'216', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'53', N'55', N'1', N'216', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'54', N'65', N'1', N'222', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'55', N'19', N'2', N'0', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'56', N'33', N'2', N'0', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'57', N'55', N'2', N'0', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'58', N'65', N'2', N'0', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'59', N'19', N'3', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'60', N'33', N'3', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'61', N'47', N'3', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'62', N'54', N'3', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'63', N'55', N'3', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'64', N'65', N'3', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'65', N'47', N'4', N'0', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'66', N'54', N'4', N'0', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'67', N'19', N'5', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'68', N'33', N'5', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'69', N'47', N'5', N'15', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'70', N'54', N'5', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'71', N'55', N'5', N'10', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'72', N'65', N'5', N'15', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'73', N'19', N'6', N'30', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'74', N'33', N'6', N'30', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'75', N'55', N'6', N'30', N'0', NULL, N'2019-11-16 15:00:00.000', N'2020-05-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'76', N'65', N'6', N'30', N'0', NULL, N'2019-11-16 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'77', N'15', N'4', N'0', N'0', NULL, N'2019-11-17 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'78', N'15', N'1', N'216', N'0', NULL, N'2019-11-17 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'79', N'15', N'5', N'10', N'0', NULL, N'2019-11-17 15:00:00.000', N'2020-05-17 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'80', N'15', N'3', N'10', N'0', NULL, N'2019-11-17 15:00:00.000', N'2020-05-17 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'81', N'36', N'1', N'216', N'0', NULL, N'2019-11-19 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'82', N'36', N'3', N'10', N'0', NULL, N'2019-11-19 15:00:00.000', N'2020-05-19 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'83', N'36', N'4', N'0', N'0', NULL, N'2019-11-19 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'84', N'36', N'5', N'10', N'0', NULL, N'2019-11-19 15:00:00.000', N'2020-05-19 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'85', N'58', N'5', N'10', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'86', N'57', N'5', N'10', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'87', N'56', N'5', N'10', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'88', N'57', N'1', N'216', N'0', NULL, N'2019-11-23 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'89', N'58', N'2', N'0', N'0', NULL, N'2019-11-23 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'90', N'58', N'3', N'10', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'91', N'57', N'3', N'10', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'92', N'56', N'3', N'10', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'93', N'58', N'1', N'216', N'0', NULL, N'2019-11-23 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'94', N'56', N'1', N'216', N'0', NULL, N'2019-11-23 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'95', N'56', N'4', N'0', N'0', NULL, N'2019-11-23 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'96', N'57', N'4', N'0', N'0', NULL, N'2019-11-23 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'97', N'58', N'6', N'30', N'0', NULL, N'2019-11-23 15:00:00.000', N'2020-05-23 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'98', N'16', N'1', N'216', N'0', NULL, N'2019-11-27 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'99', N'20', N'1', N'216', N'0', NULL, N'2019-11-27 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'100', N'16', N'2', N'0', N'0', NULL, N'2019-11-27 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'101', N'20', N'2', N'0', N'0', NULL, N'2019-11-27 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'102', N'16', N'3', N'10', N'0', NULL, N'2019-11-27 15:00:00.000', N'2020-05-27 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'103', N'20', N'3', N'10', N'0', NULL, N'2019-11-27 15:00:00.000', N'2020-05-27 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'104', N'16', N'5', N'10', N'0', NULL, N'2019-11-27 15:00:00.000', N'2020-05-27 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'105', N'20', N'5', N'10', N'0', NULL, N'2019-11-27 15:00:00.000', N'2020-05-27 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'106', N'16', N'6', N'30', N'0', NULL, N'2019-11-27 15:00:00.000', N'2020-05-27 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'107', N'20', N'6', N'30', N'0', NULL, N'2019-11-27 15:00:00.000', N'2020-05-27 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'108', N'77', N'2', N'0', N'0', NULL, N'2019-11-29 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'109', N'77', N'1', N'216', N'0', NULL, N'2019-11-29 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'110', N'77', N'3', N'10', N'0', NULL, N'2019-11-29 15:00:00.000', N'2020-05-29 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'111', N'77', N'5', N'10', N'0', NULL, N'2019-11-29 15:00:00.000', N'2020-05-29 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'112', N'77', N'6', N'30', N'0', NULL, N'2019-11-29 15:00:00.000', N'2020-05-29 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'113', N'66', N'3', N'10', N'0', NULL, N'2019-12-01 15:00:01.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'114', N'66', N'5', N'15', N'0', NULL, N'2019-12-01 15:00:01.000', N'2020-06-01 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'115', N'66', N'1', N'222', N'0', NULL, N'2019-12-01 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'116', N'66', N'6', N'30', N'0', NULL, N'2019-12-01 15:00:01.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'117', N'66', N'2', N'0', N'0', NULL, N'2019-12-01 15:00:01.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'118', N'99', N'5', N'10', N'0', NULL, N'2019-12-02 15:00:03.000', N'2020-06-02 14:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'119', N'99', N'1', N'216', N'0', NULL, N'2019-12-02 15:00:03.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'120', N'99', N'6', N'30', N'0', NULL, N'2019-12-02 15:00:03.000', N'2020-06-02 14:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'121', N'99', N'2', N'0', N'0', NULL, N'2019-12-02 15:00:03.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'122', N'99', N'3', N'10', N'0', NULL, N'2019-12-02 15:00:03.000', N'2020-06-02 14:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'123', N'7', N'3', N'10', N'0', NULL, N'2019-12-03 15:00:01.000', N'2019-12-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'124', N'7', N'2', N'0', N'0', NULL, N'2019-12-03 15:00:01.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'125', N'7', N'1', N'216', N'0', NULL, N'2019-12-03 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'126', N'7', N'6', N'30', N'0', NULL, N'2019-12-03 15:00:01.000', N'2019-12-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'127', N'7', N'5', N'10', N'0', NULL, N'2019-12-03 15:00:01.000', N'2019-12-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'128', N'95', N'1', N'210', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'129', N'95', N'2', N'0', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'130', N'95', N'3', N'10', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'131', N'96', N'3', N'10', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'132', N'96', N'4', N'0', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'133', N'95', N'5', N'5', N'0', NULL, N'2019-12-04 15:00:00.000', N'2019-12-04 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'134', N'96', N'5', N'5', N'0', NULL, N'2019-12-04 15:00:00.000', N'2019-12-04 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'135', N'96', N'1', N'210', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'136', N'95', N'6', N'30', N'0', NULL, N'2019-12-04 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'137', N'78', N'3', N'10', N'0', NULL, N'2019-12-05 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'138', N'78', N'2', N'0', N'0', NULL, N'2019-12-05 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'139', N'78', N'1', N'210', N'0', NULL, N'2019-12-05 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'140', N'78', N'5', N'5', N'0', NULL, N'2019-12-05 15:00:00.000', N'2019-12-05 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'141', N'78', N'6', N'30', N'0', NULL, N'2019-12-05 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'142', N'10', N'1', N'210', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'143', N'79', N'1', N'210', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'144', N'10', N'2', N'0', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'145', N'79', N'2', N'0', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'146', N'10', N'3', N'10', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'147', N'79', N'3', N'10', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'148', N'10', N'5', N'5', N'0', NULL, N'2019-12-08 15:00:00.000', N'2019-12-08 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'149', N'79', N'5', N'5', N'0', NULL, N'2019-12-08 15:00:00.000', N'2019-12-08 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'150', N'10', N'6', N'30', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'151', N'79', N'6', N'30', N'0', NULL, N'2019-12-08 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'152', N'9', N'3', N'10', N'0', NULL, N'2019-12-09 15:00:00.000', N'2019-12-09 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'153', N'9', N'1', N'216', N'0', NULL, N'2019-12-09 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'154', N'9', N'4', N'0', N'0', NULL, N'2019-12-09 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'155', N'9', N'5', N'10', N'0', NULL, N'2019-12-09 15:00:00.000', N'2019-12-09 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'156', N'23', N'1', N'210', N'0', NULL, N'2019-12-11 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'157', N'106', N'1', N'216', N'0', NULL, N'2019-12-11 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'158', N'23', N'2', N'0', N'0', NULL, N'2019-12-11 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'159', N'23', N'3', N'10', N'0', NULL, N'2019-12-11 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'160', N'106', N'3', N'10', N'0', NULL, N'2019-12-11 15:00:00.000', N'2019-12-11 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'161', N'106', N'4', N'0', N'0', NULL, N'2019-12-11 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'162', N'23', N'5', N'5', N'0', NULL, N'2019-12-11 15:00:00.000', N'2019-12-11 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'163', N'106', N'5', N'10', N'0', NULL, N'2019-12-11 15:00:00.000', N'2019-12-11 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'164', N'23', N'6', N'30', N'0', NULL, N'2019-12-11 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'165', N'24', N'2', N'0', N'0', NULL, N'2019-12-13 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'166', N'24', N'3', N'10', N'0', NULL, N'2019-12-13 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'167', N'24', N'1', N'210', N'0', NULL, N'2019-12-13 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'168', N'24', N'5', N'5', N'0', NULL, N'2019-12-13 15:00:00.000', N'2019-12-13 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'169', N'24', N'6', N'30', N'0', NULL, N'2019-12-13 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'170', N'59', N'4', N'0', N'0', NULL, N'2019-12-16 15:00:02.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'171', N'59', N'3', N'10', N'0', NULL, N'2019-12-16 15:00:02.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'172', N'59', N'1', N'210', N'0', NULL, N'2019-12-16 15:00:02.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'173', N'59', N'5', N'5', N'0', NULL, N'2019-12-16 15:00:02.000', N'2019-12-16 15:00:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'174', N'28', N'3', N'10', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'175', N'112', N'2', N'0', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'176', N'28', N'2', N'0', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'177', N'112', N'3', N'10', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'178', N'28', N'1', N'210', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'179', N'112', N'1', N'210', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'180', N'28', N'5', N'5', N'0', NULL, N'2019-12-17 15:00:00.000', N'2019-12-17 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'181', N'112', N'5', N'5', N'0', NULL, N'2019-12-17 15:00:00.000', N'2019-12-17 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'182', N'28', N'6', N'30', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'183', N'112', N'6', N'30', N'0', NULL, N'2019-12-17 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'184', N'29', N'3', N'10', N'0', NULL, N'2019-12-18 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'185', N'98', N'3', N'10', N'0', NULL, N'2019-12-18 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'186', N'29', N'1', N'210', N'0', NULL, N'2019-12-18 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'187', N'98', N'1', N'210', N'0', NULL, N'2019-12-18 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'188', N'29', N'4', N'0', N'0', NULL, N'2019-12-18 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'189', N'98', N'4', N'0', N'0', NULL, N'2019-12-18 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'190', N'29', N'5', N'5', N'0', NULL, N'2019-12-18 15:00:00.000', N'2019-12-18 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'191', N'98', N'5', N'5', N'0', NULL, N'2019-12-18 15:00:00.000', N'2019-12-18 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'192', N'17', N'6', N'30', N'0', NULL, N'2019-12-28 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'193', N'17', N'3', N'10', N'0', NULL, N'2019-12-28 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'194', N'17', N'2', N'0', N'0', NULL, N'2019-12-28 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'195', N'17', N'1', N'210', N'0', NULL, N'2019-12-28 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'196', N'17', N'5', N'5', N'0', NULL, N'2019-12-28 15:00:00.000', N'2019-12-28 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'197', N'8', N'5', N'10', N'0', NULL, N'2020-01-02 15:00:00.000', N'2020-01-02 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'198', N'101', N'4', N'0', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'199', N'8', N'4', N'0', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'200', N'100', N'1', N'210', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'201', N'8', N'1', N'216', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'202', N'100', N'2', N'0', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'203', N'101', N'1', N'210', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'204', N'8', N'3', N'10', N'0', NULL, N'2020-01-02 15:00:00.000', N'2020-01-02 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'205', N'100', N'3', N'10', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'206', N'101', N'3', N'10', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'207', N'100', N'5', N'5', N'0', NULL, N'2020-01-02 15:00:00.000', N'2020-01-02 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'208', N'101', N'5', N'5', N'0', NULL, N'2020-01-02 15:00:00.000', N'2020-01-02 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'209', N'100', N'6', N'30', N'0', NULL, N'2020-01-02 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'210', N'67', N'4', N'0', N'0', NULL, N'2020-01-03 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'211', N'102', N'3', N'10', N'0', NULL, N'2020-01-03 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'212', N'87', N'3', N'10', N'0', NULL, N'2020-01-03 15:00:01.000', N'2020-01-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'213', N'67', N'1', N'216', N'0', NULL, N'2020-01-03 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'214', N'67', N'3', N'10', N'0', NULL, N'2020-01-03 15:00:01.000', N'2020-01-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'215', N'102', N'4', N'0', N'0', NULL, N'2020-01-03 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'216', N'87', N'2', N'0', N'0', NULL, N'2020-01-03 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'217', N'87', N'1', N'216', N'0', NULL, N'2020-01-03 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'218', N'102', N'1', N'210', N'0', NULL, N'2020-01-03 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'219', N'67', N'5', N'10', N'0', NULL, N'2020-01-03 15:00:01.000', N'2020-01-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'220', N'87', N'5', N'10', N'0', NULL, N'2020-01-03 15:00:01.000', N'2020-01-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'221', N'102', N'5', N'5', N'0', NULL, N'2020-01-03 15:00:01.000', N'2020-01-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'222', N'87', N'6', N'30', N'0', NULL, N'2020-01-03 15:00:01.000', N'2020-01-03 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'223', N'80', N'3', N'10', N'0', NULL, N'2020-01-05 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'224', N'80', N'1', N'210', N'0', NULL, N'2020-01-05 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'225', N'80', N'4', N'0', N'0', NULL, N'2020-01-05 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'226', N'80', N'5', N'5', N'0', NULL, N'2020-01-05 15:00:00.000', N'2020-01-05 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'227', N'81', N'1', N'210', N'0', NULL, N'2020-01-06 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'228', N'81', N'3', N'10', N'0', NULL, N'2020-01-06 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'229', N'81', N'4', N'0', N'0', NULL, N'2020-01-06 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'230', N'81', N'5', N'5', N'0', NULL, N'2020-01-06 15:00:00.000', N'2020-01-06 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'231', N'18', N'3', N'10', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'232', N'60', N'1', N'210', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'233', N'18', N'1', N'210', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'234', N'60', N'3', N'10', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'235', N'18', N'2', N'0', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'236', N'60', N'4', N'0', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'237', N'18', N'5', N'5', N'0', NULL, N'2020-01-12 15:00:00.000', N'2020-01-12 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'238', N'60', N'5', N'5', N'0', NULL, N'2020-01-12 15:00:00.000', N'2020-01-12 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'239', N'18', N'6', N'30', N'0', NULL, N'2020-01-12 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'240', N'103', N'5', N'5', N'0', NULL, N'2020-01-16 15:00:00.000', N'2020-01-16 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'241', N'103', N'4', N'0', N'0', NULL, N'2020-01-16 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'242', N'103', N'3', N'10', N'0', NULL, N'2020-01-16 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'243', N'103', N'1', N'210', N'0', NULL, N'2020-01-16 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'244', N'82', N'1', N'0', N'0', NULL, N'2020-01-17 15:00:01.000', N'2021-01-24 19:28:05.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'245', N'82', N'3', N'0', N'0', NULL, N'2020-01-17 15:00:01.000', N'2021-01-24 19:28:05.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'246', N'82', N'4', N'0', N'0', NULL, N'2020-01-17 15:00:01.000', N'2021-01-24 19:28:05.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'247', N'82', N'5', N'0', N'0', NULL, N'2020-01-17 15:00:01.000', N'2021-01-24 19:28:05.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'248', N'4', N'3', N'10', N'0', NULL, N'2020-02-01 15:00:00.000', N'2020-02-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'249', N'4', N'6', N'30', N'0', NULL, N'2020-02-01 15:00:00.000', N'2020-02-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'250', N'37', N'5', N'5', N'0', NULL, N'2020-02-01 15:00:00.000', N'2020-02-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'251', N'37', N'6', N'30', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'252', N'4', N'5', N'10', N'0', NULL, N'2020-02-01 15:00:00.000', N'2020-02-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'253', N'37', N'2', N'0', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'254', N'4', N'2', N'0', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'255', N'61', N'3', N'10', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'256', N'61', N'5', N'5', N'0', NULL, N'2020-02-01 15:00:00.000', N'2020-02-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'257', N'37', N'3', N'10', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'258', N'4', N'1', N'216', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'259', N'37', N'1', N'210', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'260', N'61', N'1', N'210', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'261', N'61', N'4', N'0', N'0', NULL, N'2020-02-01 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'262', N'25', N'1', N'216', N'0', NULL, N'2020-02-04 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'263', N'25', N'3', N'10', N'0', NULL, N'2020-02-04 15:00:00.000', N'2020-02-04 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'264', N'25', N'4', N'0', N'0', NULL, N'2020-02-04 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'265', N'25', N'5', N'10', N'0', NULL, N'2020-02-04 15:00:00.000', N'2020-02-04 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'266', N'113', N'1', N'210', N'0', NULL, N'2020-02-05 15:00:07.000', N'2021-01-25 20:52:31.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'267', N'113', N'2', N'0', N'0', NULL, N'2020-02-05 15:00:07.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'268', N'113', N'6', N'30', N'0', NULL, N'2020-02-05 15:00:07.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'269', N'113', N'5', N'5', N'0', NULL, N'2020-02-05 15:00:07.000', N'2020-02-05 15:00:07.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'270', N'113', N'3', N'10', N'0', NULL, N'2020-02-05 15:00:07.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'271', N'90', N'3', N'10', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'272', N'88', N'4', N'0', N'0', NULL, N'2020-02-12 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'273', N'89', N'4', N'0', N'0', NULL, N'2020-02-12 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'274', N'88', N'5', N'10', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'275', N'89', N'5', N'10', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'276', N'89', N'3', N'10', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'277', N'88', N'3', N'10', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'278', N'90', N'5', N'10', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'279', N'88', N'1', N'216', N'0', NULL, N'2020-02-12 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'280', N'89', N'1', N'216', N'0', NULL, N'2020-02-12 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'281', N'90', N'1', N'216', N'0', NULL, N'2020-02-12 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'282', N'90', N'2', N'0', N'0', NULL, N'2020-02-12 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'283', N'90', N'6', N'30', N'0', NULL, N'2020-02-12 15:00:01.000', N'2020-02-12 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'284', N'83', N'4', N'0', N'0', NULL, N'2020-02-14 15:00:05.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'285', N'83', N'3', N'10', N'0', NULL, N'2020-02-14 15:00:05.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'286', N'83', N'5', N'5', N'0', NULL, N'2020-02-14 15:00:05.000', N'2020-02-14 15:00:05.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'287', N'83', N'1', N'210', N'0', NULL, N'2020-02-14 15:00:05.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'288', N'107', N'3', N'10', N'0', NULL, N'2020-02-20 15:00:00.000', N'2020-02-20 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'289', N'107', N'1', N'216', N'0', NULL, N'2020-02-20 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'290', N'107', N'2', N'0', N'0', NULL, N'2020-02-20 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'291', N'107', N'5', N'10', N'0', NULL, N'2020-02-20 15:00:00.000', N'2020-02-20 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'292', N'107', N'6', N'30', N'0', NULL, N'2020-02-20 15:00:00.000', N'2020-02-20 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'293', N'84', N'2', N'0', N'0', NULL, N'2020-02-22 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'294', N'84', N'6', N'30', N'0', NULL, N'2020-02-22 15:00:01.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'295', N'84', N'3', N'10', N'0', NULL, N'2020-02-22 15:00:01.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'296', N'84', N'5', N'5', N'0', NULL, N'2020-02-22 15:00:01.000', N'2020-02-22 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'297', N'84', N'1', N'210', N'0', NULL, N'2020-02-22 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'298', N'30', N'1', N'216', N'0', NULL, N'2020-02-24 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'299', N'30', N'4', N'0', N'0', NULL, N'2020-02-24 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'300', N'30', N'3', N'10', N'0', NULL, N'2020-02-24 15:00:01.000', N'2020-02-24 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'301', N'30', N'5', N'10', N'0', NULL, N'2020-02-24 15:00:01.000', N'2020-02-24 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'302', N'26', N'5', N'10', N'0', NULL, N'2020-02-26 15:00:01.000', N'2020-02-26 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'303', N'26', N'4', N'0', N'0', NULL, N'2020-02-26 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'304', N'26', N'1', N'216', N'0', NULL, N'2020-02-26 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'305', N'26', N'3', N'10', N'0', NULL, N'2020-02-26 15:00:01.000', N'2020-02-26 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'306', N'68', N'3', N'10', N'0', NULL, N'2020-03-01 15:00:00.000', N'2020-03-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'307', N'68', N'4', N'0', N'0', NULL, N'2020-03-01 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'308', N'68', N'5', N'10', N'0', NULL, N'2020-03-01 15:00:00.000', N'2020-03-01 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'309', N'68', N'1', N'216', N'0', NULL, N'2020-03-01 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'310', N'31', N'1', N'216', N'0', NULL, N'2020-03-03 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'311', N'31', N'3', N'10', N'0', NULL, N'2020-03-03 15:00:00.000', N'2020-03-03 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'312', N'114', N'3', N'10', N'0', NULL, N'2020-03-03 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'313', N'114', N'1', N'210', N'0', NULL, N'2020-03-03 15:00:00.000', N'2021-01-25 20:52:31.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'314', N'114', N'2', N'0', N'0', NULL, N'2020-03-03 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'315', N'31', N'5', N'10', N'0', NULL, N'2020-03-03 15:00:00.000', N'2020-03-03 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'316', N'31', N'4', N'0', N'0', NULL, N'2020-03-03 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'317', N'114', N'5', N'5', N'0', NULL, N'2020-03-03 15:00:00.000', N'2020-03-03 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'318', N'114', N'6', N'30', N'0', NULL, N'2020-03-03 15:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'319', N'21', N'1', N'216', N'0', NULL, N'2020-03-05 15:00:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'320', N'21', N'5', N'10', N'0', NULL, N'2020-03-05 15:00:01.000', N'2020-03-05 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'321', N'21', N'4', N'0', N'0', NULL, N'2020-03-05 15:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'322', N'21', N'3', N'10', N'0', NULL, N'2020-03-05 15:00:01.000', N'2020-03-05 15:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'323', N'69', N'1', N'216', N'0', NULL, N'2020-03-06 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'324', N'85', N'1', N'210', N'0', NULL, N'2020-03-06 15:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'325', N'69', N'2', N'0', N'0', NULL, N'2020-03-06 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'326', N'85', N'3', N'10', N'0', NULL, N'2020-03-06 15:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'327', N'69', N'3', N'10', N'0', NULL, N'2020-03-06 15:00:00.000', N'2020-03-06 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'328', N'69', N'5', N'10', N'0', NULL, N'2020-03-06 15:00:00.000', N'2020-03-06 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'329', N'85', N'4', N'0', N'0', NULL, N'2020-03-06 15:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'330', N'85', N'5', N'5', N'0', NULL, N'2020-03-06 15:00:00.000', N'2020-03-06 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'331', N'69', N'6', N'30', N'0', NULL, N'2020-03-06 15:00:00.000', N'2020-03-06 15:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'332', N'62', N'5', N'5', N'0', NULL, N'2020-03-13 14:00:00.000', N'2020-03-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'333', N'70', N'4', N'0', N'0', NULL, N'2020-03-13 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'334', N'62', N'3', N'10', N'0', NULL, N'2020-03-13 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'335', N'70', N'1', N'216', N'0', NULL, N'2020-03-13 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'336', N'70', N'3', N'10', N'0', NULL, N'2020-03-13 14:00:00.000', N'2020-03-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'337', N'62', N'1', N'210', N'0', NULL, N'2020-03-13 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'338', N'70', N'5', N'10', N'0', NULL, N'2020-03-13 14:00:00.000', N'2020-03-13 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'339', N'62', N'4', N'0', N'0', NULL, N'2020-03-13 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'340', N'63', N'3', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'341', N'48', N'2', N'0', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'342', N'49', N'2', N'0', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'343', N'50', N'3', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'344', N'49', N'3', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'345', N'48', N'3', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'346', N'63', N'1', N'210', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'347', N'50', N'1', N'216', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'348', N'49', N'1', N'216', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'349', N'48', N'1', N'216', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'350', N'63', N'2', N'0', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'351', N'50', N'4', N'0', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'352', N'48', N'5', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'353', N'49', N'5', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'354', N'50', N'5', N'10', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'355', N'63', N'5', N'5', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'356', N'48', N'6', N'30', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'357', N'49', N'6', N'30', N'0', NULL, N'2020-03-16 14:00:00.000', N'2020-03-16 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'358', N'63', N'6', N'30', N'0', NULL, N'2020-03-16 14:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'359', N'44', N'6', N'30', N'0', NULL, N'2020-03-18 14:00:00.000', N'2020-03-18 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'360', N'44', N'5', N'10', N'0', NULL, N'2020-03-18 14:00:00.000', N'2020-03-18 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'361', N'44', N'3', N'10', N'0', NULL, N'2020-03-18 14:00:00.000', N'2020-03-18 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'362', N'44', N'1', N'216', N'0', NULL, N'2020-03-18 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'363', N'44', N'2', N'0', N'0', NULL, N'2020-03-18 14:00:00.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'364', N'71', N'6', N'30', N'0', NULL, N'2020-05-11 14:00:00.000', N'2021-01-24 21:33:17.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'365', N'71', N'1', N'210', N'0', NULL, N'2020-05-11 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'366', N'71', N'2', N'0', N'0', NULL, N'2020-05-11 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'367', N'71', N'3', N'10', N'0', NULL, N'2020-05-11 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'368', N'71', N'5', N'5', N'0', NULL, N'2020-05-11 14:00:00.000', N'2020-05-11 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'369', N'74', N'1', N'210', N'0', NULL, N'2020-05-18 14:00:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'370', N'74', N'3', N'10', N'0', NULL, N'2020-05-18 14:00:00.000', N'2021-01-24 21:33:16.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'371', N'74', N'4', N'0', N'0', NULL, N'2020-05-18 14:00:00.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'372', N'74', N'5', N'5', N'0', NULL, N'2020-05-18 14:00:00.000', N'2020-05-18 14:00:00.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'373', N'118', N'1', N'216', N'0', NULL, N'2020-06-02 14:00:01.000', N'2021-01-25 20:52:31.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'374', N'118', N'4', N'0', N'0', NULL, N'2020-06-02 14:00:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'375', N'118', N'5', N'10', N'0', NULL, N'2020-06-02 14:00:01.000', N'2020-06-02 14:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'376', N'118', N'3', N'10', N'0', NULL, N'2020-06-02 14:00:01.000', N'2020-06-02 14:00:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'377', N'6', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'378', N'13', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'379', N'11', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'380', N'14', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'381', N'3', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'382', N'12', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'383', N'22', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'384', N'27', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:00.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'385', N'40', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'386', N'38', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'387', N'43', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'388', N'45', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'389', N'46', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'390', N'51', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'391', N'52', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'392', N'53', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'393', N'64', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'394', N'72', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'395', N'73', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'396', N'76', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'397', N'75', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'398', N'86', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'399', N'91', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'400', N'93', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'401', N'92', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'402', N'94', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'403', N'97', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'404', N'104', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'405', N'108', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'406', N'105', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'407', N'109', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:30.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'408', N'115', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:31.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'409', N'116', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:31.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'410', N'117', N'1', N'192', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:52:31.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'411', N'11', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'412', N'12', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'413', N'45', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'414', N'52', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'415', N'86', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'416', N'97', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'417', N'109', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'418', N'105', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'419', N'115', N'2', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'420', N'3', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'421', N'6', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'422', N'11', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'423', N'13', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'424', N'14', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'425', N'12', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'426', N'22', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'427', N'27', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'428', N'38', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'429', N'40', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'430', N'43', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'431', N'45', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'432', N'46', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'433', N'51', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'434', N'52', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'435', N'53', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'436', N'64', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'437', N'72', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'438', N'73', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'439', N'76', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'440', N'75', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'441', N'86', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'442', N'91', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'443', N'92', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'444', N'94', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'445', N'93', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'446', N'97', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'447', N'104', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'448', N'105', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'449', N'108', N'3', N'5', N'5', NULL, N'2021-01-24 21:37:01.000', N'2021-02-02 20:20:32.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'450', N'109', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'451', N'115', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'452', N'116', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'453', N'117', N'3', N'10', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'454', N'3', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'455', N'14', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'456', N'6', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'457', N'13', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'458', N'22', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'459', N'27', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'460', N'38', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'461', N'40', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'462', N'43', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'463', N'46', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'464', N'51', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'465', N'53', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'466', N'64', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'467', N'72', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'468', N'73', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'469', N'75', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'470', N'76', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'471', N'91', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'472', N'92', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'473', N'93', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'474', N'94', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'475', N'104', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'476', N'116', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'477', N'108', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'478', N'117', N'4', N'0', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-25 20:50:02.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'479', N'11', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'480', N'12', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'481', N'45', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'482', N'52', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'483', N'86', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'484', N'97', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'485', N'105', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'486', N'109', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

INSERT INTO [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (N'487', N'115', N'6', N'30', N'0', NULL, N'2021-01-24 21:37:01.000', N'2021-01-24 21:37:01.000')
GO

SET IDENTITY_INSERT [dbo].[leave_credit_policy] OFF
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
-- Records of leave_policy
-- ----------------------------
SET IDENTITY_INSERT [dbo].[leave_policy] ON
GO

INSERT INTO [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at], [code]) VALUES (N'1', N'Vacation Leave', N'12', N'', N'6', N'6', N'6', N'1', N'15', N'1', NULL, NULL, N'We have a Gitter chat room set up where you can talk directly with us.', N'1', N'2019-08-03 05:14:14.000', N'2021-01-24 21:27:24.000', N'VL')
GO

INSERT INTO [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at], [code]) VALUES (N'2', N'Maternity Leave', N'105', N'Female', N'0', N'5', N'6', N'0', N'0', N'1', NULL, NULL, NULL, N'0', N'2019-08-03 05:36:53.000', N'2019-09-18 00:23:27.000', N'ML')
GO

INSERT INTO [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at], [code]) VALUES (N'3', N'Sick Leave', N'10', N'', N'6', N'5', N'6', N'1', N'10', N'1', NULL, NULL, NULL, N'0', N'2019-08-03 05:37:17.000', N'2019-09-18 00:23:27.000', N'SL')
GO

INSERT INTO [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at], [code]) VALUES (N'4', N'Paternity Leave', N'14', N'Male', N'0', N'5', N'6', N'0', N'0', N'1', NULL, NULL, NULL, N'0', N'2019-08-03 05:37:56.000', N'2019-09-18 00:23:28.000', N'PL')
GO

INSERT INTO [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at], [code]) VALUES (N'5', N'Emergency Leave', N'10', N'', N'6', N'5', N'6', N'0', N'0', N'0', NULL, NULL, NULL, N'0', N'2019-08-04 11:21:00.000', N'2021-01-18 20:19:05.000', N'EL')
GO

INSERT INTO [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at], [code]) VALUES (N'6', N'Miscarriage', N'30', N'Female', N'0', N'6', N'6', N'0', N'0', N'1', NULL, NULL, NULL, N'0', N'2019-08-06 03:42:02.000', N'2019-09-18 01:05:40.000', N'MC')
GO

SET IDENTITY_INSERT [dbo].[leave_policy] OFF
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
-- Records of leaves
-- ----------------------------
SET IDENTITY_INSERT [dbo].[leaves] ON
GO

INSERT INTO [dbo].[leaves] ([id], [user_id], [dates], [start_date], [end_date], [leave_type], [other], [no_of_days], [credit], [reason], [attachment], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [is_hr], [created_by], [updated_by], [created_at], [updated_at], [proccessed]) VALUES (N'41', N'119', NULL, N'2021-09-25', N'2021-09-25', N'1', N'', N'1', N'1', N'null', NULL, N'2', N'1', N'1', N'1', NULL, N'2d259186-4a5a-4c81-aefa-ea46411cd3ee', NULL, N'0', N'0', N'2021-09-26 00:11:51.800', N'2021-09-26 00:11:51.800', N'0')
GO

SET IDENTITY_INSERT [dbo].[leaves] OFF
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
-- Records of leaves_date
-- ----------------------------
SET IDENTITY_INSERT [dbo].[leaves_date] ON
GO

INSERT INTO [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (N'121', N'41', N'119', N'2021-09-25', N'1')
GO

SET IDENTITY_INSERT [dbo].[leaves_date] OFF
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
-- Records of loan
-- ----------------------------
SET IDENTITY_INSERT [dbo].[loan] ON
GO

INSERT INTO [dbo].[loan] ([id], [user_id], [amount], [label], [mode_of_payment], [date_to_pay], [frequency], [status], [note], [year], [month], [period], [created_at], [updated_at], [loan_type]) VALUES (N'1', N'2', N'5000', N'Test loan', N'0', N'2020-06-16', N'2', N'1', NULL, N'2020', N'12', N'A', N'2020-06-01 21:44:11.000', N'2020-12-13 21:03:18.000', N'2')
GO

INSERT INTO [dbo].[loan] ([id], [user_id], [amount], [label], [mode_of_payment], [date_to_pay], [frequency], [status], [note], [year], [month], [period], [created_at], [updated_at], [loan_type]) VALUES (N'2', N'2', N'5000', N'Test loan 2', N'1', N'2020-06-30', N'4', N'1', NULL, N'2020', N'12', N'A', N'2020-06-02 13:27:03.000', N'2020-12-13 21:03:13.000', N'1')
GO

SET IDENTITY_INSERT [dbo].[loan] OFF
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
-- Records of loan_payments
-- ----------------------------
SET IDENTITY_INSERT [dbo].[loan_payments] ON
GO

INSERT INTO [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (N'1', N'2', N'2', N'2021', N'01', N'A', N'1250', N'0')
GO

INSERT INTO [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (N'2', N'2', N'2', N'2020', N'12', N'B', N'1250', N'0')
GO

INSERT INTO [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (N'3', N'2', N'2', N'2020', N'12', N'A', N'1250', N'0')
GO

INSERT INTO [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (N'4', N'2', N'2', N'2021', N'01', N'B', N'1250', N'0')
GO

INSERT INTO [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (N'5', N'1', N'2', N'2020', N'12', N'A', N'2500', N'0')
GO

INSERT INTO [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (N'6', N'1', N'2', N'2020', N'12', N'B', N'2500', N'0')
GO

SET IDENTITY_INSERT [dbo].[loan_payments] OFF
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
-- Records of locations
-- ----------------------------
SET IDENTITY_INSERT [dbo].[locations] ON
GO

INSERT INTO [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (N'1', N'Davao', N'2021-06-11 00:19:40.000', NULL)
GO

INSERT INTO [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (N'2', N'Padigusan', N'2021-06-11 00:19:45.000', NULL)
GO

INSERT INTO [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (N'3', N'Mine', N'2021-06-11 00:19:49.000', NULL)
GO

INSERT INTO [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (N'4', N'Mill', N'2021-06-11 00:19:50.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[locations] OFF
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
-- Records of logs
-- ----------------------------
SET IDENTITY_INSERT [dbo].[logs] ON
GO

SET IDENTITY_INSERT [dbo].[logs] OFF
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
-- Records of modules
-- ----------------------------
SET IDENTITY_INSERT [dbo].[modules] ON
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'1', N'Recruitment : Candidate Profile', N'recruitment-candidate-profile', N'1', N'2019-07-04 02:16:52.000', N'2019-08-01 04:53:15.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'2', N'Recruitment : Schedule', N'recruitment-schedule', N'1', N'2019-07-04 02:17:21.000', N'2019-08-01 04:53:25.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'3', N'Recruitment : Ratings', N'recruitment-rating', N'1', N'2019-07-04 02:17:37.000', N'2019-08-01 04:53:30.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'4', N'Recruitment : Joining', N'recruitment-joining', N'1', N'2019-07-04 02:17:44.000', N'2019-08-01 04:53:35.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'7', N'Approval : Shifts', N'approvals-shift', N'1', N'2019-07-04 02:18:56.000', N'2019-08-01 04:53:52.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'8', N'Approval : Leave', N'approvals-leave', N'1', N'2019-07-04 02:19:03.000', N'2019-08-01 04:53:56.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'9', N'Approval : Overtime', N'approvals-overtime', N'1', N'2019-07-04 02:19:12.000', N'2019-08-01 04:54:01.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'10', N'Approval : Undertime', N'approvals-undertime', N'1', N'2019-07-04 02:19:24.000', N'2019-08-01 04:54:05.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'11', N'Approval : Business Trip', N'approvals-business-trip', N'1', N'2019-07-04 02:19:35.000', N'2019-08-01 04:54:11.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'12', N'Forms : Shift', N'forms-shift', N'1', N'2019-07-04 02:19:47.000', N'2019-08-01 04:54:20.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'13', N'Forms : Leave', N'forms-leave', N'1', N'2019-07-04 02:19:52.000', N'2019-08-01 04:54:25.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'14', N'Forms : Overtime', N'forms-overtime', N'1', N'2019-07-04 02:19:58.000', N'2019-08-01 04:54:29.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'15', N'Forms : Undertime', N'forms-undertime', N'1', N'2019-07-04 02:20:03.000', N'2019-08-01 04:54:34.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'16', N'Forms : Business Trip', N'forms-business-trip', N'1', N'2019-07-04 02:20:11.000', N'2019-08-01 04:54:41.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'17', N'Settings : Company', N'settings-company', N'1', N'2019-07-04 02:20:28.000', N'2019-08-01 04:54:52.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'18', N'Settings : Branch', N'settings-branch', N'1', N'2019-07-04 02:20:37.000', N'2019-08-01 04:54:56.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'19', N'Settings : Approvers', N'settings-approvers', N'1', N'2019-07-04 02:20:54.000', N'2019-08-01 04:55:01.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'20', N'Settings : Taxonomy', N'settings-taxonomy', N'1', N'2019-07-04 02:21:01.000', N'2019-08-01 04:55:06.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'21', N'Settings : Holidays', N'settings-holidays', N'1', N'2019-07-04 02:21:11.000', N'2019-08-01 04:55:10.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'22', N'Settings : Biometric', N'settings-biometric', N'1', N'2019-07-04 02:21:20.000', N'2019-08-01 04:55:15.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'23', N'Settings : Role', N'settings-role', N'1', N'2019-07-04 02:21:33.000', N'2019-08-01 04:55:18.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'24', N'Employee : Lists', N'employee-list', N'1', N'2019-08-01 04:49:20.000', N'2019-08-06 06:23:23.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'25', N'Employee : Detail', N'employee-detail', N'1', N'2019-08-01 04:49:52.000', N'2019-08-06 06:23:28.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'26', N'Employee : Attendance', N'employee-attendance', N'1', N'2019-08-01 04:50:22.000', N'2019-08-06 06:23:32.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'27', N'Employee : Salary', N'employee-salary', N'1', N'2019-08-01 04:50:37.000', N'2019-08-06 06:23:37.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'28', N'Employee : Loan', N'employee-loan', N'1', N'2019-08-01 04:50:47.000', N'2019-08-06 06:23:40.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'29', N'Employee : Documents', N'employee-document', N'1', N'2019-08-01 04:51:02.000', N'2019-08-06 06:23:44.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'30', N'Employee : Shifts', N'employee-shift', N'1', N'2019-08-01 04:51:20.000', N'2019-08-06 06:23:49.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'31', N'Employee : Leave', N'employee-leave', N'1', N'2019-08-01 04:51:49.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'32', N'Employee : Overtime', N'employee-overtime', N'1', N'2019-08-01 04:52:04.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'33', N'Employee : Undertime', N'employee-undertime', N'1', N'2019-08-01 04:52:19.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'34', N'Employee : Business Trip', N'employee-business-trip', N'1', N'2019-08-01 04:52:44.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'35', N'Employee : Dispute', N'employee-dispute', N'1', N'2019-08-01 04:52:57.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'36', N'Forms : Dispute', N'forms-dispute', N'1', N'2019-08-01 04:55:35.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'37', N'Attendance : Shift Management', N'attendance-shift', N'1', N'2019-08-01 04:56:09.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'38', N'Attendance : Biometric Integration', N'attendance-biometric', N'1', N'2019-08-01 04:56:36.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'39', N'Attendance : Leave Management', N'attendance-leave', N'1', N'2019-08-01 04:56:57.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'40', N'Attendance : Overtime Management', N'attendance-overtime', N'1', N'2019-08-01 04:57:15.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'41', N'Attendance : Absence Management', N'attendance-absence', N'1', N'2019-08-01 04:57:40.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'42', N'Payment : Dispute', N'payment-dispute', N'1', N'2019-08-01 04:58:21.000', N'2019-09-11 23:10:58.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'43', N'Payment : Loan/ Cash Advance', N'payment-loan', N'1', N'2019-08-01 04:58:40.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'44', N'Payment : Bulk Salary Creation', N'payment-salary', N'1', N'2019-08-01 04:59:10.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'45', N'Payment : Salary Adjustment', N'payment-adjustment', N'1', N'2019-08-01 04:59:36.000', N'2019-09-11 21:01:50.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'46', N'Payment : Final Settlement', N'payment-settlement', N'1', N'2019-08-01 04:59:54.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'47', N'Reliving : Resignation/ Retirement', N'reliving-resignation', N'1', N'2019-08-01 05:00:34.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'48', N'Reliving : Exit Interview', N'reliving-interview', N'1', N'2019-08-01 05:00:50.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'49', N'Reliving : Formalities', N'reliving-formality', N'1', N'2019-08-01 05:01:06.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'50', N'Appraisal : Initiation', N'appraisal-initiation', N'0', N'2019-08-01 05:01:48.000', N'2019-09-17 04:16:59.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'51', N'Appraisal : Feedback', N'appraisal-feedback', N'0', N'2019-08-01 05:02:05.000', N'2019-09-17 04:17:01.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'52', N'Appraisal : Consolidation', N'appraisal-consolidation', N'0', N'2019-08-01 05:02:30.000', N'2019-09-17 04:17:03.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'53', N'Appraisal : Promotion', N'appraisal-promotion', N'0', N'2019-08-01 05:02:46.000', N'2019-09-17 04:17:05.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'54', N'Appraisal : Transfer', N'appraisal-transfer', N'0', N'2019-08-01 05:03:02.000', N'2019-09-17 04:17:05.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'55', N'Employee : Config', N'employee-config', N'1', N'2019-08-02 05:29:29.000', N'2019-08-14 22:29:10.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'56', N'Settings : Configuration', N'settings-configuration', N'1', N'2019-08-02 06:27:06.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'57', N'Appraisal : Increment', N'appraisal-increment', N'0', N'2019-08-03 00:42:11.000', N'2019-09-17 04:17:20.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'58', N'Settings : Leave Policy', N'settings-leave-policy', N'1', N'2019-08-03 04:24:56.000', N'2019-08-03 04:25:07.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'59', N'Employee : Leave Credit', N'employee-leave-credit', N'1', N'2019-08-06 06:24:14.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'61', N'Employee : Role', N'employee-role', N'1', N'2019-08-16 22:18:35.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'62', N'Announcement', N'announcement', N'1', N'2019-08-18 00:08:26.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'63', N'Attendance : Summary', N'attendance-summary', N'1', N'2019-08-28 05:38:38.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'64', N'Approvals : Dispute', N'approvals-dispute', N'1', N'2019-09-12 00:56:24.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'65', N'CRM - Accounts', N'accounts', N'1', N'2019-09-25 00:32:18.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'66', N'Settings : Branding', N'settings-branding', N'1', N'2020-02-20 12:54:13.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'67', N'Custom Leave', N'custom-leave', N'1', N'2021-02-01 20:23:21.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'68', N'Payment : Payroll', N'payment-payroll', N'1', N'2021-05-05 10:49:47.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'69', N'Settings : Division', N'settings-division', N'1', N'2021-06-11 00:42:05.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'70', N'Settings : Department', N'settings-department', N'1', N'2021-06-14 16:58:44.000', N'2021-06-14 16:58:51.000')
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'71', N'Settings : Section', N'settings-section', N'1', N'2021-06-14 20:13:10.000', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'72', N'Attendance : Undertime', N'attendance-undertime', N'1', N'2021-09-18 11:37:41.217', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'73', N'Forms : Change Shift', N'forms-change-shift', N'1', N'2021-09-19 12:19:25.630', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'74', N'Approval : Change Shift', N'approvals-change-shift', N'1', N'2021-09-20 09:21:23.973', NULL)
GO

INSERT INTO [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (N'75', N'Attendance : TSS', N'attendance-tss', N'1', N'2021-09-26 16:40:27.757', NULL)
GO

SET IDENTITY_INSERT [dbo].[modules] OFF
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
-- Records of notification
-- ----------------------------
SET IDENTITY_INSERT [dbo].[notification] ON
GO

SET IDENTITY_INSERT [dbo].[notification] OFF
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
-- Records of notification_receiver
-- ----------------------------
SET IDENTITY_INSERT [dbo].[notification_receiver] ON
GO

SET IDENTITY_INSERT [dbo].[notification_receiver] OFF
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
  [type] int DEFAULT 1 NULL,
  [start_date] date DEFAULT NULL NULL,
  [end_date] date DEFAULT NULL NULL,
  [start_time] time(7) DEFAULT NULL NULL,
  [end_time] time(7) DEFAULT NULL NULL,
  [actual_check_in] time(7) DEFAULT NULL NULL,
  [actual_check_out] time(7) DEFAULT NULL NULL,
  [no_of_hours] int  NULL,
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
-- Records of overtimes
-- ----------------------------
SET IDENTITY_INSERT [dbo].[overtimes] ON
GO

INSERT INTO [dbo].[overtimes] ([id], [user_id], [type], [start_date], [end_date], [start_time], [end_time], [actual_check_in], [actual_check_out], [no_of_hours], [purpose], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [created_at], [updated_at]) VALUES (N'20', N'1', N'1', N'2021-09-23', N'2021-09-23', N'17:00:00.0000000', N'23:00:00.0000000', NULL, N'23:09:08.0000000', N'2', NULL, N'2', N'1', N'1', NULL, NULL, N'e6b67b21-a929-4733-b25a-6ade996935c2', N'2021-09-22 11:12:26.563', N'2021-09-22 11:12:26.563')
GO

INSERT INTO [dbo].[overtimes] ([id], [user_id], [type], [start_date], [end_date], [start_time], [end_time], [actual_check_in], [actual_check_out], [no_of_hours], [purpose], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [created_at], [updated_at]) VALUES (N'25', N'1', N'1', N'2021-09-26', N'2021-09-26', N'08:00:00.0000000', N'17:00:00.0000000', N'07:10:05.0000000', N'17:10:46.0000000', NULL, NULL, N'2', NULL, NULL, NULL, NULL, NULL, N'2021-09-27 20:42:21.327', NULL)
GO

SET IDENTITY_INSERT [dbo].[overtimes] OFF
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
-- Records of payroll
-- ----------------------------
SET IDENTITY_INSERT [dbo].[payroll] ON
GO

SET IDENTITY_INSERT [dbo].[payroll] OFF
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
-- Records of payroll_group
-- ----------------------------
SET IDENTITY_INSERT [dbo].[payroll_group] ON
GO

INSERT INTO [dbo].[payroll_group] ([id], [name], [company_location_id], [department_id], [status]) VALUES (N'2', N'Default', N'1', N'0', N'1')
GO

SET IDENTITY_INSERT [dbo].[payroll_group] OFF
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
-- Records of payroll_period
-- ----------------------------
SET IDENTITY_INSERT [dbo].[payroll_period] ON
GO

INSERT INTO [dbo].[payroll_period] ([id], [payroll_group_id], [period], [payroll_day], [payroll_day_from], [payroll_day_to], [created_at], [updated_at]) VALUES (N'1', N'2', N'B', N'30', N'6', N'20', N'2019-08-07 05:35:44.000', N'2019-08-07 06:15:09.000')
GO

INSERT INTO [dbo].[payroll_period] ([id], [payroll_group_id], [period], [payroll_day], [payroll_day_from], [payroll_day_to], [created_at], [updated_at]) VALUES (N'2', N'2', N'A', N'15', N'21', N'6', N'2019-08-07 05:35:44.000', N'2019-08-07 06:15:20.000')
GO

SET IDENTITY_INSERT [dbo].[payroll_period] OFF
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
-- Records of payslips
-- ----------------------------
SET IDENTITY_INSERT [dbo].[payslips] ON
GO

SET IDENTITY_INSERT [dbo].[payslips] OFF
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
-- Records of positions
-- ----------------------------
SET IDENTITY_INSERT [dbo].[positions] ON
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'2', N'ADMINISTRATION OFFICE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'3', N'ADMINISTRATION DIVISION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'4', N'DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'5', N'SECRETARY', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'6', N'WEIGHBRIDGE TENDER LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'7', N'WEIGHBRIDGE TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'8', N'HUMAN RESOURCES DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'9', N'HUMAN RESOURCES MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'10', N'HUMAN RESOURCES ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'11', N'HUMAN RESOURCES SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'12', N'HUMAN RESOURCES ASSOCIATE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'13', N'HUMAN RESOURCES ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'14', N'ACCOUNTING  DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'15', N'SITE ACCOUNTING MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'16', N'MANAGEMENT ACCOUNTING SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'17', N'GENERAL ACCOUNTING SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'18', N'MANAGEMENT ACCOUNTING ASSISTANT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'19', N'GENERAL ACCOUNTING ASSISTANT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'20', N'CASHIER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'21', N'GENERAL ACCOUNTING ASSOCIATE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'22', N'ASSISTANT CASHIER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'23', N'MANAGEMENT ACCOUNTING STAF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'24', N'GENERAL ACCOUNTING STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'25', N'CASHIER STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'26', N'CLERK', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'27', N' GENERAL SERVICES DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'28', N'GENERAL SERVICES DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'29', N'GENERAL SERVICES DEPARTMENT ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'30', N'GENERAL SERVICES DEPARTMENT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'31', N'DIETICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'32', N'CAMP MAINTENANCE AND HOUSEKEEPING LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'33', N'CARPOOL DISPATCHING LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'34', N'MESS OPERATION LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'35', N'FURNITURE SHOP LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'36', N'CARPENTER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'37', N'PAINTER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'38', N'PLUMBER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'39', N'FURNITURE SHOP CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'40', N'COOK', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'41', N'COMISSARY QUALITY CONTROLLER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'42', N'PROPERTY CUSTODIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'43', N'VEHICLE CUSTODIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'44', N'HOUSEKEEPING STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'45', N'CAMP MAINTENANCE CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'46', N'KITCHEN AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'47', N'LAUNDRY STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'48', N'WATER TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'49', N'ICT DEPARTMETNT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'50', N'INFORMATION AND COMMUNICATION TECHNOLOGY MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'51', N'INFORMATION AND COMMUNICATION  ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'52', N'APPLICATION AND DATABASE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'53', N'SYSTEM AND NETWORK SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'54', N'IT OPERATIONS SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'55', N'ADMINISTRATIVE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'56', N'PROJECT OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'57', N'INSTRUMENTATION AND COMMUNICATIONS ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'58', N'APPLICATION AND DATABASE ASSISTANT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'59', N'SYSTEM AND NETWORK ASSISTANT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'60', N'HELPDESK ASSISTANT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'61', N'MAINTENANCE ASSISTANT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'62', N'SYSTEM/BUSINESS ANALYST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'63', N'DATABASE/APPLICATION DEVELOPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'64', N'IT RISK/SECURITY ADMINISTRATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'65', N'SYSTEM AND DATABASE ADMINISTRATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'66', N'NETWORK ADMINISTRATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'67', N'COMPLIANCE AND GOVERNANCE OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'68', N'QUALITY ASSURANCE/QUALITY CONTROL OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'69', N'SYSTEM TEST OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'70', N'TECHNICAL DOCUMENT WRITER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'71', N'HELPDESK STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'72', N'MAINTENANCE TEAM LEADER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'73', N'TECHNICAL SUPPORT STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'74', N'ADMINISTRATIVE ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'75', N'MEDICAL DEPARTMETNT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'76', N'MEDICAL DIRECTOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'77', N'CHIEF OF CLINICS', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'78', N'COMPANY PHYSICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'79', N'PATHOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'80', N'RADIOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'81', N'HOSPITAL ADMINISTRATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'82', N'DENTIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'83', N'CHIEF NURSE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'84', N'HOSPITAL ADMINISTRATOR SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'85', N'SENIOR NURSE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'86', N'CHIEF MEDICAL TECHNOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'87', N'CHIEF PHARMACIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'88', N'MEDICAL RECORDS OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'89', N'MEDICAL TECHNOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'90', N'NURSE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'91', N'PHARMACIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'92', N'RADIOLOGIC TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'93', N'NUTRITIONIST/DIETICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'94', N'EMERGENCY MEDICAL TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'95', N'SUPPLY OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'96', N'MIDWIFE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'97', N'RADIOLOGIC TECHNICIAN ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'98', N'AMBULANCE DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'99', N'MEDICAL RECORDS ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'100', N'CASHIERING AND BILLING IN-CHARGE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'101', N'MAINTENANCE STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'102', N'LABORATORY AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'103', N'NURSING AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'104', N'PHARMACY AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'105', N'PHILHEALTH CLERK', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'106', N'MEDICAL RECORDS FILING CLERK', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'107', N'STOREKEEPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'108', N'ENCODER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'109', N'DENTAL AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'110', N'UTILITY', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'111', N'MATERIALS CONTROL DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'112', N'MATERIALS CONTROL DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'113', N'LOGISTICS OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'114', N'MATERIALS CONTROL DEPARTMENT ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'115', N'LOGISTICS SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'116', N'WAREHOUSE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'117', N'PURCHASING SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'118', N'MATERIALS PLANNING SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'119', N'WAREHOUSE LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'120', N'LOGISTICS LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'121', N'INVENTORY ANALYST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'122', N'PURCHASING AND LOGISTICS ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'123', N'CANVASSER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'124', N'WAREHOUSE CHECKER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'125', N'WAREHOUSE MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'126', N'RECORDS LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'127', N'PURCHASING ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'128', N'MATERIALS PLANNER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'129', N'FORKLIFT OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'130', N'WAREHOUSE HELPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'131', N'TRUCK HELPER ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'132', N'SECURITY DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'133', N'SECURITY MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'134', N'EXECUTIVE OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'135', N'SECURITY ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'136', N'SENIOR SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'137', N'SITE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'138', N'UNDEGROUND PATROLLER SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'139', N'SHIFT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'140', N'GOLD ROOM SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'141', N'ROAD MONITORING SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'142', N'SECTOR SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'143', N'TRAINING/OPERATION/RESEARCH SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'144', N'UNDERGROUND PATROLLER TEAM LEADER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'145', N'SHIFT IN CHARGE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'146', N'RESEARCH ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'147', N'INVESTIGATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'148', N'K9 TEAM LEADER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'149', N'K9 HANDLER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'150', N'CCTV OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'151', N'RADIO OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'152', N'LOG ASSISTANT/VERIFIER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'153', N'ID FABRICATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'154', N'OPERATIONS/TRAINING CLERK', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'155', N'OPERATIONS/TRAINING ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'156', N'CASE CUSTODIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'157', N'ALERT TEAM DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'158', N'ALERT TEAM MEMBER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'159', N'COMPANY GUARD ON POST ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'160', N'GOLD ROOM GUARD', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'161', N'ROAD MONITORING GUARD', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'162', N'INSPECTION TEAM MEMBER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'163', N'EXPLORATION DIVISION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'164', N'CHIEF GEOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'165', N'SENIOR GEOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'166', N'PROJECT GEOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'167', N'GEOGRAPHIC INFORMATION SYSTEM MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'168', N'GEODETIC ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'169', N'GEOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'170', N'CORE FARM SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'171', N'SENIOR MAPPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'172', N'GEOGRAPHIC INFORMATION SYSTEM DATABASE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'173', N'GEOGRAPHIC INFORMATION SYSTEM SPECIALIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'174', N'CORE FARM MAINTENANCE STAFF', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'175', N'ELECTRICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'176', N'EXPEDITER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'177', N'INSTRUMENTATION TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'178', N'MAPPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'179', N'GEOGRAPHIC INFORMATION SYSTEM TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'180', N'SURVEY AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'181', N'FIELD AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'182', N'MILL DIVISION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'183', N'MILL OPERATION DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'184', N'MILL METALLURGY DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'185', N'MILL MAINTENANCE DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'186', N'ASSISTANT MILL OPERATION DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'187', N'ASSISTANT MILL METALLURGY DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'188', N'ASSISTANT MILL MECHANICAL DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'189', N'ASSISTANT MILL ELECTRICAL AND INSTRUMENTATION DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'190', N'METALLURGIC ENGINEER SHIFT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'191', N'TAILING STORAGE FACILITY SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'192', N'PLANT METALLURGIC ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'193', N'REFINERY METALLURGIC ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'194', N'PROCESS METALLURGIC ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'195', N'RESEARCH METALLURGIC ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'196', N'MECHANICAL MAINTENANCE ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'197', N'MECHANICAL PLANNER ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'198', N'ELECTRICAL AND INSTRUMENTATION ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'199', N'PLANT SYSTEM SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'200', N'ELECTRICAL SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'201', N'TAILING STORAGE FACILITY FOREMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'202', N'GOLD ROOM FOREMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'203', N'METALLURGIC ACCOUNTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'204', N'REFINERY MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'205', N'PROCESS CONTROL TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'206', N'METALLURGIC LABORATORY TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'207', N'AUTOCAD OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'208', N'SEMI-AUTOGENOUS MILL LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'209', N'LOADER OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'210', N'MAINTENANCE LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'211', N'INVENTORY LEADMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'212', N'CONTROL ROOM OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'213', N'STRIPPING OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'214', N'MACHINIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'215', N'BOBCAT OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'216', N'JAW CRUSHER OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'217', N'COMPRESSOR OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'218', N'THICKENER OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'219', N'INTENSIVE LEACH REACTOR OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'220', N'DAM AND FLUME LINE MAINTENANCE CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'221', N'MECHANIC REPAIR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'222', N'MILL EXPEDITER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'223', N'TRUCK DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'224', N'MATERIALS CONTROLLER ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'225', N'CARBON REGENERATION OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'226', N'WELDER FABRICATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'227', N'WELDER MECHANIC', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'228', N'DOCUMENT CONTROLLER CLERK', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'229', N'SEMI-AUTOGENOUS MILL LUBRICATION MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'230', N'LEACH TANK MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'231', N'CARBON-IN-LEACH TANK MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'232', N'DETOX OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'233', N'TAILING STORAGE FACILITY MONITORING AND WATER TREATMENT CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'234', N'REAGENT PREPERATION MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'235', N'METALLURGIC LABORATORY AIDE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'236', N'LUBE MAN MILL', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'237', N'CYCLONE OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'238', N'POTABLE WATER TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'239', N'CONVEYOR OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'240', N'COB/LIME MAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'241', N'TRASH SCREEN TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'242', N'TAILING STORAGE FACILITY PROJECTS CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'243', N'TOOLKEEPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'244', N'TECHNICAL SERVICES ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'245', N'ENGINEERING AND CONSTRUCTION SERVICES DIVISION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'246', N'CLERK ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'247', N'CIVIL WORKS DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'248', N'CIVIL WORKS DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'249', N'CIVIL WORKS ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'250', N'MAINTENANCE PLANNER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'251', N'SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'252', N'CIVIL WORKS LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'253', N'HEAVY EQUIPMENT OPERATOR ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'254', N'INSTRUMENT MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'255', N'DRAFTSMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'256', N'LOW BED OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'257', N'DUMP TRUCK DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'258', N'MASON', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'259', N'WELDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'260', N'ROAD INSPECTOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'261', N'CONSTRUCTION HELPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'262', N'DRIVER HELPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'263', N'ELECTRICAL SERVICES', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'264', N'ELECTRICAL SERVICES DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'265', N'ELECTRICAL SERVICES DEPARTMENT ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'266', N'POWER LINE ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'267', N'ELECTRICAL MAINTENANCE ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'268', N'MECHANICAL MAINTENANCE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'269', N'POWER LINE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'270', N'FABRICATION SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'271', N'ELECTRICAL MAINTENANCE SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'272', N'POWER LINE LEADMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'273', N'FABRICATOR LEADMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'274', N'ELECTRICAL MAINTENANCE LEADMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'275', N'POWERHOUSE MAINTENANCE LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'276', N'GROUND MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'277', N'LINEMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'278', N'ELECTRICIAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'279', N'FABRICATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'280', N'REWINDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'281', N'AIRCON TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'282', N'MECHANICAL TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'283', N'FABRICATOR HELPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'284', N'REPEATER TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'285', N'MOTORPOOL', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'286', N'MOTORPOOL DEPARTMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'287', N'MOTORPOOL ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'288', N'SHOP MECHANICAL ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'289', N'LEADMAN OPERATIONS', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'290', N'MECHANIC', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'291', N'AUTO ELECTRICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'292', N'TIRE MAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'293', N'SHOP HELPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'294', N'EXECUTIVE ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'295', N'EXECUTIVE DIVISION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'296', N'HEAD EXECUTIVE ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'297', N'CORPORATE SOCIAL RESPONSIBILITY OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'298', N'EXECUTIVE ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'299', N'LOSS CONTROL ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'300', N'LOSS CONTROL  MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'301', N'LOSS CONTROL ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'302', N'QUALITY ASSURANCE/QUALITY CONTROL', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'303', N'TECHNICAL AND QUALITY MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'304', N'CHIEF CHEMIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'305', N'QUALITY ASSURANCE OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'306', N'ASSISTANT QUALITY ASSURANCE OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'307', N'QUALITY CONTROL SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'308', N'ASSISTANT QUALITY CONTROL SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'309', N'QUALITY ASSURANCE/QUALITY CONTROL ANALYST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'310', N'QUALITY ASSURANCE/QUALITY CONTROL TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'311', N'FIRE ASSAYER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'312', N'SAMPLE PREPARATION OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'313', N'ASSISTANT SAMPLE PREPARATION OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'314', N'TENEMENT, LICENSING AND COMMUNITY RELATION', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'315', N'TENEMENT, LICENSING AND COMMUNITY RELATIONS MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'316', N'COMMUNITY RELATIONS OFFICER I', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'317', N'TENEMENT OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'318', N'COMMUNITY RELATION OFFICER II', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'319', N'INFORMATION, EDUCATION, COMMUNICATION OFFICER ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'320', N'INFORMATION, EDUCATION, COMMUNICATION ASSISTANT OFFICER ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'321', N'PUBLIC RELATION ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'322', N'TENEMENT ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'323', N'PERMITTING ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'324', N'REAL PROPERTY MANAGEMENT ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'325', N'COMMUNITY COORDINATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'326', N'BOOKEEPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'327', N'REAL PROPERTY GUARD', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'328', N'SAFETY DEPARTMENT ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'329', N'SAFETY MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'330', N'SAFETY SECTION HEAD', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'331', N'SAFETY ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'332', N'TRAINING OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'333', N'SAFETY SHIFT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'334', N'ASSISTANT TRAINING OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'335', N'SAFETY INSPECTOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'336', N'SIGN PAINTER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'337', N'FIRE TRUCK DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'338', N'UTILITY (MILL)', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'339', N'ENVIRONMENTAL DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'340', N'ENVIRONMENT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'341', N'ENVIRONMENT ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'342', N'ENVIRONMENT OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'343', N'PLANTATION & NURSERY SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'344', N'ENVIRONMENT MANAGEMENT SYSTEM COMPLIANCE OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'345', N'WATER TREATMENT SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'346', N'DOCUMENT AND MAPPING SUPERVISOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'347', N'ASSISTANT ENVIRONMENT OFFICER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'348', N'SKIDSTER OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'349', N'MINI DUMP TRUCK DRIVER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'350', N'SPECIAL PROJECTS COORDINATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'351', N'WATER TREATMENT LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'352', N'PLANTATION AND NURSERY LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'353', N'NURSERY LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'354', N'ENVIRONMENT PROJECT WORKFORCE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'355', N'PLANTATION AND MAINTENANCE LEADMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'356', N'ENVIRONMENT MANAGEMENT SYSTEM DOCUMENT CONTROLLER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'357', N'WATER TREATMENT CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'358', N'RUBBER MAINTENANCE CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'359', N'DOCUMENT AND MAPPING CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'360', N'MATERIAL RECOVERY FACILITY MAINTENANCE CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'361', N'PLANTATION & MAINTENANCE CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'362', N'NURSERY CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'363', N'SPECIAL PROJECTS CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'364', N'LEGAL DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'365', N'CORPORATE LEGAL COUNSEL', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'366', N'ASSOCIATE LAWYER - CORPORATE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'367', N'PARALEGAL - CORPORATE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'368', N'LEGAL ASSISTANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'369', N'ENGINEERING DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'370', N'MINE ENGINEERING AND PLANNING MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'371', N'LONG RANGE MINE PLANNING MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'372', N'SHORT RANGE MINE PLANNING MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'373', N'SENIOR MECHANICAL ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'374', N'SENIOR MINING ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'375', N'SENIOR PLANNING ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'376', N'MINING ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'377', N'MECHANICAL ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'378', N'SURVEYOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'379', N'MINE ENGINEERING CMMS PLANNER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'380', N'FOREMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'381', N'MINE ACCOUNTS COORDINATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'382', N'MINE CONTRACTS COORDINATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'383', N'LEADMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'384', N'ASSISTANT MINE CONTRACTS COORDINATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'385', N'PIPEMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'386', N'DEWATERING CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'387', N'PUMP ASSEMBLER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'388', N'VENTILATION CREW', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'389', N'PUMP TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'390', N'GEOLOGY DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'391', N'MINE GEOLOGY MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'392', N'MINE GEOLOGY ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'393', N'CADET GEOLOGIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'394', N'LEADMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'395', N'GEOLOGIC MAPPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'396', N'CORE CHECKER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'397', N'COREHOUSE ATTENDANT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'398', N'SAMPLER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'399', N'ELECTRICAL DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'400', N'MINE SUPPORT SERVICES MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'401', N'MINE ELECTRICAL MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'402', N'SYSTEM AUTOMATION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'403', N'MINE ELECTRICAL ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'404', N'ELECTRICAL ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'405', N'ELECTRONICS ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'406', N'POWERHOUSE TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'407', N'TECHNICIAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'408', N'CAP LAMP REPAIRMEN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'409', N'SUBSTATION TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'410', N'COMPRESSOR TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'411', N'CAP LAMP TENDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'412', N'MECHANICAL DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'413', N'MINE MECHANICAL MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'414', N'MINE MECHANICAL ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'415', N'LOCOMOTIVE MAINTENANCE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'416', N'FABRICATOR WELDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'417', N'FABRICATOR MACHINIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'418', N'REBONDER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'419', N'EXPLOSIVES DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'420', N'MINE EXPLOSIVES MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'421', N'MINE EXPLOSIVES ASSISTANT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'422', N'CRIMPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'423', N'STOCK INVENTORY CHECKER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'424', N'STOCKMAN ', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'425', N'OPERATIONS DEPARTMENT', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'426', N'MINE PRODUCTION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'427', N'SHAFTS MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'428', N'LIFT MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'429', N'SHAFT COMMUNICATION/OPERATION SPECIALIST', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'430', N'LEVEL MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'431', N'ASSISTANT LEVEL MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'432', N'SHAFT ENGINEER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'433', N'CLASS A MINER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'434', N'SHIFT COMMUNICATION OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'435', N'WINDER OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'436', N'LOCOMOTIVE OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'437', N'TRACK MAINTENANCE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'438', N'CHAINSAW OPERATOR', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'439', N'HELPER MINER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'440', N'LOCOMOTIVE BRAKEMAN', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'441', N'CHAINSAW HELPER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'442', N'MINE ADMINISTRATION OFFICE', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'443', N'MINE DIVISION MANAGER', N'2021-06-17 12:51:57.000', NULL)
GO

INSERT INTO [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (N'444', N'MINE UNION COORDINATOR', N'2021-06-17 12:51:57.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[positions] OFF
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
-- Records of positions_category
-- ----------------------------
SET IDENTITY_INSERT [dbo].[positions_category] ON
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'1', N'CADET', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'2', N'HS1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'3', N'HS2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'4', N'HS3', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'5', N'L1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'6', N'L2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'7', N'S1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'8', N'S2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'9', N'S3', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'10', N'S4', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'11', N'SK1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'12', N'SK2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'13', N'SK3', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'14', N'SP1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'15', N'SP2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'16', N'SP3', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'17', N'SS1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'18', N'SS2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'19', N'SS3', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'20', N'T1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'21', N'T2', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'22', N'T3', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'23', N'T4', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'24', N'US1', N'2021-06-17 12:58:50.000', NULL)
GO

INSERT INTO [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (N'25', N'US2', N'2021-06-17 12:58:50.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[positions_category] OFF
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
-- Records of positions_classification
-- ----------------------------
SET IDENTITY_INSERT [dbo].[positions_classification] ON
GO

INSERT INTO [dbo].[positions_classification] ([id], [name], [createdAt], [updatedAt]) VALUES (N'1', N'Rank and File', N'2021-06-17 12:58:04.000', NULL)
GO

INSERT INTO [dbo].[positions_classification] ([id], [name], [createdAt], [updatedAt]) VALUES (N'2', N'Supervisory', N'2021-06-17 12:58:04.000', NULL)
GO

INSERT INTO [dbo].[positions_classification] ([id], [name], [createdAt], [updatedAt]) VALUES (N'3', N'Managerial', N'2021-06-17 12:58:04.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[positions_classification] OFF
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
-- Records of requirements
-- ----------------------------
SET IDENTITY_INSERT [dbo].[requirements] ON
GO

SET IDENTITY_INSERT [dbo].[requirements] OFF
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
-- Records of role
-- ----------------------------
SET IDENTITY_INSERT [dbo].[role] ON
GO

INSERT INTO [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1', N'Administrator', N'super-admin', N'1', N'0', N'1', N'2019-07-03 05:48:38.000', N'2019-08-07 04:25:04.000')
GO

INSERT INTO [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'2', N'HR Admin', N'hr-admin', N'1', N'0', N'1', N'2019-07-03 05:50:18.000', N'2019-08-01 04:44:22.000')
GO

INSERT INTO [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'3', N'Payroll Admin', N'payroll-admin', N'1', N'0', NULL, N'2019-07-03 05:50:24.000', N'2019-08-01 04:44:29.000')
GO

INSERT INTO [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'4', N'Default User', N'default-user', N'1', N'0', N'1', N'2019-07-03 05:50:36.000', N'2019-08-01 04:44:35.000')
GO

INSERT INTO [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'8', N'Manager', N'manager', N'1', N'1', N'1', N'2019-07-04 01:46:13.000', N'2019-08-01 04:44:37.000')
GO

SET IDENTITY_INSERT [dbo].[role] OFF
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
-- Records of role_permission
-- ----------------------------
SET IDENTITY_INSERT [dbo].[role_permission] ON
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'104', N'1', N'appraisal-consolidation', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-03 00:42:38.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'105', N'1', N'appraisal-promotion', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'106', N'1', N'appraisal-initiation', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'107', N'1', N'appraisal-feedback', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'108', N'1', N'appraisal-transfer', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'109', N'1', N'approvals-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'110', N'1', N'approvals-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'111', N'1', N'approvals-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-09-26 03:34:22.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'112', N'1', N'approvals-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'113', N'1', N'attendance-absence', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'114', N'1', N'approvals-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'115', N'1', N'attendance-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'116', N'1', N'attendance-biometric', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'117', N'1', N'attendance-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'118', N'1', N'attendance-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'119', N'1', N'employee-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'120', N'1', N'employee-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'121', N'1', N'employee-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'122', N'1', N'employee-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'123', N'1', N'employee-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:45.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'124', N'1', N'employee-attendance', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:07:25.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'125', N'1', N'employee-detail', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'126', N'1', N'employee-document', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:21:32.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'127', N'1', N'employee-list', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-03 00:48:00.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'128', N'1', N'employee-loan', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:18:09.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'129', N'1', N'employee-salary', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:14:11.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'130', N'1', N'employee-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-09-26 03:34:22.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'131', N'1', N'forms-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'132', N'1', N'forms-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'133', N'1', N'forms-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'134', N'1', N'forms-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'135', N'1', N'forms-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-09-26 03:34:22.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'136', N'1', N'forms-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'137', N'1', N'payment-arrear', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'138', N'1', N'payment-salary', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'139', N'1', N'payment-settlement', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'140', N'1', N'payment-earning', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'141', N'1', N'recruitment-joining', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 06:03:04.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'142', N'1', N'recruitment-candidate-profile', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:42:20.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'143', N'1', N'payment-loan', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'144', N'1', N'recruitment-rating', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:50:55.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'145', N'1', N'recruitment-schedule', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 05:47:46.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'146', N'1', N'reliving-interview', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'147', N'1', N'reliving-formality', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'148', N'1', N'settings-biometric', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 06:55:43.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'149', N'1', N'settings-approvers', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-09-14 02:34:08.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'150', N'1', N'reliving-resignation', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-01 23:10:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'151', N'1', N'settings-branch', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 06:35:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'152', N'1', N'settings-company', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 06:32:20.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'153', N'1', N'settings-holidays', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 06:53:03.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'154', N'1', N'settings-role', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 07:01:17.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'155', N'1', N'settings-taxonomy', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:05:46.000', N'2019-08-02 06:47:50.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'156', N'2', N'appraisal-feedback', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'157', N'2', N'appraisal-consolidation', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'158', N'2', N'approvals-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'159', N'2', N'approvals-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'160', N'2', N'appraisal-transfer', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'161', N'2', N'approvals-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'162', N'2', N'approvals-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'163', N'2', N'appraisal-promotion', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'164', N'2', N'attendance-biometric', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'165', N'2', N'attendance-absence', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'166', N'2', N'approvals-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'167', N'2', N'attendance-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'168', N'2', N'attendance-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'169', N'2', N'attendance-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'170', N'2', N'employee-detail', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'171', N'2', N'employee-attendance', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'172', N'2', N'employee-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'173', N'2', N'employee-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'174', N'2', N'employee-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'175', N'2', N'appraisal-initiation', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'176', N'2', N'employee-document', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'177', N'2', N'employee-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'178', N'2', N'employee-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'179', N'2', N'employee-list', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'180', N'2', N'employee-loan', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'181', N'2', N'forms-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'182', N'2', N'forms-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'183', N'2', N'forms-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'184', N'2', N'employee-salary', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'185', N'2', N'employee-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'186', N'2', N'forms-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'187', N'2', N'forms-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'188', N'2', N'forms-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'189', N'2', N'payment-arrear', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'190', N'2', N'payment-salary', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'191', N'2', N'recruitment-schedule', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'192', N'2', N'payment-earning', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'193', N'2', N'recruitment-joining', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'194', N'2', N'recruitment-rating', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'195', N'2', N'payment-settlement', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'196', N'2', N'payment-loan', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'197', N'2', N'recruitment-candidate-profile', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'198', N'2', N'settings-taxonomy', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'199', N'2', N'reliving-resignation', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'200', N'2', N'settings-holidays', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'201', N'2', N'settings-company', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'202', N'2', N'settings-branch', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'203', N'2', N'reliving-interview', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'204', N'2', N'settings-approvers', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'205', N'2', N'reliving-formality', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'206', N'2', N'settings-role', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:36:42.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'207', N'2', N'settings-biometric', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:11:26.000', N'2019-08-01 23:11:26.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'208', N'4', N'appraisal-consolidation', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'209', N'4', N'appraisal-feedback', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'210', N'4', N'appraisal-initiation', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'211', N'4', N'appraisal-promotion', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'212', N'4', N'appraisal-transfer', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'213', N'4', N'approvals-business-trip', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'214', N'4', N'approvals-leave', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'215', N'4', N'approvals-overtime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'216', N'4', N'approvals-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'217', N'4', N'approvals-undertime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'218', N'4', N'attendance-absence', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'219', N'4', N'attendance-biometric', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'220', N'4', N'attendance-leave', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'221', N'4', N'attendance-overtime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'222', N'4', N'attendance-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'223', N'4', N'employee-business-trip', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'224', N'4', N'employee-dispute', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'225', N'4', N'employee-leave', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'226', N'4', N'employee-overtime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'227', N'4', N'employee-undertime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'228', N'4', N'employee-attendance', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'229', N'4', N'employee-detail', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'230', N'4', N'employee-document', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'231', N'4', N'employee-loan', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'232', N'4', N'employee-list', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'233', N'4', N'employee-salary', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'234', N'4', N'employee-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'235', N'4', N'forms-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'236', N'4', N'forms-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'237', N'4', N'forms-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'238', N'4', N'forms-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'239', N'4', N'forms-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'240', N'4', N'forms-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'241', N'4', N'payment-arrear', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'242', N'4', N'payment-salary', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'243', N'4', N'payment-earning', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'244', N'4', N'payment-settlement', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'245', N'4', N'recruitment-candidate-profile', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'246', N'4', N'payment-loan', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'247', N'4', N'recruitment-joining', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'248', N'4', N'recruitment-rating', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'249', N'4', N'recruitment-schedule', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'250', N'4', N'reliving-interview', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:30.000', N'2019-08-01 23:33:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'251', N'4', N'reliving-formality', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'252', N'4', N'reliving-resignation', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'253', N'4', N'settings-approvers', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'254', N'4', N'settings-biometric', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'255', N'4', N'settings-branch', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'256', N'4', N'settings-company', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'257', N'4', N'settings-role', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'258', N'4', N'settings-holidays', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'259', N'4', N'settings-taxonomy', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:33:31.000', N'2019-08-01 23:33:31.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'260', N'8', N'appraisal-consolidation', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:12.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'261', N'8', N'appraisal-feedback', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:12.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'262', N'8', N'appraisal-initiation', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:12.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'263', N'8', N'appraisal-promotion', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:12.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'264', N'8', N'appraisal-transfer', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:12.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'265', N'8', N'approvals-business-trip', N'1', N'0', N'1', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:39.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'266', N'8', N'approvals-leave', N'1', N'0', N'1', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:39.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'267', N'8', N'approvals-overtime', N'1', N'0', N'1', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:39.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'268', N'8', N'approvals-shift', N'1', N'0', N'1', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:39.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'269', N'8', N'approvals-undertime', N'1', N'0', N'1', N'0', NULL, NULL, N'2019-08-01 23:35:12.000', N'2019-08-01 23:35:39.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'270', N'8', N'attendance-absence', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'271', N'8', N'attendance-biometric', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'272', N'8', N'attendance-leave', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'273', N'8', N'attendance-overtime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'274', N'8', N'attendance-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'275', N'8', N'employee-business-trip', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'276', N'8', N'employee-dispute', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'277', N'8', N'employee-leave', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'278', N'8', N'employee-overtime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'279', N'8', N'employee-undertime', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'280', N'8', N'employee-attendance', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'281', N'8', N'employee-detail', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'282', N'8', N'employee-document', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'283', N'8', N'employee-list', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'284', N'8', N'employee-loan', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'285', N'8', N'employee-salary', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'286', N'8', N'employee-shift', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'287', N'8', N'forms-business-trip', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'288', N'8', N'forms-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'289', N'8', N'forms-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'290', N'8', N'forms-overtime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'291', N'8', N'forms-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'292', N'8', N'forms-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'293', N'8', N'payment-adjustment', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-09-11 21:02:29.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'294', N'8', N'payment-salary', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'295', N'8', N'payment-dispute', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-09-11 23:11:16.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'296', N'8', N'payment-settlement', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'297', N'8', N'payment-loan', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'298', N'8', N'recruitment-candidate-profile', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'299', N'8', N'recruitment-joining', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'300', N'8', N'recruitment-rating', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'301', N'8', N'recruitment-schedule', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'302', N'8', N'reliving-interview', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'303', N'8', N'reliving-formality', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'304', N'8', N'reliving-resignation', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'305', N'8', N'settings-approvers', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'306', N'8', N'settings-biometric', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'307', N'8', N'settings-branch', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'308', N'8', N'settings-company', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'309', N'8', N'settings-holidays', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'310', N'8', N'settings-role', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'311', N'8', N'settings-taxonomy', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-08-01 23:35:13.000', N'2019-08-01 23:35:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'312', N'1', N'employee-config', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-02 05:29:40.000', N'2019-08-14 22:29:36.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'313', N'1', N'settings-configuration', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-02 06:27:45.000', N'2019-08-02 06:28:56.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'314', N'1', N'appraisal-increment', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-03 00:42:38.000', N'2019-08-03 00:42:38.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'315', N'1', N'settings-leave-policy', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-03 04:26:38.000', N'2019-09-20 05:00:42.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'316', N'1', N'employee-leave-credit', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-06 06:24:35.000', N'2019-08-06 06:24:35.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'318', N'1', N'employee-role', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-16 22:18:53.000', N'2019-09-11 23:13:05.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'319', N'1', N'announcement', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-18 00:09:13.000', N'2019-08-18 00:09:13.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'320', N'1', N'attendance-summary', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-08-28 05:38:47.000', N'2019-08-28 05:38:47.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'321', N'1', N'payment-adjustment', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-09-11 21:02:59.000', N'2019-09-11 21:02:59.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'322', N'1', N'payment-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-09-11 23:13:06.000', N'2019-09-11 23:13:06.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'323', N'1', N'approvals-dispute', N'1', N'1', N'1', N'1', NULL, NULL, N'2019-09-12 00:56:49.000', N'2019-09-12 00:56:49.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'324', N'1', N'accounts', N'0', N'0', N'0', N'0', NULL, NULL, N'2019-09-25 00:32:39.000', N'2019-09-26 03:34:22.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'325', N'1', N'settings-branding', N'1', N'1', N'1', N'1', NULL, NULL, N'2020-02-20 12:54:43.000', N'2020-02-20 12:54:43.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'326', N'1', N'custom-leave', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-02-01 20:25:47.000', N'2021-02-01 20:25:47.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'327', N'1', N'payment-payroll', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-05-05 10:50:22.000', N'2021-05-05 10:50:22.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'328', N'1', N'settings-division', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-06-11 00:43:30.000', N'2021-06-11 00:43:30.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'329', N'1', N'settings-department', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-06-14 16:59:18.000', N'2021-06-14 16:59:18.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'330', N'1', N'settings-section', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-06-14 20:16:45.000', N'2021-06-14 20:16:45.000')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'331', N'4', N'announcement', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.800', N'2021-08-05 15:32:41.800')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'332', N'4', N'approvals-dispute', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.817', N'2021-08-05 15:32:41.817')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'333', N'4', N'attendance-summary', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.833', N'2021-08-05 15:32:41.833')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'334', N'4', N'accounts', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.833', N'2021-08-05 15:32:41.833')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'335', N'4', N'custom-leave', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.837', N'2021-08-05 15:32:41.837')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'336', N'4', N'employee-config', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.840', N'2021-08-05 15:32:41.840')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'337', N'4', N'employee-leave-credit', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.850', N'2021-08-05 15:32:41.850')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'338', N'4', N'employee-role', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.870', N'2021-08-05 15:32:41.870')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'339', N'4', N'payment-dispute', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.897', N'2021-08-05 15:32:41.897')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'340', N'4', N'payment-payroll', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.900', N'2021-08-05 15:32:41.900')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'341', N'4', N'payment-adjustment', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.903', N'2021-08-05 15:32:41.903')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'342', N'4', N'settings-branding', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.933', N'2021-08-05 15:32:41.933')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'343', N'4', N'settings-configuration', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.937', N'2021-08-05 15:32:41.937')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'344', N'4', N'settings-department', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.940', N'2021-08-05 15:32:41.940')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'345', N'4', N'settings-division', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.940', N'2021-08-05 15:32:41.940')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'346', N'4', N'settings-leave-policy', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.940', N'2021-08-05 15:32:41.940')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'347', N'4', N'settings-section', N'0', N'0', N'0', N'0', NULL, NULL, N'2021-08-05 15:32:41.947', N'2021-08-05 15:32:41.947')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1332', N'1', N'attendance-undertime', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-09-18 11:37:56.560', N'2021-09-18 11:37:56.560')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1333', N'1', N'forms-change-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-09-19 12:20:57.827', N'2021-09-19 12:20:57.827')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1334', N'1', N'approvals-change-shift', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-09-20 09:21:58.850', N'2021-09-20 09:21:58.850')
GO

INSERT INTO [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1335', N'1', N'attendance-tss', N'1', N'1', N'1', N'1', NULL, NULL, N'2021-09-26 16:41:45.667', N'2021-09-26 16:41:45.667')
GO

SET IDENTITY_INSERT [dbo].[role_permission] OFF
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
-- Records of salary
-- ----------------------------
SET IDENTITY_INSERT [dbo].[salary] ON
GO

INSERT INTO [dbo].[salary] ([id], [user_id], [start_date], [end_date], [amount], [mode], [payroll], [created_at], [updated_at]) VALUES (N'1', N'2', N'2019-10-30', N'2020-10-31', N'20000', N'0', N'2', N'2019-10-30 11:05:28.000', N'2019-10-30 11:05:56.000')
GO

INSERT INTO [dbo].[salary] ([id], [user_id], [start_date], [end_date], [amount], [mode], [payroll], [created_at], [updated_at]) VALUES (N'92', N'1', N'2021-01-01', NULL, N'45000', N'0', N'2', N'2021-02-03 17:15:06.000', N'2021-02-03 17:15:06.000')
GO

SET IDENTITY_INSERT [dbo].[salary] OFF
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
-- Records of sections
-- ----------------------------
SET IDENTITY_INSERT [dbo].[sections] ON
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'1', N'6', N'Cashering', N'CS', N'2', N'2', N'2', N'test', N'1', NULL, N'2021-06-14 20:29:12.000', N'2021-09-17 10:54:53.617')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'2', N'6', N'General Accounting', N'GA', N'2', N'2', N'1', N'Test', N'1', NULL, N'2021-06-14 20:31:34.000', N'2021-09-17 10:55:08.773')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'3', N'6', N'Management Accounting', N'MA', N'1', N'2', N'2', N'test', N'1', NULL, N'2021-06-14 20:40:40.000', N'2021-09-17 10:55:25.717')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'5', N'2', N'General Services Exploration', N'GSE', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 10:55:47.097', N'2021-09-17 10:55:47.097')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'6', N'2', N'General Services Mill', N'GSM', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 10:56:14.337', N'2021-09-17 10:56:14.337')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'7', N'2', N'General Services Mine', N'GSMn', N'126', N'126', N'126', N'', N'1', NULL, N'2021-09-17 10:56:39.330', N'2021-09-17 10:56:39.330')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'8', N'15', N'Human Resources Mine', N'HRMn', N'126', N'126', N'127', N'', N'1', NULL, N'2021-09-17 10:58:15.543', N'2021-09-17 10:58:15.543')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'9', N'8', N'Mill Materials Controll Office', N'MMCO', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 11:01:34.887', N'2021-09-17 11:01:34.887')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'10', N'8', N'Mine Materials Control Office', N'MMCOM', N'124', N'124', N'127', N'', N'1', NULL, N'2021-09-17 11:02:05.990', N'2021-09-17 11:02:05.990')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'11', N'8', N'Procurement Office', N'PO', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 11:17:21.457', N'2021-09-17 11:17:21.457')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'12', N'9', N'Mill Clinic', N'MC', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 11:17:42.927', N'2021-09-17 11:17:42.927')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'13', N'9', N'Mine Hospital', N'MH', N'119', N'119', N'119', N'', N'1', NULL, N'2021-09-17 11:18:02.120', N'2021-09-17 11:18:02.120')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'14', N'10', N'Exploration Security', N'EX', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 11:18:26.500', N'2021-09-17 11:18:26.500')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'15', N'10', N'Mill Security', N'MS', N'127', N'127', N'124', N'', N'1', NULL, N'2021-09-17 11:18:44.337', N'2021-09-17 11:18:44.337')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'16', N'10', N'Mine Security', N'MSS', N'126', N'126', N'127', N'', N'1', NULL, N'2021-09-17 11:19:00.087', N'2021-09-17 11:19:00.087')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'17', N'19', N'Mill Civil Works', N'MCW', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 11:19:19.963', N'2021-09-17 11:19:19.963')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'18', N'19', N'Mine Civil Works', N'MCWW', N'1', N'1', N'2', N'', N'1', NULL, N'2021-09-17 11:19:42.323', N'2021-09-17 11:19:42.323')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'19', N'21', N'Mill Motorpool', N'MM', N'126', N'126', N'127', N'', N'1', NULL, N'2021-09-17 11:19:59.097', N'2021-09-17 11:19:59.097')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'20', N'21', N'Mine Motorpool', N'MnM', N'126', N'126', N'126', N'', N'1', NULL, N'2021-09-17 11:20:17.070', N'2021-09-17 11:20:17.070')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'21', N'28', N'Mill Safety', N'MSD', N'2', N'2', N'2', N'', N'1', NULL, N'2021-09-17 11:20:43.053', N'2021-09-17 11:20:43.053')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'22', N'28', N'Mine Safety', N'MnSD', N'1', N'1', N'1', N'', N'1', NULL, N'2021-09-17 11:21:01.517', N'2021-09-17 11:21:01.517')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'23', N'30', N'Community Relation Section', N'CRS', N'125', N'1', N'121', N'', N'1', NULL, N'2021-09-17 11:21:23.503', N'2021-09-17 11:21:23.503')
GO

INSERT INTO [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (N'24', N'30', N'Tenement Section', N'TS', N'124', N'124', N'124', N'', N'1', NULL, N'2021-09-17 11:21:38.677', N'2021-09-17 11:21:38.677')
GO

SET IDENTITY_INSERT [dbo].[sections] OFF
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
-- Records of shift_type
-- ----------------------------
SET IDENTITY_INSERT [dbo].[shift_type] ON
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'1', N'12 TO 8PM', N'12PM TO 8PM', N'STANDARD', N'12:00:00.0000000', N'08:00:00.0000000', N'12:00:00.0000000', N'08:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'26', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'2', N'1st SHIFT', N'SHIFT 1 (11PM - 7AM)', N'STANDARD', N'23:00:00.0000000', N'07:00:00.0000000', N'23:00:00.0000000', N'07:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'01:01:00.0000000', N'05:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'1', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'3', N'1ST SHIFT (12:30AM - 8:30AM)', N'12:30 AM - 8:30 AM', N'STANDARD', NULL, NULL, N'00:30:00.0000000', N'08:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'02:31:00.0000000', N'06:31:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'54', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'4', N'1ST SHIFT (12am-8am)', N'12 AM - 8 AM', N'STANDARD', N'00:00:00.0000000', N'08:00:00.0000000', N'00:00:00.0000000', N'08:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'02:01:00.0000000', N'06:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'48', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'5', N'1ST SHIFT (1AM-9AM)', N'1 AM - 9 AM', N'STANDARD', N'01:00:00.0000000', N'09:00:00.0000000', N'01:00:00.0000000', N'09:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'03:01:00.0000000', N'07:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'51', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'6', N'1st SHIFT GEO', N'11:30pm - 7:30am', N'STANDARD', N'23:30:00.0000000', N'07:30:00.0000000', N'23:30:00.0000000', N'07:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'43', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'7', N'2ND SHIFT', N'SHIFT 2 (7AM - 3 PM)', N'STANDARD', N'07:00:00.0000000', N'15:00:00.0000000', N'07:00:00.0000000', N'15:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'09:01:00.0000000', N'13:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'2', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'8', N'2ND SHIFT (8:30AM-4:30PM)', N'8:30AM - 4:30PM', N'STANDARD', NULL, NULL, N'08:30:00.0000000', N'16:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'10:31:00.0000000', N'14:31:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'55', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'9', N'2ND SHIFT (9AM-5PM)', N'9 AM - 5 PM', N'STANDARD', N'09:00:00.0000000', N'17:00:00.0000000', N'09:00:00.0000000', N'17:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'11:01:00.0000000', N'15:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'52', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'10', N'2nd SHIFT GEO', N'7:30am - 3:30pm', N'STANDARD', N'07:30:00.0000000', N'15:30:00.0000000', N'07:30:00.0000000', N'15:30:00.0000000', N'0', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'44', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'11', N'2ND SHIFT(8AM-4PM)', N'8 AM - 4 PM', N'STANDARD', N'08:00:00.0000000', N'16:00:00.0000000', N'08:00:00.0000000', N'16:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'10:01:00.0000000', N'14:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'49', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'12', N'3RD SHIFT', N'SHIFT 3 (3PM - 11 PM)', N'STANDARD', N'15:00:00.0000000', N'23:00:00.0000000', N'15:00:00.0000000', N'23:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'17:01:00.0000000', N'21:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'3', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'13', N'3RD SHIFT (4:30PM - 12:30AM)', N'4:30PM - 12:30AM', N'STANDARD', NULL, NULL, N'16:30:00.0000000', N'00:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'18:31:00.0000000', N'22:31:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'56', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'14', N'3RD SHIFT (4PM-12AM)', N'4 PM - 12 AM', N'STANDARD', N'16:00:00.0000000', N'00:00:00.0000000', N'16:00:00.0000000', N'00:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'18:01:00.0000000', N'22:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'50', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'15', N'3RD SHIFT (5PM-1AM)', N'5 PM - 1 AM', N'STANDARD', N'17:00:00.0000000', N'01:00:00.0000000', N'17:00:00.0000000', N'01:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'19:01:00.0000000', N'23:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'53', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'16', N'3rd SHIFT GEO', N'3:30pm - 11:30pm', N'STANDARD', N'15:30:00.0000000', N'23:30:00.0000000', N'15:30:00.0000000', N'23:30:00.0000000', N'0', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'45', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'17', N'8AM TO 4PM', N'8AM TO 4PM', N'STANDARD', N'08:00:00.0000000', N'16:00:00.0000000', N'08:00:00.0000000', N'16:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'27', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'18', N'8PM TO 4AM', N'8PM TO 4AM', N'STANDARD', N'20:00:00.0000000', N'04:00:00.0000000', N'20:00:00.0000000', N'04:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'28', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'19', N'BUS DRIVER 1', N'Bus Driver 1 (4AM - 12 PM)', N'STANDARD', N'04:00:00.0000000', N'12:00:00.0000000', N'04:00:00.0000000', N'12:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'06:01:00.0000000', N'08:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', NULL, N'0', N'8', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'20', N'BUS DRIVER 2', N'Bus Driver 2 (2PM - 10 PM)', N'STANDARD', N'14:00:00.0000000', N'22:00:00.0000000', N'14:00:00.0000000', N'22:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'16:01:00.0000000', N'20:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', NULL, N'0', N'9', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'21', N'Gen Services 1', N'Gen Serv 1 (3AM - 1PM)', N'STANDARD', N'03:00:00.0000000', N'13:00:00.0000000', N'03:00:00.0000000', N'13:00:00.0000000', N'5', N'09:00:00.0000000', N'08:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'05:01:00.0000000', N'11:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'10', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'22', N'Gen Services 2', N'Gen Serv 2 (4AM - 1PM)', N'STANDARD', N'04:00:00.0000000', N'13:00:00.0000000', N'04:00:00.0000000', N'13:00:00.0000000', N'5', N'10:00:00.0000000', N'09:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'06:01:00.0000000', N'11:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'11', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'23', N'Gen Services 3', N'Gen Serv 3 (8AM - 6PM)', N'STANDARD', N'08:00:00.0000000', N'18:00:00.0000000', N'08:00:00.0000000', N'18:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'10:01:00.0000000', N'16:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'12', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'24', N'Gen Services 4', N'Gen Serv 4 (11AM - 8PM)', N'STANDARD', N'11:00:00.0000000', N'20:00:00.0000000', N'11:00:00.0000000', N'20:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'13:01:00.0000000', N'18:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'13', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'25', N'Gen Services 5', N'Gen Serv 5 (7AM - 5PM)', N'STANDARD', N'07:00:00.0000000', N'17:00:00.0000000', N'07:00:00.0000000', N'17:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'09:01:00.0000000', N'15:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'14', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'26', N'Gen Services 6', N'Gen Serv 6 (1PM - 9PM)', N'STANDARD', N'13:00:00.0000000', N'21:00:00.0000000', N'13:00:00.0000000', N'21:00:00.0000000', N'5', N'18:00:00.0000000', N'17:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'15:01:00.0000000', N'19:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'15', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'27', N'HALFDAY AM', N'7:00 AM - 12:00 PM', N'STANDARD', N'07:00:00.0000000', N'12:00:00.0000000', N'07:00:00.0000000', N'12:00:00.0000000', N'5', NULL, NULL, N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'19', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'28', N'HALFDAY PM', N'1:00 PM - 5:00 PM', N'STANDARD', N'13:00:00.0000000', N'17:00:00.0000000', N'13:00:00.0000000', N'17:00:00.0000000', N'5', NULL, NULL, N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'20', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'29', N'LEVEL 6 1', N'1ST SHIFT', N'STANDARD', NULL, NULL, N'22:30:00.0000000', N'06:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'00:31:00.0000000', N'04:31:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'40', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'30', N'LEVEL 6 2', N'2ND SHIFT', N'STANDARD', NULL, NULL, N'06:30:00.0000000', N'14:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'08:31:00.0000000', N'12:31:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'41', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'31', N'LEVEL 6 3', N'3RD SHIFT', N'STANDARD', NULL, NULL, N'14:30:00.0000000', N'22:30:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'16:31:00.0000000', N'20:31:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'42', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'32', N'LEVEL 8 SHAFT 1', N'1ST SHIFT', N'STANDARD', NULL, NULL, N'21:00:00.0000000', N'05:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'23:01:00.0000000', N'03:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'36', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'33', N'LEVEL 8 SHAFT 2', N'2ND SHIFT', N'STANDARD', NULL, NULL, N'05:00:00.0000000', N'13:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'07:01:00.0000000', N'11:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'37', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'34', N'LEVEL 8 SHAFT 3', N'3RD SHIFT', N'STANDARD', NULL, NULL, N'13:00:00.0000000', N'21:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'15:01:00.0000000', N'19:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'39', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'35', N'NON-SHIFTER', N'REGULAR (7AM - 4PM)', N'STANDARD', N'07:00:00.0000000', N'16:00:00.0000000', N'07:00:00.0000000', N'16:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'09:00:01.0000000', N'14:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'4', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'36', N'NON-SHIFTER1', N'REGULAR (7AM - 5PM)', N'STANDARD', N'07:00:00.0000000', N'17:00:00.0000000', N'07:00:00.0000000', N'17:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'09:01:00.0000000', N'15:01:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'21', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'37', N'O/C MONDAY', N'Monday (8AM - 5PM)', N'STANDARD', N'08:00:00.0000000', N'17:00:00.0000000', N'08:00:00.0000000', N'17:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'9', NULL, NULL, NULL, NULL, N'10:01:00.0000000', N'14:59:59.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'5', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'38', N'O/C SATURDAY', N'Saturday (8AM - 12PM)', N'STANDARD', N'08:00:00.0000000', N'12:00:00.0000000', N'08:00:00.0000000', N'12:00:00.0000000', N'5', NULL, NULL, N'4', NULL, NULL, NULL, NULL, N'11:54:00.0000000', NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'7', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'39', N'O/C TUE-FRIDAY', N'Tues-Fri (7AM - 5PM)', N'STANDARD', N'07:00:00.0000000', N'17:00:00.0000000', N'07:00:00.0000000', N'17:00:00.0000000', N'5', N'13:00:00.0000000', N'12:00:00.0000000', N'10', NULL, NULL, NULL, NULL, N'09:01:00.0000000', N'14:59:59.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'1', N'6', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'40', N'RHD 1', N'7:00 AM - 12:00 PM', N'STANDARD', N'07:00:00.0000000', N'12:00:00.0000000', N'07:00:00.0000000', N'12:00:00.0000000', N'5', NULL, NULL, N'5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'22', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'41', N'RHD 2', N'7:00 AM - 11:00 AM', N'STANDARD', N'07:00:00.0000000', N'11:00:00.0000000', N'07:00:00.0000000', N'11:00:00.0000000', N'5', NULL, NULL, N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'23', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'42', N'RHD 3', N'1:00 PM - 5:00 PM', N'STANDARD', N'13:00:00.0000000', N'17:00:00.0000000', N'13:00:00.0000000', N'17:00:00.0000000', N'5', NULL, NULL, N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'24', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'43', N'RHD 4', N'1:00 PM - 4:00 PM', N'STANDARD', N'13:00:00.0000000', N'16:00:00.0000000', N'13:00:00.0000000', N'16:00:00.0000000', N'5', NULL, NULL, N'3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'25', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'44', N'Security 1', N'1st Shift (10PM - 6AM)', N'STANDARD', N'22:00:00.0000000', N'18:00:00.0000000', N'22:00:00.0000000', N'06:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, N'05:54:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'16', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'45', N'Security 2', N'2nd Shift (6AM - 2PM)', N'STANDARD', N'06:00:00.0000000', N'14:00:00.0000000', N'06:00:00.0000000', N'14:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, N'13:54:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'17', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'46', N'Security 3', N'3rd Shift (2PM - 10PM)', N'STANDARD', N'14:00:00.0000000', N'22:00:00.0000000', N'14:00:00.0000000', N'22:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, NULL, N'21:54:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'1', N'0', N'H', N'0', N'18', N'5', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

INSERT INTO [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (N'47', N'SURVEY (2ND SHIFT)', N'6AM - 3PM', N'STANDARD', NULL, NULL, N'06:00:00.0000000', N'15:00:00.0000000', N'5', NULL, NULL, N'8', NULL, NULL, NULL, NULL, N'08:00:00.0000000', N'13:00:00.0000000', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'M', N'0', N'46', N'0', NULL, N'0', N'0', NULL, NULL, NULL, NULL, N'2021-07-22 13:32:54.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[shift_type] OFF
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
  [is_change_shift] int  NULL,
  [diff_date] int  NULL
)
GO

ALTER TABLE [dbo].[shifts] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of shifts
-- ----------------------------
SET IDENTITY_INSERT [dbo].[shifts] ON
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'1', N'1', N'1', N'2021-07-02', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.703', N'2021-08-04 23:23:14.703', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'2', N'1', N'1', N'2021-07-01', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.703', N'2021-08-04 23:23:14.703', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'3', N'1', N'1', N'2021-07-05', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.707', N'2021-08-04 23:23:14.707', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'4', N'1', N'1', N'2021-07-06', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.707', N'2021-08-04 23:23:14.707', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'5', N'1', N'1', N'2021-07-07', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.713', N'2021-08-04 23:23:14.713', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'6', N'1', N'1', N'2021-07-08', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.717', N'2021-08-04 23:23:14.717', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'7', N'1', N'1', N'2021-07-09', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.717', N'2021-08-04 23:23:14.717', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'8', N'1', N'1', N'2021-07-12', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.720', N'2021-08-04 23:23:14.720', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'9', N'1', N'1', N'2021-07-13', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.723', N'2021-08-04 23:23:14.723', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10', N'1', N'1', N'2021-07-14', N'08:00:00.0000000', N'17:00:00.0000000', NULL, N'20:57:33.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.730', N'2021-08-04 23:23:14.730', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'11', N'1', N'1', N'2021-07-15', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.733', N'2021-08-04 23:23:14.733', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'12', N'1', N'1', N'2021-07-16', N'08:00:00.0000000', N'17:00:00.0000000', N'11:13:36.0000000', N'18:54:50.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.737', N'2021-08-04 23:23:14.737', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'13', N'1', N'1', N'2021-07-19', N'08:00:00.0000000', N'17:00:00.0000000', N'08:58:50.0000000', N'15:04:28.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.740', N'2021-08-04 23:23:14.740', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'14', N'1', N'1', N'2021-07-20', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.747', N'2021-08-04 23:23:14.747', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'15', N'1', N'1', N'2021-07-21', N'08:00:00.0000000', N'17:00:00.0000000', N'11:26:44.0000000', N'19:39:42.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.750', N'2021-08-04 23:23:14.750', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'16', N'1', N'1', N'2021-07-22', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.767', N'2021-08-04 23:23:14.767', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'17', N'1', N'1', N'2021-07-23', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.773', N'2021-08-04 23:23:14.773', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'18', N'1', N'1', N'2021-07-26', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.777', N'2021-08-04 23:23:14.777', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'19', N'1', N'1', N'2021-07-27', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.780', N'2021-08-04 23:23:14.780', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'20', N'1', N'1', N'2021-07-28', N'08:00:00.0000000', N'17:00:00.0000000', N'12:13:59.0000000', NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.783', N'2021-08-04 23:23:14.783', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'21', N'1', N'1', N'2021-07-29', N'08:00:00.0000000', N'17:00:00.0000000', N'10:23:26.0000000', NULL, NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.790', N'2021-08-04 23:23:14.790', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'22', N'1', N'1', N'2021-07-30', N'08:00:00.0000000', N'17:00:00.0000000', NULL, N'16:03:08.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.790', N'2021-08-04 23:23:14.790', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'23', N'1', N'1', N'2021-08-02', N'08:00:00.0000000', N'17:00:00.0000000', NULL, N'18:35:41.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.793', N'2021-08-04 23:23:14.793', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'24', N'1', N'1', N'2021-08-03', N'08:00:00.0000000', N'17:00:00.0000000', N'10:39:26.0000000', N'17:08:08.0000000', NULL, NULL, N'1', N'1', N'9', N'8', N'1', N'1', NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:23:14.820', N'2021-08-04 23:23:14.820', N'6', NULL, NULL, NULL, NULL, NULL, N'159', NULL, NULL, NULL, N'6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'26', N'1', NULL, N'2021-08-04', N'07:00:00.0000000', N'17:00:00.0000000', NULL, N'19:33:33.0000000', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-04 23:26:59.970', N'2021-08-04 23:26:59.970', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'29', N'1', NULL, N'2021-08-05', N'07:00:00.0000000', N'17:00:00.0000000', N'11:30:33.0000000', N'17:55:58.0000000', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-05 11:46:00.200', N'2021-08-05 11:46:00.200', N'5', NULL, NULL, NULL, NULL, NULL, N'270', NULL, NULL, NULL, N'5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'445', N'1', NULL, N'2021-08-06', N'07:00:00.0000000', N'17:00:00.0000000', N'11:22:34.0000000', NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-06 00:49:00.177', N'2021-08-06 00:49:00.177', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'549', N'1', NULL, N'2021-08-07', N'08:00:00.0000000', N'12:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'4', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-07 00:00:00.123', N'2021-08-07 00:00:00.123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'552', N'1', NULL, N'2021-08-09', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-09 00:00:00.137', N'2021-08-09 00:00:00.137', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'555', N'1', NULL, N'2021-08-10', N'07:00:00.0000000', N'17:00:00.0000000', N'10:04:06.0000000', N'19:32:41.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-10 00:00:00.170', N'2021-08-10 00:00:00.170', NULL, NULL, NULL, NULL, NULL, NULL, N'184', NULL, NULL, NULL, N'6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'558', N'1', NULL, N'2021-08-11', N'07:00:00.0000000', N'17:00:00.0000000', NULL, N'20:38:01.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-11 00:00:00.143', N'2021-08-11 00:00:00.143', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10339', N'1', NULL, N'2021-08-12', N'07:00:00.0000000', N'17:00:00.0000000', N'07:32:20.0000000', N'17:32:30.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-12 17:00:00.487', N'2021-08-12 17:00:00.487', N'9', NULL, NULL, NULL, NULL, NULL, N'32', N'0', NULL, N'1', N'9', N'9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10342', N'1', NULL, N'2021-08-13', N'07:00:00.0000000', N'17:00:00.0000000', N'07:59:57.0000000', N'17:33:24.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-13 00:00:00.680', N'2021-08-13 00:00:00.680', N'9', NULL, NULL, N'9', NULL, NULL, N'59', N'0', NULL, N'1', N'9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10344', N'1', NULL, N'2021-08-14', N'08:00:00.0000000', N'12:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'4', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-14 00:00:00.663', N'2021-08-14 00:00:00.663', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10347', N'1', NULL, N'2021-08-16', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-16 00:00:00.530', N'2021-08-16 00:00:00.530', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10350', N'1', NULL, N'2021-08-17', N'07:00:00.0000000', N'17:00:00.0000000', NULL, N'18:30:39.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-17 11:00:00.557', N'2021-08-17 11:00:00.557', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10352', N'1', NULL, N'2021-08-15', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-17 21:11:35.797', N'2021-08-17 21:11:35.797', NULL, N'9', NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10354', N'1', NULL, N'2021-08-18', N'07:00:00.0000000', N'17:00:00.0000000', NULL, N'18:07:31.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-18 00:00:00.593', N'2021-08-18 00:00:00.593', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'5', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10357', N'1', NULL, N'2021-08-19', N'07:00:00.0000000', N'17:00:00.0000000', N'07:57:00.0000000', N'20:58:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-19 00:00:00.897', N'2021-08-19 00:00:00.897', NULL, NULL, NULL, NULL, NULL, NULL, N'57', N'0', NULL, N'1', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10360', N'1', NULL, N'2021-08-20', N'07:00:00.0000000', N'17:00:00.0000000', N'07:58:00.0000000', N'18:00:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-20 00:00:00.720', N'2021-08-20 00:00:00.720', NULL, NULL, NULL, NULL, NULL, NULL, N'58', N'0', NULL, N'1', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10364', N'1', NULL, N'2021-08-21', N'08:00:00.0000000', N'12:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'4', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-21 00:00:00.707', N'2021-08-21 00:00:00.707', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10366', N'1', NULL, N'2021-08-23', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-23 00:00:00.720', N'2021-08-23 00:00:00.720', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10369', N'1', NULL, N'2021-08-24', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-24 00:00:01.217', N'2021-08-24 00:00:01.217', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'0', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10372', N'1', NULL, N'2021-08-25', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-25 00:00:00.790', N'2021-08-25 00:00:00.790', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10374', N'1', NULL, N'2021-08-31', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-08-31 20:00:00.453', N'2021-08-31 20:00:00.453', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10379', N'1', NULL, N'2021-09-01', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-01 00:00:00.297', N'2021-09-01 00:00:00.297', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10382', N'1', NULL, N'2021-09-02', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-02 00:00:00.670', N'2021-09-02 00:00:00.670', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10384', N'1', NULL, N'2021-09-03', N'19:00:00.0000000', N'04:00:00.0000000', N'18:47:31.0000000', N'05:47:40.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-03 00:00:00.790', N'2021-09-03 00:00:00.790', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'0', N'10', NULL, N'0', N'6', NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10386', N'1', NULL, N'2021-09-06', N'19:00:00.0000000', N'04:00:00.0000000', N'18:44:33.0000000', N'04:44:44.0000000', NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-06 11:00:00.793', N'2021-09-06 11:00:00.793', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'0', N'9', NULL, N'0', N'6', NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10390', N'1', NULL, N'2021-09-07', N'19:00:00.0000000', N'04:00:00.0000000', N'19:46:39.0000000', N'04:15:48.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-07 00:00:00.393', N'2021-09-07 00:00:00.393', NULL, NULL, NULL, NULL, NULL, NULL, N'46', N'0', NULL, N'0', N'-15', NULL, N'0', N'6', NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10394', N'1', NULL, N'2021-09-08', N'07:00:00.0000000', N'17:00:00.0000000', N'07:57:00.0000000', N'20:58:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-08 00:00:00.530', N'2021-09-08 00:00:00.530', NULL, NULL, NULL, NULL, NULL, NULL, N'57', N'0', NULL, N'0', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10396', N'1', NULL, N'2021-09-09', N'07:00:00.0000000', N'17:00:00.0000000', N'07:57:00.0000000', N'20:58:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-09 00:00:00.453', N'2021-09-09 00:00:00.453', NULL, NULL, NULL, NULL, NULL, NULL, N'57', N'0', NULL, N'0', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10398', N'1', NULL, N'2021-09-10', N'07:00:00.0000000', N'17:00:00.0000000', N'07:57:00.0000000', N'20:58:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-10 00:00:00.407', N'2021-09-10 00:00:00.407', NULL, NULL, NULL, NULL, NULL, NULL, N'57', N'0', NULL, N'0', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10403', N'1', NULL, N'2021-09-11', N'08:00:00.0000000', N'12:00:00.0000000', N'07:57:00.0000000', N'12:05:00.0000000', NULL, NULL, N'1', NULL, N'4', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-11 00:00:00.390', N'2021-09-11 00:00:00.390', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'0', N'4', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10405', N'1', NULL, N'2021-09-13', N'08:00:00.0000000', N'17:00:00.0000000', N'07:45:00.0000000', N'17:15:00.0000000', NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-13 00:00:00.420', N'2021-09-13 00:00:00.420', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'0', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10407', N'1', NULL, N'2021-09-14', N'07:00:00.0000000', N'17:00:00.0000000', N'08:05:00.0000000', N'17:07:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-14 00:00:00.410', N'2021-09-14 00:00:00.410', NULL, NULL, NULL, NULL, NULL, NULL, N'65', N'0', NULL, N'0', N'8', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10434', N'1', NULL, N'2021-09-15', N'07:00:00.0000000', N'17:00:00.0000000', N'07:56:00.0000000', N'17:05:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-15 00:00:00.840', N'2021-09-15 00:00:00.840', NULL, NULL, NULL, NULL, NULL, NULL, N'56', N'1', NULL, N'0', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10437', N'1', NULL, N'2021-09-16', N'07:00:00.0000000', N'17:00:00.0000000', N'07:58:00.0000000', N'17:11:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-16 00:00:01.557', N'2021-09-16 00:00:01.557', NULL, NULL, NULL, NULL, NULL, NULL, N'58', N'1', NULL, N'0', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10439', N'1', NULL, N'2021-09-17', N'07:00:00.0000000', N'17:00:00.0000000', N'08:06:00.0000000', N'17:06:00.0000000', NULL, NULL, N'1', NULL, N'10', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-17 00:00:01.573', N'2021-09-17 00:00:01.573', NULL, NULL, NULL, NULL, NULL, NULL, N'66', N'1', NULL, N'0', N'8', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10443', N'1', NULL, N'2021-09-24', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'2', NULL, N'4', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-18 00:00:00.630', N'2021-09-18 00:00:00.630', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10446', N'1', NULL, N'2021-09-20', N'08:00:00.0000000', N'17:00:00.0000000', N'10:41:28.0000000', NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-20 00:00:00.787', N'2021-09-20 00:00:00.787', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'0', N'4', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10463', N'2', NULL, N'2021-09-20', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-20 20:00:00.723', N'2021-09-20 20:00:00.723', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10464', N'119', NULL, N'2021-09-20', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-20 20:00:00.727', N'2021-09-20 20:00:00.727', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10465', N'2', NULL, N'2021-09-21', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-21 00:00:00.620', N'2021-09-21 00:00:00.620', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10466', N'1', NULL, N'2021-09-21', N'07:00:00.0000000', N'17:00:00.0000000', N'09:45:49.0000000', NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-21 00:00:00.620', N'2021-09-21 00:00:00.620', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'5', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10467', N'119', NULL, N'2021-09-21', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-21 00:00:00.627', N'2021-09-21 00:00:00.627', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10468', N'2', NULL, N'2021-09-22', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-22 00:00:01.200', N'2021-09-22 00:00:01.200', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10469', N'1', NULL, N'2021-09-22', N'07:00:00.0000000', N'17:00:00.0000000', NULL, N'00:09:08.0000000', NULL, NULL, N'1', NULL, N'10', NULL, N'119', NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-22 00:00:01.203', N'2021-09-22 00:00:01.203', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'5', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10470', N'119', NULL, N'2021-09-22', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-22 00:00:01.207', N'2021-09-22 00:00:01.207', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10471', N'2', NULL, N'2021-09-23', N'07:00:00.0000000', N'17:00:00.0000000', N'06:27:54.0000000', NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-23 00:00:00.427', N'2021-09-23 00:00:00.427', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'5', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10472', N'1', NULL, N'2021-09-23', N'07:00:00.0000000', N'17:00:00.0000000', N'06:31:52.0000000', N'23:32:09.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-23 00:00:00.427', N'2021-09-23 00:00:00.427', N'10', N'6', NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'10', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10473', N'119', NULL, N'2021-09-23', N'07:00:00.0000000', N'17:00:00.0000000', N'07:32:41.0000000', N'19:32:49.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-23 00:00:00.430', N'2021-09-23 00:00:00.430', NULL, NULL, NULL, NULL, NULL, NULL, N'32', N'0', NULL, N'1', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10474', N'2', NULL, N'2021-09-24', N'07:00:00.0000000', N'17:00:00.0000000', N'06:32:58.0000000', N'17:33:06.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-24 00:00:00.467', N'2021-09-24 00:00:00.467', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', N'10', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10475', N'119', NULL, N'2021-09-24', N'07:00:00.0000000', N'17:00:00.0000000', N'06:04:41.0000000', N'16:50:50.0000000', NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-24 00:00:00.470', N'2021-09-24 00:00:00.470', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'9', N'1', N'9', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10476', N'2', NULL, N'2021-09-25', N'08:00:00.0000000', N'12:00:00.0000000', NULL, N'12:27:37.0000000', NULL, NULL, N'1', NULL, N'4', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-25 00:00:00.170', N'2021-09-25 00:00:00.170', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2', NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10477', N'1', NULL, N'2021-09-25', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'2', NULL, N'4', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-25 00:00:00.470', N'2021-09-25 00:00:00.470', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, N'2021-09-28 08:00:00.000', N'2021-09-28 17:00:00.000', N'2021-09-25 08:00:00.000', N'2021-09-25 12:00:00.000', N'1', NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10478', N'119', NULL, N'2021-09-25', N'08:00:00.0000000', N'12:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'4', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-25 00:00:00.477', N'2021-09-25 00:00:00.477', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'0', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10479', N'2', NULL, N'2021-09-27', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-27 21:00:00.587', N'2021-09-27 21:00:00.587', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10480', N'1', NULL, N'2021-09-27', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-27 21:00:00.587', N'2021-09-27 21:00:00.587', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10481', N'119', NULL, N'2021-09-27', N'08:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'9', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-27 21:00:00.587', N'2021-09-27 21:00:00.587', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10482', N'2', NULL, N'2021-09-28', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-28 01:00:00.167', N'2021-09-28 01:00:00.167', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10483', N'1', NULL, N'2021-09-28', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-28 01:00:00.530', N'2021-09-28 01:00:00.530', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours], [reg_special_holiday], [is_restday], [night_diff], [new_checkin], [new_checkout], [old_checkin], [old_checkout], [is_change_shift], [diff_date]) VALUES (N'10484', N'119', NULL, N'2021-09-28', N'07:00:00.0000000', N'17:00:00.0000000', NULL, NULL, NULL, NULL, N'1', NULL, N'10', NULL, NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'2021-09-28 01:00:00.530', N'2021-09-28 01:00:00.530', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

SET IDENTITY_INSERT [dbo].[shifts] OFF
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
-- Records of taxonomy
-- ----------------------------
SET IDENTITY_INSERT [dbo].[taxonomy] ON
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1', N'0', N'Department', NULL, NULL, N'1', N'1', N'1', NULL, NULL, N'2019-03-25 13:32:54.000', N'2019-06-25 15:33:41.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'2', N'0', N'Designation', NULL, NULL, N'1', N'2', N'1', NULL, NULL, N'2019-03-25 13:33:32.000', N'2019-07-12 18:21:11.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'3', N'0', N'Employment Status', NULL, NULL, N'1', N'3', N'1', NULL, NULL, N'2019-03-25 13:33:49.000', N'2019-06-25 15:33:49.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'4', N'2', N'Accounts receivable/payable specialist', NULL, NULL, N'1', N'1', N'0', NULL, NULL, N'2019-03-25 13:50:59.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'5', N'2', N'Assessor', NULL, NULL, N'1', N'2', N'0', NULL, NULL, N'2019-03-25 13:51:22.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'6', N'2', N'Auditor', NULL, NULL, N'1', N'3', N'0', NULL, NULL, N'2019-03-25 13:51:31.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'7', N'2', N'HR specialist', NULL, NULL, N'1', N'4', N'0', NULL, NULL, N'2019-03-25 13:51:39.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'9', N'1', N'Finance', NULL, NULL, N'1', N'2', N'0', NULL, NULL, N'2019-03-25 13:52:08.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'10', N'1', N'Information Technology', N'IT', NULL, N'1', N'3', N'0', NULL, NULL, N'2019-03-25 13:52:23.000', N'2019-03-25 16:33:19.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'11', N'1', N'Supply Chain Management', NULL, NULL, N'2', N'4', N'0', NULL, N'1', N'2019-03-25 13:52:39.000', N'2020-03-11 16:01:05.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'12', N'3', N'Full-time', NULL, NULL, N'1', N'1', N'0', NULL, NULL, N'2019-03-25 15:34:28.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'13', N'3', N'Probationary', NULL, NULL, N'1', N'2', N'0', NULL, NULL, N'2019-03-25 15:34:46.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'14', N'3', N'Project Based', NULL, NULL, N'1', N'3', N'0', NULL, NULL, N'2019-03-25 15:35:04.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'15', N'3', N'Seasonal', NULL, N'Seasonal employment is highly dependent on a specific season. This means that a job is only available at a specific time of the year and is meant to fulfill increased work demands associated with that specific season.', N'1', N'4', N'0', NULL, NULL, N'2019-03-25 15:35:29.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'16', N'2', N'Full Stack Developer', NULL, NULL, N'1', N'5', N'0', NULL, NULL, N'2019-03-26 17:41:50.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'21', N'0', N'Interview Evaluation Based on Competency', NULL, NULL, N'1', N'5', N'1', NULL, NULL, N'2019-06-25 15:27:58.000', N'2019-06-25 15:53:23.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'22', N'21', N'Was the candidate prepared for the interview?', NULL, NULL, N'1', N'1', N'0', NULL, NULL, N'2019-06-25 15:29:22.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'23', N'21', N'Does their experience appear to match what’s needed?', NULL, NULL, N'1', N'2', N'0', NULL, NULL, N'2019-06-25 15:29:52.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'24', N'21', N'Do they have some or all of the required credentials?', NULL, N'(For example, education, licenses, certifications?)', N'1', N'3', N'0', NULL, NULL, N'2019-06-25 15:30:14.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'25', N'21', N'How are their interpersonal skills?', NULL, N'(Friendly, smiling, outgoing, kind, fun, interactive?)', N'1', N'4', N'0', NULL, NULL, N'2019-06-25 15:30:38.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'26', N'0', N'Application Requirements', NULL, NULL, N'1', N'6', N'1', NULL, NULL, N'2019-07-02 18:06:33.000', N'2019-07-02 18:06:44.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'27', N'26', N'Birth Certificate', NULL, NULL, N'1', N'1', N'0', NULL, NULL, N'2019-07-02 18:07:04.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'28', N'26', N'NBI Clearance', NULL, NULL, N'1', N'2', N'0', NULL, NULL, N'2019-07-02 18:07:16.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'29', N'26', N'BIR forms', NULL, NULL, N'1', N'3', N'0', NULL, NULL, N'2019-07-02 18:07:59.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'30', N'26', N'Transcript of Records/ Diploma', NULL, NULL, N'1', N'4', N'0', NULL, NULL, N'2019-07-02 18:09:22.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'31', N'26', N'Certificate of Employment', N'COE', NULL, N'1', N'5', N'0', NULL, NULL, N'2019-07-02 18:10:01.000', NULL)
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'32', N'2', N'Seo Specialist', NULL, NULL, N'1', N'6', N'0', NULL, N'0', N'2019-07-05 19:31:15.000', N'2019-07-05 19:31:15.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'33', N'0', N'Account - Sales option', NULL, NULL, N'1', N'6', N'0', NULL, N'0', N'2019-09-25 20:23:55.000', N'2019-09-25 20:23:55.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'34', N'33', N'All', NULL, NULL, N'1', N'1', N'0', NULL, N'0', N'2019-09-25 20:24:13.000', N'2019-09-25 20:24:13.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'35', N'33', N'email01@jpm.ph', NULL, NULL, N'1', N'2', N'0', NULL, N'0', N'2019-09-25 20:24:34.000', N'2019-09-25 20:24:34.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'36', N'33', N'email02@jpm.ph', NULL, NULL, N'1', N'3', N'0', NULL, N'0', N'2019-09-25 20:24:47.000', N'2019-09-25 20:24:47.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'56', N'1', N'Marketing', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'57', N'2', N'Medical Assistant', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'58', N'2', N'Engineer', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'59', N'1', N'Purchasing', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'60', N'2', N'Project Manager', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'61', N'1', N'Production', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'62', N'2', N'Iron Worker', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:01.000', N'2019-09-27 18:23:01.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'63', N'1', N'supply chain', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:02.000', N'2019-09-27 18:23:02.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'64', N'2', N'Handyman', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-09-27 18:23:02.000', N'2019-09-27 18:23:02.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'65', N'1', N'DESIGN  ', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'66', N'2', N'DESIGN EXECUTIVE', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'70', N'2', N'DESIGN HEAD / EXEC', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'71', N'1', N'PURCHASING & LOGISTICS', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'73', N'1', N'MANAGEMENT', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'74', N'2', N'PRESIDENT', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'75', N'1', N'BUILD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'76', N'2', N'BUILD HEAD / PM', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'78', N'2', N'PURCHASING & LOGISTICS HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'80', N'2', N'GENERAL MANAGER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'81', N'1', N'BUILD - PERMITS', NULL, NULL, N'1', NULL, N'0', N'0', N'2', N'2019-10-30 05:56:29.000', N'2021-06-01 23:06:05.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'82', N'2', N'PERMIT STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'85', N'1', N'BUILD - COSTING', NULL, NULL, N'1', NULL, N'0', N'0', N'2', N'2019-10-30 05:56:29.000', N'2021-06-01 23:05:49.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'86', N'2', N'COSTING HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'87', N'1', N'ELECTRICAL', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'88', N'2', N'ELECTRICAL HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'89', N'2', N'DRIVER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'90', N'2', N'FINANCE HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'97', N'1', N'SALES', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'98', N'2', N'BUSINESS DEVT OFFICER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'102', N'2', N'PERMIT HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'104', N'1', N'DESIGN PROD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'105', N'2', N'DESIGN PRODUCTION STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'108', N'2', N'DESIGN EXECUTIVE ASST', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'111', N'1', N'MECHANICAL', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'112', N'2', N'MECHANICAL HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'114', N'2', N'ELECTRICAL TEAM LEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'115', N'1', N'EXECUTIVE', NULL, NULL, N'1', NULL, N'0', N'0', N'3', N'2019-10-30 05:56:29.000', N'2020-06-02 12:06:40.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'116', N'2', N'ASSET MANAGEMENT OFFICER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'118', N'2', N'PURCHASING & LOGISTICS STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'119', N'1', N'WAREHOUSE', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'120', N'2', N'WAREHOUSE STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'122', N'2', N'WAREHOUSE HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'124', N'2', N'MECHANICAL STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'130', N'2', N'JR ELECTRICAL TEAM LEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'136', N'2', N'DESIGN COORDINATOR', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'142', N'2', N'MATERIALS SPECIFICATION SPECIALIST', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'147', N'2', N'CREDIT AND COLLECTION OFFICER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'149', N'2', N'DESIGN PRODUCTIONS DRAWING HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'151', N'1', N'SERVICE WARRANTY', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'152', N'1', N'HR/ADMIN', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'153', N'2', N'HR HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'155', N'2', N'QUANTITY SURVEYOR', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'157', N'2', N'ACCOUNTING STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'164', N'1', N'SHOP', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'165', N'2', N'SHOP MANAGER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'167', N'2', N'MACHINE TECHNICIAN', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'178', N'2', N'SITE SUPERVISOR', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'180', N'2', N'AUXILIARY TEAM HEAD', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'182', N'2', N'SALES OFFICER', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'193', N'2', N'ELECTRICAL STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'200', N'2', N'HR STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'204', N'2', N'FOREMAN OPERATOR', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'239', N'1', N'ACCOUNTING and FINANCE', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'250', N'2', N'DESIGN ASSOCIATE', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'269', N'2', N'PRODUCTION STAFF', NULL, NULL, N'1', NULL, N'0', N'0', N'0', N'2019-10-30 05:56:29.000', N'2019-10-30 05:56:29.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'270', N'0', N'Team', NULL, NULL, N'1', N'7', N'0', N'1', N'0', N'2020-06-02 13:46:47.000', N'2020-06-02 13:46:47.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'271', N'270', N'Management', NULL, NULL, N'1', N'1', N'0', N'1', N'0', N'2020-06-02 13:46:57.000', N'2020-06-02 13:46:57.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'272', N'270', N'Sales', NULL, NULL, N'1', N'2', N'0', N'1', N'0', N'2020-06-02 13:47:12.000', N'2020-06-02 13:47:12.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'273', N'270', N'Design', NULL, NULL, N'1', N'3', N'0', N'1', N'0', N'2020-06-02 13:47:25.000', N'2020-06-02 13:47:25.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'274', N'270', N'Design Production', NULL, NULL, N'1', N'4', N'0', N'1', N'0', N'2020-06-02 13:47:45.000', N'2020-06-02 13:47:45.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'275', N'270', N'Build', NULL, NULL, N'1', N'5', N'0', N'1', N'0', N'2020-06-02 13:47:58.000', N'2020-06-02 13:47:58.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'277', N'270', N'Costing', NULL, NULL, N'1', N'7', N'0', N'1', N'0', N'2020-06-02 13:48:37.000', N'2020-06-02 13:48:37.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'278', N'270', N'Permits', NULL, NULL, N'1', N'8', N'0', N'1', N'0', N'2020-06-02 13:48:49.000', N'2020-06-02 13:48:49.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'279', N'270', N'Purchasing', NULL, NULL, N'1', N'9', N'0', N'1', N'0', N'2020-06-02 13:49:04.000', N'2020-06-02 13:49:04.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'280', N'270', N'Warehouse', NULL, NULL, N'1', N'10', N'0', N'1', N'0', N'2020-06-02 13:49:15.000', N'2020-06-02 13:49:15.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'281', N'270', N'Shop', NULL, NULL, N'1', N'11', N'0', N'1', N'0', N'2020-06-02 13:49:30.000', N'2020-06-02 13:49:30.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'282', N'270', N'Human Resources', NULL, NULL, N'1', N'12', N'0', N'1', N'0', N'2020-06-02 13:49:43.000', N'2020-06-02 13:49:43.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'283', N'270', N'Accounting and Finance', NULL, NULL, N'1', N'13', N'0', N'1', N'0', N'2020-06-02 13:50:03.000', N'2020-06-02 13:50:03.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'284', N'1', N'Commercial Group', NULL, NULL, N'1', N'25', N'0', NULL, N'0', N'2020-06-02 15:06:42.000', N'2020-06-02 15:06:42.000')
GO

INSERT INTO [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'285', N'1', N'Industrial Group', NULL, NULL, N'1', N'26', N'0', NULL, N'0', N'2020-06-02 15:06:58.000', N'2020-06-02 15:06:58.000')
GO

SET IDENTITY_INSERT [dbo].[taxonomy] OFF
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
-- Records of temp_in_out
-- ----------------------------
SET IDENTITY_INSERT [dbo].[temp_in_out] ON
GO

SET IDENTITY_INSERT [dbo].[temp_in_out] OFF
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
-- Records of tss
-- ----------------------------
SET IDENTITY_INSERT [dbo].[tss] ON
GO

INSERT INTO [dbo].[tss] ([id], [label], [start_date], [end_date], [created_at], [updated_at]) VALUES (N'3', N'Sample', N'2021-09-15', N'2021-09-30', N'2021-09-27 01:29:19.243', N'2021-09-27 01:29:19.243')
GO

SET IDENTITY_INSERT [dbo].[tss] OFF
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
-- Records of tss_data
-- ----------------------------
SET IDENTITY_INSERT [dbo].[tss_data] ON
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'25', N'1', NULL, N'2021-09-24', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.340', N'2021-09-26 23:16:52.340', NULL, N'10443')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'26', N'2', NULL, N'2021-09-23', N'5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.363', N'2021-09-26 23:16:52.363', NULL, N'10471')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'27', N'1', NULL, N'2021-09-23', N'10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'6', N'1', NULL, NULL, N'10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.373', N'2021-09-26 23:16:52.373', NULL, N'10472')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'28', N'119', NULL, N'2021-09-23', N'9', N'32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.397', N'2021-09-26 23:16:52.397', NULL, N'10473')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'29', N'2', NULL, N'2021-09-24', N'10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.400', N'2021-09-26 23:16:52.400', NULL, N'10474')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'30', N'119', NULL, N'2021-09-24', N'9', NULL, N'9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.400', N'2021-09-26 23:16:52.400', NULL, N'10475')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'31', N'2', NULL, N'2021-09-25', N'2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.410', N'2021-09-26 23:16:52.410', NULL, N'10476')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'32', N'119', NULL, N'2021-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-26 23:16:52.410', N'2021-09-26 23:16:52.410', NULL, N'10478')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'33', N'2', NULL, N'2021-09-22', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-27 17:57:38.877', N'2021-09-27 17:57:38.877', NULL, N'10468')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'34', N'1', NULL, N'2021-09-22', N'5', NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-27 17:57:38.877', N'2021-09-27 17:57:38.877', NULL, N'10469')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'35', N'119', NULL, N'2021-09-22', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-27 17:57:38.893', N'2021-09-27 17:57:38.893', NULL, N'10470')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'36', N'1', NULL, N'2021-09-25', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-27 20:42:41.667', N'2021-09-27 20:42:41.667', NULL, N'10477')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'37', N'2', NULL, N'2021-09-27', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-28 00:02:30.957', N'2021-09-28 00:02:30.957', NULL, N'10479')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'38', N'1', NULL, N'2021-09-27', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-28 00:02:30.957', N'2021-09-28 00:02:30.957', NULL, N'10480')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'39', N'119', NULL, N'2021-09-27', NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-28 00:02:30.977', N'2021-09-28 00:02:30.977', NULL, N'10481')
GO

INSERT INTO [dbo].[tss_data] ([id], [user_id], [tss_id], [date], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [noLogInOut], [shift_id]) VALUES (N'40', N'1', NULL, N'2021-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2021-09-28 01:00:09.643', N'2021-09-28 01:00:09.643', NULL, NULL)
GO

SET IDENTITY_INSERT [dbo].[tss_data] OFF
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
-- Records of tss_summary
-- ----------------------------
SET IDENTITY_INSERT [dbo].[tss_summary] ON
GO

INSERT INTO [dbo].[tss_summary] ([id], [tss_id], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [user_id]) VALUES (N'1', N'3', N'10', N'0', N'0', N'0', N'2', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'10', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'2021-09-27 01:29:19.343', N'2021-09-27 01:29:19.343', N'1')
GO

INSERT INTO [dbo].[tss_summary] ([id], [tss_id], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [user_id]) VALUES (N'2', N'3', N'17', N'0', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'2021-09-27 01:29:19.363', N'2021-09-27 01:29:19.363', N'2')
GO

INSERT INTO [dbo].[tss_summary] ([id], [tss_id], [RegHrs], [LateHrs], [UndertimeHrs], [NDHrs], [Absent], [Leave01], [Leave02], [Leave03], [Leave04], [Leave05], [Leave06], [Leave07], [Leave08], [Leave09], [Leave10], [Leave11], [Leave12], [Leave13], [Leave14], [Leave15], [Leave16], [Leave17], [Leave18], [Leave19], [Leave20], [OTHrs01], [OTHrs02], [OTHrs03], [OTHrs04], [OTHrs05], [OTHrs06], [OTHrs07], [OTHrs08], [OTHrs09], [OTHrs10], [OTHrs11], [OTHrs12], [OTHrs13], [OTHrs14], [OTHrs15], [OTHrs16], [OTHrs17], [OTHrs18], [OTHrs19], [OTHrs20], [OTHrs21], [OTHrs22], [OTHrs23], [OTHrs24], [OTHrs25], [Rate], [UnpaidRegHrs], [UnpaidSL], [UnpaidTaxSL], [UnpaidVL], [UnpaidTaxVL], [UnpaidEL], [EffectivityDate], [EmpStatus], [EffectivityDateResign], [created_at], [updated_at], [user_id]) VALUES (N'3', N'3', N'18', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'2021-09-27 01:29:19.390', N'2021-09-27 01:29:19.390', N'119')
GO

SET IDENTITY_INSERT [dbo].[tss_summary] OFF
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
-- Records of two_factor_authentication
-- ----------------------------
SET IDENTITY_INSERT [dbo].[two_factor_authentication] ON
GO

SET IDENTITY_INSERT [dbo].[two_factor_authentication] OFF
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
-- Records of undertime
-- ----------------------------
SET IDENTITY_INSERT [dbo].[undertime] ON
GO

INSERT INTO [dbo].[undertime] ([id], [user_id], [date], [time], [reason], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [created_at], [updated_at]) VALUES (N'5', N'1', N'2021-09-20', N'23:54:39.0000000', N'sample', N'1', N'1', N'119', NULL, NULL, N'c2132821-785d-4a03-bd1d-c80ea605bcd6', N'2021-09-20 15:01:18.690', N'2021-09-20 15:01:18.690')
GO

SET IDENTITY_INSERT [dbo].[undertime] OFF
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
-- Records of user_setting
-- ----------------------------
SET IDENTITY_INSERT [dbo].[user_setting] ON
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'1', N'1', N'1', N'1', N'3')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'2', N'2', N'1', N'1', N'3')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'3', N'108', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'4', N'84', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'5', N'79', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'6', N'7', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'7', N'58', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'8', N'47', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'9', N'116', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'10', N'18', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'11', N'37', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'12', N'107', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'13', N'104', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'14', N'11', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'15', N'114', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'16', N'93', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'17', N'29', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'18', N'68', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'19', N'105', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'20', N'36', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'21', N'48', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'22', N'110', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'23', N'90', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'24', N'8', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'25', N'54', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'26', N'35', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'27', N'94', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'28', N'63', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'29', N'39', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'30', N'4', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'31', N'9', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'32', N'6', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'33', N'26', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'34', N'71', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'35', N'85', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'36', N'30', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'37', N'38', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'38', N'24', N'0', N'0', N'1')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'39', N'75', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'40', N'67', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'41', N'12', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'42', N'89', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'43', N'83', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'44', N'53', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'45', N'91', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'46', N'16', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'47', N'81', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'48', N'42', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'49', N'49', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'50', N'113', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'51', N'106', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'52', N'59', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'53', N'76', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'54', N'70', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'55', N'117', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'56', N'45', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'57', N'55', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'58', N'60', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'59', N'15', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'60', N'31', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'61', N'44', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'62', N'23', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'63', N'74', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'64', N'50', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'65', N'22', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'66', N'51', N'0', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'67', N'65', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'68', N'32', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'69', N'115', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'70', N'34', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'71', N'78', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'72', N'62', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'73', N'88', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'74', N'96', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'75', N'25', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'76', N'43', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'77', N'95', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'78', N'100', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'79', N'97', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'80', N'33', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'81', N'41', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'82', N'10', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'83', N'28', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'84', N'19', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'85', N'98', N'0', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'86', N'112', N'1', N'0', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'87', N'118', N'1', N'1', N'2')
GO

INSERT INTO [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (N'88', N'119', NULL, NULL, N'3')
GO

SET IDENTITY_INSERT [dbo].[user_setting] OFF
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
-- Records of users
-- ----------------------------
SET IDENTITY_INSERT [dbo].[users] ON
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'1', N'0', N'TZPZJHkkY', N'Julius', NULL, NULL, NULL, N'Faigmani', N'Male', N'1989-07-14', N'e914d1a3-3d59-4f81-aacb-eb8d822a3632.jpg', N'', N'', N'177', N'Single', N'9954528315', N'julius.faigmani@gmail.com', N'juliusf', N'$2a$10$iSphFTqfXyfGyasyUDauCuF9fbUVh3tzQrJ4TVmOrnUy5N6i4IdnS', N'1', N'1,4', NULL, N'', N'', N'', N'', N'BB0000117', N'1', N'10', N'16', NULL, N'2019-09-02', NULL, N'1dccd37f-50f3-57e9-b78b-1f669bbf38fb', N'0', N'3', N'2019-10-01 14:29:30.000', N'2021-06-11 01:02:34.000', NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'3', N'0', N'A4349', N'RAYMOND', N'REYES', N'', N'', N'BATAPA', N'Male', N'1987-01-04', NULL, N'', N'', N'177', N'Single', N'09096215027', N'', NULL, NULL, N'1', N'4', NULL, N'08-2776782-7', N'1212-1247-9924', N'354-726-845', N'17-201075376-2', N'A4349', NULL, NULL, NULL, NULL, N'2019-02-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.167', N'2021-09-21 23:52:57.167', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'4', N'0', N'A2407', N'JULIUS', N'MENDOZA', N'', N'', N'BATANTE', N'Male', N'1994-07-06', NULL, N'', N'', N'177', N'Married', N'09094069354', N'', NULL, NULL, N'1', N'4', NULL, N'08-2443144-4', N'1211-1500-4114', N'317-221-763', N'18-025202960-3', N'A2407', NULL, NULL, NULL, NULL, N'2014-03-17', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.167', N'2021-09-21 23:52:57.167', N'0', N'PUROK 5', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'5', N'0', N'A4312', N'OWEN', N'NENIEL', N'', N'', N'AMBI', N'Male', N'1997-10-16', NULL, N'', N'', N'177', N'Single', N'09463289990', N'', NULL, NULL, N'1', N'4', NULL, N'34-8058768-7', N'1212-3988-6789', N'353-055-071', N'18-250474093-6', N'A4312', NULL, NULL, NULL, NULL, N'2018-12-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.270', N'2021-09-21 23:52:57.270', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'6', N'0', N'A0608', N'EDMUNDO', N'QUIANTE', N'', N'', N'BATAL', N'Male', N'1963-10-14', NULL, N'', N'', N'177', N'Married', N'', N'', NULL, NULL, N'1', N'4', NULL, N'06-0992607-7', N'1830-0067-5405', N'944-730-544', N'18-050053974-5', N'A0608', NULL, NULL, NULL, NULL, N'2007-07-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.270', N'2021-09-21 23:52:57.270', N'0', N'PUROK 9 UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'7', N'0', N'D7903', N'EDWIN', N'BADBADON', N'', N'', N'BATAL', N'Male', N'1992-06-15', NULL, N'', N'', N'177', N'Single', N'09101761330', N'', NULL, NULL, N'1', N'4', NULL, N'08-2601355-6', N'1211-5682-5702', N'', N'18-200752255-0', N'D7903', NULL, NULL, NULL, NULL, N'2015-09-23', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.473', N'2021-09-21 23:52:57.473', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'8', N'0', N'A4041', N'FELIXBERTO', N'POSESANO', N'JR', N'', N'BATAC', N'Male', N'1975-12-19', NULL, N'', N'', N'177', N'Married', N'09129707991', N'', NULL, NULL, N'1', N'4', NULL, N'09-1686279-8', N'1210-3038-2313', N'905-972-987', N'16-050117699-8', N'A4041', NULL, NULL, NULL, NULL, N'2018-04-17', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.477', N'2021-09-21 23:52:57.477', N'0', N'PUROK 1 SAINT PAUL DISTRICT', N'MANGAGOY', N'BISLIG', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'9', N'0', N'A4303', N'ELIEZER', N'DELA RAMA', N'', N'', N'BASTATAS', N'Male', N'1986-11-28', NULL, N'', N'', N'177', N'Married', N'09463607802', N'', NULL, NULL, N'1', N'4', NULL, N'08-1669165-8', N'1212-3846-1527', N'262-416-740', N'18-025183754-4', N'A4303', NULL, NULL, NULL, NULL, N'2018-12-03', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.627', N'2021-09-21 23:52:57.627', N'0', N'PUROK 1', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'10', N'0', N'A0355', N'RICHILOU', N'LAYAO', N'SR', N'', N'BASTASA', N'Male', N'1975-02-23', NULL, N'', N'', N'177', N'Married', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1673617-3', N'1830-0067-8558', N'299-271-654', N'18-050064469-7', N'A0355', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.630', N'2021-09-21 23:52:57.630', N'0', N'PUROK 2', N'PANIBASAN', N'MACO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'11', N'0', N'A1534', N'ANDIE', N'ENALISAN', N'', N'', N'AMPIS', N'Male', N'1976-07-23', NULL, N'', N'', N'177', N'Married', N'09123641794', N'', NULL, NULL, N'1', N'4', NULL, N'09-1773072-2', N'1210-5605-0724', N'231-190-557', N'08-050654330-8', N'A1534', NULL, NULL, NULL, NULL, N'2010-03-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.860', N'2021-09-21 23:52:57.860', N'0', N'PUROK 1-A BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'12', N'0', N'A2136', N'EDGARDO', N'MARCELINO', N'JR', N'', N'BATIAO', N'Male', N'1995-03-13', NULL, N'', N'', N'177', N'Single', N'09128585896', N'', NULL, NULL, N'1', N'4', NULL, N'08-2368480-7', N'1210-9627-5723', N'315-975-863', N'18-025192092-1', N'A2136', NULL, NULL, NULL, NULL, N'2013-07-02', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.863', N'2021-09-21 23:52:57.863', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'13', N'0', N'A2588', N'JUNREY', N'BEROU', N'', N'', N'BAYO', N'Male', N'1984-06-14', NULL, N'', N'', N'177', N'Single', N'09108830895', N'', NULL, NULL, N'1', N'4', NULL, N'08-1395281-1', N'1211-1800-1717', N'317-542-709', N'18-050054044-1', N'A2588', NULL, NULL, NULL, NULL, N'2014-11-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.863', N'2021-09-21 23:52:57.863', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'14', N'0', N'A0182', N'LENDEL', N'CABARON', N'', N'', N'BATIS', N'Male', N'1986-09-11', NULL, N'', N'', N'177', N'Single', N'09306791496', N'', NULL, NULL, N'1', N'4', NULL, N'08-1633715-8', N'1830-0068-2280', N'313-907-976', N'18-050057553-9', N'A0182', NULL, NULL, NULL, NULL, N'2012-03-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.867', N'2021-09-21 23:52:57.867', N'0', N'PUROK 2', N'EDUARDO G. MONTILLA', N'Las�Nieves', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'15', N'0', N'A1437', N'MIKE', N'MOTUS', N'', N'', N'BATOON', N'Male', N'1983-09-26', NULL, N'', N'', N'177', N'Married', N'09483246979', N'', NULL, NULL, N'1', N'4', NULL, N'09-2869650-9', N'1210-7652-8123', N'307-271-103', N'17-025187579-3', N'A1437', NULL, NULL, NULL, NULL, N'2012-11-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.867', N'2021-09-21 23:52:57.867', N'0', N'PUROK 2', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'16', N'0', N'A3899', N'JOEL', N'ENEROSA', N'', N'', N'AMORES', N'Male', N'1977-07-04', NULL, N'', N'', N'177', N'Married', N'09108336841', N'', NULL, NULL, N'1', N'4', NULL, N'09-1942826-5', N'1211-2572-3452', N'905-892-363', N'18-050064554-5', N'A3899', NULL, NULL, NULL, NULL, N'2017-11-17', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.867', N'2021-09-21 23:52:57.867', N'0', N'UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'17', N'0', N'A2462', N'MARJON', N'JABON', N'', N'', N'BAYADOG', N'Male', N'1988-08-29', NULL, N'', N'', N'177', N'Married', N'09487274338', N'', NULL, NULL, N'1', N'4', NULL, N'08-1808287-0', N'1210-0777-6804', N'400-065-333', N'18-050086950-8', N'A2462', NULL, NULL, NULL, NULL, N'2015-04-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.887', N'2021-09-21 23:52:57.887', N'0', N'PUROK 1 CADENA DE AMOR', N'CUEVAS', N'Trento', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'18', N'0', N'A4145', N'ALVIN', N'CABATUAN', N'', N'', N'AMPO', N'Male', N'1994-11-05', NULL, N'', N'', N'177', N'Single', N'09389918847', N'', NULL, NULL, N'1', N'4', NULL, N'09-4454851-8', N'1212-3130-4686', N'348-911-021', N'16-252577942-4', N'A4145', NULL, NULL, NULL, NULL, N'2018-08-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.890', N'2021-09-21 23:52:57.890', N'0', N'PUROK 4', N'PANIBASAN', N'MACO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'19', N'0', N'A4179', N'ALJOHN', N'AVE', N'', N'', N'BASILIO', N'Male', N'1995-11-15', NULL, N'', N'', N'177', N'Single', N'09485635934', N'', NULL, NULL, N'1', N'4', NULL, N'08-2844458-9', N'1212-2478-8220', N'721-258-897', N'18-025283074-8', N'A4179', NULL, NULL, NULL, NULL, N'2018-09-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.893', N'2021-09-21 23:52:57.893', N'0', N'PUROK 3', N'MABINI', N'PLACER', N'Surigao�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'20', N'0', N'A1597', N'PAULO', N'PALMA', N'', N'', N'AMPIT', N'Male', N'1986-08-24', NULL, N'', N'', N'177', N'Married', N'09463382653', N'', NULL, NULL, N'1', N'4', NULL, N'08-1659168-0', N'1830-0067-6850', N'266-425-071', N'18-050062908-6', N'A1597', NULL, NULL, NULL, NULL, N'2008-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.893', N'2021-09-21 23:52:57.893', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'21', N'0', N'A2477', N'AGAFITO', N'A�ABIEZA', N'', N'', N'ANDOYO', N'Male', N'1994-08-04', NULL, N'', N'', N'177', N'Married', N'09196796966', N'', NULL, NULL, N'1', N'4', NULL, N'08-2449998-1', N'1211-1539-2890', N'317-214-772', N'18-025223688-9', N'A2477', NULL, NULL, NULL, NULL, N'2015-03-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.893', N'2021-09-21 23:52:57.893', N'0', N'PUROK 9 NANGKA UPPER COO ', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'22', N'0', N'A0843', N'ELVIN', N'MONOY', N'JR', N'', N'ANINO', N'Male', N'1989-10-29', NULL, N'', N'', N'177', N'Married', N'09195092920', N'', NULL, NULL, N'1', N'4', NULL, N'08-1730916-9', N'1211-3653-9166', N'315-518-818', N'18-050081860-1', N'A0843', NULL, NULL, NULL, NULL, N'2012-03-15', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.907', N'2021-09-21 23:52:57.907', N'0', N'PUROK 6', N'TAGBAYAGAN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'23', N'0', N'A2587', N'RYAN', N'BEROU', N'', N'', N'BAYO', N'Male', N'1986-09-07', NULL, N'', N'', N'177', N'Married', N'09480552239', N'', NULL, NULL, N'1', N'4', NULL, N'08-1795753-7', N'1210-6554-1861', N'406-033-921', N'18-050097870-6', N'A2587', NULL, NULL, NULL, NULL, N'2014-12-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.907', N'2021-09-21 23:52:57.907', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'24', N'0', N'A4415', N'RAYMOND', N'MONGCAL', N'', N'', N'BATOY', N'Male', N'1996-01-03', NULL, N'', N'', N'177', N'Single', N'09381339756', N'', NULL, NULL, N'1', N'4', NULL, N'08-2931764-4', N'1212-4824-0154', N'000-000-000', N'18-025293588-4', N'A4415', NULL, NULL, NULL, NULL, N'2019-04-08', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.907', N'2021-09-21 23:52:57.907', N'0', N'PUROK 3-B', N'LIBERTAD', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'25', N'0', N'A2837', N'CESAR', N'ROSAL', N'', N'', N'BATTULAYAN', N'Male', N'1960-10-20', NULL, N'', N'', N'177', N'Married', N'09469126729', N'', NULL, NULL, N'1', N'4', NULL, N'09-0646803-4', N'1211-0392-1471', N'938-184-188', N'16-050322845-6', N'A2837', NULL, NULL, NULL, NULL, N'2005-03-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.910', N'2021-09-21 23:52:57.910', N'0', N'PUROK 3', N'SAN FRANCISCO', N'PANABO', N'Davao�del�Norte', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'26', N'0', N'A4265', N'LARK ANTHONY', N'LEBARIOS', N'', N'', N'BAULITE', N'Male', N'1996-07-09', NULL, N'', N'', N'177', N'Single', N'09502424866', N'', NULL, NULL, N'1', N'4', NULL, N'08-2834822-9', N'1212-2818-5994', N'000-000-000', N'18-050179687-3', N'A4265', NULL, NULL, NULL, NULL, N'2018-10-22', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.913', N'2021-09-21 23:52:57.913', N'0', N'PUROK 4', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'27', N'0', N'A4032', N'GENIBAL', N'CANAYAN', N'', N'', N'AMORIO', N'Male', N'1989-01-03', NULL, N'', N'', N'177', N'Single', N'09108649112', N'', NULL, NULL, N'1', N'4', NULL, N'34-7073930-6', N'1211-9890-3106', N'345-226-695', N'03-051359777-7', N'A4032', NULL, NULL, NULL, NULL, N'2018-04-02', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.913', N'2021-09-21 23:52:57.913', N'0', N'PUROK 6', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'28', N'0', N'A1778', N'LORETO', N'PATAC', N'', N'', N'BAYA', N'Male', N'1966-05-22', NULL, N'', N'', N'177', N'Single', N'09277783619', N'', NULL, NULL, N'1', N'4', NULL, N'09-1540420-9', N'1211-3468-0601', N'315-519-078', N'18-050105548-2', N'A1778', NULL, NULL, NULL, NULL, N'2012-07-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.917', N'2021-09-21 23:52:57.917', N'0', N'BOAN', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'29', N'0', N'A0548', N'ARNIEL', N'MENCEDEZ', N'', N'', N'A�ABIEZA', N'Male', N'1986-04-19', NULL, N'', N'', N'177', N'Married', N'09109779564', N'', NULL, NULL, N'1', N'4', NULL, N'08-1822420-1', N'1211-3554-9801', N'412-071-806', N'18-050090444-3', N'A0548', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.920', N'2021-09-21 23:52:57.920', N'0', N'PUROK 9 UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'30', N'0', N'A3918', N'KENT MARK', N'DALOS', N'', N'', N'ANDANTE', N'Male', N'1999-08-22', NULL, N'', N'', N'177', N'Single', N'09107289220', N'', NULL, NULL, N'1', N'4', NULL, N'34-7094049-6', N'1212-1420-3888', N'342-079-551', N'18-250361504-6', N'A3918', NULL, NULL, NULL, NULL, N'2017-12-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.920', N'2021-09-21 23:52:57.920', N'0', N'PUROK 8 SIMULAO', N'BUNAWAN BROOK', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'31', N'0', N'A4378', N'MARK DAVEE', N'MAGLALANG', N'', N'', N'ANGALA', N'Female', N'1984-05-12', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'02-1975049-7', N'1212-4524-1598', N'354-869-937', N'07-051078231-1', N'A4378', NULL, NULL, NULL, NULL, N'2019-03-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.920', N'2021-09-21 23:52:57.920', N'0', N'PUROK 5', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'32', N'0', N'A3840', N'JULITO', N'ROTOL', N'', N'', N'AMOZON', N'Male', N'1968-09-18', NULL, N'', N'', N'177', N'Married', N'09100422956', N'', NULL, NULL, N'1', N'4', NULL, N'09-1373011-1', N'1211-3738-8209', N'339-915-644', N'18-050113287-8', N'A3840', NULL, NULL, NULL, NULL, N'2017-08-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.923', N'2021-09-21 23:52:57.923', N'0', N'PUROK 1', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'33', N'0', N'A1596', N'NI�O', N'PALMA', N'', N'', N'AMPIT', N'Male', N'1977-10-26', NULL, N'', N'', N'177', N'Married', N'09999663468', N'', NULL, NULL, N'1', N'4', NULL, N'09-2238350-4', N'1830-0067-3620', N'934-744-205', N'18-050034704-8', N'A1596', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.923', N'2021-09-21 23:52:57.923', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'34', N'0', N'A2262', N'CHARLES', N'SUELO', N'', N'', N'ANDALES', N'Male', N'1982-06-25', NULL, N'', N'', N'177', N'Married', N'09071403470', N'', NULL, NULL, N'1', N'4', NULL, N'08-2136373-5', N'1210-8745-1893', N'315-956-090', N'18-050091654-9', N'A2262', NULL, NULL, NULL, NULL, N'2013-04-08', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.923', N'2021-09-21 23:52:57.923', N'0', N'PUROK 8', N'MATABAO', N'Buenavista', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'35', N'0', N'A2574', N'JUNNY', N'OBOS', N'', N'', N'ANCHANGCO', N'Male', N'1985-06-26', NULL, N'', N'', N'177', N'Married', N'09498276574', N'', NULL, NULL, N'1', N'4', NULL, N'08-1947617-1', N'1211-1501-7582', N'317-467-048', N'18-050113815-9', N'A2574', NULL, NULL, NULL, NULL, N'2014-05-08', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.927', N'2021-09-21 23:52:57.927', N'0', N'PUROK 3', N'LOS ARCOS', N'PROSPERIDAD', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'36', N'0', N'A3313', N'MARJUN', N'BERO', N'', N'', N'BAYO', N'Male', N'1995-03-08', NULL, N'', N'', N'177', N'Single', N'09483485869', N'', NULL, NULL, N'1', N'4', NULL, N'08-2532091-0', N'1211-3633-6967', N'337-476-707', N'18-050150542-9', N'A3313', NULL, NULL, NULL, NULL, N'2015-12-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.927', N'2021-09-21 23:52:57.927', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'37', N'0', N'A1775', N'SHOSAUROUS', N'PINES', N'', N'', N'BATOY', N'Male', N'1990-09-23', NULL, N'', N'', N'177', N'Single', N'09467127061', N'', NULL, NULL, N'1', N'4', NULL, N'08-2098219-1', N'1210-8280-5781', N'315-975-928', N'18-025187691-4', N'A1775', NULL, NULL, NULL, NULL, N'2013-02-22', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.927', N'2021-09-21 23:52:57.927', N'0', N'PUROK 7 KALINGAYAN', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'38', N'0', N'A3298', N'JEREMY', N' ', N'', N'', N'BUTAO', N'Male', N'1994-07-21', NULL, N'', N'', N'177', N'Married', N'09120279090', N'', NULL, NULL, N'1', N'4', NULL, N'08-2531960-4', N'1211-3685-4035', N'337-477-395', N'18-025235938-7', N'A3298', NULL, NULL, NULL, NULL, N'2015-11-20', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.927', N'2021-09-21 23:52:57.927', N'0', N'PUROK 8', N'BAYUGAN 2', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'39', N'0', N'A1777', N'EDUARDO', N'ALBISO', N'', N'', N'BAYABAYA', N'Male', N'1969-07-25', NULL, N'', N'', N'177', N'Married', N'09301324030', N'', NULL, NULL, N'1', N'4', NULL, N'09-1654629-2', N'1211-2411-1809', N'314-548-732', N'16-200555113-7', N'A1777', NULL, NULL, NULL, NULL, N'2012-11-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.930', N'2021-09-21 23:52:57.930', N'0', N'PUROK 3', N'MACOPA', N'MONKAYO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'40', N'0', N'A0057', N'MELVIN', N'CABATUAN', N'', N'', N'AMPO', N'Male', N'1990-07-15', NULL, N'', N'', N'177', N'Married', N'09102967720', N'', NULL, NULL, N'1', N'4', NULL, N'08-1956767-9', N'1211-3738-8955', N'313-617-821', N'18-050117653-0', N'A0057', NULL, NULL, NULL, NULL, N'2012-04-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.930', N'2021-09-21 23:52:57.930', N'0', N'PUROK 4', N'PANIBASAN', N'MACO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'41', N'0', N'A1779', N'MILA', N'MIJARES', N'', N'', N'BAYRON', N'Female', N'1972-07-25', NULL, N'', N'', N'177', N'Single', N'09499335090', N'', NULL, NULL, N'1', N'4', NULL, N'33-4152829-3', N'1211-3468-3854', N'314-549-758', N'18-025014255-0', N'A1779', NULL, NULL, NULL, NULL, N'2012-07-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.930', N'2021-09-21 23:52:57.930', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'42', N'0', N'A3032', N'JOSELITO', N'ORTEGA', N'', N'', N'ANOG', N'Male', N'1993-06-30', NULL, N'', N'', N'177', N'Married', N'09467115287', N'', NULL, NULL, N'1', N'4', NULL, N'08-2557330-1', N'1211-4699-5779', N'322-107-940', N'18-025240060-3', N'A3032', NULL, NULL, NULL, NULL, N'2015-05-08', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.940', N'2021-09-21 23:52:57.940', N'0', N'', N'IMELDA', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'43', N'0', N'A4137', N'JAIME', N'VILLASAN', N'III', N'', N'AMPOL', N'Male', N'1994-07-17', NULL, N'', N'', N'177', N'Single', N'09307121430', N'', NULL, NULL, N'1', N'4', NULL, N'08-2813646-0', N'1212-2391-9236', N'348-074-729', N'18-050178020-9', N'A4137', NULL, NULL, NULL, NULL, N'2018-08-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.940', N'2021-09-21 23:52:57.940', N'0', N'PUROK 7', N'PASTA', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'44', N'0', N'A2137', N'REY ANTHONY', N'', N'', N'', N'BAYOR', N'Male', N'1994-04-24', NULL, N'', N'', N'177', N'Single', N'09092049352', N'', NULL, NULL, N'1', N'4', NULL, N'08-2374365-4', N'1210-9656-2248', N'315-976-139', N'18-025192561-3', N'A2137', NULL, NULL, NULL, NULL, N'2013-07-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.940', N'2021-09-21 23:52:57.940', N'0', N'PUROK 7', N'LOS ARCOS', N'PROSPERIDAD', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'45', N'0', N'A0061', N'JEREMIAH ANDRES', N'BRIONES', N'', N'', N'BAUTISTA', N'Male', N'1975-03-30', NULL, N'', N'', N'177', N'Single', N'09122659698', N'', NULL, NULL, N'1', N'4', NULL, N'09-3194009-3', N'1210-8699-9622', N'315-976-034', N'18-025188050-4', N'A0061', NULL, NULL, NULL, NULL, N'2014-02-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.943', N'2021-09-21 23:52:57.943', N'0', N'PUROK 3-B', N'LIBERTAD', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'46', N'0', N'A0793', N'MELBOR', N'GUCOR', N'', N'', N'AMPONG', N'Male', N'1983-05-07', NULL, N'', N'', N'177', N'Married', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1396267-8', N'1830-0067-3942', N'939-905-284', N'18-050043247-9', N'A0793', NULL, NULL, NULL, NULL, N'2006-03-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.947', N'2021-09-21 23:52:57.947', N'0', N'', N'LA UNION', N'CABADBARAN', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'47', N'0', N'A2268', N'DANIEL', N'GARCIA', N'', N'', N'ANDRES', N'Male', N'1987-11-18', NULL, N'', N'', N'177', N'Single', N'09488886152', N'', NULL, NULL, N'1', N'4', NULL, N'08-2368478-4', N'1211-0110-9712', N'421-655-122', N'17-201187242-0', N'A2268', NULL, NULL, NULL, NULL, N'2014-05-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.947', N'2021-09-21 23:52:57.947', N'0', N'PUROK 1-A BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'48', N'0', N'A1659', N'JHAVE', N'TUMACMOL', N'', N'', N'BATULAN', N'Male', N'1984-06-19', NULL, N'', N'', N'177', N'Married', N'09081289796', N'', NULL, NULL, N'1', N'4', NULL, N'08-1960330-0', N'1210-7389-8168', N'424-576-618', N'18-025178270-7', N'A1659', NULL, NULL, NULL, NULL, N'2012-07-31', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.950', N'2021-09-21 23:52:57.950', N'0', N'PUROK 7', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'49', N'0', N'A1230', N'EDGAR', N'MIRAFUENTES', N'', N'', N'BAYOR', N'Male', N'1983-08-18', NULL, N'', N'', N'177', N'Single', N'09304556091', N'', NULL, NULL, N'1', N'4', NULL, N'08-1753565-8', N'1211-2311-6338', N'416-219-235', N'18-050078366-2', N'A1230', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.950', N'2021-09-21 23:52:57.950', N'0', N'PUROK DURIAN', N'SAN AGUSTIN', N'TALACOGON', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'50', N'0', N'A3373', N'ARCEO', N'ROA', N'', N'', N'ANIBAN', N'Male', N'1956-03-23', NULL, N'', N'', N'177', N'Married', N'09107422861', N'', NULL, NULL, N'1', N'4', NULL, N'08-6100216-4', N'1210-6781-5085', N'143-294-208', N'18-050090733-7', N'A3373', NULL, NULL, NULL, NULL, N'2016-01-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.950', N'2021-09-21 23:52:57.950', N'0', N'PUROK 3 AMBANGAN', N'AMBAGO', N'BUTUAN', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'51', N'0', N'A0441', N'JESSIE BOY', N'LAZAGA', N'', N'', N'ANI�ON', N'Male', N'1979-01-09', NULL, N'', N'', N'177', N'Married', N'09472206334', N'', NULL, NULL, N'1', N'4', NULL, N'08-1519268-2', N'1830-0067-4675', N'210-371-122', N'12-050297366-0', N'A0441', NULL, NULL, NULL, NULL, N'2007-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.950', N'2021-09-21 23:52:57.950', N'0', N'Road 28 UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'52', N'0', N'A2700', N'RANDY', N'GUCOR', N'', N'', N'AMPONG', N'Male', N'1981-11-18', NULL, N'', N'', N'177', N'Married', N'09106546322', N'', NULL, NULL, N'1', N'4', NULL, N'08-1348787-8', N'1210-9480-7299', N'318-771-203', N'18-050030430-6', N'A2700', NULL, NULL, NULL, NULL, N'2014-04-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.953', N'2021-09-21 23:52:57.953', N'0', N'', N'LA UNION', N'CABADBARAN', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'53', N'0', N'A1392', N'CHALYN MAE', N'ANGCHANGCO', N'', N'', N'ANDANTE', N'Female', N'1989-06-27', NULL, N'', N'', N'177', N'Married', N'09104711540', N'', NULL, NULL, N'1', N'4', NULL, N'08-2097620-4', N'1210-8280-7066', N'432-940-529', N'18-025187553-5', N'A1392', NULL, NULL, NULL, NULL, N'2013-02-20', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.953', N'2021-09-21 23:52:57.953', N'0', N'PUROK 1-B', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'54', N'0', N'A2293', N'JIMBOY', N'JACOSALEM', N'', N'', N'BUTUAN', N'Female', N'1994-12-17', NULL, N'', N'', N'177', N'Single', N'09125358930', N'', NULL, NULL, N'1', N'4', NULL, N'08-2400614-1', N'1211-0109-9367', N'315-979-963', N'18-025195616-0', N'A2293', NULL, NULL, NULL, NULL, N'2013-09-18', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.957', N'2021-09-21 23:52:57.957', N'0', N'PUROK 5', N'LAPINIGAN', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'55', N'0', N'A0705', N'ARNEL', N'SAGA', N'', N'', N'ANOYA', N'Male', N'1977-06-02', NULL, N'', N'', N'177', N'Single', N'09161772969', N'', NULL, NULL, N'1', N'4', NULL, N'08-1709187-5', N'1211-3483-9758', N'412-074-539', N'18-050070596-3', N'A0705', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.970', N'2021-09-21 23:52:57.970', N'0', N'PUROK NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'56', N'0', N'A1354', N'JERRY', N'B', N'', N'', N'BUTLIG', N'Male', N'1987-09-05', NULL, N'', N'', N'177', N'Married', N'09286632130', N'', NULL, NULL, N'1', N'4', NULL, N'08-1875849-2', N'1210-7441-3425', N'416-222-384', N'18-050101244-9', N'A1354', NULL, NULL, NULL, NULL, N'2011-06-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.970', N'2021-09-21 23:52:57.970', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'57', N'0', N'A3125', N'CHARLENE', N'BUO', N'', N'', N'AYA', N'Female', N'1996-05-19', NULL, N'', N'', N'177', N'Single', N'09307366323', N'', NULL, NULL, N'1', N'4', NULL, N'09-3934049-1', N'1211-5089-5642', N'337-476-090', N'16-025682255-2', N'A3125', NULL, NULL, NULL, NULL, N'2015-12-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.973', N'2021-09-21 23:52:57.973', N'0', N'PUROK NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'58', N'0', N'D7832', N'JOMARK ANTHONY', N'MONDEJAR', N'', N'', N'AYALA', N'Female', N'1993-07-28', NULL, N'', N'', N'177', N'Single', N'09075700401', N'', NULL, NULL, N'1', N'4', NULL, N'08-2508225-8', N'0000-0000-0000', N'', N'18-025232007-3', N'D7832', NULL, NULL, NULL, NULL, N'2016-03-14', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.973', N'2021-09-21 23:52:57.973', N'0', N'PUROK 4 ', N'BUNAWAN BROOK', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'59', N'0', N'A0180', N'LOLITA', N'BUO', N'', N'', N'AYA', N'Female', N'1974-10-08', NULL, N'', N'', N'177', N'Married', N'09127427735', N'', NULL, NULL, N'1', N'4', NULL, N'09-2864745-1', N'1211-3578-9461', N'315-525-954', N'18-050272474-3', N'A0180', NULL, NULL, NULL, NULL, N'2012-04-17', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.973', N'2021-09-21 23:52:57.973', N'0', N'PUROK 9', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'60', N'0', N'A3643', N'JOSRIEL', N' ', N'', N'', N'BUTUAN', N'Female', N'1998-08-07', NULL, N'', N'', N'177', N'Single', N'09126746539', N'', NULL, NULL, N'1', N'4', NULL, N'34-6399692-3', N'1211-8733-6250', N'333-071-418', N'18-025262304-1', N'A3643', NULL, NULL, NULL, NULL, N'2016-12-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.977', N'2021-09-21 23:52:57.977', N'0', N'PUROK 1', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'61', N'0', N'A4151', N'APOLINARIO', N'MARFIL', N'', N'', N'ANDICO', N'Male', N'1975-12-19', NULL, N'', N'', N'177', N'Married', N'09383174725', N'', NULL, NULL, N'1', N'4', NULL, N'08-1280883-0', N'1212-2479-2951', N'000-000-000', N'18-200405441-6', N'A4151', NULL, NULL, NULL, NULL, N'2018-08-20', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.980', N'2021-09-21 23:52:57.980', N'0', N'PUROK 4', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'62', N'0', N'A1793', N'CRIS ANTHONY', N'CANTIGA', N'', N'', N'BRUNO', N'Male', N'1988-08-11', NULL, N'', N'', N'177', N'Married', N'09993754104', N'', NULL, NULL, N'1', N'4', NULL, N'08-1899561-1', N'1211-3668-7104', N'313-669-676', N'18-050105523-7', N'A1793', NULL, NULL, NULL, NULL, N'2013-07-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.980', N'2021-09-21 23:52:57.980', N'0', N'PUROK 4', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'63', N'0', N'A3667', N'JESAN', N'VILLANCIO', N'', N'', N'AYATON', N'Female', N'1994-03-06', NULL, N'', N'', N'177', N'Single', N'09108635997', N'', NULL, NULL, N'1', N'4', NULL, N'08-2596068-4', N'1211-8918-3006', N'332-624-745', N'18-251544675-4', N'A3667', NULL, NULL, NULL, NULL, N'2016-12-03', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.980', N'2021-09-21 23:52:57.980', N'0', N'PUROK 1', N'CABANTAO', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'64', N'0', N'A4225', N'RANDY', N'MEASCO', N'', N'', N'ANTIBO', N'Male', N'1994-08-02', NULL, N'', N'', N'177', N'Married', N'09382178513', N'', NULL, NULL, N'1', N'4', NULL, N'34-6160480-6', N'1211-7670-3806', N'350-232-410', N'18-050165846-2', N'A4225', NULL, NULL, NULL, NULL, N'2018-10-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.990', N'2021-09-21 23:52:57.990', N'0', N'PUROK 5', N'MARFIL', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'65', N'0', N'A0145', N'JAY RYAN', N'RUGAS', N'', N'', N'ANCHETA', N'Male', N'1990-04-29', NULL, N'', N'', N'177', N'Married', N'09463281650', N'', NULL, NULL, N'1', N'4', NULL, N'08-1945984-2', N'1211-3669-1893', N'313-908-091', N'18-050115279-8', N'A0145', NULL, NULL, NULL, NULL, N'2012-04-25', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.993', N'2021-09-21 23:52:57.993', N'0', N'PUROK 6', N'POBLACION', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'66', N'0', N'A1796', N'ALBERT', N'NOCALAN', N'', N'', N'BUTLIG', N'Male', N'1993-04-26', NULL, N'', N'', N'177', N'Married', N'09485146102', N'', NULL, NULL, N'1', N'4', NULL, N'08-1903461-0', N'1211-3707-2522', N'315-061-424', N'18-050106202-0', N'A1796', NULL, NULL, NULL, NULL, N'2012-01-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.993', N'2021-09-21 23:52:57.993', N'0', N'PUROK 6', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'67', N'0', N'A4255', N'ROLAND', N'BISTOYONG', N'', N'', N'AYALA', N'Male', N'1991-06-19', NULL, N'', N'', N'177', N'Single', N'09466693660', N'', NULL, NULL, N'1', N'4', NULL, N'09-3475208-4', N'1211-1416-5853', N'448-205-537', N'16-050615902-1', N'A4255', NULL, NULL, NULL, NULL, N'2018-10-15', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.997', N'2021-09-21 23:52:57.997', N'0', N'PUROK 1', N'IMELDA', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'68', N'0', N'A2959', N'RHOE', N'SALOMES', N'', N'', N'BAYLON', N'Male', N'1975-04-19', NULL, N'', N'', N'177', N'Married', N'09105747478', N'', NULL, NULL, N'1', N'4', NULL, N'08-1031412-2', N'1212-0085-5551', N'319-225-218', N'18-200279176-6', N'A2959', NULL, NULL, NULL, NULL, N'2015-04-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:57.997', N'2021-09-21 23:52:57.997', N'0', N'', N'BENIGNO AQUINO', N'HINATUAN', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'69', N'0', N'A3767', N'JANICE', N'SUMALINOG', N'', N'', N'AYATON', N'Female', N'1995-10-30', NULL, N'', N'', N'177', N'Single', N'09108635997', N'', NULL, NULL, N'1', N'4', NULL, N'09-4001500-3', N'1211-9818-4049', N'335-963-034', N'16-050693272-3', N'A3767', NULL, NULL, NULL, NULL, N'2017-03-27', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.000', N'2021-09-21 23:52:58.000', N'0', N'SIMULAO', N'BUNAWAN BROOK', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'70', N'0', N'A3479', N'ANECITO', N'VILLAHERMOSA', N'', N'', N'AYCO', N'Female', N'1984-07-23', NULL, N'', N'', N'177', N'Single', N'09468393591', N'', NULL, NULL, N'1', N'4', NULL, N'09-2822463-8', N'1210-9593-9750', N'328-357-660', N'12-050654670-8', N'A3479', NULL, NULL, NULL, NULL, N'2016-06-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.007', N'2021-09-21 23:52:58.007', N'0', N'', N'SAN ROQUE', N'Trento', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'71', N'0', N'A1242', N'CHRISTIE', N'ARMODIA', N'', N'', N'CABAL', N'Female', N'1982-10-26', NULL, N'', N'', N'177', N'Single', N'09109157558', N'', NULL, NULL, N'1', N'4', NULL, N'06-1899453-7', N'1830-0068-2279', N'280-018-912', N'18-050064954-0', N'A1242', NULL, NULL, NULL, NULL, N'2009-07-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.050', N'2021-09-21 23:52:58.050', N'0', N'PUROK 3-B', N'KARAUS', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'72', N'0', N'A2289', N'ELEUDEJIE', N'GUERRERO', N'', N'', N'AYES', N'Female', N'1986-02-20', NULL, N'', N'', N'177', N'Single', N'09094068795', N'', NULL, NULL, N'1', N'4', NULL, N'09-3624645-9', N'1211-0248-0469', N'315-928-010', N'18-025194834-6', N'A2289', NULL, NULL, NULL, NULL, N'2014-02-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.060', N'2021-09-21 23:52:58.060', N'0', N'', N'LIBERTAD', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'73', N'0', N'A0151', N'FRACHYNJUN', N'CELOSIA', N'', N'', N'CABAHUG', N'Female', N'1979-05-30', NULL, N'', N'', N'177', N'Single', N'09262201541', N'', NULL, NULL, N'1', N'4', NULL, N'08-1200431-7', N'1210-7399-9468', N'315-521-747', N'01-050842581-9', N'A0151', NULL, NULL, NULL, NULL, N'2013-05-25', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.060', N'2021-09-21 23:52:58.060', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'74', N'0', N'A3834', N'JOHN MARK', N'SALDE', N'', N'', N'BUSAYONG', N'Female', N'1999-01-31', NULL, N'', N'', N'177', N'Single', N'09468082195', N'', NULL, NULL, N'1', N'4', NULL, N'34-6840582-0', N'1212-0180-4128', N'339-822-895', N'18-251553880-2', N'A3834', NULL, NULL, NULL, NULL, N'2017-08-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.063', N'2021-09-21 23:52:58.063', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'75', N'0', N'A4014', N'JUSTINES', N'GALLAR', N'', N'', N'BURLAT', N'Female', N'1996-04-01', NULL, N'', N'', N'177', N'Single', N'09300558222', N'', NULL, NULL, N'1', N'4', NULL, N'34-6656048-2', N'1211-9504-7835', N'344-819-253', N'16-251940137-1', N'A4014', NULL, NULL, NULL, NULL, N'2018-03-12', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.067', N'2021-09-21 23:52:58.067', N'0', N'', N'ANDILI', N'MAWAB', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'76', N'0', N'A3573', N'ALVIE', N'MONTERA', N'', N'', N'BUSTILLO', N'Female', N'1991-10-08', NULL, N'', N'', N'177', N'Single', N'09307607166', N'', NULL, NULL, N'1', N'4', NULL, N'08-2474601-6', N'1211-1082-9870', N'331-004-321', N'18-025240941-4', N'A3573', NULL, NULL, NULL, NULL, N'2016-12-14', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.070', N'2021-09-21 23:52:58.070', N'0', N'PUROK 15', N'POBLACION', N'Bayugan', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'77', N'0', N'A0760', N'DANILO', N'FERNANDEZ', N'', N'', N'AZARCON', N'Female', N'1972-07-27', NULL, N'', N'', N'177', N'Single', N'09124310878', N'', NULL, NULL, N'1', N'4', NULL, N'09-1912138-4', N'1830-0067-8447', N'270-820-928', N'16-200418008-9', N'A0760', NULL, NULL, NULL, NULL, N'2008-12-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.070', N'2021-09-21 23:52:58.070', N'0', N'PUROK 9 NANGKA', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'78', N'0', N'A1576', N'MARILYN', N'JACOSALEM', N'', N'', N'BUTUAN', N'Female', N'1969-09-07', NULL, N'', N'', N'177', N'Single', N'09481812387', N'', NULL, NULL, N'1', N'4', NULL, N'08-1598125-9', N'1830-0067-6649', N'942-232-794', N'18-050051117-4', N'A1576', NULL, NULL, NULL, NULL, N'2007-05-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.073', N'2021-09-21 23:52:58.073', N'0', N'PUROK 5', N'LAPINIGAN', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'79', N'0', N'A3203', N'BENJIE LOU', N'CUTEJO', N'', N'', N'AZARCON', N'Female', N'1994-05-07', NULL, N'', N'', N'177', N'Single', N'09489707204', N'', NULL, NULL, N'1', N'4', NULL, N'08-2594417-6', N'1211-5216-4584', N'323-431-881', N'18-250499705-8', N'A3203', NULL, NULL, NULL, NULL, N'2016-01-24', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.073', N'2021-09-21 23:52:58.073', N'0', N'PUROK 8', N'ALEGRIA', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'80', N'0', N'A0685', N'NOEL', N'TINGSON', N'', N'', N'AYSON', N'Female', N'1975-11-23', NULL, N'', N'', N'177', N'Single', N'09169626491', N'', NULL, NULL, N'1', N'4', NULL, N'08-1512791-6', N'1830-0068-1592', N'264-347-103', N'18-025108159-8', N'A0685', NULL, NULL, NULL, NULL, N'2008-08-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.077', N'2021-09-21 23:52:58.077', N'0', N'PUROK 1-A', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'81', N'0', N'A4018', N'KYLE RATHZEL MAE', N'YTING', N'', N'', N'BUSTAMANTE', N'Female', N'1997-04-24', NULL, N'', N'', N'177', N'Single', N'09096642128', N'', NULL, NULL, N'1', N'4', NULL, N'08-2825477-9', N'1212-1964-6200', N'344-721-613', N'16-250864419-1', N'A4018', NULL, NULL, NULL, NULL, N'2018-03-19', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.077', N'2021-09-21 23:52:58.077', N'0', N'PUROK OCITE', N'SANTA CRUZ', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'82', N'0', N'A0555', N'ANTHONY', N'ALO', N'SR', N'', N'CABAL', N'Female', N'1973-11-02', NULL, N'', N'', N'177', N'Single', N'09092053830', N'', NULL, NULL, N'1', N'4', NULL, N'08-2117467-8', N'1210-4019-6452', N'174-500-617', N'18-000026823-0', N'A0555', NULL, NULL, NULL, NULL, N'2011-05-17', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.080', N'2021-09-21 23:52:58.080', N'0', N'PUROK 2', N'SUMILIHON', N'BUTUAN', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'83', N'0', N'A0994', N'FELIX', N'A�ORA', N'JR', N'', N'CABAL', N'Female', N'1976-02-08', NULL, N'', N'', N'177', N'Single', N'09499233938', N'', NULL, NULL, N'1', N'4', NULL, N'09-1654759-2', N'1830-0067-3487', N'931-290-118', N'18-050032443-9', N'A0994', NULL, NULL, NULL, NULL, N'2006-03-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.080', N'2021-09-21 23:52:58.080', N'0', N'UPPER COO', N'BAYUGAN 3', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'84', N'0', N'A0333', N'JOSE', N'CAMARA', N'JR', N'', N'BUSTAMANTE', N'Female', N'1974-04-28', NULL, N'', N'', N'177', N'Single', N'09079075543', N'', NULL, NULL, N'1', N'4', NULL, N'08-1660422-1', N'1830-0067-8702', N'283-881-182', N'18-050062982-5', N'A0333', NULL, NULL, NULL, NULL, N'2009-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.083', N'2021-09-21 23:52:58.083', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'85', N'0', N'A0510', N'MARLON', N'GALENDEZ', N'', N'', N'AYUBAN', N'Female', N'1983-03-30', NULL, N'', N'', N'177', N'Single', N'09306072927', N'', NULL, NULL, N'1', N'4', NULL, N'33-8263855-3', N'1211-3579-0204', N'237-418-381', N'01-050113274-3', N'A0510', NULL, NULL, NULL, NULL, N'2011-05-16', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.083', N'2021-09-21 23:52:58.083', N'0', N'PUROK 6', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'86', N'0', N'A3492', N'JAYZIER', N'JAYNUDDIN', N'', N'', N'AYROSO', N'Female', N'1981-04-12', NULL, N'', N'', N'177', N'Single', N'09463581866', N'', NULL, NULL, N'1', N'4', NULL, N'34-0064270-6', N'1210-9474-5144', N'328-836-664', N'16-050462120-8', N'A3492', NULL, NULL, NULL, NULL, N'2016-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.083', N'2021-09-21 23:52:58.083', N'0', N'PUROK 3', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'87', N'0', N'A0993', N'ROMEL', N'MALASA', N'', N'', N'BUSTILLO', N'Female', N'1977-01-11', NULL, N'', N'', N'177', N'Single', N'09104437912', N'', NULL, NULL, N'1', N'4', NULL, N'08-1343212-4', N'1210-8585-5972', N'412-069-868', N'18-050029572-2', N'A0993', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.087', N'2021-09-21 23:52:58.087', N'0', N'PUROK 2', N'PATROCINIO', N'Santa�Josefa', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'88', N'0', N'A1471', N'LORETO', N'DELA CRUZ', N'', N'', N'CABALBAG', N'Female', N'1972-02-18', NULL, N'', N'', N'177', N'Single', N'09301426162', N'', NULL, NULL, N'1', N'4', NULL, N'08-1902096-7', N'1210-7438-1444', N'422-039-789', N'23-001419077-0', N'A1471', NULL, NULL, NULL, NULL, N'2011-10-20', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.193', N'2021-09-21 23:52:58.193', N'0', N'PUROK 2', N'BAYUGAN 3', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'89', N'0', N'A1472', N'JUNIE', N'PAINAGAN', N'', N'', N'CABALES', N'Female', N'1977-08-26', NULL, N'', N'', N'177', N'Single', N'09309936042', N'', NULL, NULL, N'1', N'4', NULL, N'08-1499391-8', N'1830-0067-6650', N'939-898-993', N'18-050038395-8', N'A1472', NULL, NULL, NULL, NULL, N'2007-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.193', N'2021-09-21 23:52:58.193', N'0', N'BOAN', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'90', N'0', N'A3828', N'JESSA', N'TADLE', N'', N'', N'CADAY', N'Female', N'1990-01-01', NULL, N'', N'', N'177', N'Single', N'09488289390', N'', NULL, NULL, N'1', N'4', NULL, N'08-2547320-7', N'1211-4046-9893', N'451-621-070', N'18-025238321-0', N'A3828', NULL, NULL, NULL, NULL, N'2017-08-08', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.247', N'2021-09-21 23:52:58.247', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'91', N'0', N'A3102', N'CARLITO', N'LAPORE', N'III', N'', N'CADIOG', N'Female', N'1974-09-21', NULL, N'', N'', N'177', N'Single', N'09306406157', N'', NULL, NULL, N'1', N'4', NULL, N'08-2571284-5', N'1211-5078-9356', N'407-387-632', N'18-200716954-0', N'A3102', NULL, NULL, NULL, NULL, N'2015-11-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.247', N'2021-09-21 23:52:58.247', N'0', N'PUROK 3', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'92', N'0', N'A1794', N'TOMMY', N'VILLA', N'', N'', N'BUENAFLOR', N'Female', N'1977-07-11', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1748213-8', N'1211-3482-9845', N'314-550-752', N'18-200473505-7', N'A1794', NULL, NULL, NULL, NULL, N'2013-10-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.267', N'2021-09-21 23:52:58.267', N'0', N'SITIO GARDEN', N'TAMBIS', N'BAROBO', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'93', N'0', N'A3086', N'MARY KRIS', N'BONDOC', N'', N'', N'CADAY', N'Female', N'1991-12-25', NULL, N'', N'', N'177', N'Single', N'09301750763', N'', NULL, NULL, N'1', N'4', NULL, N'09-3842484-2', N'1211-3156-6743', N'462-282-679', N'18-025171848-0', N'A3086', NULL, NULL, NULL, NULL, N'2016-02-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.267', N'2021-09-21 23:52:58.267', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'94', N'0', N'A3984', N'NEIL', N'VECINA', N'', N'', N'CABRERA', N'Female', N'1983-10-22', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1785037-5', N'1211-6755-6294', N'723-014-374', N'18-025135350-4', N'A3984', NULL, NULL, NULL, NULL, N'2018-02-12', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.270', N'2021-09-21 23:52:58.270', N'0', N'PUROK 10', N'TUNGAO', N'BUTUAN', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'95', N'0', N'A2421', N'ALEXIS', N'TUBO', N'', N'', N'DAQUIO', N'Female', N'1987-06-23', NULL, N'', N'', N'177', N'Single', N'09079649211', N'', NULL, NULL, N'1', N'4', NULL, N'08-2446643-5', N'1211-1379-5023', N'426-454-565', N'18-200718707-7', N'A2421', NULL, NULL, NULL, NULL, N'2015-03-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.273', N'2021-09-21 23:52:58.273', N'0', N'PUROK 9', N'BAYUGAN 2', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'96', N'0', N'A2937', N'AMRI', N'EQUIBAL', N'', N'', N'DANDAN', N'Female', N'1989-04-10', NULL, N'', N'', N'177', N'Single', N'09488557748', N'', NULL, NULL, N'1', N'4', NULL, N'34-1749770-8', N'1211-4267-2664', N'278-347-107', N'02-050984454-3', N'A2937', NULL, NULL, NULL, NULL, N'2015-04-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.277', N'2021-09-21 23:52:58.277', N'0', N'', N'PASTA', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'97', N'0', N'A2164', N'ALDO', N'BESTOYONG', N'', N'', N'DANGUIS', N'Female', N'1993-12-04', NULL, N'', N'', N'177', N'Single', N'09092461346', N'', NULL, NULL, N'1', N'4', NULL, N'09-3579658-6', N'1210-9561-6044', N'316-010-983', N'18-025191055-1', N'A2164', NULL, NULL, NULL, NULL, N'2014-06-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.280', N'2021-09-21 23:52:58.280', N'0', N'PUROK 1', N'IMELDA', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'98', N'0', N'A4174', N'ERLY JAY', N'ALIPAR', N'', N'', N'BUDIONGAN', N'Female', N'1995-12-11', NULL, N'', N'', N'177', N'Single', N'09101647241', N'', NULL, NULL, N'1', N'4', NULL, N'34-7645119-6', N'1212-2755-1884', N'349-862-547', N'18-025284439-0', N'A4174', NULL, NULL, NULL, NULL, N'2018-09-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.287', N'2021-09-21 23:52:58.287', N'0', N'PUROK 4', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'99', N'0', N'A0998', N'FRANCIS', N'JO', N'', N'', N'CABRIADAS', N'Female', N'1979-11-15', NULL, N'', N'', N'177', N'Single', N'09307147727', N'', NULL, NULL, N'1', N'4', NULL, N'08-1506531-1', N'1820-0044-3352', N'948-853-159', N'15-050112425-9', N'A0998', NULL, NULL, NULL, NULL, N'2013-04-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.290', N'2021-09-21 23:52:58.290', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'100', N'0', N'A0334', N'BABSTER', N'GUANAO', N'', N'', N'CABUROG', N'Female', N'1967-02-18', NULL, N'', N'', N'177', N'Single', N'09395941948', N'', NULL, NULL, N'1', N'4', NULL, N'08-1671075-9', N'1830-0067-8758', N'315-984-145', N'18-050063269-9', N'A0334', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.290', N'2021-09-21 23:52:58.290', N'0', N'PUROK 6', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'101', N'0', N'A2165', N'JOHNY', N'CERBO', N'', N'', N'DAPACINO', N'Female', N'1974-06-23', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-2189522-9', N'1210-8824-2487', N'315-997-999', N'18-025188288-4', N'A2165', NULL, NULL, NULL, NULL, N'2013-04-24', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.290', N'2021-09-21 23:52:58.290', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'102', N'0', N'A2288', N'JUNEL', N'OMA�A', N'', N'', N'CADAVOS', N'Female', N'1993-11-19', NULL, N'', N'', N'177', N'Single', N'09488606423', N'', NULL, NULL, N'1', N'4', NULL, N'08-1979074-7', N'1210-7618-5994', N'316-781-691', N'18-025182639-9', N'A2288', NULL, NULL, NULL, NULL, N'2013-09-12', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.293', N'2021-09-21 23:52:58.293', N'0', N'', N'KAUSWAGAN', N'San�Agustin', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'103', N'0', N'A0155', N'ROY', N'SUGABO', N'', N'', N'DAQUE', N'Female', N'1983-12-07', NULL, N'', N'', N'177', N'Single', N'09305354660', N'', NULL, NULL, N'1', N'4', NULL, N'08-1513912-4', N'1211-3678-2145', N'942-231-701', N'18-050042678-9', N'A0155', NULL, NULL, NULL, NULL, N'2011-07-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.293', N'2021-09-21 23:52:58.293', N'0', N'PUROK 1-A', N'MACOPA', N'MONKAYO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'104', N'0', N'A4182', N'OMAR', N'OLALO', N'', N'', N'DAMIAN', N'Female', N'1974-04-24', NULL, N'', N'', N'177', N'Single', N'09090669397', N'', NULL, NULL, N'1', N'4', NULL, N'08-0804252-9', N'1210-7657-4452', N'207-594-395', N'03-050260031-8', N'A4182', NULL, NULL, NULL, NULL, N'2018-09-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.293', N'2021-09-21 23:52:58.293', N'0', N'PUROK 1', N'LA UNION', N'CABADBARAN', N'Agusan�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'105', N'0', N'A3024', N'GIOVANI', N'RABE', N'', N'', N'DANIEL', N'Female', N'1986-10-29', NULL, N'', N'', N'177', N'Single', N'09197471889', N'', NULL, NULL, N'1', N'4', NULL, N'09-3866656-1', N'1211-4618-1526', N'322-091-568', N'18-025237186-7', N'A3024', NULL, NULL, NULL, NULL, N'2015-05-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.297', N'2021-09-21 23:52:58.297', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'106', N'0', N'A2576', N'JOVELYN', N'GOLOSINDA', N'', N'', N'BUGAS', N'Female', N'1990-01-20', NULL, N'', N'', N'177', N'Single', N'09059652848', N'', NULL, NULL, N'1', N'4', NULL, N'08-1715073-2', N'1210-2835-2051', N'308-238-897', N'15-050221608-4', N'A2576', NULL, NULL, NULL, NULL, N'2014-05-08', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.297', N'2021-09-21 23:52:58.297', N'0', N'PUROK 2', N'TIBANGA', N'Iligan', N'Lanao�del�Norte', N'X')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'107', N'0', N'A3472', N'VICENTE', N'MALAZA', N'JR', N'', N'BUSTILLO', N'Female', N'1995-12-28', NULL, N'', N'', N'177', N'Single', N'09300688662', N'', NULL, NULL, N'1', N'4', NULL, N'08-2557081-2', N'1211-7407-1229', N'467-029-245', N'18-025240037-9', N'A3472', NULL, NULL, NULL, NULL, N'2016-05-25', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.300', N'2021-09-21 23:52:58.300', N'0', N'', N'PATROCINIO', N'Santa�Josefa', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'108', N'0', N'A0098', N'RANDY', N'BISTOYONG', N'', N'', N'DANGUIS', N'Female', N'1981-08-04', NULL, N'', N'', N'177', N'Single', N'09487274155', N'', NULL, NULL, N'1', N'4', NULL, N'08-1648118-5', N'1211-3656-5909', N'315-524-410', N'18-200620655-8', N'A0098', NULL, NULL, NULL, NULL, N'2012-03-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.303', N'2021-09-21 23:52:58.303', N'0', N'PUROK 6', N'SAN ANDRES', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'109', N'0', N'A4358', N'JANES HITFIELD', N'ALCUINO', N'', N'', N'CAINGLES', N'Female', N'1996-02-22', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'09-4176404-9', N'1212-0645-7989', N'338-200-185', N'16-050753798-4', N'A4358', NULL, NULL, NULL, NULL, N'2019-02-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.303', N'2021-09-21 23:52:58.303', N'0', N'PUROK 4', N'SAN TEODORO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'110', N'0', N'A0996', N'WILFREDO', N'IDEA', N'', N'', N'CABILING', N'Female', N'1960-10-12', NULL, N'', N'', N'177', N'Single', N'09464979577', N'', NULL, NULL, N'1', N'4', NULL, N'08-0537450-4', N'1830-0067-2399', N'928-258-783', N'18-050028834-3', N'A0996', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.303', N'2021-09-21 23:52:58.303', N'0', N'PUROK 12', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'111', N'0', N'A0008', N'MARIO', N'WATIN', N'', N'', N'CABURNAY', N'Female', N'1966-07-26', NULL, N'', N'', N'177', N'Single', N'09496954750', N'', NULL, NULL, N'1', N'4', NULL, N'06-1265829-3', N'1640-0138-6684', N'937-812-847', N'12-050885300-4', N'A0008', NULL, NULL, NULL, NULL, N'2012-03-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.317', N'2021-09-21 23:52:58.317', N'0', N'DAS UPPER HIGHWAY', N'DON ANDRES SORIANO', N'Toledo', N'Cebu', N'VII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'112', N'0', N'A4223', N'JULINDO', N'HERSAVA', N'JR', N'', N'DAR', N'Female', N'1999-06-26', NULL, N'', N'', N'177', N'Single', N'09467669431', N'', NULL, NULL, N'1', N'4', NULL, N'08-2881528-6', N'1212-3460-6466', N'352-475-771', N'18-250467974-9', N'A4223', NULL, NULL, NULL, NULL, N'2018-10-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.323', N'2021-09-21 23:52:58.323', N'0', N'PUROK 6', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'113', N'0', N'A1019', N'ELMER', N'DIAZ', N'', N'', N'DAR', N'Female', N'1988-11-23', NULL, N'', N'', N'177', N'Single', N'09107245013', N'', NULL, NULL, N'1', N'4', NULL, N'08-1760487-7', N'1211-3675-7232', N'279-671-615', N'18-050080896-7', N'A1019', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.323', N'2021-09-21 23:52:58.323', N'0', N'PUROK 3', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'114', N'0', N'A1021', N'FELIX', N'DIAZ', N'III', N'', N'DAR', N'Female', N'1990-02-20', NULL, N'', N'', N'177', N'Single', N'09098092826', N'', NULL, NULL, N'1', N'4', NULL, N'08-1742294-9', N'1211-3675-7254', N'297-986-160', N'18-050076331-9', N'A1021', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.323', N'2021-09-21 23:52:58.323', N'0', N'PUROK 3', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'115', N'0', N'A0064', N'JAYBON', N'LOPEZ', N'', N'', N'CABUGA', N'Female', N'1993-05-30', NULL, N'', N'', N'177', N'Single', N'09098730586', N'', NULL, NULL, N'1', N'4', NULL, N'08-1899772-9', N'1211-3780-7676', N'313-898-964', N'18-050105571-7', N'A0064', NULL, NULL, NULL, NULL, N'2012-01-02', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.327', N'2021-09-21 23:52:58.327', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'116', N'0', N'A0762', N'DARWIN', N'DAGOHOY', N'', N'', N'BUCTOT', N'Female', N'1977-01-02', NULL, N'', N'', N'177', N'Single', N'09203393418', N'', NULL, NULL, N'1', N'4', NULL, N'08-1552325-1', N'1211-3653-3450', N'298-063-794', N'18-025125120-5', N'A0762', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.330', N'2021-09-21 23:52:58.330', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'117', N'0', N'A2637', N'MANILYN', N'DIAZ', N'', N'', N'DAR', N'Female', N'1993-09-13', NULL, N'', N'', N'177', N'Single', N'09126832316', N'', NULL, NULL, N'1', N'4', NULL, N'08-2430024-5', N'1211-1981-2519', N'317-721-648', N'18-025226537-4', N'A2637', NULL, NULL, NULL, NULL, N'2014-06-03', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.330', N'2021-09-21 23:52:58.330', N'0', N'PUROK 3', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'118', N'0', N'A4138', N'MARK IVAN', N'BARRO', N'', N'', N'BUHAWE', N'Female', N'1988-08-26', NULL, N'', N'', N'177', N'Single', N'09109275324', N'', NULL, NULL, N'1', N'4', NULL, N'09-3198294-1', N'1211-0492-8605', N'308-720-576', N'16-050431195-0', N'A4138', NULL, NULL, NULL, NULL, N'2018-08-09', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.330', N'2021-09-21 23:52:58.330', N'0', N'PUROK 4', N'BAYUGAN 2', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'119', N'0', N'A2148', N'SAMMY', N'LINDAHAY', N'', N'', N'CALIWAAN', N'Female', N'1987-07-22', NULL, N'', N'', N'177', N'Single', N'09072176332', N'', NULL, NULL, N'1', N'4', NULL, N'08-2365345-6', N'1210-9685-9121', N'315-985-170', N'18-200621015-6', N'A2148', NULL, NULL, NULL, NULL, N'2013-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.330', N'2021-09-21 23:52:58.330', N'0', N'PUROK 8 KALINGAYAN', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'120', N'0', N'A3301', N'RAFFY', N'ABRIGOSO', N'', N'', N'CABRIADAS', N'Female', N'1996-01-19', NULL, N'', N'', N'177', N'Single', N'09466055501', N'', NULL, NULL, N'1', N'4', NULL, N'08-2614597-4', N'1211-6211-1374', N'477-277-256', N'18-250471674-1', N'A3301', NULL, NULL, NULL, NULL, N'2015-11-25', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.330', N'2021-09-21 23:52:58.330', N'0', N'PUROK 4', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'121', N'0', N'A0518', N'JONIE BEN', N'CRUJEDO', N'', N'', N'CAHOY', N'Female', N'1980-09-23', NULL, N'', N'', N'177', N'Single', N'09196781746', N'', NULL, NULL, N'1', N'4', NULL, N'34-0257831-5', N'1211-3583-2066', N'402-784-277', N'03-050682584-5', N'A0518', NULL, NULL, NULL, NULL, N'2011-08-19', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.333', N'2021-09-21 23:52:58.333', N'0', N'PUROK 1-A BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'122', N'0', N'A1802', N'RANIE', N'DANO', N'', N'', N'CALISTA', N'Female', N'1969-09-26', NULL, N'', N'', N'177', N'Single', N'09993169655', N'', NULL, NULL, N'1', N'4', NULL, N'08-1907096-2', N'1211-3468-7059', N'314-551-301', N'15-200419988-4', N'A1802', NULL, NULL, NULL, NULL, N'2011-11-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.333', N'2021-09-21 23:52:58.333', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'123', N'0', N'A1801', N'RENE', N'TANGCAY', N'', N'', N'CALIS', N'Female', N'1966-04-22', NULL, N'', N'', N'177', N'Single', N'09106612320', N'', NULL, NULL, N'1', N'4', NULL, N'08-0970018-7', N'1211-3468-7037', N'173-047-289', N'18-050035975-5', N'A1801', NULL, NULL, NULL, NULL, N'2011-11-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.333', N'2021-09-21 23:52:58.333', N'0', N'PUROK 6', N'DIATAGON', N'LIANGA', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'124', N'0', N'A4078', N'JESSIE', N' ', N'', N'', N'CALAPO-AN', N'Female', N'1982-04-04', NULL, N'', N'', N'177', N'Single', N'09100189259', N'', NULL, NULL, N'1', N'4', NULL, N'', N'', N'346-712-138', N'', N'A4078', NULL, NULL, NULL, NULL, N'2018-06-25', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.337', N'2021-09-21 23:52:58.337', N'0', N'PUROK 11', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'125', N'0', N'A4334', N'GILBERT', N'JO', N'', N'', N'CABRIADAS', N'Female', N'1986-05-13', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'34-6537175-3', N'1211-9305-1433', N'000-000-000', N'18-025131099-6', N'A4334', NULL, NULL, NULL, NULL, N'2019-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.340', N'2021-09-21 23:52:58.340', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'126', N'0', N'A1018', N'GERWIN', N'LOPEZ', N'', N'', N'DAMARILLOS', N'Female', N'1986-12-04', NULL, N'', N'', N'177', N'Single', N'09105102661', N'', NULL, NULL, N'1', N'4', NULL, N'08-1958691-9', N'1211-2061-6933', N'313-709-411', N'18-050117690-5', N'A1018', NULL, NULL, NULL, NULL, N'2012-06-19', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.340', N'2021-09-21 23:52:58.340', N'0', N'PUROK 6', N'TAGBAYAGAN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'127', N'0', N'A2546', N'ALJON', N'EQUIBAL', N'', N'', N'DANDAN', N'Female', N'1990-09-12', NULL, N'', N'', N'177', N'Single', N'09303515704', N'', NULL, NULL, N'1', N'4', NULL, N'34-2823782-1', N'1211-1796-7048', N'317-548-328', N'18-025210436-2', N'A2546', NULL, NULL, NULL, NULL, N'2014-05-02', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.340', N'2021-09-21 23:52:58.340', N'0', N'PUROK 4', N'PASTA', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'128', N'0', N'A1196', N'ALBERTO', N'PELI�O', N'', N'', N'CALDERON', N'Female', N'1975-05-07', NULL, N'', N'', N'177', N'Single', N'09066004151', N'', NULL, NULL, N'1', N'4', NULL, N'08-0966677-1', N'1830-0067-8771', N'298-032-898', N'18-050063420-9', N'A1196', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.340', N'2021-09-21 23:52:58.340', N'0', N'PUROK 13 NCCC RELOCATION LOURDES TIGATTO', N'BUHANGIN', N'Davao�City', N'Davao�del�Sur', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'129', N'0', N'A1254', N'ISABEL', N'ESTILO', N'', N'', N'CALIMPUSAN', N'Female', N'1969-06-30', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-0798813-4', N'1900-0031-9790', N'931-285-090', N'19-090427129-6', N'A1254', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.343', N'2021-09-21 23:52:58.343', N'0', N'', N'BARANGAY 5', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'130', N'0', N'A0678', N'RAYGIN', N'RETAMAS', N'', N'', N'DARANG', N'Female', N'1979-06-17', NULL, N'', N'', N'177', N'Single', N'09193613601', N'', NULL, NULL, N'1', N'4', NULL, N'08-1796604-9', N'1211-3708-4667', N'403-978-516', N'18-050085569-8', N'A0678', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.343', N'2021-09-21 23:52:58.343', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'131', N'0', N'A1020', N'RAFFE', N'GAMALO', N'', N'', N'DAR', N'Female', N'1980-09-26', NULL, N'', N'', N'177', N'Single', N'09075424631', N'', NULL, NULL, N'1', N'4', NULL, N'33-6535876-6', N'1210-8744-8060', N'315-998-594', N'18-200494183-8', N'A1020', NULL, NULL, NULL, NULL, N'2013-04-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.343', N'2021-09-21 23:52:58.343', N'0', N'', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'132', N'0', N'A3441', N'CHESSA LOU', N'CHATTO', N'', N'', N'CAJES', N'Female', N'1988-02-27', NULL, N'', N'', N'177', N'Single', N'09466962788', N'', NULL, NULL, N'1', N'4', NULL, N'09-3181558-4', N'1211-1387-4590', N'406-135-474', N'18-025185474-0', N'A3441', NULL, NULL, NULL, NULL, N'2016-06-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.347', N'2021-09-21 23:52:58.347', N'0', N'PUROK 1', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'133', N'0', N'A1165', N'SAMUEL', N'ADLAO', N'', N'', N'CAERLANG', N'Female', N'1954-07-21', NULL, N'', N'', N'177', N'Single', N'09264059759', N'', NULL, NULL, N'1', N'4', NULL, N'08-2161266-4', N'1830-0068-1301', N'296-153-276', N'18-025078494-3', N'A1165', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.350', N'2021-09-21 23:52:58.350', N'0', N'PUROK 8 KILOMETER 3', N'TABON', N'BISLIG', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'134', N'0', N'A3633', N'EDGAR', N'NUMERON', N'', N'', N'CALLAO', N'Female', N'1985-04-08', NULL, N'', N'', N'177', N'Single', N'09128504092', N'', NULL, NULL, N'1', N'4', NULL, N'08-1618376-8', N'1830-0067-5628', N'944-731-194', N'18-050054762-4', N'A3633', NULL, NULL, NULL, NULL, N'2016-11-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.350', N'2021-09-21 23:52:58.350', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'135', N'0', N'A0393', N'RONILO', N'LINDAHAY', N'', N'', N'CALIWAAN', N'Female', N'1984-06-15', NULL, N'', N'', N'177', N'Single', N'09105711696', N'', NULL, NULL, N'1', N'4', NULL, N'08-1872524-7', N'1211-3583-4653', N'416-228-163', N'18-200621014-8', N'A0393', NULL, NULL, NULL, NULL, N'2011-05-16', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.353', N'2021-09-21 23:52:58.353', N'0', N'PUROK 8 KALINGAYAN', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'136', N'0', N'A3309', N'FLORA MAY', N'ALAMILLO', N'', N'', N'CALLENO', N'Female', N'1991-05-22', NULL, N'', N'', N'177', N'Single', N'09098951905', N'', NULL, NULL, N'1', N'4', NULL, N'08-2619398-4', N'1211-6199-4778', N'325-351-855', N'18-025248590-0', N'A3309', NULL, NULL, NULL, NULL, N'2015-12-02', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.353', N'2021-09-21 23:52:58.353', N'0', N'', N'PATIN-AY', N'PROSPERIDAD', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'137', N'0', N'A3158', N'KRISHNA', N'HERNANDEZ', N'', N'', N'DAR', N'Female', N'1987-04-18', NULL, N'', N'', N'177', N'Single', N'09198622833', N'', NULL, NULL, N'1', N'4', NULL, N'08-1853788-8', N'1211-2711-1722', N'271-443-604', N'18-025154270-6', N'A3158', NULL, NULL, NULL, NULL, N'2015-08-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.353', N'2021-09-21 23:52:58.353', N'0', N'PUROK 1', N'POBLACION', N'LIANGA', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'138', N'0', N'A1372', N'KRISTINA ALEXANDRIA', N'PALMARIA', N'', N'', N'DARUCA', N'Female', N'1987-12-19', NULL, N'', N'', N'177', N'Single', N'09397563026', N'', NULL, NULL, N'1', N'4', NULL, N'09-2848071-5', N'1211-0658-9961', N'413-613-987', N'18-050102446-3', N'A1372', NULL, NULL, NULL, NULL, N'2011-07-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.373', N'2021-09-21 23:52:58.373', N'0', N'PUROK 1', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'139', N'0', N'A3243', N'JOE ANN', N'ABELLA', N'', N'', N'DARAY', N'Female', N'1986-06-21', NULL, N'', N'', N'177', N'Single', N'09499190140', N'', NULL, NULL, N'1', N'4', NULL, N'06-3295368-0', N'1211-0949-0859', N'312-400-585', N'12-051157081-1', N'A3243', NULL, NULL, NULL, NULL, N'2014-01-09', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.380', N'2021-09-21 23:52:58.380', N'0', N'PUROK 1', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'140', N'0', N'A2313', N'MICHAEL', N'LUGA', N'', N'', N'GARCIA', N'Female', N'1984-08-26', NULL, N'', N'', N'177', N'Single', N'09126150176', N'', NULL, NULL, N'1', N'4', NULL, N'09-2932401-6', N'1211-0234-1145', N'000-000-000', N'18-025194530-4', N'A2313', NULL, NULL, NULL, NULL, N'2014-10-07', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.380', N'2021-09-21 23:52:58.380', N'0', N'PUROK 6', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'141', N'0', N'A4395', N'IDELMAR', N'BUSQUE', N'', N'', N'DAROCA', N'Female', N'1998-02-07', NULL, N'', N'', N'177', N'Single', N'09506716397', N'', NULL, NULL, N'1', N'4', NULL, N'08-2926695-7', N'1212-4461-7010', N'356-154-705', N'18-025292893-4', N'A4395', NULL, NULL, NULL, NULL, N'2019-03-18', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.380', N'2021-09-21 23:52:58.380', N'0', N'PUROK 4', N'SANTA ANA', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'142', N'0', N'A1053', N'BENEDICTO', N'LABONG', N'JR', N'', N'IGDALINO', N'Female', N'1992-06-18', NULL, N'', N'', N'177', N'Single', N'09076604474', N'', NULL, NULL, N'1', N'4', NULL, N'08-1882511-8', N'1210-8739-0769', N'316-045-985', N'18-025188150-0', N'A1053', NULL, NULL, NULL, NULL, N'2013-04-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.397', N'2021-09-21 23:52:58.397', N'0', N'PUROK 10-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'143', N'0', N'A4380', N'JOBERTH', N'MARIANO', N'', N'', N'GONZALES', N'Female', N'1997-11-20', NULL, N'', N'', N'177', N'Single', N'09302418976', N'', NULL, NULL, N'1', N'4', NULL, N'34-6462148-8', N'1212-2767-0736', N'000-000-000', N'18-250470715-7', N'A4380', NULL, NULL, NULL, NULL, N'2019-03-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.397', N'2021-09-21 23:52:58.397', N'0', N'PUROK DOLDOL', N'SANTA CRUZ', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'144', N'0', N'A2823', N'RENE BOY', N'BULAWIN', N'', N'', N'GONZALES', N'Female', N'1995-01-23', NULL, N'', N'', N'177', N'Single', N'09094286340', N'', NULL, NULL, N'1', N'4', NULL, N'08-2516411-8', N'1211-3536-9948', N'000-000-000', N'18-025233382-5', N'A2823', NULL, NULL, NULL, NULL, N'2015-01-07', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.397', N'2021-09-21 23:52:58.397', N'0', N'PUROK 3', N'TAGBAYAGAN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'145', N'0', N'A1890', N'MARY JANE', N'CULLANTES', N'', N'', N'GOYO', N'Female', N'1988-03-28', NULL, N'', N'', N'177', N'Single', N'09186577832', N'', NULL, NULL, N'1', N'4', NULL, N'08-1917241-7', N'1211-3745-8972', N'313-898-518', N'18-050109251-5', N'A1890', NULL, NULL, NULL, NULL, N'2016-02-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.400', N'2021-09-21 23:52:58.400', N'0', N'PUROK 8 KALINGAYAN', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'146', N'0', N'A2673', N'HANDE KILBERT', N'CASIRES', N'', N'', N'IDPALINA', N'Female', N'1991-03-13', NULL, N'', N'', N'177', N'Single', N'09076938943', N'', NULL, NULL, N'1', N'4', NULL, N'09-3729062-4', N'1211-2282-1944', N'451-622-552', N'18-025226927-2', N'A2673', NULL, NULL, NULL, NULL, N'2014-07-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.400', N'2021-09-21 23:52:58.400', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'147', N'0', N'A1384', N'RONALD', N'MEJORADA', N'', N'', N'GORNE', N'Female', N'1982-07-22', NULL, N'', N'', N'177', N'Single', N'09129466523', N'', NULL, NULL, N'1', N'4', NULL, N'08-1490839-8', N'1830-0067-3553', N'931-291-845', N'18-050033895-2', N'A1384', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.400', N'2021-09-21 23:52:58.400', N'0', N'BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'148', N'0', N'A2539', N'OSCAR', N'PANU�AL', N'', N'', N'GOYO', N'Female', N'1974-12-31', NULL, N'', N'', N'177', N'Single', N'09123641848', N'', NULL, NULL, N'1', N'4', NULL, N'08-1287169-2', N'1210-2310-1294', N'317-356-158', N'18-050036346-9', N'A2539', NULL, NULL, NULL, NULL, N'2015-01-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.400', N'2021-09-21 23:52:58.400', N'0', N'PUROK 7 EVERLASTING', N'CUEVAS', N'Trento', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'149', N'0', N'A1889', N'JAIME', N'MISAGRANDE', N'JR', N'', N'GONZAGA', N'Female', N'1992-05-04', NULL, N'', N'', N'177', N'Single', N'09485780482', N'', NULL, NULL, N'1', N'4', NULL, N'', N'', N'316-046-179', N'', N'A1889', NULL, NULL, NULL, NULL, N'2011-10-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.403', N'2021-09-21 23:52:58.403', N'0', N'SITIO UPPER BANANGHILID', N'TAMBIS', N'BAROBO', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'150', N'0', N'A3164', N'KRISTIAN MORE', N'CHING', N'', N'', N'GONZAL', N'Female', N'1992-11-10', NULL, N'', N'', N'177', N'Single', N'09296018495', N'', NULL, NULL, N'1', N'4', NULL, N'08-2583421-5', N'1211-5377-0499', N'322-748-748', N'18-025243709-4', N'A3164', NULL, NULL, NULL, NULL, N'2015-08-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.403', N'2021-09-21 23:52:58.403', N'0', N'PUROK 1-A BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'151', N'0', N'A4142', N'ISIDRO', N'PULMONES', N'', N'', N'GONZAGA', N'Female', N'1986-05-15', NULL, N'', N'', N'177', N'Single', N'09489381858', N'', NULL, NULL, N'1', N'4', NULL, N'34-6972657-9', N'1212-1053-9501', N'348-203-016', N'18-200995021-5', N'A4142', NULL, NULL, NULL, NULL, N'2018-08-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.407', N'2021-09-21 23:52:58.407', N'0', N'PUROK 7', N'PASTA', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'152', N'0', N'A0362', N'JONNIFIL', N'MARZON', N'', N'', N'GONZALES', N'Female', N'1987-03-03', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1662212-2', N'1830-0067-9324', N'413-579-203', N'18-050063873-5', N'A0362', NULL, NULL, NULL, NULL, N'2011-05-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.407', N'2021-09-21 23:52:58.407', N'0', N'PUROK 2', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'153', N'0', N'A3130', N'MICHELLE', N'MONLING', N'', N'', N'CAGA-ANAN', N'Female', N'1993-07-27', NULL, N'', N'', N'177', N'Single', N'09106686589', N'', NULL, NULL, N'1', N'4', NULL, N'08-2581896-9', N'1211-4839-0020', N'322-506-952', N'18-250472456-6', N'A3130', NULL, NULL, NULL, NULL, N'2015-07-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.407', N'2021-09-21 23:52:58.407', N'0', N'PUROK 1-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'154', N'0', N'A1519', N'GABRIEL', N'OFTANA', N'', N'', N'DARUCA', N'Female', N'1981-11-25', NULL, N'', N'', N'177', N'Single', N'09124249735', N'', NULL, NULL, N'1', N'4', NULL, N'08-1547593-0', N'1210-7555-8519', N'296-150-553', N'18-050083386-4', N'A1519', NULL, NULL, NULL, NULL, N'2010-03-22', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.407', N'2021-09-21 23:52:58.407', N'0', N'PUROK 1 BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'155', N'0', N'A4049', N'RICARDO', N'RAAGAS', N'', N'', N'CAGARA', N'Female', N'1963-01-19', NULL, N'', N'', N'177', N'Single', N'09125055282', N'', NULL, NULL, N'1', N'4', NULL, N'09-1258696-8', N'1211-7747-0035', N'169-302-734', N'19-025296727-7', N'A4049', NULL, NULL, NULL, NULL, N'2018-04-24', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.410', N'2021-09-21 23:52:58.410', N'0', N'PUROK 3 GAMAON DISTRICT', N'MANGAGOY', N'BISLIG', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'156', N'0', N'A3823', N'ERVIN', N'PEREZ', N'', N'', N'JACOB', N'Female', N'1993-05-29', NULL, N'', N'', N'177', N'Single', N'09483191992', N'', NULL, NULL, N'1', N'4', NULL, N'34-6924783-8', N'1212-0457-5820', N'339-075-055', N'18-201022402-1', N'A3823', NULL, NULL, NULL, NULL, N'2018-07-31', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.497', N'2021-09-21 23:52:58.497', N'0', N'PUROK 4', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'157', N'0', N'A4368', N'ADONIS', N'LABONG', N'', N'', N'IGDALINO', N'Female', N'1996-03-29', NULL, N'', N'', N'177', N'Single', N'09109591080', N'', NULL, NULL, N'1', N'4', NULL, N'08-2528394-7', N'1211-4260-2755', N'355-236-314', N'18-050153065-2', N'PMC20210000157', NULL, NULL, NULL, NULL, N'2019-03-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.500', N'2021-09-21 23:52:58.500', N'0', N'PUROK 10-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'158', N'0', N'A4164', N'ARGIE', N'ORTIZ', N'', N'', N'IGSOC', N'Female', N'1997-08-15', NULL, N'', N'', N'177', N'Single', N'09474408358', N'', NULL, NULL, N'1', N'4', NULL, N'34-6145028-3', N'1212-1128-0956', N'000-000-000', N'18-251033970-4', N'A4164', NULL, NULL, NULL, NULL, N'2018-09-03', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.507', N'2021-09-21 23:52:58.507', N'0', N'PUROK 1', N'BAN-AS', N'LIANGA', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'159', N'0', N'A4325', N'JAKE LOYD', N'TESORO', N'', N'', N'JACOB', N'Female', N'1992-06-14', NULL, N'', N'', N'177', N'Single', N'09362595142', N'', NULL, NULL, N'1', N'4', NULL, N'34-6213160-8', N'1211-8018-8969', N'353-316-131', N'18-200921767-4', N'A4325', NULL, NULL, NULL, NULL, N'2019-01-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.510', N'2021-09-21 23:52:58.510', N'0', N'', N'BANBANON', N'San�Francisco�(Anao-Aon)', N'Surigao�del�Norte', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'160', N'0', N'A3527', N'RETZIE', N'DERECHO', N'', N'', N'GRIPO', N'Female', N'1987-05-14', NULL, N'', N'', N'177', N'Single', N'09109911092', N'', NULL, NULL, N'1', N'4', NULL, N'34-6080651-1', N'1211-7938-4811', N'329-847-672', N'18-200666489-0', N'A3527', NULL, NULL, NULL, NULL, N'2016-08-09', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.510', N'2021-09-21 23:52:58.510', N'0', N'PUROK 2', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'161', N'0', N'A2603', N'STEVEN', N'VILLASOTES', N'', N'', N'JACOB', N'Female', N'1980-09-26', NULL, N'', N'', N'177', N'Single', N'09093314427', N'', NULL, NULL, N'1', N'4', NULL, N'08-2457560-1', N'1211-1812-9238', N'317-568-073', N'18-025224934-4', N'A2603', NULL, NULL, NULL, NULL, N'2015-03-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.510', N'2021-09-21 23:52:58.510', N'0', N'PUROK 3', N'TAGBAYAGAN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'162', N'0', N'A1396', N'ALBERTO', N'LUPIAN', N'', N'', N'GUCOR', N'Female', N'1967-05-11', NULL, N'', N'', N'177', N'Single', N'09187651883', N'', NULL, NULL, N'1', N'4', NULL, N'09-1420173-3', N'1830-0067-2710', N'174-506-220', N'19-089555275-9', N'A1396', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.513', N'2021-09-21 23:52:58.513', N'0', N'PUROK 1-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'163', N'0', N'A1904', N'RUDY', N'ALGUZAR', N'', N'', N'JABAHAB', N'Female', N'1968-06-23', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'04-1996695-5', N'1211-3489-7521', N'314-683-746', N'18-200279332-7', N'A1904', NULL, NULL, NULL, NULL, N'2013-10-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.513', N'2021-09-21 23:52:58.513', N'0', N'PUROK 3', N'TAMBIS', N'BAROBO', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'164', N'0', N'A0340', N'ROLDAN', N'MASIG', N'', N'', N'INSOG', N'Female', N'1974-04-10', NULL, N'', N'', N'177', N'Single', N'09481300377', N'', NULL, NULL, N'1', N'4', NULL, N'09-2835543-9', N'1830-0067-5517', N'944-731-888', N'16-050259259-6', N'A0340', NULL, NULL, NULL, NULL, N'2007-07-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.517', N'2021-09-21 23:52:58.517', N'0', N'', N'TERESA', N'MACO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'165', N'0', N'A1318', N'ROMEO', N'CABO�ETA', N'', N'', N'INTES', N'Female', N'1960-02-07', NULL, N'', N'', N'177', N'Single', N'09474101843', N'', NULL, NULL, N'1', N'4', NULL, N'08-0660395-7', N'1830-0067-3398', N'139-193-136', N'18-050032251-7', N'A1318', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.520', N'2021-09-21 23:52:58.520', N'0', N'BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'166', N'0', N'A0189', N'CHERALDEN', N'BOSQUE', N'', N'', N'INSOG', N'Female', N'1993-04-29', NULL, N'', N'', N'177', N'Single', N'09389180510', N'', NULL, NULL, N'1', N'4', NULL, N'09-3477347-4', N'1210-8811-4064', N'313-922-597', N'16-025535961-1', N'A0189', NULL, NULL, NULL, NULL, N'2012-09-14', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.520', N'2021-09-21 23:52:58.520', N'0', N'PUROK 10', N'POBLACION', N'MACO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'167', N'0', N'A1716', N'DOMINIQUE', N'REBUCAN', N'', N'', N'INOCENCIO', N'Female', N'1970-03-03', NULL, N'', N'', N'177', N'Single', N'09480767338', N'', NULL, NULL, N'1', N'4', NULL, N'08-0819575-1', N'1830-0067-3565', N'931-291-879', N'18-050038389-3', N'A1716', NULL, NULL, NULL, NULL, N'2005-07-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.520', N'2021-09-21 23:52:58.520', N'0', N'PUROK 1-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'168', N'0', N'A1234', N'ERNESTO', N'KISIO', N'', N'', N'INAHID', N'Female', N'1976-10-25', NULL, N'', N'', N'177', N'Single', N'09991645968', N'', NULL, NULL, N'1', N'4', NULL, N'08-1660517-8', N'1830-0067-9392', N'270-789-999', N'18-050063006-8', N'A1234', NULL, NULL, NULL, NULL, N'2008-10-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.523', N'2021-09-21 23:52:58.523', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'169', N'0', N'A4113', N'VAVAN', N'GOMEZ', N'', N'', N'GRABILLO', N'Female', N'1990-08-20', NULL, N'', N'', N'177', N'Single', N'09461296839', N'', NULL, NULL, N'1', N'4', NULL, N'34-6928974-4', N'1211-9887-9830', N'000-000-000', N'18-050176380-0', N'A4113', NULL, NULL, NULL, NULL, N'2018-07-16', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.523', N'2021-09-21 23:52:58.523', N'0', N'PUROK 1', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'170', N'0', N'A1052', N'JOEL', N'AGUILAR', N'', N'', N'GRUTA', N'Female', N'1982-04-10', NULL, N'', N'', N'177', N'Single', N'09059701878', N'', NULL, NULL, N'1', N'4', NULL, N'08-1662213-5', N'1830-0067-9335', N'299-261-610', N'18-050063877-8', N'A1052', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.527', N'2021-09-21 23:52:58.527', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'171', N'0', N'A3112', N'JOHNRY', N'BOYLES', N'', N'', N'GUALINGCO', N'Female', N'1993-01-06', NULL, N'', N'', N'177', N'Single', N'09101761359', N'', NULL, NULL, N'1', N'4', NULL, N'08-2572137-3', N'1211-5084-3154', N'331-897-912', N'18-025242352-2', N'A3112', NULL, NULL, NULL, NULL, N'2015-12-03', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 2', N'HUBANG', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'172', N'0', N'A0568', N'RADIN', N'MASIG', N'', N'', N'INSOG', N'Female', N'1967-12-05', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'09-1272175-2', N'1830-0067-5505', N'944-730-119', N'16-050250465-4', N'A0568', NULL, NULL, NULL, NULL, N'2007-07-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 10', N'MASARA', N'MACO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'173', N'0', N'A2712', N'HONEY BELLE', N'BENTOSO ', N'', N'', N'GUARDAQUIBEL', N'Female', N'1992-02-11', NULL, N'', N'', N'177', N'Single', N'09308166527', N'', NULL, NULL, N'1', N'4', NULL, N'08-2490952-3', N'1211-2835-9802', N'319-445-043', N'18-025229666-0', N'A2712', NULL, NULL, NULL, NULL, N'2014-09-15', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 9 UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'174', N'0', N'A1903', N'CARLITO', N'MONDEJAR', N'', N'', N'ITAO', N'Female', N'1970-04-26', NULL, N'', N'', N'177', N'Single', N'09466632028', N'', NULL, NULL, N'1', N'4', NULL, N'09-2286095-9', N'1210-4386-4834', N'314-655-038', N'16-050198468-7', N'A1903', NULL, NULL, NULL, NULL, N'2012-10-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 1-A', N'POBLACION', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'175', N'0', N'A1905', N'MICHAEL', N'PILAPIL', N'', N'', N'JABALLA', N'Female', N'1989-03-19', NULL, N'', N'', N'177', N'Single', N'09462684633', N'', NULL, NULL, N'1', N'4', NULL, N'08-1970829-2', N'1210-8727-0229', N'441-892-615', N'18-025187341-9', N'A1905', NULL, NULL, NULL, NULL, N'2013-12-11', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 3', N'GUINHALINAN', N'BAROBO', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'176', N'0', N'A2771', N'ZALDE', N'LACERNA', N'', N'', N'ITIM', N'Female', N'1992-01-12', NULL, N'', N'', N'177', N'Single', N'09482833673', N'', NULL, NULL, N'1', N'4', NULL, N'08-1814340-5', N'1211-3113-0248', N'319-497-172', N'18-050088513-9', N'A2771', NULL, NULL, NULL, NULL, N'2015-04-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 2', N'BAYUGAN 2', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'177', N'0', N'A3864', N'JANO', N'       ', N'', N'', N'IMPROSO', N'Female', N'1993-06-01', NULL, N'', N'', N'177', N'Single', N'09300559043', N'', NULL, NULL, N'1', N'4', NULL, N'08-2787534-0', N'1212-1215-1635', N'340-677-377', N'18-025274706-9', N'A3864', NULL, NULL, NULL, NULL, N'2017-10-09', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.530', N'2021-09-21 23:52:58.530', N'0', N'PUROK 1-B', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'178', N'0', N'A1901', N'NILO', N'MABANAN', N'', N'', N'IGDALINO', N'Female', N'1965-10-17', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1910492-2', N'1211-3667-1688', N'314-654-915', N'18-200012837-7', N'A1901', NULL, NULL, NULL, NULL, N'2011-11-24', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.557', N'2021-09-21 23:52:58.557', N'0', N'PUROK 1', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'179', N'0', N'A4375', N'ARNEL', N' ', N'', N'', N'GUCILA', N'Female', N'1999-05-07', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-2921804-4', N'1212-4524-7357', N'355-238-988', N'18-050177089-0', N'A4375', NULL, NULL, NULL, NULL, N'2019-03-04', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.567', N'2021-09-21 23:52:58.567', N'0', N'PUROK 5-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'180', N'0', N'A3342', N'JOEL', N'PIANO', N'', N'', N'INOCIAN', N'Female', N'1995-11-11', NULL, N'', N'', N'177', N'Single', N'09123072651', N'', NULL, NULL, N'1', N'4', NULL, N'08-2619177-9', N'1211-6226-5261', N'325-330-800', N'18-250354157-3', N'A3342', NULL, NULL, NULL, NULL, N'2016-01-16', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.570', N'2021-09-21 23:52:58.570', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'181', N'0', N'A0567', N'LIBRADO', N'DIVIBAR', N'JR', N'', N'INOCIAN', N'Female', N'1961-01-01', NULL, N'', N'', N'177', N'Single', N'09482262612', N'', NULL, NULL, N'1', N'4', NULL, N'09-0791250-5', N'1830-0067-4206', N'180-060-307', N'18-050052271-0', N'A0567', NULL, NULL, NULL, NULL, N'2006-06-13', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.570', N'2021-09-21 23:52:58.570', N'0', N'PUROK 9 NANGKA UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'182', N'0', N'A1891', N'ORLANDO', N'MIQUE', N'', N'', N'GUBATANGA', N'Female', N'1975-03-25', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1078539-5', N'1210-7961-1319', N'314-654-801', N'18-200329956-3', N'A1891', NULL, NULL, NULL, NULL, N'2014-02-26', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.573', N'2021-09-21 23:52:58.573', N'0', N'PUROK 1', N'LIBERTAD', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'183', N'0', N'A4281', N'IAN MAR', N'DUMALAGAN', N'', N'', N'GRANADA', N'Female', N'1986-11-15', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'34-6323201-4', N'1211-8465-2965', N'000-000-000', N'18-200840972-3', N'A4281', NULL, NULL, NULL, NULL, N'2018-11-05', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.573', N'2021-09-21 23:52:58.573', N'0', N'PUROK 2-C', N'SAN ANDRES', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'184', N'0', N'A1545', N'RONELO', N'REAMBONANZA', N'', N'', N'GRADO', N'Female', N'1964-05-09', NULL, N'', N'', N'177', N'Single', N'09102648869', N'', NULL, NULL, N'1', N'4', NULL, N'08-0626746-1', N'1210-4276-8674', N'119-616-177', N'18-200354250-6', N'A1545', NULL, NULL, NULL, NULL, N'2011-03-31', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.577', N'2021-09-21 23:52:58.577', N'0', N'PUROK 2', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'185', N'0', N'A3554', N'JOHN ERWIN REY', N'TULOD', N'', N'', N'GUILLENA', N'Female', N'1991-03-18', NULL, N'', N'', N'177', N'Single', N'09301784066', N'', NULL, NULL, N'1', N'4', NULL, N'34-6162436-5', N'1211-8192-6789', N'330-705-919', N'18-200718950-9', N'A3554', NULL, NULL, NULL, NULL, N'2016-09-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.580', N'2021-09-21 23:52:58.580', N'0', N'PUROK 2', N'LAPINIGAN', N'San�Francisco', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'186', N'0', N'A0072', N'JOVANI', N'PANES', N'', N'', N'GUILLERA', N'Female', N'1989-04-07', NULL, N'', N'', N'177', N'Single', N'09474672636', N'', NULL, NULL, N'1', N'4', NULL, N'08-1979838-3', N'1210-7515-2190', N'315-295-609', N'18-025182524-4', N'A0072', NULL, NULL, NULL, NULL, N'2012-11-15', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.580', N'2021-09-21 23:52:58.580', N'0', N'PUROK 10-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'187', N'0', N'A3630', N'JOENARD', N'ACUPAN', N'', N'', N'JANOYA', N'Female', N'1979-06-19', NULL, N'', N'', N'177', N'Single', N'09464475523', N'', NULL, NULL, N'1', N'4', NULL, N'34-6194297-9', N'1211-8754-0651', N'332-498-111', N'18-025258701-0', N'A3630', NULL, NULL, NULL, NULL, N'2016-11-25', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.583', N'2021-09-21 23:52:58.583', N'0', N'PUROK 5', N'ANIBONGAN', N'LIANGA', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'188', N'0', N'A3804', N'NORBEN', N'ARA�EZ', N'', N'', N'JAPOS', N'Female', N'1990-11-28', NULL, N'', N'', N'177', N'Single', N'09120002754', N'', NULL, NULL, N'1', N'4', NULL, N'08-2306663-2', N'1211-3236-8450', N'702-479-883', N'18-050127326-9', N'A3804', NULL, NULL, NULL, NULL, N'2017-06-27', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.587', N'2021-09-21 23:52:58.587', N'0', N'', N'PASIAN', N'MONKAYO', N'Compostela�Valley', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'189', N'0', N'A1894', N'KINDATO', N'ABDULLAH', N'', N'', N'GUIAPAL', N'Female', N'1981-07-08', NULL, N'', N'', N'177', N'Single', N'09351711146', N'', NULL, NULL, N'1', N'4', NULL, N'08-1953867-9', N'1211-3663-8492', N'320-344-086', N'18-050115392-1', N'A1894', NULL, NULL, NULL, NULL, N'2012-05-16', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.587', N'2021-09-21 23:52:58.587', N'0', N'PUROK 1', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'190', N'0', N'A0110', N'JEROME', N'LABADOR', N'', N'', N'GUERGIO', N'Female', N'1991-01-26', NULL, N'', N'', N'177', N'Single', N'09093658472', N'', NULL, NULL, N'1', N'4', NULL, N'08-1827306-1', N'1210-8701-1065', N'421-370-899', N'15-050279561-0', N'A0110', NULL, NULL, NULL, NULL, N'2013-03-18', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.590', N'2021-09-21 23:52:58.590', N'0', N'', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'191', N'0', N'A2858', N'KIER', N'SALVADOR', N'', N'', N'GUIAO', N'Female', N'1990-11-28', NULL, N'', N'', N'177', N'Single', N'09099609643', N'', NULL, NULL, N'1', N'4', NULL, N'08-2459176-6', N'1211-3780-2360', N'320-712-814', N'18-200755096-1', N'A2858', NULL, NULL, NULL, NULL, N'2015-08-02', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.590', N'2021-09-21 23:52:58.590', N'0', N'PUROK 9 UPPER COO', N'CONSUELO', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'192', N'0', N'A2666', N'MARLON', N'BUTIL', N'', N'', N'GUDILOS', N'Female', N'1981-04-19', NULL, N'', N'', N'177', N'Single', N'09092700959', N'', NULL, NULL, N'1', N'4', NULL, N'09-2161383-5', N'1211-2527-5089', N'318-561-227', N'16-025631716-5', N'A2666', NULL, NULL, NULL, NULL, N'2014-07-09', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.590', N'2021-09-21 23:52:58.590', N'0', N'PUROK 5', N'APOKON', N'Tagum', N'Davao�del�Norte', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'193', N'0', N'A3533', N'JAMES', N'BRIMON', N'', N'', N'GUI�AREZ', N'Female', N'1995-08-13', NULL, N'', N'', N'177', N'Single', N'09120272020', N'', NULL, NULL, N'1', N'4', NULL, N'34-6091014-8', N'1211-3378-9172', N'330-188-869', N'18-250427955-4', N'A3533', NULL, NULL, NULL, NULL, N'2016-08-18', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.590', N'2021-09-21 23:52:58.590', N'0', N'PUROK 6', N'AZPETIA', N'PROSPERIDAD', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'194', N'0', N'A0408', N'JEMBOY', N'TEJADA', N'', N'', N'INTES', N'Female', N'1985-05-27', NULL, N'', N'', N'177', N'Single', N'09104147406', N'', NULL, NULL, N'1', N'4', NULL, N'08-1662215-1', N'1830-0067-9401', N'406-469-602', N'18-050063875-1', N'A0408', NULL, NULL, NULL, NULL, N'2010-01-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.590', N'2021-09-21 23:52:58.590', N'0', N'PUROK 1-A BANAHAW', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'195', N'0', N'A1201', N'THELMA', N'SALVADOR', N'', N'', N'GUIAO', N'Female', N'1970-06-26', NULL, N'', N'', N'177', N'Single', N'', N'', NULL, NULL, N'1', N'4', NULL, N'08-1816330-4', N'1211-3704-2147', N'403-965-608', N'18-050089766-8', N'A1201', NULL, NULL, NULL, NULL, N'2010-09-28', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.593', N'2021-09-21 23:52:58.593', N'0', N'PUROK 9 UPPER COO', N'', N'BUNAWAN', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'196', N'0', N'A3780', N'MANDY', N'SANTOS', N'', N'', N'INOCENCIO', N'Female', N'1998-01-29', NULL, N'', N'', N'177', N'Single', N'09483246994', N'', NULL, NULL, N'1', N'4', NULL, N'34-6440857-5', N'1211-6520-2760', N'337-498-850', N'18-025263084-6', N'A3780', NULL, NULL, NULL, NULL, N'2017-11-14', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.597', N'2021-09-21 23:52:58.597', N'0', N'PUROK 1-A', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'197', N'0', N'A3108', N'RIX', N'TAYPIN', N'', N'', N'INFIESTO', N'Female', N'1980-10-29', NULL, N'', N'', N'177', N'Single', N'09395269591', N'', NULL, NULL, N'1', N'4', NULL, N'08-2437200-8', N'1211-5074-2208', N'322-652-495', N'16-200272864-8', N'A3108', NULL, NULL, NULL, NULL, N'2015-11-22', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.597', N'2021-09-21 23:52:58.597', N'0', N'PUROK GUMAMELA', N'MAMANGAN', N'San�Isidro', N'Davao�del�Norte', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'198', N'0', N'A3109', N'REGINO', N'TAYPIN', N'', N'', N'INFIESTO', N'Female', N'1982-06-25', NULL, N'', N'', N'177', N'Single', N'09101817160', N'', NULL, NULL, N'1', N'4', NULL, N'08-2570409-9', N'1211-5074-1889', N'322-751-648', N'18-025242106-6', N'A3109', NULL, NULL, NULL, NULL, N'2015-11-22', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.597', N'2021-09-21 23:52:58.597', N'0', N'PUROK TUBOD', N'GUPITAN', N'Kapalong', N'Davao�del�Norte', N'XI')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'200', N'0', N'A4186', N'REX OLIVER', N'BISTUIR', N'', N'', N'IGNACIO', N'Female', N'1988-09-20', NULL, N'', N'', N'177', N'Single', N'09464561070', N'', NULL, NULL, N'1', N'4', NULL, N'09-2904589-0', N'1211-0754-5254', N'447-714-586', N'18-200711723-0', N'A4186', NULL, NULL, NULL, NULL, N'2018-09-21', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.600', N'2021-09-21 23:52:58.600', N'0', N'PUROK 1', N'POBLACION', N'LIANGA', N'Surigao�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'201', N'0', N'A0565', N'JIMMY', N'LABADOR', N'', N'', N'GUERGIO', N'Female', N'1985-06-03', NULL, N'', N'', N'177', N'Single', N'09291200980', N'', NULL, NULL, N'1', N'4', NULL, N'08-1499844-7', N'1211-1049-7404', N'403-757-902', N'18-050105038-3', N'A0565', NULL, NULL, NULL, NULL, N'2011-08-10', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.603', N'2021-09-21 23:52:58.603', N'0', N'PUROK 5', N'WASI-AN', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

INSERT INTO [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type], [street], [barangay], [city], [province], [region]) VALUES (N'202', N'0', N'A2732', N'JUNEL', N'PEREZ', N'', N'', N'GUERRERO', N'Female', N'1988-08-18', NULL, N'', N'', N'177', N'Single', N'09095842633', N'', NULL, NULL, N'1', N'4', NULL, N'09-3471045-3', N'1211-3109-2137', N'319-258-856', N'18-025230837-5', N'A2732', NULL, NULL, NULL, NULL, N'2014-10-01', NULL, NULL, N'0', N'0', N'2021-09-21 23:52:58.603', N'2021-09-21 23:52:58.603', N'0', N'PUROK 3', N'BAYUGAN 3', N'ROSARIO', N'Agusan�del�Sur', N'XIII')
GO

SET IDENTITY_INSERT [dbo].[users] OFF
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
-- Records of users_document
-- ----------------------------
SET IDENTITY_INSERT [dbo].[users_document] ON
GO

INSERT INTO [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (N'1', N'1', N'Dummy', N'e01ebcce-49d6-44f1-9166-8cf9090f96a1.pdf', N'sample.pdf', N'', N'2019-10-07 15:15:28.000', N'2019-10-07 15:15:28.000')
GO

INSERT INTO [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (N'2', N'2', N'Promotion', N'cbbbbe6d-2be4-4af3-aac2-ee70767df17e.txt', N'promotion.txt', N'Promoted from Associate to Professional', N'2019-11-19 11:42:11.000', N'2019-11-19 11:42:11.000')
GO

INSERT INTO [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (N'3', N'44', N'Movement Letter', N'6564525b-576c-437f-a952-460d80a96c49.pdf', N'MARIA MONICA TURALBA.pdf', N'Promoted as Design Executive effective March 18, 2019', N'2019-11-20 16:44:03.000', N'2019-11-20 16:44:03.000')
GO

INSERT INTO [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (N'4', N'97', N'Movement Letter', N'42d53f22-ab3d-47cb-b852-dba6bb40dc1f.pdf', N'SHARA MAY CANLAS .pdf', N'Promoted as Design Coordinator effective September 24, 2019', N'2019-11-20 16:48:59.000', N'2019-11-20 16:48:59.000')
GO

INSERT INTO [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (N'5', N'71', N'Movement Letter', N'a342653c-cee3-45f0-8ed3-b0d2e020c0c9.jpg', N'Garcia, Jamie.jpg', N'Promoted as Project Manager effective November 11, 2019', N'2019-11-20 16:59:07.000', N'2019-11-20 16:59:07.000')
GO

SET IDENTITY_INSERT [dbo].[users_document] OFF
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
-- Records of work_areas
-- ----------------------------
SET IDENTITY_INSERT [dbo].[work_areas] ON
GO

INSERT INTO [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (N'1', N'Surface', N'2021-06-17 16:20:57.000', NULL)
GO

INSERT INTO [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (N'2', N'Underground', N'2021-06-17 16:20:57.000', NULL)
GO

INSERT INTO [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (N'3', N'Surface/Underground', N'2021-06-17 16:20:57.000', NULL)
GO

INSERT INTO [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (N'4', N'Support', N'2021-06-17 16:20:57.000', NULL)
GO

SET IDENTITY_INSERT [dbo].[work_areas] OFF
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
-- Records of work_schedule
-- ----------------------------
SET IDENTITY_INSERT [dbo].[work_schedule] ON
GO

INSERT INTO [dbo].[work_schedule] ([id], [user_id], [type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at], [destination_entitlement], [shift_type], [rooster_break], [break_type]) VALUES (N'87', N'2', N'0', N'2021-08-02', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', NULL, N'0', N'2021-08-04 22:06:55.797', N'2021-08-04 22:06:55.797', NULL, N'0', N'4', N'2')
GO

INSERT INTO [dbo].[work_schedule] ([id], [user_id], [type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at], [destination_entitlement], [shift_type], [rooster_break], [break_type]) VALUES (N'88', N'1', N'0', N'2021-08-02', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', NULL, N'0', N'2021-08-04 22:13:41.010', N'2021-08-04 22:13:41.010', NULL, N'0', N'4', N'2')
GO

INSERT INTO [dbo].[work_schedule] ([id], [user_id], [type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at], [destination_entitlement], [shift_type], [rooster_break], [break_type]) VALUES (N'89', N'119', N'0', N'2021-08-02', NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', NULL, N'0', N'2021-08-04 22:14:00.000', N'2021-08-04 22:14:00.000', NULL, N'0', N'4', N'2')
GO

SET IDENTITY_INSERT [dbo].[work_schedule] OFF
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
DBCC CHECKIDENT ('[dbo].[biometric_logs]', RESEED, 10401)
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
DBCC CHECKIDENT ('[dbo].[employments]', RESEED, 1013)
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
DBCC CHECKIDENT ('[dbo].[overtimes]', RESEED, 25)
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
DBCC CHECKIDENT ('[dbo].[shifts]', RESEED, 10484)
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
DBCC CHECKIDENT ('[dbo].[tss_data]', RESEED, 40)
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

