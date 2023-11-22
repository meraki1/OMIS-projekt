USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[GeneriranjeKomisionirnogListaIspisOrderBasics]    Script Date: 22.11.2023. 22:13:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GeneriranjeKomisionirnogListaIspisOrderBasics]
    @orderID INT
AS
BEGIN
    -- Retrieve basic information about order and employee who is doing the order
	SELECT Narudžba.[ID narudžbe], Kupac.Ime as "Kupac", Narudžba.[Datum primitka], Kupac.[Broj telefona], Kupac.Email, Kupac.Ime, Kupac.Prezime, 
	Zaposlenik.[ID zaposlenik], CONCAT(Zaposlenik.[Ime], ' ', Zaposlenik.[Prezime]) as 'Zaposlenik'
    FROM Narudžba
	INNER JOIN Kupac ON Narudžba.[ID kupac] = Kupac.[ID kupac]
    INNER JOIN Status ON Narudžba.[ID statusa] = Status.[ID statusa]
	LEFT OUTER JOIN Zaposlenik ON Narudžba.[ID zaposlenik] = Zaposlenik.[ID zaposlenik]
	LEFT OUTER JOIN Prijevoznik ON Narudžba.[ID prijevoznik] = Prijevoznik.[ID prijevoznik]        
    WHERE @orderID = Narudžba.[ID narudžbe]
END
GO

