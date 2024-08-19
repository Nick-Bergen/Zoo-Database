/* ==================================================
=	ISE-Project groep C-2							=
=	Tests Use Case UPDATE 3.1-3.38  				=
================================================== */ 

-- Testclass: [test_STP_Update'Tabel']
-- Testnamen: [Een 'entiteit' wordt toegevoegd met correcte parameters]
-- Testnamen: [Een 'entiteit' wordt niet toegevoegd met een foute 'NaamParameter']

/*
De Unit Tests volgen de vorm AAA: Assembly, Act, Assert
Eerst wordt er in de SetUp procedure tabellen gekopieerd en gevuld met testdata.
Vervolgens wordt een verwachte uitkomst gedeclareerd (Exception of NoException).
De te testen handeling/procedure wordt uitgevoerd en de test slaagt als de uitkomst overeenkomt met de verwachting.
*/

------------------------------------------ T3.1 - T3.2 -------------------------------------------- Nick
-- Unit Tests UC 1.8
EXEC tSQLt.NewTestClass test_STP_UpdateDier
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateDier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Dier'

	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig')
END
GO

-- | T 3.1 | UC 1.8, FR 1.3 | Een dier wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateDier].[test Een dier wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateDier
		@OudDierID			= 'PAN-001',
		@DierID		= NULL,
		@GebiedNaam			= NULL,
		@Verblijf			= NULL,
		@Diersoort			= 'Centrophorus harrissoni',
		@FokID				= NULL,
		@DierNaam			= 'Clara',
		@Geslacht			= NULL,
		@Geboorteplaats		= NULL,
		@GeboorteLand		= NULL,
		@GeboorteDatum		= NULL,
		@Status				= NULL

	EXEC STP_UpdateDier
		@OudDierID			= 'PAN-001',
		@DierID		= 'PAN-003',
		@GebiedNaam			= 'Europa & Amerika',
		@Verblijf			= 1,
		@Diersoort			= 'Centrophorus harrissoni',
		@FokID				= 0,
		@DierNaam			= 'Clara',
		@Geslacht			= 'F',
		@Geboorteplaats		= 'Anterpen',
		@GeboorteLand		= 'België',
		@GeboorteDatum		= '01-07-2006',
		@Status				= 'Afwezig'
END
GO

-- | T 3.2 | UC 1.8, FR 1.3 | Een dier wordt niet geüpdate met incorrecte parameters. |
-- Geen tests

------------------------------------------ T3.3 - T3.4 -------------------------------------------- Levi
-- Unit Tests UC 1.9
EXEC tSQLt.NewTestClass test_STP_UpdateGebied
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateGebied].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GEBIED'

	INSERT INTO GEBIED (GEBIEDNAAM)
	VALUES ('Vlindertuin')
END
GO

-- | T 3.3 | UC 1.9, FR 1.1 | Een gebied wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateGebied].[test Een verblijf wordt geupdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateGebied
		@OudeGebiedNaam = 'Vlindertuin',
		@NieuwGebiedNaam = 'Vlinderparadijs'
END
GO

-- | T 3.4 | UC 1.9, FR 1.1 | Een gebied wordt niet geüpdate met incorrecte parameters. |
-- Geen constraints aanwezig op gebiednamen, dus ook geen incorrecte parameters.

------------------------------------------ T3.5 - T3.6 -------------------------------------------- Jorian
-- Unit Tests UC 1.10
EXEC tSQLt.NewTestClass test_STP_UpdateVerblijf
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateVerblijf].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GEBIED'
	EXEC tSQLt.FakeTable 'dbo', 'VERBLIJF'

	INSERT INTO GEBIED (GEBIEDNAAM, HOOFDVERZORGER)
	VALUES 
		('Savanne', 2),
		('Vlindertuin', 3)

	INSERT INTO VERBLIJF( GEBIEDNAAM,VERBLIJFID)
	VALUES 
		('Savanne',1)
END
GO

-- | T 3.5 | UC 1.10, FR 1.2 | Een verblijf wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateVerblijf].[test Een verblijf wordt geupdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateVerblijf
		@OudGebiedNaam 	= 'Savanne',
		@GebiedNaam 	= 'Vlindertuin',
		@VerblijfID 		= 1
END
GO

-- | T 3.6 | UC 1.10, FR 1.2 | Een verblijf wordt niet geüpdate met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateVerblijf].[test Een verblijf wordt niet geupdate met een fout GEBIED]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateVerblijf
		@OudGebiedNaam 	= 'Savanne',
		@GebiedNaam 	= 'De maan',
		@VerblijfID 		= 1
END
GO

------------------------------------------ T3.7 - T3.8 -------------------------------------------- Vince
-- Unit Tests UC 1.11
EXEC tSQLt.NewTestClass test_STP_UpdateDiersoort
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateDiersoort].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_UpdateDiersoort].[actual]
	FROM DIERSOORT

	SELECT top 0 *
	INTO [test_STP_UpdateDiersoort].[verwacht]
	FROM DIERSOORT

    EXEC tSQLt.FakeTable 'dbo', 'DIERSOORT';	

	INSERT INTO DIERSOORT(LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
	VALUES('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.','https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')
END
GO

-- | T 3.7 | UC 1.11, FR 1.9 | Diereninformatie wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateDiersoort].[test Diereninformatie wordt geüpdate met correcte parameters.]
AS
BEGIN
	EXEC STP_UpdateDiersoort
		@OudLatijnseNaam 	= 'Panthera leo',
		@LatijnseNaam = 'Leo',
		@NormaleNaam 	= 'Leeuw',
		@EduTekst 	= 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.',
		@Foto 		= 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'

	INSERT INTO [test_STP_UpdateDiersoort].[actual]
	SELECT *
	FROM DIERSOORT

	INSERT INTO [test_STP_UpdateDiersoort].[verwacht]
	VALUES('Leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateDiersoort.actual', 'test_STP_UpdateDiersoort.verwacht'
END
GO

-- | T 3.8 | UC 1.11, FR 1.9 | Diereninformatie wordt niet geüpdate met incorrecte parameter OudeLatijnseNaam. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateDiersoort].[test Diereninformatie wordt niet geüpdate met incorrecte parameter OudeLatijnseNaam.]
AS
BEGIN
	EXEC STP_UpdateDiersoort
		@OudLatijnseNaam = 'Leo',
		@LatijnseNaam = 'Leo',
		@NormaleNaam = 'Leeuw',
		@EduTekst = 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter',
		@Foto = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'

	INSERT INTO [test_STP_UpdateDiersoort].[actual]
	SELECT *
	FROM DIERSOORT

	INSERT INTO [test_STP_UpdateDiersoort].[verwacht]
	VALUES('Panthera Leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateDiersoort.actual', 'test_STP_UpdateDiersoort.verwacht'
END
GO

------------------------------------------ T3.9 - T3.10 ------------------------------------------- Nick
-- Unit Tests UC 1.12
EXEC tSQLt.NewTestClass test_STP_UpdateFokdossier
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateFokdossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Fokdossier'

	INSERT INTO FOKDOSSIER (FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
	(0, 'PAN-002', 'PAN-001', '19-APR-2017', 'Nijmegen')
END
GO

-- | T 3.9 | UC 1.12, FR 1.16 | Een fokdossier wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateFokdossier].[test Een fokdossier wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateFokdossier
		@FokID				= 0,
		@Fokdier			= 'PAN-003',
		@Fokpartner			= NULL,
		@Fokdatum			= NULL,
		@Fokplaats			= NULL

	EXEC STP_UpdateFokdossier
		@FokID				= 0,
		@Fokdier			= 'PAN-003',
		@Fokpartner			= 'PAN-001',
		@Fokdatum			= '19-APR-2017',
		@Fokplaats			= 'Nijmegen'
END
GO

-- | T 3.10 | UC 1.12, FR 1.16 | Een fokdossier wordt niet geüpdate met incorrecte parameters. |
-- Geen tests
------------------------------------------ T3.11 - T3.12 ------------------------------------------ Levi
-- Unit Tests UC 1.13
EXEC tSQLt.NewTestClass 'test_STP_UpdateUitleendossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateUitleendossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';

	INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES(1, '13-JAN-2020', 'Somerleyton Animal Park', 'Apenheul', '13-APR-2020', 'Uitgeleend aan Apenheul om mee te fokken'),
		  (1, '13-JAN-2021', 'Somerleyton Animal Park', 'Apenheul', '13-FEB-2021', 'Uitgeleend aan Apenheul om mee te fokken')

	INSERT INTO DIER(DIERID, GEBOORTEDATUM, [STATUS])
	VALUES(1, '12-DEC-2019', 'Aanwezig'),
		  (2, '15-FEB-2003', 'Overleden')
END
GO

-- | T 3.11 | UC 1.13, FR 1.5 | Een uitleendossier wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitleenDossier].[test Een UitleenDossier wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateUitleenDossier
		@OudDierID 				= 1, 
		@OudUitleenDatum 		= '13-JAN-2020',
		@DierID 				= 1,
		@UitleenDatum			= '13-JAN-2020', 
		@UitlenendeDierentuin 	= 'Somerleyton Animal Park', 
		@OntvangendeDierentuin 	= 'Apenheul',
		@TerugkeerDatum 		= '13-MAY-2020', 
		@UitleenOpmerking 		= 'Uitgeleend aan Apenheul om mee te fokken, verlengd met een maand'
END
GO

-- | T 3.12 | UC 1.13, FR 1.5 | Een uitleendossier wordt niet geüpdate met foute UitleenDatum |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitleenDossier].[test Een uitleendossier wordt niet geüpdate met foute UitleenDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateUitleenDossier --UitleenDatum voor bestaande UitleenDatum
		@OudDierID 				= 1, 
		@OudUitleendatum 		= '13-JAN-2020',
		@DierID 				= 1, 
		@UitleenDatum 			= '13-JAN-2021', 
		@UitlenendeDierentuin 	= 'Somerleyton Animal Park', 
		@OntvangendeDierentuin	= 'Apenheul',
		@TerugkeerDatum 		= '30-FEB-2021', 
		@UitleenOpmerking 		= 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T 3.12 | UC 1.13, FR 1.5 | Een UitleenDossier wordt niet geüpdate met foute UitlenendeDierentuin & OntvangendeDierentuin |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitleenDossier].[test Een UitleenDossier wordt niet geüpdate met foute UitlenendeDierentuin & OntvangendeDierentuin]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateUitleenDossier --UitlenendeDierentuin Of OntvangendeDierentuin is niet Somerleyton Animal Park
		@OudDierID 				= 1, 
		@OudUitleendatum 		= '13-JAN-2020',
		@DierID 				= 1, 
		@UitleenDatum 			= '13-AUG-2020', 
		@UitlenendeDierentuin 	= 'Ouwehands Dierenpark',
		@OntvangendeDierentuin 	= 'Apenheul',
		@TerugkeerDatum 		= '13-DEC-2020', 
		@UitleenOpmerking 		= 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T 3.12 | UC 1.13, FR 1.5 | Een UitleenDossier wordt niet geüpdate met foute TerugkeerDatum |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitleenDossier].[test Een UitleenDossier wordt niet geüpdate met foute TerugkeerDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateUitleenDossier --TerugkeerDatum voor UitleenDatum
		@OudDierID 				= 1, 
		@OudUitleendatum 		= '13-JAN-2020',
		@DierID 				= 1, 
		@UitleenDatum 			= '13-JAN-2020', 
		@UitlenendeDierentuin 	= 'Somerleyton Animal Park', 
		@OntvangendeDierentuin 	= 'Apenheul',
		@TerugkeerDatum 		= '12-JAN-2020',
		@UitleenOpmerking 		= 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

-- | T 3.12 | UC 1.13, FR 1.5 | Een UitleenDossier wordt niet geüpdate met foute DierID |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitleenDossier].[test Een UitleenDossier wordt niet geüpdate met foute DierID]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateUitleenDossier --DierID 2 heeft status 'Overleden'
		@OudDierID 				= 1, 
		@OudUitleendatum 		= '13-JAN-2020',
		@DierID 				= 2, 
		@UitleenDatum 			= '13-JAN-2020', 
		@UitlenendeDierentuin 	= 'Somerleyton Animal Park', 
		@OntvangendeDierentuin 	= 'Apenheul',
		@TerugkeerDatum			= '13-APR-2020',
		@UitleenOpmerking 		= 'Uitgeleend aan Apenheul om mee te fokken'
END
GO

------------------------------------------ T3.13 - T3.14 ------------------------------------------ Jorian
-- Unit Tests UC 1.14
EXEC tSQLt.NewTestClass 'test_STP_UpdateUitzetdossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateUitzetDossier].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'UitzetDOSSIER';
	EXEC tSQLt.FakeTable 'dbo', 'DIER';

	INSERT INTO UitzetDOSSIER(DIERID, UitzetDATUM, UITZETLOCATIE,UITZETPROGRAMMA, UitzetOPMERKING)
	VALUES(1, '13-JAN-2020', 'Kenya', 'aha', 'Uitgezet in afrika voor aba'),
		  (1, '13-JAN-2021', 'Nederland', 'aba',  'Uitgezet op urk')

	INSERT INTO DIER(DIERID, GEBOORTEDATUM, STATUS)
	VALUES(1, '12-DEC-2019', 'Aanwezig'),
		  (2, '15-FEB-2003', 'Overleden')
END
GO
-- | T 3.13 | UC 1.14, FR 1.6 | Uitzetdossier wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitzetDossier].[test Een UitzetDossier wordt geupdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateUitzetDossier
		@OudDierID 			= 1,
		@oudUitzetDatum 	= '13-JAN-2020',
		@Dierid 			= 1,
		@UitzetDatum 		= '13-JAN-2020',
		@UitzetLocatie 		= 'Nederland',
		@UitzetProgramma 	= 'alle',
		@UitzetOpmerking 	= 'Uitgezet op urk'
END
GO
-- | T 3.13 | UC 1.14, FR 1.6 | Uitzetdossier wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitzetDossier].[test Een UitzetDossier wordt geupdate met correcte parameters en update dier]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 1;

	EXEC STP_UpdateUitzetDossier
	    @OudDierID 			= 1,
		@oudUitzetDatum 	= '13-JAN-2020',
		@DierID 			= 1,
		@UitzetDatum 		= '13-JAN-2020',
		@UitzetLocatie 		= 'Nederland',
		@UitzetProgramma 	= 'alle',
		@UitzetOpmerking 	= 'Uitgezet op urk'

	SELECT @actual = COUNT(*) FROM DIER WHERE STATUS = 'Uitgezet'
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO

-- | T 3.14 | UC 1.14, FR 1.6 | Uitzetdossier wordt niet geüpdate met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitzetDossier].[test Een UitzetDossier wordt niet geupdate met foute parameter UitzetDatum]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateUitzetDossier
	    @OudDierID 			= 1,
		@oudUitzetDatum 	= '13-JAN-2020',
		@DierID 			= 1,
		@UitzetDatum 		= '13-AUG-2015',
		@UitzetLocatie 		= 'Nederland',
		@UitzetProgramma 	= 'alle',
		@UitzetOpmerking 	= 'Uitgezet op urk'
END
GO

-- | T 3.14 | UC 1.14, FR 1.6 | Uitzetdossier wordt niet geüpdate met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateUitzetDossier].[test Een UitzetDossier wordt niet geupdate met foute parameter DierID]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateUitzetDossier --DierID 2 has status 'Overleden'
	    @OudDierID 			= 1,
		@oudUitzetDatum 	= '13-JAN-2020',
		@DierID 			= 2,
		@UitzetDatum 		= '13-AUG-2020',
		@UitzetLocatie 		= 'Nederland',
		@UitzetProgramma 	= 'alle',
		@UitzetOpmerking 	= 'Uitgezet op urk'
END
GO

------------------------------------------ T3.15 - T3.16 ------------------------------------------ Vince
-- Unit Tests UC 1.24
EXEC tSQLt.NewTestClass 'test_STP_UpdateGespot'
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateGespot].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_UpdateGespot].[actual]
	FROM GESPOT

	SELECT top 0 *
	INTO [test_STP_UpdateGespot].[verwacht]
	FROM GESPOT

    EXEC tSQLt.FakeTable 'dbo', 'GESPOT';	

	INSERT INTO GESPOT(DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE)
	VALUES(1, '12-DEC-2020', '12-DEC-2021', 'Portugal, Oost van Lisbon')
END	
GO

-- | T 3.15 | UC 1.24, FR 1.18 | Een spotting wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateGespot].[test Een spotting wordt geüpdate met correcte parameters.]
AS
BEGIN
	EXEC STP_UpdateGespot
		@OudDierID 		= 1,
		@OudUitzetDatum 	= '12-DEC-2020',
		@OudSpotDatum 		= '12-DEC-2021',
		@NieuweDierID 		= 1,
		@NieuweUitzetDatum	= '12-DEC-2020',
		@NieuweSpotDatum 	= '12-NOV-2021',
		@NieuweSpotLocatie 	= 'Portugal, Oost van Lisabon'

	INSERT INTO [test_STP_UpdateGespot].[actual]
	SELECT *
	FROM GESPOT

	INSERT INTO [test_STP_UpdateGespot].[verwacht]
	VALUES(1, '12-DEC-2020', '12-NOV-2021', 'Portugal, Oost van Lisabon')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateGespot.actual', 'test_STP_UpdateGespot.verwacht'
END
GO

-- | T 3.16 | UC 1.24, FR 1.18 | Een spotting wordt niet geüpdate met incorrecte parameters DierID, UitzetDatum, SpotDatum. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateGespot].[test Een spotting wordt niet geüpdate met incorrecte parameters DierID, UitzetDatum, SpotDatum.]
AS
BEGIN
	EXEC STP_UpdateGespot
		@OudDierID 		= 2,
		@OudUitzetDatum 	= '12-DEC-2019',
		@OudSpotDatum 		= '12-DEC-2020',
		@NieuweDierID 		= 1,
		@NieuweUitzetDatum 	= '12-DEC-2020',
		@NieuweSpotDatum 	= '12-NOV-2021',
		@NieuweSpotLocatie 	= 'Portugal, Oost van Lisabon'

	INSERT INTO [test_STP_UpdateGespot].[actual]
	SELECT *
	FROM GESPOT

	INSERT INTO [test_STP_UpdateGespot].[verwacht]
	VALUES(1, '12-DEC-2020', '12-DEC-2021', 'Portugal, Oost van Lisbon')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateGespot.actual', 'test_STP_UpdateGespot.verwacht'
END
GO

------------------------------------------ T3.17 - T3.18 ------------------------------------------ Nick
-- Unit Tests UC 1.31
EXEC tSQLt.NewTestClass test_STP_UpdateDieetinformatie
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateDieetinformatie].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DieetInformatie'

	INSERT INTO DIEETINFORMATIE (DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('PAN-001', 'Gecondenseerde Melk', '19-APR-2007', '1.5', 'Liter')
END
GO

-- | T 3.17 | UC 1.31, FR 1.16 | Een dieetinformatie wordt geüpdate met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateDieetinformatie].[test Een dieetinformatie wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateDieetinformatie
		@OudDierID			= 'PAN-001',
		@DierID		= NULL,
		@OudVoedselSoort	= 'Gecondenseerde Melk',
		@VoedselSoort	= NULL,
		@OudStartdatum		= '19-APR-2007',
		@Startdatum	= NULL,
		@HoeveelheidPerDag	= '2',
		@Eenheid			= 'Liter'	

	EXEC STP_UpdateDieetinformatie
		@OudDierID			= 'PAN-001',
		@DierID		= 'PAN-002',
		@OudVoedselSoort	= 'Gecondenseerde Melk',
		@VoedselSoort	= 'Gefrituurd Melk',
		@OudStartdatum		= '19-APR-2007',
		@Startdatum	= '19-APR-2009',
		@HoeveelheidPerDag	= '2.2',
		@Eenheid			= 'KG'	
END
GO

-- | T 3.18 | UC 1.31, FR 1.16 | Een dieetinformatie wordt niet geüpdate met de incorrecte parameters. |
-- Geen tests

------------------------------------------ T3.19 - T3.20 ------------------------------------------ Levi
-- Unit Tests UC 1.27
EXEC tSQLt.NewTestClass 'test_STP_UpdateMedischDossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateMedischDossier].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_UpdateMedischDossier].[actual]
	FROM MEDISCHDOSSIER

	SELECT top 0 *
	INTO [test_STP_UpdateMedischDossier].[verwacht]
	FROM MEDISCHDOSSIER

    EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER';	
	
	INSERT INTO MEDISCHDOSSIER(DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	VALUES (1, '12-DEC-2021', 1, '13-DEC-2021')
END	
GO

-- | T 3.19 | UC 1.27, FR 1.5 | Een medisch dossier wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateMedischDossier].[test Een medisch dossier wordt geüpdate met correcte parameters.]
AS
BEGIN
	EXEC STP_UpdateMedischDossier
		@OudDierId 				= 1,
		@OudDatumControle 		= '12-DEC-2021',
		@DierId 			= 2,
		@DatumControle 	= '13-DEC-2021',
		@MedewerkerID 		= 2,
		@VolgendeControle	= '17-DEC-2021'
			
	INSERT INTO [test_STP_UpdateMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	SELECT DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE
	FROM MEDISCHDOSSIER

	INSERT INTO [test_STP_UpdateMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	VALUES(2, '13-DEC-2021', 2, '17-DEC-2021')
			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateMedischDossier.actual', 'test_STP_UpdateMedischDossier.verwacht'
END
GO

-- | T 3.20 | UC 1.27, FR 1.5 | Een medisch dossier wordt niet geüpdate met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateMedischDossier].[test Een medisch dossier wordt niet geüpdate met incorrecte parameters DierId.]
AS
BEGIN
	EXEC STP_UpdateMedischDossier --DierId bestaat niet in MedischDossier
		@OudDierId 				= 3,
		@OudDatumControle 		= '12-DEC-2021',
		@DierId 			= 1,
		@DatumControle 	= '13-DEC-2021',
		@MedewerkerID 		= 2,
		@VolgendeControle 	= '17-DEC-2021'
			
	INSERT INTO [test_STP_UpdateMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	SELECT DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE
	FROM MEDISCHDOSSIER

	INSERT INTO [test_STP_UpdateMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	VALUES(1, '12-DEC-2021', 1, '13-DEC-2021')
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateMedischDossier.actual', 'test_STP_UpdateMedischDossier.verwacht'
END
GO

------------------------------------------ T3.21 - T3.22 ------------------------------------------ Jorian
-- Unit Tests UC 1.30
EXEC tSQLt.NewTestClass 'Test_STP_UpdateOntvangenGoederen'
GO

CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[SetUp]
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

-- | T 3.21 | UC 1.33, FR 1.12 | Ontvangen goederen worden geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen worden geupdate met correcte parameters.]
AS
BEGIN
    EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 1,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '2-JAN-2000',
		@BESTELLINGID 			= 1,
		@VOEDSELSOORT 			= 'BANANEN',
		@ONTVANGDATUMTIJD 		= '2-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 100,
		@EENHEID 				= 'KILO'
END
GO

-- | T 3.22 | UC 1.33, FR 1.12 | Ontvangen goederen niet kunnen worden geupdate omdat de levering gedaan is voor de bestelling. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen niet kunnen worden geupdate omdat de levering gedaan is voor de bestelling]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 2,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '6-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 100,
		@EENHEID 				= 'KILO'
END 
GO

-- | T 3.22 | UC 1.33, FR 1.12 | Ontvangen goederen niet kunnen worden geupdate omdat de verwachte hoeveelheid meer is dan er is besteld. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen niet kunnen worden geupdate omdat de verwachte hoeveelheid meer is dan er is besteld]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 2,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '2-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 50,
		@EENHEID 				= 'KILO'
END 
GO

-- | T 3.22 | UC 1.33, FR 1.12 | Ontvangen goederen niet kunnen worden geupdate omdat de eenheid niet bestaat. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen niet kunnen worden geupdate omdat de eenheid niet bestaat]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 1,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '2-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 50,
		@EENHEID 				= 'GRAM'

END 
GO

-- | T 3.22 | UC 1.33, FR 1.12 | Ontvangen goederen niet kunnen worden geupdate omdat er geen bestelling is bij deze levering. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen niet kunnen worden geupdate omdat er geen bestelling is bij deze levering]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 5,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '2-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 50,
		@EENHEID 				= 'GRAM'

END 
GO

-- | T 3.22 | UC 1.33, FR 1.12 | Ontvangen goederen niet kunnen worden geupdate omdat er geen bestellingregel is bij deze levering. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen niet kunnen worden geupdate omdat er geen bestellingregel is bij deze levering]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 4,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '2-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 50,
		@EENHEID 				= 'GRAM'
END 
GO

-- | T 3.22 | UC 1.33, FR 1.12 | Ontvangen goederen niet kunnen worden geupdate omdat de bestelling al is afgerond. |
CREATE OR ALTER PROCEDURE [Test_STP_UpdateOntvangenGoederen].[test Ontvangen goederen niet kunnen worden geupdate omdat de bestelling al is afgerond]
AS
BEGIN
    EXEC tSQLt.ExpectException
	EXEC STP_UpdateOntvangenGoederen
		@OudBESTELLINGID 		= 4,
		@OudVOEDSELSOORT 		= 'BANANEN',
		@OudONTVANGDATUMTIJD 	= '2-JAN-2000',
		@ONTVANGENHOEVEELHEID 	= 50,
		@VERWACHTEHOEVEELHEID 	= 100,
		@EENHEID 				= 'KILO'
END 
GO

------------------------------------------ T3.23 - T3.24 ------------------------------------------ Vince
-- Unit Tests UC 1.36
EXEC tSQLt.NewTestClass 'test_STP_UpdateStatusBestelling'
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateStatusBestelling].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_UpdateStatusBestelling].[actual]
	FROM BESTELLING

	SELECT top 0 *
	INTO [test_STP_UpdateStatusBestelling].[verwacht]
	FROM BESTELLING

    EXEC tSQLt.FakeTable 'dbo', 'BESTELLING';	
	INSERT INTO BESTELLING(BESTELLINGID, LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	VALUES (1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Betaling_Nodig', NULL),
		   (2, 'Mapleton Zoological Supplies', '25-JAN-2021', 'Besteld', NULL)
END	
GO

-- | T 3.23 | UC 1.36, FR 1.13 | Bestelling als betaald wordt ingesteld als de order compleet is. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateStatusBestelling].[test Bestelling als betaald wordt ingesteld als de order compleet is. ]
AS
BEGIN
	EXEC STP_UpdateStatusBestelling
		@BestellingID 		= 1,
		@BestelStatus 		= 'Betaald',
		@BetaalDatum 		= '25-JAN-2021'

	INSERT INTO [test_STP_UpdateStatusBestelling].[actual](LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	SELECT LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM
	FROM BESTELLING

	INSERT INTO [test_STP_UpdateStatusBestelling].[verwacht](LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	VALUES('Mapleton Zoological Supplies', '23-JAN-2021', 'Betaald', '25-JAN-2021'),
		  ('Mapleton Zoological Supplies', '25-JAN-2021', 'Besteld', NULL)
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateStatusBestelling.actual', 'test_STP_UpdateStatusBestelling.verwacht'
END
GO

-- | T 3.24 | UC 1.36, FR 1.13 | Bestelling niet als betaald wordt ingesteld als de order niet compleet is. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateStatusBestelling].[test Bestelling niet als betaald wordt ingesteld als de order niet compleet is. ]
AS
BEGIN
	EXEC [tSQLt].[ExpectException]

	--Update status naar 'Betaald' van bestelling die niet op 'Betaling_Nodig' staat
	EXEC STP_UpdateStatusBestelling
		@BestellingID 	= 2,
		@BestelStatus 	= 'Betaald',
		@BetaalDatum 	= '26-JAN-2021'
END
GO

------------------------------------------ T3.25 - T3.26 ------------------------------------------ Nick
-- Unit Tests UC 1.37
EXEC tSQLt.NewTestClass test_STP_UpdateBestelling
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateBestelling].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Bestelling'

	INSERT INTO BESTELLING (BESTELLINGID, LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	VALUES 
	(0, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL)
END
GO

-- | T 3.25 | UC 1.37, FR 1.10 | Een bestelling wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateBestelling].[test Een dieetinformatie wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateBestelling
		@BestellingID		= 0,
		@LeverancierNaam	= 'Mapleton Zoological Supplies',
		@BestelDatum		= '23-JAN-2021',
		--@BestelStatus		= 'Besteld',
		@BetaalDatum		= NULL

	EXEC STP_UpdateBestelling
		@BestellingID		= 0,
		@LeverancierNaam	= 'Mapleton Zoological Supplies',
		@BestelDatum		= '23-JAN-2021',
		--@BestelStatus		= 'Betaald',
		@BetaalDatum		= '24-JAN-2021'
END
GO

-- | T 3.26 | UC 1.37, FR 1.10 | Een bestelling wordt niet geüpdate met incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateBestelling].[test Een dieetinformatie wordt niet geüpdate met een BestelDatum die in de toekomst ligt]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateBestelling
		@BestellingID		= 0,
		@LeverancierNaam	= 'Mapleton Zoological Supplies',
		@BestelDatum		= '23-JAN-9999',
		--@BestelStatus		= 'Besteld',
		@BetaalDatum		= NULL
END
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateBestelling].[test Een dieetinformatie wordt niet geüpdate met een BetaalDatum die in de toekomst ligt]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateBestelling
		@BestellingID		= 0,
		@LeverancierNaam	= 'Mapleton Zoological Supplies',
		@BestelDatum		= '23-JAN-2021',
		--@BestelStatus		= 'Besteld',
		@BetaalDatum		= '23-JAN-9999'
END
GO
------------------------------------------ T3.27 - T3.28 ------------------------------------------ Nick
-- Unit Tests UC 1.38
EXEC tSQLt.NewTestClass test_STP_UpdateBestellingRegel
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateBestellingRegel].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BestellingRegel'

	INSERT INTO BESTELLINGREGEL(BESTELLINGID, VOEDSELSOORT, BESTELDEHOEVEELHEID, PRIJS, EENHEID)
	VALUES (0, 'Stro', 2, 2.50, 'KG')
END
GO

-- | T 3.27 | UC 1.38, FR 1.10 | Een voedselbestelling wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateBestellingRegel].[test Een voedselsoort wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateBestellingRegel
		@OudBestellingID			= 0,
		@OudVoedselSoort		= 'Stro',
		@VoedselSoort		= NULL,
		@BesteldeHoeveelheid	= 2,
		@Prijs					= 2.50,
		@Eenheid				= 'KG'

	EXEC STP_UpdateBestellingRegel
		@OudBestellingID			= 0,
		@OudVoedselSoort		= 'Stro',
		@VoedselSoort		= 'Hooi',
		@BesteldeHoeveelheid	= 3,
		@Prijs					= 50.5,
		@Eenheid				= 'L'
END
GO

-- | T 3.28 | UC 1.38, FR 1.10 | Een voedselbestelling wordt niet geüpdate met incorrecte parameters. |
-- Geen test

------------------------------------------ T3.29 - T3.30 ------------------------------------------ Jorian
-- Unit Tests UC 1.41
EXEC tSQLt.NewTestClass test_STP_UpdateHoofdverzorger
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateHoofdverzorger].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'GEBIED'

	INSERT INTO GEBIED (GEBIEDNAAM,HOOFDVERZORGER)
	VALUES ('Vlindertuin',4), ('Savanna',2), ('Heuvel',3)
END
GO

-- | T 3.29 | UC 1.41, FR 1.1 | De hoofdverzorger van een gebied wordt geüpdate met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateHoofdverzorger].[test Een verblijf wordt geupdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateHoofdverzorger
		@GebiedNaam = 'Vlindertuin',
		@NieuweHoofdverzorger = 1
END
GO

-- | T 3.30 | UC 1.41, FR 1.1 | De hoofdverzorger van een gebied wordt niet geüpdate met de incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateHoofdverzorger].[test Een verblijf wordt niet geupdate met incorrecte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectException
	EXEC STP_UpdateHoofdverzorger
		@GebiedNaam = 'Savanna',
		@NieuweHoofdverzorger = 3
END
GO
    
------------------------------------------ T3.31 - T3.32 ------------------------------------------ Vince
-- Unit Tests UC 1.42
EXEC tSQLt.NewTestClass 'test_STP_UpdateGebiedVerzorger'
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateGebiedVerzorger].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_UpdateGebiedVerzorger].[actual]
	FROM MEDEWERKER

	SELECT top 0 *
	INTO [test_STP_UpdateGebiedVerzorger].[verwacht]
	FROM MEDEWERKER

    EXEC tSQLt.FakeTable 'dbo', 'MEDEWERKER';	
	
	INSERT INTO MEDEWERKER(MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES(1,'Andrei', 'Meyer', 'Verzorger', 'Savanne'),
		  (2,'Rhiannon', 'Huff', 'Hoofdverzorger', 'Vlindertuin'),
		  (3, 'Esmay', 'Swift', 'Dierenarts', NULL)
END	
GO

-- | T 3.31 | UC 1.42, FR 1.7 | Een gebied bij een verzorger wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateGebiedVerzorger].[test Een gebied bij een verzorger wordt geüpdate met correcte parameters.]
AS
BEGIN
	EXEC STP_UpdateGebiedVerzorger
		@MedewerkerID 	= 1,
		@Gebiednaam 	= 'Vlindertuin'
	
	INSERT INTO [test_STP_UpdateGebiedVerzorger].[actual](VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	SELECT VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM
	FROM MEDEWERKER

	INSERT INTO [test_STP_UpdateGebiedVerzorger].[verwacht](VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES('Andrei', 'Meyer', 'Verzorger', 'Vlindertuin'),
		  ('Rhiannon', 'Huff', 'Hoofdverzorger', 'Vlindertuin'),
		  ('Esmay', 'Swift', 'Dierenarts', NULL)
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateGebiedVerzorger.actual', 'test_STP_UpdateGebiedVerzorger.verwacht'
END
GO

-- | T 3.31 | UC 1.42, FR 1.7 | Een gebied bij een verzorger wordt geüpdate met correcte parameters Medewerkerid met functie Hoofdverzorger |
CREATE OR ALTER PROCEDURE [test_STP_UpdateGebiedVerzorger].[test Een gebied bij een verzorger wordt geüpdate met correcte parameters Medewerkerid met functie Hoofdverzorger.]
AS
BEGIN
	EXEC STP_UpdateGebiedVerzorger
		@MedewerkerID 	= 2,
		@Gebiednaam 	= 'Savanne'
	
	INSERT INTO [test_STP_UpdateGebiedVerzorger].[actual](VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	SELECT VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM
	FROM MEDEWERKER

	INSERT INTO [test_STP_UpdateGebiedVerzorger].[verwacht](VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES('Andrei', 'Meyer', 'Verzorger', 'Savanne'),
		  ('Rhiannon', 'Huff', 'Hoofdverzorger', 'Savanne'),
		  ('Esmay', 'Swift', 'Dierenarts', NULL)
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateGebiedVerzorger.actual', 'test_STP_UpdateGebiedVerzorger.verwacht'
END
GO

-- | T 3.31 | UC 1.42, FR 1.7 | Een gebied bij een verzorger wordt geüpdate naar null met correcte parameters Medewerkerid |
CREATE OR ALTER PROCEDURE [test_STP_UpdateGebiedVerzorger].[test Een gebied bij een verzorger wordt geüpdate naar null met correcte parameters Medewerkerid]
AS
BEGIN
	EXEC STP_UpdateGebiedVerzorger
		@MedewerkerID = 2

	INSERT INTO [test_STP_UpdateGebiedVerzorger].[actual](VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	SELECT VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM
	FROM MEDEWERKER

	INSERT INTO [test_STP_UpdateGebiedVerzorger].[verwacht](VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES('Andrei', 'Meyer', 'Verzorger', 'Savanne'),
		  ('Rhiannon', 'Huff', 'Hoofdverzorger', NULL),
		  ('Esmay', 'Swift', 'Dierenarts', NULL)
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_UpdateGebiedVerzorger.actual', 'test_STP_UpdateGebiedVerzorger.verwacht'
END
GO

-- | T 3.32 | UC 1.42, FR 1.7 | Een gebied bij een verzorger wordt niet geüpdate met incorrecte parameters MedewerkerID met functie Dierenarts.|
CREATE OR ALTER PROCEDURE [test_STP_UpdateGebiedVerzorger].[test Een gebied bij een verzorger wordt niet geüpdate met incorrecte parameter MedewerkerID met functie Dierenarts.]
AS
BEGIN
	EXEC [tSQLt].[ExpectException]
	
	EXEC STP_UpdateGebiedVerzorger
		@MedewerkerID 	= 3,
		@Gebiednaam 	= 'Vlindertuin'
END
GO

------------------------------------------ T3.33 - T3.34 ------------------------------------------ Nick
-- Unit Tests UC 1.45
EXEC tSQLt.NewTestClass test_STP_UpdateLeveranciers
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateLeveranciers].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Leverancier'

	INSERT INTO LEVERANCIER (LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES)
	VALUES ('Freeks Freaky Frikandellen', 'Nijmegen', 'Professor Molkenboerstraat 3')
END
GO

-- | T 3.33 | UC 1.45, FR 1.11 | Leveranciers wordt geüpdate met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateLeveranciers].[test Een Leverancier wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateLeveranciers
		@OudLeverancierNaam		= 'Freeks Freaky Frikandellen',
		@LeverancierNaam	= NULL,
		@LeverancierPlaats		= NULL,
		@LeverancierAdres		= NULL,
		@ContactInformatie		= NULL

	EXEC STP_UpdateLeveranciers
		@OudLeverancierNaam		= 'Freeks Freaky Frikandellen',
		@LeverancierNaam	= 'Kees Krokrante Kroketten',
		@LeverancierPlaats		= 'Arnhem',
		@LeverancierAdres		= 'Professor Melkenbeerstraat 3',
		@ContactInformatie		= 'Persoonlijk telefoon nr. : 06-12345678'
END
GO

-- | T 3.34 | UC 1.45, FR 1.11 | Leveranciers wordt niet geüpdate met de incorrecte parameters. |
-- Geen tests

------------------------------------------ T3.35 - T3.36 ------------------------------------------ Nick
-- Unit Tests UC 1.51
EXEC tSQLt.NewTestClass test_STP_UpdateVoedselsoort
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateVoedselsoort].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Voedsel'

	INSERT INTO VOEDSEL (VOEDSELSOORT)
	VALUES ('Stro')
END
GO

-- | T 3.35 | UC 1.51, FR 1.19 | Een voedselsoort wordt geüpdate met correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateVoedselsoort].[test Een Voedselsoort wordt geüpdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	EXEC STP_UpdateVoedselsoort
		@OudVoedselSoort		= 'Stro',
		@NieuwVoedselSoort		= 'Hooi'
END
GO

-- | T 3.36 | UC 1.51, FR 1.19 | Een voedselsoort wordt niet geüpdate met incorrecte parameters. |
-- Geen tests

------------------------------------------ T3.37 - T3.38 ------------------------------------------ Jorian
-- Unit Tests UC 1.41
EXEC tSQLt.NewTestClass test_STP_UpdateFuncties
GO

CREATE OR ALTER PROCEDURE [test_STP_UpdateFuncties].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'Functies'
	EXEC tSQLt.FakeTable 'dbo','MEDEWERKER'

	INSERT INTO FUNCTIES
	VALUES
		('Verzorger'),
		('Hoofdverzorger'),
		('Schoonmaker')
	INSERT INTO MEDEWERKER (MEDEWERKERID,FUNCTIE)
	VALUES
		(1,'Verzorger'),
		(2,'Hoofdverzorger')
END
GO

-- | T 3.37 | UC 1.52, FR 1.20 | Een functie wordt geüpdate met de correcte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateFuncties].[test Een Functie wordt geupdate met correcte parameters]
AS
BEGIN
	EXEC tSQLt.ExpectNoException

	EXEC STP_UpdateFuncties
		@OudeFunctie = 'Schoonmaker',
		@NieuweFunctie = 'KantoorBewerker'
END
GO

-- | T 3.38 | UC 1.52, FR 1.20 | Een functie wordt niet geüpdate met de incorrecte parameters. |
CREATE OR ALTER PROCEDURE [test_STP_UpdateFuncties].[test Een functie wordt niet geupdate met incorrecte parameters]
AS
BEGIN
	DECLARE @actual int;
	DECLARE @expected int;
	SET @expected = 0;

	EXEC STP_UpdateFuncties
		@OudeFunctie = 'Directeur',
		@NieuweFunctie = 'KantoorBewerkert'

    SELECT @actual = COUNT(*) FROM MEDEWERKER WHERE FUNCTIE = 'KantoorBewerkert'
	EXEC tSQLt.AssertEquals @expected, @actual;
END
GO
