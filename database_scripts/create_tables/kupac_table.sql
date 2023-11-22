USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Kupac]    Script Date: 22.11.2023. 22:08:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kupac](
	[ID kupac] [int] NOT NULL,
	[Ime] [varchar](50) NULL,
	[OIB] [varchar](11) NOT NULL,
	[Email] [varchar](100) NULL,
	[Prezime] [varchar](50) NULL,
	[Naziv] [varchar](100) NOT NULL,
	[Broj telefona] [varchar](50) NULL,
	[Adresa] [varchar](50) NULL,
 CONSTRAINT [PK__Kupac__9AE7529B9D714AE6] PRIMARY KEY CLUSTERED 
(
	[ID kupac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

