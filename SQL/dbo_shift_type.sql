-- ----------------------------
-- Table structure for [dbo].[shift_type]
-- ----------------------------
if OBJECT_ID('[dbo].[shift_type]') IS NOT NULL
DROP TABLE [dbo].[shift_type]
GO
CREATE TABLE [dbo].[shift_type] (
[id] int NOT NULL IDENTITY(5,1) ,
[name] nvarchar(255) NULL DEFAULT NULL ,
[createdAt] datetime NOT NULL DEFAULT (getdate()) ,
[updatedAt] datetime NULL DEFAULT NULL 
)


GO

-- ----------------------------
-- Records of shift_type
-- ----------------------------
SET IDENTITY_INSERT [dbo].[shift_type] ON
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'1',  N'12 TO 8PM', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'2',  N'1st SHIFT', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'3',  N'1ST SHIFT (12:30AM - 8:30AM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'4',  N'1ST SHIFT (12am-8am)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'5',  N'1ST SHIFT (1AM-9AM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'6',  N'1st SHIFT GEO', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'7',  N'2ND SHIFT', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'8',  N'2ND SHIFT (8:30AM-4:30PM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'9',  N'2ND SHIFT (9AM-5PM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'10', N'2nd SHIFT GEO', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'11', N'2ND SHIFT(8AM-4PM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'12', N'3RD SHIFT', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'13', N'3RD SHIFT (4:30PM - 12:30AM)', N'2021-06-18 15:38:15'
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'14', N'3RD SHIFT (4PM-12AM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'15', N'3RD SHIFT (5PM-1AM)', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'16', N'3rd SHIFT GEO', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'17', N'8AM TO 4PM', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'18', N'8PM TO 4AM', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'19', N'BUS DRIVER 1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'20', N'BUS DRIVER 2', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'21', N'Gen Services 1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'22', N'Gen Services 2', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'23', N'Gen Services 3', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'24', N'Gen Services 4', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'25', N'Gen Services 5', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'26', N'Gen Services 6', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'27', N'HALFDAY AM', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'28', N'HALFDAY PM', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'29', N'LEVEL 6 1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'30', N'LEVEL 6 2', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'31', N'LEVEL 6 3', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'32', N'LEVEL 8 SHAFT 1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'33', N'LEVEL 8 SHAFT 2', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'34', N'LEVEL 8 SHAFT 3', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'35', N'NON-SHIFTER', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'36', N'NON-SHIFTER1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'37', N'OC MONDAY', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'38', N'OC SATURDAY', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'39', N'OC TUE-FRIDAY', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'40', N'RHD 1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'41', N'RHD 2', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'42', N'RHD 3', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'43', N'RHD 4', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'44', N'Security 1', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'45', N'Security 2', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'46', N'Security 3', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[shift_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'47', N'SURVEY (2ND SHIFT)', N'2021-06-18 15:38:15', null);