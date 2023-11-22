USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[CRUDFormPrijevoznik]    Script Date: 22.11.2023. 22:11:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRUDFormPrijevoznik]
    @Operation CHAR(1),
    @IDPrijevoznik INT = NULL,
    @Naziv NVARCHAR(100) = NULL,
    @BrojTelefona NVARCHAR(50) = NULL,
    @Email NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operation = 'C'
        INSERT INTO Prijevoznik (Naziv, [Broj telefona], Email)
        VALUES (@Naziv, @BrojTelefona, @Email)
    ELSE IF @Operation = 'R'
        SELECT * FROM Prijevoznik
    ELSE IF @Operation = 'U'
        UPDATE Prijevoznik
        SET Naziv = @Naziv,
            [Broj telefona] = @BrojTelefona,
            Email = @Email
        WHERE [ID prijevoznik] = @IDPrijevoznik
    ELSE IF @Operation = 'D'
        DELETE FROM Prijevoznik WHERE [ID prijevoznik] = @IDPrijevoznik
END
GO

