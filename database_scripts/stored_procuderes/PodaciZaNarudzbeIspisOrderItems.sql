USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[PodaciZaNarudzbeIspisOrderItems]    Script Date: 22.11.2023. 22:15:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PodaciZaNarudzbeIspisOrderItems]
    @orderID INT
AS
BEGIN
    -- Retrieve information about items in order
    SELECT Artikl.[ID artikl], Artikl.Naziv, Artikl.Opis, Stavka.Količina, Artikl.Jmj, Artikl.[Jedinična cijena (bez PDV-a)], Stavka.[Rab, %]
    FROM Narudžba
	INNER JOIN Stavka ON Narudžba.[ID statusa] = Stavka.[ID narudžba]
		INNER JOIN Artikl ON Stavka.[ID artikl] = Artikl.[ID artikl]        
    WHERE @orderID = Narudžba.[ID narudžbe]
END
GO

