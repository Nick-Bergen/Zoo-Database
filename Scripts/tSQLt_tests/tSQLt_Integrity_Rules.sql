/* ==================================================
=	ISE-Project groep C-2							=
=	Tests Integrity Rules T6.1 - T6.140				=
================================================== */ 

/* Drop de check constraints in het geval ze opnieuw toegevoegd moeten worden

ALTER TABLE UITLEENDOSSIER
DROP CONSTRAINT CHK_TerugkeerDatum
ALTER TABLE BESTELLING
DROP CONSTRAINT CHK_BetaalDatumBestelling
ALTER TABLE GESPOT
DROP CONSTRAINT CHK_DatumDierGespot
ALTER TABLE DIER
DROP CONSTRAINT CHK_GeboorteDatumInToekomst
ALTER TABLE UITLEENDOSSIER
DROP CONSTRAINT CHK_UitleenDierentuin
ALTER TABLE DIER
DROP CONSTRAINT CHK_VerblijfDoodDier
ALTER TABLE MEDEWERKER
DROP CONSTRAINT CHK_VerzorgerInGebied

De Unit Tests volgen de vorm AAA: Assembly, Act, Assert
Eerst worden in de SetUp procedure tabellen gekopieerd en gevuld met testdata.
Vervolgens wordt een verwachte uitkomst gedeclareerd (Exception of NoException).
De te testen handeling/procedure wordt uitgevoerd en de test slaagt als de uitkomst overeenkomt met de verwachting.
*/

------------------------------------------ T6.1 - T6.4 -------------------------------------------- Jorian
-- Unit Tests IR 1
EXEC tSQLt.NewTestClass 'test_TRG_LeverdatumBestelling'
GO

CREATE OR ALTER PROCEDURE [test_TRG_LeverdatumBestelling].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Bestelling';
	EXEC tSQLt.FakeTable 'dbo', 'LeveringControle';
	EXEC tSQLt.ApplyTrigger 'LeveringControle','TRG_LeverdatumBestelling'; 

	INSERT INTO Bestelling(BestellingID,BESTELDATUM )VALUES(1,'08-09-1994')
	INSERT INTO Bestelling(BestellingID,BESTELDATUM )VALUES(2,'08-09-1994')
	INSERT INTO LEVERINGCONTROLE(BestellingID,OntvangDatumTijd) VALUES(2,'09-09-1994')
END
GO

-- | T 6.1 | IR 1 | Een leverdatum wordt toegevoegd die later is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_TRG_LeverdatumBestelling].[test Een leverdatum wordt toegevoegd die later is dan de besteldatum. ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO LEVERINGCONTROLE(BestellingID,OntvangDatumTijd) VALUES(1,'09-09-1994')
END
GO

-- | T 6.2 | IR 1 | Een ontvangDatumTijd wordt niet toegevoegd die eerder is dan de besteldatum.|
CREATE OR ALTER PROCEDURE [test_TRG_LeverdatumBestelling].[test Een ontvangDatumTijd wordt niet toegevoegd die eerder is dan de besteldatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO LEVERINGCONTROLE(BestellingID,OntvangDatumTijd) VALUES(1,'07-09-1994')
END
GO

-- | T 6.3 | IR 1 | Een ontvangDatumTijd wordt geüpdate die later is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_TRG_LeverdatumBestelling].[test Een ontvangDatumTijd wordt geüpdate die later is dan de besteldatum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE LEVERINGCONTROLE
	SET OntvangDatumTijd = '10-09-1994'
    WHERE BestellingID = 2
END
GO

-- | T 6.4 | IR 1 | Een ontvangDatumTijd wordt niet geüpdate die eerder is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_TRG_LeverdatumBestelling].[test Een ontvangDatumTijd wordt niet geüpdate die eerder is dan de besteldatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE LEVERINGCONTROLE
	SET OntvangDatumTijd = '07-09-1994'
    WHERE BestellingID = 2
END
GO

------------------------------------------ 6.5 - T6.8---------------------------------------------- Levi
-- Unit Tests IR 2
EXEC tSQLt.NewTestClass 'test_TRG_GeboortedatumDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_GeboortedatumDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER';
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER';
	EXEC tSQLt.ApplyTrigger 'DIER','TRG_GeboortedatumDier'; 

	INSERT INTO DIER(DIERID, GEBOORTEDATUM, FOKID) 
	VALUES('Moeder','10-JAN-2000', NULL), ('Vader','11-JAN-2000', NULL), ('kind1', '25-JAN-2000', 1), ('kind2', '26-JAN-2000', 1)
	INSERT INTO FOKDOSSIER(FOKID, FOKDIER, FOKPARTNER) 
	VALUES(1, 'Moeder', 'Vader')
END
GO

-- | T 6.5 | IR 2 | Een dier wordt toegevoegd met een geboortedatum die later is dan de geboortedatum van de ouders. |
CREATE OR ALTER PROCEDURE [test_TRG_GeboortedatumDier].[test Een dier wordt toegevoegd met een geboortedatum die later is dan de geboortedatum van de ouders.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIER(DIERID, GEBOORTEDATUM, FOKID) VALUES ('kind3', '12-JAN-2000', 1)
END
GO

-- | T 6.6 | IR 2 | Een dier wordt niet toegevoegd met een geboortedatum die eerder is dan de geboortedatum van de ouders. |
CREATE OR ALTER PROCEDURE [test_TRG_GeboortedatumDier].[test Een dier wordt niet toegevoegd met een geboortedatum die eerder is dan de geboortedatum van de ouders.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO DIER(DIERID, GEBOORTEDATUM, FOKID) VALUES ('kind4', '9-JAN-2000', 1)
END
GO

-- | T 6.7 | IR 2 | Een dier wordt geüpdate met een geboortedatum die later is dan de geboortedatum van de ouders. |
CREATE OR ALTER PROCEDURE [test_TRG_GeboortedatumDier].[test Een dier wordt geüpdate met een geboortedatum die later is dan de geboortedatum van de ouders.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE DIER
	SET GEBOORTEDATUM = '26-JAN-2000'
    WHERE DIERID = 'kind1'
END
GO

-- | T 6.8 | IR 2 | Een dier wordt niet geüpdate met een geboortedatum die eerder is dan de GeboorteDatum van de ouders. |
CREATE OR ALTER PROCEDURE [test_TRG_GeboortedatumDier].[test Een dier wordt niet geüpdate met een geboortedatum die eerder is dan de GeboorteDatum van de ouders.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE DIER
	SET GEBOORTEDATUM = '5-JAN-2000'
    WHERE DIERID = 'kind2'
END
GO

------------------------------------------ T6.9 - T6.12-------------------------------------------- Nick
-- Unit Tests IR 3
EXEC tSQLt.NewTestClass 'test_TRG_VoederDatum'
GO

CREATE OR ALTER PROCEDURE [test_TRG_VoederDatum].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'DIEETINFORMATIE', @TriggerName = 'TRG_VoederDatum'

	INSERT INTO DIER(DierID, GEBOORTEDATUM)
	VALUES ('SAS-001', '01-01-2000')	
END
GO

-- | T 6.9 | IR 3 | Een dieetvoorkeur wordt toegevoegd met een startdatum die later of gelijk is aan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_VoederDatum].[test Een dieetvoorkeur wordt toegevoegd met een startdatum die later of gelijk is aan de GeboorteDatum van het dier]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIEETINFORMATIE(DierID, Startdatum)
	VALUES ('SAS-001', '01-01-2020')
END
GO

-- | T 6.10 | IR 3 | Een dieetvoorkeur wordt niet toegevoegd met een startdatum die eerder is dan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_VoederDatum].[test Een dieetvoorkeur wordt niet toegevoegd met een startdatum die eerder is dan de GeboorteDatum van het dier]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO DIEETINFORMATIE(DierID, Startdatum)
	VALUES ('SAS-001', '01-01-1900')
END
GO

-- | T 6.11 | IR 3 | Een dieetvoorkeur wordt geüpdate met een startdatum die later of gelijk is aan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_VoederDatum].[test Een dieetvoorkeur wordt geüpdate met een startdatum die later of gelijk is aan de GeboorteDatum van het dier]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(DierID, Startdatum)
	VALUES ('SAS-001', '01-01-2021')

	EXEC tSQLt.ExpectNoException
	UPDATE DIEETINFORMATIE
	SET Startdatum = '01-01-2020'
END
GO

-- | T 6.12 | IR 3 | Een dieetvoorkeur wordt niet geüpdate met een startdatum die eerder is dan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_VoederDatum].[test Een dieetvoorkeur wordt niet geüpdate met een startdatum die eerder is dan de GeboorteDatum van het dier]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(DierID, Startdatum)
	VALUES ('SAS-001', '01-01-2021')

	EXEC tSQLt.ExpectException
	UPDATE DIEETINFORMATIE
	SET Startdatum = '01-01-1900'
END
GO

------------------------------------------ T6.13 - T6.16 ------------------------------------------ Vince
-- Unit Tests IR 4
EXEC tSQLt.NewTestClass 'test_TRG_MedischDossierDatum'
GO

CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDatum].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER';
	EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER';

	INSERT INTO DIER(DIERID, GEBOORTEDATUM)
	VALUES(1, '19-DEC-2020'),(2, '15-FEB-2019'),
		  (3, '21-JAN-2011'),(4, '15-SEP-2012')

	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM)
	VALUES(3, '22-JAN-2011'),(4, '16-SEP-2012')

	EXEC tSQLt.ApplyTrigger @tableName = 'MEDISCHDOSSIER', @TriggerName = 'TRG_MedischDossierDatum'
END
GO

-- | T 6.13 | IR 4 | Een medischdossier wordt toegevoegd met een controledatum die later of gelijk is aan de geboortedatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDatum].[test Een medischdossier wordt toegevoegd met een controledatum die later of gelijk is aan de geboortedatum van het dier]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM)
	VALUES(1, '19-DEC-2020'), (2, '16-FEB-2019')
END
GO

-- | T 6.14 | IR 4 | Een medischdossier wordt niet toegevoegd met een controledatum die eerder is dan de geboortedatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDatum].[test een medischdossier wordt niet toegevoegd met een controledatum die eerder is dan de geboortedatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De controledatum kan niet voor de geboortedatum van een dier liggen'
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM)
	VALUES(1, '18-DEC-2020'), (2, '16-FEB-2019')
END
GO

-- | T 6.15 | IR 4 | Een medischdossier wordt geüpdate met een controledatum die later of gelijk is aan de geboortedatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDatum].[test Een medischdossier wordt geüpdate met een controledatum die later of gelijk is aan de geboortedatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE MEDISCHDOSSIER
	SET CONTROLEDATUM = '21-JAN-2011'
	WHERE DIERID = 3
	UPDATE MEDISCHDOSSIER
	SET CONTROLEDATUM = '17-SEP-2012'
	WHERE DIERID = 4
END
GO

-- | T 6.16 | IR 4 | Een medischdossier wordt niet geüpdate met een controledatum die eerder is dan de geboortedatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDatum].[test Een medischdossier wordt niet geüpdate met een controledatum die eerder is dan de geboortedatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De controledatum kan niet voor de geboortedatum van een dier liggen'
	UPDATE MEDISCHDOSSIER
	SET CONTROLEDATUM = '20-JAN-2011'
	WHERE DIERID = 3
	UPDATE MEDISCHDOSSIER
	SET CONTROLEDATUM = '17-SEP-2012'
	WHERE DIERID = 4
END
GO

-----------------------------------------  T6.17 - T6.20 ------------------------------------------ Jorian
-- Unit Tests IR 5
EXEC tSQLt.NewTestClass 'test_TRG_FokgeschiedenisDatum'
GO

CREATE OR ALTER PROCEDURE [test_TRG_FokgeschiedenisDatum].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FokDossier';
	EXEC tSQLt.FakeTable 'dbo', 'Dier';
	EXEC tSQLt.ApplyTrigger 'FokDossier','TRG_FokgeschiedenisDatum'; 

	INSERT INTO Dier(DIERID,GEBOORTEDATUM )VALUES(1,'08-09-1994')
	INSERT INTO Dier(DIERID,GEBOORTEDATUM)VALUES(2,'08-09-1994')
	INSERT INTO FokDossier(FOKDIER,FOKDATUM) VALUES(2,'09-09-1994')
END
GO

-- | T 6.17 | IR 5 | Een fokdossier wordt toegevoegd met een FokDatum die later is dan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_FokgeschiedenisDatum].[test Een fokdossier wordt toegevoegd met een FokDatum die later is dan de GeboorteDatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO FokDossier(FokDier,FokDatum) VALUES(1,'09-09-1994')
END
GO

-- | T 6.18 | IR 5 | Een fokdossier wordt niet toegevoegd met een FokDatum die eerder is dan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_FokgeschiedenisDatum].[test Een fokdossier wordt niet toegevoegd met een FokDatum die eerder is dan de GeboorteDatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO FokDossier(FokDier,FokDatum) VALUES(1,'07-09-1994')
END
GO

-- | T 6.19 | IR 5 | Een fokdossier wordt geüpdate met een FokDatum die later is dan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_FokgeschiedenisDatum].[test Een fokdossier wordt geüpdate met een FokDatum die later is dan de GeboorteDatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE FokDossier
	SET FokDatum = '10-09-1994'
    WHERE FokDier = 2
END
GO

-- | T 6.20 | IR 5 | Een fokdossier wordt niet geüpdate met een FokDatum die eerder is dan de GeboorteDatum van het dier. |
CREATE OR ALTER PROCEDURE [test_TRG_FokgeschiedenisDatum].[test Een fokdossier wordt niet geüpdate met een FokDatum die eerder is dan de GeboorteDatum van het dier.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE FokDossier
	SET FokDatum = '07-09-1994'
    WHERE FokDier = 2
END
GO

------------------------------------------ T6.21 - T6.25 ------------------------------------------ Levi
-- Unit Tests IR 6
EXEC tSQLt.NewTestClass 'test_CHK_TerugkeerDatum'
GO

CREATE OR ALTER PROCEDURE [test_CHK_TerugkeerDatum].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER';
	EXEC tSQLt.ApplyConstraint @tableName = 'UITLEENDOSSIER', @constraintName = 'CHK_TerugkeerDatum'; 

	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, TERUGKEERDATUM) 
	VALUES ('Dier1', '15-JAN-2000', '17-JAN-2000')
END
GO

-- | T 6.21 | IR 6 | Een Uitleendossier wordt toegevoegd met een TerugkeerDatum die later is dan de UitleenDatum. |
CREATE OR ALTER PROCEDURE [test_CHK_TerugkeerDatum].[test Een Uitleendossier wordt toegevoegd met een TerugkeerDatum die later is dan de UitleenDatum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, TERUGKEERDATUM) 
	VALUES ('Dier2', '1-JAN-2000', '30-JAN-2000')
END
GO

-- | T 6.22 | IR 6 | Een Uitleendossier wordt niet toegevoegd met een TerugkeerDatum die eerder is dan de UitleenDatum. |
CREATE OR ALTER PROCEDURE [test_CHK_TerugkeerDatum].[test Een Uitleendossier wordt niet toegevoegd met een TerugkeerDatum die eerder is dan de UitleenDatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, TERUGKEERDATUM) 
	VALUES ('Dier3', '30-JAN-2000', '1-JAN-2000')
END
GO

-- | T 6.23 | IR 6 | Een Uitleendossier wordt geüpdate met een TerugkeerDatum die later is dan de UitleenDatum. |
CREATE OR ALTER PROCEDURE [test_CHK_TerugkeerDatum].[test Een Uitleendossier wordt geüpdate met een TerugkeerDatum die later is dan de UitleenDatum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE UITLEENDOSSIER
	SET TERUGKEERDATUM = '18-JAN-2000'
    WHERE DIERID = 'Dier1'
END
GO

-- | T 6.24 | IR 6 | Een Uitleendossier wordt niet geüpdate met een TerugkeerDatum die eerder is dan de UitleenDatum. |
CREATE OR ALTER PROCEDURE [test_CHK_TerugkeerDatum].[test Een Uitleendossier wordt niet geüpdate met een TerugkeerDatum die eerder is dan de UitleenDatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE UITLEENDOSSIER
	SET TERUGKEERDATUM = '1-JAN-2000'
    WHERE DIERID = 'Dier1'
END
GO

------------------------------------------ T6.25 - T6.29 ------------------------------------------ Nick
-- Unit Tests IR 7
EXEC tSQLt.NewTestClass 'test_TRG_GeslachtFokDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_GeslachtFokDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'

	EXEC tSQLt.ApplyTrigger @TableName = 'FOKDOSSIER', @TriggerName = 'TRG_GeslachtFokDier'
END
GO

-- | T 6.25 | IR 7 | Een fokdossier wordt toegevoegd met twee dieren met verschillende geslachten. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtFokDier].[test Een fokdossier wordt toegevoegd met twee dieren met verschillende geslachten]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES ('SAS-001', 'F'), ('SAS-002', 'M')

	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')
END
GO
-- | T 6.26 | IR 7 | Een fokdossier wordt niet toegevoegd met twee dieren van hetzelfde geslacht. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtFokDier].[test Een fokdossier wordt niet toegevoegd met twee dieren van hetzelfde geslacht]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES ('SAS-001', 'F'), ('SAS-002', 'F')

	EXEC tSQLt.ExpectException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')
END
GO

-- | T 6.27 | IR 7 | Een fokdossier wordt geüpdate met twee dieren van verschillende geslacht. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtFokDier].[test Een fokdossier wordt geüpdate met twee dieren van verschillende geslacht]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES 
	('SAS-001', 'F'), ('SAS-002', 'M'), ('SAS-003', 'M')
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')

	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKPARTNER = 'SAS-003'
	WHERE FOKPARTNER = 'SAS-002'
END
GO

-- | T 6.28 | IR 7  | Een fokdossier wordt niet geüpdate met twee dieren van hetzelfde geslacht. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtFokDier].[test Een fokdossier wordt niet geüpdate met twee dieren van hetzelfde geslacht]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES ('SAS-001', 'F'), ('SAS-002', 'M'), ('SAS-003', 'F')
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')

	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKPARTNER = 'SAS-003'
	WHERE FOKPARTNER = 'SAS-002'
END
GO

------------------------------------------ T6.29 - T6.32 ------------------------------------------ Vince
-- Unit Tests IR 8
EXEC tSQLt.NewTestClass 'test_TRG_UitleenDatum'
GO

CREATE OR ALTER PROCEDURE [test_TRG_UitleenDatum].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER';
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER';

	INSERT INTO DIER(DIERID, GEBOORTEDATUM)
	VALUES(1, '19-DEC-2020'), (2, '15-FEB-2019'), (3, '21-JAN-2011'), (4, '15-SEP-2012')
	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM)
	VALUES(3, '22-JAN-2011'), (4, '16-SEP-2012')

	EXEC tSQLt.ApplyTrigger @tableName = UITLEENDOSSIER, @TriggerName = TRG_UitleenDatum
END
GO

-- | T 6.29 | IR 8 | Een uitleendossier wordt toegevoegd met een uitleendatum die later is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDatum].[test Een uitleendossier wordt toegevoegd met een uitleendatum die later is dan de geboortedatum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM)
	VALUES(1, '20-DEC-2020'),
		  (2, '16-FEB-2019')
END
GO

-- | T6.30 | IR 8 | Een uitleendossier wordt niet toegevoegd met een uitleendatum die eerder is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDatum].[test Een uitleendossier wordt niet toegevoegd met een uitleendatum die eerder is dan de geboortedatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De uitleendatum kan niet voor de geboortedatum van een dier liggen'
	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM)
	VALUES(1, '18-DEC-2020'),
		  (2, '16-FEB-2019')
END
GO

-- | T6.31 | IR 8 | Een uitleendossier wordt geüpdate met een uitleendatum die later is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDatum].[test Een uitleendossier wordt geüpdate met een uitleendatum die later is dan de geboortedatum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '25-JAN-2011'
	WHERE DIERID = 3
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '17-SEP-2012'
	WHERE DIERID = 4
END
GO

-- |T6.32 | IR 8 | Een uitleendossier wordt niet toegevoegd met een uitleendatum die eerder is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDatum].[test Een uitleendossier wordt niet geüpdate met een uitleendatum die eerder is dan de geboortedatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De uitleendatum kan niet voor de geboortedatum van een dier liggen'
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '25-JAN-2011'
	WHERE DIERID = 3
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '14-SEP-2012'
	WHERE DIERID = 4
END
GO

------------------------------------------ T6.33 - T6.36 ------------------------------------------ Jorian
-- Unit Tests IR 9
EXEC tSQLt.NewTestClass 'test_TRG_Uitzetdatum'
GO

CREATE OR ALTER PROCEDURE [test_TRG_UitzetDatum].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UitzetDossier';
	EXEC tSQLt.FakeTable 'dbo', 'Dier';
	EXEC tSQLt.ApplyTrigger 'UitzetDossier','TRG_UitzetDatum'; 

	INSERT INTO Dier(DIERID,GEBOORTEDATUM)VALUES(1,'08-09-1994')
	INSERT INTO Dier(DIERID,GEBOORTEDATUM)VALUES(2,'08-09-1994')
	INSERT INTO UitzetDossier(DIERID,UITZETDATUM) VALUES(2,'09-09-1994')
END
GO

-- | T 6.33 | IR 9 | Een uitzetdossier wordt toegevoegd met een uitleendatum die later is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzetDatum].[Een uitzetdossier wordt toegevoegd met een uitleendatum die later is dan de geboortedatum.  ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UitzetDossier(DIERID,UITZETDATUM) VALUES(1,'09-09-1994')
END
GO

-- | T 6.34 | IR 9 | Een uitzetdossier wordt niet toegevoegd met een uitleendatum die eerder is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzetDatum].[test Een uitzetdossier wordt niet toegevoegd met een uitleendatum die eerder is dan de geboortedatum. ]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UitzetDossier(DIERID,UITZETDATUM) VALUES(1,'07-09-1994')
END
GO

-- | T 6.35 | IR 9 | Een uitzetdossier wordt geüpdate met een uitleendatum die later is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzetDatum].[test  Een uitzetdossier wordt geüpdate met een uitleendatum die later is dan de geboortedatum. ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE UitzetDossier
	SET UITZETDATUM = '10-09-1994'
    WHERE DIERID = 2
END
GO

-- | T 6.36 | IR 9 | Een uitzetdossier wordt niet geüpdate met een uitleendatum die eerder is dan de geboortedatum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzetDatum].[Een uitzetdossier wordt niet geüpdate met een uitleendatum die eerder is dan de geboortedatum. ]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE UitzetDossier
	SET UITZETDATUM = '07-09-1994'
    WHERE DIERID = 2
END
GO

------------------------------------------ T6.37 - T6.40 ------------------------------------------ Levi
-- Unit Tests IR 10
EXEC tSQLt.NewTestClass 'test_TRG_GeslachtMoeder'
GO

CREATE OR ALTER PROCEDURE [test_TRG_GeslachtMoeder].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'FOKDOSSIER', @TriggerName = 'TRG_GeslachtMoeder'
	
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES ('Dier1', 'F'), ('Dier2', 'M')
END
GO

-- | T 6.37 | IR 10 | Een fokdossier wordt toegevoegd met een vrouwelijke moeder. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtMoeder].[test Een fokdossier wordt toegevoegd met een vrouwelijke moeder.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier1', 'Dier2')
END
GO

-- | T 6.38 | IR 10 | Een fokdossier wordt niet toegevoegd met een mannelijke moeder. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtMoeder].[test Een fokdossier wordt niet toegevoegd met een mannelijke moeder.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier2', 'Dier1')
END
GO

-- | T 6.39 | IR 10 | Een fokdossier wordt geüpdate met een vrouwelijke moeder. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtMoeder].[test Een fokdossier wordt geüpdate met een vrouwelijke moeder.]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES ('Dier3', 'F')
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier1', 'Dier2')

	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKDIER = 'Dier3'
	WHERE FOKDier = 'Dier1'
END
GO

-- | T 6.40 | IR 10 | Een fokdossier wordt niet geüpdate met een mannelijke moeder. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtMoeder].[test Een fokdossier wordt niet geüpdate met een mannelijke moeder.]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES ('Dier3', 'M')
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier1', 'Dier2')

	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKDIER = 'Dier3'
	WHERE FOKDier = 'Dier1'
END
GO

------------------------------------------ T6.41 - T6.44 ------------------------------------------ Nick
-- Unit Tests IR 11
EXEC tSQLt.NewTestClass 'test_TRG_GeslachtVader'
GO

CREATE OR ALTER PROCEDURE [test_TRG_GeslachtVader].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'

	EXEC tSQLt.ApplyTrigger @TableName = 'FOKDOSSIER', @TriggerName = 'TRG_GeslachtVader'
END
GO

-- | T 6.41 | IR 11 | Een fokdossier wordt toegevoegd met een mannelijke vader. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtVader].[test Een fokdossier wordt toegevoegd met een mannelijke vader]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES 
	('SAS-001', 'F'),
	('SAS-002', 'M')

	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')
END
GO

-- | T 6.42 | IR 11 | Een fokdossier wordt niet toegevoegd met een vrouwelijke vader. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtVader].[test Een fokdossier wordt niet toegevoegd met een vrouwelijke vader]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES 
	('SAS-001', 'F'),
	('SAS-002', 'F')

	EXEC tSQLt.ExpectException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')
END
GO

-- | T 6.43 | IR 11 | Een fokdossier wordt geüpdate met een mannelijke vader. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtVader].[test Een fokdossier wordt geüpdate met een mannelijke vader]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES 
	('SAS-001', 'F'),
	('SAS-002', 'M'),
	('SAS-003', 'M')

	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')

	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKPARTNER = 'SAS-003'
	WHERE FOKPARTNER = 'SAS-002'
END
GO

-- | T 6.44 | IR 11 | Een fokdossier wordt niet geüpdate met een vrouwelijke vader. |
CREATE OR ALTER PROCEDURE [test_TRG_GeslachtVader].[test Een fokdossier wordt niet geüpdate met een vrouwelijke vader]
AS
BEGIN
	INSERT INTO DIER(DierID, GESLACHT)
	VALUES 
	('SAS-001', 'F'),
	('SAS-002', 'M'),
	('SAS-003', 'F')

	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('SAS-001', 'SAS-002')

	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKPARTNER = 'SAS-003'
	WHERE FOKPARTNER = 'SAS-002'
END
GO

------------------------------------------ T6.45 - T6.48 ------------------------------------------ Vince
-- Unit Tests IR 12
EXEC tSQLt.NewTestClass 'test_TRG_FokLocatie'
GO

CREATE OR ALTER PROCEDURE [test_TRG_FokLocatie].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIERENTUIN';

	INSERT INTO DIER(DIERID)
	VALUES (1), (2), (3), (4)

	INSERT INTO DIERENTUIN(DIERENTUINNAAM, PLAATS)
	VALUES('Apenheul', 'Apeldoorn'), ('Somerleyton Animal Park', 'Somerleyton'), ('Ouwehands Dierenpark', 'Utrecht')

	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM)
	VALUES(1, '5-DEC-2021', 'Somerleyton Animal Park', 'Apenheul', '5-DEC-2022'),
		  (3, '10-JAN-2021', 'Ouwehands Dierenpark', 'Somerleyton Animal Park', '10-APR-2021'),
		  (4, '1-JAN-2021', 'Somerleyton Animal Park', 'Ouwehands Dierenpark', '1-FEB-2021')

	INSERT INTO FOKDOSSIER(FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES(1, 1, 3, '9-APR-2021', 'Somerleyton')

	EXEC tSQLt.ApplyTrigger @tableName = FOKDOSSIER, @TriggerName = TRG_FokLocatie
END
GO

-- | T 6.45 | IR 12 | Een fokdossier wordt toegevoegd met een locatie die hetzelfde is als die van de dierentuin waar het dier verblijft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokLocatie].[test Een fokdossier wordt toegevoegd met een locatie die hetzelfde is als die van de dierentuin waar het dier verblijft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER(FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES(2, 1, 4, '6-APR-2021', 'Somerleyton')
END
GO

-- | T 6.46 | IR 12 | Een fokdossier wordt niet toegevoegd met een locatie dat verschilt van de locatie van de dierentuin waar het dier verblijft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokLocatie].[test Een fokdossier wordt niet toegevoegd met dat verschilt van de locatie van de dierentuin waar het dier verblijft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO FOKDOSSIER(FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES(2, 1, 4, '6-APR-2021', 'Utrecht')
END
GO

-- | T 6.47 | IR 12 | Een fokdossier wordt geüpdate met een locatie die hetzelfde is als die van de dierentuin waar het dier verblijft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokLocatie].[test Een fokdossier wordt geüpdate met een locatie die hetzelfde is als die van de dierentuin waar het dier verblijft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKPLAATS = 'Somerleyton',
		FOKPARTNER = 2
	WHERE FOKID = 1
END
GO

-- | T 6.48 | IR 12 | Een fokdossier wordt niet geüpdate met een locatie dat verschilt van de locatie van de dierentuin waar het dier verblijft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokLocatie].[test Een fokdossier wordt niet geüpdate met een locatie dat verschilt van de locatie van de dierentuin waar het dier verblijft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKPLAATS = 'Apeldoorn'
	WHERE FOKID = 1
END
GO

------------------------------------------ T6.49 - T6.52 ------------------------------------------ Jorian
-- Unit Tests IR 13
EXEC tSQLt.NewTestClass 'test_TRG_BestellingBetalen'
GO

CREATE OR ALTER PROCEDURE [test_TRG_BestellingBetalen].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Bestelling';
	EXEC tSQLt.ApplyTrigger 'Bestelling','TRG_BestellingBetalen'; 

	INSERT INTO BESTELLING(BESTELLINGID,BETAALDATUM,BESTELSTATUS)VALUES(1,'08-09-1994','Betaald')
	INSERT INTO BESTELLING(BESTELLINGID,BESTELSTATUS)VALUES(2,'Besteld')
END
GO

-- | T 6.49 | IR 13 | Een bestelling wordt toegevoegd met een betaaldatum als de status op "Betaald" staat. |
CREATE OR ALTER PROCEDURE [test_TRG_BestellingBetalen].[test Een bestelling wordt toegevoegd met een betaaldatum als de status op "Betaald" staat.  ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO BESTELLING(BESTELLINGID,BETAALDATUM,BESTELSTATUS)VALUES(3,'08-09-1994','Betaald')
END
GO

-- | T 6.50 | IR 13 | Een bestelling wordt niet toegevoegd met een betaaldatum als de status niet op "Betaald" staat. |
CREATE OR ALTER PROCEDURE [test_TRG_BestellingBetalen].[test Een bestelling wordt niet toegevoegd met een betaaldatum als de status niet op "Betaald" staat.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO BESTELLING(BESTELLINGID,BETAALDATUM,BESTELSTATUS)VALUES(4,'08-09-1994','Besteld')
END
GO

-- | T 6.51 | IR 13 | Een bestelling wordt geüpdate met een betaaldatum als de status op "Betaald" staat. |
CREATE OR ALTER PROCEDURE [test_TRG_BestellingBetalen].[test Een bestelling wordt geüpdate met een betaaldatum als de status op "Betaald" staat. ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE Bestelling
	SET BETAALDATUM = '10-09-1994'
    WHERE BESTELLINGID = 1
END
GO

-- | T 6.52  | IR 13   | Een bestelling wordt niet geüpdate met een betaaldatum als de status niet op "Betaald" staat. |
CREATE OR ALTER PROCEDURE [test_TRG_BestellingBetalen].[test Een bestelling wordt niet geüpdate met een betaaldatum als de status niet op "Betaald" staat. ]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE Bestelling
	SET BETAALDATUM = '10-09-1994'
    WHERE BESTELLINGID = 2
END
GO

------------------------------------------ T6.53 - T6.56 ------------------------------------------ Levi
-- Unit Tests IR 14
EXEC tSQLt.NewTestClass 'test_CHK_BetaalDatumBestelling'
GO

CREATE OR ALTER PROCEDURE [test_CHK_BetaalDatumBestelling].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING'
	EXEC tSQLt.ApplyConstraint @TableName = 'BESTELLING', @ConstraintName = 'CHK_BetaalDatumBestelling'
END
GO

-- | T 6.53 | IR 14 | Een bestelling wordt toegevoegd met een betaaldatum die later is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_CHK_BetaalDatumBestelling].[test Een bestelling wordt toegevoegd met een betaaldatum die later is dan de besteldatum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO BESTELLING (BESTELDATUM, BETAALDATUM)
	VALUES ('1-JAN-2000', '2-JAN-2000')
END
GO

-- | T 6.54 | IR 14 | Een bestelling wordt niet toegevoegd met een betaaldatum die eerder is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_CHK_BetaalDatumBestelling].[test Een bestelling wordt niet toegevoegd met een betaaldatum die eerder is dan de besteldatum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO BESTELLING (BESTELDATUM, BETAALDATUM)
	VALUES ('2-JAN-2000', '1-JAN-2000')
END
GO

-- | T 6.55 | IR 14 | Een bestelling wordt geüpdate met een betaaldatum die later is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_CHK_BetaalDatumBestelling].[test Een bestelling wordt geüpdate met een betaaldatum die later is dan de besteldatum.]
AS
BEGIN
	INSERT INTO BESTELLING (BESTELDATUM, BETAALDATUM)
	VALUES ('1-JAN-2000', '2-JAN-2000')
	EXEC tSQLt.ExpectNoException
	UPDATE BESTELLING
	SET BETAALDATUM = '3-JAN-2000'
END
GO

-- | T 6.56 | IR 14 | Een bestelling wordt niet geüpdate met een betaaldatum die eerder is dan de besteldatum. |
CREATE OR ALTER PROCEDURE [test_CHK_BetaalDatumBestelling].[test Een bestelling wordt niet geüpdate met een betaaldatum die eerder is dan de besteldatum.]
AS
BEGIN
	INSERT INTO BESTELLING (BESTELDATUM, BETAALDATUM)
	VALUES ('2-JAN-2000', '3-JAN-2000')
	EXEC tSQLt.ExpectException
	UPDATE BESTELLING
	SET BETAALDATUM = '1-JAN-2000' 
END
GO

------------------------------------------ T6.57 - T6.60 ------------------------------------------ Nick
-- Unit Tests IR 15
EXEC tSQLt.NewTestClass 'test_CHK_DatumDierGespot'
GO

CREATE OR ALTER PROCEDURE [test_CHK_DatumDierGespot].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GESPOT'
	EXEC tSQLt.ApplyConstraint @TableName = 'GESPOT', @ConstraintName = 'CHK_DatumDierGespot'
END
GO

-- | T 6.57 | IR 15 | Een spotting wordt toegevoegd met een spotdatum die later is dan de uitzetdatum. |
CREATE OR ALTER PROCEDURE [test_CHK_DatumDierGespot].[test Een spotting wordt toegevoegd met een spotdatum die later is dan de uitzetdatum]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO GESPOT(UITZETDATUM, SPOTDATUM)
	VALUES ('01-01-2000', '01-01-2020')
END
GO

-- | T 6.58 | IR 15 | Een spotting wordt niet toegevoegd met een spotdatum die eerder is dan de uitzetdatum. |
CREATE OR ALTER PROCEDURE [test_CHK_DatumDierGespot].[test Een spotting wordt niet toegevoegd met een spotdatum die eerder is dan de uitzetdatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO GESPOT(UITZETDATUM, SPOTDATUM)
	VALUES ('01-01-2000', '01-01-1900')
END
GO

-- | T 6.59 | IR 15 | Een spotting wordt geüpdate met een spotdatum die later is dan de uitzetdatum. |
CREATE OR ALTER PROCEDURE [test_CHK_DatumDierGespot].[test Een spotting wordt geüpdate met een spotdatum die later is dan de uitzetdatum]
AS
BEGIN
	INSERT INTO GESPOT(UITZETDATUM, SPOTDATUM)
	VALUES ('01-01-2000', '01-01-2020')

	EXEC tSQLt.ExpectNoException
	UPDATE GESPOT
	SET SPOTDATUM = '01-01-2021'
END
GO

-- | T 6.60 | IR 15 | Een spotting wordt niet geüpdate met een spotdatum die eerder is dan de uitzetdatum. |
CREATE OR ALTER PROCEDURE [test_CHK_DatumDierGespot].[test Een spotting wordt niet geüpdate met een spotdatum die eerder is dan de uitzetdatum]
AS
BEGIN
	INSERT INTO GESPOT(UITZETDATUM, SPOTDATUM)
	VALUES ('01-01-2000', '01-01-2020')

	EXEC tSQLt.ExpectException
	UPDATE GESPOT
	SET SPOTDATUM = '01-01-1900'
END
GO

------------------------------------------ T6.61 - T6.64 ------------------------------------------ Vince
EXEC tSQLt.NewTestClass 'test_TRG_DiagnoseDoorDierenarts'
GO

CREATE OR ALTER PROCEDURE [test_TRG_DiagnoseDoorDierenarts].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'MEDEWERKER';
	EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER';

	INSERT INTO MEDEWERKER(MEDEWERKERID, FUNCTIE)
	VALUES (1, 'Dierenarts'), (2, 'Verzorger'), (3, 'Dierenarts')
	INSERT INTO MEDISCHDOSSIER(DIERID, MEDEWERKERID)
	VALUES (1, 3)

	EXEC tSQLt.ApplyTrigger @tableName = 'MEDISCHDOSSIER', @TriggerName = 'TRG_DiagnoseDoorDierenarts'
END
GO

-- | T 6.61 | IR 16 | Een medischdossier wordt toegevoegd met een medewerker die de functie 'Dierenarts' heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_DiagnoseDoorDierenarts].[test Een medischdossier wordt toegevoegd met een medewerker die de functie 'Dierenarts' heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO MEDISCHDOSSIER(DIERID, MEDEWERKERID)
	VALUES(1, 1)
END
GO

-- | T 6.62 | IR 16 | Een medischdossier wordt niet toegevoegd met een medewerker die een andere functie heeft dan 'Dierenarts'. |
CREATE OR ALTER PROCEDURE [test_TRG_DiagnoseDoorDierenarts].[test Een medischdossier wordt niet toegevoegd met een medewerker die een andere functie heeft dan 'Dierenarts'.]
AS
BEGIN
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De medewerker is geen dierenarts'
	INSERT INTO MEDISCHDOSSIER(DIERID, MEDEWERKERID)
	VALUES(1, 2)
END
GO

-- | T 6.63 | IR 16 | Een medischdossier wordt geüpdate een medewerker die de functie 'Dierenarts' heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_DiagnoseDoorDierenarts].[test Een medischdossier wordt geüpdate een medewerker die de functie 'Dierenarts' heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException 
	UPDATE MEDISCHDOSSIER
	SET MEDEWERKERID = 1
	WHERE MEDEWERKERID = 3
END
GO

-- | T 6.64 | IR 16 | Een medischdossier wordt niet geüpdate een medewerker die een andere functie heeft dan 'Dierenarts'. |
CREATE OR ALTER PROCEDURE [test_TRG_DiagnoseDoorDierenarts].[test Een medischdossier wordt niet geüpdate een medewerker die een andere functie heeft dan 'Dierenarts'.]
AS
BEGIN
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De medewerker is geen dierenarts'
	UPDATE MEDISCHDOSSIER
	SET MEDEWERKERID = 2
	WHERE MEDEWERKERID = 3
END
GO

------------------------------------------ T6.65 - T6.68 ------------------------------------------ Jorian
-- Unit Tests IR 17
EXEC tSQLt.NewTestClass 'test_TRG_UitgeleendDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_UitgeleendDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Uitleendossier';	
	EXEC tSQLt.ApplyTrigger 'Uitleendossier','TRG_UitgeleendDier'; 
	INSERT INTO Uitleendossier(DierID,UitleenDATUM,TERUGKEERDATUM)VALUES(1,'08-SEP-1994','18-SEP-1994')	
	INSERT INTO Uitleendossier(DierID,UitleenDATUM,TERUGKEERDATUM)VALUES(1,'25-SEP-1994','30-SEP-1994')
    INSERT INTO Uitleendossier(DierID,UitleenDATUM,TERUGKEERDATUM)VALUES(2,'08-SEP-1994','18-SEP-1994')	
	INSERT INTO Uitleendossier(DierID,UitleenDATUM,TERUGKEERDATUM)VALUES(2,'25-SEP-1994','30-SEP-1994')
END
GO

-- | T 6.65 | IR 17 | Twee uitleendossier's van één dier worden toegevoegd met een niet overlappende datum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitgeleendDier].[test Twee uitleendossier's van één dier worden toegevoegd met een niet overlappende datum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO Uitleendossier(DierID,UitleenDATUM,TERUGKEERDATUM)VALUES(1,'08-OCT-1994','18-OCT-1994')	
END
GO

-- | T 6.66 | IR 17 | Twee uitleendossier's van één dier worden niet toegevoegd met een overlappende datum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitgeleendDier].[test Twee uitleendossier's van één dier worden niet toegevoegd met een overlappende datum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO Uitleendossier(DierID,UitleenDATUM,TERUGKEERDATUM)VALUES(1,'26-SEP-1994','29-SEP-1994')	
END
GO

-- | T 6.67 | IR 17 | Twee uitleendossier's van één dier worden geüpdate met een niet overlappende datum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitgeleendDier].[test Twee uitleendossier's van één dier worden geüpdate met een niet overlappende datum.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '26-SEP-1994'
    WHERE DIERID = 1 AND UITLEENDATUM = '25-SEP-1994'
END
GO

-- | T 6.68  | IR 17 | Twee uitleendossier's van één dier worden niet geüpdate met een overlappende datum. |
CREATE OR ALTER PROCEDURE [test_TRG_UitgeleendDier].[test Twee uitleendossier's van één dier worden niet geüpdate met een overlappende datum.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '17-SEP-1994'
    WHERE DIERID = 2 AND UITLEENDATUM = '25-SEP-1994'
END
GO

------------------------------------------ T6.69 - T6.72 ------------------------------------------ Levi
-- Unit Tests IR 18
EXEC tSQLt.NewTestClass 'test_TRG_DierInHetWild'
GO

CREATE OR ALTER PROCEDURE [test_TRG_DierInHetWild].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'UITZETDOSSIER', @TriggerName = 'TRG_DierInHetWild'

	INSERT INTO DIER (DIERID, VERBLIJFID) 
	VALUES ('Dier1', NULL), ('Dier2', 1)
END
GO

-- | T 6.69 | IR 18 | Een uitzetdossier wordt toegevoegd met een dier zonder verblijfnummer. |
CREATE OR ALTER PROCEDURE [test_TRG_DierInHetWild].[test Een uitzetdossier wordt toegevoegd met een dier zonder verblijfnummer.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITZETDOSSIER (DIERID) 
	VALUES ('Dier1')
END
GO

-- | T 6.70 | IR 18 | Een uitzetdossier wordt niet toegevoegd met een dier met een verblijfnummer. |
CREATE OR ALTER PROCEDURE [test_TRG_DierInHetWild].[test Een uitzetdossier wordt niet toegevoegd met een dier met een verblijfnummer.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UITZETDOSSIER (DIERID) 
	VALUES ('Dier2')
END
GO

-- | T 6.71 | IR 18 | Een uitzetdossier wordt geüpdate met een dier zonder verblijfnummer. |
CREATE OR ALTER PROCEDURE [test_TRG_DierInHetWild].[test Een uitzetdossier wordt geüpdate met een dier zonder verblijfnummer.]
AS
BEGIN
	INSERT INTO UITZETDOSSIER (DIERID) 
	VALUES ('Dier1')
	INSERT INTO DIER(DIERID)
	VALUES ('Dier3')
	EXEC tSQLt.ExpectNoException
	UPDATE UITZETDOSSIER
	SET DIERID = 'Dier3'
END
GO

-- | T 6.72 | IR 18 | Een uitzetdossier wordt niet geüpdate met een dier met een verblijfnummer. |
CREATE OR ALTER PROCEDURE [test_TRG_DierInHetWild].[test Een uitzetdossier wordt niet geüpdate met een dier met een verblijfnummer.]
AS
BEGIN
	INSERT INTO UITZETDOSSIER (DIERID) 
	VALUES ('Dier1')
	EXEC tSQLt.ExpectException
	UPDATE UITZETDOSSIER
	SET DIERID = 'Dier2'
END
GO

------------------------------------------ T6.73 - T6.76 ------------------------------------------ Nick
-- Unit Tests IR 19
EXEC tSQLt.NewTestClass 'test_TRG_ZwangerschapDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_ZwangerschapDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIAGNOSES'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'

	EXEC tSQLt.ApplyTrigger @TableName = 'DIAGNOSES', @TriggerName = 'TRG_ZwangerschapDier'
END
GO

-- | T 6.73 | IR 19 | Een diagnose wordt toegevoegd met zwangerschap voor een vrouwtjes dier. |
CREATE OR ALTER PROCEDURE [test_TRG_ZwangerschapDier].[test Een diagnose wordt toegevoegd met zwangerschap voor een vrouwtjes dier]
AS
BEGIN
	INSERT INTO DIER(DIERID, GESLACHT)
	VALUES ('SAS-001', 'F')

	EXEC tSQLt.ExpectNoException
	INSERT INTO DIAGNOSES(DIERID, DIAGNOSE)
	VALUES ('SAS-001', 'ZWANGER')
END
GO

-- | T 6.74 | IR 19 | Een diagnose wordt niet toegevoegd met zwangerschap voor een mannetjes dier. |
CREATE OR ALTER PROCEDURE [test_TRG_ZwangerschapDier].[test Een diagnose wordt niet toegevoegd met zwangerschap voor een mannetjes dier]
AS
BEGIN
	INSERT INTO DIER(DIERID, GESLACHT)
	VALUES ('SAS-001', 'M')

	EXEC tSQLt.ExpectException
	INSERT INTO DIAGNOSES(DIERID, DIAGNOSE)
	VALUES ('SAS-001', 'ZWANGER')
END
GO

-- | T 6.75 | IR 19 | Een diagnose wordt geüpdate met zwangerschap voor een vrouwtjes dier. |
CREATE OR ALTER PROCEDURE [test_TRG_ZwangerschapDier].[test Een diagnose wordt geüpdate met zwangerschap voor een vrouwtjes dier]
AS
BEGIN
	INSERT INTO DIER(DIERID, GESLACHT)
	VALUES ('SAS-001', 'F')

	INSERT INTO DIAGNOSES(DIERID, DIAGNOSE)
	VALUES ('SAS-001', 'DEAD')

	EXEC tSQLt.ExpectNoException
	UPDATE DIAGNOSES
	SET DIAGNOSE = 'ZWANGER'
END
GO

-- | T 6.76 | IR 19 | Een diagnose wordt niet geüpdate met zwangerschap voor een mannetjes dier. |
CREATE OR ALTER PROCEDURE [test_TRG_ZwangerschapDier].[test Een diagnose wordt niet geüpdate met zwangerschap voor een mannetjes dier]
AS
BEGIN
	INSERT INTO DIER(DIERID, GESLACHT)
	VALUES ('SAS-001', 'M')

	INSERT INTO DIAGNOSES(DIERID, DIAGNOSE)
	VALUES ('SAS-001', 'DEAD')

	EXEC tSQLt.ExpectException
	UPDATE DIAGNOSES
	SET DIAGNOSE = 'ZWANGER'
END
GO

------------------------------------------ T6.77 - T6.80 ------------------------------------------ Vince
-- Unit Tests IR 20
EXEC tSQLt.NewTestClass 'test_CHK_GeboorteDatumInToekomst'
GO

CREATE OR ALTER PROCEDURE test_CHK_GeboorteDatumInToekomst.SetUp
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER';

	INSERT INTO DIER(DIERID, GEBOORTEDATUM)
	VALUES(100, '15-DEC-2020')

	EXEC tSQLt.ApplyConstraint @TableName = 'DIER', @ConstraintName = 'CHK_GeboorteDatumInToekomst'
END
GO

-- | T 6.77 | IR 20 | Een dier wordt toegevoegd met een geboortedatum die in het verleden ligt. |
CREATE OR ALTER PROCEDURE [test_CHK_GeboorteDatumInToekomst].[test Een dier wordt toegevoegd met een geboortedatum die in het verleden ligt.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIER(DIERID, GEBOORTEDATUM)
	VALUES(1, '5-DEC-2021')
END
GO

-- | T 6.78 | IR 20 | Een dier wordt niet toegevoegd met een geboortedatum die in de toekomst ligt. |
CREATE OR ALTER PROCEDURE [test_CHK_GeboorteDatumInToekomst].[test Een dier wordt niet toegevoegd met een geboortedatum die in de toekomst ligt.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO DIER(DIERID, GEBOORTEDATUM)
	VALUES(1, CAST( GETDATE() + 1 AS Date ))
END
GO

-- | T 6.79 | IR 20 | Een dier wordt geüpdate met een geboortedatum die in het verleden ligt. |
CREATE OR ALTER PROCEDURE [test_CHK_GeboorteDatumInToekomst].[test Een dier wordt geüpdate met een geboortedatum die in het verleden ligt.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE DIER
	SET GEBOORTEDATUM = '15-DEC-2019'
	WHERE GEBOORTEDATUM = '15-DEC-2020'
END
GO

-- | T6.80 | IR 20 | Een dier wordt geüpdate met een geboortedatum die in het verleden ligt. n|
CREATE OR ALTER PROCEDURE [test_CHK_GeboorteDatumInToekomst].[test Een dier wordt niet geüpdate met een geboortedatum die in de toekomst ligt.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE DIER
	SET GEBOORTEDATUM = CAST( GETDATE() + 1 AS Date )
	WHERE GEBOORTEDATUM = '15-DEC-2020'
END
GO

------------------------------------------ T6.81 - T6.84 ------------------------------------------ Jorian
EXEC tSQLt.NewTestClass 'test_TRG_FokkenMetFamilie'
GO

CREATE OR ALTER PROCEDURE [test_TRG_FokkenMetFamilie].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER';
    EXEC tSQLt.FakeTable 'dbo', 'DIER';	
	EXEC tSQLt.ApplyTrigger 'FOKDOSSIER','TRG_FokkenMetFamilie'; 
	INSERT INTO FOKDOSSIER(FOKID,FOKDIER,FOKPARTNER)VALUES('1','Moeder','Vader')
    INSERT INTO FOKDOSSIER(FOKID,FOKDIER,FOKPARTNER)VALUES('2','Moeder','Vader')
    INSERT INTO FOKDOSSIER(FOKID,FOKDIER,FOKPARTNER)VALUES('3','Moeder','Kind3')
    INSERT INTO DIER(DIERID)VALUES('Vader')
    INSERT INTO DIER(DIERID)VALUES('Moeder')
    INSERT INTO DIER(DIERID,FOKID)VALUES('Kind1',1)
    INSERT INTO DIER(DIERID,FOKID)VALUES('Kind2',2)
    INSERT INTO DIER(DIERID)VALUES('Kind3')
    INSERT INTO DIER(DIERID,FOKID)VALUES('Kind4',3)
    INSERT INTO DIER(DIERID)VALUES('Kind5')
END
GO

-- | T 6.81 | IR 21 | Een fokdossier wordt toegevoegd met twee dieren die geen familie van elkaar zijn. |
CREATE OR ALTER PROCEDURE [test_TRG_FokkenMetFamilie].[test Een fokdossier wordt toegevoegd met twee dieren die geen familie van elkaar zijn.   ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER(FOKID,FOKDIER,FOKPARTNER)VALUES('4','Kind1','Kind3')
END
GO

-- | T 6.82 | IR 21 | Een fokdossier wordt niet toegevoegd met twee dieren die familie van elkaar zijn. |  
CREATE OR ALTER PROCEDURE [test_TRG_FokkenMetFamilie].[test Een fokdossier wordt niet toegevoegd met twee dieren die familie van elkaar zijn. ]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO FOKDOSSIER(FOKID,FOKDIER,FOKPARTNER)VALUES('Vader','Moeder','Kind1')	
END
GO
-- | T 6.83 | IR 21 | Een fokdossier wordt geüpdate met twee dieren die geen familie van elkaar zijn. |
CREATE OR ALTER PROCEDURE [test_TRG_FokkenMetFamilie].[test Een fokdossier wordt geüpdate met twee dieren die geen familie van elkaar zijn. ]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKDIER = 'Kind5'
    WHERE FOKID = 3 
END
GO

-- | T 6.84 | IR 21 | Een fokdossier wordt niet geüpdate met twee dieren die familie van elkaar zijn. |
CREATE OR ALTER PROCEDURE [test_TRG_FokkenMetFamilie].[test Een fokdossier wordt niet geüpdate met twee dieren die familie van elkaar zijn.  ]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKPARTNER = 'Kind1'
    WHERE FOKID = 2 
END
GO

------------------------------------------ T6.85 - T6.88 ------------------------------------------ Levi
-- Unit Tests IR 22
EXEC tSQLt.NewTestClass 'test_TRG_HoofdverzorgerGebied'
GO

CREATE OR ALTER PROCEDURE [test_TRG_HoofdverzorgerGebied].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GEBIED'
	EXEC tSQLt.FakeTable 'dbo', 'MEDEWERKER'
	EXEC tSQLt.ApplyTrigger @TableName = 'GEBIED', @TriggerName = 'TRG_HoofdverzorgerGebied'

	INSERT INTO MEDEWERKER(MEDEWERKERID, FUNCTIE) 
	VALUES (1, 'Hoofdverzorger'), (2, 'Verzorger'), (3, 'Hoofdverzorger')
END
GO

-- | T 6.85 | IR 22 | Een gebied wordt toegevoegd met een hoofdverzorger die de functie hoofdverzorger heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_HoofdverzorgerGebied].[test Een gebied wordt toegevoegd met een hoofdverzorger die de functie hoofdverzorger heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO GEBIED(GEBIEDNAAM, HOOFDVERZORGER) 
	VALUES ('Gebied1', 1)
END
GO

-- | T 6.86 | IR 22 | Een gebied wordt niet toegevoegd met een hoofdverzorger die niet de functie hoofdverzorger heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_HoofdverzorgerGebied].[test Een gebied wordt niet toegevoegd met een hoofdverzorger die niet de functie hoofdverzorger heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO GEBIED(GEBIEDNAAM, HOOFDVERZORGER) 
	VALUES ('Gebied2', 2)
END
GO

-- | T 6.87 | IR 22 | Een gebied wordt geüpdate met een hoofdverzorger die de functie hoofdverzorger heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_HoofdverzorgerGebied].[test Een gebied wordt geüpdate met een hoofdverzorger die de functie hoofdverzorger heeft.]
AS
BEGIN
	INSERT INTO GEBIED(GEBIEDNAAM, HOOFDVERZORGER) 
	VALUES ('Gebied3', 1)
	EXEC tSQLt.ExpectNoException
	UPDATE GEBIED
	SET HOOFDVERZORGER = 3
END
GO

-- | T 6.88 | IR 22 | Een gebied wordt niet geüpdate met een hoofdverzorger die de functie hoofdverzorger heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_HoofdverzorgerGebied].[test Een gebied wordt niet geüpdate met een hoofdverzorger die de functie hoofdverzorger heeft.]
AS
BEGIN
	INSERT INTO GEBIED(GEBIEDNAAM, HOOFDVERZORGER) 
	VALUES ('Gebied4', 1)
	EXEC tSQLt.ExpectException
	UPDATE GEBIED
	SET HOOFDVERZORGER = 2
END
GO

------------------------------------------ T6.89 - T6.92 ------------------------------------------ Nick 
-- Unit Tests IR 23
EXEC tSQLt.NewTestClass 'test_CHK_UitleenDierentuin'
GO

CREATE OR ALTER PROCEDURE [test_CHK_UitleenDierentuin].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER'

	EXEC tSQLt.ApplyConstraint @TableName = 'UITLEENDOSSIER', @ConstraintName = 'CHK_UitleenDierentuin'
END
GO

-- | T 6.89 | IR 23 | Een uitleendossier wordt toegevoegd met uitlenende of ontvangende dierentuin Somerleyton. |
CREATE OR ALTER PROCEDURE [test_CHK_UitleenDierentuin].[test Een uitleendossier wordt toegevoegd met uitlenende of ontvangende dierentuin Somerleyton]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITLEENDOSSIER(UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN)
	VALUES ('Somerleyton', 'Winterleyton')
END
GO

-- | T 6.90 | IR 23 | Een uitleendossier wordt niet toegevoegd zonder uitlenende of ontvangende dierentuin Somerleyton. |
CREATE OR ALTER PROCEDURE [test_CHK_UitleenDierentuin].[test Een uitleendossier wordt niet toegevoegd zonder uitlenende of ontvangende dierentuin Somerleyton]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UITLEENDOSSIER(UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN)
	VALUES ('Springleyton', 'Winterleyton')
END
GO

-- | T 6.91 | IR 23 | Een uitleendossier wordt geüpdate met uitlenende of ontvangende dierentuin Somerleyton. |
CREATE OR ALTER PROCEDURE [test_CHK_UitleenDierentuin].[test Een uitleendossier wordt geüpdate met uitlenende of ontvangende dierentuin Somerleyton]
AS
BEGIN
	INSERT INTO UITLEENDOSSIER(UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN)
	VALUES ('Somerleyton', 'Winterleyton')

	EXEC tSQLt.ExpectNoException
	UPDATE UITLEENDOSSIER
	SET UITLENENDEDIERENTUIN = 'Winterleyton',
	ONTVANGENDEDIERENTUIN = 'Somerleyton'
END
GO

-- | T 6.92 | IR 23 | Een uitleendossier wordt niet geüpdate zonder uitlenende of ontvangende dierentuin Somerleyton. |
CREATE OR ALTER PROCEDURE [test_CHK_UitleenDierentuin].[test Een uitleendossier wordt niet geüpdate zonder uitlenende of ontvangende dierentuin Somerleyton]
AS
BEGIN
	INSERT INTO UITLEENDOSSIER(UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN)
	VALUES ('Somerleyton', 'Winterleyton')

	EXEC tSQLt.ExpectException
	UPDATE UITLEENDOSSIER
	SET UITLENENDEDIERENTUIN = 'Winterleyton',
	ONTVANGENDEDIERENTUIN = 'Springleyton'
END
GO

------------------------------------------ T6.93 - T6.96 ------------------------------------------ Vince
-- Unit Tests IR 24
EXEC tSQLt.NewTestClass 'test_TRG_MedischDossierUitgezetDier'
GO

CREATE OR ALTER PROCEDURE test_TRG_MedischDossierUitgezetDier.SetUp
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER';

	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM)
	VALUES (1, '12-DEC-2020')
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM)
	VALUES (2, '6-DEC-2021')

	EXEC tSQLt.ApplyTrigger @tableName = 'MEDISCHDOSSIER', @TriggerName = 'TRG_MedischDossierUitgezetDier'
END
GO

-- | T 6.93 | IR 24 | Een medischdossier wordt toegevoegd van een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierUitgezetDier].[test Een medischdossier wordt toegevoegd van een dier dat nog niet uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM)
	VALUES (3, '5-DEC-2021'), (1, '11-DEC-2020')
END
GO

-- | T 6.94 | IR 24 | Een medischdossier wordt niet toegevoegd van een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierUitgezetDier].[test Een medischdossier wordt niet toegevoegd van een dier dat al uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM)
	VALUES(1, '13-DEC-2021')
END
GO

-- | T 6.95 | IR 24 | Een medischdossier wordt geüpdate met een dier dat nog nietuitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierUitgezetDier].[test Een medischdossier wordt geüpdate met een dier dat nog nietuitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE MEDISCHDOSSIER
	SET DIERID = 5
	WHERE DIERID = 2
	AND CONTROLEDATUM = '6-DEC-2021'
END
GO

-- | T 6.96 | IR 24 | Een medischdossier wordt niet geüpdate van een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierUitgezetDier].[test Een medischdossier wordt niet geüpdate van een dier dat al uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE MEDISCHDOSSIER
	SET DIERID = 1,
		CONTROLEDATUM = '13-DEC-2020'
	WHERE DIERID = 2
	AND CONTROLEDATUM = '6-DEC-2021'
END
GO

------------------------------------------ T6.97 - T6.100 ----------------------------------------- Jorian
-- Unit Tests IR 25
EXEC tSQLt.NewTestClass 'test_TRG_FokDossierUitgezetDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_FokDossierUitgezetDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'FOKDOSSIER', @TriggerName = 'TRG_FokDossierUitgezetDier'

	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM) 
	VALUES ('PAPA', '10-JAN-2000')
END
GO

-- | T 6.97 | IR 25 | Een fokdossier wordt toegevoegd met een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierUitgezetDier].[test Een fokdossier wordt toegevoegd met een dier dat nog niet uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER (FOKID, FOKDIER,FOKPARTNER,FOKDATUM)
	VALUES ('1', 'PAPA','MAMA', '5-JAN-2000')
END
GO

-- | T 6.98 | IR 25 | Een fokdossier wordt niet toegevoegd met een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierUitgezetDier].[test Een fokdossier wordt niet toegevoegd met een dier dat al uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectException
		INSERT INTO FOKDOSSIER (FOKID, FOKDIER,FOKPARTNER,FOKDATUM)
    	VALUES ('1', 'PAPA','MAMA', '15-JAN-2000')
END
GO

-- | T 6.99 | IR 25 | Een fokdossier wordt geüpdate met een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierUitgezetDier].[test Een fokdossier wordt geüpdate met een dier dat nog niet uitgezet is.]
AS
BEGIN
	INSERT INTO FOKDOSSIER (FOKID, FOKDIER,FOKPARTNER,FOKDATUM)
	VALUES ('1', 'PAPA','MAMA', '5-JAN-2000')
	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKDATUM = '8-JAN-2000'
	WHERE FOKID = 1
END
GO

-- | T 6.100 | IR 25 | Een fokdossier wordt niet geüpdate met een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierUitgezetDier].[test Een fokdossier wordt niet geüpdate met een dier dat al uitgezet is.]
AS
BEGIN
	INSERT INTO FOKDOSSIER (FOKID, FOKDIER,FOKPARTNER,FOKDATUM)
	VALUES ('1', 'PAPA','MAMA', '5-JAN-2000')
	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKDATUM = '15-JAN-2000'
	WHERE FOKID = 1
END
GO

------------------------------------------ T6.101 - T6.104 ---------------------------------------- Levi
-- Unit Tests IR 26
EXEC tSQLt.NewTestClass 'test_TRG_UitleenDossierUitgezetDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierUitgezetDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'UITLEENDOSSIER', @TriggerName = 'TRG_UitleenDossierUitgezetDier'

	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM) 
	VALUES ('Dier1', '10-JAN-2000')
END
GO

-- | T 6.101 | IR 26 | Een uitleendossier wordt toegevoegd met een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierUitgezetDier].[test Een uitleendossier wordt toegevoegd met een dier dat nog niet uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, TERUGKEERDATUM)
	VALUES ('Dier1', '1-JAN-2000', '5-JAN-2000')
END
GO

-- | T 6.102 | IR 26 | Een uitleendossier wordt niet toegevoegd met een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierUitgezetDier].[test Een uitleendossier wordt niet toegevoegd met een dier dat al uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, TERUGKEERDATUM)
	VALUES ('Dier1', '1-JAN-2000', '15-JAN-2000')
END
GO

-- | T 6.103 | IR 26 | Een uitleendossier wordt geüpdate met een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierUitgezetDier].[test Een uitleendossier wordt geüpdate met een dier dat nog niet uitgezet is.]
AS
BEGIN
	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, TERUGKEERDATUM)
	VALUES ('Dier1', '1-JAN-2000', '4-JAN-2000')
	EXEC tSQLt.ExpectNoException
	UPDATE UITLEENDOSSIER
	SET TERUGKEERDATUM = '8-JAN-2000'
END
GO

-- | T 6.104 | IR 26 | Een uitleendossier wordt niet geüpdate met een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierUitgezetDier].[test Een uitleendossier wordt niet geüpdate met een dier dat al uitgezet is.]
AS
BEGIN
	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, TERUGKEERDATUM)
	VALUES ('Dier1', '3-JAN-2000', '7-JAN-2000')
	EXEC tSQLt.ExpectException
	UPDATE UITLEENDOSSIER
	SET UITLEENDATUM = '15-JAN-2000', TERUGKEERDATUM = '20-JAN-2000'
END
GO

-----------------------------------------  T6.105 - T6.108 ---------------------------------------- Nick
-- Unit Tests IR 27
EXEC tSQLt.NewTestClass 'test_TRG_VoedselInfoUitgezetDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoUitgezetDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE'
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER'

	EXEC tSQLt.ApplyTrigger @TableName = 'DIEETINFORMATIE', @TriggerName = 'TRG_VoedselInfoUitgezetDier'
END
GO

-- | T 6.105 | IR 27 | Een dieetvoorkeur wordt toegevoegd van een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoUitgezetDier].[test Een dieetvoorkeur wordt toegevoegd van een dier dat nog niet uitgezet is.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIEETINFORMATIE(DIERID, STARTDATUM)
	VALUES ('SAS-001', '01-01-2020')
END
GO

-- | T 6.106 | IR 27 | Een dieetvoorkeur wordt niet toegevoegd van een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoUitgezetDier].[test Een dieetvoorkeur wordt niet toegevoegd van een dier dat al uitgezet is.]
AS
BEGIN
	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM)
	VALUES ('SAS-001', '01-01-2000')

	EXEC tSQLt.ExpectException
	INSERT INTO DIEETINFORMATIE(DIERID, STARTDATUM)
	VALUES ('SAS-001', '01-01-2020')
END
GO

-- | T 6.107 | IR 27 | Een dieetvoorkeur wordt geüpdate met een dier dat nog niet uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoUitgezetDier].[test Een dieetvoorkeur wordt geüpdate met een dier dat nog niet uitgezet is.]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(DIERID, STARTDATUM)
	VALUES ('SAS-001', '01-01-2010')

	EXEC tSQLt.ExpectNoException
	UPDATE DIEETINFORMATIE
	SET STARTDATUM = '01-01-2020'
END
GO

-- | T 6.108 | IR 27 | Een dieetvoorkeur wordt niet geüpdate met een dier dat al uitgezet is. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoUitgezetDier].[test Een dieetvoorkeur wordt niet geüpdate met een dier dat al uitgezet is.]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(DIERID, STARTDATUM)
	VALUES ('SAS-001', '01-01-1900')

	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM)
	VALUES ('SAS-001', '01-01-2000')

	EXEC tSQLt.ExpectException
	UPDATE DIEETINFORMATIE
	SET STARTDATUM = '01-01-2020'
END
GO

------------------------------------------ T6.109 - T6.112 ---------------------------------------- Vince
-- Unit Tests IR 28
EXEC tSQLt.NewTestClass 'test_TRG_VerblijfUitgezetDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_VerblijfUitgezetDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';

	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES (5)
	INSERT INTO DIER(DIERID, VERBLIJFID)
	VALUES(1, NULL), (4, 111), (5, NULL)

	EXEC tSQLt.ApplyTrigger @tableName = UITZETDOSSIER, @TriggerName = TRG_VerblijfUitgezetDier
END
GO

-- | T 6.109 | IR 28 | Een Uitzetdossier wordt toegevoegd met een dier dat een leeg verblijfID heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VerblijfUitgezetDier].[test Een Uitzetdossier wordt toegevoegd met een dier dat een leeg verblijfID heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES(1)
END
GO

-- | T 6.110 | IR 28| Een Uitzetdossier wordt niet toegevoegd met een dier dat een ingevuld verblijfID heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VerblijfUitgezetDier].[test Een Uitzetdossier wordt niet toegevoegd met een dier dat een ingevuld verblijfID heeft..]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES(4)
END
GO

-- | T 6.111 | IR 28 | Een Uitzetdossier wordt geüpdate met een dier dat een leeg verblijfID heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VerblijfUitgezetDier].[test Een Uitzetdossier wordt geüpdate met een dier dat een leeg verblijfID heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	UPDATE UITZETDOSSIER
	SET DIERID = 1
	WHERE DIERID = 5
END
GO

-- | T 6.112 | IR 28 | Een Uitzetdossier wordt niet geüpdate met een dier dat een ingevuld verblijfID heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VerblijfUitgezetDier].[test Een Uitzetdossier wordt niet geüpdate met een dier dat een ingevuld verblijfID heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	UPDATE UITZETDOSSIER
	SET DIERID = 4
	WHERE DIERID = 5
END
GO

------------------------------------------ T6.113 - T6.116 ---------------------------------------- Jorian
-- Unit Tests IR 29
EXEC tSQLt.NewTestClass 'test_TRG_MedischDossierDoodDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDoodDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'MEDISCHDOSSIER', @TriggerName = 'TRG_MedischDossierDoodDier'

	INSERT INTO DIER(DIERID, STATUS) 
	VALUES ('Dier1', 'Overleden'), ('Dier2', 'Aanwezig'), ('Dier3', 'Aanwezig')
END
GO

--| T 6.113 | IR 29 | Een medisch dossier wordt toegevoegd met een dier zonder de status overleden. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDoodDier].[test Een medisch dossier wordt toegevoegd met een dier zonder de status overleden.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO MEDISCHDOSSIER(DIERID)
	VALUES ('Dier2')
END
GO

-- | T 6.114 | IR 29 | Een medisch dossier wordt niet toegevoegd met een dier met de status overleden. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDoodDier].[test  Een medisch dossier wordt niet toegevoegd met een dier met de status overleden.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO MEDISCHDOSSIER(DIERID)
	VALUES ('Dier1')
END
GO

-- | T 6.115 | IR 29 | Een medisch dossier wordt geüpdate met een dier dat niet status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDoodDier].[test Een medisch dossier wordt geüpdate met een dier dat niet status overleden heeft.]
AS
BEGIN
	INSERT INTO MEDISCHDOSSIER(DIERID)
	VALUES ('Dier2')
	EXEC tSQLt.ExpectNoException
	UPDATE MEDISCHDOSSIER
	SET DIERID = 'Dier3'
	WHERE DIERID = 'Dier2'
END
GO

-- | T 6.116 | IR 29 | Een medisch dossier wordt niet geüpdate met een dier dat de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_MedischDossierDoodDier].[test Een medisch dossier wordt niet geüpdate met een dier dat de status overleden heeft.]
AS
BEGIN
	INSERT INTO MEDISCHDOSSIER(DIERID)
	VALUES ('Dier2')
	INSERT INTO DIER(DIERID, STATUS) 
	VALUES ('Dier1', 'Overleden'), ('Dier2', 'Aanwezig')
	EXEC tSQLt.ExpectException
	UPDATE MEDISCHDOSSIER
	SET DIERID = 'Dier1'
	WHERE DIERID = 'Dier2'
END
GO

------------------------------------------ T6.117 - T6.120 ---------------------------------------- Levi
-- Unit tests IR 30
EXEC tSQLt.NewTestClass 'test_TRG_FokDossierDoodDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_FokDossierDoodDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'FOKDOSSIER', @TriggerName = 'TRG_FokDossierDoodDier'

	INSERT INTO DIER(DIERID, STATUS) 
	VALUES ('Dier1', 'Overleden'), ('Dier2', 'Aanwezig'), ('Dier3', 'Aanwezig')
END
GO

-- | T 6.117 | IR 30 | Een fokdossier wordt toegevoegd met een dier die niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierDoodDier].[test Een fokdossier wordt toegevoegd met een dier die niet de status overleden heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier2', 'Dier3')
END
GO

-- | T 6.118 | IR 30 | Een fokdossier wordt niet toegevoegd met een dier die de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierDoodDier].[test Een fokdossier wordt niet toegevoegd met een dier die de status overleden heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier1', 'Dier3')
END
GO

-- | T 6.119 | IR 30 | Een fokdossier wordt geüpdate met een dier die niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierDoodDier].[test Een fokdossier wordt geüpdate met een dier die niet de status overleden heeft.]
AS
BEGIN
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier2', 'Dier3')
	EXEC tSQLt.ExpectNoException
	UPDATE FOKDOSSIER
	SET FOKDIER = 'Dier3', FOKPARTNER = 'Dier2'
END
GO

-- | T 6.120 | IR 30 | Een fokdossier wordt wordt niet geüpdate met een dier die de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_FokDossierDoodDier].[test Een fokdossier wordt wordt niet geüpdate met een dier die de status overleden heeft.]
AS
BEGIN
	INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER)
	VALUES ('Dier2', 'Dier3')
	EXEC tSQLt.ExpectException
	UPDATE FOKDOSSIER
	SET FOKPARTNER = 'Dier1'
END
GO

------------------------------------------ T6.121 - T6.124 ---------------------------------------- Nick
-- Unit Tests IR 31
EXEC tSQLt.NewTestClass 'test_TRG_UitleenDossierDoodDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierDoodDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'

	EXEC tSQLt.ApplyTrigger @TableName = 'UITLEENDOSSIER', @TriggerName = 'TRG_UitleenDossierDoodDier'
END
GO

-- | T 6.121 | IR 31 | Een uitleendossier wordt toegevoegd met een dier dat niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierDoodDier].[test Een uitleendossier wordt toegevoegd met een dier dat niet de status overleden heeft]
AS
BEGIN
	INSERT INTO DIER(DIERID, STATUS)
	VALUES ('SAS-001', NULL)

	EXEC tSQLt.ExpectNoException
	INSERT INTO UITLEENDOSSIER(DIERID)
	VALUES ('SAS-001')
END
GO

-- | T 6.122 | IR 31 | Een uitleendossier wordt niet toegevoegd met een dier dat de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierDoodDier].[test Een uitleendossier wordt niet toegevoegd met een dier dat de status overleden heeft]
AS
BEGIN
	INSERT INTO DIER(DIERID, STATUS)
	VALUES ('SAS-001', 'Overleden')

	EXEC tSQLt.ExpectException
	INSERT INTO UITLEENDOSSIER(DIERID)
	VALUES ('SAS-001')
END
GO

-- | T 6.123 | IR 31 | Een uitleendossier wordt geüpdate met een dier dat niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierDoodDier].[test Een uitleendossier wordt geüpdate met een dier dat niet de status overleden heeft]
AS
BEGIN
	INSERT INTO DIER(DIERID, STATUS)
	VALUES ('SAS-001', NULL), ('SAS-002', NULL)

	INSERT INTO UITLEENDOSSIER(DIERID)
	VALUES ('SAS-001')

	EXEC tSQLt.ExpectNoException
	UPDATE UITLEENDOSSIER
	SET DIERID = 'SAS-002'
END
GO

-- | T 6.124 | IR 31 | Een uitleendossier wordt niet geüpdate met een dier dat de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitleenDossierDoodDier].[test Een uitleendossier wordt niet geüpdate met een dier dat de status overleden heeft]
AS
BEGIN
	INSERT INTO DIER(DIERID, STATUS)
	VALUES ('SAS-001', NULL), ('SAS-002', 'Overleden')

	INSERT INTO UITLEENDOSSIER(DIERID)
	VALUES ('SAS-001')

	EXEC tSQLt.ExpectException
	UPDATE UITLEENDOSSIER
	SET DIERID = 'SAS-002'
END
GO

------------------------------------------ T6.125 - T6.128 ---------------------------------------- Vince
-- Unit Tests IR 32
EXEC tSQLt.NewTestClass 'test_TRG_VoedselInfoDoodDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoDoodDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'DIEETINFORMATIE', @TriggerName = 'TRG_VoedselInfoDoodDier'

	INSERT INTO DIER(DIERID, STATUS) 
	VALUES ('Dier1', 'Overleden'), ('Dier2', 'Aanwezig'), ('Dier3', 'Aanwezig')
END
GO

-- | T 6.125 | IR 32 | Een dieetvoorkeur wordt toegevoegd van een dier dat niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoDoodDier].[test Een dieetvoorkeur wordt toegevoegd van een dier dat niet de status overleden heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIEETINFORMATIE(DIERID)
	VALUES ('Dier2')
END
GO

-- | T 6.126 | IR 32 | Een dieetvoorkeur wordt niet toegevoegd van een dier dat de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoDoodDier].[test Een dieetvoorkeur wordt niet toegevoegd van een dier dat de status overleden heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO DIEETINFORMATIE(DIERID)
	VALUES ('Dier1')
END
GO

-- | T 6.127 | IR 32 | Een dieetvoorkeur wordt geüpdate met een dier dat niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoDoodDier].[test Een dieetvoorkeur wordt geüpdate met een dier dat niet de status overleden heeft.]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(DIERID)
	VALUES ('Dier2')
	EXEC tSQLt.ExpectNoException
	UPDATE DIEETINFORMATIE
	SET DIERID = 'Dier3'
END
GO

-- | T 6.128 | IR 32 | Een dieetvoorkeur wordt niet geüpdate met een dier dat de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_VoedselInfoDoodDier].[test Een dieetvoorkeur wordt niet geüpdate met een dier dat de status overleden heeft.]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(DIERID)
	VALUES ('Dier2')
	EXEC tSQLt.ExpectException
	UPDATE DIEETINFORMATIE
	SET DIERID = 'Dier1'
END
GO

------------------------------------------ T6.129 - T6.132 ---------------------------------------- Jorian
-- Unit Tests IR 33
EXEC tSQLt.NewTestClass 'test_CHK_VerblijfDoodDier'
GO

CREATE OR ALTER PROCEDURE [test_CHK_VerblijfDoodDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyConstraint @TableName = 'DIER', @ConstraintName = 'CHK_VerblijfDoodDier'
END
GO

-- | T 6.129 | IR 33 | Een dier wordt toegevoegd met de status overleden en een leeg verblijfID. |
CREATE OR ALTER PROCEDURE [test_CHK_VerblijfDoodDier].[test Een dier wordt toegevoegd met de status overleden en een leeg verblijfID.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIER (STATUS, VERBLIJFID)
	VALUES ('Overleden', NULL)
END
GO

-- | T 6.130 | IR 33 | Een dier wordt niet toegevoegd met de status overleden en een ingevuld verblijfID. |
CREATE OR ALTER PROCEDURE [test_CHK_VerblijfDoodDier].[test Een dier wordt niet toegevoegd met de status overleden en een ingevuld verblijfID.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO DIER (STATUS, VERBLIJFID)
	VALUES ('Overleden', 1)
END
GO

-- | T 6.131 | IR 33 | Een dier wordt geüpdate met de status overleden een leeg verblijfID. |
CREATE OR ALTER PROCEDURE [test_CHK_VerblijfDoodDier].[test Een dier wordt geüpdate met de status overleden een leeg verblijfID.]
AS
BEGIN
	INSERT INTO DIER (STATUS, VERBLIJFID)
	VALUES ('Levend', NULL)
	EXEC tSQLt.ExpectNoException
	UPDATE DIER
	SET STATUS = 'Overleden'
	WHERE STATUS = 'Levend'
END
GO

-- | T 6.132 | IR 33 | Een dier wordt niet geüpdate met de status overleden en een ingevuld verblijfID. |
CREATE OR ALTER PROCEDURE [test_CHK_VerblijfDoodDier].[test Een dier wordt niet geüpdate met de status overleden en een ingevuld verblijfID. ]
AS
BEGIN
	INSERT INTO DIER (STATUS, VERBLIJFID)
	VALUES ('Levend', NULL)
	EXEC tSQLt.ExpectException
	UPDATE DIER
	SET STATUS = 'Overleden',VERBLIJFID = 1
	WHERE STATUS = 'Levend'
END
GO

------------------------------------------ T6.133 - T6.136 ---------------------------------------- Levi
-- Unit Tests IR 34
EXEC tSQLt.NewTestClass 'test_TRG_UitzettenDoodDier'
GO

CREATE OR ALTER PROCEDURE [test_TRG_UitzettenDoodDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyTrigger @TableName = 'UITZETDOSSIER', @TriggerName = 'TRG_UitzettenDoodDier'

	INSERT INTO DIER(DIERID, STATUS) 
	VALUES ('Dier1', 'Overleden'), ('Dier2', 'Aanwezig'), ('Dier3', 'Aanwezig')
END
GO

-- | T 6.133 | IR 34 | Een uitzetdossier wordt toegevoegd met een dier die niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzettenDoodDier].[test Een uitzetdossier wordt toegevoegd met een dier die niet de status overleden heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES ('Dier2')
END
GO

-- | T 6.134 | IR 34 | Een uitzetdossier wordt niet toegevoegd met een dier die de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzettenDoodDier].[test Een uitzetdossier wordt niet toegevoegd met een dier die de status overleden heeft.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES ('Dier1')
END
GO

-- | T 6.135 | IR 34 | Een uitzetdossier wordt geüpdate met een dier die niet de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzettenDoodDier].[test Een uitzetdossier wordt geüpdate met een dier die niet de status overleden heeft.]
AS
BEGIN
	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES ('Dier2')
	EXEC tSQLt.ExpectNoException
	UPDATE UITZETDOSSIER
	SET DIERID = 'Dier3'
END
GO

-- | T 6.136 | IR 34 | Een uitzetdossier wordt niet geüpdate met een dier die de status overleden heeft. |
CREATE OR ALTER PROCEDURE [test_TRG_UitzettenDoodDier].[test Een uitzetdossier wordt niet geüpdate met een dier die de status overleden heeft.]
AS
BEGIN
	INSERT INTO UITZETDOSSIER(DIERID)
	VALUES ('Dier2')
	EXEC tSQLt.ExpectException
	UPDATE UITZETDOSSIER
	SET DIERID = 'Dier1'
END
GO

------------------------------------------ T6.137 - T6.140 ---------------------------------------- Nick
-- Unit Tests IR 35
EXEC tSQLt.NewTestClass 'test_CHK_VerzorgerInGebied'
GO

CREATE OR ALTER PROCEDURE [test_CHK_VerzorgerInGebied].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'MEDEWERKER'
	EXEC tSQLt.ApplyConstraint @TableName = 'MEDEWERKER', @ConstraintName = 'CHK_VerzorgerInGebied'
END
GO

-- | T 6.137 | IR 35 | Een werknemer wordt toegevoegd met een gebied en de functie verzorger. |
CREATE OR ALTER PROCEDURE [test_CHK_VerzorgerInGebied].[test Een werknemer wordt toegevoegd met een gebied en de functie verzorger]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO MEDEWERKER(MEDEWERKERID, GEBIEDNAAM, FUNCTIE)
	VALUES ('1', 'Afrika', 'Verzorger')
END
GO

-- | T 6.138 | IR 35 | Een werknemer wordt niet toegevoegd met een gebied en niet de functie verzorger. |
CREATE OR ALTER PROCEDURE [test_CHK_VerzorgerInGebied].[test Een werknemer wordt niet toegevoegd met een gebied en niet de functie verzorger]
AS
BEGIN
	EXEC tSQLt.ExpectException
	INSERT INTO MEDEWERKER(MEDEWERKERID, GEBIEDNAAM, FUNCTIE)
	VALUES ('1', 'Afrika', 'Dierenarts')
END
GO

-- | T 6.139 | IR 35 | Een werknemer wordt geüpdate met een gebied en de functie verzorger. |
CREATE OR ALTER PROCEDURE [test_CHK_VerzorgerInGebied].[test Een werknemer wordt geüpdate met een gebied en de functie verzorger]
AS
BEGIN
	INSERT INTO MEDEWERKER(MEDEWERKERID, GEBIEDNAAM, FUNCTIE)
	VALUES ('1', NULL, 'Dierenarts')

	EXEC tSQLt.ExpectNoException
	UPDATE MEDEWERKER
	SET GEBIEDNAAM = 'Afrika', FUNCTIE = 'Verzorger'
END
GO

-- | T 6.140 | IR 35 | Een werknemer wordt niet geüpdate met een gebied en zonder de functie verzorger. |
CREATE OR ALTER PROCEDURE [test_CHK_VerzorgerInGebied].[test Een werknemer wordt niet geüpdate met een gebied en zonder de functie verzorger]
AS
BEGIN
	INSERT INTO MEDEWERKER(MEDEWERKERID, GEBIEDNAAM, FUNCTIE)
	VALUES ('1', NULL, 'Dierenarts')

	EXEC tSQLt.ExpectException
	UPDATE MEDEWERKER
	SET GEBIEDNAAM = 'Afrika'
END
GO