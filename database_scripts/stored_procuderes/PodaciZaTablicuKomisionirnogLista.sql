USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[PodaciZaTablicuKomisionirnogLista]    Script Date: 22.11.2023. 22:15:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PodaciZaTablicuKomisionirnogLista]
    @SortExpression NVARCHAR(50),
    @SortDirection NVARCHAR(4)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)
    SET @SQL = N'SELECT Narudžba.[ID narudžbe], CONCAT(Zaposlenik.[ID zaposlenik], '' - '', Zaposlenik.[Ime], '' '', Zaposlenik.[Prezime]) as ''ID - Zaposlenik''
    FROM Narudžba
    INNER JOIN Status ON Narudžba.[ID statusa] = Status.[ID statusa]
    LEFT OUTER JOIN Zaposlenik ON Narudžba.[ID zaposlenik] = Zaposlenik.[ID zaposlenik]
    WHERE Status.[Naziv statusa] = ''U obradi'' '

    IF @SortExpression IS NOT NULL AND @SortDirection IS NOT NULL
        SET @SQL = @SQL + N' ORDER BY ' + @SortExpression + N' ' + @SortDirection

    EXEC sp_executesql @SQL
END
GO

