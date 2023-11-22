USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Artikl]    Script Date: 22.11.2023. 22:08:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Artikl](
	[ID artikl] [int] IDENTITY(1,1) NOT NULL,
	[Naziv] [varchar](100) NOT NULL,
	[Jedinična cijena (bez PDV-a)] [decimal](18, 2) NULL,
	[Jmj] [varchar](10) NOT NULL,
	[Opis] [varchar](500) NULL,
	[ID skladišna lokacija] [int] NULL,
 CONSTRAINT [PK__Artikl__A7CE42D987C3C268] PRIMARY KEY CLUSTERED 
(
	[ID artikl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Artikl]  WITH CHECK ADD  CONSTRAINT [FK_Artikl_Skladišna lokacija] FOREIGN KEY([ID skladišna lokacija])
REFERENCES [dbo].[Skladišna lokacija] ([ID skladišna lokacija])
GO

ALTER TABLE [dbo].[Artikl] CHECK CONSTRAINT [FK_Artikl_Skladišna lokacija]
GO

