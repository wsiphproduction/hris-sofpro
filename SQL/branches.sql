/*
Navicat SQL Server Data Transfer

Source Server         : MSSQL
Source Server Version : 150000
Source Host           : JULIUSF:1433
Source Database       : philsaga
Source Schema         : dbo

Target Server Type    : SQL Server
Target Server Version : 150000
File Encoding         : 65001

Date: 2021-08-17 15:39:33
*/


-- ----------------------------
-- Table structure for [dbo].[branches]
-- ----------------------------
DROP TABLE [dbo].[branches]
GO
CREATE TABLE [dbo].[branches] (
[id] int NOT NULL IDENTITY(2,1) ,
[location_id] int NULL ,
[address] nvarchar(512) NULL DEFAULT NULL ,
[country_id] int NULL DEFAULT NULL ,
[company_id] int NOT NULL ,
[description] nvarchar(MAX) NULL DEFAULT NULL ,
[status] int NOT NULL DEFAULT ((1)) ,
[created_by] int NULL DEFAULT NULL ,
[updated_by] int NULL DEFAULT NULL ,
[created_at] datetime NOT NULL DEFAULT (getdate()) ,
[updated_at] datetime NULL DEFAULT NULL 
)


GO

-- ----------------------------
-- Records of branches
-- ----------------------------
SET IDENTITY_INSERT [dbo].[branches] ON
GO
INSERT INTO [dbo].[branches] ([id], [location_id], [address], [country_id], [company_id], [description], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (N'1', N'1', N'Ayala Avenue', N'177', N'1', null, N'1', null, null, N'2019-03-24 07:09:18.000', N'2019-09-26 03:05:50.000');
GO
SET IDENTITY_INSERT [dbo].[branches] OFF
GO

-- ----------------------------
-- Indexes structure for table branches
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[branches]
-- ----------------------------
ALTER TABLE [dbo].[branches] ADD PRIMARY KEY ([id])
GO
