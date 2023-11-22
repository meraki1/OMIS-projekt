USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Zaposlenik]    Script Date: 22.11.2023. 22:09:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Zaposlenik](
	[Ime] [varchar](50) NOT NULL,
	[Prezime] [varchar](50) NOT NULL,
	[OIB] [varchar](11) NOT NULL,
	[ID zaposlenik] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID zaposlenik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

