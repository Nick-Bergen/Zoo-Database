/* ==================================================
=	ISE-Project groep C-2							=
=	Tests Use Case DELETE T4.1-T4.36  				=
================================================== */ 

-- Testclass: [test_STP_Delete'Tabel']
-- Testnamen: [Een 'entiteit' wordt toegevoegd met correcte parameters]
-- Testnamen: [Een 'entiteit' wordt niet toegevoegd met een foute 'NaamParameter']

/*
De Unit Tests volgen de vorm AAA: Assembly, Act, Assert
Eerst wordt er in de SetUp procedure tabellen gekopieerd en gevuld met testdata.
Vervolgens wordt een verwachte uitkomst gedeclareerd (Exception of NoException).
De te testen handeling/procedure wordt uitgevoerd en de test slaagt als de uitkomst overeenkomt met de verwachting.
*/

------------------------------------------ T4.1 - T4.2 -------------------------------------------- Jorian
-- Unit Tests UC 1.8 
EXEC tSQLt.NewTestClass test_STP_DeleteDier
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Dier'
	
	INSERT INTO DIER (DIERID)
	VALUES (1)
END
GO

-- | T 4.1 | UC 1.8, FR 1.3 | Een dier wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteDier].[test Een dier wordt gedelete met correcte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;
	
	EXEC STP_DeleteDier
	@DierID = 1

	SELECT @actual = COUNT(*) FROM DIER
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.2 | UC 1.8, FR 1.3 | Een dier wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteDier].[test Een dier wordt niet gedelete met incorrecte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;
	
	EXEC STP_DeleteDier
	@DierID = 2

	SELECT @actual = COUNT(*) FROM DIER
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.3 - T4.4 -------------------------------------------- Nick
-- Unit Tests UC 1.9
EXEC tSQLt.NewTestClass test_STP_DeleteGebied
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteGebied].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Gebied'

	INSERT INTO Gebied (GebiedNaam, Hoofdverzorger)
	VALUES ('Savanne', 1)

END
GO

-- | T 4.3 | UC 1.9, FR 1.1 | Een gebied wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteGebied].[test Een gebied wordt gedelete met correcte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteGebied
	@GebiedNaam			= 'Savanne'

	SELECT @actual = COUNT(*) FROM GEBIED
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.4 | UC 1.9, FR 1.1 | Een gebied wordt niet gedelete met incorrecte parameters. | 
CREATE OR ALTER PROCEDURE [test_STP_DeleteGebied].[test Een gebied wordt niet gedelete met incorrecte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteGebied
	@GebiedNaam			= 'Warenhuis'

	SELECT @actual = COUNT(*) FROM GEBIED
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.5 - T4.6 -------------------------------------------- Levi
-- Unit Tests UC 1.10
EXEC tSQLt.NewTestClass test_STP_DeleteVerblijf
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteVerblijf].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Verblijf'
	
	INSERT INTO Verblijf (VERBLIJFID,GEBIEDNAAM)
	VALUES 
	(1,'Savanne')
END
GO

-- | T 4.5 | UC 1.10, FR 1.2 | Een verblijf wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteVerblijf].[test Een verblijf wordt gedelete met correcte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;
	
	EXEC STP_DeleteVerblijf
	@VERBLIJFID = 1,
	@GEBIEDNAAM = 'Savanne'

	SELECT @actual = COUNT(*) FROM Verblijf
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.6 | UC 1.10, FR 1.2 | Een verblijf wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteVerblijf].[test Een verblijf wordt niet gedelete met incorrecte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;
	
	EXEC STP_DeleteVerblijf
	@VERBLIJFID = 1,
	@GEBIEDNAAM = 'Vlindertuin'

	SELECT @actual = COUNT(*) FROM Verblijf
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.7 - T4.8 -------------------------------------------- Vince
-- Unit Test UC 1.11
EXEC tSQLt.NewTestClass 'test_STP_DeleteDiersoort'
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteDiersoort].[SetUp]
AS
BEGIN
	DROP TABLE IF EXISTS [test_STP_DeleteDiersoort].[verwacht]
	
	SELECT TOP 0 *
	INTO [test_STP_DeleteDiersoort].[verwacht]
	FROM DIERSOORT

	EXEC tSQLt.FakeTable 'dbo', 'DIERSOORT';

	INSERT INTO DIERSOORT(LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
	VALUES('Panthera leo', 'Leeuw', 'Leeuw', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')

END
GO

-- | T 4.7 | UC 1.11, FR 1.9 | Diereninformatie wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteDiersoort].[test Diereninformatie wordt gedelete met correcte parameters. ]
AS
BEGIN
	EXEC STP_DeleteDiersoort
		@LatijnseNaam = 'Panthera leo'

	SELECT *
	INTO [test_STP_DeleteDiersoort].[actual]
	FROM DIERSOORT

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_DeleteDiersoort.actual', 'test_STP_DeleteDiersoort.verwacht'
END
GO

-- | T 4.8 | UC 1.11, FR 1.9 | Diereninformatie wordt gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteDiersoort].[test Diereninformatie wordt niet gedelete met incorrecte parameters. ]
AS
BEGIN
	EXEC STP_DeleteDiersoort --Not existing LatijnseNaam
		@LatijnseNaam = 'Panthera'

	SELECT *
	INTO [test_STP_DeleteDiersoort].[actual]
	FROM DIERSOORT

	INSERT INTO [test_STP_DeleteDiersoort].[verwacht]
	VALUES('Panthera leo', 'Leeuw', 'Leeuw', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_DeleteDiersoort.actual', 'test_STP_DeleteDiersoort.verwacht'
END
GO

------------------------------------------ T4.9 - T4.10 ------------------------------------------- Jorian
-- Unit Tests UC 1.12
EXEC tSQLt.NewTestClass test_STP_DeleteFokDossier
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteFokDossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FokDossier'
	
	INSERT INTO FokDossier (FOKID)
	VALUES (1)
END
GO

-- | T 4.9 | UC 1.12, FR 1.16 | Een fokdossier wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteFokDossier].[test Een fokdossier wordt gedelete met correcte parameters. ]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;
	
	EXEC STP_DeleteFokDossier
	@FokID = 1

	SELECT @actual = COUNT(*) FROM FokDossier
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.10 | UC 1.12, FR 1.16 | Een fokdossier wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteFokDossier].[test Een fokdossier wordt niet gedelete met incorrecte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;
	
	EXEC STP_DeleteFokDossier
	@FokID = 2

	SELECT @actual = COUNT(*) FROM FokDossier
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.11 - T4.12 ------------------------------------------ Nick
-- Unit Tests UC 1.13
EXEC tSQLt.NewTestClass test_STP_DeleteUitleendossier
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteUitleendossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER'

	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM)
	VALUES (1, '01-01-2020')
END
GO

-- | T 4.11 | UC 1.13, FR 1.5 | Een uitleendossier wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteUitleendossier].[test Een uitleendossier wordt gedelete met correcte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteUitleendossier
	@DierID			= 1,
	@UitleenDatum	= '01-01-2020'

	SELECT @actual = COUNT(*) FROM UITLEENDOSSIER
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.12 | UC 1.13, FR 1.5 | Een uitleendossier wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteUitleendossier].[test Een uitleendossier wordt niet gedelete met incorrecte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteUitleendossier
	@DierID			= 2,
	@UitleenDatum	= '01-01-2020'

	SELECT @actual = COUNT(*) FROM UITLEENDOSSIER
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.13 - T4.14 ------------------------------------------ Levi
-- Unit Tests UC 1.14
EXEC tSQLt.NewTestClass test_STP_DeleteUitzetdossier
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteUitzetdossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UitzetDOSSIER'

	INSERT INTO UitzetDOSSIER(DIERID, UitzetDATUM)
	VALUES (1, '01-01-2020')

END
GO

-- | T 4.13 | UC 1.14, FR 1.6 | Uitzetdossier wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteUitzetdossier].[test Een Uitzetdossier wordt gedelete met correcte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteUitzetdossier
		@DierID			= 1,
		@UitzetDatum	= '01-01-2020'

	SELECT @actual = COUNT(*) FROM UitzetDOSSIER
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.14 | UC 1.14, FR 1.6 | Uitzetdossier wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteUitzetdossier].[test Een Uitzetdossier wordt niet gedelete met incorrecte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteUitzetdossier
		@DierID			= 2,
		@UitzetDatum	= '01-01-2020'

	SELECT @actual = COUNT(*) FROM UitzetDOSSIER
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.15 - T4.16 ------------------------------------------ Vince
-- Unit Tests UC 1.24
EXEC tSQLt.NewTestClass 'test_STP_DeleteGespot'
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteGespot].[SetUp]
AS
BEGIN
	DROP TABLE IF EXISTS [test_STP_DeleteGespot].[verwacht]
	
	SELECT TOP 0 *
	INTO [test_STP_DeleteGespot].[verwacht]
	FROM GESPOT

	EXEC tSQLt.FakeTable 'dbo', 'GESPOT';

	INSERT INTO GESPOT(DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE)
	VALUES(1, '12-DEC-2020', '15-DEC-2020', 'JAPAN')
END
GO

-- | T 4.15 | UC 1.24, FR 1.18 | Een spotting wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteGespot].[test Een spotting wordt gedelete met correcte parameters. ]
AS
BEGIN
	EXEC STP_DeleteGespot
		@DierID = 1, @UitzetDatum = '12-DEC-2020', @Spotdatum = '15-DEC-2020'

	SELECT *
	INTO [test_STP_DeleteGespot].[actual]
	FROM GESPOT

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_DeleteGespot.actual', 'test_STP_DeleteGespot.verwacht'
END
GO

-- | T 4.16 | UC 1.24, FR 1.18 | Een spotting wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteGespot].[test Een spotting wordt niet gedelete met incorrecte parameters.]
AS
BEGIN
	INSERT INTO [test_STP_DeleteGespot].[verwacht]
	VALUES (1, '12-DEC-2020', '15-DEC-2020', 'JAPAN')

	EXEC STP_DeleteGespot --UitzetDatum does not exist
		@DierID = 1, @UitzetDatum = '12-DEC-2021', @Spotdatum = '15-DEC-2020'

	SELECT *
	INTO [test_STP_DeleteGespot].[actual]
	FROM GESPOT

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_DeleteGespot.actual', 'test_STP_DeleteGespot.verwacht'
END
GO

------------------------------------------ T4.17 - T4.18 ------------------------------------------ Jorian
-- Unit Tests UC 1.27
EXEC tSQLt.NewTestClass test_STP_DeleteMedischDossier
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteMedischDossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'MedischDossier'
	
	INSERT INTO MedischDossier (DIERID,CONTROLEDATUM)
	VALUES 
	(1,'01-JAN-2000')
END
GO

-- | T 4.17 | UC 1.27, FR 1.5 | Een medisch dossier wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteMedischDossier].[test Een medisch dossier wordt gedelete met correcte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;
	
	EXEC STP_DeleteMedischDossier
		@DIERID = 1,
		@CONTROLEDATUM = '01-JAN-2000'

	SELECT @actual = COUNT(*) FROM MedischDossier
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.18 | UC 1.27, FR 1.5 | Een medisch dossier wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteMedischDossier].[test Een medisch dossier wordt niet gedelete met incorrecte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;
	
	EXEC STP_DeleteMedischDossier
		@DIERID = 2,
		@CONTROLEDATUM = '01-JAN-2000'

	SELECT @actual = COUNT(*) FROM MedischDossier 
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.19 - T4.20 ------------------------------------------ Nick
-- Unit Tests UC 1.33
EXEC tSQLt.NewTestClass test_STP_DeleteLeveringcontrole
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteLeveringcontrole].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'LEVERINGCONTROLE'

	INSERT INTO LEVERINGCONTROLE (BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD)
	VALUES (1, 'Banaan', '01-01-2020')

END
GO

-- | T 4.19 | UC 1.33, FR 1.12 | Ontvangen goederen worden gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteLeveringcontrole].[test Ontvangen goederen worden gedelete met correcte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteOntvangenGoederen
		@BestellingID		= 1,
		@VoedselSoort		= 'Banaan',
		@OntvangenDatumTijd	= '01-01-2020'

	SELECT @actual = COUNT(*) FROM LEVERINGCONTROLE
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.20 | UC 1.33, FR 1.12 | Ontvangen goederen niet worden gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteLeveringcontrole].[test Ontvangen goederen niet worden gedelete met incorrecte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteOntvangenGoederen
		@BestellingID		= 2,
		@VoedselSoort		= 'Vlees',
		@OntvangenDatumTijd	= '01-01-2018'

	SELECT @actual = COUNT(*) FROM LEVERINGCONTROLE
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.21 - T4.22 ------------------------------------------ Nick
-- Unit Tests UC 1.37
EXEC tSQLt.NewTestClass test_STP_DeleteBestelling
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteBestelling].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING'

	INSERT INTO BESTELLING(BESTELLINGID)
	VALUES (1)

END
GO

-- | T 4.23 | UC 1.37, FR 1.10 | Een bestelling wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteBestelling].[test Een bestelling wordt gedelete met correcte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteBestelling
		@BestellingID		= 1

	SELECT @actual = COUNT(*) FROM BESTELLING
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.24 | UC 1.37, FR 1.10 | Een bestelling wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteBestelling].[test Een voedingsinformatie wordt niet gedelete met een incorrecte primary key.]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteBestelling
		@BestellingID		= 2

	SELECT @actual = COUNT(*) FROM BESTELLING
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.23 - T4.24 ------------------------------------------ Vince
-- Unit Tests UC 1.38
EXEC tSQLt.NewTestClass 'test_STP_DeleteBestellingRegel'
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteBestellingRegel].[SetUp]
AS
BEGIN
	DROP TABLE IF EXISTS [test_STP_DeleteBestellingRegel].[verwacht]
	
	SELECT TOP 0 *
	INTO [test_STP_DeleteBestellingRegel].[verwacht]
	FROM BESTELLINGREGEL

	EXEC tSQLt.FakeTable 'dbo', 'BESTELLINGREGEL';

	INSERT INTO BESTELLINGREGEL(BESTELLINGID, VOEDSELSOORT, BESTELDEHOEVEELHEID, PRIJS, EENHEID)
	VALUES(1, 'Banaan', 5, '£3.45', 'Kilogram')
END
GO


-- | T 4.25 | UC 1.38, FR 1.10 | Een voedselbestelling wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteBestellingRegel].[test Een voedselbestelling wordt gedelete met correcte parameters.]
AS
BEGIN
	EXEC STP_DeleteBestellingRegel
		@BestellingId = 1, @VoedselSoort = 'Banaan'

	SELECT *
	INTO [test_STP_DeleteBestellingRegel].[actual]
	FROM BESTELLINGREGEL

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_DeleteBestellingRegel.actual', 'test_STP_DeleteBestellingRegel.verwacht'
END
GO

-- | T 4.26 | UC 1.38, FR 1.10 | Een voedselbestelling wordt niet gedelete met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteBestellingRegel].[test Een voedselbestelling wordt niet gedelete met incorrecte parameters.]
AS
BEGIN
	EXEC STP_DeleteBestellingRegel --Not existing BestellingId
		@BestellingId = 2, @VoedselSoort = 'Banaan'

	SELECT *
	INTO [test_STP_DeleteBestellingRegel].[actual]
	FROM BESTELLINGREGEL

	INSERT INTO [test_STP_DeleteBestellingRegel].[verwacht]
	VALUES(1, 'Banaan', 5, '£3.45', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_DeleteBestellingRegel.actual', 'test_STP_DeleteBestellingRegel.verwacht'
END
GO

------------------------------------------ T4.25 - T4.26 ------------------------------------------ Levi
-- Unit Tests UC 1.45
EXEC tSQLt.NewTestClass test_STP_DeleteLeverancier
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteLeverancier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Leverancier'

	INSERT INTO Leverancier(LeverancierNaam)
	VALUES ('Gamma')
END
GO

-- | T 4.25 | UC 1.45, FR 1.11 | Leveranciers wordt gedelete met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteLeverancier].[test Leveranciers wordt gedelete met de correcte parameters.]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteLeverancier
		@LeverancierNaam = 'Gamma'

	SELECT @actual = COUNT(*) FROM Leverancier
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.26 | UC 1.45, FR 1.11 | Leveranciers wordt niet gedelete met de incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteLeverancier].[test Leveranciers wordt niet gedelete met de incorrecte parameters.]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteLeverancier
		@LeverancierNaam = 'Praxis'

	SELECT @actual = COUNT(*) FROM Leverancier
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

------------------------------------------ T4.27 - T4.28 ------------------------------------------ Vince
-- Unit Tests UC 1.51
EXEC tSQLt.NewTestClass 'test_STP_DeleteVoedsel'
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteVoedsel].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'VOEDSEL';
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE';

	INSERT INTO VOEDSEL(VOEDSELSOORT)
	VALUES
	('Banaan'), ('Appel')

	INSERT INTO DIEETINFORMATIE(VOEDSELSOORT)
	VALUES('Appel')
END
GO

-- | T 4.33 | UC 1.51, FR 1.19 | Een voedselsoort wordt gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteVoedsel].[test Een voedselsoort wordt gedelete met correcte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;
	
	EXEC STP_DeleteVoedsel
		@VoedselSoort = 'Banaan'

	SELECT @actual = COUNT(*) FROM VOEDSEL
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.33 | UC 1.51, FR 1.19 | Een voedselsoort wordt geupdate met met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteVoedsel].[test Een voedselsoort wordt geupdate met correcte parameters.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 2;
	
	EXEC STP_DeleteVoedsel
		@VoedselSoort = 'Appel',
		@NewVoedselSoort = 'Druif'

	SELECT @actual = COUNT(*) FROM VOEDSEL
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.34 | UC 1.51, FR 1.19 | Een voedselsoort wordt niet gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteVoedsel].[test Een voedselsoort wordt niet gedelete met correcte parameters.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	
	EXEC STP_DeleteVoedsel
		@VoedselSoort = 'Appel'
END
GO

-- | T 4.34 | UC 1.51, FR 1.19 | Een voedselsoort wordt niet gedelete met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteVoedsel].[test Een voedselsoort wordt niet gedelete met correcte parameters Voedselsoort en NewVoedselsoort.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	
	EXEC STP_DeleteVoedsel
		@VoedselSoort = 'Appel',
		@NewVoedselSoort = 'Banaan'
END
GO

------------------------------------------ T4.29 - T4.30 ------------------------------------------ Jorian
-- Unit Tests UC 1.52
EXEC tSQLt.NewTestClass test_STP_DeleteFunctie
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteFunctie].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Functies'
	EXEC tSQLt.FakeTable 'dbo', 'Medewerker'
	
	INSERT INTO Functies (Functie)
	VALUES 
	('MedeVerzorger'),
	('HoofdVerzorger')

	INSERT INTO MEDEWERKER (FUNCTIE)
	VALUES
	('MedeVerzorger')
END
GO

-- | T 4.35 | UC 1.52, FR 1.20 | Een functie wordt gedelete met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteFunctie].[test Een functie wordt gedelete met de correcte functie.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;
	
	EXEC STP_DeleteFunctie
		@Functie = 'HoofdVerzorger'

	SELECT @actual = COUNT(*) FROM Functies
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.35 | UC 1.52, FR 1.20 | Een functie wordt gedelete met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteFunctie].[test Een functie wordt gedelete met de correcte nieuwe functie.]
AS
BEGIN
    DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 2;
	
	EXEC STP_DeleteFunctie
		@Functie = 'HoofdVerzorger',
		@NewFunctie = 'NieuweVerzorger'

	SELECT @actual = COUNT(*) FROM Functies
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.36 | UC 1.52, FR 1.20 | Een functie wordt niet gedelete met de incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteFunctie].[test Een functie wordt niet gedelete met de functie die medewerker.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_DeleteFunctie
		@Functie = 'MedeVerzorger'
END
GO

-- | T 4.36 | UC 1.52, FR 1.20 | Een functie wordt niet gedelete met de incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteFunctie].[test Een functie wordt niet gedelete met de incorrecte Nieuwe functie.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_DeleteFunctie
		@Functie = 'MedeVerzorger',
		@NewFunctie = 'HoofdVerzorger'
END
GO

------------------------------------------ T4.31 - T4.32 ------------------------------------------ Nick
-- Unit Tests UC 1.31
EXEC tSQLt.NewTestClass test_STP_DeleteDieetinformatie
GO

CREATE OR ALTER PROCEDURE [test_STP_DeleteDieetinformatie].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE'

	INSERT INTO DIEETINFORMATIE(DIERID, VOEDSELSOORT, STARTDATUM)
	VALUES (1, 'Banaan', '01-01-2020')
END
GO

-- | T 4.35 | UC 1.31, FR 1.16 | Een voedingsinformatie wordt gedelete met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteDieetinformatie].[test Een voedingsinformatie wordt gedelete met de correcte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_DeleteDieetinformatie
		@DierID				= 1,
		@VoedselSoort		= 'Banaan',
		@Startdatum			= '01-01-2020'

	SELECT @actual = COUNT(*) FROM DIEETINFORMATIE
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 4.36 | UC 1.31, FR 1.16 | Een voedingsinformatie wordt niet gedelete met de incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_DeleteDieetinformatie].[test Een voedingsinformatie wordt niet gedelete met een incorrecte primary key.]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_DeleteDieetinformatie
		@DierID				= 2,
		@VoedselSoort		= 'Vlees',
		@Startdatum			= '01-01-2018'

	SELECT @actual = COUNT(*) FROM DIEETINFORMATIE
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO