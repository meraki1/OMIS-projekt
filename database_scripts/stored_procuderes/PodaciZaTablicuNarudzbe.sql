USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[PodaciZaTablicuNarudzbe]    Script Date: 22.11.2023. 22:15:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PodaciZaTablicuNarudzbe]
    @SortExpression NVARCHAR(50) = NULL,
    @SortDirection NVARCHAR(4) = NULL
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)
    SET @SQL = N'SELECT Narudžba.[ID narudžbe], Kupac.Ime as ''Kupac'', CONCAT(Zaposlenik.[ID zaposlenik], '' - '', Zaposlenik.[Ime], '' '', Zaposlenik.[Prezime]) as ''ID - Zaposlenik'', Narudžba.[Datum primitka], Narudžba.[Datum isporuke], Prijevoznik.[Naziv] as ''Prijevoznik'', Status.[Naziv statusa] as ''Status''
    FROM Narudžba
    INNER JOIN Kupac ON Narudžba.[ID kupac] = Kupac.[ID kupac]
    INNER JOIN Status ON Narudžba.[ID statusa] = Status.[ID statusa]
    LEFT OUTER JOIN Zaposlenik ON Narudžba.[ID zaposlenik] = Zaposlenik.[ID zaposlenik]
    LEFT OUTER JOIN Prijevoznik ON Narudžba.[ID prijevoznik] = Prijevoznik.[ID prijevoznik]'

    IF @SortExpression IS NOT NULL AND @SortDirection IS NOT NULL
		SET @SQL = @SQL + N' ORDER BY ' + @SortExpression + N' ' + @SortDirection
	ELSE
		SET @SQL = @SQL + N' ORDER BY Narudžba.[ID narudžbe] ASC'


    EXEC sp_executesql @SQL
END


GO

