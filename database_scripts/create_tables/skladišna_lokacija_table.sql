USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Skladišna lokacija]    Script Date: 22.11.2023. 22:09:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Skladišna lokacija](
	[ID skladišna lokacija] [int] IDENTITY(1,1) NOT NULL,
	[Skladišna lokacija] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Skladišna lokacija] PRIMARY KEY CLUSTERED 
(
	[ID skladišna lokacija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

