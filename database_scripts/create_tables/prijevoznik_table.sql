USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Prijevoznik]    Script Date: 22.11.2023. 22:08:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Prijevoznik](
	[ID prijevoznik] [int] IDENTITY(1,1) NOT NULL,
	[Naziv] [varchar](50) NOT NULL,
	[Broj telefona] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
 CONSTRAINT [PK__Prijevoz__A9B270404F8FA9B8] PRIMARY KEY CLUSTERED 
(
	[ID prijevoznik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

