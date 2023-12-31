USE [master]
GO
/****** Object:  Database [philsaga]    Script Date: 8/19/2021 2:25:23 AM ******/
CREATE DATABASE [philsaga]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'philsaga', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\philsaga.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'philsaga_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\philsaga_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [philsaga] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [philsaga].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [philsaga] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [philsaga] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [philsaga] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [philsaga] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [philsaga] SET ARITHABORT OFF 
GO
ALTER DATABASE [philsaga] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [philsaga] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [philsaga] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [philsaga] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [philsaga] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [philsaga] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [philsaga] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [philsaga] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [philsaga] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [philsaga] SET  DISABLE_BROKER 
GO
ALTER DATABASE [philsaga] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [philsaga] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [philsaga] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [philsaga] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [philsaga] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [philsaga] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [philsaga] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [philsaga] SET RECOVERY FULL 
GO
ALTER DATABASE [philsaga] SET  MULTI_USER 
GO
ALTER DATABASE [philsaga] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [philsaga] SET DB_CHAINING OFF 
GO
ALTER DATABASE [philsaga] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [philsaga] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [philsaga] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [philsaga] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'philsaga', N'ON'
GO
ALTER DATABASE [philsaga] SET QUERY_STORE = OFF
GO
USE [philsaga]
GO
/****** Object:  Table [dbo].[adjustment]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adjustment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[year] [int] NOT NULL,
	[month] [varchar](2) NULL,
	[period] [varchar](1) NULL,
	[amount] [real] NOT NULL,
	[status] [int] NOT NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[announcement]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[announcement](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[subject] [nvarchar](500) NOT NULL,
	[short_description] [nvarchar](max) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[slug] [nvarchar](255) NULL,
	[created_by] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[approvers]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[approvers](
	[id] [int] IDENTITY(26,1) NOT NULL,
	[company_location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[primary_approver_id] [int] NULL,
	[backup_approver_id] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[biometric_csv]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[biometric_csv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[site] [nvarchar](255) NULL,
	[filename] [nvarchar](255) NOT NULL,
	[date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[biometric_logs]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[biometric_logs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[state] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[status] [int] NOT NULL,
	[ip_address] [nvarchar](16) NULL,
	[source] [nvarchar](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[biometric_number]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[biometric_number](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[biometric_id] [int] NOT NULL,
	[biometric_number] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[biometrics]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[biometrics](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[site] [nvarchar](255) NOT NULL,
	[status] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[branches]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[branches](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[location] [nvarchar](255) NOT NULL,
	[address] [nvarchar](512) NULL,
	[country_id] [int] NULL,
	[company_id] [int] NOT NULL,
	[description] [nvarchar](max) NULL,
	[status] [int] NOT NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[branding]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[branding](
	[id] [int] IDENTITY(5,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[logo] [nvarchar](255) NULL,
	[branding] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[business_trip]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[business_trip](
	[id] [int] IDENTITY(4,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date_start] [date] NOT NULL,
	[date_end] [date] NOT NULL,
	[title] [nvarchar](255) NULL,
	[note] [nvarchar](max) NULL,
	[primary_status] [int] NULL,
	[backup_status] [int] NULL,
	[primary_approver] [int] NULL,
	[backup_approver] [int] NULL,
	[approver_note] [nvarchar](max) NULL,
	[approved_by] [int] NULL,
	[_token] [nvarchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_profile]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_profile](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[shortid] [nvarchar](255) NULL,
	[position_applying_for] [nvarchar](255) NOT NULL,
	[first_name] [nvarchar](255) NOT NULL,
	[last_name] [nvarchar](255) NOT NULL,
	[current_address] [nvarchar](512) NULL,
	[permanent_address] [nvarchar](512) NULL,
	[email] [nvarchar](255) NULL,
	[phone_number] [nvarchar](255) NOT NULL,
	[alternate_number] [nvarchar](255) NULL,
	[birthday] [date] NULL,
	[gender] [nvarchar](6) NULL,
	[marital_status] [nvarchar](255) NULL,
	[nationality] [int] NULL,
	[interview_schedule] [datetime2](7) NULL,
	[attachment] [nvarchar](255) NULL,
	[sss_number] [nvarchar](255) NULL,
	[pagibig_number] [nvarchar](255) NULL,
	[tin_number] [nvarchar](255) NULL,
	[philhealth_number] [nvarchar](255) NULL,
	[status] [int] NOT NULL,
	[interview_status] [int] NOT NULL,
	[note] [nvarchar](max) NULL,
	[company] [int] NULL,
	[department] [int] NULL,
	[job_title] [int] NULL,
	[start_date] [date] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[companies]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[companies](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[code] [nvarchar](255) NULL,
	[logo] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[status] [int] NOT NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuration]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[configuration](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[json] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[countries]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[countries](
	[id] [int] IDENTITY(251,1) NOT NULL,
	[iso] [nchar](3) NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[code] [nchar](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crm_chase]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crm_chase](
	[id] [int] IDENTITY(6,1) NOT NULL,
	[account] [nvarchar](255) NULL,
	[project_site] [nvarchar](255) NULL,
	[type] [int] NULL,
	[revenue] [real] NULL,
	[sales] [nvarchar](11) NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crm_clone]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crm_clone](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[chase_id] [int] NOT NULL,
	[sqm] [real] NULL,
	[reason] [nvarchar](max) NULL,
	[flag] [int] NOT NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crm_members]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crm_members](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[win_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[custom_approver]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[custom_approver](
	[id] [int] IDENTITY(34,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[primary_approver_id] [int] NULL,
	[backup_approver_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[departments]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departments](
	[id] [int] IDENTITY(7,1) NOT NULL,
	[division_id] [int] NOT NULL,
	[department_name] [nvarchar](255) NOT NULL,
	[department_code] [nvarchar](255) NOT NULL,
	[manager_id] [int] NOT NULL,
	[assistant_manager_id] [int] NULL,
	[secretary_id] [int] NOT NULL,
	[description] [nvarchar](max) NULL,
	[status] [int] NOT NULL,
	[deletedAt] [datetime2](7) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dispute]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dispute](
	[id] [int] IDENTITY(6,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[year] [int] NULL,
	[month] [nvarchar](2) NULL,
	[period] [nvarchar](1) NULL,
	[hour] [int] NOT NULL,
	[date] [date] NULL,
	[type] [int] NOT NULL,
	[note] [nvarchar](max) NULL,
	[primary_status] [int] NULL,
	[backup_status] [int] NULL,
	[primary_approver] [int] NULL,
	[backup_approver] [int] NULL,
	[admin_status] [int] NULL,
	[_token] [nvarchar](255) NULL,
	[document] [nvarchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[divisions]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[divisions](
	[id] [int] IDENTITY(9,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[code] [nvarchar](255) NULL,
	[manager_id] [int] NULL,
	[assistant_manager_id] [int] NULL,
	[secretary_id] [int] NULL,
	[description] [nvarchar](max) NULL,
	[status] [int] NULL,
	[deletedAt] [datetime2](7) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[educations]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[educations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[school] [nvarchar](255) NULL,
	[degree] [nvarchar](255) NULL,
	[year_attended] [nvarchar](16) NULL,
	[post_graduate] [nvarchar](255) NULL,
	[others] [nvarchar](max) NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee_type]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employments]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employments](
	[id] [int] IDENTITY(10,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[employee_number] [nvarchar](255) NULL,
	[company_id] [int] NULL,
	[company_branch_id] [int] NULL,
	[division_id] [int] NULL,
	[department_id] [int] NULL,
	[section_id] [int] NULL,
	[position_id] [int] NULL,
	[position_classification_id] [int] NULL,
	[position_category_id] [int] NULL,
	[approving_organization] [nvarchar](255) NULL,
	[work_area_id] [int] NULL,
	[branch_id] [int] NULL,
	[job_title_id] [int] NULL,
	[date_entry] [date] NULL,
	[date_exit] [date] NULL,
	[comment] [nvarchar](max) NULL,
	[status] [int] NOT NULL,
	[team_id] [int] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__employme__3213E83F4F7766AE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[events]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[id] [int] IDENTITY(10,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date] [datetime2](7) NOT NULL,
	[end_date] [datetime2](7) NULL,
	[type] [nvarchar](255) NOT NULL,
	[comment] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[holidays]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[holidays](
	[id] [int] IDENTITY(7,1) NOT NULL,
	[country_id] [int] NULL,
	[location_id] [int] NULL,
	[date] [date] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[type] [int] NOT NULL,
	[status] [int] NOT NULL,
	[note] [nvarchar](max) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[incentive]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incentive](
	[id] [int] IDENTITY(70,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[from] [date] NULL,
	[to] [date] NULL,
	[amount] [real] NOT NULL,
	[label] [nvarchar](max) NOT NULL,
	[mode] [int] NOT NULL,
	[status] [int] NOT NULL,
	[period] [int] NULL,
	[taxable] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[interview]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[interview](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_profile_id] [int] NOT NULL,
	[interviewer] [int] NOT NULL,
	[interview_date] [date] NOT NULL,
	[overall_assessment] [nvarchar](max) NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[interview_ratings]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[interview_ratings](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[interview_id] [int] NOT NULL,
	[title] [nvarchar](max) NOT NULL,
	[candidate_rating] [int] NOT NULL,
	[job_relevance] [int] NOT NULL,
	[notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leave_credit_policy]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leave_credit_policy](
	[id] [int] IDENTITY(488,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[policy_id] [int] NOT NULL,
	[balance] [real] NULL,
	[utilized] [real] NULL,
	[cycle] [date] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leave_policy]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leave_policy](
	[id] [int] IDENTITY(7,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[total_per_year] [int] NOT NULL,
	[gender] [nvarchar](255) NULL,
	[probation_validity] [int] NOT NULL,
	[initial] [int] NULL,
	[cycle] [int] NOT NULL,
	[increment] [int] NULL,
	[max_increment] [int] NULL,
	[status] [int] NOT NULL,
	[company] [int] NULL,
	[department] [int] NULL,
	[description] [nvarchar](max) NULL,
	[carry_over] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leaves]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leaves](
	[id] [int] IDENTITY(24,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[dates] [nvarchar](max) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[leave_type] [int] NOT NULL,
	[other] [nvarchar](255) NULL,
	[no_of_days] [real] NOT NULL,
	[credit] [int] NOT NULL,
	[reason] [nvarchar](max) NULL,
	[attachment] [nvarchar](255) NULL,
	[primary_status] [int] NOT NULL,
	[backup_status] [int] NULL,
	[primary_approver] [int] NULL,
	[backup_approver] [int] NULL,
	[approver_note] [nvarchar](max) NULL,
	[_token] [nvarchar](255) NULL,
	[is_hr] [int] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[proccessed] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leaves_date]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leaves_date](
	[id] [int] IDENTITY(104,1) NOT NULL,
	[leave_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[number_of_day] [real] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loan]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loan](
	[id] [int] IDENTITY(3,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[amount] [real] NOT NULL,
	[label] [nvarchar](255) NOT NULL,
	[mode_of_payment] [int] NOT NULL,
	[date_to_pay] [date] NULL,
	[frequency] [int] NULL,
	[status] [int] NULL,
	[note] [nvarchar](max) NULL,
	[year] [nvarchar](4) NULL,
	[month] [nvarchar](2) NULL,
	[period] [nvarchar](1) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[loan_type] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loan_payments]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loan_payments](
	[id] [int] IDENTITY(7,1) NOT NULL,
	[loan_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[year] [int] NOT NULL,
	[month] [nvarchar](2) NULL,
	[period] [nvarchar](1) NULL,
	[amount] [real] NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[locations]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[locations](
	[id] [int] IDENTITY(5,1) NOT NULL,
	[location] [nvarchar](255) NOT NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[logs]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime2](7) NOT NULL,
	[message] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[modules]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[modules](
	[id] [int] IDENTITY(72,1) NOT NULL,
	[title] [nvarchar](255) NULL,
	[tag] [nvarchar](255) NOT NULL,
	[status] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notification]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notification](
	[id] [int] IDENTITY(58,1) NOT NULL,
	[sender] [int] NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[date] [datetime] NULL,
	[created_by] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notification_receiver]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notification_receiver](
	[id] [bigint] IDENTITY(57,1) NOT NULL,
	[notification_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[status] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[overtimes]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[overtimes](
	[id] [int] IDENTITY(11,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[type] [int] NOT NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[start_time] [time](7) NULL,
	[end_time] [time](7) NULL,
	[actual_check_in] [time](7) NULL,
	[actual_check_out] [time](7) NULL,
	[no_of_hours] [int] NOT NULL,
	[purpose] [nvarchar](max) NULL,
	[primary_status] [int] NULL,
	[backup_status] [int] NULL,
	[primary_approver] [int] NULL,
	[backup_approver] [int] NULL,
	[approver_note] [nvarchar](max) NULL,
	[_token] [nvarchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payroll]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payroll](
	[id] [int] IDENTITY(8,1) NOT NULL,
	[period] [nvarchar](255) NOT NULL,
	[attachment] [nvarchar](255) NULL,
	[date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payroll_group]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payroll_group](
	[id] [int] IDENTITY(3,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[company_location_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payroll_period]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payroll_period](
	[id] [int] IDENTITY(3,1) NOT NULL,
	[payroll_group_id] [int] NOT NULL,
	[period] [nvarchar](1) NOT NULL,
	[payroll_day] [int] NULL,
	[payroll_day_from] [int] NULL,
	[payroll_day_to] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payslips]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payslips](
	[id] [bigint] IDENTITY(371,1) NOT NULL,
	[user_id] [int] NULL,
	[payroll_period] [nvarchar](255) NOT NULL,
	[employee_number] [nvarchar](255) NULL,
	[employee_name] [nvarchar](255) NULL,
	[monthly_rate] [real] NULL,
	[this_pay] [real] NULL,
	[absence] [real] NULL,
	[overtime_hrs] [real] NULL,
	[amount] [real] NULL,
	[gross_pay] [real] NULL,
	[reimburseable_allowance] [real] NULL,
	[other_fees_allowances] [real] NULL,
	[total_pay] [real] NULL,
	[tax] [real] NULL,
	[sss30th] [real] NULL,
	[phic30th] [real] NULL,
	[pagibig30th] [real] NULL,
	[other_deductions] [real] NULL,
	[sss_loan15th] [real] NULL,
	[pagibig_loan15th] [real] NULL,
	[employee_charges] [real] NULL,
	[intellicare] [real] NULL,
	[net_pay] [real] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positions]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positions](
	[id] [int] IDENTITY(445,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positions_category]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positions_category](
	[id] [int] IDENTITY(26,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positions_classification]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positions_classification](
	[id] [int] IDENTITY(4,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[requirements]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[requirements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_id] [int] NULL,
	[title] [nvarchar](255) NULL,
	[status] [int] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[id] [int] IDENTITY(9,1) NOT NULL,
	[label] [nvarchar](255) NOT NULL,
	[slug] [nvarchar](255) NULL,
	[status] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_permission]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_permission](
	[id] [int] IDENTITY(331,1) NOT NULL,
	[role_id] [int] NULL,
	[module_tag] [nvarchar](255) NULL,
	[read] [int] NULL,
	[write] [int] NULL,
	[modify] [int] NULL,
	[delete] [int] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salary]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salary](
	[id] [int] IDENTITY(93,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[amount] [real] NOT NULL,
	[mode] [int] NOT NULL,
	[payroll] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sections]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sections](
	[id] [int] IDENTITY(5,1) NOT NULL,
	[department_id] [int] NOT NULL,
	[section_name] [nvarchar](255) NULL,
	[section_code] [nvarchar](255) NULL,
	[supervisor_id] [int] NULL,
	[assistant_supervisor_id] [int] NULL,
	[secretary_id] [int] NULL,
	[description] [nvarchar](max) NULL,
	[status] [int] NULL,
	[deletedAt] [datetime2](7) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shift_type]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shift_type](
	[id] [int] IDENTITY(48,1) NOT NULL,
	[shift_id] [varchar](65) NULL,
	[shift_desc] [varchar](65) NULL,
	[shift_opt] [varchar](65) NULL,
	[credit_time_in] [time](7) NULL,
	[credit_time_out] [time](7) NULL,
	[time_in] [time](7) NULL,
	[time_out] [time](7) NULL,
	[gp] [int] NULL,
	[break_in] [time](7) NULL,
	[break_out] [time](7) NULL,
	[num_hours] [int] NULL,
	[cbamin] [time](7) NULL,
	[cbamout] [time](7) NULL,
	[cbpmin] [time](7) NULL,
	[cbpmout] [time](7) NULL,
	[trig_late] [time](7) NULL,
	[trig_under] [time](7) NULL,
	[early_in] [time](7) NULL,
	[early_out] [time](7) NULL,
	[late_in] [time](7) NULL,
	[late_out] [time](7) NULL,
	[flex_am_break] [int] NULL,
	[flex_pm_break] [int] NULL,
	[flex_break] [int] NULL,
	[min_ot] [int] NULL,
	[hday_by_late] [int] NULL,
	[ot_type] [varchar](45) NULL,
	[break_hours] [int] NULL,
	[seq_id] [int] NULL,
	[gp2] [int] NULL,
	[trig_absent] [varchar](45) NULL,
	[min_workhours_1h] [int] NULL,
	[min_workhours_2h] [int] NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_terminal] [int] NULL,
	[updated_terminal] [int] NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shifts]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shifts](
	[id] [bigint] IDENTITY(9395,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[type] [int] NULL,
	[date] [date] NOT NULL,
	[check_in] [time](7) NULL,
	[check_out] [time](7) NULL,
	[actual_check_in] [time](7) NULL,
	[actual_check_out] [time](7) NULL,
	[between_start] [time](7) NULL,
	[between_end] [time](7) NULL,
	[primary_status] [int] NULL,
	[backup_status] [int] NULL,
	[shift_length] [int] NULL,
	[paid_hours] [int] NULL,
	[primary_approver] [int] NULL,
	[backup_approver] [int] NULL,
	[approver_note] [nvarchar](max) NULL,
	[onsite] [int] NULL,
	[_token] [nvarchar](255) NULL,
	[approved_by] [int] NULL,
	[approved_at] [datetime2](7) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[reg_holiday_work_hrs] [int] NULL,
	[reg_holiday_rest_day_work_hrs] [int] NULL,
	[reg_special_holiday_restday_work_hrs] [int] NULL,
	[double_reg_holiday] [int] NULL,
	[special_holiday] [int] NULL,
	[special_holiday_restday] [int] NULL,
	[late] [int] NULL,
	[absent] [int] NULL,
	[undertime] [int] NULL,
	[awol] [int] NULL,
	[actual_work_hours] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[taxonomy]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[taxonomy](
	[id] [int] IDENTITY(286,1) NOT NULL,
	[parent_id] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[code] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[status] [int] NOT NULL,
	[node] [int] NULL,
	[system_role] [int] NOT NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_in_out]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_in_out](
	[id] [int] IDENTITY(20,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](7) NOT NULL,
	[type] [nvarchar](10) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[two_factor_authentication]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[two_factor_authentication](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[status] [int] NULL,
	[code] [nvarchar](255) NULL,
	[validity_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[undertime]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[undertime](
	[id] [int] IDENTITY(3,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date] [date] NULL,
	[time] [time](7) NULL,
	[reason] [nvarchar](max) NULL,
	[primary_status] [int] NULL,
	[backup_status] [int] NULL,
	[primary_approver] [int] NULL,
	[backup_approver] [int] NULL,
	[approver_note] [nvarchar](max) NULL,
	[_token] [nvarchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_setting]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_setting](
	[id] [int] IDENTITY(88,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[has_holiday] [int] NULL,
	[has_overtime] [int] NULL,
	[work_schedule_method] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(119,1) NOT NULL,
	[parent_id] [int] NOT NULL,
	[shortid] [nvarchar](255) NOT NULL,
	[first_name] [nvarchar](255) NOT NULL,
	[middle_name] [nvarchar](255) NULL,
	[suffix] [nvarchar](255) NULL,
	[nick_name] [nvarchar](255) NULL,
	[last_name] [nvarchar](255) NOT NULL,
	[gender] [nvarchar](6) NOT NULL,
	[birthdate] [date] NULL,
	[avatar] [nvarchar](255) NULL,
	[present_address] [nvarchar](512) NULL,
	[permanent_address] [nvarchar](512) NULL,
	[nationality] [int] NULL,
	[marital_status] [nvarchar](255) NULL,
	[contact_number] [nvarchar](20) NULL,
	[email] [nvarchar](255) NULL,
	[username] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[status] [int] NOT NULL,
	[user_role] [nvarchar](255) NULL,
	[note] [nvarchar](max) NULL,
	[sss_number] [nvarchar](255) NULL,
	[pagibig_number] [nvarchar](255) NULL,
	[tin_number] [nvarchar](255) NULL,
	[philhealth_number] [nvarchar](255) NULL,
	[employee_number] [nvarchar](255) NULL,
	[company_branch_id] [int] NULL,
	[department_id] [int] NULL,
	[job_title_id] [int] NULL,
	[team_id] [int] NULL,
	[date_entry] [date] NULL,
	[resignation_date] [date] NULL,
	[reset_token] [nvarchar](255) NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[employee_type] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users_document]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_document](
	[id] [int] IDENTITY(6,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[label] [nvarchar](255) NULL,
	[hash] [nvarchar](255) NULL,
	[original_name] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[work_areas]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[work_areas](
	[id] [int] IDENTITY(5,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[work_schedule]    Script Date: 8/19/2021 2:25:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[work_schedule](
	[id] [int] IDENTITY(87,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[type] [int] NOT NULL,
	[break_type] [int] NOT NULL,
	[rooster_break] [int] NOT NULL,
	[destination_entitlement] [nvarchar](255) NULL,
	[shift_type] [int] NOT NULL,
	[effective_date] [date] NOT NULL,
	[check_in] [time](7) NULL,
	[check_out] [time](7) NULL,
	[between_start] [time](7) NULL,
	[between_end] [time](7) NULL,
	[shift_length] [int] NOT NULL,
	[paid_hours] [int] NOT NULL,
	[monday] [int] NULL,
	[tuesday] [int] NULL,
	[wednesday] [int] NULL,
	[thursday] [int] NULL,
	[friday] [int] NULL,
	[saturday] [int] NULL,
	[sunday] [int] NULL,
	[onsite] [int] NOT NULL,
	[created_by] [int] NULL,
	[updated_by] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[announcement] ON 

INSERT [dbo].[announcement] ([id], [subject], [short_description], [description], [slug], [created_by], [created_at], [updated_at]) VALUES (1, N'Welcome', N'Welcome to the new Human Resource Information System!', N'<p>Have a nice day!</p>', N'welcome', 1, CAST(N'2019-10-01T11:14:30.000' AS DateTime), CAST(N'2021-06-01T22:32:47.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[announcement] OFF
GO
SET IDENTITY_INSERT [dbo].[approvers] ON 

INSERT [dbo].[approvers] ([id], [company_location_id], [department_id], [primary_approver_id], [backup_approver_id], [created_at], [updated_at], [created_by], [updated_by]) VALUES (1, 1, 8, 18, 18, CAST(N'2019-11-05T11:54:48.000' AS DateTime), CAST(N'2019-11-20T17:02:04.000' AS DateTime), NULL, 3)
INSERT [dbo].[approvers] ([id], [company_location_id], [department_id], [primary_approver_id], [backup_approver_id], [created_at], [updated_at], [created_by], [updated_by]) VALUES (2, 1, 9, 18, 18, CAST(N'2019-11-05T11:54:48.000' AS DateTime), CAST(N'2019-11-20T17:02:52.000' AS DateTime), NULL, 3)
INSERT [dbo].[approvers] ([id], [company_location_id], [department_id], [primary_approver_id], [backup_approver_id], [created_at], [updated_at], [created_by], [updated_by]) VALUES (25, 1, 10, NULL, NULL, CAST(N'2021-06-01T23:05:20.000' AS DateTime), CAST(N'2021-06-01T23:05:20.000' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[approvers] OFF
GO
SET IDENTITY_INSERT [dbo].[biometric_csv] ON 

INSERT [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (23, N'1', N'20210720005203.csv', CAST(N'2021-07-20' AS Date))
INSERT [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (1002, N'1', N'20210803143049.csv', CAST(N'2021-08-03' AS Date))
INSERT [dbo].[biometric_csv] ([id], [site], [filename], [date]) VALUES (1004, N'1', N'20210804151116.csv', CAST(N'2021-08-04' AS Date))
SET IDENTITY_INSERT [dbo].[biometric_csv] OFF
GO
SET IDENTITY_INSERT [dbo].[biometric_logs] ON 

INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (181, 1, 1, CAST(N'2021-07-14T19:56:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (182, 1, 1, CAST(N'2021-07-14T19:57:00.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (183, 1, 1, CAST(N'2021-07-14T19:57:12.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (184, 1, 1, CAST(N'2021-07-14T19:58:20.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (185, 1, 1, CAST(N'2021-07-14T19:59:40.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (186, 1, 1, CAST(N'2021-07-14T20:02:08.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (187, 1, 1, CAST(N'2021-07-14T20:02:11.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (188, 1, 1, CAST(N'2021-07-14T20:19:47.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (189, 1, 1, CAST(N'2021-07-14T20:20:01.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (190, 1, 1, CAST(N'2021-07-14T20:20:20.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (191, 1, 1, CAST(N'2021-07-14T20:30:30.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (192, 1, 1, CAST(N'2021-07-14T20:30:38.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (193, 1, 1, CAST(N'2021-07-14T20:31:38.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (194, 1, 1, CAST(N'2021-07-14T20:32:55.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (195, 1, 1, CAST(N'2021-07-14T20:34:22.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (196, 1, 1, CAST(N'2021-07-14T20:37:58.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (197, 1, 1, CAST(N'2021-07-14T20:38:02.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (198, 1, 1, CAST(N'2021-07-14T20:38:08.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (199, 1, 1, CAST(N'2021-07-14T20:42:15.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (200, 1, 1, CAST(N'2021-07-14T20:57:33.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (201, 1, 1, CAST(N'2021-07-14T21:50:26.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (202, 1, 1, CAST(N'2021-07-16T11:13:36.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (203, 1, 1, CAST(N'2021-07-16T18:54:50.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (204, 1, 1, CAST(N'2021-07-19T08:29:59.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (205, 1, 1, CAST(N'2021-07-19T08:58:50.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (206, 1, 1, CAST(N'2021-07-19T14:43:23.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (207, 1, 1, CAST(N'2021-07-19T14:43:37.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (208, 1, 1, CAST(N'2021-07-19T14:43:48.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (209, 1, 1, CAST(N'2021-07-19T14:43:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (210, 1, 1, CAST(N'2021-07-19T14:45:41.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (211, 1, 1, CAST(N'2021-07-19T14:45:44.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (212, 1, 1, CAST(N'2021-07-19T14:45:47.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (213, 1, 1, CAST(N'2021-07-19T14:45:50.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (214, 1, 1, CAST(N'2021-07-19T14:45:52.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (215, 1, 1, CAST(N'2021-07-19T14:45:55.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (216, 1, 1, CAST(N'2021-07-19T14:46:28.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (217, 1, 1, CAST(N'2021-07-19T14:46:38.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (218, 1, 1, CAST(N'2021-07-19T14:46:41.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (219, 1, 1, CAST(N'2021-07-19T14:46:44.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (220, 1, 1, CAST(N'2021-07-19T14:46:48.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (221, 1, 1, CAST(N'2021-07-19T14:47:01.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (222, 1, 1, CAST(N'2021-07-19T14:47:04.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (223, 1, 1, CAST(N'2021-07-19T14:47:32.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (224, 1, 1, CAST(N'2021-07-19T14:47:35.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (225, 1, 1, CAST(N'2021-07-19T14:47:38.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (226, 1, 1, CAST(N'2021-07-19T14:47:41.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (227, 1, 1, CAST(N'2021-07-19T14:47:43.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (228, 1, 1, CAST(N'2021-07-19T14:48:16.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (229, 1, 1, CAST(N'2021-07-19T14:48:20.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (230, 1, 1, CAST(N'2021-07-19T14:49:30.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (231, 1, 1, CAST(N'2021-07-19T14:54:04.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (232, 1, 1, CAST(N'2021-07-19T14:54:07.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (233, 1, 1, CAST(N'2021-07-19T14:55:17.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (234, 1, 1, CAST(N'2021-07-19T14:55:40.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (235, 1, 1, CAST(N'2021-07-19T14:58:55.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (236, 1, 1, CAST(N'2021-07-19T14:58:58.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (237, 1, 1, CAST(N'2021-07-19T14:59:00.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (238, 1, 1, CAST(N'2021-07-19T14:59:03.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (239, 1, 1, CAST(N'2021-07-19T14:59:06.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (240, 1, 1, CAST(N'2021-07-19T14:59:09.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (241, 2, 1, CAST(N'2021-07-19T15:00:47.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (242, 2, 1, CAST(N'2021-07-19T15:00:50.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (243, 2, 1, CAST(N'2021-07-19T15:00:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (244, 2, 1, CAST(N'2021-07-19T15:00:55.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (245, 1, 1, CAST(N'2021-07-19T15:00:59.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (246, 2, 1, CAST(N'2021-07-19T15:01:01.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (247, 2, 1, CAST(N'2021-07-19T15:01:48.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (248, 1, 1, CAST(N'2021-07-19T15:01:51.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (249, 1, 1, CAST(N'2021-07-19T15:01:53.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (250, 2, 1, CAST(N'2021-07-19T15:01:56.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (251, 2, 1, CAST(N'2021-07-19T15:01:58.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (252, 2, 1, CAST(N'2021-07-19T15:02:01.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (253, 2, 1, CAST(N'2021-07-19T15:02:03.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (254, 2, 1, CAST(N'2021-07-19T15:02:05.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (255, 2, 1, CAST(N'2021-07-19T15:02:07.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (256, 2, 1, CAST(N'2021-07-19T15:02:09.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (257, 1, 1, CAST(N'2021-07-19T15:02:12.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (258, 1, 1, CAST(N'2021-07-19T15:02:15.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (259, 1, 1, CAST(N'2021-07-19T15:02:17.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (260, 2, 1, CAST(N'2021-07-19T15:02:19.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (261, 2, 1, CAST(N'2021-07-19T15:02:21.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (262, 1, 1, CAST(N'2021-07-19T15:02:38.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (263, 2, 1, CAST(N'2021-07-19T15:02:41.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (264, 2, 1, CAST(N'2021-07-19T15:02:44.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (265, 2, 1, CAST(N'2021-07-19T15:02:47.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (266, 2, 1, CAST(N'2021-07-19T15:02:49.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (267, 2, 1, CAST(N'2021-07-19T15:02:52.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (268, 2, 1, CAST(N'2021-07-19T15:02:54.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (269, 2, 1, CAST(N'2021-07-19T15:02:56.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (270, 2, 1, CAST(N'2021-07-19T15:02:58.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (271, 2, 1, CAST(N'2021-07-19T15:03:01.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (272, 2, 1, CAST(N'2021-07-19T15:03:03.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (273, 2, 1, CAST(N'2021-07-19T15:03:06.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (274, 2, 1, CAST(N'2021-07-19T15:03:08.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (275, 2, 1, CAST(N'2021-07-19T15:03:10.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (276, 2, 1, CAST(N'2021-07-19T15:03:12.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (277, 2, 1, CAST(N'2021-07-19T15:03:14.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (278, 2, 1, CAST(N'2021-07-19T15:03:17.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (279, 2, 1, CAST(N'2021-07-19T15:03:19.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
GO
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (280, 2, 1, CAST(N'2021-07-19T15:03:21.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (281, 2, 1, CAST(N'2021-07-19T15:03:24.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (282, 2, 1, CAST(N'2021-07-19T15:03:26.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (283, 2, 1, CAST(N'2021-07-19T15:03:28.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (284, 2, 1, CAST(N'2021-07-19T15:03:31.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (285, 2, 1, CAST(N'2021-07-19T15:03:33.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (286, 2, 1, CAST(N'2021-07-19T15:03:35.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (287, 2, 1, CAST(N'2021-07-19T15:03:37.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (288, 1, 1, CAST(N'2021-07-19T15:03:40.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (289, 1, 1, CAST(N'2021-07-19T15:03:42.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (290, 1, 1, CAST(N'2021-07-19T15:03:44.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (291, 1, 1, CAST(N'2021-07-19T15:03:47.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (292, 1, 1, CAST(N'2021-07-19T15:03:50.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (293, 1, 1, CAST(N'2021-07-19T15:03:52.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (294, 1, 1, CAST(N'2021-07-19T15:03:55.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (295, 1, 1, CAST(N'2021-07-19T15:03:57.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (296, 1, 1, CAST(N'2021-07-19T15:04:00.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (297, 1, 1, CAST(N'2021-07-19T15:04:08.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (298, 1, 1, CAST(N'2021-07-19T15:04:10.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (299, 1, 1, CAST(N'2021-07-19T15:04:12.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (300, 1, 1, CAST(N'2021-07-19T15:04:16.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (301, 1, 1, CAST(N'2021-07-19T15:04:18.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (302, 1, 1, CAST(N'2021-07-19T15:04:21.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (303, 1, 1, CAST(N'2021-07-19T15:04:23.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (304, 1, 1, CAST(N'2021-07-19T15:04:26.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (305, 1, 1, CAST(N'2021-07-19T15:04:28.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (306, 1, 1, CAST(N'2021-07-19T15:04:30.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (307, 1, 1, CAST(N'2021-07-19T15:04:33.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (308, 3, 1, CAST(N'2021-07-19T15:06:50.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (309, 3, 1, CAST(N'2021-07-19T15:06:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (310, 3, 1, CAST(N'2021-07-19T15:06:56.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (311, 3, 1, CAST(N'2021-07-19T15:06:59.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (312, 3, 1, CAST(N'2021-07-19T15:07:07.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (313, 3, 1, CAST(N'2021-07-19T15:07:10.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (314, 1, 1, CAST(N'2021-07-19T15:07:13.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (315, 2, 1, CAST(N'2021-07-19T15:07:17.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (316, 3, 1, CAST(N'2021-07-19T15:07:42.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (317, 3, 1, CAST(N'2021-07-19T15:07:48.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (318, 1, 1, CAST(N'2021-07-19T15:07:50.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (319, 1, 1, CAST(N'2021-07-19T15:07:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (320, 1, 1, CAST(N'2021-07-19T15:07:58.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (321, 2, 1, CAST(N'2021-07-19T15:08:03.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (322, 2, 1, CAST(N'2021-07-19T15:08:06.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (323, 2, 1, CAST(N'2021-07-19T15:08:08.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (324, 2, 1, CAST(N'2021-07-19T15:08:10.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (325, 3, 1, CAST(N'2021-07-19T15:08:14.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (326, 3, 1, CAST(N'2021-07-19T15:08:23.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (327, 1, 1, CAST(N'2021-07-21T11:26:44.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (328, 1, 15, CAST(N'2021-07-21T11:26:51.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (329, 2, 1, CAST(N'2021-07-21T11:26:55.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (330, 1, 15, CAST(N'2021-07-21T11:27:01.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (331, 1, 1, CAST(N'2021-07-21T11:35:11.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (332, 1, 1, CAST(N'2021-07-21T11:36:36.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (333, 1, 1, CAST(N'2021-07-21T11:36:42.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (334, 1, 1, CAST(N'2021-07-21T11:36:46.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (335, 3, 1, CAST(N'2021-07-21T11:36:50.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (336, 3, 1, CAST(N'2021-07-21T11:36:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (337, 1, 1, CAST(N'2021-07-21T18:45:45.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (338, 1, 15, CAST(N'2021-07-21T19:39:36.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (339, 1, 15, CAST(N'2021-07-21T19:39:42.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (340, 2, 1, CAST(N'2021-07-22T02:41:45.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (341, 1, 1, CAST(N'2021-07-27T22:48:41.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (342, 1, 1, CAST(N'2021-07-28T12:13:59.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (343, 1, 1, CAST(N'2021-07-29T01:23:53.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (344, 1, 1, CAST(N'2021-07-29T10:23:26.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (345, 1, 1, CAST(N'2021-07-29T11:20:40.000' AS DateTime), 0, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (346, 1, 1, CAST(N'2021-07-30T16:03:08.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (347, 1, 1, CAST(N'2021-08-02T18:35:41.000' AS DateTime), 1, N'192.168.0.101', N'biometric')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (348, 1, 1, CAST(N'2021-08-05T07:20:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (349, 1, 1, CAST(N'2021-08-05T21:20:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (350, 1, 1, CAST(N'2021-08-06T07:23:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (351, 1, 1, CAST(N'2021-08-06T23:23:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (352, 1, 1, CAST(N'2021-08-07T08:01:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (353, 1, 1, CAST(N'2021-08-07T16:44:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (354, 1, 1, CAST(N'2021-08-08T08:07:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (355, 1, 1, CAST(N'2021-08-08T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (356, 1, 1, CAST(N'2021-08-09T07:45:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (357, 1, 1, CAST(N'2021-08-09T16:44:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (358, 1, 1, CAST(N'2021-08-10T07:54:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (359, 1, 1, CAST(N'2021-08-10T16:34:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (360, 1, 1, CAST(N'2021-08-11T16:14:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (361, 1, 1, CAST(N'2021-08-11T07:51:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (362, 1, 1, CAST(N'2021-08-12T07:31:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (363, 1, 1, CAST(N'2021-08-12T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (364, 1, 1, CAST(N'2021-08-13T07:21:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (365, 1, 1, CAST(N'2021-08-13T16:43:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (366, 1, 1, CAST(N'2021-08-14T08:11:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (367, 1, 1, CAST(N'2021-08-14T16:42:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (368, 1, 1, CAST(N'2021-08-15T07:54:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (369, 1, 1, CAST(N'2021-08-15T16:31:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (370, 1, 1, CAST(N'2021-08-16T07:59:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (371, 1, 1, CAST(N'2021-08-16T16:32:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (372, 1, 1, CAST(N'2021-08-17T07:48:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (373, 1, 1, CAST(N'2021-08-17T16:12:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (374, 1, 1, CAST(N'2021-08-18T07:50:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (375, 1, 1, CAST(N'2021-08-18T16:15:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (376, 1, 1, CAST(N'2021-08-19T07:31:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (377, 1, 1, CAST(N'2021-08-20T07:41:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (378, 1, 1, CAST(N'2021-08-19T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (379, 1, 1, CAST(N'2021-08-20T16:52:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
GO
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (380, 1, 1, CAST(N'2021-08-21T07:46:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (381, 1, 1, CAST(N'2021-08-21T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (382, 1, 1, CAST(N'2021-08-22T07:39:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (383, 1, 1, CAST(N'2021-08-22T16:35:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (384, 1, 1, CAST(N'2021-08-23T07:51:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (385, 1, 1, CAST(N'2021-08-23T16:38:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (386, 1, 1, CAST(N'2021-08-24T07:41:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (387, 1, 1, CAST(N'2021-08-24T16:19:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (388, 1, 1, CAST(N'2021-08-25T07:49:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (389, 1, 1, CAST(N'2021-08-25T16:59:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (390, 1, 1, CAST(N'2021-08-26T07:40:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (391, 1, 1, CAST(N'2021-08-26T16:27:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (392, 1, 1, CAST(N'2021-08-27T07:51:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (393, 1, 1, CAST(N'2021-08-27T16:22:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (394, 1, 1, CAST(N'2021-08-28T07:31:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (395, 1, 1, CAST(N'2021-08-28T16:55:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (396, 1, 1, CAST(N'2021-08-29T07:51:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (397, 1, 1, CAST(N'2021-08-30T07:31:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (398, 1, 1, CAST(N'2021-08-29T16:11:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (399, 1, 1, CAST(N'2021-08-30T16:27:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (400, 120, 1, CAST(N'2021-08-08T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (401, 1, 1, CAST(N'2021-08-31T07:41:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (402, 1, 1, CAST(N'2021-08-31T16:57:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (403, 2, 1, CAST(N'2021-08-05T07:20:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (404, 2, 1, CAST(N'2021-08-05T21:20:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (405, 2, 1, CAST(N'2021-08-06T07:23:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (406, 2, 1, CAST(N'2021-08-06T23:23:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (407, 2, 1, CAST(N'2021-08-07T08:01:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (408, 2, 1, CAST(N'2021-08-07T16:44:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (409, 2, 1, CAST(N'2021-08-08T08:07:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (410, 2, 1, CAST(N'2021-08-08T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (411, 2, 1, CAST(N'2021-08-09T07:45:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (412, 2, 1, CAST(N'2021-08-09T16:44:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (413, 2, 1, CAST(N'2021-08-10T07:54:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (414, 2, 1, CAST(N'2021-08-10T16:34:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (415, 2, 1, CAST(N'2021-08-11T07:51:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (416, 2, 1, CAST(N'2021-08-11T16:14:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (417, 2, 1, CAST(N'2021-08-12T07:31:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (418, 2, 1, CAST(N'2021-08-12T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (419, 2, 1, CAST(N'2021-08-13T07:21:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (420, 2, 1, CAST(N'2021-08-13T16:43:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (421, 120, 1, CAST(N'2021-08-05T07:20:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (422, 120, 1, CAST(N'2021-08-05T21:20:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (423, 120, 1, CAST(N'2021-08-06T07:23:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (424, 120, 1, CAST(N'2021-08-06T23:23:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (425, 120, 1, CAST(N'2021-08-07T08:01:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (426, 120, 1, CAST(N'2021-08-07T16:44:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (427, 120, 1, CAST(N'2021-08-08T08:07:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (428, 120, 1, CAST(N'2021-08-09T07:45:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (429, 120, 1, CAST(N'2021-08-09T16:44:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (430, 120, 1, CAST(N'2021-08-10T07:54:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (431, 120, 1, CAST(N'2021-08-10T16:34:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (432, 120, 1, CAST(N'2021-08-11T07:51:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (433, 120, 1, CAST(N'2021-08-11T16:14:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (434, 120, 1, CAST(N'2021-08-12T07:31:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (435, 120, 1, CAST(N'2021-08-12T16:24:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (436, 120, 1, CAST(N'2021-08-13T07:21:00.000' AS DateTime), 0, N'192.168.1.1', N'csv')
INSERT [dbo].[biometric_logs] ([id], [userId], [state], [date], [status], [ip_address], [source]) VALUES (437, 120, 1, CAST(N'2021-08-13T16:43:00.000' AS DateTime), 1, N'192.168.1.1', N'csv')
SET IDENTITY_INSERT [dbo].[biometric_logs] OFF
GO
SET IDENTITY_INSERT [dbo].[biometric_number] ON 

INSERT [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (1, 2, 1, 2011, CAST(N'2021-07-07T22:53:38.253' AS DateTime), CAST(N'2021-07-07T22:53:38.253' AS DateTime))
INSERT [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (2, 1, 1, 2078, CAST(N'2021-07-14T17:02:05.117' AS DateTime), CAST(N'2021-07-14T17:02:05.117' AS DateTime))
INSERT [dbo].[biometric_number] ([id], [user_id], [biometric_id], [biometric_number], [created_at], [updated_at]) VALUES (3, 120, 1, 2028, CAST(N'2021-08-03T14:28:58.427' AS DateTime), CAST(N'2021-08-03T14:28:58.427' AS DateTime))
SET IDENTITY_INSERT [dbo].[biometric_number] OFF
GO
SET IDENTITY_INSERT [dbo].[biometrics] ON 

INSERT [dbo].[biometrics] ([id], [site], [status], [created_at], [updated_at]) VALUES (1, N'192.168.1.1', 1, CAST(N'2021-05-17T13:14:12.000' AS DateTime), CAST(N'2021-05-17T13:14:12.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[biometrics] OFF
GO
SET IDENTITY_INSERT [dbo].[branches] ON 

INSERT [dbo].[branches] ([id], [location], [address], [country_id], [company_id], [description], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (1, N'Makati City', N'Ayala Avenue', 177, 1, NULL, 1, NULL, NULL, CAST(N'2019-03-24T07:09:18.000' AS DateTime), CAST(N'2019-09-26T03:05:50.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[branches] OFF
GO
SET IDENTITY_INSERT [dbo].[branding] ON 

INSERT [dbo].[branding] ([id], [name], [logo], [branding]) VALUES (4, N'HRIS', N'0e616b2a-d591-4052-a0dc-4f45bfa9ff0f.png', 3)
SET IDENTITY_INSERT [dbo].[branding] OFF
GO
SET IDENTITY_INSERT [dbo].[business_trip] ON 

INSERT [dbo].[business_trip] ([id], [user_id], [date_start], [date_end], [title], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [approved_by], [_token], [created_at], [updated_at]) VALUES (1, 1, CAST(N'2019-10-08' AS Date), CAST(N'2019-10-09' AS Date), NULL, N'Trips', 2, 2, 1, 1, NULL, NULL, N'', CAST(N'2019-10-03T18:03:02.000' AS DateTime), CAST(N'2019-10-08T11:42:15.000' AS DateTime))
INSERT [dbo].[business_trip] ([id], [user_id], [date_start], [date_end], [title], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [approved_by], [_token], [created_at], [updated_at]) VALUES (2, 2, CAST(N'2019-10-15' AS Date), CAST(N'2019-10-16' AS Date), NULL, N'Go to Cebu project', 2, 2, 1, 1, NULL, NULL, N'', CAST(N'2019-10-08T10:59:27.000' AS DateTime), CAST(N'2019-10-08T11:42:15.000' AS DateTime))
INSERT [dbo].[business_trip] ([id], [user_id], [date_start], [date_end], [title], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [approved_by], [_token], [created_at], [updated_at]) VALUES (3, 1, CAST(N'2021-03-10' AS Date), CAST(N'2021-03-12' AS Date), NULL, N'Test', 2, 2, 1, 1, NULL, NULL, N'', CAST(N'2021-03-01T12:39:12.000' AS DateTime), CAST(N'2021-03-01T12:39:26.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[business_trip] OFF
GO
SET IDENTITY_INSERT [dbo].[companies] ON 

INSERT [dbo].[companies] ([id], [name], [code], [logo], [description], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (1, N'Bookbit', N'BB', N'314782c7-60ff-410e-94bd-a3001208b28e.png', N'', 1, 1, 2, CAST(N'2019-03-23T01:47:46.000' AS DateTime), CAST(N'2021-06-01T23:05:14.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[companies] OFF
GO
SET IDENTITY_INSERT [dbo].[configuration] ON 

INSERT [dbo].[configuration] ([id], [json], [created_at], [updated_at]) VALUES (1, N'{"server":{"timezone":"undefined"},"shift":{"grace_period":"10"},"overtime":{"overtime_regular":"undefined","overtime_restday":"undefined","overtime_regular_holiday":"undefined","overtime_restday_special_holiday":"undefined","overtime_restday_regular_holiday":"undefined"},"smtp":{"smtp_host":"undefined","smtp_port":"undefined","smtp_username":"undefined","smtp_password":"undefined","smtp_service":"undefined"},"cutoff":{"A_from":"21","A_to":"5","A_day":"15","B_from":"6","B_to":"20","B_day":"30"},"contribution":{"sss":"A","philhealth":"B","pagibig":"B"},"manual_log":"yes","policy":{"nolog":"1"}}', CAST(N'2019-07-13T04:29:31.000' AS DateTime), CAST(N'2019-09-20T03:45:32.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[configuration] OFF
GO
SET IDENTITY_INSERT [dbo].[countries] ON 

INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (1, N'ABW', N'Aruba', N'AW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (2, N'AFG', N'Afghanistan', N'AF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (3, N'AGO', N'Angola', N'AO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (4, N'AIA', N'Anguilla', N'AI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (5, N'ALA', N'Åland', N'AX')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (6, N'ALB', N'Albania', N'AL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (7, N'AND', N'Andorra', N'AD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (8, N'ARE', N'United Arab Emirates', N'AE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (9, N'ARG', N'Argentina', N'AR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (10, N'ARM', N'Armenia', N'AM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (11, N'ASM', N'American Samoa', N'AS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (12, N'ATA', N'Antarctica', N'AQ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (13, N'ATF', N'French Southern Territories', N'TF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (14, N'ATG', N'Antigua and Barbuda', N'AG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (15, N'AUS', N'Australia', N'AU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (16, N'AUT', N'Austria', N'AT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (17, N'AZE', N'Azerbaijan', N'AZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (18, N'BDI', N'Burundi', N'BI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (19, N'BEL', N'Belgium', N'BE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (20, N'BEN', N'Benin', N'BJ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (21, N'BES', N'Bonaire', N'BQ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (22, N'BFA', N'Burkina Faso', N'BF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (23, N'BGD', N'Bangladesh', N'BD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (24, N'BGR', N'Bulgaria', N'BG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (25, N'BHR', N'Bahrain', N'BH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (26, N'BHS', N'Bahamas', N'BS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (27, N'BIH', N'Bosnia and Herzegovina', N'BA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (28, N'BLM', N'Saint Barthélemy', N'BL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (29, N'BLR', N'Belarus', N'BY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (30, N'BLZ', N'Belize', N'BZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (31, N'BMU', N'Bermuda', N'BM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (32, N'BOL', N'Bolivia', N'BO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (33, N'BRA', N'Brazil', N'BR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (34, N'BRB', N'Barbados', N'BB')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (35, N'BRN', N'Brunei', N'BN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (36, N'BTN', N'Bhutan', N'BT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (37, N'BVT', N'Bouvet Island', N'BV')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (38, N'BWA', N'Botswana', N'BW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (39, N'CAF', N'Central African Republic', N'CF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (40, N'CAN', N'Canada', N'CA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (41, N'CCK', N'Cocos [Keeling] Islands', N'CC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (42, N'CHE', N'Switzerland', N'CH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (43, N'CHL', N'Chile', N'CL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (44, N'CHN', N'China', N'CN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (45, N'CIV', N'Ivory Coast', N'CI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (46, N'CMR', N'Cameroon', N'CM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (47, N'COD', N'Democratic Republic of the Congo', N'CD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (48, N'COG', N'Republic of the Congo', N'CG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (49, N'COK', N'Cook Islands', N'CK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (50, N'COL', N'Colombia', N'CO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (51, N'COM', N'Comoros', N'KM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (52, N'CPV', N'Cape Verde', N'CV')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (53, N'CRI', N'Costa Rica', N'CR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (54, N'CUB', N'Cuba', N'CU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (55, N'CUW', N'Curacao', N'CW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (56, N'CXR', N'Christmas Island', N'CX')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (57, N'CYM', N'Cayman Islands', N'KY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (58, N'CYP', N'Cyprus', N'CY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (59, N'CZE', N'Czech Republic', N'CZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (60, N'DEU', N'Germany', N'DE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (61, N'DJI', N'Djibouti', N'DJ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (62, N'DMA', N'Dominica', N'DM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (63, N'DNK', N'Denmark', N'DK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (64, N'DOM', N'Dominican Republic', N'DO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (65, N'DZA', N'Algeria', N'DZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (66, N'ECU', N'Ecuador', N'EC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (67, N'EGY', N'Egypt', N'EG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (68, N'ERI', N'Eritrea', N'ER')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (69, N'ESH', N'Western Sahara', N'EH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (70, N'ESP', N'Spain', N'ES')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (71, N'EST', N'Estonia', N'EE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (72, N'ETH', N'Ethiopia', N'ET')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (73, N'FIN', N'Finland', N'FI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (74, N'FJI', N'Fiji', N'FJ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (75, N'FLK', N'Falkland Islands', N'FK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (76, N'FRA', N'France', N'FR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (77, N'FRO', N'Faroe Islands', N'FO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (78, N'FSM', N'Micronesia', N'FM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (79, N'GAB', N'Gabon', N'GA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (80, N'GBR', N'United Kingdom', N'GB')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (81, N'GEO', N'Georgia', N'GE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (82, N'GGY', N'Guernsey', N'GG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (83, N'GHA', N'Ghana', N'GH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (84, N'GIB', N'Gibraltar', N'GI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (85, N'GIN', N'Guinea', N'GN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (86, N'GLP', N'Guadeloupe', N'GP')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (87, N'GMB', N'Gambia', N'GM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (88, N'GNB', N'Guinea-Bissau', N'GW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (89, N'GNQ', N'Equatorial Guinea', N'GQ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (90, N'GRC', N'Greece', N'GR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (91, N'GRD', N'Grenada', N'GD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (92, N'GRL', N'Greenland', N'GL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (93, N'GTM', N'Guatemala', N'GT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (94, N'GUF', N'French Guiana', N'GF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (95, N'GUM', N'Guam', N'GU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (96, N'GUY', N'Guyana', N'GY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (97, N'HKG', N'Hong Kong', N'HK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (98, N'HMD', N'Heard Island and McDonald Islands', N'HM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (99, N'HND', N'Honduras', N'HN')
GO
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (100, N'HRV', N'Croatia', N'HR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (101, N'HTI', N'Haiti', N'HT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (102, N'HUN', N'Hungary', N'HU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (103, N'IDN', N'Indonesia', N'ID')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (104, N'IMN', N'Isle of Man', N'IM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (105, N'IND', N'India', N'IN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (106, N'IOT', N'British Indian Ocean Territory', N'IO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (107, N'IRL', N'Ireland', N'IE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (108, N'IRN', N'Iran', N'IR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (109, N'IRQ', N'Iraq', N'IQ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (110, N'ISL', N'Iceland', N'IS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (111, N'ISR', N'Israel', N'IL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (112, N'ITA', N'Italy', N'IT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (113, N'JAM', N'Jamaica', N'JM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (114, N'JEY', N'Jersey', N'JE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (115, N'JOR', N'Jordan', N'JO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (116, N'JPN', N'Japan', N'JP')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (117, N'KAZ', N'Kazakhstan', N'KZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (118, N'KEN', N'Kenya', N'KE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (119, N'KGZ', N'Kyrgyzstan', N'KG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (120, N'KHM', N'Cambodia', N'KH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (121, N'KIR', N'Kiribati', N'KI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (122, N'KNA', N'Saint Kitts and Nevis', N'KN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (123, N'KOR', N'South Korea', N'KR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (124, N'KWT', N'Kuwait', N'KW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (125, N'LAO', N'Laos', N'LA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (126, N'LBN', N'Lebanon', N'LB')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (127, N'LBR', N'Liberia', N'LR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (128, N'LBY', N'Libya', N'LY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (129, N'LCA', N'Saint Lucia', N'LC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (130, N'LIE', N'Liechtenstein', N'LI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (131, N'LKA', N'Sri Lanka', N'LK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (132, N'LSO', N'Lesotho', N'LS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (133, N'LTU', N'Lithuania', N'LT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (134, N'LUX', N'Luxembourg', N'LU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (135, N'LVA', N'Latvia', N'LV')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (136, N'MAC', N'Macao', N'MO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (137, N'MAF', N'Saint Martin', N'MF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (138, N'MAR', N'Morocco', N'MA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (139, N'MCO', N'Monaco', N'MC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (140, N'MDA', N'Moldova', N'MD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (141, N'MDG', N'Madagascar', N'MG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (142, N'MDV', N'Maldives', N'MV')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (143, N'MEX', N'Mexico', N'MX')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (144, N'MHL', N'Marshall Islands', N'MH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (145, N'MKD', N'Macedonia', N'MK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (146, N'MLI', N'Mali', N'ML')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (147, N'MLT', N'Malta', N'MT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (148, N'MMR', N'Myanmar [Burma]', N'MM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (149, N'MNE', N'Montenegro', N'ME')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (150, N'MNG', N'Mongolia', N'MN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (151, N'MNP', N'Northern Mariana Islands', N'MP')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (152, N'MOZ', N'Mozambique', N'MZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (153, N'MRT', N'Mauritania', N'MR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (154, N'MSR', N'Montserrat', N'MS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (155, N'MTQ', N'Martinique', N'MQ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (156, N'MUS', N'Mauritius', N'MU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (157, N'MWI', N'Malawi', N'MW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (158, N'MYS', N'Malaysia', N'MY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (159, N'MYT', N'Mayotte', N'YT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (160, N'NAM', N'Namibia', N'NA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (161, N'NCL', N'New Caledonia', N'NC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (162, N'NER', N'Niger', N'NE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (163, N'NFK', N'Norfolk Island', N'NF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (164, N'NGA', N'Nigeria', N'NG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (165, N'NIC', N'Nicaragua', N'NI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (166, N'NIU', N'Niue', N'NU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (167, N'NLD', N'Netherlands', N'NL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (168, N'NOR', N'Norway', N'NO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (169, N'NPL', N'Nepal', N'NP')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (170, N'NRU', N'Nauru', N'NR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (171, N'NZL', N'New Zealand', N'NZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (172, N'OMN', N'Oman', N'OM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (173, N'PAK', N'Pakistan', N'PK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (174, N'PAN', N'Panama', N'PA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (175, N'PCN', N'Pitcairn Islands', N'PN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (176, N'PER', N'Peru', N'PE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (177, N'PHL', N'Philippines', N'PH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (178, N'PLW', N'Palau', N'PW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (179, N'PNG', N'Papua New Guinea', N'PG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (180, N'POL', N'Poland', N'PL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (181, N'PRI', N'Puerto Rico', N'PR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (182, N'PRK', N'North Korea', N'KP')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (183, N'PRT', N'Portugal', N'PT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (184, N'PRY', N'Paraguay', N'PY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (185, N'PSE', N'Palestine', N'PS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (186, N'PYF', N'French Polynesia', N'PF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (187, N'QAT', N'Qatar', N'QA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (188, N'REU', N'Réunion', N'RE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (189, N'ROU', N'Romania', N'RO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (190, N'RUS', N'Russia', N'RU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (191, N'RWA', N'Rwanda', N'RW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (192, N'SAU', N'Saudi Arabia', N'SA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (193, N'SDN', N'Sudan', N'SD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (194, N'SEN', N'Senegal', N'SN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (195, N'SGP', N'Singapore', N'SG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (196, N'SGS', N'South Georgia and the South Sandwich Islands', N'GS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (197, N'SHN', N'Saint Helena', N'SH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (198, N'SJM', N'Svalbard and Jan Mayen', N'SJ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (199, N'SLB', N'Solomon Islands', N'SB')
GO
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (200, N'SLE', N'Sierra Leone', N'SL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (201, N'SLV', N'El Salvador', N'SV')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (202, N'SMR', N'San Marino', N'SM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (203, N'SOM', N'Somalia', N'SO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (204, N'SPM', N'Saint Pierre and Miquelon', N'PM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (205, N'SRB', N'Serbia', N'RS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (206, N'SSD', N'South Sudan', N'SS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (207, N'STP', N'São Tomé and Príncipe', N'ST')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (208, N'SUR', N'Suriname', N'SR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (209, N'SVK', N'Slovakia', N'SK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (210, N'SVN', N'Slovenia', N'SI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (211, N'SWE', N'Sweden', N'SE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (212, N'SWZ', N'Swaziland', N'SZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (213, N'SXM', N'Sint Maarten', N'SX')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (214, N'SYC', N'Seychelles', N'SC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (215, N'SYR', N'Syria', N'SY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (216, N'TCA', N'Turks and Caicos Islands', N'TC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (217, N'TCD', N'Chad', N'TD')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (218, N'TGO', N'Togo', N'TG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (219, N'THA', N'Thailand', N'TH')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (220, N'TJK', N'Tajikistan', N'TJ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (221, N'TKL', N'Tokelau', N'TK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (222, N'TKM', N'Turkmenistan', N'TM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (223, N'TLS', N'East Timor', N'TL')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (224, N'TON', N'Tonga', N'TO')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (225, N'TTO', N'Trinidad and Tobago', N'TT')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (226, N'TUN', N'Tunisia', N'TN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (227, N'TUR', N'Turkey', N'TR')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (228, N'TUV', N'Tuvalu', N'TV')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (229, N'TWN', N'Taiwan', N'TW')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (230, N'TZA', N'Tanzania', N'TZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (231, N'UGA', N'Uganda', N'UG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (232, N'UKR', N'Ukraine', N'UA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (233, N'UMI', N'U.S. Minor Outlying Islands', N'UM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (234, N'URY', N'Uruguay', N'UY')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (235, N'USA', N'United States', N'US')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (236, N'UZB', N'Uzbekistan', N'UZ')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (237, N'VAT', N'Vatican City', N'VA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (238, N'VCT', N'Saint Vincent and the Grenadines', N'VC')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (239, N'VEN', N'Venezuela', N'VE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (240, N'VGB', N'British Virgin Islands', N'VG')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (241, N'VIR', N'U.S. Virgin Islands', N'VI')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (242, N'VNM', N'Vietnam', N'VN')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (243, N'VUT', N'Vanuatu', N'VU')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (244, N'WLF', N'Wallis and Futuna', N'WF')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (245, N'WSM', N'Samoa', N'WS')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (246, N'XKX', N'Kosovo', N'XK')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (247, N'YEM', N'Yemen', N'YE')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (248, N'ZAF', N'South Africa', N'ZA')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (249, N'ZMB', N'Zambia', N'ZM')
INSERT [dbo].[countries] ([id], [iso], [name], [code]) VALUES (250, N'ZWE', N'Zimbabwe', N'ZW')
SET IDENTITY_INSERT [dbo].[countries] OFF
GO
SET IDENTITY_INSERT [dbo].[crm_chase] ON 

INSERT [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (1, N'Materialize', N'Bacoor, Cavite', 2, 52000, N'0', 1, NULL, CAST(N'2019-09-25T22:01:16.000' AS DateTime), CAST(N'2019-09-25T22:01:16.000' AS DateTime))
INSERT [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (2, N'Dropdown', N'Ayala Ave., Makati City', 3, 63000, N'0', 1, NULL, CAST(N'2019-09-25T22:03:16.000' AS DateTime), CAST(N'2019-09-25T22:03:16.000' AS DateTime))
INSERT [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (3, N'JavaScript', N'Ortigas, Pasig City', 1, 27800, N'0', 1, NULL, CAST(N'2019-09-25T22:04:02.000' AS DateTime), CAST(N'2019-09-25T22:04:02.000' AS DateTime))
INSERT [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (4, N'Methods', N'Cubao, Quezon City', 2, 105750, N'0', 1, NULL, CAST(N'2019-09-25T22:04:55.000' AS DateTime), CAST(N'2019-09-25T22:04:55.000' AS DateTime))
INSERT [dbo].[crm_chase] ([id], [account], [project_site], [type], [revenue], [sales], [created_by], [updated_by], [created_at], [updated_at]) VALUES (5, N'Events', N'Fairview, Quezon City', 2, 47000, N'All', 1, NULL, CAST(N'2019-09-25T22:41:50.000' AS DateTime), CAST(N'2019-09-25T22:41:50.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[crm_chase] OFF
GO
SET IDENTITY_INSERT [dbo].[custom_approver] ON 

INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (1, 2, 1, 1)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (2, 90, 11, 11)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (3, 18, 11, 11)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (4, 10, 11, 11)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (5, 35, 11, 11)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (6, 9, 8, 8)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (7, 6, 8, 8)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (8, 49, 8, 6)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (9, 25, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (10, 16, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (11, 31, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (12, 30, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (13, 32, 11, 90)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (14, 28, 8, 8)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (15, 22, 8, 8)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (16, 15, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (17, 54, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (18, 24, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (19, 50, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (20, 51, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (21, 63, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (22, 64, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (23, 67, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (24, 71, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (25, 74, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (26, 88, 9, 9)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (27, 94, 24, 24)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (28, 108, 54, 54)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (29, 98, 67, 67)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (30, 104, 67, 67)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (31, 105, 51, 51)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (32, 106, 51, 51)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (33, 1, 1, 1)
INSERT [dbo].[custom_approver] ([id], [user_id], [primary_approver_id], [backup_approver_id]) VALUES (34, 123, 121, 120)
SET IDENTITY_INSERT [dbo].[custom_approver] OFF
GO
SET IDENTITY_INSERT [dbo].[departments] ON 

INSERT [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (1, 7, N'Human Resources', N'HR', 2, 2, 2, N'test', 1, NULL, CAST(N'2021-06-14T17:31:37.000' AS DateTime), CAST(N'2021-06-14T20:15:52.000' AS DateTime))
INSERT [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (2, 2, N'Information Technology', N'IT', 2, 2, 1, N'I.T.s', 1, NULL, CAST(N'2021-06-14T17:32:41.000' AS DateTime), CAST(N'2021-06-14T20:15:48.000' AS DateTime))
INSERT [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (5, 2, N'Network', N'NTWRK', 2, 2, 2, N'', 1, NULL, CAST(N'2021-06-14T19:23:25.000' AS DateTime), CAST(N'2021-06-14T19:23:25.000' AS DateTime))
INSERT [dbo].[departments] ([id], [division_id], [department_name], [department_code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (6, 3, N'Accounting', N'ACNTNG', 1, 1, 1, N'', 1, NULL, CAST(N'2021-06-14T19:23:25.000' AS DateTime), CAST(N'2021-06-14T19:23:25.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[departments] OFF
GO
SET IDENTITY_INSERT [dbo].[dispute] ON 

INSERT [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (1, 1, NULL, NULL, NULL, 4, CAST(N'2019-10-01' AS Date), 2, N'Not acounted', 2, 2, 1, 1, 1, N'', NULL, CAST(N'2019-10-03T18:03:53.000' AS DateTime), CAST(N'2019-10-08T11:42:29.000' AS DateTime))
INSERT [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (2, 2, NULL, NULL, NULL, 2, CAST(N'2019-10-01' AS Date), 2, N'Overtime not applied', 2, 2, 1, 1, 1, N'', NULL, CAST(N'2019-10-08T11:01:40.000' AS DateTime), CAST(N'2019-10-08T11:42:29.000' AS DateTime))
INSERT [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (3, 2, NULL, NULL, NULL, 7, CAST(N'2019-10-06' AS Date), 1, N'Work at site', 2, 2, 1, 1, 1, N'', NULL, CAST(N'2019-10-08T11:02:29.000' AS DateTime), CAST(N'2019-10-08T11:42:29.000' AS DateTime))
INSERT [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (4, 2, NULL, NULL, NULL, 8, CAST(N'2019-10-02' AS Date), 3, N'Leave not applied', 2, 2, 1, 1, 1, N'', NULL, CAST(N'2019-10-08T11:04:22.000' AS DateTime), CAST(N'2019-10-08T11:42:29.000' AS DateTime))
INSERT [dbo].[dispute] ([id], [user_id], [year], [month], [period], [hour], [date], [type], [note], [primary_status], [backup_status], [primary_approver], [backup_approver], [admin_status], [_token], [document], [created_at], [updated_at]) VALUES (5, 2, NULL, NULL, NULL, 5, CAST(N'2019-10-04' AS Date), 4, N'Forgot to log', 2, 2, 1, 1, 1, N'', NULL, CAST(N'2019-10-08T11:06:53.000' AS DateTime), CAST(N'2019-10-08T11:42:29.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[dispute] OFF
GO
SET IDENTITY_INSERT [dbo].[divisions] ON 

INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (1, 1, N'Lorem ipsum', N'LRM', 2, 0, 2, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 1, NULL, CAST(N'2021-06-11T12:35:21.000' AS DateTime), CAST(N'2021-06-17T17:26:45.000' AS DateTime))
INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (2, 1, N'Duis aute', N'DU', 2, 2, 2, N'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 1, NULL, CAST(N'2021-06-11T12:56:57.000' AS DateTime), CAST(N'2021-06-14T17:37:02.000' AS DateTime))
INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (3, 1, N'Nemo enim', N'NMO', 2, 0, 2, N'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.', 1, NULL, CAST(N'2021-06-11T13:17:25.000' AS DateTime), CAST(N'2021-06-11T13:21:49.000' AS DateTime))
INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (4, 1, N'Neque porro ', N'NE', 1, 0, 1, N'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet.', 1, NULL, CAST(N'2021-06-11T13:22:18.000' AS DateTime), CAST(N'2021-06-14T17:37:03.000' AS DateTime))
INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (7, 1, N'Nam libero', N'NL', 2, 2, 2, N'Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus', 1, NULL, CAST(N'2021-06-14T19:24:01.000' AS DateTime), CAST(N'2021-06-14T19:24:01.000' AS DateTime))
INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (8, 1, N'At vero eos', N'AT', 2, 2, 2, N'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident', 1, NULL, CAST(N'2021-06-14T19:24:01.000' AS DateTime), CAST(N'2021-06-14T19:24:01.000' AS DateTime))
INSERT [dbo].[divisions] ([id], [company_id], [name], [code], [manager_id], [assistant_manager_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (9, 1, N'IT', N'IT', 2, 2, 2, N'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident', 1, NULL, CAST(N'2021-07-08T13:23:42.973' AS DateTime), CAST(N'2021-07-08T13:23:42.973' AS DateTime))
SET IDENTITY_INSERT [dbo].[divisions] OFF
GO
SET IDENTITY_INSERT [dbo].[employee_type] ON 

INSERT [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'Regular', CAST(N'2021-06-18T15:38:15.000' AS DateTime), NULL)
INSERT [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'Probationary', CAST(N'2021-06-18T15:38:31.000' AS DateTime), NULL)
INSERT [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'Project Based', CAST(N'2021-06-18T15:38:31.000' AS DateTime), NULL)
INSERT [dbo].[employee_type] ([id], [name], [createdAt], [updatedAt]) VALUES (4, N'Casual', CAST(N'2021-06-18T15:38:31.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[employee_type] OFF
GO
SET IDENTITY_INSERT [dbo].[employments] ON 

INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (8, 1, NULL, 1, NULL, 2, 2, 3, 14, 3, 1, N'section', 4, 1, 0, CAST(N'2021-06-17' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-06-21T23:02:13.000' AS DateTime), CAST(N'2021-06-17T21:02:31.000' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (9, 123, NULL, 1, NULL, 2, 2, 3, 27, 1, 1, N'division', 4, 1, 0, CAST(N'2021-06-22' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-06-22T20:50:18.000' AS DateTime), CAST(N'2021-06-22T20:50:18.000' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (10, 2, NULL, 1, NULL, 2, 2, 3, 27, 3, 1, N'division', 4, 1, NULL, CAST(N'2021-07-07' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-07-07T22:59:38.570' AS DateTime), CAST(N'2021-07-07T22:59:38.570' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (11, 122, NULL, 1, NULL, 7, 1, 1, 14, 3, 1, N'division', 4, 1, NULL, CAST(N'2021-07-07' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-07-07T23:00:44.153' AS DateTime), CAST(N'2021-07-07T23:00:44.153' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (12, 1, NULL, 1, NULL, 2, 2, 3, 328, 1, 7, N'department', 2, 1, NULL, CAST(N'2021-07-08' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-07-08T13:29:37.030' AS DateTime), CAST(N'2021-07-08T13:29:37.030' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (13, 120, NULL, 1, NULL, 2, 2, 3, 54, 2, 12, N'division', 1, 1, NULL, CAST(N'2021-08-03' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-08-03T14:59:17.413' AS DateTime), CAST(N'2021-08-03T14:59:17.413' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (14, 119, NULL, 1, NULL, 2, 2, 3, 276, 1, 2, N'department', 4, 1, NULL, CAST(N'2021-08-17' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-08-17T17:25:04.630' AS DateTime), CAST(N'2021-08-17T17:25:04.630' AS DateTime))
INSERT [dbo].[employments] ([id], [user_id], [employee_number], [company_id], [company_branch_id], [division_id], [department_id], [section_id], [position_id], [position_classification_id], [position_category_id], [approving_organization], [work_area_id], [branch_id], [job_title_id], [date_entry], [date_exit], [comment], [status], [team_id], [created_by], [updated_by], [created_at], [updated_at]) VALUES (15, 121, NULL, 1, NULL, 2, 2, 3, 189, 2, 2, N'section', 1, 1, NULL, CAST(N'2021-08-17' AS Date), NULL, NULL, 1, NULL, 0, 0, CAST(N'2021-08-17T17:25:37.263' AS DateTime), CAST(N'2021-08-17T17:25:37.263' AS DateTime))
SET IDENTITY_INSERT [dbo].[employments] OFF
GO
SET IDENTITY_INSERT [dbo].[events] ON 

INSERT [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (4, 1, CAST(N'2021-02-15T08:00:00.0000000' AS DateTime2), CAST(N'2021-02-17T08:00:00.0000000' AS DateTime2), N'Out of Office Meeting / Sourcing', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', CAST(N'2021-02-15T20:05:39.000' AS DateTime), CAST(N'2021-02-15T20:05:39.000' AS DateTime))
INSERT [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (5, 1, CAST(N'2021-02-17T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-17T00:00:00.0000000' AS DateTime2), N'Office Work', NULL, CAST(N'2021-02-15T20:42:57.000' AS DateTime), CAST(N'2021-02-15T20:42:57.000' AS DateTime))
INSERT [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (6, 1, CAST(N'2021-02-17T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-17T00:00:00.0000000' AS DateTime2), N'Shop / Warehouse Visit', NULL, CAST(N'2021-02-15T20:43:08.000' AS DateTime), CAST(N'2021-02-15T20:43:08.000' AS DateTime))
INSERT [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (7, 1, CAST(N'2021-02-28T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-28T00:00:00.0000000' AS DateTime2), N'Jobsite', N'Test', CAST(N'2021-02-16T13:11:53.000' AS DateTime), CAST(N'2021-02-16T13:11:53.000' AS DateTime))
INSERT [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (8, 1, CAST(N'2021-03-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-03-02T00:00:00.0000000' AS DateTime2), N'Office', NULL, CAST(N'2021-02-17T13:55:07.000' AS DateTime), CAST(N'2021-02-17T13:55:07.000' AS DateTime))
INSERT [dbo].[events] ([id], [user_id], [date], [end_date], [type], [comment], [created_at], [updated_at]) VALUES (9, 1, CAST(N'2021-03-17T00:00:00.0000000' AS DateTime2), CAST(N'2021-03-17T00:00:00.0000000' AS DateTime2), N'Shop/Warehouse', NULL, CAST(N'2021-03-04T20:50:16.000' AS DateTime), CAST(N'2021-03-04T20:50:16.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[events] OFF
GO
SET IDENTITY_INSERT [dbo].[holidays] ON 

INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (1, 177, 1, CAST(N'2019-08-26' AS Date), N'National Heroes'' Day', 1, 1, NULL, CAST(N'2019-10-01T11:58:18.000' AS DateTime), CAST(N'2021-06-11T00:36:10.000' AS DateTime), 1, 1)
INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (2, 177, 1, CAST(N'2019-11-30' AS Date), N'Bonifacio Day', 1, 1, NULL, CAST(N'2019-10-01T12:01:07.000' AS DateTime), CAST(N'2021-06-11T00:36:04.000' AS DateTime), 1, 1)
INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (3, 177, 1, CAST(N'2019-12-25' AS Date), N'Christmas Day', 1, 1, NULL, CAST(N'2019-10-01T12:01:31.000' AS DateTime), CAST(N'2021-06-11T00:35:57.000' AS DateTime), 1, 1)
INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (4, 177, 4, CAST(N'2019-12-30' AS Date), N'Rizal Day', 1, 1, NULL, CAST(N'2019-10-01T12:01:56.000' AS DateTime), CAST(N'2021-06-11T00:35:48.000' AS DateTime), 1, 1)
INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (5, 177, 4, CAST(N'2021-02-12' AS Date), N'Chinese New Year', 1, 1, NULL, CAST(N'2021-02-11T12:50:32.000' AS DateTime), CAST(N'2021-06-11T00:35:40.000' AS DateTime), 1, 1)
INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (6, NULL, 1, CAST(N'2021-06-24' AS Date), N'Test Holiday', 1, 1, NULL, CAST(N'2021-06-11T00:28:11.000' AS DateTime), CAST(N'2021-06-11T00:28:11.000' AS DateTime), 1, 0)
INSERT [dbo].[holidays] ([id], [country_id], [location_id], [date], [title], [type], [status], [note], [created_at], [updated_at], [created_by], [updated_by]) VALUES (7, NULL, 1, CAST(N'2021-06-24' AS Date), N'test', 1, 1, N'test', CAST(N'2021-08-11T20:58:45.630' AS DateTime), CAST(N'2021-08-11T20:58:45.630' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[holidays] OFF
GO
SET IDENTITY_INSERT [dbo].[incentive] ON 

INSERT [dbo].[incentive] ([id], [user_id], [from], [to], [amount], [label], [mode], [status], [period], [taxable], [created_at], [updated_at]) VALUES (1, 2, CAST(N'2019-11-19' AS Date), NULL, 3000, N'Rice Allowance', 2, 1, 2, 0, CAST(N'2019-11-19T11:30:19.000' AS DateTime), CAST(N'2019-11-19T11:30:19.000' AS DateTime))
INSERT [dbo].[incentive] ([id], [user_id], [from], [to], [amount], [label], [mode], [status], [period], [taxable], [created_at], [updated_at]) VALUES (68, 1, CAST(N'2021-01-01' AS Date), NULL, 3500, N'Transfortation', 2, 1, 2, 0, CAST(N'2021-02-03T17:15:40.000' AS DateTime), CAST(N'2021-02-03T17:15:40.000' AS DateTime))
INSERT [dbo].[incentive] ([id], [user_id], [from], [to], [amount], [label], [mode], [status], [period], [taxable], [created_at], [updated_at]) VALUES (69, 1, CAST(N'2021-01-01' AS Date), NULL, 4500, N'Rice Allowance', 2, 1, 2, 0, CAST(N'2021-02-03T17:16:53.000' AS DateTime), CAST(N'2021-02-03T17:16:53.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[incentive] OFF
GO
SET IDENTITY_INSERT [dbo].[leave_credit_policy] ON 

INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (1, 1, 1, 199, 16, NULL, CAST(N'2019-10-03T17:55:44.000' AS DateTime), CAST(N'2021-02-10T22:54:48.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (2, 1, 3, 0, 10, NULL, CAST(N'2019-10-03T17:55:44.000' AS DateTime), CAST(N'2021-02-10T22:54:48.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (3, 1, 4, 0, 0, NULL, CAST(N'2019-10-03T17:55:44.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (4, 1, 5, 2, 3, NULL, CAST(N'2019-10-03T17:55:44.000' AS DateTime), CAST(N'2020-03-02T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (5, 2, 1, 216, 0, NULL, CAST(N'2019-10-05T15:22:17.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (6, 2, 3, 10, 0, NULL, CAST(N'2019-10-05T15:22:17.000' AS DateTime), CAST(N'2020-06-01T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (7, 2, 4, 0, 0, NULL, CAST(N'2019-10-05T15:22:17.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (8, 2, 5, 10, 0, NULL, CAST(N'2019-10-05T15:22:17.000' AS DateTime), CAST(N'2019-12-01T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (9, 41, 1, 210, 0, NULL, CAST(N'2019-11-01T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (10, 41, 2, 0, 0, NULL, CAST(N'2019-11-01T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (11, 41, 3, 10, 0, NULL, CAST(N'2019-11-01T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (12, 41, 5, 5, 0, NULL, CAST(N'2019-11-01T14:00:00.000' AS DateTime), CAST(N'2019-11-01T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (13, 41, 6, 30, 0, NULL, CAST(N'2019-11-01T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (14, 32, 2, 0, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (15, 110, 3, 10, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (16, 32, 3, 10, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (17, 111, 1, 210, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (18, 110, 1, 210, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (19, 32, 1, 210, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (20, 111, 3, 10, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (21, 110, 2, 0, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (22, 111, 2, 0, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (23, 32, 5, 5, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2019-11-02T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (24, 110, 5, 5, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2019-11-02T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (25, 111, 5, 5, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2019-11-02T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (26, 32, 6, 30, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (27, 110, 6, 30, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (28, 111, 6, 30, 0, NULL, CAST(N'2019-11-02T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (29, 5, 3, 10, 0, NULL, CAST(N'2019-11-03T14:00:00.000' AS DateTime), CAST(N'2019-11-03T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (30, 5, 4, 0, 0, NULL, CAST(N'2019-11-03T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (31, 5, 5, 10, 0, NULL, CAST(N'2019-11-03T14:00:00.000' AS DateTime), CAST(N'2019-11-03T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (32, 5, 1, 216, 0, NULL, CAST(N'2019-11-03T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (33, 34, 1, 210, 0, NULL, CAST(N'2019-11-05T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (34, 34, 3, 10, 0, NULL, CAST(N'2019-11-05T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (35, 34, 4, 0, 0, NULL, CAST(N'2019-11-05T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (36, 34, 5, 5, 0, NULL, CAST(N'2019-11-05T15:00:00.000' AS DateTime), CAST(N'2019-11-05T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (37, 39, 4, 0, 0, NULL, CAST(N'2019-11-11T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (38, 39, 5, 15, 0, NULL, CAST(N'2019-11-11T15:00:01.000' AS DateTime), CAST(N'2020-05-11T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (39, 39, 3, 10, 0, NULL, CAST(N'2019-11-11T15:00:01.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (40, 39, 1, 222, 0, NULL, CAST(N'2019-11-11T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (41, 42, 1, 216, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (42, 35, 1, 216, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (43, 35, 3, 10, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2020-05-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (44, 42, 3, 10, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2020-05-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (45, 35, 4, 0, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (46, 42, 4, 0, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (47, 35, 5, 10, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2020-05-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (48, 42, 5, 10, 0, NULL, CAST(N'2019-11-13T15:00:00.000' AS DateTime), CAST(N'2020-05-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (49, 19, 1, 216, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (50, 33, 1, 216, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (51, 47, 1, 222, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (52, 54, 1, 216, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (53, 55, 1, 216, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (54, 65, 1, 222, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (55, 19, 2, 0, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (56, 33, 2, 0, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (57, 55, 2, 0, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (58, 65, 2, 0, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (59, 19, 3, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (60, 33, 3, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (61, 47, 3, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (62, 54, 3, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (63, 55, 3, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (64, 65, 3, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (65, 47, 4, 0, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (66, 54, 4, 0, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (67, 19, 5, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (68, 33, 5, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (69, 47, 5, 15, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (70, 54, 5, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (71, 55, 5, 10, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (72, 65, 5, 15, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (73, 19, 6, 30, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (74, 33, 6, 30, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (75, 55, 6, 30, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2020-05-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (76, 65, 6, 30, 0, NULL, CAST(N'2019-11-16T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (77, 15, 4, 0, 0, NULL, CAST(N'2019-11-17T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (78, 15, 1, 216, 0, NULL, CAST(N'2019-11-17T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (79, 15, 5, 10, 0, NULL, CAST(N'2019-11-17T15:00:00.000' AS DateTime), CAST(N'2020-05-17T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (80, 15, 3, 10, 0, NULL, CAST(N'2019-11-17T15:00:00.000' AS DateTime), CAST(N'2020-05-17T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (81, 36, 1, 216, 0, NULL, CAST(N'2019-11-19T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (82, 36, 3, 10, 0, NULL, CAST(N'2019-11-19T15:00:00.000' AS DateTime), CAST(N'2020-05-19T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (83, 36, 4, 0, 0, NULL, CAST(N'2019-11-19T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (84, 36, 5, 10, 0, NULL, CAST(N'2019-11-19T15:00:00.000' AS DateTime), CAST(N'2020-05-19T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (85, 58, 5, 10, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (86, 57, 5, 10, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (87, 56, 5, 10, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (88, 57, 1, 216, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (89, 58, 2, 0, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (90, 58, 3, 10, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (91, 57, 3, 10, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (92, 56, 3, 10, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (93, 58, 1, 216, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (94, 56, 1, 216, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (95, 56, 4, 0, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (96, 57, 4, 0, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (97, 58, 6, 30, 0, NULL, CAST(N'2019-11-23T15:00:00.000' AS DateTime), CAST(N'2020-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (98, 16, 1, 216, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (99, 20, 1, 216, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
GO
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (100, 16, 2, 0, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (101, 20, 2, 0, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (102, 16, 3, 10, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2020-05-27T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (103, 20, 3, 10, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2020-05-27T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (104, 16, 5, 10, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2020-05-27T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (105, 20, 5, 10, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2020-05-27T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (106, 16, 6, 30, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2020-05-27T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (107, 20, 6, 30, 0, NULL, CAST(N'2019-11-27T15:00:00.000' AS DateTime), CAST(N'2020-05-27T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (108, 77, 2, 0, 0, NULL, CAST(N'2019-11-29T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (109, 77, 1, 216, 0, NULL, CAST(N'2019-11-29T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (110, 77, 3, 10, 0, NULL, CAST(N'2019-11-29T15:00:00.000' AS DateTime), CAST(N'2020-05-29T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (111, 77, 5, 10, 0, NULL, CAST(N'2019-11-29T15:00:00.000' AS DateTime), CAST(N'2020-05-29T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (112, 77, 6, 30, 0, NULL, CAST(N'2019-11-29T15:00:00.000' AS DateTime), CAST(N'2020-05-29T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (113, 66, 3, 10, 0, NULL, CAST(N'2019-12-01T15:00:01.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (114, 66, 5, 15, 0, NULL, CAST(N'2019-12-01T15:00:01.000' AS DateTime), CAST(N'2020-06-01T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (115, 66, 1, 222, 0, NULL, CAST(N'2019-12-01T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (116, 66, 6, 30, 0, NULL, CAST(N'2019-12-01T15:00:01.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (117, 66, 2, 0, 0, NULL, CAST(N'2019-12-01T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (118, 99, 5, 10, 0, NULL, CAST(N'2019-12-02T15:00:03.000' AS DateTime), CAST(N'2020-06-02T14:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (119, 99, 1, 216, 0, NULL, CAST(N'2019-12-02T15:00:03.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (120, 99, 6, 30, 0, NULL, CAST(N'2019-12-02T15:00:03.000' AS DateTime), CAST(N'2020-06-02T14:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (121, 99, 2, 0, 0, NULL, CAST(N'2019-12-02T15:00:03.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (122, 99, 3, 10, 0, NULL, CAST(N'2019-12-02T15:00:03.000' AS DateTime), CAST(N'2020-06-02T14:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (123, 7, 3, 10, 0, NULL, CAST(N'2019-12-03T15:00:01.000' AS DateTime), CAST(N'2019-12-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (124, 7, 2, 0, 0, NULL, CAST(N'2019-12-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (125, 7, 1, 216, 0, NULL, CAST(N'2019-12-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (126, 7, 6, 30, 0, NULL, CAST(N'2019-12-03T15:00:01.000' AS DateTime), CAST(N'2019-12-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (127, 7, 5, 10, 0, NULL, CAST(N'2019-12-03T15:00:01.000' AS DateTime), CAST(N'2019-12-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (128, 95, 1, 210, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (129, 95, 2, 0, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (130, 95, 3, 10, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (131, 96, 3, 10, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (132, 96, 4, 0, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (133, 95, 5, 5, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2019-12-04T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (134, 96, 5, 5, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2019-12-04T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (135, 96, 1, 210, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (136, 95, 6, 30, 0, NULL, CAST(N'2019-12-04T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (137, 78, 3, 10, 0, NULL, CAST(N'2019-12-05T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (138, 78, 2, 0, 0, NULL, CAST(N'2019-12-05T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (139, 78, 1, 210, 0, NULL, CAST(N'2019-12-05T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (140, 78, 5, 5, 0, NULL, CAST(N'2019-12-05T15:00:00.000' AS DateTime), CAST(N'2019-12-05T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (141, 78, 6, 30, 0, NULL, CAST(N'2019-12-05T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (142, 10, 1, 210, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (143, 79, 1, 210, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (144, 10, 2, 0, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (145, 79, 2, 0, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (146, 10, 3, 10, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (147, 79, 3, 10, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (148, 10, 5, 5, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2019-12-08T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (149, 79, 5, 5, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2019-12-08T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (150, 10, 6, 30, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (151, 79, 6, 30, 0, NULL, CAST(N'2019-12-08T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (152, 9, 3, 10, 0, NULL, CAST(N'2019-12-09T15:00:00.000' AS DateTime), CAST(N'2019-12-09T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (153, 9, 1, 216, 0, NULL, CAST(N'2019-12-09T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (154, 9, 4, 0, 0, NULL, CAST(N'2019-12-09T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (155, 9, 5, 10, 0, NULL, CAST(N'2019-12-09T15:00:00.000' AS DateTime), CAST(N'2019-12-09T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (156, 23, 1, 210, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (157, 106, 1, 216, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (158, 23, 2, 0, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (159, 23, 3, 10, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (160, 106, 3, 10, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2019-12-11T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (161, 106, 4, 0, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (162, 23, 5, 5, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2019-12-11T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (163, 106, 5, 10, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2019-12-11T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (164, 23, 6, 30, 0, NULL, CAST(N'2019-12-11T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (165, 24, 2, 0, 0, NULL, CAST(N'2019-12-13T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (166, 24, 3, 10, 0, NULL, CAST(N'2019-12-13T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (167, 24, 1, 210, 0, NULL, CAST(N'2019-12-13T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (168, 24, 5, 5, 0, NULL, CAST(N'2019-12-13T15:00:00.000' AS DateTime), CAST(N'2019-12-13T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (169, 24, 6, 30, 0, NULL, CAST(N'2019-12-13T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (170, 59, 4, 0, 0, NULL, CAST(N'2019-12-16T15:00:02.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (171, 59, 3, 10, 0, NULL, CAST(N'2019-12-16T15:00:02.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (172, 59, 1, 210, 0, NULL, CAST(N'2019-12-16T15:00:02.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (173, 59, 5, 5, 0, NULL, CAST(N'2019-12-16T15:00:02.000' AS DateTime), CAST(N'2019-12-16T15:00:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (174, 28, 3, 10, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (175, 112, 2, 0, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (176, 28, 2, 0, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (177, 112, 3, 10, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (178, 28, 1, 210, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (179, 112, 1, 210, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (180, 28, 5, 5, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2019-12-17T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (181, 112, 5, 5, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2019-12-17T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (182, 28, 6, 30, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (183, 112, 6, 30, 0, NULL, CAST(N'2019-12-17T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (184, 29, 3, 10, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (185, 98, 3, 10, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (186, 29, 1, 210, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (187, 98, 1, 210, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (188, 29, 4, 0, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (189, 98, 4, 0, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (190, 29, 5, 5, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2019-12-18T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (191, 98, 5, 5, 0, NULL, CAST(N'2019-12-18T15:00:00.000' AS DateTime), CAST(N'2019-12-18T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (192, 17, 6, 30, 0, NULL, CAST(N'2019-12-28T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (193, 17, 3, 10, 0, NULL, CAST(N'2019-12-28T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (194, 17, 2, 0, 0, NULL, CAST(N'2019-12-28T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (195, 17, 1, 210, 0, NULL, CAST(N'2019-12-28T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (196, 17, 5, 5, 0, NULL, CAST(N'2019-12-28T15:00:00.000' AS DateTime), CAST(N'2019-12-28T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (197, 8, 5, 10, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2020-01-02T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (198, 101, 4, 0, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (199, 8, 4, 0, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
GO
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (200, 100, 1, 210, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (201, 8, 1, 216, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (202, 100, 2, 0, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (203, 101, 1, 210, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (204, 8, 3, 10, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2020-01-02T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (205, 100, 3, 10, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (206, 101, 3, 10, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (207, 100, 5, 5, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2020-01-02T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (208, 101, 5, 5, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2020-01-02T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (209, 100, 6, 30, 0, NULL, CAST(N'2020-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (210, 67, 4, 0, 0, NULL, CAST(N'2020-01-03T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (211, 102, 3, 10, 0, NULL, CAST(N'2020-01-03T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (212, 87, 3, 10, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2020-01-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (213, 67, 1, 216, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (214, 67, 3, 10, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2020-01-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (215, 102, 4, 0, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (216, 87, 2, 0, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (217, 87, 1, 216, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (218, 102, 1, 210, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (219, 67, 5, 10, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2020-01-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (220, 87, 5, 10, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2020-01-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (221, 102, 5, 5, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2020-01-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (222, 87, 6, 30, 0, NULL, CAST(N'2020-01-03T15:00:01.000' AS DateTime), CAST(N'2020-01-03T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (223, 80, 3, 10, 0, NULL, CAST(N'2020-01-05T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (224, 80, 1, 210, 0, NULL, CAST(N'2020-01-05T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (225, 80, 4, 0, 0, NULL, CAST(N'2020-01-05T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (226, 80, 5, 5, 0, NULL, CAST(N'2020-01-05T15:00:00.000' AS DateTime), CAST(N'2020-01-05T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (227, 81, 1, 210, 0, NULL, CAST(N'2020-01-06T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (228, 81, 3, 10, 0, NULL, CAST(N'2020-01-06T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (229, 81, 4, 0, 0, NULL, CAST(N'2020-01-06T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (230, 81, 5, 5, 0, NULL, CAST(N'2020-01-06T15:00:00.000' AS DateTime), CAST(N'2020-01-06T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (231, 18, 3, 10, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (232, 60, 1, 210, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (233, 18, 1, 210, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (234, 60, 3, 10, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (235, 18, 2, 0, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (236, 60, 4, 0, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (237, 18, 5, 5, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2020-01-12T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (238, 60, 5, 5, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2020-01-12T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (239, 18, 6, 30, 0, NULL, CAST(N'2020-01-12T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (240, 103, 5, 5, 0, NULL, CAST(N'2020-01-16T15:00:00.000' AS DateTime), CAST(N'2020-01-16T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (241, 103, 4, 0, 0, NULL, CAST(N'2020-01-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (242, 103, 3, 10, 0, NULL, CAST(N'2020-01-16T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (243, 103, 1, 210, 0, NULL, CAST(N'2020-01-16T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (244, 82, 1, 0, 0, NULL, CAST(N'2020-01-17T15:00:01.000' AS DateTime), CAST(N'2021-01-24T19:28:05.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (245, 82, 3, 0, 0, NULL, CAST(N'2020-01-17T15:00:01.000' AS DateTime), CAST(N'2021-01-24T19:28:05.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (246, 82, 4, 0, 0, NULL, CAST(N'2020-01-17T15:00:01.000' AS DateTime), CAST(N'2021-01-24T19:28:05.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (247, 82, 5, 0, 0, NULL, CAST(N'2020-01-17T15:00:01.000' AS DateTime), CAST(N'2021-01-24T19:28:05.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (248, 4, 3, 10, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2020-02-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (249, 4, 6, 30, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2020-02-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (250, 37, 5, 5, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2020-02-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (251, 37, 6, 30, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (252, 4, 5, 10, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2020-02-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (253, 37, 2, 0, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (254, 4, 2, 0, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (255, 61, 3, 10, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (256, 61, 5, 5, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2020-02-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (257, 37, 3, 10, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (258, 4, 1, 216, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (259, 37, 1, 210, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (260, 61, 1, 210, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (261, 61, 4, 0, 0, NULL, CAST(N'2020-02-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (262, 25, 1, 216, 0, NULL, CAST(N'2020-02-04T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (263, 25, 3, 10, 0, NULL, CAST(N'2020-02-04T15:00:00.000' AS DateTime), CAST(N'2020-02-04T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (264, 25, 4, 0, 0, NULL, CAST(N'2020-02-04T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (265, 25, 5, 10, 0, NULL, CAST(N'2020-02-04T15:00:00.000' AS DateTime), CAST(N'2020-02-04T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (266, 113, 1, 210, 0, NULL, CAST(N'2020-02-05T15:00:07.000' AS DateTime), CAST(N'2021-01-25T20:52:31.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (267, 113, 2, 0, 0, NULL, CAST(N'2020-02-05T15:00:07.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (268, 113, 6, 30, 0, NULL, CAST(N'2020-02-05T15:00:07.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (269, 113, 5, 5, 0, NULL, CAST(N'2020-02-05T15:00:07.000' AS DateTime), CAST(N'2020-02-05T15:00:07.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (270, 113, 3, 10, 0, NULL, CAST(N'2020-02-05T15:00:07.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (271, 90, 3, 10, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (272, 88, 4, 0, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (273, 89, 4, 0, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (274, 88, 5, 10, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (275, 89, 5, 10, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (276, 89, 3, 10, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (277, 88, 3, 10, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (278, 90, 5, 10, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (279, 88, 1, 216, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (280, 89, 1, 216, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (281, 90, 1, 216, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (282, 90, 2, 0, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (283, 90, 6, 30, 0, NULL, CAST(N'2020-02-12T15:00:01.000' AS DateTime), CAST(N'2020-02-12T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (284, 83, 4, 0, 0, NULL, CAST(N'2020-02-14T15:00:05.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (285, 83, 3, 10, 0, NULL, CAST(N'2020-02-14T15:00:05.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (286, 83, 5, 5, 0, NULL, CAST(N'2020-02-14T15:00:05.000' AS DateTime), CAST(N'2020-02-14T15:00:05.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (287, 83, 1, 210, 0, NULL, CAST(N'2020-02-14T15:00:05.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (288, 107, 3, 10, 0, NULL, CAST(N'2020-02-20T15:00:00.000' AS DateTime), CAST(N'2020-02-20T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (289, 107, 1, 216, 0, NULL, CAST(N'2020-02-20T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (290, 107, 2, 0, 0, NULL, CAST(N'2020-02-20T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (291, 107, 5, 10, 0, NULL, CAST(N'2020-02-20T15:00:00.000' AS DateTime), CAST(N'2020-02-20T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (292, 107, 6, 30, 0, NULL, CAST(N'2020-02-20T15:00:00.000' AS DateTime), CAST(N'2020-02-20T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (293, 84, 2, 0, 0, NULL, CAST(N'2020-02-22T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (294, 84, 6, 30, 0, NULL, CAST(N'2020-02-22T15:00:01.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (295, 84, 3, 10, 0, NULL, CAST(N'2020-02-22T15:00:01.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (296, 84, 5, 5, 0, NULL, CAST(N'2020-02-22T15:00:01.000' AS DateTime), CAST(N'2020-02-22T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (297, 84, 1, 210, 0, NULL, CAST(N'2020-02-22T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (298, 30, 1, 216, 0, NULL, CAST(N'2020-02-24T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (299, 30, 4, 0, 0, NULL, CAST(N'2020-02-24T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
GO
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (300, 30, 3, 10, 0, NULL, CAST(N'2020-02-24T15:00:01.000' AS DateTime), CAST(N'2020-02-24T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (301, 30, 5, 10, 0, NULL, CAST(N'2020-02-24T15:00:01.000' AS DateTime), CAST(N'2020-02-24T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (302, 26, 5, 10, 0, NULL, CAST(N'2020-02-26T15:00:01.000' AS DateTime), CAST(N'2020-02-26T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (303, 26, 4, 0, 0, NULL, CAST(N'2020-02-26T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (304, 26, 1, 216, 0, NULL, CAST(N'2020-02-26T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (305, 26, 3, 10, 0, NULL, CAST(N'2020-02-26T15:00:01.000' AS DateTime), CAST(N'2020-02-26T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (306, 68, 3, 10, 0, NULL, CAST(N'2020-03-01T15:00:00.000' AS DateTime), CAST(N'2020-03-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (307, 68, 4, 0, 0, NULL, CAST(N'2020-03-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (308, 68, 5, 10, 0, NULL, CAST(N'2020-03-01T15:00:00.000' AS DateTime), CAST(N'2020-03-01T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (309, 68, 1, 216, 0, NULL, CAST(N'2020-03-01T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (310, 31, 1, 216, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (311, 31, 3, 10, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2020-03-03T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (312, 114, 3, 10, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (313, 114, 1, 210, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:31.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (314, 114, 2, 0, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (315, 31, 5, 10, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2020-03-03T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (316, 31, 4, 0, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (317, 114, 5, 5, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2020-03-03T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (318, 114, 6, 30, 0, NULL, CAST(N'2020-03-03T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (319, 21, 1, 216, 0, NULL, CAST(N'2020-03-05T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (320, 21, 5, 10, 0, NULL, CAST(N'2020-03-05T15:00:01.000' AS DateTime), CAST(N'2020-03-05T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (321, 21, 4, 0, 0, NULL, CAST(N'2020-03-05T15:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (322, 21, 3, 10, 0, NULL, CAST(N'2020-03-05T15:00:01.000' AS DateTime), CAST(N'2020-03-05T15:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (323, 69, 1, 216, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (324, 85, 1, 210, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (325, 69, 2, 0, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (326, 85, 3, 10, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (327, 69, 3, 10, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2020-03-06T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (328, 69, 5, 10, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2020-03-06T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (329, 85, 4, 0, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (330, 85, 5, 5, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2020-03-06T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (331, 69, 6, 30, 0, NULL, CAST(N'2020-03-06T15:00:00.000' AS DateTime), CAST(N'2020-03-06T15:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (332, 62, 5, 5, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2020-03-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (333, 70, 4, 0, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (334, 62, 3, 10, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (335, 70, 1, 216, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (336, 70, 3, 10, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2020-03-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (337, 62, 1, 210, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (338, 70, 5, 10, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2020-03-13T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (339, 62, 4, 0, 0, NULL, CAST(N'2020-03-13T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (340, 63, 3, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (341, 48, 2, 0, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (342, 49, 2, 0, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (343, 50, 3, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (344, 49, 3, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (345, 48, 3, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (346, 63, 1, 210, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (347, 50, 1, 216, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (348, 49, 1, 216, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (349, 48, 1, 216, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (350, 63, 2, 0, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (351, 50, 4, 0, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (352, 48, 5, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (353, 49, 5, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (354, 50, 5, 10, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (355, 63, 5, 5, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (356, 48, 6, 30, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (357, 49, 6, 30, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2020-03-16T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (358, 63, 6, 30, 0, NULL, CAST(N'2020-03-16T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (359, 44, 6, 30, 0, NULL, CAST(N'2020-03-18T14:00:00.000' AS DateTime), CAST(N'2020-03-18T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (360, 44, 5, 10, 0, NULL, CAST(N'2020-03-18T14:00:00.000' AS DateTime), CAST(N'2020-03-18T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (361, 44, 3, 10, 0, NULL, CAST(N'2020-03-18T14:00:00.000' AS DateTime), CAST(N'2020-03-18T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (362, 44, 1, 216, 0, NULL, CAST(N'2020-03-18T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (363, 44, 2, 0, 0, NULL, CAST(N'2020-03-18T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (364, 71, 6, 30, 0, NULL, CAST(N'2020-05-11T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:17.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (365, 71, 1, 210, 0, NULL, CAST(N'2020-05-11T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (366, 71, 2, 0, 0, NULL, CAST(N'2020-05-11T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (367, 71, 3, 10, 0, NULL, CAST(N'2020-05-11T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (368, 71, 5, 5, 0, NULL, CAST(N'2020-05-11T14:00:00.000' AS DateTime), CAST(N'2020-05-11T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (369, 74, 1, 210, 0, NULL, CAST(N'2020-05-18T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (370, 74, 3, 10, 0, NULL, CAST(N'2020-05-18T14:00:00.000' AS DateTime), CAST(N'2021-01-24T21:33:16.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (371, 74, 4, 0, 0, NULL, CAST(N'2020-05-18T14:00:00.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (372, 74, 5, 5, 0, NULL, CAST(N'2020-05-18T14:00:00.000' AS DateTime), CAST(N'2020-05-18T14:00:00.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (373, 118, 1, 216, 0, NULL, CAST(N'2020-06-02T14:00:01.000' AS DateTime), CAST(N'2021-01-25T20:52:31.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (374, 118, 4, 0, 0, NULL, CAST(N'2020-06-02T14:00:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (375, 118, 5, 10, 0, NULL, CAST(N'2020-06-02T14:00:01.000' AS DateTime), CAST(N'2020-06-02T14:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (376, 118, 3, 10, 0, NULL, CAST(N'2020-06-02T14:00:01.000' AS DateTime), CAST(N'2020-06-02T14:00:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (377, 6, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (378, 13, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (379, 11, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (380, 14, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (381, 3, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (382, 12, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (383, 22, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (384, 27, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:00.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (385, 40, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (386, 38, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (387, 43, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (388, 45, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (389, 46, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (390, 51, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (391, 52, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (392, 53, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (393, 64, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (394, 72, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (395, 73, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (396, 76, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (397, 75, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (398, 86, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (399, 91, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
GO
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (400, 93, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (401, 92, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (402, 94, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (403, 97, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (404, 104, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (405, 108, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (406, 105, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (407, 109, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:30.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (408, 115, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:31.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (409, 116, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:31.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (410, 117, 1, 192, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:52:31.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (411, 11, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (412, 12, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (413, 45, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (414, 52, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (415, 86, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (416, 97, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (417, 109, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (418, 105, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (419, 115, 2, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (420, 3, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (421, 6, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (422, 11, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (423, 13, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (424, 14, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (425, 12, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (426, 22, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (427, 27, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (428, 38, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (429, 40, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (430, 43, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (431, 45, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (432, 46, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (433, 51, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (434, 52, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (435, 53, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (436, 64, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (437, 72, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (438, 73, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (439, 76, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (440, 75, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (441, 86, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (442, 91, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (443, 92, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (444, 94, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (445, 93, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (446, 97, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (447, 104, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (448, 105, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (449, 108, 3, 5, 5, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-02-02T20:20:32.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (450, 109, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (451, 115, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (452, 116, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (453, 117, 3, 10, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (454, 3, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (455, 14, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (456, 6, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (457, 13, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (458, 22, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (459, 27, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (460, 38, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (461, 40, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (462, 43, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (463, 46, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (464, 51, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (465, 53, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (466, 64, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (467, 72, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (468, 73, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (469, 75, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (470, 76, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (471, 91, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (472, 92, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (473, 93, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (474, 94, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (475, 104, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (476, 116, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (477, 108, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (478, 117, 4, 0, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-25T20:50:02.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (479, 11, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (480, 12, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (481, 45, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (482, 52, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (483, 86, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (484, 97, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (485, 105, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (486, 109, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
INSERT [dbo].[leave_credit_policy] ([id], [user_id], [policy_id], [balance], [utilized], [cycle], [created_at], [updated_at]) VALUES (487, 115, 6, 30, 0, NULL, CAST(N'2021-01-24T21:37:01.000' AS DateTime), CAST(N'2021-01-24T21:37:01.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[leave_credit_policy] OFF
GO
SET IDENTITY_INSERT [dbo].[leave_policy] ON 

INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (1, N'Vacation Leave', 12, N'', 6, 6, 6, 1, 15, 1, NULL, NULL, N'We have a Gitter chat room set up where you can talk directly with us.', 1, CAST(N'2019-08-03T05:14:14.000' AS DateTime), CAST(N'2021-01-24T21:27:24.000' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (2, N'Maternity Leave', 105, N'Female', 0, NULL, 6, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2019-08-03T05:36:53.000' AS DateTime), CAST(N'2019-09-18T00:23:27.000' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (3, N'Sick Leave', 10, N'', 6, 5, 6, 1, 10, 1, 0, 0, NULL, NULL, CAST(N'2019-08-03T05:37:17.000' AS DateTime), CAST(N'2019-09-18T00:23:27.000' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (4, N'Paternity Leave', 14, N'Male', 0, NULL, 6, 0, 0, 1, NULL, NULL, NULL, NULL, CAST(N'2019-08-03T05:37:56.000' AS DateTime), CAST(N'2019-09-18T00:23:28.000' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (5, N'Emergency Leave', 10, N'', 6, 5, 6, 0, 0, 1, NULL, NULL, NULL, 0, CAST(N'2019-08-04T11:21:00.000' AS DateTime), CAST(N'2021-01-18T20:19:05.000' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (6, N'Miscarriage', 30, N'Female', 0, 6, 6, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2019-08-06T03:42:02.000' AS DateTime), CAST(N'2019-09-18T01:05:40.000' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (7, N'Parental Leave', 10, N'', 6, 1, 12, NULL, NULL, 1, NULL, NULL, NULL, 0, CAST(N'2021-08-18T21:52:41.980' AS DateTime), CAST(N'2021-08-18T21:52:41.980' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (8, N'Service Incentive Leave', 5, N'', 5, 5, 12, NULL, NULL, 1, NULL, NULL, NULL, 0, CAST(N'2021-08-18T21:53:40.710' AS DateTime), CAST(N'2021-08-18T21:53:40.710' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (9, N'Violence Against Women and Children Leave', 5, N'', 5, 5, 12, NULL, NULL, 1, NULL, NULL, NULL, 0, CAST(N'2021-08-18T21:54:16.720' AS DateTime), CAST(N'2021-08-18T21:54:16.720' AS DateTime))
INSERT [dbo].[leave_policy] ([id], [name], [total_per_year], [gender], [probation_validity], [initial], [cycle], [increment], [max_increment], [status], [company], [department], [description], [carry_over], [created_at], [updated_at]) VALUES (10, N'Special Leave for Women', 5, N'', 5, 5, 12, NULL, NULL, 1, NULL, NULL, NULL, 0, CAST(N'2021-08-18T21:55:51.910' AS DateTime), CAST(N'2021-08-18T21:55:51.910' AS DateTime))
SET IDENTITY_INSERT [dbo].[leave_policy] OFF
GO
SET IDENTITY_INSERT [dbo].[leaves] ON 

INSERT [dbo].[leaves] ([id], [user_id], [dates], [start_date], [end_date], [leave_type], [other], [no_of_days], [credit], [reason], [attachment], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [is_hr], [created_by], [updated_by], [created_at], [updated_at], [proccessed]) VALUES (1, 1, NULL, CAST(N'2019-10-04' AS Date), CAST(N'2019-10-04' AS Date), 1, N'', 1, 2, N'Test leave', NULL, 3, 3, 1, 1, NULL, N'', NULL, 0, 0, CAST(N'2019-10-03T17:56:43.000' AS DateTime), CAST(N'2019-10-08T11:36:56.000' AS DateTime), 1)
INSERT [dbo].[leaves] ([id], [user_id], [dates], [start_date], [end_date], [leave_type], [other], [no_of_days], [credit], [reason], [attachment], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [is_hr], [created_by], [updated_by], [created_at], [updated_at], [proccessed]) VALUES (2, 2, NULL, CAST(N'2019-10-08' AS Date), CAST(N'2019-10-08' AS Date), 1, N'', 1, 1, N'On family vacation', NULL, 2, 2, 1, 1, NULL, N'', NULL, 0, 0, CAST(N'2019-10-08T10:55:27.000' AS DateTime), CAST(N'2019-10-08T11:36:49.000' AS DateTime), 1)
INSERT [dbo].[leaves] ([id], [user_id], [dates], [start_date], [end_date], [leave_type], [other], [no_of_days], [credit], [reason], [attachment], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [is_hr], [created_by], [updated_by], [created_at], [updated_at], [proccessed]) VALUES (3, 2, NULL, CAST(N'2019-10-11' AS Date), CAST(N'2019-10-11' AS Date), 3, N'', 1, 1, N'Rest day', NULL, 2, 2, 1, 1, NULL, N'', NULL, 0, 0, CAST(N'2019-10-08T11:31:58.000' AS DateTime), CAST(N'2019-10-08T11:36:49.000' AS DateTime), 1)
INSERT [dbo].[leaves] ([id], [user_id], [dates], [start_date], [end_date], [leave_type], [other], [no_of_days], [credit], [reason], [attachment], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [is_hr], [created_by], [updated_by], [created_at], [updated_at], [proccessed]) VALUES (4, 1, NULL, CAST(N'2020-03-11' AS Date), CAST(N'2020-03-26' AS Date), 1, N'', 16, 1, N'', NULL, 1, 1, 1, 1, NULL, N'0dd1a39d-3933-4fa3-b2c5-1937e308c64f', NULL, 0, 0, CAST(N'2020-03-11T16:24:56.000' AS DateTime), CAST(N'2020-03-11T16:24:56.000' AS DateTime), 1)
INSERT [dbo].[leaves] ([id], [user_id], [dates], [start_date], [end_date], [leave_type], [other], [no_of_days], [credit], [reason], [attachment], [primary_status], [backup_status], [primary_approver], [backup_approver], [approver_note], [_token], [is_hr], [created_by], [updated_by], [created_at], [updated_at], [proccessed]) VALUES (24, 1, NULL, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-07' AS Date), 1, N' ', 3, 1, N' ', NULL, 2, 2, 1, 1, NULL, N'', NULL, 0, 0, CAST(N'2021-07-13T15:39:46.060' AS DateTime), CAST(N'2021-07-13T15:39:46.060' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[leaves] OFF
GO
SET IDENTITY_INSERT [dbo].[leaves_date] ON 

INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (1, 1, 1, CAST(N'2019-10-04' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (2, 2, 2, CAST(N'2019-10-08' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (3, 3, 2, CAST(N'2019-10-11' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (4, 4, 1, CAST(N'2020-03-11' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (5, 4, 1, CAST(N'2020-03-12' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (6, 4, 1, CAST(N'2020-03-13' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (7, 4, 1, CAST(N'2020-03-14' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (8, 4, 1, CAST(N'2020-03-15' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (9, 4, 1, CAST(N'2020-03-16' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (10, 4, 1, CAST(N'2020-03-17' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (11, 4, 1, CAST(N'2020-03-18' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (12, 4, 1, CAST(N'2020-03-19' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (13, 4, 1, CAST(N'2020-03-20' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (14, 4, 1, CAST(N'2020-03-21' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (15, 4, 1, CAST(N'2020-03-22' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (16, 4, 1, CAST(N'2020-03-23' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (17, 4, 1, CAST(N'2020-03-24' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (18, 4, 1, CAST(N'2020-03-25' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (19, 4, 1, CAST(N'2020-03-26' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (104, 24, 1, CAST(N'2021-08-05' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (105, 24, 1, CAST(N'2021-08-06' AS Date), 1)
INSERT [dbo].[leaves_date] ([id], [leave_id], [user_id], [date], [number_of_day]) VALUES (106, 24, 1, CAST(N'2021-08-07' AS Date), 1)
SET IDENTITY_INSERT [dbo].[leaves_date] OFF
GO
SET IDENTITY_INSERT [dbo].[loan] ON 

INSERT [dbo].[loan] ([id], [user_id], [amount], [label], [mode_of_payment], [date_to_pay], [frequency], [status], [note], [year], [month], [period], [created_at], [updated_at], [loan_type]) VALUES (1, 2, 5000, N'Test loan', 0, CAST(N'2020-06-16' AS Date), 2, 1, NULL, N'2020', N'12', N'A', CAST(N'2020-06-01T21:44:11.000' AS DateTime), CAST(N'2020-12-13T21:03:18.000' AS DateTime), 2)
INSERT [dbo].[loan] ([id], [user_id], [amount], [label], [mode_of_payment], [date_to_pay], [frequency], [status], [note], [year], [month], [period], [created_at], [updated_at], [loan_type]) VALUES (2, 2, 5000, N'Test loan 2', 1, CAST(N'2020-06-30' AS Date), 4, 1, NULL, N'2020', N'12', N'A', CAST(N'2020-06-02T13:27:03.000' AS DateTime), CAST(N'2020-12-13T21:03:13.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[loan] OFF
GO
SET IDENTITY_INSERT [dbo].[loan_payments] ON 

INSERT [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (1, 2, 2, 2021, N'01', N'A', 1250, 0)
INSERT [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (2, 2, 2, 2020, N'12', N'B', 1250, 0)
INSERT [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (3, 2, 2, 2020, N'12', N'A', 1250, 0)
INSERT [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (4, 2, 2, 2021, N'01', N'B', 1250, 0)
INSERT [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (5, 1, 2, 2020, N'12', N'A', 2500, 0)
INSERT [dbo].[loan_payments] ([id], [loan_id], [user_id], [year], [month], [period], [amount], [status]) VALUES (6, 1, 2, 2020, N'12', N'B', 2500, 0)
SET IDENTITY_INSERT [dbo].[loan_payments] OFF
GO
SET IDENTITY_INSERT [dbo].[locations] ON 

INSERT [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (1, N'Davao', CAST(N'2021-06-11T00:19:40.000' AS DateTime), NULL)
INSERT [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (2, N'Padigusan', CAST(N'2021-06-11T00:19:45.000' AS DateTime), NULL)
INSERT [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (3, N'Mine', CAST(N'2021-06-11T00:19:49.000' AS DateTime), NULL)
INSERT [dbo].[locations] ([id], [location], [createdAt], [updatedAt]) VALUES (4, N'Mill', CAST(N'2021-06-11T00:19:50.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[locations] OFF
GO
SET IDENTITY_INSERT [dbo].[modules] ON 

INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (1, N'Recruitment : Candidate Profile', N'recruitment-candidate-profile', 1, CAST(N'2019-07-04T02:16:52.000' AS DateTime), CAST(N'2019-08-01T04:53:15.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (2, N'Recruitment : Schedule', N'recruitment-schedule', 1, CAST(N'2019-07-04T02:17:21.000' AS DateTime), CAST(N'2019-08-01T04:53:25.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (3, N'Recruitment : Ratings', N'recruitment-rating', 1, CAST(N'2019-07-04T02:17:37.000' AS DateTime), CAST(N'2019-08-01T04:53:30.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (4, N'Recruitment : Joining', N'recruitment-joining', 1, CAST(N'2019-07-04T02:17:44.000' AS DateTime), CAST(N'2019-08-01T04:53:35.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (7, N'Approval : Shifts', N'approvals-shift', 1, CAST(N'2019-07-04T02:18:56.000' AS DateTime), CAST(N'2019-08-01T04:53:52.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (8, N'Approval : Leave', N'approvals-leave', 1, CAST(N'2019-07-04T02:19:03.000' AS DateTime), CAST(N'2019-08-01T04:53:56.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (9, N'Approval : Overtime', N'approvals-overtime', 1, CAST(N'2019-07-04T02:19:12.000' AS DateTime), CAST(N'2019-08-01T04:54:01.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (10, N'Approval : Undertime', N'approvals-undertime', 1, CAST(N'2019-07-04T02:19:24.000' AS DateTime), CAST(N'2019-08-01T04:54:05.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (11, N'Approval : Business Trip', N'approvals-business-trip', 1, CAST(N'2019-07-04T02:19:35.000' AS DateTime), CAST(N'2019-08-01T04:54:11.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (12, N'Forms : Shift', N'forms-shift', 1, CAST(N'2019-07-04T02:19:47.000' AS DateTime), CAST(N'2019-08-01T04:54:20.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (13, N'Forms : Leave', N'forms-leave', 1, CAST(N'2019-07-04T02:19:52.000' AS DateTime), CAST(N'2019-08-01T04:54:25.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (14, N'Forms : Overtime', N'forms-overtime', 1, CAST(N'2019-07-04T02:19:58.000' AS DateTime), CAST(N'2019-08-01T04:54:29.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (15, N'Forms : Undertime', N'forms-undertime', 1, CAST(N'2019-07-04T02:20:03.000' AS DateTime), CAST(N'2019-08-01T04:54:34.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (16, N'Forms : Business Trip', N'forms-business-trip', 1, CAST(N'2019-07-04T02:20:11.000' AS DateTime), CAST(N'2019-08-01T04:54:41.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (17, N'Settings : Company', N'settings-company', 1, CAST(N'2019-07-04T02:20:28.000' AS DateTime), CAST(N'2019-08-01T04:54:52.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (18, N'Settings : Branch', N'settings-branch', 1, CAST(N'2019-07-04T02:20:37.000' AS DateTime), CAST(N'2019-08-01T04:54:56.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (19, N'Settings : Approvers', N'settings-approvers', 1, CAST(N'2019-07-04T02:20:54.000' AS DateTime), CAST(N'2019-08-01T04:55:01.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (20, N'Settings : Taxonomy', N'settings-taxonomy', 1, CAST(N'2019-07-04T02:21:01.000' AS DateTime), CAST(N'2019-08-01T04:55:06.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (21, N'Settings : Holidays', N'settings-holidays', 1, CAST(N'2019-07-04T02:21:11.000' AS DateTime), CAST(N'2019-08-01T04:55:10.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (22, N'Settings : Biometric', N'settings-biometric', 1, CAST(N'2019-07-04T02:21:20.000' AS DateTime), CAST(N'2019-08-01T04:55:15.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (23, N'Settings : Role', N'settings-role', 1, CAST(N'2019-07-04T02:21:33.000' AS DateTime), CAST(N'2019-08-01T04:55:18.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (24, N'Employee : Lists', N'employee-list', 1, CAST(N'2019-08-01T04:49:20.000' AS DateTime), CAST(N'2019-08-06T06:23:23.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (25, N'Employee : Detail', N'employee-detail', 1, CAST(N'2019-08-01T04:49:52.000' AS DateTime), CAST(N'2019-08-06T06:23:28.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (26, N'Employee : Attendance', N'employee-attendance', 1, CAST(N'2019-08-01T04:50:22.000' AS DateTime), CAST(N'2019-08-06T06:23:32.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (27, N'Employee : Salary', N'employee-salary', 1, CAST(N'2019-08-01T04:50:37.000' AS DateTime), CAST(N'2019-08-06T06:23:37.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (28, N'Employee : Loan', N'employee-loan', 1, CAST(N'2019-08-01T04:50:47.000' AS DateTime), CAST(N'2019-08-06T06:23:40.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (29, N'Employee : Documents', N'employee-document', 1, CAST(N'2019-08-01T04:51:02.000' AS DateTime), CAST(N'2019-08-06T06:23:44.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (30, N'Employee : Shifts', N'employee-shift', 1, CAST(N'2019-08-01T04:51:20.000' AS DateTime), CAST(N'2019-08-06T06:23:49.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (31, N'Employee : Leave', N'employee-leave', 1, CAST(N'2019-08-01T04:51:49.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (32, N'Employee : Overtime', N'employee-overtime', 1, CAST(N'2019-08-01T04:52:04.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (33, N'Employee : Undertime', N'employee-undertime', 1, CAST(N'2019-08-01T04:52:19.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (34, N'Employee : Business Trip', N'employee-business-trip', 1, CAST(N'2019-08-01T04:52:44.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (35, N'Employee : Dispute', N'employee-dispute', 1, CAST(N'2019-08-01T04:52:57.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (36, N'Forms : Dispute', N'forms-dispute', 1, CAST(N'2019-08-01T04:55:35.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (37, N'Attendance : Shift Management', N'attendance-shift', 1, CAST(N'2019-08-01T04:56:09.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (38, N'Attendance : Biometric Integration', N'attendance-biometric', 1, CAST(N'2019-08-01T04:56:36.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (39, N'Attendance : Leave Management', N'attendance-leave', 1, CAST(N'2019-08-01T04:56:57.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (40, N'Attendance : Overtime Management', N'attendance-overtime', 1, CAST(N'2019-08-01T04:57:15.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (41, N'Attendance : Absence Management', N'attendance-absence', 1, CAST(N'2019-08-01T04:57:40.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (42, N'Payment : Dispute', N'payment-dispute', 1, CAST(N'2019-08-01T04:58:21.000' AS DateTime), CAST(N'2019-09-11T23:10:58.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (43, N'Payment : Loan/ Cash Advance', N'payment-loan', 1, CAST(N'2019-08-01T04:58:40.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (44, N'Payment : Bulk Salary Creation', N'payment-salary', 1, CAST(N'2019-08-01T04:59:10.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (45, N'Payment : Salary Adjustment', N'payment-adjustment', 1, CAST(N'2019-08-01T04:59:36.000' AS DateTime), CAST(N'2019-09-11T21:01:50.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (46, N'Payment : Final Settlement', N'payment-settlement', 1, CAST(N'2019-08-01T04:59:54.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (47, N'Reliving : Resignation/ Retirement', N'reliving-resignation', 1, CAST(N'2019-08-01T05:00:34.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (48, N'Reliving : Exit Interview', N'reliving-interview', 1, CAST(N'2019-08-01T05:00:50.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (49, N'Reliving : Formalities', N'reliving-formality', 1, CAST(N'2019-08-01T05:01:06.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (50, N'Appraisal : Initiation', N'appraisal-initiation', 0, CAST(N'2019-08-01T05:01:48.000' AS DateTime), CAST(N'2019-09-17T04:16:59.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (51, N'Appraisal : Feedback', N'appraisal-feedback', 0, CAST(N'2019-08-01T05:02:05.000' AS DateTime), CAST(N'2019-09-17T04:17:01.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (52, N'Appraisal : Consolidation', N'appraisal-consolidation', 0, CAST(N'2019-08-01T05:02:30.000' AS DateTime), CAST(N'2019-09-17T04:17:03.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (53, N'Appraisal : Promotion', N'appraisal-promotion', 0, CAST(N'2019-08-01T05:02:46.000' AS DateTime), CAST(N'2019-09-17T04:17:05.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (54, N'Appraisal : Transfer', N'appraisal-transfer', 0, CAST(N'2019-08-01T05:03:02.000' AS DateTime), CAST(N'2019-09-17T04:17:05.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (55, N'Employee : Config', N'employee-config', 1, CAST(N'2019-08-02T05:29:29.000' AS DateTime), CAST(N'2019-08-14T22:29:10.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (56, N'Settings : Configuration', N'settings-configuration', 1, CAST(N'2019-08-02T06:27:06.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (57, N'Appraisal : Increment', N'appraisal-increment', 0, CAST(N'2019-08-03T00:42:11.000' AS DateTime), CAST(N'2019-09-17T04:17:20.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (58, N'Settings : Leave Policy', N'settings-leave-policy', 1, CAST(N'2019-08-03T04:24:56.000' AS DateTime), CAST(N'2019-08-03T04:25:07.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (59, N'Employee : Leave Credit', N'employee-leave-credit', 1, CAST(N'2019-08-06T06:24:14.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (61, N'Employee : Role', N'employee-role', 1, CAST(N'2019-08-16T22:18:35.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (62, N'Announcement', N'announcement', 1, CAST(N'2019-08-18T00:08:26.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (63, N'Attendance : Summary', N'attendance-summary', 1, CAST(N'2019-08-28T05:38:38.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (64, N'Approvals : Dispute', N'approvals-dispute', 1, CAST(N'2019-09-12T00:56:24.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (65, N'CRM - Accounts', N'accounts', 1, CAST(N'2019-09-25T00:32:18.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (66, N'Settings : Branding', N'settings-branding', 1, CAST(N'2020-02-20T12:54:13.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (67, N'Custom Leave', N'custom-leave', 1, CAST(N'2021-02-01T20:23:21.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (68, N'Payment : Payroll', N'payment-payroll', 1, CAST(N'2021-05-05T10:49:47.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (69, N'Settings : Division', N'settings-division', 1, CAST(N'2021-06-11T00:42:05.000' AS DateTime), NULL)
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (70, N'Settings : Department', N'settings-department', 1, CAST(N'2021-06-14T16:58:44.000' AS DateTime), CAST(N'2021-06-14T16:58:51.000' AS DateTime))
INSERT [dbo].[modules] ([id], [title], [tag], [status], [created_at], [updated_at]) VALUES (71, N'Settings : Section', N'settings-section', 1, CAST(N'2021-06-14T20:13:10.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[modules] OFF
GO
SET IDENTITY_INSERT [dbo].[notification] ON 

INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (58, 1, N'<strong>Julius Faigmani</strong> sent leave application that requires your approval.', N'approvals/leave', CAST(N'2021-07-13T15:39:48.217' AS DateTime), 0, CAST(N'2021-07-13T15:39:48.217' AS DateTime), CAST(N'2021-07-13T15:39:48.217' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (59, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-07-15T22:44:28.317' AS DateTime), 0, CAST(N'2021-07-15T22:44:28.317' AS DateTime), CAST(N'2021-07-15T22:44:28.317' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (1059, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-07-19T22:47:54.313' AS DateTime), 0, CAST(N'2021-07-19T22:47:54.313' AS DateTime), CAST(N'2021-07-19T22:47:54.313' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (1060, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-07-19T23:31:47.790' AS DateTime), 0, CAST(N'2021-07-19T23:31:47.790' AS DateTime), CAST(N'2021-07-19T23:31:47.790' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (1061, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-07-19T23:55:07.177' AS DateTime), 0, CAST(N'2021-07-19T23:55:07.177' AS DateTime), CAST(N'2021-07-19T23:55:07.177' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (1062, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-07-20T00:09:44.973' AS DateTime), 0, CAST(N'2021-07-20T00:09:44.973' AS DateTime), CAST(N'2021-07-20T00:09:44.973' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (1063, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-07-20T00:51:40.747' AS DateTime), 0, CAST(N'2021-07-20T00:51:40.747' AS DateTime), CAST(N'2021-07-20T00:51:40.747' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (2059, 1, N'<strong>Julius Faigmani</strong> sent shift application that requires your approval.', N'approvals/shift', CAST(N'2021-08-04T14:46:45.680' AS DateTime), 0, CAST(N'2021-08-04T14:46:45.680' AS DateTime), CAST(N'2021-08-04T14:46:45.680' AS DateTime))
INSERT [dbo].[notification] ([id], [sender], [content], [url], [date], [created_by], [created_at], [updated_at]) VALUES (2060, 1, N'<strong>Julius Faigmani</strong> approved your leave application.', N'forms/leave', CAST(N'2021-08-13T20:27:15.610' AS DateTime), 0, CAST(N'2021-08-13T20:27:15.610' AS DateTime), CAST(N'2021-08-13T20:27:15.610' AS DateTime))
SET IDENTITY_INSERT [dbo].[notification] OFF
GO
SET IDENTITY_INSERT [dbo].[notification_receiver] ON 

INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (57, 58, 1, 1, CAST(N'2021-07-13T15:39:48.237' AS DateTime), CAST(N'2021-07-13T15:39:48.237' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (58, 59, 1, 1, CAST(N'2021-07-15T22:44:28.360' AS DateTime), CAST(N'2021-07-15T22:44:28.360' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (10058, 1059, 1, 1, CAST(N'2021-07-19T22:47:54.407' AS DateTime), CAST(N'2021-07-19T22:47:54.407' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (10059, 1060, 1, 1, CAST(N'2021-07-19T23:31:47.917' AS DateTime), CAST(N'2021-07-19T23:31:47.917' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (10060, 1061, 1, 0, CAST(N'2021-07-19T23:55:07.267' AS DateTime), CAST(N'2021-07-19T23:55:07.267' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (10061, 1062, 1, 0, CAST(N'2021-07-20T00:09:45.070' AS DateTime), CAST(N'2021-07-20T00:09:45.070' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (10062, 1063, 1, 1, CAST(N'2021-07-20T00:51:40.820' AS DateTime), CAST(N'2021-07-20T00:51:40.820' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (20058, 2059, 1, 0, CAST(N'2021-08-04T14:46:45.763' AS DateTime), CAST(N'2021-08-04T14:46:45.763' AS DateTime))
INSERT [dbo].[notification_receiver] ([id], [notification_id], [user_id], [status], [created_at], [updated_at]) VALUES (20059, 2060, 1, 0, CAST(N'2021-08-13T20:27:15.630' AS DateTime), CAST(N'2021-08-13T20:27:15.630' AS DateTime))
SET IDENTITY_INSERT [dbo].[notification_receiver] OFF
GO
SET IDENTITY_INSERT [dbo].[payroll_group] ON 

INSERT [dbo].[payroll_group] ([id], [name], [company_location_id], [department_id], [status]) VALUES (2, N'Default', 1, 0, 1)
SET IDENTITY_INSERT [dbo].[payroll_group] OFF
GO
SET IDENTITY_INSERT [dbo].[payroll_period] ON 

INSERT [dbo].[payroll_period] ([id], [payroll_group_id], [period], [payroll_day], [payroll_day_from], [payroll_day_to], [created_at], [updated_at]) VALUES (1, 2, N'B', 30, 6, 20, CAST(N'2019-08-07T05:35:44.000' AS DateTime), CAST(N'2019-08-07T06:15:09.000' AS DateTime))
INSERT [dbo].[payroll_period] ([id], [payroll_group_id], [period], [payroll_day], [payroll_day_from], [payroll_day_to], [created_at], [updated_at]) VALUES (2, 2, N'A', 15, 21, 6, CAST(N'2019-08-07T05:35:44.000' AS DateTime), CAST(N'2019-08-07T06:15:20.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[payroll_period] OFF
GO
SET IDENTITY_INSERT [dbo].[positions] ON 

INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'ADMINISTRATION OFFICE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'ADMINISTRATION DIVISION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (4, N'DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (5, N'SECRETARY', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (6, N'WEIGHBRIDGE TENDER LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (7, N'WEIGHBRIDGE TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (8, N'HUMAN RESOURCES DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (9, N'HUMAN RESOURCES MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (10, N'HUMAN RESOURCES ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (11, N'HUMAN RESOURCES SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (12, N'HUMAN RESOURCES ASSOCIATE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (13, N'HUMAN RESOURCES ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (14, N'ACCOUNTING  DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (15, N'SITE ACCOUNTING MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (16, N'MANAGEMENT ACCOUNTING SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (17, N'GENERAL ACCOUNTING SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (18, N'MANAGEMENT ACCOUNTING ASSISTANT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (19, N'GENERAL ACCOUNTING ASSISTANT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (20, N'CASHIER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (21, N'GENERAL ACCOUNTING ASSOCIATE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (22, N'ASSISTANT CASHIER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (23, N'MANAGEMENT ACCOUNTING STAF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (24, N'GENERAL ACCOUNTING STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (25, N'CASHIER STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (26, N'CLERK', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (27, N' GENERAL SERVICES DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (28, N'GENERAL SERVICES DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (29, N'GENERAL SERVICES DEPARTMENT ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (30, N'GENERAL SERVICES DEPARTMENT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (31, N'DIETICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (32, N'CAMP MAINTENANCE AND HOUSEKEEPING LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (33, N'CARPOOL DISPATCHING LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (34, N'MESS OPERATION LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (35, N'FURNITURE SHOP LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (36, N'CARPENTER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (37, N'PAINTER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (38, N'PLUMBER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (39, N'FURNITURE SHOP CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (40, N'COOK', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (41, N'COMISSARY QUALITY CONTROLLER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (42, N'PROPERTY CUSTODIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (43, N'VEHICLE CUSTODIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (44, N'HOUSEKEEPING STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (45, N'CAMP MAINTENANCE CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (46, N'KITCHEN AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (47, N'LAUNDRY STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (48, N'WATER TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (49, N'ICT DEPARTMETNT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (50, N'INFORMATION AND COMMUNICATION TECHNOLOGY MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (51, N'INFORMATION AND COMMUNICATION  ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (52, N'APPLICATION AND DATABASE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (53, N'SYSTEM AND NETWORK SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (54, N'IT OPERATIONS SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (55, N'ADMINISTRATIVE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (56, N'PROJECT OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (57, N'INSTRUMENTATION AND COMMUNICATIONS ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (58, N'APPLICATION AND DATABASE ASSISTANT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (59, N'SYSTEM AND NETWORK ASSISTANT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (60, N'HELPDESK ASSISTANT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (61, N'MAINTENANCE ASSISTANT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (62, N'SYSTEM/BUSINESS ANALYST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (63, N'DATABASE/APPLICATION DEVELOPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (64, N'IT RISK/SECURITY ADMINISTRATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (65, N'SYSTEM AND DATABASE ADMINISTRATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (66, N'NETWORK ADMINISTRATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (67, N'COMPLIANCE AND GOVERNANCE OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (68, N'QUALITY ASSURANCE/QUALITY CONTROL OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (69, N'SYSTEM TEST OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (70, N'TECHNICAL DOCUMENT WRITER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (71, N'HELPDESK STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (72, N'MAINTENANCE TEAM LEADER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (73, N'TECHNICAL SUPPORT STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (74, N'ADMINISTRATIVE ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (75, N'MEDICAL DEPARTMETNT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (76, N'MEDICAL DIRECTOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (77, N'CHIEF OF CLINICS', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (78, N'COMPANY PHYSICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (79, N'PATHOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (80, N'RADIOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (81, N'HOSPITAL ADMINISTRATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (82, N'DENTIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (83, N'CHIEF NURSE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (84, N'HOSPITAL ADMINISTRATOR SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (85, N'SENIOR NURSE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (86, N'CHIEF MEDICAL TECHNOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (87, N'CHIEF PHARMACIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (88, N'MEDICAL RECORDS OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (89, N'MEDICAL TECHNOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (90, N'NURSE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (91, N'PHARMACIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (92, N'RADIOLOGIC TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (93, N'NUTRITIONIST/DIETICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (94, N'EMERGENCY MEDICAL TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (95, N'SUPPLY OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (96, N'MIDWIFE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (97, N'RADIOLOGIC TECHNICIAN ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (98, N'AMBULANCE DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (99, N'MEDICAL RECORDS ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (100, N'CASHIERING AND BILLING IN-CHARGE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
GO
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (101, N'MAINTENANCE STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (102, N'LABORATORY AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (103, N'NURSING AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (104, N'PHARMACY AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (105, N'PHILHEALTH CLERK', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (106, N'MEDICAL RECORDS FILING CLERK', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (107, N'STOREKEEPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (108, N'ENCODER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (109, N'DENTAL AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (110, N'UTILITY', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (111, N'MATERIALS CONTROL DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (112, N'MATERIALS CONTROL DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (113, N'LOGISTICS OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (114, N'MATERIALS CONTROL DEPARTMENT ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (115, N'LOGISTICS SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (116, N'WAREHOUSE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (117, N'PURCHASING SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (118, N'MATERIALS PLANNING SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (119, N'WAREHOUSE LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (120, N'LOGISTICS LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (121, N'INVENTORY ANALYST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (122, N'PURCHASING AND LOGISTICS ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (123, N'CANVASSER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (124, N'WAREHOUSE CHECKER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (125, N'WAREHOUSE MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (126, N'RECORDS LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (127, N'PURCHASING ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (128, N'MATERIALS PLANNER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (129, N'FORKLIFT OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (130, N'WAREHOUSE HELPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (131, N'TRUCK HELPER ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (132, N'SECURITY DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (133, N'SECURITY MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (134, N'EXECUTIVE OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (135, N'SECURITY ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (136, N'SENIOR SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (137, N'SITE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (138, N'UNDEGROUND PATROLLER SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (139, N'SHIFT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (140, N'GOLD ROOM SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (141, N'ROAD MONITORING SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (142, N'SECTOR SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (143, N'TRAINING/OPERATION/RESEARCH SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (144, N'UNDERGROUND PATROLLER TEAM LEADER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (145, N'SHIFT IN CHARGE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (146, N'RESEARCH ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (147, N'INVESTIGATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (148, N'K9 TEAM LEADER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (149, N'K9 HANDLER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (150, N'CCTV OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (151, N'RADIO OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (152, N'LOG ASSISTANT/VERIFIER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (153, N'ID FABRICATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (154, N'OPERATIONS/TRAINING CLERK', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (155, N'OPERATIONS/TRAINING ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (156, N'CASE CUSTODIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (157, N'ALERT TEAM DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (158, N'ALERT TEAM MEMBER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (159, N'COMPANY GUARD ON POST ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (160, N'GOLD ROOM GUARD', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (161, N'ROAD MONITORING GUARD', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (162, N'INSPECTION TEAM MEMBER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (163, N'EXPLORATION DIVISION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (164, N'CHIEF GEOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (165, N'SENIOR GEOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (166, N'PROJECT GEOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (167, N'GEOGRAPHIC INFORMATION SYSTEM MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (168, N'GEODETIC ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (169, N'GEOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (170, N'CORE FARM SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (171, N'SENIOR MAPPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (172, N'GEOGRAPHIC INFORMATION SYSTEM DATABASE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (173, N'GEOGRAPHIC INFORMATION SYSTEM SPECIALIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (174, N'CORE FARM MAINTENANCE STAFF', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (175, N'ELECTRICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (176, N'EXPEDITER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (177, N'INSTRUMENTATION TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (178, N'MAPPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (179, N'GEOGRAPHIC INFORMATION SYSTEM TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (180, N'SURVEY AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (181, N'FIELD AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (182, N'MILL DIVISION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (183, N'MILL OPERATION DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (184, N'MILL METALLURGY DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (185, N'MILL MAINTENANCE DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (186, N'ASSISTANT MILL OPERATION DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (187, N'ASSISTANT MILL METALLURGY DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (188, N'ASSISTANT MILL MECHANICAL DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (189, N'ASSISTANT MILL ELECTRICAL AND INSTRUMENTATION DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (190, N'METALLURGIC ENGINEER SHIFT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (191, N'TAILING STORAGE FACILITY SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (192, N'PLANT METALLURGIC ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (193, N'REFINERY METALLURGIC ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (194, N'PROCESS METALLURGIC ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (195, N'RESEARCH METALLURGIC ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (196, N'MECHANICAL MAINTENANCE ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (197, N'MECHANICAL PLANNER ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (198, N'ELECTRICAL AND INSTRUMENTATION ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (199, N'PLANT SYSTEM SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (200, N'ELECTRICAL SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
GO
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (201, N'TAILING STORAGE FACILITY FOREMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (202, N'GOLD ROOM FOREMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (203, N'METALLURGIC ACCOUNTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (204, N'REFINERY MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (205, N'PROCESS CONTROL TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (206, N'METALLURGIC LABORATORY TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (207, N'AUTOCAD OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (208, N'SEMI-AUTOGENOUS MILL LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (209, N'LOADER OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (210, N'MAINTENANCE LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (211, N'INVENTORY LEADMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (212, N'CONTROL ROOM OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (213, N'STRIPPING OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (214, N'MACHINIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (215, N'BOBCAT OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (216, N'JAW CRUSHER OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (217, N'COMPRESSOR OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (218, N'THICKENER OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (219, N'INTENSIVE LEACH REACTOR OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (220, N'DAM AND FLUME LINE MAINTENANCE CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (221, N'MECHANIC REPAIR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (222, N'MILL EXPEDITER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (223, N'TRUCK DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (224, N'MATERIALS CONTROLLER ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (225, N'CARBON REGENERATION OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (226, N'WELDER FABRICATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (227, N'WELDER MECHANIC', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (228, N'DOCUMENT CONTROLLER CLERK', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (229, N'SEMI-AUTOGENOUS MILL LUBRICATION MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (230, N'LEACH TANK MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (231, N'CARBON-IN-LEACH TANK MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (232, N'DETOX OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (233, N'TAILING STORAGE FACILITY MONITORING AND WATER TREATMENT CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (234, N'REAGENT PREPERATION MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (235, N'METALLURGIC LABORATORY AIDE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (236, N'LUBE MAN MILL', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (237, N'CYCLONE OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (238, N'POTABLE WATER TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (239, N'CONVEYOR OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (240, N'COB/LIME MAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (241, N'TRASH SCREEN TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (242, N'TAILING STORAGE FACILITY PROJECTS CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (243, N'TOOLKEEPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (244, N'TECHNICAL SERVICES ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (245, N'ENGINEERING AND CONSTRUCTION SERVICES DIVISION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (246, N'CLERK ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (247, N'CIVIL WORKS DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (248, N'CIVIL WORKS DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (249, N'CIVIL WORKS ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (250, N'MAINTENANCE PLANNER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (251, N'SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (252, N'CIVIL WORKS LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (253, N'HEAVY EQUIPMENT OPERATOR ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (254, N'INSTRUMENT MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (255, N'DRAFTSMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (256, N'LOW BED OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (257, N'DUMP TRUCK DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (258, N'MASON', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (259, N'WELDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (260, N'ROAD INSPECTOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (261, N'CONSTRUCTION HELPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (262, N'DRIVER HELPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (263, N'ELECTRICAL SERVICES', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (264, N'ELECTRICAL SERVICES DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (265, N'ELECTRICAL SERVICES DEPARTMENT ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (266, N'POWER LINE ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (267, N'ELECTRICAL MAINTENANCE ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (268, N'MECHANICAL MAINTENANCE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (269, N'POWER LINE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (270, N'FABRICATION SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (271, N'ELECTRICAL MAINTENANCE SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (272, N'POWER LINE LEADMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (273, N'FABRICATOR LEADMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (274, N'ELECTRICAL MAINTENANCE LEADMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (275, N'POWERHOUSE MAINTENANCE LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (276, N'GROUND MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (277, N'LINEMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (278, N'ELECTRICIAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (279, N'FABRICATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (280, N'REWINDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (281, N'AIRCON TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (282, N'MECHANICAL TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (283, N'FABRICATOR HELPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (284, N'REPEATER TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (285, N'MOTORPOOL', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (286, N'MOTORPOOL DEPARTMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (287, N'MOTORPOOL ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (288, N'SHOP MECHANICAL ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (289, N'LEADMAN OPERATIONS', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (290, N'MECHANIC', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (291, N'AUTO ELECTRICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (292, N'TIRE MAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (293, N'SHOP HELPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (294, N'EXECUTIVE ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (295, N'EXECUTIVE DIVISION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (296, N'HEAD EXECUTIVE ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (297, N'CORPORATE SOCIAL RESPONSIBILITY OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (298, N'EXECUTIVE ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (299, N'LOSS CONTROL ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (300, N'LOSS CONTROL  MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
GO
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (301, N'LOSS CONTROL ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (302, N'QUALITY ASSURANCE/QUALITY CONTROL', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (303, N'TECHNICAL AND QUALITY MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (304, N'CHIEF CHEMIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (305, N'QUALITY ASSURANCE OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (306, N'ASSISTANT QUALITY ASSURANCE OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (307, N'QUALITY CONTROL SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (308, N'ASSISTANT QUALITY CONTROL SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (309, N'QUALITY ASSURANCE/QUALITY CONTROL ANALYST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (310, N'QUALITY ASSURANCE/QUALITY CONTROL TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (311, N'FIRE ASSAYER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (312, N'SAMPLE PREPARATION OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (313, N'ASSISTANT SAMPLE PREPARATION OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (314, N'TENEMENT, LICENSING AND COMMUNITY RELATION', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (315, N'TENEMENT, LICENSING AND COMMUNITY RELATIONS MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (316, N'COMMUNITY RELATIONS OFFICER I', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (317, N'TENEMENT OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (318, N'COMMUNITY RELATION OFFICER II', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (319, N'INFORMATION, EDUCATION, COMMUNICATION OFFICER ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (320, N'INFORMATION, EDUCATION, COMMUNICATION ASSISTANT OFFICER ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (321, N'PUBLIC RELATION ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (322, N'TENEMENT ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (323, N'PERMITTING ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (324, N'REAL PROPERTY MANAGEMENT ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (325, N'COMMUNITY COORDINATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (326, N'BOOKEEPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (327, N'REAL PROPERTY GUARD', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (328, N'SAFETY DEPARTMENT ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (329, N'SAFETY MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (330, N'SAFETY SECTION HEAD', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (331, N'SAFETY ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (332, N'TRAINING OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (333, N'SAFETY SHIFT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (334, N'ASSISTANT TRAINING OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (335, N'SAFETY INSPECTOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (336, N'SIGN PAINTER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (337, N'FIRE TRUCK DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (338, N'UTILITY (MILL)', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (339, N'ENVIRONMENTAL DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (340, N'ENVIRONMENT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (341, N'ENVIRONMENT ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (342, N'ENVIRONMENT OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (343, N'PLANTATION & NURSERY SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (344, N'ENVIRONMENT MANAGEMENT SYSTEM COMPLIANCE OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (345, N'WATER TREATMENT SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (346, N'DOCUMENT AND MAPPING SUPERVISOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (347, N'ASSISTANT ENVIRONMENT OFFICER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (348, N'SKIDSTER OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (349, N'MINI DUMP TRUCK DRIVER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (350, N'SPECIAL PROJECTS COORDINATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (351, N'WATER TREATMENT LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (352, N'PLANTATION AND NURSERY LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (353, N'NURSERY LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (354, N'ENVIRONMENT PROJECT WORKFORCE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (355, N'PLANTATION AND MAINTENANCE LEADMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (356, N'ENVIRONMENT MANAGEMENT SYSTEM DOCUMENT CONTROLLER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (357, N'WATER TREATMENT CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (358, N'RUBBER MAINTENANCE CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (359, N'DOCUMENT AND MAPPING CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (360, N'MATERIAL RECOVERY FACILITY MAINTENANCE CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (361, N'PLANTATION & MAINTENANCE CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (362, N'NURSERY CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (363, N'SPECIAL PROJECTS CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (364, N'LEGAL DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (365, N'CORPORATE LEGAL COUNSEL', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (366, N'ASSOCIATE LAWYER - CORPORATE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (367, N'PARALEGAL - CORPORATE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (368, N'LEGAL ASSISTANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (369, N'ENGINEERING DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (370, N'MINE ENGINEERING AND PLANNING MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (371, N'LONG RANGE MINE PLANNING MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (372, N'SHORT RANGE MINE PLANNING MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (373, N'SENIOR MECHANICAL ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (374, N'SENIOR MINING ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (375, N'SENIOR PLANNING ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (376, N'MINING ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (377, N'MECHANICAL ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (378, N'SURVEYOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (379, N'MINE ENGINEERING CMMS PLANNER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (380, N'FOREMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (381, N'MINE ACCOUNTS COORDINATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (382, N'MINE CONTRACTS COORDINATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (383, N'LEADMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (384, N'ASSISTANT MINE CONTRACTS COORDINATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (385, N'PIPEMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (386, N'DEWATERING CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (387, N'PUMP ASSEMBLER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (388, N'VENTILATION CREW', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (389, N'PUMP TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (390, N'GEOLOGY DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (391, N'MINE GEOLOGY MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (392, N'MINE GEOLOGY ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (393, N'CADET GEOLOGIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (394, N'LEADMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (395, N'GEOLOGIC MAPPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (396, N'CORE CHECKER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (397, N'COREHOUSE ATTENDANT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (398, N'SAMPLER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (399, N'ELECTRICAL DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (400, N'MINE SUPPORT SERVICES MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
GO
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (401, N'MINE ELECTRICAL MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (402, N'SYSTEM AUTOMATION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (403, N'MINE ELECTRICAL ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (404, N'ELECTRICAL ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (405, N'ELECTRONICS ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (406, N'POWERHOUSE TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (407, N'TECHNICIAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (408, N'CAP LAMP REPAIRMEN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (409, N'SUBSTATION TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (410, N'COMPRESSOR TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (411, N'CAP LAMP TENDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (412, N'MECHANICAL DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (413, N'MINE MECHANICAL MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (414, N'MINE MECHANICAL ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (415, N'LOCOMOTIVE MAINTENANCE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (416, N'FABRICATOR WELDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (417, N'FABRICATOR MACHINIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (418, N'REBONDER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (419, N'EXPLOSIVES DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (420, N'MINE EXPLOSIVES MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (421, N'MINE EXPLOSIVES ASSISTANT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (422, N'CRIMPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (423, N'STOCK INVENTORY CHECKER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (424, N'STOCKMAN ', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (425, N'OPERATIONS DEPARTMENT', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (426, N'MINE PRODUCTION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (427, N'SHAFTS MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (428, N'LIFT MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (429, N'SHAFT COMMUNICATION/OPERATION SPECIALIST', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (430, N'LEVEL MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (431, N'ASSISTANT LEVEL MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (432, N'SHAFT ENGINEER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (433, N'CLASS A MINER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (434, N'SHIFT COMMUNICATION OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (435, N'WINDER OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (436, N'LOCOMOTIVE OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (437, N'TRACK MAINTENANCE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (438, N'CHAINSAW OPERATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (439, N'HELPER MINER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (440, N'LOCOMOTIVE BRAKEMAN', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (441, N'CHAINSAW HELPER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (442, N'MINE ADMINISTRATION OFFICE', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (443, N'MINE DIVISION MANAGER', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
INSERT [dbo].[positions] ([id], [name], [createdAt], [updatedAt]) VALUES (444, N'MINE UNION COORDINATOR', CAST(N'2021-06-17T12:51:57.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[positions] OFF
GO
SET IDENTITY_INSERT [dbo].[positions_category] ON 

INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'CADET', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'HS1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'HS2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (4, N'HS3', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (5, N'L1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (6, N'L2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (7, N'S1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (8, N'S2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (9, N'S3', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (10, N'S4', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (11, N'SK1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (12, N'SK2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (13, N'SK3', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (14, N'SP1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (15, N'SP2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (16, N'SP3', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (17, N'SS1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (18, N'SS2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (19, N'SS3', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (20, N'T1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (21, N'T2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (22, N'T3', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (23, N'T4', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (24, N'US1', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
INSERT [dbo].[positions_category] ([id], [name], [createdAt], [updatedAt]) VALUES (25, N'US2', CAST(N'2021-06-17T12:58:50.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[positions_category] OFF
GO
SET IDENTITY_INSERT [dbo].[positions_classification] ON 

INSERT [dbo].[positions_classification] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'Rank and File', CAST(N'2021-06-17T12:58:04.000' AS DateTime), NULL)
INSERT [dbo].[positions_classification] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'Supervisory', CAST(N'2021-06-17T12:58:04.000' AS DateTime), NULL)
INSERT [dbo].[positions_classification] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'Managerial', CAST(N'2021-06-17T12:58:04.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[positions_classification] OFF
GO
SET IDENTITY_INSERT [dbo].[role] ON 

INSERT [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (1, N'Administrator', N'super-admin', 1, 0, 1, CAST(N'2019-07-03T05:48:38.000' AS DateTime), CAST(N'2019-08-07T04:25:04.000' AS DateTime))
INSERT [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (2, N'HR Admin', N'hr-admin', 1, 0, 1, CAST(N'2019-07-03T05:50:18.000' AS DateTime), CAST(N'2019-08-01T04:44:22.000' AS DateTime))
INSERT [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (3, N'Payroll Admin', N'payroll-admin', 1, 0, NULL, CAST(N'2019-07-03T05:50:24.000' AS DateTime), CAST(N'2019-08-01T04:44:29.000' AS DateTime))
INSERT [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (4, N'Default User', N'default-user', 1, 0, 1, CAST(N'2019-07-03T05:50:36.000' AS DateTime), CAST(N'2019-08-01T04:44:35.000' AS DateTime))
INSERT [dbo].[role] ([id], [label], [slug], [status], [created_by], [updated_by], [created_at], [updated_at]) VALUES (8, N'Manager', N'manager', 1, 1, 1, CAST(N'2019-07-04T01:46:13.000' AS DateTime), CAST(N'2019-08-01T04:44:37.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[role] OFF
GO
SET IDENTITY_INSERT [dbo].[role_permission] ON 

INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (104, 1, N'appraisal-consolidation', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-03T00:42:38.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (105, 1, N'appraisal-promotion', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (106, 1, N'appraisal-initiation', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (107, 1, N'appraisal-feedback', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (108, 1, N'appraisal-transfer', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (109, 1, N'approvals-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (110, 1, N'approvals-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (111, 1, N'approvals-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-09-26T03:34:22.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (112, 1, N'approvals-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (113, 1, N'attendance-absence', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (114, 1, N'approvals-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (115, 1, N'attendance-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (116, 1, N'attendance-biometric', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (117, 1, N'attendance-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (118, 1, N'attendance-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (119, 1, N'employee-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (120, 1, N'employee-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (121, 1, N'employee-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (122, 1, N'employee-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (123, 1, N'employee-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:45.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (124, 1, N'employee-attendance', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:07:25.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (125, 1, N'employee-detail', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (126, 1, N'employee-document', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:21:32.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (127, 1, N'employee-list', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-03T00:48:00.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (128, 1, N'employee-loan', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:18:09.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (129, 1, N'employee-salary', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:14:11.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (130, 1, N'employee-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-09-26T03:34:22.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (131, 1, N'forms-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (132, 1, N'forms-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (133, 1, N'forms-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (134, 1, N'forms-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (135, 1, N'forms-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-09-26T03:34:22.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (136, 1, N'forms-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (137, 1, N'payment-arrear', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (138, 1, N'payment-salary', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (139, 1, N'payment-settlement', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (140, 1, N'payment-earning', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (141, 1, N'recruitment-joining', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T06:03:04.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (142, 1, N'recruitment-candidate-profile', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:42:20.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (143, 1, N'payment-loan', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (144, 1, N'recruitment-rating', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:50:55.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (145, 1, N'recruitment-schedule', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T05:47:46.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (146, 1, N'reliving-interview', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (147, 1, N'reliving-formality', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (148, 1, N'settings-biometric', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T06:55:43.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (149, 1, N'settings-approvers', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-09-14T02:34:08.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (150, 1, N'reliving-resignation', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-01T23:10:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (151, 1, N'settings-branch', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T06:35:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (152, 1, N'settings-company', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T06:32:20.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (153, 1, N'settings-holidays', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T06:53:03.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (154, 1, N'settings-role', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T07:01:17.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (155, 1, N'settings-taxonomy', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:05:46.000' AS DateTime), CAST(N'2019-08-02T06:47:50.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (156, 2, N'appraisal-feedback', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (157, 2, N'appraisal-consolidation', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (158, 2, N'approvals-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (159, 2, N'approvals-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (160, 2, N'appraisal-transfer', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (161, 2, N'approvals-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (162, 2, N'approvals-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (163, 2, N'appraisal-promotion', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (164, 2, N'attendance-biometric', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (165, 2, N'attendance-absence', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (166, 2, N'approvals-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (167, 2, N'attendance-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (168, 2, N'attendance-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (169, 2, N'attendance-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (170, 2, N'employee-detail', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (171, 2, N'employee-attendance', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (172, 2, N'employee-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (173, 2, N'employee-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (174, 2, N'employee-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (175, 2, N'appraisal-initiation', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (176, 2, N'employee-document', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (177, 2, N'employee-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (178, 2, N'employee-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (179, 2, N'employee-list', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (180, 2, N'employee-loan', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (181, 2, N'forms-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (182, 2, N'forms-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (183, 2, N'forms-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (184, 2, N'employee-salary', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (185, 2, N'employee-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (186, 2, N'forms-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (187, 2, N'forms-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (188, 2, N'forms-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (189, 2, N'payment-arrear', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (190, 2, N'payment-salary', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (191, 2, N'recruitment-schedule', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (192, 2, N'payment-earning', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (193, 2, N'recruitment-joining', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (194, 2, N'recruitment-rating', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (195, 2, N'payment-settlement', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (196, 2, N'payment-loan', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (197, 2, N'recruitment-candidate-profile', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (198, 2, N'settings-taxonomy', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (199, 2, N'reliving-resignation', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (200, 2, N'settings-holidays', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (201, 2, N'settings-company', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (202, 2, N'settings-branch', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
GO
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (203, 2, N'reliving-interview', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (204, 2, N'settings-approvers', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (205, 2, N'reliving-formality', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (206, 2, N'settings-role', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:36:42.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (207, 2, N'settings-biometric', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:11:26.000' AS DateTime), CAST(N'2019-08-01T23:11:26.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (208, 4, N'appraisal-consolidation', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (209, 4, N'appraisal-feedback', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (210, 4, N'appraisal-initiation', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (211, 4, N'appraisal-promotion', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (212, 4, N'appraisal-transfer', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (213, 4, N'approvals-business-trip', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (214, 4, N'approvals-leave', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (215, 4, N'approvals-overtime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (216, 4, N'approvals-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (217, 4, N'approvals-undertime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (218, 4, N'attendance-absence', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (219, 4, N'attendance-biometric', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (220, 4, N'attendance-leave', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (221, 4, N'attendance-overtime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (222, 4, N'attendance-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (223, 4, N'employee-business-trip', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (224, 4, N'employee-dispute', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (225, 4, N'employee-leave', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (226, 4, N'employee-overtime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (227, 4, N'employee-undertime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (228, 4, N'employee-attendance', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (229, 4, N'employee-detail', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (230, 4, N'employee-document', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (231, 4, N'employee-loan', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (232, 4, N'employee-list', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (233, 4, N'employee-salary', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (234, 4, N'employee-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (235, 4, N'forms-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (236, 4, N'forms-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (237, 4, N'forms-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (238, 4, N'forms-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (239, 4, N'forms-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (240, 4, N'forms-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (241, 4, N'payment-arrear', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (242, 4, N'payment-salary', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (243, 4, N'payment-earning', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (244, 4, N'payment-settlement', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (245, 4, N'recruitment-candidate-profile', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (246, 4, N'payment-loan', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (247, 4, N'recruitment-joining', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (248, 4, N'recruitment-rating', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (249, 4, N'recruitment-schedule', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (250, 4, N'reliving-interview', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:30.000' AS DateTime), CAST(N'2019-08-01T23:33:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (251, 4, N'reliving-formality', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (252, 4, N'reliving-resignation', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (253, 4, N'settings-approvers', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (254, 4, N'settings-biometric', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (255, 4, N'settings-branch', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (256, 4, N'settings-company', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (257, 4, N'settings-role', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (258, 4, N'settings-holidays', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (259, 4, N'settings-taxonomy', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:33:31.000' AS DateTime), CAST(N'2019-08-01T23:33:31.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (260, 8, N'appraisal-consolidation', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:12.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (261, 8, N'appraisal-feedback', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:12.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (262, 8, N'appraisal-initiation', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:12.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (263, 8, N'appraisal-promotion', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:12.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (264, 8, N'appraisal-transfer', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:12.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (265, 8, N'approvals-business-trip', 1, 0, 1, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:39.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (266, 8, N'approvals-leave', 1, 0, 1, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:39.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (267, 8, N'approvals-overtime', 1, 0, 1, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:39.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (268, 8, N'approvals-shift', 1, 0, 1, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:39.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (269, 8, N'approvals-undertime', 1, 0, 1, 0, NULL, NULL, CAST(N'2019-08-01T23:35:12.000' AS DateTime), CAST(N'2019-08-01T23:35:39.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (270, 8, N'attendance-absence', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (271, 8, N'attendance-biometric', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (272, 8, N'attendance-leave', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (273, 8, N'attendance-overtime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (274, 8, N'attendance-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (275, 8, N'employee-business-trip', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (276, 8, N'employee-dispute', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (277, 8, N'employee-leave', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (278, 8, N'employee-overtime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (279, 8, N'employee-undertime', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (280, 8, N'employee-attendance', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (281, 8, N'employee-detail', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (282, 8, N'employee-document', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (283, 8, N'employee-list', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (284, 8, N'employee-loan', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (285, 8, N'employee-salary', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (286, 8, N'employee-shift', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (287, 8, N'forms-business-trip', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (288, 8, N'forms-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (289, 8, N'forms-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (290, 8, N'forms-overtime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (291, 8, N'forms-shift', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (292, 8, N'forms-undertime', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (293, 8, N'payment-adjustment', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-09-11T21:02:29.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (294, 8, N'payment-salary', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (295, 8, N'payment-dispute', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-09-11T23:11:16.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (296, 8, N'payment-settlement', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (297, 8, N'payment-loan', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (298, 8, N'recruitment-candidate-profile', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (299, 8, N'recruitment-joining', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (300, 8, N'recruitment-rating', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (301, 8, N'recruitment-schedule', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (302, 8, N'reliving-interview', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
GO
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (303, 8, N'reliving-formality', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (304, 8, N'reliving-resignation', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (305, 8, N'settings-approvers', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (306, 8, N'settings-biometric', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (307, 8, N'settings-branch', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (308, 8, N'settings-company', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (309, 8, N'settings-holidays', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (310, 8, N'settings-role', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (311, 8, N'settings-taxonomy', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-08-01T23:35:13.000' AS DateTime), CAST(N'2019-08-01T23:35:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (312, 1, N'employee-config', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-02T05:29:40.000' AS DateTime), CAST(N'2019-08-14T22:29:36.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (313, 1, N'settings-configuration', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-02T06:27:45.000' AS DateTime), CAST(N'2019-08-02T06:28:56.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (314, 1, N'appraisal-increment', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-03T00:42:38.000' AS DateTime), CAST(N'2019-08-03T00:42:38.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (315, 1, N'settings-leave-policy', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-03T04:26:38.000' AS DateTime), CAST(N'2019-09-20T05:00:42.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (316, 1, N'employee-leave-credit', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-06T06:24:35.000' AS DateTime), CAST(N'2019-08-06T06:24:35.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (318, 1, N'employee-role', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-16T22:18:53.000' AS DateTime), CAST(N'2019-09-11T23:13:05.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (319, 1, N'announcement', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-18T00:09:13.000' AS DateTime), CAST(N'2019-08-18T00:09:13.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (320, 1, N'attendance-summary', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-08-28T05:38:47.000' AS DateTime), CAST(N'2019-08-28T05:38:47.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (321, 1, N'payment-adjustment', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-09-11T21:02:59.000' AS DateTime), CAST(N'2019-09-11T21:02:59.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (322, 1, N'payment-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-09-11T23:13:06.000' AS DateTime), CAST(N'2019-09-11T23:13:06.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (323, 1, N'approvals-dispute', 1, 1, 1, 1, NULL, NULL, CAST(N'2019-09-12T00:56:49.000' AS DateTime), CAST(N'2019-09-12T00:56:49.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (324, 1, N'accounts', 0, 0, 0, 0, NULL, NULL, CAST(N'2019-09-25T00:32:39.000' AS DateTime), CAST(N'2019-09-26T03:34:22.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (325, 1, N'settings-branding', 1, 1, 1, 1, NULL, NULL, CAST(N'2020-02-20T12:54:43.000' AS DateTime), CAST(N'2020-02-20T12:54:43.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (326, 1, N'custom-leave', 1, 1, 1, 1, NULL, NULL, CAST(N'2021-02-01T20:25:47.000' AS DateTime), CAST(N'2021-02-01T20:25:47.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (327, 1, N'payment-payroll', 1, 1, 1, 1, NULL, NULL, CAST(N'2021-05-05T10:50:22.000' AS DateTime), CAST(N'2021-05-05T10:50:22.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (328, 1, N'settings-division', 1, 1, 1, 1, NULL, NULL, CAST(N'2021-06-11T00:43:30.000' AS DateTime), CAST(N'2021-06-11T00:43:30.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (329, 1, N'settings-department', 1, 1, 1, 1, NULL, NULL, CAST(N'2021-06-14T16:59:18.000' AS DateTime), CAST(N'2021-06-14T16:59:18.000' AS DateTime))
INSERT [dbo].[role_permission] ([id], [role_id], [module_tag], [read], [write], [modify], [delete], [created_by], [updated_by], [created_at], [updated_at]) VALUES (330, 1, N'settings-section', 1, 1, 1, 1, NULL, NULL, CAST(N'2021-06-14T20:16:45.000' AS DateTime), CAST(N'2021-06-14T20:16:45.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[role_permission] OFF
GO
SET IDENTITY_INSERT [dbo].[salary] ON 

INSERT [dbo].[salary] ([id], [user_id], [start_date], [end_date], [amount], [mode], [payroll], [created_at], [updated_at]) VALUES (1, 2, CAST(N'2019-10-30' AS Date), CAST(N'2020-10-31' AS Date), 20000, 0, 2, CAST(N'2019-10-30T11:05:28.000' AS DateTime), CAST(N'2019-10-30T11:05:56.000' AS DateTime))
INSERT [dbo].[salary] ([id], [user_id], [start_date], [end_date], [amount], [mode], [payroll], [created_at], [updated_at]) VALUES (92, 1, CAST(N'2021-01-01' AS Date), NULL, 45000, 0, 2, CAST(N'2021-02-03T17:15:06.000' AS DateTime), CAST(N'2021-02-03T17:15:06.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[salary] OFF
GO
SET IDENTITY_INSERT [dbo].[sections] ON 

INSERT [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (1, 1, N'AB Sections', N'AB', 2, 2, 2, N'test', 1, NULL, CAST(N'2021-06-14T20:29:12.000' AS DateTime), CAST(N'2021-06-14T20:32:51.000' AS DateTime))
INSERT [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (2, 6, N'CD Section', N'CD', 2, 2, 1, N'Test', 1, NULL, CAST(N'2021-06-14T20:31:34.000' AS DateTime), CAST(N'2021-06-14T20:33:17.000' AS DateTime))
INSERT [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (3, 2, N'GH Section', N'GH', 1, 2, 2, N'test', 1, NULL, CAST(N'2021-06-14T20:40:40.000' AS DateTime), CAST(N'2021-06-14T20:40:40.000' AS DateTime))
INSERT [dbo].[sections] ([id], [department_id], [section_name], [section_code], [supervisor_id], [assistant_supervisor_id], [secretary_id], [description], [status], [deletedAt], [createdAt], [updatedAt]) VALUES (4, 1, N'EF Section', N'EF', 1, 1, 1, N'test test', 1, NULL, CAST(N'2021-06-14T20:40:40.000' AS DateTime), CAST(N'2021-06-14T20:40:40.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[sections] OFF
GO
SET IDENTITY_INSERT [dbo].[shift_type] ON 

INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (1, N'12 TO 8PM', N'12PM TO 8PM', N'STANDARD', CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 26, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (2, N'1st SHIFT', N'SHIFT 1 (11PM - 7AM)', N'STANDARD', CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'01:01:00' AS Time), CAST(N'05:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 1, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (3, N'1ST SHIFT (12:30AM - 8:30AM)', N'12:30 AM - 8:30 AM', N'STANDARD', NULL, NULL, CAST(N'00:30:00' AS Time), CAST(N'08:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'02:31:00' AS Time), CAST(N'06:31:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 54, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (4, N'1ST SHIFT (12am-8am)', N'12 AM - 8 AM', N'STANDARD', CAST(N'00:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'00:00:00' AS Time), CAST(N'08:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'02:01:00' AS Time), CAST(N'06:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 48, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (5, N'1ST SHIFT (1AM-9AM)', N'1 AM - 9 AM', N'STANDARD', CAST(N'01:00:00' AS Time), CAST(N'09:00:00' AS Time), CAST(N'01:00:00' AS Time), CAST(N'09:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'03:01:00' AS Time), CAST(N'07:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 51, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (6, N'1st SHIFT GEO', N'11:30pm - 7:30am', N'STANDARD', CAST(N'23:30:00' AS Time), CAST(N'07:30:00' AS Time), CAST(N'23:30:00' AS Time), CAST(N'07:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 43, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (7, N'2ND SHIFT', N'SHIFT 2 (7AM - 3 PM)', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'09:01:00' AS Time), CAST(N'13:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 2, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (8, N'2ND SHIFT (8:30AM-4:30PM)', N'8:30AM - 4:30PM', N'STANDARD', NULL, NULL, CAST(N'08:30:00' AS Time), CAST(N'16:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'10:31:00' AS Time), CAST(N'14:31:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 55, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (9, N'2ND SHIFT (9AM-5PM)', N'9 AM - 5 PM', N'STANDARD', CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'11:01:00' AS Time), CAST(N'15:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 52, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (10, N'2nd SHIFT GEO', N'7:30am - 3:30pm', N'STANDARD', CAST(N'07:30:00' AS Time), CAST(N'15:30:00' AS Time), CAST(N'07:30:00' AS Time), CAST(N'15:30:00' AS Time), 0, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 44, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (11, N'2ND SHIFT(8AM-4PM)', N'8 AM - 4 PM', N'STANDARD', CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'10:01:00' AS Time), CAST(N'14:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 49, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (12, N'3RD SHIFT', N'SHIFT 3 (3PM - 11 PM)', N'STANDARD', CAST(N'15:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'23:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'17:01:00' AS Time), CAST(N'21:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 3, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (13, N'3RD SHIFT (4:30PM - 12:30AM)', N'4:30PM - 12:30AM', N'STANDARD', NULL, NULL, CAST(N'16:30:00' AS Time), CAST(N'00:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'18:31:00' AS Time), CAST(N'22:31:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 56, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (14, N'3RD SHIFT (4PM-12AM)', N'4 PM - 12 AM', N'STANDARD', CAST(N'16:00:00' AS Time), CAST(N'00:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'00:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'18:01:00' AS Time), CAST(N'22:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 50, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (15, N'3RD SHIFT (5PM-1AM)', N'5 PM - 1 AM', N'STANDARD', CAST(N'17:00:00' AS Time), CAST(N'01:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'01:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'19:01:00' AS Time), CAST(N'23:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 53, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (16, N'3rd SHIFT GEO', N'3:30pm - 11:30pm', N'STANDARD', CAST(N'15:30:00' AS Time), CAST(N'23:30:00' AS Time), CAST(N'15:30:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 45, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (17, N'8AM TO 4PM', N'8AM TO 4PM', N'STANDARD', CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 27, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (18, N'8PM TO 4AM', N'8PM TO 4AM', N'STANDARD', CAST(N'20:00:00' AS Time), CAST(N'04:00:00' AS Time), CAST(N'20:00:00' AS Time), CAST(N'04:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 28, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (19, N'BUS DRIVER 1', N'Bus Driver 1 (4AM - 12 PM)', N'STANDARD', CAST(N'04:00:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'04:00:00' AS Time), CAST(N'12:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'06:01:00' AS Time), CAST(N'08:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, 0, 8, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (20, N'BUS DRIVER 2', N'Bus Driver 2 (2PM - 10 PM)', N'STANDARD', CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'16:01:00' AS Time), CAST(N'20:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, 0, 9, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (21, N'Gen Services 1', N'Gen Serv 1 (3AM - 1PM)', N'STANDARD', CAST(N'03:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'03:00:00' AS Time), CAST(N'13:00:00' AS Time), 5, CAST(N'09:00:00' AS Time), CAST(N'08:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'05:01:00' AS Time), CAST(N'11:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 10, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (22, N'Gen Services 2', N'Gen Serv 2 (4AM - 1PM)', N'STANDARD', CAST(N'04:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'04:00:00' AS Time), CAST(N'13:00:00' AS Time), 5, CAST(N'10:00:00' AS Time), CAST(N'09:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'06:01:00' AS Time), CAST(N'11:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 11, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (23, N'Gen Services 3', N'Gen Serv 3 (8AM - 6PM)', N'STANDARD', CAST(N'08:00:00' AS Time), CAST(N'18:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'18:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'10:01:00' AS Time), CAST(N'16:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 12, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (24, N'Gen Services 4', N'Gen Serv 4 (11AM - 8PM)', N'STANDARD', CAST(N'11:00:00' AS Time), CAST(N'20:00:00' AS Time), CAST(N'11:00:00' AS Time), CAST(N'20:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'13:01:00' AS Time), CAST(N'18:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 13, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (25, N'Gen Services 5', N'Gen Serv 5 (7AM - 5PM)', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'09:01:00' AS Time), CAST(N'15:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 14, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (26, N'Gen Services 6', N'Gen Serv 6 (1PM - 9PM)', N'STANDARD', CAST(N'13:00:00' AS Time), CAST(N'21:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'21:00:00' AS Time), 5, CAST(N'18:00:00' AS Time), CAST(N'17:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'15:01:00' AS Time), CAST(N'19:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 15, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (27, N'HALFDAY AM', N'7:00 AM - 12:00 PM', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), 5, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 19, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (28, N'HALFDAY PM', N'1:00 PM - 5:00 PM', N'STANDARD', CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 20, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (29, N'LEVEL 6 1', N'1ST SHIFT', N'STANDARD', NULL, NULL, CAST(N'22:30:00' AS Time), CAST(N'06:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'00:31:00' AS Time), CAST(N'04:31:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 40, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (30, N'LEVEL 6 2', N'2ND SHIFT', N'STANDARD', NULL, NULL, CAST(N'06:30:00' AS Time), CAST(N'14:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'08:31:00' AS Time), CAST(N'12:31:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 41, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (31, N'LEVEL 6 3', N'3RD SHIFT', N'STANDARD', NULL, NULL, CAST(N'14:30:00' AS Time), CAST(N'22:30:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'16:31:00' AS Time), CAST(N'20:31:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 42, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (32, N'LEVEL 8 SHAFT 1', N'1ST SHIFT', N'STANDARD', NULL, NULL, CAST(N'21:00:00' AS Time), CAST(N'05:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'23:01:00' AS Time), CAST(N'03:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 36, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (33, N'LEVEL 8 SHAFT 2', N'2ND SHIFT', N'STANDARD', NULL, NULL, CAST(N'05:00:00' AS Time), CAST(N'13:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'07:01:00' AS Time), CAST(N'11:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 37, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (34, N'LEVEL 8 SHAFT 3', N'3RD SHIFT', N'STANDARD', NULL, NULL, CAST(N'13:00:00' AS Time), CAST(N'21:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'15:01:00' AS Time), CAST(N'19:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 39, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (35, N'NON-SHIFTER', N'REGULAR (7AM - 4PM)', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'16:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'09:00:01' AS Time), CAST(N'14:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 4, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (36, N'NON-SHIFTER1', N'REGULAR (7AM - 5PM)', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'09:01:00' AS Time), CAST(N'15:01:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 21, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (37, N'O/C MONDAY', N'Monday (8AM - 5PM)', N'STANDARD', CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 9, NULL, NULL, NULL, NULL, CAST(N'10:01:00' AS Time), CAST(N'14:59:59' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 5, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (38, N'O/C SATURDAY', N'Saturday (8AM - 12PM)', N'STANDARD', CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time), 5, NULL, NULL, 4, NULL, NULL, NULL, NULL, CAST(N'11:54:00' AS Time), NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 7, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (39, N'O/C TUE-FRIDAY', N'Tues-Fri (7AM - 5PM)', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, CAST(N'13:00:00' AS Time), CAST(N'12:00:00' AS Time), 10, NULL, NULL, NULL, NULL, CAST(N'09:01:00' AS Time), CAST(N'14:59:59' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 1, 6, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (40, N'RHD 1', N'7:00 AM - 12:00 PM', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), 5, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 22, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (41, N'RHD 2', N'7:00 AM - 11:00 AM', N'STANDARD', CAST(N'07:00:00' AS Time), CAST(N'11:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'11:00:00' AS Time), 5, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 23, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (42, N'RHD 3', N'1:00 PM - 5:00 PM', N'STANDARD', CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), 5, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 24, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (43, N'RHD 4', N'1:00 PM - 4:00 PM', N'STANDARD', CAST(N'13:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'16:00:00' AS Time), 5, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 25, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (44, N'Security 1', N'1st Shift (10PM - 6AM)', N'STANDARD', CAST(N'22:00:00' AS Time), CAST(N'18:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, CAST(N'05:54:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 16, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (45, N'Security 2', N'2nd Shift (6AM - 2PM)', N'STANDARD', CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, CAST(N'13:54:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 17, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (46, N'Security 3', N'3rd Shift (2PM - 10PM)', N'STANDARD', CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, CAST(N'21:54:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, N'H', 0, 18, 5, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
INSERT [dbo].[shift_type] ([id], [shift_id], [shift_desc], [shift_opt], [credit_time_in], [credit_time_out], [time_in], [time_out], [gp], [break_in], [break_out], [num_hours], [cbamin], [cbamout], [cbpmin], [cbpmout], [trig_late], [trig_under], [early_in], [early_out], [late_in], [late_out], [flex_am_break], [flex_pm_break], [flex_break], [min_ot], [hday_by_late], [ot_type], [break_hours], [seq_id], [gp2], [trig_absent], [min_workhours_1h], [min_workhours_2h], [created_by], [updated_by], [created_terminal], [updated_terminal], [createdAt], [updatedAt]) VALUES (47, N'SURVEY (2ND SHIFT)', N'6AM - 3PM', N'STANDARD', NULL, NULL, CAST(N'06:00:00' AS Time), CAST(N'15:00:00' AS Time), 5, NULL, NULL, 8, NULL, NULL, NULL, NULL, CAST(N'08:00:00' AS Time), CAST(N'13:00:00' AS Time), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, N'M', 0, 46, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2021-07-22T13:32:54.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[shift_type] OFF
GO
SET IDENTITY_INSERT [dbo].[shifts] ON 

INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (1, 1, 1, CAST(N'2021-07-02' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.703' AS DateTime), CAST(N'2021-08-04T23:23:14.703' AS DateTime), 1, 5, 5, 4, NULL, 2, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (2, 1, 1, CAST(N'2021-07-01' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.703' AS DateTime), CAST(N'2021-08-04T23:23:14.703' AS DateTime), NULL, 2, 1, 3, 2, 41, 41, 3, NULL, NULL, 45)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (3, 1, 1, CAST(N'2021-07-05' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.707' AS DateTime), CAST(N'2021-08-04T23:23:14.707' AS DateTime), NULL, 11, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, 50)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (4, 1, 1, CAST(N'2021-07-06' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.707' AS DateTime), CAST(N'2021-08-04T23:23:14.707' AS DateTime), NULL, 1, 12, 21, 21, NULL, NULL, NULL, 41, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (5, 1, 1, CAST(N'2021-07-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.713' AS DateTime), CAST(N'2021-08-04T23:23:14.713' AS DateTime), NULL, 12, NULL, 21, 21, NULL, NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (6, 1, 1, CAST(N'2021-07-08' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.717' AS DateTime), CAST(N'2021-08-04T23:23:14.717' AS DateTime), NULL, 21, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (7, 1, 1, CAST(N'2021-07-09' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.717' AS DateTime), CAST(N'2021-08-04T23:23:14.717' AS DateTime), NULL, NULL, 1, 21, 21, NULL, 51, NULL, 41, NULL, 6)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (8, 1, 1, CAST(N'2021-07-12' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.720' AS DateTime), CAST(N'2021-08-04T23:23:14.720' AS DateTime), NULL, 11, 1, 2, NULL, 5, 8, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (9, 1, 1, CAST(N'2021-07-13' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.723' AS DateTime), CAST(N'2021-08-04T23:23:14.723' AS DateTime), NULL, 21, 21, NULL, 2, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10, 1, 1, CAST(N'2021-07-14' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, CAST(N'20:57:33' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.730' AS DateTime), CAST(N'2021-08-04T23:23:14.730' AS DateTime), NULL, NULL, NULL, 3, 2, NULL, 14, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (11, 1, 1, CAST(N'2021-07-15' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.733' AS DateTime), CAST(N'2021-08-04T23:23:14.733' AS DateTime), NULL, 1, 23, NULL, 21, 2, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (12, 1, 1, CAST(N'2021-07-16' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'11:13:36' AS Time), CAST(N'18:54:50' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.737' AS DateTime), CAST(N'2021-08-04T23:23:14.737' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (13, 1, 1, CAST(N'2021-07-19' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'08:58:50' AS Time), CAST(N'15:04:28' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.740' AS DateTime), CAST(N'2021-08-04T23:23:14.740' AS DateTime), NULL, 1, NULL, 12, NULL, 6, 41, NULL, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (14, 1, 1, CAST(N'2021-07-20' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.747' AS DateTime), CAST(N'2021-08-04T23:23:14.747' AS DateTime), NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, 41, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (15, 1, 1, CAST(N'2021-07-21' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'11:26:44' AS Time), CAST(N'19:39:42' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.750' AS DateTime), CAST(N'2021-08-04T23:23:14.750' AS DateTime), NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (16, 1, 1, CAST(N'2021-07-22' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.767' AS DateTime), CAST(N'2021-08-04T23:23:14.767' AS DateTime), NULL, NULL, 3, NULL, NULL, 8, NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (17, 1, 1, CAST(N'2021-07-23' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.773' AS DateTime), CAST(N'2021-08-04T23:23:14.773' AS DateTime), NULL, 4, NULL, 8, NULL, NULL, 5, NULL, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (18, 1, 1, CAST(N'2021-07-26' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.777' AS DateTime), CAST(N'2021-08-04T23:23:14.777' AS DateTime), NULL, NULL, 5, NULL, 3, 5, NULL, NULL, 6, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (19, 1, 1, CAST(N'2021-07-27' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.780' AS DateTime), CAST(N'2021-08-04T23:23:14.780' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (20, 1, 1, CAST(N'2021-07-28' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'12:13:59' AS Time), NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.783' AS DateTime), CAST(N'2021-08-04T23:23:14.783' AS DateTime), NULL, NULL, NULL, 3, 5, NULL, NULL, 0, NULL, 1, 4)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (21, 1, 1, CAST(N'2021-07-29' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'10:23:26' AS Time), NULL, NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.790' AS DateTime), CAST(N'2021-08-04T23:23:14.790' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 4)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (22, 1, 1, CAST(N'2021-07-30' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, CAST(N'16:03:08' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.790' AS DateTime), CAST(N'2021-08-04T23:23:14.790' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 7, 1, 4)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (23, 1, 1, CAST(N'2021-08-02' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, CAST(N'18:35:41' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.793' AS DateTime), CAST(N'2021-08-04T23:23:14.793' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 7, 1, 4)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (24, 1, 1, CAST(N'2021-08-03' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'10:39:26' AS Time), CAST(N'17:08:08' AS Time), NULL, NULL, 1, 1, 9, 8, 1, 1, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:23:14.820' AS DateTime), CAST(N'2021-08-04T23:23:14.820' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 159, NULL, NULL, NULL, 6)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (25, 2, 1, CAST(N'2021-08-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:26:59.963' AS DateTime), CAST(N'2021-08-04T23:26:59.963' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (26, 1, 1, CAST(N'2021-08-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, CAST(N'19:33:33' AS Time), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:26:59.970' AS DateTime), CAST(N'2021-08-04T23:26:59.970' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 45, 0, NULL, 1, 0)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (27, 119, 1, CAST(N'2021-08-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-04T23:26:59.983' AS DateTime), CAST(N'2021-08-04T23:26:59.983' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 65, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (28, 2, 1, CAST(N'2021-08-05' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-05T11:46:00.137' AS DateTime), CAST(N'2021-08-05T11:46:00.137' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (29, 1, 1, CAST(N'2021-08-05' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'11:30:33' AS Time), CAST(N'17:55:58' AS Time), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-05T11:46:00.200' AS DateTime), CAST(N'2021-08-05T11:46:00.200' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 270, NULL, NULL, NULL, 5)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (30, 119, 1, CAST(N'2021-08-05' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-05T11:46:00.217' AS DateTime), CAST(N'2021-08-05T11:46:00.217' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (444, 2, 1, CAST(N'2021-08-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:49:00.930' AS DateTime), CAST(N'2021-08-06T00:49:00.930' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (445, 1, 1, CAST(N'2021-08-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'11:22:34' AS Time), NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:49:00.177' AS DateTime), CAST(N'2021-08-06T00:49:00.177' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 5)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (446, 119, 1, CAST(N'2021-08-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:49:00.203' AS DateTime), CAST(N'2021-08-06T00:49:00.203' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (447, 120, 1, CAST(N'2021-08-02' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.520' AS DateTime), CAST(N'2021-08-06T00:50:14.520' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 5, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (448, 120, 1, CAST(N'2021-08-03' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.523' AS DateTime), CAST(N'2021-08-06T00:50:14.523' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (449, 120, 1, CAST(N'2021-08-04' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.523' AS DateTime), CAST(N'2021-08-06T00:50:14.523' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (450, 120, 1, CAST(N'2021-08-05' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.527' AS DateTime), CAST(N'2021-08-06T00:50:14.527' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (451, 120, 1, CAST(N'2021-08-06' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.530' AS DateTime), CAST(N'2021-08-06T00:50:14.530' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (452, 120, 1, CAST(N'2021-08-07' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.530' AS DateTime), CAST(N'2021-08-06T00:50:14.530' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 3, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (453, 120, 1, CAST(N'2021-08-09' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.533' AS DateTime), CAST(N'2021-08-06T00:50:14.533' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (454, 120, 1, CAST(N'2021-08-10' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.533' AS DateTime), CAST(N'2021-08-06T00:50:14.533' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (455, 120, 1, CAST(N'2021-08-11' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.537' AS DateTime), CAST(N'2021-08-06T00:50:14.537' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (456, 120, 1, CAST(N'2021-08-12' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.540' AS DateTime), CAST(N'2021-08-06T00:50:14.540' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (457, 120, 1, CAST(N'2021-08-13' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.540' AS DateTime), CAST(N'2021-08-06T00:50:14.540' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (458, 120, 1, CAST(N'2021-08-14' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.543' AS DateTime), CAST(N'2021-08-06T00:50:14.543' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (459, 120, 1, CAST(N'2021-08-16' AS Date), CAST(N'12:00:00' AS Time), CAST(N'08:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.547' AS DateTime), CAST(N'2021-08-06T00:50:14.547' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (460, 121, 1, CAST(N'2021-08-02' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.547' AS DateTime), CAST(N'2021-08-06T00:50:14.547' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (461, 121, 2, CAST(N'2021-08-03' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.550' AS DateTime), CAST(N'2021-08-06T00:50:14.550' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (462, 121, 3, CAST(N'2021-08-04' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.553' AS DateTime), CAST(N'2021-08-06T00:50:14.553' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (463, 121, 4, CAST(N'2021-08-05' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.553' AS DateTime), CAST(N'2021-08-06T00:50:14.553' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (464, 121, 4, CAST(N'2021-08-06' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.557' AS DateTime), CAST(N'2021-08-06T00:50:14.557' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 4, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (465, 121, 3, CAST(N'2021-08-07' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.560' AS DateTime), CAST(N'2021-08-06T00:50:14.560' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (466, 121, 2, CAST(N'2021-08-09' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.563' AS DateTime), CAST(N'2021-08-06T00:50:14.563' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (467, 121, 4, CAST(N'2021-08-10' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.567' AS DateTime), CAST(N'2021-08-06T00:50:14.567' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (468, 121, 6, CAST(N'2021-08-11' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.570' AS DateTime), CAST(N'2021-08-06T00:50:14.570' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (469, 121, 7, CAST(N'2021-08-12' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.570' AS DateTime), CAST(N'2021-08-06T00:50:14.570' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (470, 121, 6, CAST(N'2021-08-13' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.573' AS DateTime), CAST(N'2021-08-06T00:50:14.573' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, 2, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (471, 121, 8, CAST(N'2021-08-14' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.577' AS DateTime), CAST(N'2021-08-06T00:50:14.577' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (472, 121, 8, CAST(N'2021-08-16' AS Date), CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.580' AS DateTime), CAST(N'2021-08-06T00:50:14.580' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (473, 122, 4, CAST(N'2021-08-02' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.580' AS DateTime), CAST(N'2021-08-06T00:50:14.580' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (474, 122, 5, CAST(N'2021-08-03' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.583' AS DateTime), CAST(N'2021-08-06T00:50:14.583' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (475, 122, 4, CAST(N'2021-08-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.587' AS DateTime), CAST(N'2021-08-06T00:50:14.587' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (476, 122, 5, CAST(N'2021-08-05' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.590' AS DateTime), CAST(N'2021-08-06T00:50:14.590' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (477, 122, 6, CAST(N'2021-08-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.593' AS DateTime), CAST(N'2021-08-06T00:50:14.593' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (478, 122, 2, CAST(N'2021-08-07' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.600' AS DateTime), CAST(N'2021-08-06T00:50:14.600' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (479, 122, 3, CAST(N'2021-08-09' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.600' AS DateTime), CAST(N'2021-08-06T00:50:14.600' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (480, 122, 6, CAST(N'2021-08-10' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.603' AS DateTime), CAST(N'2021-08-06T00:50:14.603' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (481, 122, 7, CAST(N'2021-08-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.607' AS DateTime), CAST(N'2021-08-06T00:50:14.607' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (482, 122, 4, CAST(N'2021-08-12' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.610' AS DateTime), CAST(N'2021-08-06T00:50:14.610' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (483, 122, 13, CAST(N'2021-08-13' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.613' AS DateTime), CAST(N'2021-08-06T00:50:14.613' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, 2, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (484, 122, 11, CAST(N'2021-08-14' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.617' AS DateTime), CAST(N'2021-08-06T00:50:14.617' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (485, 122, 12, CAST(N'2021-08-16' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.620' AS DateTime), CAST(N'2021-08-06T00:50:14.620' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (486, 123, 21, CAST(N'2021-08-02' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.623' AS DateTime), CAST(N'2021-08-06T00:50:14.623' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 6, 0, 2, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (487, 123, 5, CAST(N'2021-08-03' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.630' AS DateTime), CAST(N'2021-08-06T00:50:14.630' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (488, 123, 34, CAST(N'2021-08-04' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.630' AS DateTime), CAST(N'2021-08-06T00:50:14.630' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 3, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (489, 123, 31, CAST(N'2021-08-05' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.633' AS DateTime), CAST(N'2021-08-06T00:50:14.633' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (490, 123, 3, CAST(N'2021-08-06' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.637' AS DateTime), CAST(N'2021-08-06T00:50:14.637' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (491, 123, 3, CAST(N'2021-08-07' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.637' AS DateTime), CAST(N'2021-08-06T00:50:14.637' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 7, 0, 5, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (492, 123, 5, CAST(N'2021-08-09' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.640' AS DateTime), CAST(N'2021-08-06T00:50:14.640' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (493, 123, 4, CAST(N'2021-08-10' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.643' AS DateTime), CAST(N'2021-08-06T00:50:14.643' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (494, 123, 6, CAST(N'2021-08-11' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.643' AS DateTime), CAST(N'2021-08-06T00:50:14.643' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (495, 123, 1, CAST(N'2021-08-12' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.647' AS DateTime), CAST(N'2021-08-06T00:50:14.647' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (496, 123, 7, CAST(N'2021-08-13' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.650' AS DateTime), CAST(N'2021-08-06T00:50:14.650' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (497, 123, 8, CAST(N'2021-08-14' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.657' AS DateTime), CAST(N'2021-08-06T00:50:14.657' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (498, 123, 9, CAST(N'2021-08-16' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.657' AS DateTime), CAST(N'2021-08-06T00:50:14.657' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (499, 124, 2, CAST(N'2021-08-02' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.660' AS DateTime), CAST(N'2021-08-06T00:50:14.660' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (500, 124, 3, CAST(N'2021-08-03' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.663' AS DateTime), CAST(N'2021-08-06T00:50:14.663' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (501, 124, 4, CAST(N'2021-08-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.667' AS DateTime), CAST(N'2021-08-06T00:50:14.667' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (502, 124, 2, CAST(N'2021-08-05' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.667' AS DateTime), CAST(N'2021-08-06T00:50:14.667' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (503, 124, 5, CAST(N'2021-08-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.670' AS DateTime), CAST(N'2021-08-06T00:50:14.670' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (504, 124, 6, CAST(N'2021-08-07' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.670' AS DateTime), CAST(N'2021-08-06T00:50:14.670' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (505, 124, 7, CAST(N'2021-08-09' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.673' AS DateTime), CAST(N'2021-08-06T00:50:14.673' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (506, 124, 8, CAST(N'2021-08-10' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.677' AS DateTime), CAST(N'2021-08-06T00:50:14.677' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (507, 124, 9, CAST(N'2021-08-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.680' AS DateTime), CAST(N'2021-08-06T00:50:14.680' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (508, 124, 3, CAST(N'2021-08-12' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.680' AS DateTime), CAST(N'2021-08-06T00:50:14.680' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (509, 124, 3, CAST(N'2021-08-13' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.680' AS DateTime), CAST(N'2021-08-06T00:50:14.680' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (510, 124, 5, CAST(N'2021-08-14' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.683' AS DateTime), CAST(N'2021-08-06T00:50:14.683' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (511, 124, 1, CAST(N'2021-08-16' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.683' AS DateTime), CAST(N'2021-08-06T00:50:14.683' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (512, 124, 4, CAST(N'2021-08-17' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.687' AS DateTime), CAST(N'2021-08-06T00:50:14.687' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, 1, NULL)
GO
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (513, 124, 5, CAST(N'2021-08-18' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.690' AS DateTime), CAST(N'2021-08-06T00:50:14.690' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (514, 124, 6, CAST(N'2021-08-19' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.690' AS DateTime), CAST(N'2021-08-06T00:50:14.690' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (515, 124, 8, CAST(N'2021-08-20' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.690' AS DateTime), CAST(N'2021-08-06T00:50:14.690' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (516, 124, 9, CAST(N'2021-08-21' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.693' AS DateTime), CAST(N'2021-08-06T00:50:14.693' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (517, 124, 7, CAST(N'2021-08-23' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.693' AS DateTime), CAST(N'2021-08-06T00:50:14.693' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (518, 124, 5, CAST(N'2021-08-24' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.697' AS DateTime), CAST(N'2021-08-06T00:50:14.697' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (519, 124, 4, CAST(N'2021-08-25' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.697' AS DateTime), CAST(N'2021-08-06T00:50:14.697' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (520, 124, 12, CAST(N'2021-08-26' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.700' AS DateTime), CAST(N'2021-08-06T00:50:14.700' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (521, 124, 3, CAST(N'2021-08-27' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.703' AS DateTime), CAST(N'2021-08-06T00:50:14.703' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (522, 124, 2, CAST(N'2021-08-28' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.703' AS DateTime), CAST(N'2021-08-06T00:50:14.703' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (523, 124, 1, CAST(N'2021-08-30' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.707' AS DateTime), CAST(N'2021-08-06T00:50:14.707' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (524, 124, 2, CAST(N'2021-08-31' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.710' AS DateTime), CAST(N'2021-08-06T00:50:14.710' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (525, 124, 1, CAST(N'2021-09-01' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.710' AS DateTime), CAST(N'2021-08-06T00:50:14.710' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (526, 126, 5, CAST(N'2021-08-02' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.717' AS DateTime), CAST(N'2021-08-06T00:50:14.717' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (527, 126, 6, CAST(N'2021-08-03' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.717' AS DateTime), CAST(N'2021-08-06T00:50:14.717' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (528, 126, 9, CAST(N'2021-08-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.720' AS DateTime), CAST(N'2021-08-06T00:50:14.720' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (529, 126, 8, CAST(N'2021-08-05' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.727' AS DateTime), CAST(N'2021-08-06T00:50:14.727' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (530, 126, 7, CAST(N'2021-08-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.730' AS DateTime), CAST(N'2021-08-06T00:50:14.730' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (531, 126, 4, CAST(N'2021-08-07' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.730' AS DateTime), CAST(N'2021-08-06T00:50:14.730' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (532, 126, 5, CAST(N'2021-08-09' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.733' AS DateTime), CAST(N'2021-08-06T00:50:14.733' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (533, 126, 2, CAST(N'2021-08-10' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.733' AS DateTime), CAST(N'2021-08-06T00:50:14.733' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (534, 126, 3, CAST(N'2021-08-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.737' AS DateTime), CAST(N'2021-08-06T00:50:14.737' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (535, 126, 6, CAST(N'2021-08-12' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.740' AS DateTime), CAST(N'2021-08-06T00:50:14.740' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (536, 126, 5, CAST(N'2021-08-13' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.740' AS DateTime), CAST(N'2021-08-06T00:50:14.740' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (537, 126, 4, CAST(N'2021-08-14' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.743' AS DateTime), CAST(N'2021-08-06T00:50:14.743' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (538, 126, 7, CAST(N'2021-08-16' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.747' AS DateTime), CAST(N'2021-08-06T00:50:14.747' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (539, 126, 8, CAST(N'2021-08-17' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.750' AS DateTime), CAST(N'2021-08-06T00:50:14.750' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (540, 126, 9, CAST(N'2021-08-18' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.750' AS DateTime), CAST(N'2021-08-06T00:50:14.750' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (541, 126, 6, CAST(N'2021-08-19' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.753' AS DateTime), CAST(N'2021-08-06T00:50:14.753' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (542, 126, 5, CAST(N'2021-08-20' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.753' AS DateTime), CAST(N'2021-08-06T00:50:14.753' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (543, 126, 4, CAST(N'2021-08-21' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.757' AS DateTime), CAST(N'2021-08-06T00:50:14.757' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (544, 126, 1, CAST(N'2021-08-23' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.760' AS DateTime), CAST(N'2021-08-06T00:50:14.760' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (545, 126, 2, CAST(N'2021-08-24' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.760' AS DateTime), CAST(N'2021-08-06T00:50:14.760' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (546, 126, 3, CAST(N'2021-08-25' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.763' AS DateTime), CAST(N'2021-08-06T00:50:14.763' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (547, 126, 2, CAST(N'2021-08-26' AS Date), CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 5, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-06T00:50:14.767' AS DateTime), CAST(N'2021-08-06T00:50:14.767' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (548, 2, 1, CAST(N'2021-08-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-07T00:00:00.730' AS DateTime), CAST(N'2021-08-07T00:00:00.730' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (549, 1, 5, CAST(N'2021-08-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-07T00:00:00.123' AS DateTime), CAST(N'2021-08-07T00:00:00.123' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (550, 119, 3, CAST(N'2021-08-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 4, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-07T00:00:00.130' AS DateTime), CAST(N'2021-08-07T00:00:00.130' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (551, 2, 6, CAST(N'2021-08-09' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 9, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-09T00:00:00.730' AS DateTime), CAST(N'2021-08-09T00:00:00.730' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (552, 1, 5, CAST(N'2021-08-09' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 9, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-09T00:00:00.137' AS DateTime), CAST(N'2021-08-09T00:00:00.137' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (553, 119, 2, CAST(N'2021-08-09' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 9, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-09T00:00:00.140' AS DateTime), CAST(N'2021-08-09T00:00:00.140' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (554, 2, 1, CAST(N'2021-08-10' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-10T00:00:00.110' AS DateTime), CAST(N'2021-08-10T00:00:00.110' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (556, 119, 4, CAST(N'2021-08-10' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-10T00:00:00.190' AS DateTime), CAST(N'2021-08-10T00:00:00.190' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (557, 2, 5, CAST(N'2021-08-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-11T00:00:00.630' AS DateTime), CAST(N'2021-08-11T00:00:00.630' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (558, 1, 8, CAST(N'2021-08-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, CAST(N'20:38:01' AS Time), NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-11T00:00:00.143' AS DateTime), CAST(N'2021-08-11T00:00:00.143' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 5)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (559, 119, 9, CAST(N'2021-08-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-11T00:00:00.150' AS DateTime), CAST(N'2021-08-11T00:00:00.150' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10337, 2, 6, CAST(N'2021-08-12' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-12T17:00:00.487' AS DateTime), CAST(N'2021-08-12T17:00:00.487' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10338, 119, 5, CAST(N'2021-08-12' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-12T17:00:00.487' AS DateTime), CAST(N'2021-08-12T17:00:00.487' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10339, 1, 4, CAST(N'2021-08-12' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-12T17:00:00.487' AS DateTime), CAST(N'2021-08-12T17:00:00.487' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10340, 120, 8, CAST(N'2021-08-17' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-17T07:00:00.103' AS DateTime), CAST(N'2021-08-17T07:00:00.103' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10342, 120, NULL, CAST(N'2021-08-18' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-18T00:00:01.003' AS DateTime), CAST(N'2021-08-18T00:00:01.003' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [dbo].[shifts] ([id], [user_id], [type], [date], [check_in], [check_out], [actual_check_in], [actual_check_out], [between_start], [between_end], [primary_status], [backup_status], [shift_length], [paid_hours], [primary_approver], [backup_approver], [approver_note], [onsite], [_token], [approved_by], [approved_at], [created_at], [updated_at], [reg_holiday_work_hrs], [reg_holiday_rest_day_work_hrs], [reg_special_holiday_restday_work_hrs], [double_reg_holiday], [special_holiday], [special_holiday_restday], [late], [absent], [undertime], [awol], [actual_work_hours]) VALUES (10343, 120, NULL, CAST(N'2021-08-19' AS Date), CAST(N'07:00:00' AS Time), CAST(N'17:00:00' AS Time), NULL, NULL, NULL, NULL, 1, NULL, 10, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, CAST(N'2021-08-19T00:00:00.127' AS DateTime), CAST(N'2021-08-19T00:00:00.127' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[shifts] OFF
GO
SET IDENTITY_INSERT [dbo].[taxonomy] ON 

INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (1, 0, N'Department', NULL, NULL, 1, 1, 1, NULL, NULL, CAST(N'2019-03-25T13:32:54.000' AS DateTime), CAST(N'2019-06-25T15:33:41.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (2, 0, N'Designation', NULL, NULL, 1, 2, 1, NULL, NULL, CAST(N'2019-03-25T13:33:32.000' AS DateTime), CAST(N'2019-07-12T18:21:11.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (3, 0, N'Employment Status', NULL, NULL, 1, 3, 1, NULL, NULL, CAST(N'2019-03-25T13:33:49.000' AS DateTime), CAST(N'2019-06-25T15:33:49.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (4, 2, N'Accounts receivable/payable specialist', NULL, NULL, 1, 1, 0, NULL, NULL, CAST(N'2019-03-25T13:50:59.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (5, 2, N'Assessor', NULL, NULL, 1, 2, 0, NULL, NULL, CAST(N'2019-03-25T13:51:22.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (6, 2, N'Auditor', NULL, NULL, 1, 3, 0, NULL, NULL, CAST(N'2019-03-25T13:51:31.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (7, 2, N'HR specialist', NULL, NULL, 1, 4, 0, NULL, NULL, CAST(N'2019-03-25T13:51:39.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (9, 1, N'Finance', NULL, NULL, 1, 2, 0, NULL, NULL, CAST(N'2019-03-25T13:52:08.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (10, 1, N'Information Technology', N'IT', NULL, 1, 3, 0, NULL, NULL, CAST(N'2019-03-25T13:52:23.000' AS DateTime), CAST(N'2019-03-25T16:33:19.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (11, 1, N'Supply Chain Management', NULL, NULL, 2, 4, 0, NULL, 1, CAST(N'2019-03-25T13:52:39.000' AS DateTime), CAST(N'2020-03-11T16:01:05.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (12, 3, N'Full-time', NULL, NULL, 1, 1, 0, NULL, NULL, CAST(N'2019-03-25T15:34:28.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (13, 3, N'Probationary', NULL, NULL, 1, 2, 0, NULL, NULL, CAST(N'2019-03-25T15:34:46.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (14, 3, N'Project Based', NULL, NULL, 1, 3, 0, NULL, NULL, CAST(N'2019-03-25T15:35:04.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (15, 3, N'Seasonal', NULL, N'Seasonal employment is highly dependent on a specific season. This means that a job is only available at a specific time of the year and is meant to fulfill increased work demands associated with that specific season.', 1, 4, 0, NULL, NULL, CAST(N'2019-03-25T15:35:29.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (16, 2, N'Full Stack Developer', NULL, NULL, 1, 5, 0, NULL, NULL, CAST(N'2019-03-26T17:41:50.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (21, 0, N'Interview Evaluation Based on Competency', NULL, NULL, 1, 5, 1, NULL, NULL, CAST(N'2019-06-25T15:27:58.000' AS DateTime), CAST(N'2019-06-25T15:53:23.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (22, 21, N'Was the candidate prepared for the interview?', NULL, NULL, 1, 1, 0, NULL, NULL, CAST(N'2019-06-25T15:29:22.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (23, 21, N'Does their experience appear to match what’s needed?', NULL, NULL, 1, 2, 0, NULL, NULL, CAST(N'2019-06-25T15:29:52.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (24, 21, N'Do they have some or all of the required credentials?', NULL, N'(For example, education, licenses, certifications?)', 1, 3, 0, NULL, NULL, CAST(N'2019-06-25T15:30:14.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (25, 21, N'How are their interpersonal skills?', NULL, N'(Friendly, smiling, outgoing, kind, fun, interactive?)', 1, 4, 0, NULL, NULL, CAST(N'2019-06-25T15:30:38.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (26, 0, N'Application Requirements', NULL, NULL, 1, 6, 1, NULL, NULL, CAST(N'2019-07-02T18:06:33.000' AS DateTime), CAST(N'2019-07-02T18:06:44.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (27, 26, N'Birth Certificate', NULL, NULL, 1, 1, 0, NULL, NULL, CAST(N'2019-07-02T18:07:04.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (28, 26, N'NBI Clearance', NULL, NULL, 1, 2, 0, NULL, NULL, CAST(N'2019-07-02T18:07:16.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (29, 26, N'BIR forms', NULL, NULL, 1, 3, 0, NULL, NULL, CAST(N'2019-07-02T18:07:59.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (30, 26, N'Transcript of Records/ Diploma', NULL, NULL, 1, 4, 0, NULL, NULL, CAST(N'2019-07-02T18:09:22.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (31, 26, N'Certificate of Employment', N'COE', NULL, 1, 5, 0, NULL, NULL, CAST(N'2019-07-02T18:10:01.000' AS DateTime), NULL)
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (32, 2, N'Seo Specialist', NULL, NULL, 1, 6, 0, NULL, 0, CAST(N'2019-07-05T19:31:15.000' AS DateTime), CAST(N'2019-07-05T19:31:15.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (33, 0, N'Account - Sales option', NULL, NULL, 1, 6, 0, NULL, 0, CAST(N'2019-09-25T20:23:55.000' AS DateTime), CAST(N'2019-09-25T20:23:55.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (34, 33, N'All', NULL, NULL, 1, 1, 0, NULL, 0, CAST(N'2019-09-25T20:24:13.000' AS DateTime), CAST(N'2019-09-25T20:24:13.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (35, 33, N'email01@jpm.ph', NULL, NULL, 1, 2, 0, NULL, 0, CAST(N'2019-09-25T20:24:34.000' AS DateTime), CAST(N'2019-09-25T20:24:34.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (36, 33, N'email02@jpm.ph', NULL, NULL, 1, 3, 0, NULL, 0, CAST(N'2019-09-25T20:24:47.000' AS DateTime), CAST(N'2019-09-25T20:24:47.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (56, 1, N'Marketing', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (57, 2, N'Medical Assistant', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (58, 2, N'Engineer', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (59, 1, N'Purchasing', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (60, 2, N'Project Manager', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (61, 1, N'Production', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (62, 2, N'Iron Worker', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:01.000' AS DateTime), CAST(N'2019-09-27T18:23:01.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (63, 1, N'supply chain', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:02.000' AS DateTime), CAST(N'2019-09-27T18:23:02.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (64, 2, N'Handyman', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-09-27T18:23:02.000' AS DateTime), CAST(N'2019-09-27T18:23:02.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (65, 1, N'DESIGN  ', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (66, 2, N'DESIGN EXECUTIVE', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (70, 2, N'DESIGN HEAD / EXEC', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (71, 1, N'PURCHASING & LOGISTICS', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (73, 1, N'MANAGEMENT', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (74, 2, N'PRESIDENT', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (75, 1, N'BUILD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (76, 2, N'BUILD HEAD / PM', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (78, 2, N'PURCHASING & LOGISTICS HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (80, 2, N'GENERAL MANAGER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (81, 1, N'BUILD - PERMITS', NULL, NULL, 1, NULL, 0, 0, 2, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2021-06-01T23:06:05.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (82, 2, N'PERMIT STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (85, 1, N'BUILD - COSTING', NULL, NULL, 1, NULL, 0, 0, 2, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2021-06-01T23:05:49.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (86, 2, N'COSTING HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (87, 1, N'ELECTRICAL', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (88, 2, N'ELECTRICAL HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (89, 2, N'DRIVER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (90, 2, N'FINANCE HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (97, 1, N'SALES', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (98, 2, N'BUSINESS DEVT OFFICER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (102, 2, N'PERMIT HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (104, 1, N'DESIGN PROD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (105, 2, N'DESIGN PRODUCTION STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (108, 2, N'DESIGN EXECUTIVE ASST', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (111, 1, N'MECHANICAL', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (112, 2, N'MECHANICAL HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (114, 2, N'ELECTRICAL TEAM LEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (115, 1, N'EXECUTIVE', NULL, NULL, 1, NULL, 0, 0, 3, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2020-06-02T12:06:40.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (116, 2, N'ASSET MANAGEMENT OFFICER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (118, 2, N'PURCHASING & LOGISTICS STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (119, 1, N'WAREHOUSE', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (120, 2, N'WAREHOUSE STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (122, 2, N'WAREHOUSE HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (124, 2, N'MECHANICAL STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (130, 2, N'JR ELECTRICAL TEAM LEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (136, 2, N'DESIGN COORDINATOR', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (142, 2, N'MATERIALS SPECIFICATION SPECIALIST', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (147, 2, N'CREDIT AND COLLECTION OFFICER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (149, 2, N'DESIGN PRODUCTIONS DRAWING HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (151, 1, N'SERVICE WARRANTY', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (152, 1, N'HR/ADMIN', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (153, 2, N'HR HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (155, 2, N'QUANTITY SURVEYOR', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (157, 2, N'ACCOUNTING STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (164, 1, N'SHOP', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (165, 2, N'SHOP MANAGER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (167, 2, N'MACHINE TECHNICIAN', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (178, 2, N'SITE SUPERVISOR', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (180, 2, N'AUXILIARY TEAM HEAD', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (182, 2, N'SALES OFFICER', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (193, 2, N'ELECTRICAL STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (200, 2, N'HR STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (204, 2, N'FOREMAN OPERATOR', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (239, 1, N'ACCOUNTING and FINANCE', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (250, 2, N'DESIGN ASSOCIATE', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (269, 2, N'PRODUCTION STAFF', NULL, NULL, 1, NULL, 0, 0, 0, CAST(N'2019-10-30T05:56:29.000' AS DateTime), CAST(N'2019-10-30T05:56:29.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (270, 0, N'Team', NULL, NULL, 1, 7, 0, 1, 0, CAST(N'2020-06-02T13:46:47.000' AS DateTime), CAST(N'2020-06-02T13:46:47.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (271, 270, N'Management', NULL, NULL, 1, 1, 0, 1, 0, CAST(N'2020-06-02T13:46:57.000' AS DateTime), CAST(N'2020-06-02T13:46:57.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (272, 270, N'Sales', NULL, NULL, 1, 2, 0, 1, 0, CAST(N'2020-06-02T13:47:12.000' AS DateTime), CAST(N'2020-06-02T13:47:12.000' AS DateTime))
GO
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (273, 270, N'Design', NULL, NULL, 1, 3, 0, 1, 0, CAST(N'2020-06-02T13:47:25.000' AS DateTime), CAST(N'2020-06-02T13:47:25.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (274, 270, N'Design Production', NULL, NULL, 1, 4, 0, 1, 0, CAST(N'2020-06-02T13:47:45.000' AS DateTime), CAST(N'2020-06-02T13:47:45.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (275, 270, N'Build', NULL, NULL, 1, 5, 0, 1, 0, CAST(N'2020-06-02T13:47:58.000' AS DateTime), CAST(N'2020-06-02T13:47:58.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (277, 270, N'Costing', NULL, NULL, 1, 7, 0, 1, 0, CAST(N'2020-06-02T13:48:37.000' AS DateTime), CAST(N'2020-06-02T13:48:37.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (278, 270, N'Permits', NULL, NULL, 1, 8, 0, 1, 0, CAST(N'2020-06-02T13:48:49.000' AS DateTime), CAST(N'2020-06-02T13:48:49.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (279, 270, N'Purchasing', NULL, NULL, 1, 9, 0, 1, 0, CAST(N'2020-06-02T13:49:04.000' AS DateTime), CAST(N'2020-06-02T13:49:04.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (280, 270, N'Warehouse', NULL, NULL, 1, 10, 0, 1, 0, CAST(N'2020-06-02T13:49:15.000' AS DateTime), CAST(N'2020-06-02T13:49:15.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (281, 270, N'Shop', NULL, NULL, 1, 11, 0, 1, 0, CAST(N'2020-06-02T13:49:30.000' AS DateTime), CAST(N'2020-06-02T13:49:30.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (282, 270, N'Human Resources', NULL, NULL, 1, 12, 0, 1, 0, CAST(N'2020-06-02T13:49:43.000' AS DateTime), CAST(N'2020-06-02T13:49:43.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (283, 270, N'Accounting and Finance', NULL, NULL, 1, 13, 0, 1, 0, CAST(N'2020-06-02T13:50:03.000' AS DateTime), CAST(N'2020-06-02T13:50:03.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (284, 1, N'Commercial Group', NULL, NULL, 1, 25, 0, NULL, 0, CAST(N'2020-06-02T15:06:42.000' AS DateTime), CAST(N'2020-06-02T15:06:42.000' AS DateTime))
INSERT [dbo].[taxonomy] ([id], [parent_id], [title], [code], [description], [status], [node], [system_role], [created_by], [updated_by], [created_at], [updated_at]) VALUES (285, 1, N'Industrial Group', NULL, NULL, 1, 26, 0, NULL, 0, CAST(N'2020-06-02T15:06:58.000' AS DateTime), CAST(N'2020-06-02T15:06:58.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[taxonomy] OFF
GO
SET IDENTITY_INSERT [dbo].[temp_in_out] ON 

INSERT [dbo].[temp_in_out] ([id], [user_id], [date], [time], [type], [created_at], [updated_at]) VALUES (20, 1, CAST(N'2021-07-14' AS Date), CAST(N'17:02:13' AS Time), N'timein', CAST(N'2021-07-14T17:01:38.610' AS DateTime), CAST(N'2021-07-14T17:01:38.610' AS DateTime))
INSERT [dbo].[temp_in_out] ([id], [user_id], [date], [time], [type], [created_at], [updated_at]) VALUES (21, 1, CAST(N'2021-07-14' AS Date), CAST(N'17:01:43' AS Time), N'timeout', CAST(N'2021-07-14T17:01:43.073' AS DateTime), CAST(N'2021-07-14T17:01:43.073' AS DateTime))
INSERT [dbo].[temp_in_out] ([id], [user_id], [date], [time], [type], [created_at], [updated_at]) VALUES (22, 1, CAST(N'2021-07-17' AS Date), CAST(N'01:49:29' AS Time), N'timein', CAST(N'2021-07-17T01:49:29.517' AS DateTime), CAST(N'2021-07-17T01:49:29.517' AS DateTime))
INSERT [dbo].[temp_in_out] ([id], [user_id], [date], [time], [type], [created_at], [updated_at]) VALUES (23, 1, CAST(N'2021-07-19' AS Date), CAST(N'16:00:16' AS Time), N'timein', CAST(N'2021-07-19T16:00:16.050' AS DateTime), CAST(N'2021-07-19T16:00:16.050' AS DateTime))
INSERT [dbo].[temp_in_out] ([id], [user_id], [date], [time], [type], [created_at], [updated_at]) VALUES (1023, 1, CAST(N'2021-07-21' AS Date), CAST(N'11:11:47' AS Time), N'timein', CAST(N'2021-07-21T11:11:47.353' AS DateTime), CAST(N'2021-07-21T11:11:47.353' AS DateTime))
INSERT [dbo].[temp_in_out] ([id], [user_id], [date], [time], [type], [created_at], [updated_at]) VALUES (1024, 1, CAST(N'2021-07-21' AS Date), CAST(N'11:11:48' AS Time), N'timeout', CAST(N'2021-07-21T11:11:48.180' AS DateTime), CAST(N'2021-07-21T11:11:48.180' AS DateTime))
SET IDENTITY_INSERT [dbo].[temp_in_out] OFF
GO
SET IDENTITY_INSERT [dbo].[user_setting] ON 

INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (1, 1, 1, 1, 3)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (2, 2, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (3, 108, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (4, 84, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (5, 79, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (6, 7, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (7, 58, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (8, 47, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (9, 116, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (10, 18, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (11, 37, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (12, 107, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (13, 104, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (14, 11, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (15, 114, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (16, 93, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (17, 29, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (18, 68, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (19, 105, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (20, 36, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (21, 48, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (22, 110, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (23, 90, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (24, 8, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (25, 54, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (26, 35, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (27, 94, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (28, 63, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (29, 39, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (30, 4, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (31, 9, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (32, 6, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (33, 26, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (34, 71, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (35, 85, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (36, 30, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (37, 38, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (38, 24, 0, 0, 1)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (39, 75, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (40, 67, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (41, 12, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (42, 89, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (43, 83, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (44, 53, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (45, 91, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (46, 16, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (47, 81, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (48, 42, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (49, 49, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (50, 113, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (51, 106, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (52, 59, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (53, 76, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (54, 70, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (55, 117, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (56, 45, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (57, 55, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (58, 60, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (59, 15, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (60, 31, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (61, 44, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (62, 23, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (63, 74, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (64, 50, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (65, 22, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (66, 51, 0, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (67, 65, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (68, 32, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (69, 115, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (70, 34, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (71, 78, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (72, 62, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (73, 88, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (74, 96, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (75, 25, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (76, 43, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (77, 95, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (78, 100, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (79, 97, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (80, 33, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (81, 41, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (82, 10, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (83, 28, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (84, 19, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (85, 98, 0, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (86, 112, 1, 0, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (87, 118, 1, 1, 2)
INSERT [dbo].[user_setting] ([id], [user_id], [has_holiday], [has_overtime], [work_schedule_method]) VALUES (88, 120, NULL, NULL, 3)
SET IDENTITY_INSERT [dbo].[user_setting] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (1, 0, N'TZPZJHkkY', N'Julius', NULL, NULL, NULL, N'Faigmani', N'Male', CAST(N'1989-07-14' AS Date), N'e914d1a3-3d59-4f81-aacb-eb8d822a3632.jpg', N'', N'', 177, N'Single', N'9954528315', N'julius.faigmani@gmail.com', N'juliusf', N'$2a$10$iSphFTqfXyfGyasyUDauCuF9fbUVh3tzQrJ4TVmOrnUy5N6i4IdnS', 1, N'1,4', NULL, N'', N'', N'', N'', N'0000000000', 1, 10, 16, NULL, CAST(N'2019-09-02' AS Date), NULL, N'1dccd37f-50f3-57e9-b78b-1f669bbf38fb', 0, 3, CAST(N'2019-10-01T14:29:30.000' AS DateTime), CAST(N'2021-06-11T01:02:34.000' AS DateTime), NULL)
INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (2, 0, N'J0MVrEOSq', N'Jerwine', N'Clark', NULL, NULL, N'Badiang', N'Male', CAST(N'1982-10-30' AS Date), NULL, N'119 Dela Rosa Street', N'', 177, N'Married', N'9189574468', N'jerwine@bookbit.ph', N'jerwinb', N'$2a$10$gzddQHBJK8tR4CfTY05Ol.nOx4kPF93ZH1YotbZcbUlLxOixB5D.C', 1, N'1', NULL, N'', N'', N'', N'', N'JPM20190000002', 1, 10, 60, 275, CAST(N'2019-06-01' AS Date), NULL, NULL, 1, NULL, CAST(N'2019-10-06T04:52:28.000' AS DateTime), CAST(N'2021-06-14T15:20:35.000' AS DateTime), NULL)
INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (119, 0, N'KmMh7oRZ1', N'test', N'test', NULL, NULL, N'test', N'Male', CAST(N'2021-07-08' AS Date), NULL, NULL, NULL, 177, N'Single', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'BB0000119', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-07-09T00:05:07.633' AS DateTime), CAST(N'2021-07-09T00:05:07.633' AS DateTime), 0)
INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (120, 0, N'DrlDkbMLF', N'Geronimo John', N'Basilio', NULL, N'Gj', N'Rivera', N'Male', CAST(N'2021-07-14' AS Date), NULL, NULL, NULL, 177, N'Single', NULL, N'grivera@gmail.com', NULL, N'$2a$10$TYtNnhe50e6AylcNRslV.O7j9xbzosLTeMv2VBGhqVOrrRfdgi.US', 1, NULL, NULL, NULL, NULL, NULL, NULL, N'BB0000120', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2021-07-09T00:09:53.203' AS DateTime), CAST(N'2021-07-09T00:09:53.203' AS DateTime), 0)
INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (121, 0, N'PbvxOEOow', N'test1', N'test', NULL, N'test', N'test', N'Male', CAST(N'2021-07-08' AS Date), NULL, NULL, NULL, 65, N'Single', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'BB0000121', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(N'2021-07-09T00:10:45.350' AS DateTime), CAST(N'2021-07-09T00:10:45.350' AS DateTime), 0)
INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (122, 0, N'2cLaA7q6I', N'ttt', N'tt', N'tt', N'tt', N't', N'Male', CAST(N'2021-07-08' AS Date), NULL, NULL, NULL, 177, N'Single', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(N'2021-07-09T00:13:22.160' AS DateTime), CAST(N'2021-07-09T00:13:22.160' AS DateTime), 0)
INSERT [dbo].[users] ([id], [parent_id], [shortid], [first_name], [middle_name], [suffix], [nick_name], [last_name], [gender], [birthdate], [avatar], [present_address], [permanent_address], [nationality], [marital_status], [contact_number], [email], [username], [password], [status], [user_role], [note], [sss_number], [pagibig_number], [tin_number], [philhealth_number], [employee_number], [company_branch_id], [department_id], [job_title_id], [team_id], [date_entry], [resignation_date], [reset_token], [created_by], [updated_by], [created_at], [updated_at], [employee_type]) VALUES (123, 0, N'1dxsBr5zB', N'a', N'aa', NULL, NULL, N'aa', N'Female', CAST(N'2021-07-08' AS Date), NULL, NULL, NULL, 50, N'Separated', NULL, N'test@test.com', NULL, N'$2a$10$htb4FNt/.I0ZtkAVd7x.3uj19vA6CQBZLUUxSgArMLq2.a6BrwMA6', 1, N'4', NULL, NULL, NULL, NULL, NULL, N'BB20210000123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-07-09T00:14:02.813' AS DateTime), CAST(N'2021-07-09T00:14:02.813' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[users_document] ON 

INSERT [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (1, 1, N'Dummy', N'e01ebcce-49d6-44f1-9166-8cf9090f96a1.pdf', N'sample.pdf', N'', CAST(N'2019-10-07T15:15:28.000' AS DateTime), CAST(N'2019-10-07T15:15:28.000' AS DateTime))
INSERT [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (2, 2, N'Promotion', N'cbbbbe6d-2be4-4af3-aac2-ee70767df17e.txt', N'promotion.txt', N'Promoted from Associate to Professional', CAST(N'2019-11-19T11:42:11.000' AS DateTime), CAST(N'2019-11-19T11:42:11.000' AS DateTime))
INSERT [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (3, 44, N'Movement Letter', N'6564525b-576c-437f-a952-460d80a96c49.pdf', N'MARIA MONICA TURALBA.pdf', N'Promoted as Design Executive effective March 18, 2019', CAST(N'2019-11-20T16:44:03.000' AS DateTime), CAST(N'2019-11-20T16:44:03.000' AS DateTime))
INSERT [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (4, 97, N'Movement Letter', N'42d53f22-ab3d-47cb-b852-dba6bb40dc1f.pdf', N'SHARA MAY CANLAS .pdf', N'Promoted as Design Coordinator effective September 24, 2019', CAST(N'2019-11-20T16:48:59.000' AS DateTime), CAST(N'2019-11-20T16:48:59.000' AS DateTime))
INSERT [dbo].[users_document] ([id], [user_id], [label], [hash], [original_name], [description], [created_at], [updated_at]) VALUES (5, 71, N'Movement Letter', N'a342653c-cee3-45f0-8ed3-b0d2e020c0c9.jpg', N'Garcia, Jamie.jpg', N'Promoted as Project Manager effective November 11, 2019', CAST(N'2019-11-20T16:59:07.000' AS DateTime), CAST(N'2019-11-20T16:59:07.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[users_document] OFF
GO
SET IDENTITY_INSERT [dbo].[work_areas] ON 

INSERT [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'Surface', CAST(N'2021-06-17T16:20:57.000' AS DateTime), NULL)
INSERT [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'Underground', CAST(N'2021-06-17T16:20:57.000' AS DateTime), NULL)
INSERT [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'Surface/Underground', CAST(N'2021-06-17T16:20:57.000' AS DateTime), NULL)
INSERT [dbo].[work_areas] ([id], [name], [createdAt], [updatedAt]) VALUES (4, N'Support', CAST(N'2021-06-17T16:20:57.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[work_areas] OFF
GO
SET IDENTITY_INSERT [dbo].[work_schedule] ON 

INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (3, 79, 2, 1, 1, N' ', 1, CAST(N'2019-11-19' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T11:54:38.000' AS DateTime), CAST(N'2019-11-20T11:57:33.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (4, 108, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T12:02:55.000' AS DateTime), CAST(N'2019-11-20T12:02:55.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (7, 58, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T12:35:02.000' AS DateTime), CAST(N'2019-11-20T12:35:02.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (8, 47, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T13:29:13.000' AS DateTime), CAST(N'2019-11-20T13:29:13.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (9, 116, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T13:33:45.000' AS DateTime), CAST(N'2019-11-20T13:33:45.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (10, 18, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T13:38:20.000' AS DateTime), CAST(N'2019-11-20T13:38:20.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (11, 37, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T13:39:53.000' AS DateTime), CAST(N'2019-11-20T13:39:53.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (13, 104, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T13:43:57.000' AS DateTime), CAST(N'2019-11-20T13:43:57.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (14, 11, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T13:45:29.000' AS DateTime), CAST(N'2019-11-20T13:45:29.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (16, 93, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T13:48:06.000' AS DateTime), CAST(N'2019-11-20T13:48:06.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (19, 105, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T13:55:23.000' AS DateTime), CAST(N'2019-11-20T13:55:23.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (22, 110, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:05:06.000' AS DateTime), CAST(N'2019-11-20T14:05:06.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (23, 90, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:08:52.000' AS DateTime), CAST(N'2019-11-20T14:08:52.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (24, 8, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:09:50.000' AS DateTime), CAST(N'2019-11-20T14:09:50.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (25, 54, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T14:12:04.000' AS DateTime), CAST(N'2019-11-20T14:12:04.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (26, 35, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:17:14.000' AS DateTime), CAST(N'2019-11-20T14:17:14.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (27, 94, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T14:19:36.000' AS DateTime), CAST(N'2019-11-20T14:19:36.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (28, 63, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T14:23:37.000' AS DateTime), CAST(N'2019-11-20T14:23:37.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (30, 4, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:27:43.000' AS DateTime), CAST(N'2019-11-20T14:27:43.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (31, 9, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T14:34:36.000' AS DateTime), CAST(N'2019-11-20T14:34:36.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (32, 6, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:35:59.000' AS DateTime), CAST(N'2019-11-20T14:35:59.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (33, 26, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:39:55.000' AS DateTime), CAST(N'2019-11-20T14:39:55.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (34, 71, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T14:45:46.000' AS DateTime), CAST(N'2019-11-20T14:45:46.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (35, 85, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:47:26.000' AS DateTime), CAST(N'2019-11-20T14:47:26.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (36, 30, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T14:48:48.000' AS DateTime), CAST(N'2019-11-20T14:48:48.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (39, 67, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T15:00:27.000' AS DateTime), CAST(N'2019-11-20T15:00:27.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (45, 16, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:18:20.000' AS DateTime), CAST(N'2019-11-20T15:18:20.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (47, 42, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:22:11.000' AS DateTime), CAST(N'2019-11-20T15:22:11.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (48, 49, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:23:23.000' AS DateTime), CAST(N'2019-11-20T15:23:23.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (50, 106, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T15:25:26.000' AS DateTime), CAST(N'2019-11-20T15:25:26.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (51, 59, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:26:39.000' AS DateTime), CAST(N'2019-11-20T15:26:39.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (52, 76, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:42:49.000' AS DateTime), CAST(N'2019-11-20T15:42:49.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (53, 70, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:44:08.000' AS DateTime), CAST(N'2019-11-20T15:44:08.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (58, 15, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:54:14.000' AS DateTime), CAST(N'2019-11-20T15:54:14.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (59, 31, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:56:01.000' AS DateTime), CAST(N'2019-11-20T15:56:01.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (60, 44, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T15:57:00.000' AS DateTime), CAST(N'2019-11-20T15:57:00.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (62, 74, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T16:00:05.000' AS DateTime), CAST(N'2019-11-20T16:00:05.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (63, 50, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T16:04:12.000' AS DateTime), CAST(N'2019-11-20T16:04:12.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (64, 22, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:06:51.000' AS DateTime), CAST(N'2019-11-20T16:06:51.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (65, 51, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 1, 0, 0, NULL, 0, CAST(N'2019-11-20T16:08:20.000' AS DateTime), CAST(N'2019-11-20T16:08:20.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (67, 32, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:11:04.000' AS DateTime), CAST(N'2019-11-20T16:11:04.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (68, 115, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:12:05.000' AS DateTime), CAST(N'2019-11-20T16:12:05.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (71, 62, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:17:02.000' AS DateTime), CAST(N'2019-11-20T16:17:02.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (72, 88, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:17:57.000' AS DateTime), CAST(N'2019-11-20T16:17:57.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (73, 96, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:18:42.000' AS DateTime), CAST(N'2019-11-20T16:18:42.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (74, 25, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:20:21.000' AS DateTime), CAST(N'2019-11-20T16:20:21.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (75, 43, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:21:24.000' AS DateTime), CAST(N'2019-11-20T16:21:24.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (76, 95, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:22:16.000' AS DateTime), CAST(N'2019-11-20T16:22:16.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (77, 100, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:23:10.000' AS DateTime), CAST(N'2019-11-20T16:23:10.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (78, 97, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:25:41.000' AS DateTime), CAST(N'2019-11-20T16:25:41.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (81, 10, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:36:26.000' AS DateTime), CAST(N'2019-11-20T16:36:26.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (84, 98, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:41:06.000' AS DateTime), CAST(N'2019-11-20T16:41:06.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (85, 112, 2, 1, 1, N' ', 1, CAST(N'2019-11-20' AS Date), NULL, NULL, NULL, NULL, 9, 8, 1, 1, 1, 1, 1, 0, 0, 0, NULL, 0, CAST(N'2019-11-20T16:42:01.000' AS DateTime), CAST(N'2019-11-20T16:42:01.000' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (87, 1, 0, 1, 3, N'test', 3, CAST(N'2021-06-30' AS Date), NULL, NULL, NULL, NULL, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, CAST(N'2021-07-08T14:52:01.647' AS DateTime), CAST(N'2021-07-08T14:52:01.647' AS DateTime))
INSERT [dbo].[work_schedule] ([id], [user_id], [type], [break_type], [rooster_break], [destination_entitlement], [shift_type], [effective_date], [check_in], [check_out], [between_start], [between_end], [shift_length], [paid_hours], [monday], [tuesday], [wednesday], [thursday], [friday], [saturday], [sunday], [onsite], [created_by], [updated_by], [created_at], [updated_at]) VALUES (88, 120, 0, 2, 4, NULL, 4, CAST(N'2021-07-01' AS Date), NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, CAST(N'2021-08-03T15:00:01.000' AS DateTime), CAST(N'2021-08-03T15:00:01.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[work_schedule] OFF
GO
/****** Object:  Index [fk_i_cp]    Script Date: 8/19/2021 2:25:24 AM ******/
CREATE NONCLUSTERED INDEX [fk_i_cp] ON [dbo].[interview]
(
	[candidate_profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [fk_cp_id]    Script Date: 8/19/2021 2:25:24 AM ******/
CREATE NONCLUSTERED INDEX [fk_cp_id] ON [dbo].[interview_ratings]
(
	[interview_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[adjustment] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[adjustment] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[adjustment] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[adjustment] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[announcement] ADD  DEFAULT (NULL) FOR [slug]
GO
ALTER TABLE [dbo].[announcement] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[announcement] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[approvers] ADD  DEFAULT (NULL) FOR [primary_approver_id]
GO
ALTER TABLE [dbo].[approvers] ADD  DEFAULT (NULL) FOR [backup_approver_id]
GO
ALTER TABLE [dbo].[approvers] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[approvers] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[approvers] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[approvers] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[biometric_csv] ADD  DEFAULT (NULL) FOR [site]
GO
ALTER TABLE [dbo].[biometric_logs] ADD  DEFAULT (NULL) FOR [ip_address]
GO
ALTER TABLE [dbo].[biometric_number] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[biometric_number] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[biometrics] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[biometrics] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (NULL) FOR [address]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (NULL) FOR [country_id]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[branches] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[branding] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[branding] ADD  DEFAULT (NULL) FOR [logo]
GO
ALTER TABLE [dbo].[branding] ADD  DEFAULT (NULL) FOR [branding]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [primary_status]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT ((1)) FOR [backup_status]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [primary_approver]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [backup_approver]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [approver_note]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [approved_by]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [_token]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[business_trip] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [shortid]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [current_address]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [permanent_address]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [alternate_number]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [birthday]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [gender]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [marital_status]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [nationality]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [interview_schedule]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [attachment]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [sss_number]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [pagibig_number]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [tin_number]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [philhealth_number]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT ((1)) FOR [interview_status]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [company]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [department]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [job_title]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [start_date]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[candidate_profile] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [code]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [logo]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[companies] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[configuration] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[configuration] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[countries] ADD  DEFAULT (NULL) FOR [code]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [account]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [project_site]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [type]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [revenue]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [sales]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[crm_chase] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[crm_clone] ADD  DEFAULT (NULL) FOR [sqm]
GO
ALTER TABLE [dbo].[crm_clone] ADD  DEFAULT (NULL) FOR [reason]
GO
ALTER TABLE [dbo].[crm_clone] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[crm_clone] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[crm_clone] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[crm_clone] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[custom_approver] ADD  DEFAULT (NULL) FOR [primary_approver_id]
GO
ALTER TABLE [dbo].[custom_approver] ADD  DEFAULT (NULL) FOR [backup_approver_id]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (NULL) FOR [assistant_manager_id]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (NULL) FOR [deletedAt]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [year]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [month]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [period]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [date]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT ((1)) FOR [primary_status]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT ((1)) FOR [backup_status]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [primary_approver]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [backup_approver]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT ((1)) FOR [admin_status]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [_token]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [document]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[dispute] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [code]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [manager_id]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [assistant_manager_id]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [secretary_id]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [deletedAt]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[divisions] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [school]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [degree]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [year_attended]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [post_graduate]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [others]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[educations] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[employee_type] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[employee_type] ADD  DEFAULT (NULL) FOR [createdAt]
GO
ALTER TABLE [dbo].[employee_type] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__emplo__5614BF03]  DEFAULT (NULL) FOR [employee_number]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__compa__5708E33C]  DEFAULT (NULL) FOR [company_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__compa__57FD0775]  DEFAULT (NULL) FOR [company_branch_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__divis__58F12BAE]  DEFAULT (NULL) FOR [division_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__depar__59E54FE7]  DEFAULT (NULL) FOR [department_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__secti__5AD97420]  DEFAULT (NULL) FOR [section_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__posit__5BCD9859]  DEFAULT (NULL) FOR [position_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__posit__5CC1BC92]  DEFAULT (NULL) FOR [position_classification_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__posit__5DB5E0CB]  DEFAULT (NULL) FOR [position_category_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__appro__5EAA0504]  DEFAULT (N'') FOR [approving_organization]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__work___5F9E293D]  DEFAULT (NULL) FOR [work_area_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__branc__60924D76]  DEFAULT (NULL) FOR [branch_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__date___618671AF]  DEFAULT (NULL) FOR [date_entry]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__date___627A95E8]  DEFAULT (NULL) FOR [date_exit]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__comme__636EBA21]  DEFAULT (NULL) FOR [comment]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__statu__6462DE5A]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__team___65570293]  DEFAULT (NULL) FOR [team_id]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__creat__664B26CC]  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__updat__673F4B05]  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__creat__68336F3E]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[employments] ADD  CONSTRAINT [DF__employmen__updat__69279377]  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[events] ADD  DEFAULT (NULL) FOR [end_date]
GO
ALTER TABLE [dbo].[events] ADD  DEFAULT (NULL) FOR [comment]
GO
ALTER TABLE [dbo].[events] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[events] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (NULL) FOR [country_id]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (NULL) FOR [location_id]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[holidays] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT (NULL) FOR [from]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT (NULL) FOR [to]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT (NULL) FOR [period]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT ((0)) FOR [taxable]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[incentive] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[interview] ADD  DEFAULT (NULL) FOR [overall_assessment]
GO
ALTER TABLE [dbo].[interview] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[interview] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[interview] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[interview] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[interview_ratings] ADD  DEFAULT (NULL) FOR [notes]
GO
ALTER TABLE [dbo].[leave_credit_policy] ADD  DEFAULT (NULL) FOR [balance]
GO
ALTER TABLE [dbo].[leave_credit_policy] ADD  DEFAULT (NULL) FOR [utilized]
GO
ALTER TABLE [dbo].[leave_credit_policy] ADD  DEFAULT (NULL) FOR [cycle]
GO
ALTER TABLE [dbo].[leave_credit_policy] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[leave_credit_policy] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [gender]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [initial]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [increment]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [max_increment]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [company]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [department]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [carry_over]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[leave_policy] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [dates]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [other]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [reason]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [attachment]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT ((1)) FOR [primary_status]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [backup_status]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [primary_approver]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [backup_approver]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [approver_note]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [_token]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [is_hr]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[leaves] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [date_to_pay]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [frequency]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [year]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [month]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [period]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[loan] ADD  DEFAULT (NULL) FOR [loan_type]
GO
ALTER TABLE [dbo].[loan_payments] ADD  DEFAULT (NULL) FOR [month]
GO
ALTER TABLE [dbo].[loan_payments] ADD  DEFAULT (NULL) FOR [period]
GO
ALTER TABLE [dbo].[loan_payments] ADD  DEFAULT (NULL) FOR [amount]
GO
ALTER TABLE [dbo].[loan_payments] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[locations] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[locations] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[logs] ADD  DEFAULT (NULL) FOR [message]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[notification] ADD  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[notification] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[notification] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[notification_receiver] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[notification_receiver] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[notification_receiver] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [start_date]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [end_date]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [start_time]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [end_time]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [actual_check_in]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [actual_check_out]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [purpose]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [primary_status]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [backup_status]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [primary_approver]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [backup_approver]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [approver_note]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [_token]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[overtimes] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[payroll] ADD  DEFAULT (NULL) FOR [attachment]
GO
ALTER TABLE [dbo].[payroll] ADD  DEFAULT (NULL) FOR [date]
GO
ALTER TABLE [dbo].[payroll_group] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[payroll_period] ADD  DEFAULT (NULL) FOR [payroll_day]
GO
ALTER TABLE [dbo].[payroll_period] ADD  DEFAULT (NULL) FOR [payroll_day_from]
GO
ALTER TABLE [dbo].[payroll_period] ADD  DEFAULT (NULL) FOR [payroll_day_to]
GO
ALTER TABLE [dbo].[payroll_period] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[payroll_period] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [user_id]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [employee_number]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [employee_name]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [monthly_rate]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [this_pay]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [absence]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [overtime_hrs]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [amount]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [gross_pay]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [reimburseable_allowance]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [other_fees_allowances]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [total_pay]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [tax]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [sss30th]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [phic30th]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [pagibig30th]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [other_deductions]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [sss_loan15th]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [pagibig_loan15th]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [employee_charges]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [intellicare]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [net_pay]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[payslips] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT (N'') FOR [name]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[positions_category] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[positions_category] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[positions_category] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[positions_classification] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[positions_classification] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[positions_classification] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (NULL) FOR [candidate_id]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[requirements] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[role] ADD  DEFAULT (NULL) FOR [slug]
GO
ALTER TABLE [dbo].[role] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[role] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[role] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[role] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT (NULL) FOR [role_id]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT (NULL) FOR [module_tag]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT ((0)) FOR [read]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT ((0)) FOR [write]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT ((0)) FOR [modify]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT ((0)) FOR [delete]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[role_permission] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[salary] ADD  DEFAULT (NULL) FOR [start_date]
GO
ALTER TABLE [dbo].[salary] ADD  DEFAULT (NULL) FOR [end_date]
GO
ALTER TABLE [dbo].[salary] ADD  DEFAULT ((2)) FOR [payroll]
GO
ALTER TABLE [dbo].[salary] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[salary] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [section_name]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [section_code]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [supervisor_id]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [assistant_supervisor_id]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [secretary_id]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [deletedAt]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[sections] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [credit_time_in]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [credit_time_out]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [time_in]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [time_out]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [gp]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [break_in]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [break_out]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [num_hours]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [cbamin]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [cbamout]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [cbpmin]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [cbpmout]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [trig_late]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [trig_under]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [early_in]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [early_out]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [late_in]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [late_out]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [flex_am_break]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [flex_pm_break]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [flex_break]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [min_ot]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [hday_by_late]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [break_hours]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [seq_id]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [gp2]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [min_workhours_1h]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [min_workhours_2h]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [created_terminal]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [updated_terminal]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[shift_type] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [check_in]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [check_out]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [actual_check_in]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [actual_check_out]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [between_start]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [between_end]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT ((1)) FOR [primary_status]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [backup_status]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [shift_length]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [paid_hours]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [primary_approver]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [backup_approver]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [approver_note]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT ((0)) FOR [onsite]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [_token]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [approved_by]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [approved_at]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[shifts] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (NULL) FOR [code]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (NULL) FOR [node]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT ((0)) FOR [system_role]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[taxonomy] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[temp_in_out] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[temp_in_out] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[two_factor_authentication] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[two_factor_authentication] ADD  DEFAULT (NULL) FOR [code]
GO
ALTER TABLE [dbo].[two_factor_authentication] ADD  DEFAULT (NULL) FOR [validity_date]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [date]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [time]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [reason]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [primary_status]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [backup_status]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [primary_approver]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [backup_approver]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [approver_note]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [_token]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[undertime] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[user_setting] ADD  DEFAULT (NULL) FOR [has_holiday]
GO
ALTER TABLE [dbo].[user_setting] ADD  DEFAULT (NULL) FOR [has_overtime]
GO
ALTER TABLE [dbo].[user_setting] ADD  DEFAULT ((1)) FOR [work_schedule_method]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [middle_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [suffix]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [nick_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [birthdate]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [avatar]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [present_address]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [permanent_address]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [nationality]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [marital_status]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [contact_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [password]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [user_role]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [sss_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [pagibig_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [tin_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [philhealth_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [employee_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [company_branch_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [department_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [job_title_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [team_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [date_entry]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [resignation_date]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [reset_token]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [employee_type]
GO
ALTER TABLE [dbo].[users_document] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[users_document] ADD  DEFAULT (NULL) FOR [hash]
GO
ALTER TABLE [dbo].[users_document] ADD  DEFAULT (NULL) FOR [original_name]
GO
ALTER TABLE [dbo].[users_document] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[users_document] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users_document] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dbo].[work_areas] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[work_areas] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[work_areas] ADD  DEFAULT (NULL) FOR [updatedAt]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [destination_entitlement]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [check_in]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [check_out]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [between_start]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [between_end]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [monday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [tuesday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [wednesday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [thursday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [friday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [saturday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [sunday]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT ((0)) FOR [onsite]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[work_schedule] ADD  DEFAULT (NULL) FOR [updated_at]
GO
USE [master]
GO
ALTER DATABASE [philsaga] SET  READ_WRITE 
GO
