USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[GetAvailableStorageLocations]    Script Date: 22.11.2023. 22:13:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAvailableStorageLocations]
AS
BEGIN
    SELECT [ID skladišna lokacija], [Skladišna lokacija]
    FROM [Skladišna lokacija]
    WHERE [ID skladišna lokacija] NOT IN (SELECT [ID skladišna lokacija] FROM Artikl)
END
GO

