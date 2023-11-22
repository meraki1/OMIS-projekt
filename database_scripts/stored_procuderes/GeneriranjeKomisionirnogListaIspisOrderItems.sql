USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[GeneriranjeKomisionirnogListaIspisOrderItems]    Script Date: 22.11.2023. 22:13:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GeneriranjeKomisionirnogListaIspisOrderItems]
    @orderID INT
AS
BEGIN
    -- Retrieve basic information about order items
	SELECT Artikl.[ID artikl], Artikl.Naziv, Artikl.Opis, Stavka.Količina, Artikl.Jmj, [Skladišna lokacija].[Skladišna lokacija]
    FROM Narudžba
	INNER JOIN Stavka ON Narudžba.[ID statusa] = Stavka.[ID narudžba]
		INNER JOIN Artikl ON Stavka.[ID artikl] = Artikl.[ID artikl]
		INNER JOIN [Skladišna lokacija] ON Artikl.[ID skladišna lokacija] = [Skladišna lokacija].[ID skladišna lokacija]
    WHERE @orderID = Narudžba.[ID narudžbe]
END
GO

