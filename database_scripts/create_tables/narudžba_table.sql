USE [Karlo_Miskovic]
GO

/****** Object:  Table [dbo].[Narudžba]    Script Date: 22.11.2023. 22:08:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Narudžba](
	[ID narudžbe] [int] NOT NULL,
	[Datum primitka] [date] NOT NULL,
	[Datum isporuke] [date] NULL,
	[ID zaposlenik] [int] NULL,
	[ID prijevoznik] [int] NOT NULL,
	[ID kupac] [int] NOT NULL,
	[ID statusa] [int] NOT NULL,
 CONSTRAINT [PK__Narudžba__5DAA6A8C04593D53] PRIMARY KEY CLUSTERED 
(
	[ID narudžbe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Narudžba]  WITH CHECK ADD  CONSTRAINT [FK__Narudžba__ID_kup__59FA5E80] FOREIGN KEY([ID kupac])
REFERENCES [dbo].[Kupac] ([ID kupac])
GO

ALTER TABLE [dbo].[Narudžba] CHECK CONSTRAINT [FK__Narudžba__ID_kup__59FA5E80]
GO

ALTER TABLE [dbo].[Narudžba]  WITH CHECK ADD  CONSTRAINT [FK__Narudžba__ID_pri__59063A47] FOREIGN KEY([ID prijevoznik])
REFERENCES [dbo].[Prijevoznik] ([ID prijevoznik])
GO

ALTER TABLE [dbo].[Narudžba] CHECK CONSTRAINT [FK__Narudžba__ID_pri__59063A47]
GO

ALTER TABLE [dbo].[Narudžba]  WITH CHECK ADD  CONSTRAINT [FK_Narudžba_Status] FOREIGN KEY([ID statusa])
REFERENCES [dbo].[Status] ([ID statusa])
GO

ALTER TABLE [dbo].[Narudžba] CHECK CONSTRAINT [FK_Narudžba_Status]
GO

ALTER TABLE [dbo].[Narudžba]  WITH CHECK ADD  CONSTRAINT [FK_Narudžba_Zaposlenik] FOREIGN KEY([ID zaposlenik])
REFERENCES [dbo].[Zaposlenik] ([ID zaposlenik])
GO

ALTER TABLE [dbo].[Narudžba] CHECK CONSTRAINT [FK_Narudžba_Zaposlenik]
GO

