USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[InsertStavka]    Script Date: 22.11.2023. 22:14:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertStavka]
    @Kolicina INT,
    @Rab DECIMAL(10, 2),
    @NazivArtikl NVARCHAR(100),
    @IDNarudzba INT
AS
BEGIN
    DECLARE @IDartikl INT
    
    SELECT @IDartikl = [ID artikl]
    FROM Artikl
    WHERE Artikl.[Naziv] = @NazivArtikl
    
    INSERT INTO Stavka (Količina, [Rab, %], [ID artikl], [ID narudžba])
    VALUES (@Kolicina, @Rab, @IDartikl, @IDNarudzba)
END

GO

