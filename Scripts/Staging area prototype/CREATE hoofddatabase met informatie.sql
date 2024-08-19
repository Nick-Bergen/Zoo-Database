USE MASTER
GO

DROP DATABASE IF EXISTS Dierentuin
GO

CREATE DATABASE Dierentuin
GO

USE Dierentuin
GO

CREATE TABLE DierenInformatie(
Diersoort varchar(255),
Informatie varchar(255)
)
GO

INSERT INTO DierenInformatie(Diersoort, Informatie)
values('Olifant', 'Olifanten zijn grote zoogdieren uit de familie van de Elephantidae binnen de orde van de slurfdieren (Proboscidea). Traditioneel worden er twee soorten erkend, de Afrikaanse olifant (Loxodonta africana) en de Aziatische olifant (Elephas maximus).'),
	  ('Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.'),
	  ('Sprinkhaan', 'Een groot grijs beest'),
	  ('Cheeta', 'Erg snel beest'),
	  ('Krokodil', 'Is een beest met een hele grote bek'),
	  ('Giraf', 'Is een beest met een hele lange nek'),
	  ('Baviaan', 'De bavianen (Papio) vormen een geslacht van apen binnen de familie Cercopithecidae. Hun verspreidingsgebied is het zuidelijke Arabisch Schiereiland en Afrika ten zuiden van de Sahara. Het zijn op de mensapen na de grootste apensoorten.')
GO


CREATE OR ALTER PROCEDURE STP_InsertDataInStagingArea
--(@param datatype, ...)
AS
BEGIN
	--create a unique savepointnaam
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON; --no x rows affected for performance reasons.
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;
			
			INSERT INTO DierentuinStagingArea.dbo.DierenInformatie
			SELECT Diersoort, Informatie
			FROM Dierentuin.dbo.DierenInformatie

		COMMIT TRANSACTION; -- lower trancount with 1 when at end of TRY.
	END TRY
	BEGIN CATCH
		--a rollback is possible if a transaction is "doomed", but only if @startTrancount = 0
		--If @startTrancount is higher, the calling sproc/system is responsible for rolling back.
		IF XACT_STATE() = -1 AND @startTrancount = 0
		BEGIN
			ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN
			--if the transactions is not doomed, the work of this sproc can be undone.
			--Other work in the whole transaction, might still be able to be commited.
			--so a rollback to savepoint is necessary and transactions counter substracted by 1  ;
			IF XACT_STATE() = 1
			--transaction not doomed, but work needs to be undone.
			--your not in this CATCH block for nothing.
			BEGIN
				ROLLBACK TRANSACTION @savepoint; --undo work of this sproc
				COMMIT TRANSACTION; --trancount - 1
			END;
		END;
		DECLARE @errormessage varchar(2000);
		SET @errormessage = 'Error occured in sproc ''' + OBJECT_NAME(@@procid) + '''. Original message: ''' + ERROR_MESSAGE() + '''';
		THROW 50000, @errormessage, 1;
	END CATCH;
END;
GO