/* ==================================================
=	ISE-Project groep C-2							=
=	Tests Use Case INSERTS 1.1-1.28  				=
================================================== */ 

-- Testclass: [test_STP_Insert'Tabel']
-- Testnamen: [Een 'entiteit' wordt toegevoegd met correcte parameters]
-- Testnamen: [Een 'entiteit' wordt niet toegevoegd met een foute 'NaamParameter']

/*
De Unit Tests volgen de vorm AAA: Assembly, Act, Assert
Eerst wordt er in de SetUp procedure tabellen gekopieerd en gevuld met testdata.
Vervolgens wordt een verwachte uitkomst gedeclareerd (Exception of NoException).
De te testen handeling/procedure wordt uitgevoerd en de test slaagt als de uitkomst overeenkomt met de verwachting.
*/

------------------------------------------ T1.1 - T1.2 -------------------------------------------- Jorian
-- Unit Tests UC 1.1
EXEC tSQLt.NewTestClass test_STP_InsertDier
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER';
	EXEC tSQLt.FakeTable 'dbo', 'VERBLIJF';	
END
GO

-- | T 1.1 | UC 1.1, FR 1.3 | Een dier wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[test Een Dier wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDier
		@DIERID = 'ABC-123',
		@GEBIEDNAAM = 'SAVANNE',
		@VERBLIJFID = 1,
		@DIERSOORT = 'Leeuw',
		@FOKID = NULL,
		@DIERNAAM = 'Hannah',
		@Geslacht = 'M',
		@GEBOORTEPLAATS = 'Somerleyton',
		@GEBOORTELAND = 'UK',
		@GEBOORTEDATUM = '01-JAN-2000',
		@STATUS = 'Aanwezig'
END
GO

-- | T 1.2 | UC 1.1, FR 1.3 | Een dier wordt niet toegevoegd met een incorrecte DIERID. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[test Een dier wordt niet toegevoegd met een incorrecte DIERID.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDier
		@DIERID = '123-123',
		@GEBIEDNAAM = 'SAVANNE',
		@VERBLIJFID = 1,
		@DIERSOORT = 'Leeuw',
		@FOKID = NULL,
		@DIERNAAM = 'Hannah',
		@Geslacht = 'M',
		@GEBOORTEPLAATS = 'Somerleyton',
		@GEBOORTELAND = 'UK',
		@GEBOORTEDATUM = '01-JAN-2000',
		@STATUS = 'Aanwezig'
END
GO
-- | T 1.2 | UC 1.1, FR 1.3 | Een dier wordt niet toegevoegd met een incorrecte diernaam. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[test Een dier wordt niet toegevoegd met een incorrecte diernaam.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDier
		@DIERID = 'ABC-123',
		@GEBIEDNAAM = 'SAVANNE',
		@VERBLIJFID = 1,
		@DIERSOORT = 'Leeuw',
		@FOKID = NULL,
		@DIERNAAM = 'Hannah1',
		@Geslacht = 'M',
		@GEBOORTEPLAATS = 'Somerleyton',
		@GEBOORTELAND = 'UK',
		@GEBOORTEDATUM = '01-JAN-2000',
		@STATUS = 'Aanwezig'
END
GO
-- | T 1.2 | UC 1.1, FR 1.3 | Een dier wordt niet toegevoegd met een incorrecte diersoort. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[test Een dier wordt niet toegevoegd met een incorrecte diersoort.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDier
		@DIERID = 'ABC-123',
		@GEBIEDNAAM = 'SAVANNE',
		@VERBLIJFID = 1,
		@DIERSOORT = 'Leeuw1',
		@FOKID = NULL,
		@DIERNAAM = 'Hannah',
		@Geslacht = 'M',
		@GEBOORTEPLAATS = 'Somerleyton',
		@GEBOORTELAND = 'UK',
		@GEBOORTEDATUM = '01-JAN-2000',
		@STATUS = 'Aanwezig'
END
GO
-- | T 1.2 | UC 1.1, FR 1.3 | Een dier wordt niet toegevoegd met een incorrecte geboorteplaats. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[test Een dier wordt niet toegevoegd met een incorrecte geboorteplaats.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDier
		@DIERID = '123-123',
		@GEBIEDNAAM = 'SAVANNE',
		@VERBLIJFID = 1,
		@DIERSOORT = 'Leeuw',
		@FOKID = NULL,
		@DIERNAAM = 'Hannah',
		@Geslacht = 'M',
		@GEBOORTEPLAATS = 'Somerleyton1',
		@GEBOORTELAND = 'UK',
		@GEBOORTEDATUM = '01-JAN-2000',
		@STATUS = 'Aanwezig'
END
GO
-- | T 1.2 | UC 1.1, FR 1.3 | Een dier wordt niet toegevoegd met een incorrecte geboorteland. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDier].[test Een dier wordt niet toegevoegd met een incorrecte geboorteland.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDier
		@DIERID = '123-123',
		@GEBIEDNAAM = 'SAVANNE',
		@VERBLIJFID = 1,
		@DIERSOORT = 'Leeuw',
		@FOKID = NULL,
		@DIERNAAM = 'Hannah',
		@Geslacht = 'M',
		@GEBOORTEPLAATS = 'Somerleyton',
		@GEBOORTELAND = 'UK1',
		@GEBOORTEDATUM = '01-JAN-2000',
		@STATUS = 'Aanwezig'
END
GO
------------------------------------------ T1.3 - T1.4 -------------------------------------------- Jorian
-- Unit Tests UC 1.2
EXEC tSQLt.NewTestClass test_STP_InsertGebied
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertGebied].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GEBIED'
	EXEC tSQLt.FakeTable 'dbo', 'Medewerker'

	INSERT INTO GEBIED (GEBIEDNAAM, HOOFDVERZORGER)
	VALUES 
	('Savanne', 2),
	('Vlindertuin', 3)

	INSERT INTO MEDEWERKER (MEDEWERKERID,FUNCTIE)
	VALUES
	(1,'Hoofdverzorger'),
	(2,'Verzorger')

	INSERT INTO MEDEWERKER (MEDEWERKERID,FUNCTIE,GEBIEDNAAM)
	VALUES
	(3,'Hoofdverzorger','Vlindertuin')
END
GO

-- | T 1.3 | UC 1.2, FR 1.1 | Een gebied wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertGebied].[test Een Gebied wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertGebied
		@GebiedNaam = 'Savanne',
		@HOOFDVERZORGER = 1
END
GO

-- | T 1.4 | UC 1.2, FR 1.1 | Een gebied wordt niet toegevoegd met medewerker die niet hoofdverzorger is |
CREATE OR ALTER PROCEDURE [test_STP_InsertGebied].[test Een gebied wordt niet toegevoegd met medewerker die niet hoofdverzorger is]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertGebied
		@GebiedNaam = 'Savanne',
		@HOOFDVERZORGER = 2
END
GO

-- | T 1.4 | UC 1.2, FR 1.1 | Een gebied wordt niet toegevoegd met medewerker die al hoofdverzorger is |
CREATE OR ALTER PROCEDURE [test_STP_InsertGebied].[test Een gebied wordt niet toegevoegd met medewerker die al hoofdverzorger is]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertGebied
		@GebiedNaam = 'Savanne',
		@HOOFDVERZORGER = 3
END
GO

------------------------------------------ T1.5 - T1.6 -------------------------------------------- Nick
-- Unit Tests UC 1.3
EXEC tSQLt.NewTestClass test_STP_InsertVerblijf
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertVerblijf].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GEBIED'
	EXEC tSQLt.FakeTable 'dbo', 'VERBLIJF'

	INSERT INTO GEBIED (GEBIEDNAAM, HOOFDVERZORGER)
	VALUES 
	('Savanne', 2),
	('Vlindertuin', 3)
END
GO

-- | T 1.5 | UC 1.3, FR 1.2 | Een verblijf wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertVerblijf].[test Een verblijf wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertVerblijf
		@GebiedNaam = 'Savanne'
END
GO

-- | T 1.6 | UC 1.3, FR 1.2 | Een verblijf wordt niet toegevoegd met een fout Gebied |
CREATE OR ALTER PROCEDURE [test_STP_InsertVerblijf].[test Een verblijf wordt niet toegevoegd met een fout Gebied]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertVerblijf
		@GebiedNaam = 'De maan'
END
GO

------------------------------------------ T1.7 - T1.7 -------------------------------------------- Jorian
-- Unit Tests UC 1.4
EXEC tSQLt.NewTestClass 'Test_STP_InsertDiersoort'
GO

CREATE OR ALTER PROCEDURE [Test_STP_InsertDiersoort].[SetUp]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'DIER';	
END
GO

-- | T 1.7 | UC 1.4, FR 1.8 | Diereninformatie wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertDiersoort].[test Diereninformatie wordt toegevoegd met correcte parameters.]
AS
BEGIN
    EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDiersoort
		@Latijnsenaam = 'Panthera leon',
		@Normalenaam = 'Leeuw',
		@EduTekst = 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.',
		@Foto = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'				 
END
GO

-- | T 1.8 | UC 1.4, FR 1.8 | Diereninformatie wordt niet toegevoegd met incorrecte fotolink. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertDiersoort].[test Diereninformatie wordt niet toegevoegd met incorrecte fotolink.]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertDiersoort
		@Latijnsenaam = 'Panthera leo',
		@Normalenaam = 'Leeuw',
		@EduTekst = 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.',
		@FOTO = 'http//upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'
END 
GO

-- | T 1.8 | UC 1.4, FR 1.8 | Diereninformatie wordt niet toegevoegd met incorrecte Latijnsenaam. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertDiersoort].[test Diereninformatie wordt niet toegevoegd met incorrecte Latijnsenaam.]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertDiersoort
		@Latijnsenaam = 'Panthera 23leo',
		@Normalenaam = 'Leeuw',
		@EduTekst = 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.',
		@FOTO = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'
END 
GO

-- | T 1.8 | UC 1.4, FR 1.8 | Diereninformatie wordt niet toegevoegd met incorrecte Normalenaam. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertDiersoort].[test Diereninformatie wordt niet toegevoegd met incorrecte Normalenaam.]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertDiersoort
		@Latijnsenaam = 'Panthera leo',
		@Normalenaam = 'Leeuw1',
		@EduTekst = 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.',
		@FOTO = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'
END 
GO

------------------------------------------ T1.9 - T1.10 ------------------------------------------- Nick
-- Unit Tests UC 1.5
EXEC tSQLt.NewTestClass 'test_STP_InsertFokdossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER'
END
GO

-- | T 1.9 | UC 1.5, FR 1.16 | Een fokdossier wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt toegevoegd met correcte parameters]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('PAN-003', 'Savanne', 1, 'Panthera leo', 'Leo2', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Afwezig'),
	('PAN-004', 'Savanne', 1, 'Panthera leo', 'Jaiden2', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Afwezig')

	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('PAN-003', '10-JAN-2019', 'Somerleyton Animal Park', 'Nordhorn Zoo', NULL, NULL),
	('PAN-004', '10-JAN-2019', 'Somerleyton Animal Park', 'Nordhorn Zoo', NULL, NULL)

	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'

	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-004',
		@FokPartner = 'PAN-003',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Nordhorn Zoo'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een fout FokDier |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een fout FokDier.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'M', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een fout FokPartner. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een fout FokPartner.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'F', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een FokDatum in de toekomst. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een FokDatum in de toekomst.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-9999',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een FokDatum eerder dan de GeboorteDatum van FokDier. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een FokDatum eerder dan de GeboorteDatum van FokDier.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2008',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een FokDatum eerder dan de GeboorteDatum van FokPartner. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een FokDatum eerder dan de GeboorteDatum van FokPartner.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2009', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2007', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2008',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een andere FokPlaats als FokDier en FokPartner de Status Aanwezig hebben. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een andere FokPlaats als FokDier en FokPartner de Status Aanwezig hebben.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2009', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2007', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Nordhorn Zoo'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een ontbrekend Geslacht van FokDier. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een ontbrekend Geslacht van FokDier.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', NULL, 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd met een ontbrekend Geslacht van FokPartner. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd met een ontbrekend Geslacht van FokPartner.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', NULL, 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd als FokDier een andere status heeft dan FokPartner |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd als FokDier een andere status heeft dan FokPartner]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Afwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd als FokPartner een andere status heeft dan FokDier. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd als FokPartner een andere status heeft dan FokDier.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Afwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Somerleyton Animal Park'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd als FokDier zich momenteel niet bevind in de FokPlaats. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd als FokDier zich momenteel niet bevind in de FokPlaats.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Afwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Afwezig')

	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('PAN-001', '10-JAN-2019', 'Somerleyton Animal Park', 'Brookfield Zoo', NULL, NULL),
	('PAN-002', '10-JAN-2019', 'Somerleyton Animal Park', 'Nordhorn Zoo', NULL, NULL)

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Nordhorn Zoo'
END
GO

-- | T 1.10 | UC 1.5, FR 1.16 | Een fokdossier wordt niet toegevoegd als FokPartner zich momenteel niet bevind in de FokPlaats. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFokdossier].[test Een fokdossier wordt niet toegevoegd als FokPartner zich momenteel niet bevind in de FokPlaats.]
AS
BEGIN
	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Afwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Afwezig')

	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('PAN-001', '10-JAN-2019', 'Somerleyton Animal Park', 'Nordhorn Zoo', NULL, NULL),
	('PAN-002', '10-JAN-2019', 'Somerleyton Animal Park', 'Brookfield Zoo', NULL, NULL)

	EXEC tSQLt.ExpectException
	EXEC STP_InsertFokdossier
		@FokDier	= 'PAN-002',
		@FokPartner = 'PAN-001',
		@FokDatum	= '07-SEP-2020',
		@FokPlaats	= 'Nordhorn Zoo'
END
GO

------------------------------------------ T1.11 - T1.12 ------------------------------------------ Vince
-- Unit Tests UC 1.6
EXEC tSQLt.NewTestClass 'test_STP_InsertUitleendossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertUitleenDossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';

	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	(1, '13-JAN-2020', 'Somerleyton Animal Park', 'Apenheul', '13-APR-2020', 'Uitgeleend aan Apenheul om mee te fokken'),
	(1, '13-JAN-2021', 'Somerleyton Animal Park', 'Apenheul', '13-FEB-2021', 'Uitgeleend aan Apenheul om mee te fokken')

	INSERT INTO DIER(DIERID, GEBOORTEDATUM, [STATUS])
	VALUES
	(1, '12-DEC-2019', 'Aanwezig'),
	(2, '15-FEB-2003', 'Overleden')
END
GO

-- | T 1.11 | UC 1.6, FR 1.5| Een uitleendossier wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitleenDossier].[test Een UitleenDossier wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertUitleenDossier
		@DierID = 1, @UitleenDatum = '13-AUG-2020', @UitlenendeDierentuin = 'Somerleyton Animal Park', @OntvangendeDierentuin = 'Apenheul',
		@TerugkeerDatum = '13-DEC-2020', @UitleenOpmerking = 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T 1.12 | UC 1.6, FR 1.5| Een uitleendossier wordt niet toegevoegd met foute UitleenDatum. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitleenDossier].[test Een UitleenDossier wordt niet toegevoegd met foute UitleenDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertUitleenDossier --UitleenDatum after existing UitleenDatum
		@DierID = 1, @UitleenDatum = '12-JAN-2020', @UitlenendeDierentuin = 'Somerleyton Animal Park', @OntvangendeDierentuin = 'Apenheul',
		@TerugkeerDatum = '13-DEC-2020', @UitleenOpmerking = 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T1.12 | UC 1.6, FR 1.5 | Een uitleendossier wordt niet toegevoegd met foute UitlenendeDierentuin & OntvangendeDierentuin. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitleenDossier].[test Een UitleenDossier wordt niet toegevoegd met foute UitlenendeDierentuin & OntvangendeDierentuin]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertUitleenDossier --UitlenendeDierentuin Or OntvangendeDierentuin is not Somerleyton Animal Park
		@DierID = 1, @UitleenDatum = '13-AUG-2020', @UitlenendeDierentuin = 'Ouwehands Dierenpark', @OntvangendeDierentuin = 'Apenheul',
		@TerugkeerDatum = '13-DEC-2020', @UitleenOpmerking = 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T 1.12 | UC 1.6, FR 1.5| Een uitleendossier wordt niet toegevoegd met foute TerugkeerDatum. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitleenDossier].[test Een UitleenDossier wordt niet toegevoegd met foute TerugkeerDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertUitleenDossier --TerugkeerDatum Before UitleenDatum
		@DierID = 1, @UitleenDatum = '13-AUG-2020', @UitlenendeDierentuin = 'Somerleyton Animal Park', @OntvangendeDierentuin = 'Apenheul',
		@TerugkeerDatum = '12-AUG-2020', @UitleenOpmerking = 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T 1.12 | UC 1.6, FR 1.5| Een uitleendossier wordt niet toegevoegd met foute DierID. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitleenDossier].[test Een UitleenDossier wordt niet toegevoegd met foute DierID]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertUitleenDossier --DierID 2 has status 'Overleden'
		@DierID = 2, @UitleenDatum = '13-AUG-2020', @UitlenendeDierentuin = 'Somerleyton Animal Park', @OntvangendeDierentuin = 'Apenheul',
		@TerugkeerDatum = '13-DEC-2020', @UitleenOpmerking = 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

------------------------------------------ T1.13 - T1.14 ------------------------------------------ Vince
-- Unit Tests UC 1.23
EXEC tSQLt.NewTestClass 'test_STP_InsertGespot'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertGespot].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'GESPOT';

	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM, UITZETLOCATIE)
	VALUES(1, '1-DEC-2021', 'Nationaal natuurpark van Japan')
END
GO

-- | T 1.13 | UC 1.23, FR 1.18 | Een Spotting wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertGespot].[test Een Spotting wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertGespot
		@DierID = 1, @UitzetDatum = '1-DEC-2021', @SpotDatum ='8-DEC-2021' , @SpotLocatie = 'Nationaal natuurpark van Japan Noordkant' 
END
GO

-- | T 1.14 | UC 1.23, FR 1.18 | Een Spotting wordt niet toegevoegd met foute parameter DierID. |
CREATE OR ALTER PROCEDURE [test_STP_InsertGespot].[test Een Spotting wordt niet toegevoegd met foute parameter DierID]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertGespot --DierID does not exist in UitzetDossier
		@DierID = 2, @UitzetDatum = '1-DEC-2021', @SpotDatum ='8-DEC-2021' , @SpotLocatie = 'Nationaal natuurpark van Japan Noordkant' 
END
GO

-- | T 1.14 | UC 1.23, FR 1.18 | Een Spotting wordt niet toegevoegd met foute parameter UitzetDatum. |
CREATE OR ALTER PROCEDURE [test_STP_InsertGespot].[test Een Spotting wordt niet toegevoegd met foute parameter UitzetDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertGespot --UitzetDatum is not the same as in UitzetDossier
		@DierID = 1, @UitzetDatum = '2-DEC-2021', @SpotDatum ='8-DEC-2021' , @SpotLocatie = 'Nationaal natuurpark van Japan Noordkant' 
END
GO

-- | T 1.14 | UC 1.23, FR 1.18 | Een Spotting wordt niet toegevoegd met foute parameter SpotDatum. |
CREATE OR ALTER PROCEDURE [test_STP_InsertGespot].[test Een Spotting wordt niet toegevoegd met foute parameter SpotDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertGespot --SpotDatum before UitzetDatum
		@DierID = 1, @UitzetDatum = '1-DEC-2021', @SpotDatum ='30-NOV-2021' , @SpotLocatie = 'Nationaal natuurpark van Japan Noordkant' 
END
GO

-- | T1.14 | UC 1.23, FR 1.18 | Een Spotting wordt niet toegevoegd met foute parameter SpotLocatie. |
CREATE OR ALTER PROCEDURE [test_STP_InsertGespot].[test Een Spotting wordt niet toegevoegd met foute parameter SpotLocatie]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertGespot --SpotLocatie NULL
		@DierID = 1, @UitzetDatum = '1-DEC-2021', @SpotDatum ='8-DEC-2021' , @SpotLocatie = NULL
END
GO

------------------------------------------ T1.15 - T1.16 ------------------------------------------ Nick
-- Unit Tests UC 1.26
EXEC tSQLt.NewTestClass test_STP_InsertMedischDossier
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertMedischDossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.FakeTable 'dbo', 'MEDEWERKER'

	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Overleden')

	INSERT INTO MEDEWERKER (MEDEWERKERID ,VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES
	(1, 'Eboni', 'Lyons', 'Hoofdverzorger', 'Savanne'),
	(2, 'Bella-Rose', 'Harrison', 'Dierenarts', NULL)
END
GO

-- | T 1.15 | UC 1.26, FR 1.4 | Een medisch dossier wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedischDossier].[test Een medisch dossier wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertMedischDossier
		@Dierid = 'PAN-001',
		@ControleDatum = '01-01-2020',
		@MedewerkerID = '2'
END
GO

-- | T 1.16 | UC 1.26, FR 1.4 | Een medisch dossier wordt niet toegevoegd met een Controledatum voor de geboortedatum van het dier. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedischDossier].[test Een medisch dossier wordt niet toegevoegd met een Controledatum voor de geboortedatum van het dier]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertMedischDossier
		@Dierid = 'PAN-001',
		@ControleDatum = '01-01-1900',
		@MedewerkerID = '2'
END
GO

-- | T 1.16 | UC 1.26, FR 1.4 | Een medisch dossier wordt niet toegevoegd met een Controledatum in de toekomst. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedischDossier].[test Een medisch dossier wordt niet toegevoegd met een Controledatum in de toekomst]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertMedischDossier
		@Dierid = 'PAN-001',
		@ControleDatum = '01-01-9999',
		@MedewerkerID = '2'
END
GO

-- | T 1.16 | UC 1.26, FR 1.4 | Een medisch dossier wordt niet toegevoegd met een foute Dier_Status. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedischDossier].[test Een medisch dossier wordt niet toegevoegd met een foute Dier_Status]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertMedischDossier
		@Dierid = 'PAN-002',
		@ControleDatum = '01-01-2020',
		@MedewerkerID = '2'
END
GO

-- | T 1.16 | UC 1.26, FR 1.4 | Een medisch dossier wordt niet toegevoegd met een foute Medewerker_Functie. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedischDossier].[test Een medisch dossier wordt niet toegevoegd met een foute Medewerker_Functie]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertMedischDossier
		@Dierid = 'PAN-001',
		@ControleDatum = '01-01-2020',
		@MedewerkerID = '1'
END
GO

------------------------------------------ T1.17 - T1.18 ------------------------------------------ Levi
-- Unit Tests UC 1.29
EXEC tSQLt.NewTestClass 'test_STP_InsertDieetInformatie'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertDieetInformatie].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';
	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER';

	INSERT INTO DIER(DIERID, GEBOORTEDATUM, [STATUS])
	VALUES
	(1, '1-DEC-2021', 'Aanwezig'),
	(2, '3-JAN-2020', 'Uitgezet'),
	(3, '3-APR-2012', 'Overleden')

	INSERT INTO UITZETDOSSIER(DIERID, UITZETDATUM)
	VALUES
	(2, '30-DEC-2020')
END
GO

-- | T 1.17 | UC 1.29, FR 1.9 | Dieetinformatie wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDieetInformatie].[test DieetInformatie wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDieetInformatie
		@DierId = 1, @VoedselSoort = 'Banaan', @StartDatum = '1-DEC-2021', @HoeveelheidPerDag = 1, @Eenheid = 'Kilogram'
END
GO

-- | T 1.18 | UC 1.29, FR 1.9 | Dieetinformatie wordt niet toegevoegd met foute parameter DierID dat voorkomt in UitzetDossier. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDieetInformatie].[test Dieetinformatie wordt niet toegevoegd met foute parameter DierID dat voorkomt in UitzetDossier]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDieetInformatie -- DierID exists in UitzetDossier
		@DierId = 2, @VoedselSoort = 'Banaan', @StartDatum = '1-DEC-2021', @HoeveelheidPerDag = 1, @Eenheid = 'Kilogram'
END
GO

-- | T 1.18 | UC 1.29, FR 1.9 | Dieetinformatie wordt niet toegevoegd met foute parameter DierID met status 'Overleden'. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDieetInformatie].[test Dieetinformatie wordt niet toegevoegd met foute parameter DierID met status 'Overleden']
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDieetInformatie -- DierID status 'Overleden'
		@DierId = 3, @VoedselSoort = 'Banaan', @StartDatum = '1-DEC-2021', @HoeveelheidPerDag = 1, @Eenheid = 'Kilogram'
END
GO

-- | T 1.18 | UC 1.29, FR 1.9| Dieetinformatie wordt niet toegevoegd met foute parameter StartDatum'. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDieetInformatie].[test Dieetinformatie wordt niet toegevoegd met foute parameter StartDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDieetInformatie -- StartDatum before GeboorteDatum'
		@DierId = 1, @VoedselSoort = 'Banaan', @StartDatum = '30-NOV-2021', @HoeveelheidPerDag = 1, @Eenheid = 'Kilogram'
END
GO

-- | T 1.18 | UC 1.29, FR 1.9 | Dieetinformatie wordt niet toegevoegd met foute parameter HoeveelheidPerDag'. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDieetInformatie].[test Dieetinformatie wordt niet toegevoegd met foute parameter HoeveelheidPerDag]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDieetInformatie -- HoeveelheidPerDag < 1
		@DierId = 1, @VoedselSoort = 'Banaan', @StartDatum = '30-NOV-2021', @HoeveelheidPerDag = 0, @Eenheid = 'Kilogram'
END
GO

------------------------------------------ T1.19 - T1.20 ------------------------------------------
-- Unit Tests UC 1.30
EXEC tSQLt.NewTestClass 'Test_STP_InsertOntvangenGoederen'
GO

CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[SetUp]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'LEVERINGCONTROLE';	
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING';	
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLINGREGEL';	
	EXEC tSQLt.FakeTable 'dbo', 'EENHEDEN';

	INSERT INTO EENHEDEN (EENHEID)
	VALUES ('KILO')

	-- Goede data
	INSERT INTO BESTELLING(BESTELLINGID,BESTELDATUM,BESTELSTATUS)
	VALUES (1,'1-JAN-2000','BESTELD')

	INSERT INTO BESTELLINGREGEL(BESTELLINGID,BESTELDEHOEVEELHEID,VOEDSELSOORT)
	VALUES(1,100,'BANANEN')

	-- Teveel verwachte hoeveelheid
	INSERT INTO BESTELLING(BESTELLINGID,BESTELDATUM,BESTELSTATUS)
	VALUES (2,'5-JAN-2000','BESTELD')

	INSERT INTO BESTELLINGREGEL(BESTELLINGID,BESTELDEHOEVEELHEID,VOEDSELSOORT)
	VALUES(2,75,'BANANEN')

	-- Bestelling die al betaald is
	INSERT INTO BESTELLING(BESTELLINGID,BESTELDATUM,BESTELSTATUS)
	VALUES (3,'1-JAN-2000','BETAALD')

	INSERT INTO BESTELLINGREGEL(BESTELLINGID,BESTELDEHOEVEELHEID,VOEDSELSOORT)
	VALUES(3,100,'BANANEN')

	-- Zonder bestellingsregel
	INSERT INTO BESTELLING(BESTELLINGID,BESTELDATUM,BESTELSTATUS)
	VALUES (4,'1-JAN-2000','BETAALD')

	INSERT INTO BESTELLINGREGEL(BESTELLINGID,BESTELDEHOEVEELHEID,VOEDSELSOORT)
	VALUES(4,75,'APPELS')
END
GO

-- | T 1.19 | UC 1.30, FR 1.12 | Ontvangen goederen worden toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen worden toegevoegd met correcte parameters.]
AS
BEGIN
    EXEC tSQLt.ExpectNoException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 1,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '2-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 100,
		@EENHEID = 'KILO'			 
END
GO
-- | T 1.20 | UC 1.30, FR 1.12 | Ontvangen goederen niet kunnen worden toegevoegd omdat de levering gedaan is voor de bestelling |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen niet kunnen worden toegevoegd omdat de levering gedaan is voor de bestelling]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 2,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '6-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 100,
		@EENHEID = 'KILO'
END 
GO
-- | T 1.20 | UC 1.30, FR 1.12 | Ontvangen goederen niet kunnen worden toegevoegd omdat de verwachte hoeveelheid meer is dan er is besteld. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen niet kunnen worden toegevoegd omdat de verwachte hoeveelheid meer is dan er is besteld]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 2,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '2-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 50,
		@EENHEID = 'KILO'
END
GO

-- | T 1.20 | UC 1.30, FR 1.12 | Ontvangen goederen niet kunnen worden toegevoegd omdat de eenheid niet bestaat. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen niet kunnen worden toegevoegd omdat de eenheid niet bestaat]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 1,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '2-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 50,
		@EENHEID = 'GRAM'
END
GO
-- | T 1.20 | UC 1.30, FR 1.12 | Ontvangen goederen niet kunnen worden toegevoegd omdat er geen bestelling is bij deze levering. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen niet kunnen worden toegevoegd omdat er geen bestelling is bij deze levering]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 5,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '2-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 50,
		@EENHEID = 'GRAM'
END 
GO
-- | T 1.20 | UC 1.30, FR 1.12 | Ontvangen goederen niet kunnen worden toegevoegd omdat er geen bestellingregel is bij deze levering. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen niet kunnen worden toegevoegd omdat er geen bestellingregel is bij deze levering]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 4,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '2-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 50,
		@EENHEID = 'GRAM'
END 
GO
-- | T 1.20 | UC 1.30, FR 1.12 | Ontvangen goederen niet kunnen worden toegevoegd omdat de bestelling al is afgerond. |
CREATE OR ALTER PROCEDURE [Test_STP_InsertOntvangenGoederen].[test Ontvangen goederen niet kunnen worden toegevoegd omdat de bestelling al is afgerond]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_InsertOntvangenGoederen
		@BESTELLINGID = 4,
		@VOEDSELSOORT = 'BANANEN',
		@ONTVANGDATUMTIJD = '2-JAN-2000',
		@ONTVANGENHOEVEELHEID = 50,
		@VERWACHTEHOEVEELHEID = 100,
		@EENHEID = 'KILO'
END 
GO
------------------------------------------ T1.21 - T1.22 ------------------------------------------ Vince
-- Unit Tests UC 1.35
EXEC tSQLt.NewTestClass 'test_STP_InsertBestelling'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertBestelling].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING';
	EXEC tSQLt.FakeTable 'dbo', 'LEVERANCIER';

	INSERT INTO LEVERANCIER(LEVERANCIERNAAM)
	VALUES('Freeks Freaky Frikandellen')
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | Bestelling wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestelling].[test Een Bestelling wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertBestelling
		@LeverancierNaam = 'Freeks Freaky Frikandellen', @BestelDatum = '8-DEC-2021'
END
GO

-- | T 1.22 | UC 1.35, FR 1.10 | Bestelling wordt niet toegevoegd met incorrecte parameter LeverancierNaam. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestelling].[test Een Bestelling wordt toegevoegd met foute parameter LeverancierNaam]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestelling
		@LeverancierNaam = 'Freeks Frikandellen', @BestelDatum = '8-DEC-2021'
END
GO

-- | T 1.22 | UC 1.35, FR 1.10 | Bestelling wordt niet toegevoegd met incorrecte parameter BestelDatum. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestelling].[test Een Bestelling wordt toegevoegd met foute parameter BestelDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException 
	EXEC STP_InsertBestelling
		@LeverancierNaam = 'Freeks Freaky Frikandellen', @BestelDatum = 'dwadw'
END
GO

-- | T 1.22 | UC 1.35, FR 1.10 | Bestelling wordt niet toegevoegd met parameter BestelDatum die in de toekomst ligt. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestelling].[test Een Bestelling wordt niet toegevoegd met parameter BestelDatum die in de toekomst ligt]
AS
BEGIN
	EXEC tSQLt.ExpectException 
	EXEC STP_InsertBestelling
		@LeverancierNaam = 'Freeks Freaky Frikandellen', @BestelDatum = '8-DEC-9999'
END
GO

-- Unit Tests UC 1.35 (BestellingRegel)
EXEC tSQLt.NewTestClass 'test_STP_InsertBestellingRegel'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING';
	EXEC tSQLt.FakeTable 'dbo', 'VOEDSEL';
	EXEC tSQLt.FakeTable 'dbo', 'EENHEDEN';

	INSERT INTO BESTELLING(BESTELLINGID, LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	VALUES
	(1, 'Freeks Freaky Frikandellen', '8-DEC-2021', 'Besteld', NULL),
	(2, 'Freeks Freaky Frikandellen', '9-NOV-2021', 'Betaald', '11-NOV-2021')

	INSERT INTO VOEDSEL(VOEDSELSOORT)
	VALUES
	('Banaan'),
	('Stro'),
	('Hooi'),
	('Gedroogd Gras'),
	('Sla')

	INSERT INTO EENHEDEN(EENHEID)
	VALUES
	('Kilogram'),
	('Gram'),
	('Milligram'),
	('Liter'),
	('Milliliter'),
	('Aantal'),
	('Verpakkingen')
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertBestellingRegel
		@BestellingId = 1, @VoedselSoort = 'Banaan', @BesteldeHoeveelheid = 50, @Prijs = '£32.98', @Eenheid = 'Kilogram'
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt niet toegevoegd met foute parameter BestellingID. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt niet toegevoegd met foute parameter BestellingID]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestellingRegel --BestellingID unknown.
		@BestellingId = 4636, @VoedselSoort = 'Banaan', @BesteldeHoeveelheid = 50, @Prijs = '£32.98', @Eenheid = 'Kilogram'
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt niet toegevoegd met foute parameter VoedselSoort. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt niet toegevoegd met foute parameter VoedselSoort]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestellingRegel --Voedselsoort unknown.
		@BestellingId = 1, @VoedselSoort = 'Knakworst', @BesteldeHoeveelheid = 50, @Prijs = '£32.98', @Eenheid = 'Kilogram'
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt niet toegevoegd met foute parameter BesteldeHoeveelheid. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt niet toegevoegd met foute parameter BesteldeHoeveelheid]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestellingRegel --BesteldeHoeveelheid < 1
		@BestellingId = 1, @VoedselSoort = 'Banaan', @BesteldeHoeveelheid = 0, @Prijs = '£32.98', @Eenheid = 'Kilogram'
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt niet toegevoegd met foute parameter Prijs. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt niet toegevoegd met foute parameter Prijs]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestellingRegel --Prijs = 0
		@BestellingId = 1, @VoedselSoort = 'Banaan', @BesteldeHoeveelheid = 50, @Prijs = '£0', @Eenheid = 'Kilogram'
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt niet toegevoegd met foute parameter Prijs. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt niet toegevoegd met foute parameter Prijs]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestellingRegel --Eenheid unknown.
		@BestellingId = 1, @VoedselSoort = 'Banaan', @BesteldeHoeveelheid = 50, @Prijs = '£32.98', @Eenheid = 'Handjes'
END
GO

-- | T 1.21 | UC 1.35, FR 1.10 | BestellingRegel wordt niet toegevoegd met foute parameter BestellingId met status Betaald. |
CREATE OR ALTER PROCEDURE [test_STP_InsertBestellingRegel].[test Een Bestellingregel wordt niet toegevoegd met foute parameter BestellingId met status Betaald.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertBestellingRegel --Insert BestellingRegel that already is payed.
		@BestellingId = 2, @VoedselSoort = 'Banaan', @BesteldeHoeveelheid = 50, @Prijs = '£32.98', @Eenheid = 'Kilogram'
END
GO

------------------------------------------ T1.23 - T1.24 ------------------------------------------ Nick
-- Unit tests UC 1.44
EXEC tSQLt.NewTestClass test_STP_InsertLeverancier
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertLeverancier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'LEVERANCIER'
END
GO

-- | T 1.23 | UC 1.44, FR 1.11 | Leverancier wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertLeverancier].[test Een Leverancier wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertLeverancier
		@LeverancierNaam	= 'Freeks Freaky Frikandellen',
		@LeverancierPlaats	= 'Nijmegen',
		@leverancierAdres	= 'Professor Molkenboerstraat 3'
END
GO

-- | T 1.24 | UC 1.44, FR 1.11 | Leverancier wordt niet toegevoegd met incorrecte parameters. |
-- Er zijn geen constraints op leveranciers dus geen tests.

------------------------------------------ T1.25 - T1.26 ------------------------------------------ Vince
-- Unit Tests UC 1.48
EXEC tSQLt.NewTestClass 'test_STP_InsertVoedsel'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertVoedsel].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'VOEDSEL';
END
GO

-- | T 1.25 | UC 1.48, FR 1.19 | Een VoedselSoort wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertVoedsel].[test Een VoedselSoort wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertVoedsel
		@VoedselSoort = 'Banaan'
END
GO

-- | T 1.25 | UC 1.48, FR 1.19 | Een VoedselSoort wordt niet toegevoegd met incorrecte parameters. |
-- Er zijn geen constraints op voedselsoorten dus geen tests.

------------------------------------------ T1.27 - T1.28 ------------------------------------------ Nick
-- Unit Tests UC 1.50
EXEC tSQLt.NewTestClass test_STP_InsertFuncties
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertFuncties].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'FUNCTIES'
END
GO

-- | T 1.27 | UC 1.50, FR 1.20 | Functie wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertFuncties].[test Een Functie wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertFuncties
		@Functie = 'Verzorger'
END
GO

-- | T 1.28 | UC 1.50, FR 1.20 | Functie wordt niet toegevoegd met incorrecte parameters. |
-- Er zijn geen constraints op functie dus geen tests.

------------------------------------------ T1.29 - T1.30 ------------------------------------------ Nick
-- Unit Tests UC 1.53
EXEC tSQLt.NewTestClass test_STP_InsertMedewerker
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertMedewerker].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Medewerker'
END
GO

-- | T 1.29 | UC 1.53, FR 1.7 | Medewerker wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedewerker].[test Een Medewerker wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertMedewerker
		@GebiedNaam		= 'Savanne',
		@Voornaam		= 'Eboni',
		@Achternaam		= 'Lyons',
		@Functie		= 'Hoofdverzorger'

	EXEC STP_InsertMedewerker
		@GebiedNaam		= NULL,
		@Voornaam		= 'Eboni',
		@Achternaam		= 'Lyons',
		@Functie		= 'Kantoormedewerker'

	EXEC STP_InsertMedewerker
		@GebiedNaam		= NULL,
		@Voornaam		= 'Eboni',
		@Achternaam		= 'Lyons',
		@Functie		= 'Hoofdverzorger'
END
GO

-- | T 1.30 | UC 1.53, FR 1.7 | Een Medewerker wordt niet toegevoegd met een ongeldige GebiedNaam en Functie combinatie. |
CREATE OR ALTER PROCEDURE [test_STP_InsertMedewerker].[test Een Medewerker wordt niet toegevoegd met een ongeldige GebiedNaam en Functie combinatie.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertMedewerker
		@GebiedNaam		= 'Savanne',
		@Voornaam		= 'Eboni',
		@Achternaam		= 'Lyons',
		@Functie		= 'Kantoormedewerker'
END
GO

------------------------------------------ T1.31 - T1.32 ------------------------------------------ Jorian
-- Unit Tests UC 1.7
EXEC tSQLt.NewTestClass 'test_STP_InsertUitzetdossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertUitzetDossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UitzetDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';

	INSERT INTO UitzetDOSSIER(DIERID, UitzetDATUM, UITZETLOCATIE,UITZETPROGRAMMA, UitzetOPMERKING)
	VALUES
	(1, '13-JAN-2020', 'Kenya', 'aha', 'Uitgezet in afrika voor aba'),
	(1, '13-JAN-2021', 'Nederland', 'aba',  'Uitgezet op urk')

	INSERT INTO DIER(DIERID, GEBOORTEDATUM, [STATUS])
	VALUES
	(1, '12-DEC-2019', 'Aanwezig'),
	(2, '15-FEB-2003', 'Overleden')
END
GO

--| T 1.31 | UC 1.7, FR 1.6 | Een uitzet dossier wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitzetDossier].[test Een UitzetDossier wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertUitzetDossier
		@DierID = 1,
		@UitzetDatum = '13-AUG-2020',
		@UitzetLocatie = 'Nederland',
		@UitzetProgramma = 'alle',
		@UitzetOpmerking = 'Uitgezet op urk'
END
GO

--| T 1.32  | UC 1.7, FR 1.6 | Een uitzet dossier wordt niet toegevoegd met incorrecte UitzetDatum. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitzetDossier].[test Een UitzetDossier wordt niet toegevoegd met foute parameter UitzetDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertUitzetDossier
		@DierID = 1,
		@UitzetDatum = '13-AUG-2015',
		@UitzetLocatie = 'Nederland',
		@UitzetProgramma = 'alle',
		@UitzetOpmerking = 'Uitgezet op urk'
END
GO

--| T 1.32 | UC 1.7, FR 1.6 | Een uitzet dossier wordt niet toegevoegd met incorrecte DierID. |
CREATE OR ALTER PROCEDURE [test_STP_InsertUitzetDossier].[test Een UitzetDossier wordt niet toegevoegd met foute parameter DierID]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertUitzetDossier --DierID 2 has status 'Overleden'
		@DierID = 2,
		@UitzetDatum = '13-AUG-2020',
		@UitzetLocatie = 'Nederland',
		@UitzetProgramma = 'alle',
		@UitzetOpmerking = 'Uitgezet op urk'
END
GO

------------------------------------------ T1.33 - T1.34 ------------------------------------------ Nick
-- Unit Tests UC 1.6
EXEC tSQLt.NewTestClass test_STP_InsertDierentuin
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertDierentuin].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Dierentuin'
END
GO

-- | T 1.33 | UC 1.6, FR 1.15 | Een dierentuin wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDierentuin].[test Een dierentuin wordt toegevoegd met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDierentuin
		@DierentuinNaam			= 'Ouwehands Dierenpark',
		@Plaats					= 'Utrecht',
		@Land					= 'Nederland',
		@Hoofdverantwoordelijke	= 'Herman Biet',
		@ContactInformatie		= 'Grebbeweg 111, 3911 AV Rhenen, telefoon: 0317 650 200'

	EXEC STP_InsertDierentuin
		@DierentuinNaam			= 'Artis',
		@Plaats					= NULL,
		@Land					= NULL,
		@Hoofdverantwoordelijke	= NULL,
		@ContactInformatie		= NULL
END
GO

-- | T 1.34 | UC 1.6, FR 1.15 | Een dierentuin wordt niet toegevoegd met incorrecte parameters. |   
-- Er zijn geen constraints op Uitleendossier dus geen tests.

------------------------------------------ T 1.35 - T 1.36 ---------------------------------------- Jorian
-- Unit tests UC 1.4
EXEC tSQLt.NewTestClass test_STP_InsertSeksueeldimorfisme
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertSeksueeldimorfisme].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'SEKSUEELDIMORFISME'
END
GO

-- | T 1.35 | UC 1.4, FR 1.17 | Seksueeldimorfisme wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertSeksueeldimorfisme].[test Seksueeldimorfisme wordt toegevoegd met correcte parameters.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertSeksueeldimorfisme
		@LatijnseNaam = 'Panthera leo',
		@Geslacht = 'M',
		@Volwassenleeftijd = '5 Jaar',
		@Volwassengewicht = '150 tot 280 kg',
		@Overigekenmerken = 'kop-romplengte van 172 tot 250 cm'
END
GO

-- | T 1.36 | UC 1.4, FR 1.17 | Seksueeldimorfisme wordt niet toegevoegd met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertSeksueeldimorfisme].[test Seksueeldimorfisme wordt niet toegevoegd met incorrecte parameters.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertSeksueeldimorfisme
		@LatijnseNaam = 'Panthera leo1',
		@Geslacht = 'M',
		@Volwassenleeftijd = '5 Jaar',
		@Volwassengewicht = '150 tot 280 kg',
		@Overigekenmerken = 'kop-romplengte van 172 tot 250 cm'
END
GO

------------------------------------------ T 1.37 - T 1.38 -------------------------------------------- Vince
-- Unit Tests UC 1.27
EXEC tSQLt.NewTestClass 'test_STP_InsertDiagnoses'
GO

CREATE OR ALTER PROCEDURE [test_STP_InsertDiagnoses].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIAGNOSES';
	EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER';
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	VALUES(1, '9-DEC-2020', 1, '11-DEC-2020')
END
GO

-- | T 1.37 | UC 1.27, FR 1.4| Een diagnose wordt toegevoegd met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDiagnoses].[test Een diagnose wordt toegevoegd met correcte parameters.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_InsertDiagnoses
		@DierId = 1, @ControleDatum = '9-DEC-2020', @Diagnose = 'Luizen', @Voorschrift = 'Zalf'
END
GO

-- | T 1.38 | UC 1.27, FR 1.4| Een diagnose wordt niet toegevoegd met foute parameters diagnose en voorschrift. |
CREATE OR ALTER PROCEDURE [test_STP_InsertDiagnoses].[test Een diagnose wordt niet toegevoegd met foute parameters diagnose en voorschrift.]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_InsertDiagnoses --Diagnose AND Voorschrift is NULL
		@DierId = 1, @ControleDatum = '9-DEC-2020'
END
GO