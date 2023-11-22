USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[CRUDFormArtikli]    Script Date: 22.11.2023. 22:11:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRUDFormArtikli]
    @Operation CHAR(1),
    @IDArtikl INT = NULL,
    @Naziv NVARCHAR(100) = NULL,
    @Cijena decimal(18, 2) = NULL,
    @Jmj NVARCHAR(50) = NULL,
    @Opis NVARCHAR(MAX) = NULL,
    @SkladisteLokacija NVARCHAR(50) = NULL
AS
BEGIN
	DECLARE @IDskladiste INT
    
    SELECT @IDskladiste = [ID skladišna lokacija]
    FROM [Skladišna lokacija]
    WHERE [Skladišna lokacija] = @SkladisteLokacija
    
	IF @Operation = 'C'
        INSERT INTO Artikl (Naziv, [Jedinična cijena (bez PDV-a)], Jmj, Opis, [ID skladišna lokacija])
        VALUES (@Naziv, @Cijena, @Jmj, @Opis, @IDskladiste)
	ELSE IF @Operation = 'U'
        UPDATE Artikl
        SET Naziv = @Naziv,
            [Jedinična cijena (bez PDV-a)] = @Cijena,
            Jmj = @Jmj,
            Opis = @Opis,
            [ID skladišna lokacija] = @IDskladiste
        WHERE [ID artikl] = @IDArtikl
    ELSE IF @Operation = 'R'
        SELECT Artikl.[ID artikl], Artikl.[Jedinična cijena (bez PDV-a)], Artikl.Jmj, Artikl.Naziv, Artikl.Opis, [Skladišna lokacija].[Skladišna lokacija]
		FROM Artikl
		INNER JOIN [Skladišna lokacija]
			ON Artikl.[ID skladišna lokacija] = [Skladišna lokacija].[ID skladišna lokacija]    
    ELSE IF @Operation = 'D'
        DELETE FROM Artikl WHERE [ID artikl] = @IDArtikl
END
GO

