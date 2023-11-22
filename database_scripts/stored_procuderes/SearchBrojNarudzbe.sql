USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[SearchBrojNarudzbe]    Script Date: 22.11.2023. 22:16:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchBrojNarudzbe]
    @searchValue NVARCHAR
AS
BEGIN
    SELECT Narudžba.[ID narudžbe], Kupac.Ime as 'Kupac', CONCAT(Zaposlenik.[ID zaposlenik], ' - ', Zaposlenik.[Ime], ' ', Zaposlenik.[Prezime]) as 'ID - Zaposlenik', Narudžba.[Datum primitka], Narudžba.[Datum isporuke], Prijevoznik.[Naziv] as 'Prijevoznik', Status.[Naziv statusa] as 'Status'
    FROM Narudžba
    INNER JOIN Kupac ON Narudžba.[ID kupac] = Kupac.[ID kupac]
    INNER JOIN Status ON Narudžba.[ID statusa] = Status.[ID statusa]
	LEFT OUTER JOIN Zaposlenik ON Narudžba.[ID zaposlenik] = Zaposlenik.[ID zaposlenik]
	LEFT OUTER JOIN Prijevoznik ON Narudžba.[ID prijevoznik] = Prijevoznik.[ID prijevoznik]
	WHERE [ID narudžbe] LIKE '%' + @searchValue + '%'
END
GO

