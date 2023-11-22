USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[PodaciZaDetailsPopup]    Script Date: 22.11.2023. 22:14:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PodaciZaDetailsPopup]
    @orderID INT
AS
BEGIN
    SELECT
        Narudžba.[ID narudžbe],
        Stavka.[ID stavka],
        Artikl.Naziv,
        Artikl.Opis,
        Stavka.Količina,
        Artikl.Jmj,
        Artikl.[Jedinična cijena (bez PDV-a)],
        Stavka.[Rab, %]
	FROM
        Narudžba
        INNER JOIN Stavka ON Narudžba.[ID narudžbe] = Stavka.[ID narudžba]
        INNER JOIN Artikl ON Stavka.[ID artikl] = Artikl.[ID artikl]
    WHERE
        Narudžba.[ID narudžbe] = @orderID
END
GO

