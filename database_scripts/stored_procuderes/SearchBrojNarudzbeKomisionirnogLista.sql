USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[SearchBrojNarudzbeKomisionirnogLista]    Script Date: 22.11.2023. 22:16:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchBrojNarudzbeKomisionirnogLista]
    @searchValue NVARCHAR
AS
BEGIN
    SELECT Narudžba.[ID narudžbe], CONCAT(Zaposlenik.[ID zaposlenik], ' - ', Zaposlenik.[Ime], ' ', Zaposlenik.[Prezime]) as 'ID - Zaposlenik'
    FROM Narudžba
    INNER JOIN Status ON Narudžba.[ID statusa] = Status.[ID statusa]
	LEFT OUTER JOIN Zaposlenik ON Narudžba.[ID zaposlenik] = Zaposlenik.[ID zaposlenik]
	WHERE [ID narudžbe] LIKE '%' + @searchValue + '%' 
	AND Status.[Naziv statusa] = 'U obradi'
END
GO

