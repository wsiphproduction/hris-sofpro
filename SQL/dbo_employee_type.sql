-- ----------------------------
-- Table structure for [dbo].[employee_type]
-- ----------------------------
DROP TABLE [dbo].[employee_type]
GO
CREATE TABLE [dbo].[employee_type] (
[id] int NOT NULL IDENTITY(1,1) ,
[name] nvarchar(255) NULL DEFAULT NULL ,
[createdAt] datetime NULL DEFAULT NULL ,
[updatedAt] datetime NULL DEFAULT NULL 
)

GO

SET IDENTITY_INSERT [dbo].[employee_type] ON
GO
INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'1', N'Regular', N'2021-06-18 15:38:15', null);
GO
INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'2', N'Probationary', N'2021-06-18 15:38:31', null);
GO
INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'3', N'Project Based', N'2021-06-18 15:38:31', null);
GO
INSERT INTO [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt])VALUES (N'4', N'Casual', N'2021-06-18 15:38:31', null);
