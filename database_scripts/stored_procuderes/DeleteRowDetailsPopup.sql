USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[DeleteRowDetailsPopup]    Script Date: 22.11.2023. 22:13:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteRowDetailsPopup]
    @orderID INT,
    @idStavka INT
AS
BEGIN
    DELETE FROM Stavka
    WHERE [ID stavka] = @idStavka AND [ID narudžba] = @orderID
END
GO

