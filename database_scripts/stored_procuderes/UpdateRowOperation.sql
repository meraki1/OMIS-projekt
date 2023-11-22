USE [Karlo_Miskovic]
GO

/****** Object:  StoredProcedure [dbo].[UpdateRowOperation]    Script Date: 22.11.2023. 22:16:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateRowOperation]
    @OrderID int,
    @DeliveryDate datetime = NULL,
    @Status varchar(50),
    @Carrier varchar(50),
    @employeeIDWithName varchar(50) = NULL
AS
BEGIN
    -- Get @StatusID based on the @Status
    DECLARE @StatusID int
    SELECT @StatusID = Status.[ID statusa]
    FROM Status
    WHERE Status.[Naziv statusa] = @Status
    
    -- Get @CarrierID based on the @Carrier
    DECLARE @CarrierID int
    SELECT @CarrierID = Prijevoznik.[ID prijevoznik]
    FROM Prijevoznik
	WHERE Prijevoznik.Naziv = @Carrier

    -- Extract employee ID from selected employee value
    DECLARE @employeeID int = NULL
    IF (@employeeIDWithName IS NOT NULL)
        BEGIN
            SET @employeeID = CAST(LEFT(@employeeIDWithName, CHARINDEX('-', @employeeIDWithName) - 1) AS int)
        END

    -- Update the Narudžba table
    IF (@DeliveryDate IS NOT NULL AND @employeeIDWithName IS NOT NULL)
        BEGIN
            UPDATE Narudžba
            SET [Datum isporuke] = @DeliveryDate,
                [ID statusa] = @StatusID,
                [ID prijevoznik] = @CarrierID,
                [ID zaposlenik] = @employeeID
            WHERE [ID narudžbe] = @OrderID 
        END
    ELSE IF (@DeliveryDate IS NOT NULL AND @employeeIDWithName IS NULL)
        BEGIN
            UPDATE Narudžba
            SET [Datum isporuke] = @DeliveryDate,
                [ID statusa] = @StatusID,
                [ID prijevoznik] = @CarrierID,
				[ID zaposlenik] = @employeeID
            WHERE [ID narudžbe] = @OrderID 
        END 
    ELSE IF (@DeliveryDate IS NULL AND @employeeIDWithName IS NOT NULL)
       BEGIN
            UPDATE Narudžba
            SET [Datum isporuke] = @DeliveryDate,
				[ID statusa] = @StatusID,
                [ID prijevoznik] = @CarrierID,
                [ID zaposlenik] = @employeeID
            WHERE [ID narudžbe] = @OrderID 
        END 
	ELSE
        BEGIN
            UPDATE Narudžba
            SET [Datum isporuke] = @DeliveryDate,
				[ID statusa] = @StatusID,
                [ID prijevoznik] = @CarrierID,
                [ID zaposlenik] = @employeeID
            WHERE [ID narudžbe] = @OrderID 
        END 
END
GO

