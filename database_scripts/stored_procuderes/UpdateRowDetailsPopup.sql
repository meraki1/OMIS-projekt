USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[UpdateRowDetailsPopup]    Script Date: 22.11.2023. 22:16:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateRowDetailsPopup]
    @orderID INT,
    @idStavka INT,
    @kolicina INT,
    @rab decimal(5,2)
AS
BEGIN
    UPDATE Stavka
    SET Količina = @kolicina,
        [Rab, %] = @rab
    WHERE [ID stavka] = @idStavka AND [ID narudžba] = @orderID
END
GO

