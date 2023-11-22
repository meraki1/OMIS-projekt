USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[SearchArtikli]    Script Date: 22.11.2023. 22:15:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchArtikli]
    @searchValue NVARCHAR(100)
AS
BEGIN
    SELECT Artikl.[ID artikl], Artikl.[Jedinična cijena (bez PDV-a)], Artikl.Jmj, Artikl.Naziv, Artikl.Opis, [Skladišna lokacija].[Skladišna lokacija]
    FROM Artikl
    INNER JOIN [Skladišna lokacija] ON Artikl.[ID skladišna lokacija] = [Skladišna lokacija].[ID skladišna lokacija]
    WHERE Artikl.Naziv LIKE '%' + @searchValue + '%'
END
GO

