/* 
	Templates
	Levi Gerrits
*/
-- SELECT @OutputParam = <column> FROM .....
-- Stored Procedure met transacties
/*******************************************************************
Stored Procedure Template
*******************************************************************/

--(based on a blog Louis Davidson, a MS SQLSERVER MVP).

CREATE OR ALTER PROCEDURE STP_<NAME>
--(@param datatype, ...)
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		----------------------------------------

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF XACT_STATE() = -1 AND @startTrancount = 0
		BEGIN
			ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN
			IF XACT_STATE() = 1
			BEGIN
				ROLLBACK TRANSACTION @savepoint;
				COMMIT TRANSACTION;
			END;
		END;
		DECLARE @errormessage varchar(2000);
		SET @errormessage = 'Error occured in sproc ''' + OBJECT_NAME(@@procid) + '''. Original message: ''' + ERROR_MESSAGE() + '''';
		THROW 50000, @errormessage, 1;
	END CATCH;
END;
GO

-- Trigger Template
CREATE OR ALTER TRIGGER Naam
ON <table>
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		<Logica die foutsituatie(s) vindt met
			THROW <errorcode>, <melding>, 1
		>
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO