USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[DeleteRowOperation]    Script Date: 22.11.2023. 22:13:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteRowOperation]
    @orderID INT
AS  
BEGIN
	-- Delete the order
	DELETE FROM Narudžba WHERE [ID narudžbe] = @orderID
END    
GO

