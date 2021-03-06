USE [master]
GO
/****** Object:  Database [ZhedShop]    Script Date: 10/16/2016 2:19:32 PM ******/
CREATE DATABASE [ZhedShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'zhed_shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014EXPRESS\MSSQL\DATA\zhed_shop.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'zhed_shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014EXPRESS\MSSQL\DATA\zhed_shop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ZhedShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ZhedShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ZhedShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ZhedShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ZhedShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ZhedShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [ZhedShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ZhedShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ZhedShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ZhedShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ZhedShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ZhedShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ZhedShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ZhedShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ZhedShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ZhedShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ZhedShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ZhedShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ZhedShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ZhedShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ZhedShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ZhedShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ZhedShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ZhedShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ZhedShop] SET  MULTI_USER 
GO
ALTER DATABASE [ZhedShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ZhedShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ZhedShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ZhedShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ZhedShop]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/16/2016 2:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [varchar](10) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[Remarks] [varchar](200) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Item]    Script Date: 10/16/2016 2:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [varchar](50) NOT NULL,
	[Barcode] [varchar](20) NOT NULL,
	[ItemName] [varchar](200) NOT NULL,
	[Category] [varchar](10) NOT NULL,
	[Picture] [varchar](200) NOT NULL,
	[Price] [decimal](18, 2) NULL,
	[Remarks] [varchar](200) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log]    Script Date: 10/16/2016 2:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[LogID] [varchar](12) NOT NULL,
	[Content] [varchar](max) NOT NULL,
	[Remarks] [varchar](200) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/16/2016 2:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderHeaderID] [varchar](64) NOT NULL,
	[OrderDetailID] [varchar](64) NOT NULL,
	[ItemID] [varchar](20) NOT NULL,
	[ItemPrice] [decimal](18, 2) NOT NULL,
	[Qty] [int] NOT NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderHeader]    Script Date: 10/16/2016 2:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderHeader](
	[OrderHeaderID] [varchar](64) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[CustomerName] [varchar](50) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[ShippingFee] [decimal](18, 2) NOT NULL,
	[ShippingCourier] [varchar](20) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderHeader] PRIMARY KEY CLUSTERED 
(
	[OrderHeaderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Remarks]) VALUES (N'Health', N'Health', N'Remarks for Healt')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Remarks]) VALUES (N'Kids', N'Kids', N'Remarks for Kids')
INSERT [dbo].[Item] ([ItemID], [Barcode], [ItemName], [Category], [Picture], [Price], [Remarks]) VALUES (N'A-001', N'A-001', N'Honey Bee - Kuda Goyang', N'Kids', N'images/items/z-001.png', CAST(259200.00 AS Decimal(18, 2)), N'-')
INSERT [dbo].[Item] ([ItemID], [Barcode], [ItemName], [Category], [Picture], [Price], [Remarks]) VALUES (N'A-002', N'A-002', N'Ocean Toy - Raket Tenis Besar Multiwarna', N'Kids', N'images/items/z-002.png', CAST(29900.00 AS Decimal(18, 2)), N'-')
INSERT [dbo].[Item] ([ItemID], [Barcode], [ItemName], [Category], [Picture], [Price], [Remarks]) VALUES (N'A-003', N'A-003', N'Flat Ball Disc Deformed Flying Frisbee to Ball', N'Kids', N'images/items/z-003.png', CAST(109700.00 AS Decimal(18, 2)), N'-')
INSERT [dbo].[Item] ([ItemID], [Barcode], [ItemName], [Category], [Picture], [Price], [Remarks]) VALUES (N'A-004', N'A-004', N'Buddy Tag with Sillicone Wristband', N'Kids', N'images/items/z-004.png', CAST(659000.00 AS Decimal(18, 2)), N'-')
INSERT [dbo].[Item] ([ItemID], [Barcode], [ItemName], [Category], [Picture], [Price], [Remarks]) VALUES (N'A-005', N'A-005', N'Bestway Tenda Rumah Bermain Anak Play House', N'Kids', N'images/items/z-005.png', CAST(180100.00 AS Decimal(18, 2)), N'-')
INSERT [dbo].[Item] ([ItemID], [Barcode], [ItemName], [Category], [Picture], [Price], [Remarks]) VALUES (N'A-006', N'A-006', N'TSH - Mainan Slime Korea 4 Warna 1 Buah', N'Kids', N'images/items/z-006.png', CAST(23000.00 AS Decimal(18, 2)), N'-')
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'b21f238c-dc7e-412a-a6dd-b276b8abfe13', N'2eb539bb-1950-4432-a90e-68ae7743795e', N'A-003', CAST(109700.00 AS Decimal(18, 2)), 1, CAST(109700.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'4b02751f-836d-41ea-a624-b98b167404f1', N'3e5d6d24-a4be-4f51-a0e8-9524d0518c1b', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'7e6a0999-a371-410a-baa1-e9bbb0fed235', N'645d1f44-8c35-4095-843c-93e06443897f', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'43f74dad-9028-46f0-b7ef-ea2752dc5590', N'68e9f098-1d8c-4705-a4d4-14eb2e062958', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'48ec26b0-3c77-4016-8781-91ee9d05f176', N'6f7ff5cf-3915-4889-987e-d8e1946f8820', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'aae6bab8-4a5e-4ed1-8d69-c634c21458c6', N'878614f8-2fc0-48ce-ae98-77b8915ec084', N'A-003', CAST(109700.00 AS Decimal(18, 2)), 1, CAST(109700.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'80ec2781-9249-4368-9f01-2e09398fbdc4', N'8fd7901f-3465-4402-9ed6-a0c74ffc2d7c', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'fb56c9ed-c5c8-4c88-89df-6ebc81fa4561', N'b368fc1c-4266-4a86-a5e7-ebb2b904ff2f', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderHeaderID], [OrderDetailID], [ItemID], [ItemPrice], [Qty], [Subtotal]) VALUES (N'8859ca34-1ddd-4773-be72-b14ab26e89c7', N'f2693166-3240-49e8-8984-8affdc811ba7', N'A-002', CAST(29900.00 AS Decimal(18, 2)), 1, CAST(29900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'43f74dad-9028-46f0-b7ef-ea2752dc5590', CAST(N'2016-10-16' AS Date), N'XXXX', N'ASD', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'48ec26b0-3c77-4016-8781-91ee9d05f176', CAST(N'2016-10-16' AS Date), N'XXX', N'XXXX', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'4b02751f-836d-41ea-a624-b98b167404f1', CAST(N'2016-10-16' AS Date), N'XXX', N'SDS', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'7e6a0999-a371-410a-baa1-e9bbb0fed235', CAST(N'2016-10-16' AS Date), N'XXXX', N'ASD', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'80ec2781-9249-4368-9f01-2e09398fbdc4', CAST(N'2016-10-16' AS Date), N'Huda', N'XXX', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'8859ca34-1ddd-4773-be72-b14ab26e89c7', CAST(N'2016-10-16' AS Date), N'Huda', N'AD', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'aae6bab8-4a5e-4ed1-8d69-c634c21458c6', CAST(N'2016-10-16' AS Date), N'XXX', N'SSS', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'b21f238c-dc7e-412a-a6dd-b276b8abfe13', CAST(N'2016-10-16' AS Date), N'AA', N'ADS', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderHeader] ([OrderHeaderID], [OrderDate], [CustomerName], [Address], [ShippingFee], [ShippingCourier], [Total]) VALUES (N'fb56c9ed-c5c8-4c88-89df-6ebc81fa4561', CAST(N'2016-10-16' AS Date), N'XXX', N'XXXX', CAST(50000.00 AS Decimal(18, 2)), N'DHL Express', CAST(0.00 AS Decimal(18, 2)))
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Category] FOREIGN KEY([Category])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Category]
GO
USE [master]
GO
ALTER DATABASE [ZhedShop] SET  READ_WRITE 
GO
