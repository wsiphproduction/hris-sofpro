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

Date: 2021-08-02 19:31:02
*/


-- ----------------------------
-- Table structure for [dbo].[biometric_logs]
-- ----------------------------
DROP TABLE [dbo].[biometric_logs]
GO
CREATE TABLE [dbo].[biometric_logs] (
[id] bigint NOT NULL IDENTITY(1,1) ,
[userId] int NOT NULL ,
[state] int NOT NULL ,
[date] datetime NOT NULL ,
[status] int NOT NULL ,
[ip_address] nvarchar(16) NULL DEFAULT NULL ,
[source] nvarchar(12) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[biometric_logs]', RESEED, 347)
GO

-- ----------------------------
-- Records of biometric_logs
-- ----------------------------
SET IDENTITY_INSERT [dbo].[biometric_logs] ON
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'181', N'1', N'1', N'2021-07-14 19:56:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'182', N'1', N'1', N'2021-07-14 19:57:00.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'183', N'1', N'1', N'2021-07-14 19:57:12.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'184', N'1', N'1', N'2021-07-14 19:58:20.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'185', N'1', N'1', N'2021-07-14 19:59:40.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'186', N'1', N'1', N'2021-07-14 20:02:08.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'187', N'1', N'1', N'2021-07-14 20:02:11.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'188', N'1', N'1', N'2021-07-14 20:19:47.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'189', N'1', N'1', N'2021-07-14 20:20:01.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'190', N'1', N'1', N'2021-07-14 20:20:20.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'191', N'1', N'1', N'2021-07-14 20:30:30.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'192', N'1', N'1', N'2021-07-14 20:30:38.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'193', N'1', N'1', N'2021-07-14 20:31:38.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'194', N'1', N'1', N'2021-07-14 20:32:55.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'195', N'1', N'1', N'2021-07-14 20:34:22.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'196', N'1', N'1', N'2021-07-14 20:37:58.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'197', N'1', N'1', N'2021-07-14 20:38:02.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'198', N'1', N'1', N'2021-07-14 20:38:08.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'199', N'1', N'1', N'2021-07-14 20:42:15.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'200', N'1', N'1', N'2021-07-14 20:57:33.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'201', N'1', N'1', N'2021-07-14 21:50:26.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'202', N'1', N'1', N'2021-07-16 11:13:36.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'203', N'1', N'1', N'2021-07-16 18:54:50.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'204', N'1', N'1', N'2021-07-19 08:29:59.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'205', N'1', N'1', N'2021-07-19 08:58:50.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'206', N'1', N'1', N'2021-07-19 14:43:23.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'207', N'1', N'1', N'2021-07-19 14:43:37.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'208', N'1', N'1', N'2021-07-19 14:43:48.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'209', N'1', N'1', N'2021-07-19 14:43:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'210', N'1', N'1', N'2021-07-19 14:45:41.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'211', N'1', N'1', N'2021-07-19 14:45:44.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'212', N'1', N'1', N'2021-07-19 14:45:47.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'213', N'1', N'1', N'2021-07-19 14:45:50.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'214', N'1', N'1', N'2021-07-19 14:45:52.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'215', N'1', N'1', N'2021-07-19 14:45:55.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'216', N'1', N'1', N'2021-07-19 14:46:28.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'217', N'1', N'1', N'2021-07-19 14:46:38.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'218', N'1', N'1', N'2021-07-19 14:46:41.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'219', N'1', N'1', N'2021-07-19 14:46:44.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'220', N'1', N'1', N'2021-07-19 14:46:48.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'221', N'1', N'1', N'2021-07-19 14:47:01.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'222', N'1', N'1', N'2021-07-19 14:47:04.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'223', N'1', N'1', N'2021-07-19 14:47:32.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'224', N'1', N'1', N'2021-07-19 14:47:35.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'225', N'1', N'1', N'2021-07-19 14:47:38.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'226', N'1', N'1', N'2021-07-19 14:47:41.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'227', N'1', N'1', N'2021-07-19 14:47:43.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'228', N'1', N'1', N'2021-07-19 14:48:16.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'229', N'1', N'1', N'2021-07-19 14:48:20.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'230', N'1', N'1', N'2021-07-19 14:49:30.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'231', N'1', N'1', N'2021-07-19 14:54:04.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'232', N'1', N'1', N'2021-07-19 14:54:07.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'233', N'1', N'1', N'2021-07-19 14:55:17.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'234', N'1', N'1', N'2021-07-19 14:55:40.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'235', N'1', N'1', N'2021-07-19 14:58:55.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'236', N'1', N'1', N'2021-07-19 14:58:58.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'237', N'1', N'1', N'2021-07-19 14:59:00.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'238', N'1', N'1', N'2021-07-19 14:59:03.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'239', N'1', N'1', N'2021-07-19 14:59:06.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'240', N'1', N'1', N'2021-07-19 14:59:09.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'241', N'2', N'1', N'2021-07-19 15:00:47.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'242', N'2', N'1', N'2021-07-19 15:00:50.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'243', N'2', N'1', N'2021-07-19 15:00:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'244', N'2', N'1', N'2021-07-19 15:00:55.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'245', N'1', N'1', N'2021-07-19 15:00:59.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'246', N'2', N'1', N'2021-07-19 15:01:01.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'247', N'2', N'1', N'2021-07-19 15:01:48.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'248', N'1', N'1', N'2021-07-19 15:01:51.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'249', N'1', N'1', N'2021-07-19 15:01:53.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'250', N'2', N'1', N'2021-07-19 15:01:56.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'251', N'2', N'1', N'2021-07-19 15:01:58.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'252', N'2', N'1', N'2021-07-19 15:02:01.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'253', N'2', N'1', N'2021-07-19 15:02:03.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'254', N'2', N'1', N'2021-07-19 15:02:05.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'255', N'2', N'1', N'2021-07-19 15:02:07.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'256', N'2', N'1', N'2021-07-19 15:02:09.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'257', N'1', N'1', N'2021-07-19 15:02:12.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'258', N'1', N'1', N'2021-07-19 15:02:15.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'259', N'1', N'1', N'2021-07-19 15:02:17.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'260', N'2', N'1', N'2021-07-19 15:02:19.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'261', N'2', N'1', N'2021-07-19 15:02:21.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'262', N'1', N'1', N'2021-07-19 15:02:38.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'263', N'2', N'1', N'2021-07-19 15:02:41.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'264', N'2', N'1', N'2021-07-19 15:02:44.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'265', N'2', N'1', N'2021-07-19 15:02:47.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'266', N'2', N'1', N'2021-07-19 15:02:49.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'267', N'2', N'1', N'2021-07-19 15:02:52.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'268', N'2', N'1', N'2021-07-19 15:02:54.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'269', N'2', N'1', N'2021-07-19 15:02:56.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'270', N'2', N'1', N'2021-07-19 15:02:58.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'271', N'2', N'1', N'2021-07-19 15:03:01.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'272', N'2', N'1', N'2021-07-19 15:03:03.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'273', N'2', N'1', N'2021-07-19 15:03:06.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'274', N'2', N'1', N'2021-07-19 15:03:08.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'275', N'2', N'1', N'2021-07-19 15:03:10.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'276', N'2', N'1', N'2021-07-19 15:03:12.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'277', N'2', N'1', N'2021-07-19 15:03:14.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'278', N'2', N'1', N'2021-07-19 15:03:17.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'279', N'2', N'1', N'2021-07-19 15:03:19.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'280', N'2', N'1', N'2021-07-19 15:03:21.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'281', N'2', N'1', N'2021-07-19 15:03:24.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'282', N'2', N'1', N'2021-07-19 15:03:26.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'283', N'2', N'1', N'2021-07-19 15:03:28.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'284', N'2', N'1', N'2021-07-19 15:03:31.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'285', N'2', N'1', N'2021-07-19 15:03:33.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'286', N'2', N'1', N'2021-07-19 15:03:35.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'287', N'2', N'1', N'2021-07-19 15:03:37.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'288', N'1', N'1', N'2021-07-19 15:03:40.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'289', N'1', N'1', N'2021-07-19 15:03:42.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'290', N'1', N'1', N'2021-07-19 15:03:44.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'291', N'1', N'1', N'2021-07-19 15:03:47.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'292', N'1', N'1', N'2021-07-19 15:03:50.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'293', N'1', N'1', N'2021-07-19 15:03:52.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'294', N'1', N'1', N'2021-07-19 15:03:55.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'295', N'1', N'1', N'2021-07-19 15:03:57.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'296', N'1', N'1', N'2021-07-19 15:04:00.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'297', N'1', N'1', N'2021-07-19 15:04:08.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'298', N'1', N'1', N'2021-07-19 15:04:10.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'299', N'1', N'1', N'2021-07-19 15:04:12.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'300', N'1', N'1', N'2021-07-19 15:04:16.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'301', N'1', N'1', N'2021-07-19 15:04:18.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'302', N'1', N'1', N'2021-07-19 15:04:21.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'303', N'1', N'1', N'2021-07-19 15:04:23.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'304', N'1', N'1', N'2021-07-19 15:04:26.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'305', N'1', N'1', N'2021-07-19 15:04:28.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'306', N'1', N'1', N'2021-07-19 15:04:30.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'307', N'1', N'1', N'2021-07-19 15:04:33.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'308', N'3', N'1', N'2021-07-19 15:06:50.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'309', N'3', N'1', N'2021-07-19 15:06:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'310', N'3', N'1', N'2021-07-19 15:06:56.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'311', N'3', N'1', N'2021-07-19 15:06:59.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'312', N'3', N'1', N'2021-07-19 15:07:07.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'313', N'3', N'1', N'2021-07-19 15:07:10.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'314', N'1', N'1', N'2021-07-19 15:07:13.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'315', N'2', N'1', N'2021-07-19 15:07:17.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'316', N'3', N'1', N'2021-07-19 15:07:42.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'317', N'3', N'1', N'2021-07-19 15:07:48.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'318', N'1', N'1', N'2021-07-19 15:07:50.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'319', N'1', N'1', N'2021-07-19 15:07:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'320', N'1', N'1', N'2021-07-19 15:07:58.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'321', N'2', N'1', N'2021-07-19 15:08:03.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'322', N'2', N'1', N'2021-07-19 15:08:06.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'323', N'2', N'1', N'2021-07-19 15:08:08.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'324', N'2', N'1', N'2021-07-19 15:08:10.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'325', N'3', N'1', N'2021-07-19 15:08:14.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'326', N'3', N'1', N'2021-07-19 15:08:23.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'327', N'1', N'1', N'2021-07-21 11:26:44.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'328', N'1', N'15', N'2021-07-21 11:26:51.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'329', N'2', N'1', N'2021-07-21 11:26:55.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'330', N'1', N'15', N'2021-07-21 11:27:01.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'331', N'1', N'1', N'2021-07-21 11:35:11.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'332', N'1', N'1', N'2021-07-21 11:36:36.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'333', N'1', N'1', N'2021-07-21 11:36:42.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'334', N'1', N'1', N'2021-07-21 11:36:46.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'335', N'3', N'1', N'2021-07-21 11:36:50.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'336', N'3', N'1', N'2021-07-21 11:36:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'337', N'1', N'1', N'2021-07-21 18:45:45.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'338', N'1', N'15', N'2021-07-21 19:39:36.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'339', N'1', N'15', N'2021-07-21 19:39:42.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'340', N'2', N'1', N'2021-07-22 02:41:45.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'341', N'1', N'1', N'2021-07-27 22:48:41.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'342', N'1', N'1', N'2021-07-28 12:13:59.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'343', N'1', N'1', N'2021-07-29 01:23:53.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'344', N'1', N'1', N'2021-07-29 10:23:26.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'345', N'1', N'1', N'2021-07-29 11:20:40.000', N'0', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'346', N'1', N'1', N'2021-07-30 16:03:08.000', N'1', N'192.168.0.101', N'biometric');
GO
INSERT INTO [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (N'347', N'1', N'1', N'2021-08-02 18:35:41.000', N'1', N'192.168.0.101', N'biometric');
GO
SET IDENTITY_INSERT [dbo].[biometric_logs] OFF
GO

-- ----------------------------
-- Indexes structure for table biometric_logs
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[biometric_logs]
-- ----------------------------
ALTER TABLE [dbo].[biometric_logs] ADD PRIMARY KEY ([id])
GO
