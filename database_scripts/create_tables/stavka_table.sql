USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Stavka]    Script Date: 22.11.2023. 22:09:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stavka](
	[ID stavka] [int] IDENTITY(1,1) NOT NULL,
	[Količina] [int] NOT NULL,
	[Rab, %] [decimal](5, 2) NULL,
	[ID artikl] [int] NOT NULL,
	[ID narudžba] [int] NOT NULL,
 CONSTRAINT [PK__Stavka__451FABEE1A1CD871] PRIMARY KEY CLUSTERED 
(
	[ID stavka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Stavka]  WITH CHECK ADD  CONSTRAINT [FK__Stavka__ID_artik__5DCAEF64] FOREIGN KEY([ID artikl])
REFERENCES [dbo].[Artikl] ([ID artikl])
GO

ALTER TABLE [dbo].[Stavka] CHECK CONSTRAINT [FK__Stavka__ID_artik__5DCAEF64]
GO

ALTER TABLE [dbo].[Stavka]  WITH CHECK ADD  CONSTRAINT [FK_Stavka_Narudžba] FOREIGN KEY([ID narudžba])
REFERENCES [dbo].[Narudžba] ([ID narudžbe])
GO

ALTER TABLE [dbo].[Stavka] CHECK CONSTRAINT [FK_Stavka_Narudžba]
GO

