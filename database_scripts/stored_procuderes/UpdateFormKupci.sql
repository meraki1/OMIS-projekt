USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[UpdateFormKupci]    Script Date: 22.11.2023. 22:16:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateFormKupci]
    @IDKupac INT,
    @Ime NVARCHAR(50),
    @OIB NVARCHAR(11),
    @Email NVARCHAR(100),
    @Prezime NVARCHAR(50),
    @Naziv NVARCHAR(100),
    @BrojTelefona NVARCHAR(50),
    @Adresa NVARCHAR(50)
AS
BEGIN
    UPDATE Kupac
    SET Ime = @Ime,
        OIB = @OIB,
        Email = @Email,
        Prezime = @Prezime,
        Naziv = @Naziv,
        [Broj telefona] = @BrojTelefona,
        Adresa = @Adresa
    WHERE [ID kupac] = @IDKupac;
END
GO

