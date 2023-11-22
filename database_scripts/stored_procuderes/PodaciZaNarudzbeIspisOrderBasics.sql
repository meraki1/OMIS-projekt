USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[PodaciZaNarudzbeIspisOrderBasics]    Script Date: 22.11.2023. 22:14:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PodaciZaNarudzbeIspisOrderBasics]
    @orderID INT
AS
BEGIN
    -- Retrieve basic information about order
	SELECT Narudžba.[ID narudžbe], Kupac.Ime as "Kupac", Narudžba.[Datum primitka], Narudžba.[Datum isporuke], Prijevoznik.[Naziv] as "Prijevoznik", 
		Kupac.Adresa, Kupac.[Broj telefona], Kupac.Email, Kupac.Ime, Kupac.Prezime
    FROM Narudžba
	INNER JOIN Kupac ON Narudžba.[ID kupac] = Kupac.[ID kupac]
	LEFT OUTER JOIN Prijevoznik ON Narudžba.[ID prijevoznik] = Prijevoznik.[ID prijevoznik]
	INNER JOIN Stavka ON Narudžba.[ID statusa] = Stavka.[ID narudžba]
		INNER JOIN Artikl ON Stavka.[ID artikl] = Artikl.[ID artikl]        
    WHERE @orderID = Narudžba.[ID narudžbe]
END
GO

