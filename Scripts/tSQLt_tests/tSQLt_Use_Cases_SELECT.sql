/* ==================================================
=	ISE-Project groep C-2							=
=	Tests Use Case SELECT T2.1-T2.19  				=
================================================== */ 

-- Testclass: [test_STP_Select'Tabel']
-- Testnamen: [Een 'entiteit' wordt toegevoegd met correcte parameters]
-- Testnamen: [Een 'entiteit' wordt niet toegevoegd met een foute 'NaamParameter']

/*
De Unit Tests volgen de vorm AAA: Assembly, Act, Assert
Eerst worden in de SetUp procedure tabellen gekopieerd en gevuld met testdata.
Vervolgens wordt een verwachte uitkomst gedeclareerd (In de vorm van een tabel).
De te testen handeling/procedure wordt uitgevoerd en de test slaagt als resulterende tabel overeenkomt met de verwachte tabel.
*/

------------------------------------------ T2.1 ------------------------------------------ Levi
-- Unit Tests UC 1.15		
EXEC tSQLt.NewTestClass 'test_STP_SelectUitdraaisel'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectUitdraaisel].[SetUp]
AS
BEGIN
	SELECT TOP 0 D.LATIJNSENAAM, D.NORMALENAAM, D.EDUTEKST, D.FOTO,
	S.GESLACHT, S.VOLWASSENLEEFTIJD, S.VOLWASSENGEWICHT, S.OVERIGEKENMERKEN
	INTO [test_STP_SelectUitdraaisel].[actual]
	FROM DIERSOORT D INNER JOIN SEKSUEELDIMORFISME S
	ON D.LATIJNSENAAM = S.LATIJNSENAAM
	
	SELECT TOP 0 D.LATIJNSENAAM, D.NORMALENAAM, D.EDUTEKST, D.FOTO,
	S.GESLACHT, S.VOLWASSENLEEFTIJD, S.VOLWASSENGEWICHT, S.OVERIGEKENMERKEN
	INTO [test_STP_SelectUitdraaisel].[verwacht]
	FROM DIERSOORT D INNER JOIN SEKSUEELDIMORFISME S
	ON D.LATIJNSENAAM = S.LATIJNSENAAM

    EXEC tSQLt.FakeTable 'dbo', 'DIERSOORT';	
	EXEC tSQLt.FakeTable 'dbo', 'SEKSUEELDIMORFISME';

	INSERT INTO DIERSOORT (LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'),
	('Loxodonta', NULL, NULL, NULL) -- Afrikaanse olifant

	INSERT INTO SEKSUEELDIMORFISME (LATIJNSENAAM, GESLACHT, VOLWASSENLEEFTIJD, VOLWASSENGEWICHT, OVERIGEKENMERKEN) 
	VALUES
	('Panthera leo', 'M', '5 jaar', '150 tot 280 kg', 'kop-romplengte van 172 tot 250 cm'),
	('Panthera leo', 'F', '5 jaar', '100 tot 182 kg', 'kop-romplengte van 140 tot 192 cm'),
	('Loxodonta', 'M',  '10 tot 12 jaar','4,700-6,048 kg', 'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.'),
	('Loxodonta', 'F', '10 tot 12 jaar','2,160-3,232 kg',  'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.')
END	
GO

-- | T 2.1 | UC 1.15, FR 1.8 | Het juiste uitdraaisel wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitdraaisel].[test Het juiste uitdraaisel wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitdraaisel].[actual]
	EXEC STP_SelectUitdraaisel

	INSERT INTO [test_STP_SelectUitdraaisel].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'M', '5 jaar', '150 tot 280 kg', 'kop-romplengte van 172 tot 250 cm'),
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'F', '5 jaar', '100 tot 182 kg', 'kop-romplengte van 140 tot 192 cm'),
	('Loxodonta', NULL, NULL, NULL, 'M', '10 tot 12 jaar', '4,700-6,048 kg', 'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.'),
	('Loxodonta', NULL, NULL, NULL, 'F', '10 tot 12 jaar', '2,160-3,232 kg', 'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitdraaisel.actual', 'test_STP_SelectUitdraaisel.verwacht'
END
GO

-- | T 2.1 | UC 1.15, FR 1.8 | Het juiste uitdraaisel wordt teruggegeven met parameter DiersoortNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitdraaisel].[test Het juiste uitdraaisel wordt teruggegeven met parameter DiersoortNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitdraaisel].[actual]
	EXEC STP_SelectUitdraaisel
		@DiersoortNaam = 'Leeuw'

	INSERT INTO [test_STP_SelectUitdraaisel].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'M', '5 jaar', '150 tot 280 kg', 'kop-romplengte van 172 tot 250 cm'),
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'F', '5 jaar', '100 tot 182 kg', 'kop-romplengte van 140 tot 192 cm')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitdraaisel.actual', 'test_STP_SelectUitdraaisel.verwacht'
END
GO

-- | T 2.1 | UC 1.15, FR 1.8 | Het juiste uitdraaisel wordt teruggegeven met parameter LatijnseNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitdraaisel].[test Het juiste uitdraaisel wordt teruggegeven met parameter LatijnseNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitdraaisel].[actual]
	EXEC STP_SelectUitdraaisel
		@LatijnseNaam = 'Loxodonta'

	INSERT INTO [test_STP_SelectUitdraaisel].[verwacht]
	VALUES
	('Loxodonta', NULL, NULL, NULL, 'M', '10 tot 12 jaar', '4,700-6,048 kg', 'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.'),
	('Loxodonta', NULL, NULL, NULL, 'F', '10 tot 12 jaar', '2,160-3,232 kg', 'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitdraaisel.actual', 'test_STP_SelectUitdraaisel.verwacht'
END
GO

-- | T 2.1 | UC 1.15, FR 1.8 | Het juiste uitdraaisel wordt teruggegeven met parameter EduTekstFragment. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitdraaisel].[test Het juiste uitdraaisel wordt teruggegeven met parameter EduTekstFragment]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitdraaisel].[actual]
	EXEC STP_SelectUitdraaisel
		@EduTekstFragment = 'katachtigen'

	INSERT INTO [test_STP_SelectUitdraaisel].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'M', '5 jaar', '150 tot 280 kg', 'kop-romplengte van 172 tot 250 cm'),
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'F', '5 jaar', '100 tot 182 kg', 'kop-romplengte van 140 tot 192 cm')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitdraaisel.actual', 'test_STP_SelectUitdraaisel.verwacht'
END
GO

-- | T 2.1 | UC 1.15, FR 1.8 | Het juiste uitdraaisel wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitdraaisel].[test Het juiste uitdraaisel wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitdraaisel].[actual]
	EXEC STP_SelectUitdraaisel
		@DiersoortNaam = 'Leeuw',
		@LatijnseNaam = 'Panthera leo',
		@EduTekstFragment = 'katachtigen'

	INSERT INTO [test_STP_SelectUitdraaisel].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'M', '5 jaar', '150 tot 280 kg', 'kop-romplengte van 172 tot 250 cm'),
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg', 'F', '5 jaar', '100 tot 182 kg', 'kop-romplengte van 140 tot 192 cm')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitdraaisel.actual', 'test_STP_SelectUitdraaisel.verwacht'
END
GO

------------------------------------------ T2.2 ------------------------------------------ Nick
-- Unit Tests UC 1.16
EXEC tSQLt.NewTestClass test_STP_SelectDier
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[SetUp]
AS
BEGIN
	SELECT TOP 0 *
	INTO [test_STP_SelectDier].[actual]
	FROM DIER

	SELECT TOP 0 *
	INTO [test_STP_SelectDier].[expected] 
	FROM DIER

	EXEC tSQLt.FakeTable 'dbo', 'Dier';	

	INSERT INTO DIER (DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES
	('PAN-001', 'Savanne', 1, 'Panthera leo', NULL, 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', NULL, 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('PAN-003', 'Savanne', 1, 'Panthera leo', 1, 'Claire', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('LOX-001', NULL, NULL, 'Loxodonta', NULL, 'Allana', 'F', NULL, NULL, '19-JAN-2001', 'Aanwezig'),
	('LOX-002', 'Savanne', 2, 'Loxodonta', NULL, 'Mya', 'M', NULL, NULL, '30-APR-2002', 'Aanwezig'),
	('CEN-001', 'Aquarium', 3, 'Centrophorus harrissoni', NULL, 'George', 'M', NULL, NULL, NULL, 'Aanwezig'),
	('CEN-002', NULL, NULL, 'Centrophorus harrissoni', NULL, 'Hillary', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('CAN-001', NULL, NULL, 'Canis lupus', NULL, 'Snowball', 'M', 'Moscow', NULL, '26-NOV-2005', 'Aanwezig'),
	('CAN-002', NULL, NULL, 'Canis lupus', NULL, 'Jessie', 'F', NULL, 'Zwitserland', NULL, 'Aanwezig'),
	('CAN-003', NULL, NULL, 'Canis lupus', 3, 'Muhammed', 'M', NULL, NULL, '06-OCT-2019', 'Aanwezig'),
	('TOR-001', NULL, NULL, 'Torgos tracheliotos', NULL, 'Zayn', 'M', NULL, NULL, NULL, 'Afwezig'),
	('TOR-002', 'Europa & Amerika', 5, 'Torgos tracheliotos', NULL, 'Sophie', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('ARG-001', 'Vlindertuin', 6, 'Argynnis paphia', NULL, 'Ammar', 'M', NULL, NULL, NULL, 'Aanwezig'),
	('ARG-002', NULL, NULL, 'Argynnis paphia', NULL, 'Henna', 'F', 'Nijmegen', NULL, NULL, 'Aanwezig'),
	('CYP-001', NULL, NULL, 'Cyprinus carpio', NULL, 'Nabil', 'M', 'Zwolle', 'Nederland', NULL, 'Aanwezig'),
	('CYP-002', NULL, NULL, 'Cyprinus carpio', NULL, 'Oakley', 'M', NULL, 'America', '01-JAN-2020', 'Aanwezig'),
	('CYP-003', NULL, NULL, 'Cyprinus carpio', NULL, 'Deon', 'M', NULL, NULL, '11-JUN-2020', 'Overleden'),
	('CYP-004', 'Aquarium', 3, 'Cyprinus carpio', NULL, 'Rianne', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('BRZ_CYP-005', 'Aquarium', 3, 'Cyprinus carpio', NULL, 'Oakley', 'M', 'Deventer', NULL, NULL, 'Aanwezig'),
	('ALL-001', NULL, NULL, 'Alligator mississippiensis', NULL, 'Jamie-Leigh', 'M', NULL, 'America', NULL, 'Aanwezig'),
	('ALL-002', NULL, NULL, 'Alligator mississippiensis', NULL, 'Kali', 'F', 'Tallahassee', NULL,'18-OCT-1986', 'Aanwezig'),
	('ALL-003', NULL, NULL, 'Alligator mississippiensis', NULL, 'Daryl', 'M', NULL, 'America', NULL, 'Afwezig'),
	('ALL-004', 'Aquarium', 7, 'Alligator mississippiensis', NULL, 'Elina', 'F','Tallahassee', NULL, NULL, 'Aanwezig'),
	('ALL-005', 'Aquarium', 7, 'Alligator mississippiensis', NULL, 'Sjaak', 'M', NULL, 'America', NULL, 'Aanwezig'),
	('PHO-001', NULL, NULL, 'Phoenicopteridae', NULL, 'Brandi', 'M', NULL, NULL, '12-DEC-2016', 'Aanwezig'),
	('PHO-002', NULL, NULL, 'Phoenicopteridae', NULL, 'Alesha', 'F', 'Arnhem', NULL, NULL, 'Uitgezet'),
	('PHO-003', 'Europa & Amerika', NULL, 'Phoenicopteridae', NULL, 'Roan', 'M', NULL,'Nigeria', NULL, 'Aanwezig'),
	('PHO-004', 'Europa & Amerika', 8, 'Phoenicopteridae', NULL, 'Wanda', 'F', NULL, NULL, '09-DEC-2017', 'Aanwezig'),
	('PHO-005', NULL, NULL, 'Phoenicopteridae', NULL, 'Azeem', 'M', NULL, NULL, NULL, 'Afwezig'),
	('PHO-006', 'Europa & Amerika', 8, 'Phoenicopteridae', NULL, 'Sofie', 'F', NULL, NULL, '03-NOV-2016', 'Aanwezig'),
	('UIL_PHO-007', 'Europa & Amerika', 8, 'Phoenicopteridae', NULL, 'Soren', 'M', NULL, NULL, NULL, 'Aanwezig'),
	('COL-001', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Gordon', 'M', NULL, NULL, NULL, 'Aanwezig'),
	('COL-002', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Jolie', 'F', 'Hilversum', NULL, NULL, 'Aanwezig'),
	('COL-003', NULL, NULL, 'Colobus guereza', NULL, 'Delia', 'M', 'Arnhem', 'Nederland', NULL, 'Aanwezig'),
	('COL-004', NULL, NULL, 'Colobus guereza', NULL, 'Gia', 'F', 'Tokyo', 'Japan', '14-APR-2013', 'Aanwezig'),
	('COL-005', NULL, NULL, 'Colobus guereza', NULL, 'Cai', 'M', NULL, 'Japan', '14-APR-2013', 'Overleden'),
	('COL-006', 'Europa & Amerika', 9, 'Colobus guereza', NULL,'Stacy', 'F', 'Amsterdam', NULL, NULL, 'Aanwezig'),
	('COL-007', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Glyn', 'M', 'Amsterdam', 'Nederland', NULL, 'Aanwezig'),
	('COL-008', NULL, NULL, 'Colobus guereza', NULL, 'Thea', 'F', 'Brussel', 'België', '08-JUN-2019', 'Aanwezig'),
	('COL-009', NULL, NULL, 'Colobus guereza', NULL, 'Andy', 'M', 'Brussel', 'België', '08-JUN-2019', 'Uitgezet'),
	('COL-010', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Ace', 'F', 'Parijs', 'Frankrijk', NULL, 'Aanwezig'),
	('COL-011', 'Europa & Amerika', 9, 'Colobus guereza', 4, 'Erin', 'M', 'Parijs', 'Frankrijk', '07-SEP-2020', 'Aanwezig'),
	('COL-012', NULL, NULL, 'Colobus guereza', NULL, 'Karina', 'F', 'Parijs', 'Frankrijk', '22-APR-2020', 'Afwezig'),
	('BEZ_COL-001', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Evan', 'M', 'Parijs', 'Frankrijk', '27-NOV-2017', 'Aanwezig')
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	SELECT * FROM DIER

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met DierID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met DierID]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= 'PAN-001',
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES ('PAN-001', 'Savanne', 1, 'Panthera leo', NULL, 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met GebiedNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met GebiedNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= 'Savanne',
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('PAN-001', 'Savanne', 1, 'Panthera leo', NULL, 'Leo', 'M', 'Nijmegen', 'Nederland', '19-APR-2007', 'Aanwezig'),
	('PAN-002', 'Savanne', 1, 'Panthera leo', NULL, 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('PAN-003', 'Savanne', 1, 'Panthera leo', 1, 'Claire', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('LOX-002', 'Savanne', 2, 'Loxodonta', NULL, 'Mya', 'M', NULL, NULL, '30-APR-2002', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met VerblijfID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met VerblijfID]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= 3,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('CEN-001', 'Aquarium', 3, 'Centrophorus harrissoni', NULL, 'George', 'M', NULL, NULL, NULL, 'Aanwezig'),
	('CYP-004', 'Aquarium', 3, 'Cyprinus carpio', NULL, 'Rianne', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('BRZ_CYP-005', 'Aquarium', 3, 'Cyprinus carpio', NULL, 'Oakley', 'M', 'Deventer', NULL, NULL, 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met Diersoort. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met Diersoort]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= 'Colobus guereza',
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('COL-001', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Gordon', 'M', NULL, NULL, NULL, 'Aanwezig'),
	('COL-002', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Jolie', 'F', 'Hilversum', NULL, NULL, 'Aanwezig'),
	('COL-003', NULL, NULL, 'Colobus guereza', NULL, 'Delia', 'M', 'Arnhem', 'Nederland', NULL, 'Aanwezig'),
	('COL-004', NULL, NULL, 'Colobus guereza', NULL, 'Gia', 'F', 'Tokyo', 'Japan', '14-APR-2013', 'Aanwezig'),
	('COL-005', NULL, NULL, 'Colobus guereza', NULL, 'Cai', 'M', NULL, 'Japan', '14-APR-2013', 'Overleden'),
	('COL-006', 'Europa & Amerika', 9, 'Colobus guereza', NULL,'Stacy', 'F', 'Amsterdam', NULL, NULL, 'Aanwezig'),
	('COL-007', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Glyn', 'M', 'Amsterdam', 'Nederland', NULL, 'Aanwezig'),
	('COL-008', NULL, NULL, 'Colobus guereza', NULL, 'Thea', 'F', 'Brussel', 'België', '08-JUN-2019', 'Aanwezig'),
	('COL-009', NULL, NULL, 'Colobus guereza', NULL, 'Andy', 'M', 'Brussel', 'België', '08-JUN-2019', 'Uitgezet'),
	('COL-010', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Ace', 'F', 'Parijs', 'Frankrijk', NULL, 'Aanwezig'),
	('COL-011', 'Europa & Amerika', 9, 'Colobus guereza', 4, 'Erin', 'M', 'Parijs', 'Frankrijk', '07-SEP-2020', 'Aanwezig'),
	('COL-012', NULL, NULL, 'Colobus guereza', NULL, 'Karina', 'F', 'Parijs', 'Frankrijk', '22-APR-2020', 'Afwezig'),
	('BEZ_COL-001', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Evan', 'M', 'Parijs', 'Frankrijk', '27-NOV-2017', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met FokID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met FokID]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= 4,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES ('COL-011', 'Europa & Amerika', 9, 'Colobus guereza', 4, 'Erin', 'M', 'Parijs', 'Frankrijk', '07-SEP-2020', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met DierNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met DierNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= 'Muhammed',
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES ('CAN-003', NULL, NULL, 'Canis lupus', 3, 'Muhammed', 'M', NULL, NULL, '06-OCT-2019', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met Geslacht. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met Geslacht]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= 'F',
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES
	('PAN-002', 'Savanne', 1, 'Panthera leo', NULL, 'Jaiden', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('PAN-003', 'Savanne', 1, 'Panthera leo', 1, 'Claire', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig'),
	('LOX-001', NULL, NULL, 'Loxodonta', NULL, 'Allana', 'F', NULL, NULL, '19-JAN-2001', 'Aanwezig'),
	('CEN-002', NULL, NULL, 'Centrophorus harrissoni', NULL, 'Hillary', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('CAN-002', NULL, NULL, 'Canis lupus', NULL, 'Jessie', 'F', NULL, 'Zwitserland', NULL, 'Aanwezig'),
	('TOR-002', 'Europa & Amerika', 5, 'Torgos tracheliotos', NULL, 'Sophie', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('ARG-002', NULL, NULL, 'Argynnis paphia', NULL, 'Henna', 'F', 'Nijmegen', NULL, NULL, 'Aanwezig'),
	('CYP-004', 'Aquarium', 3, 'Cyprinus carpio', NULL, 'Rianne', 'F', NULL, NULL, NULL, 'Aanwezig'),
	('ALL-002', NULL, NULL, 'Alligator mississippiensis', NULL, 'Kali', 'F', 'Tallahassee', NULL,'18-OCT-1986', 'Aanwezig'),
	('ALL-004', 'Aquarium', 7, 'Alligator mississippiensis', NULL, 'Elina', 'F','Tallahassee', NULL, NULL, 'Aanwezig'),
	('PHO-002', NULL, NULL, 'Phoenicopteridae', NULL, 'Alesha', 'F', 'Arnhem', NULL, NULL, 'Uitgezet'),
	('PHO-004', 'Europa & Amerika', 8, 'Phoenicopteridae', NULL, 'Wanda', 'F', NULL, NULL, '09-DEC-2017', 'Aanwezig'),
	('PHO-006', 'Europa & Amerika', 8, 'Phoenicopteridae', NULL, 'Sofie', 'F', NULL, NULL, '03-NOV-2016', 'Aanwezig'),
	('COL-002', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Jolie', 'F', 'Hilversum', NULL, NULL, 'Aanwezig'),
	('COL-004', NULL, NULL, 'Colobus guereza', NULL, 'Gia', 'F', 'Tokyo', 'Japan', '14-APR-2013', 'Aanwezig'),
	('COL-006', 'Europa & Amerika', 9, 'Colobus guereza', NULL,'Stacy', 'F', 'Amsterdam', NULL, NULL, 'Aanwezig'),
	('COL-008', NULL, NULL, 'Colobus guereza', NULL, 'Thea', 'F', 'Brussel', 'België', '08-JUN-2019', 'Aanwezig'),
	('COL-010', 'Europa & Amerika', 9, 'Colobus guereza', NULL, 'Ace', 'F', 'Parijs', 'Frankrijk', NULL, 'Aanwezig'),
	('COL-012', NULL, NULL, 'Colobus guereza', NULL, 'Karina', 'F', 'Parijs', 'Frankrijk', '22-APR-2020', 'Afwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met Geboorteplaats. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met Geboorteplaats]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= 'Brussel',
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES
	('COL-008', NULL, NULL, 'Colobus guereza', NULL, 'Thea', 'F', 'Brussel', 'België', '08-JUN-2019', 'Aanwezig'),
	('COL-009', NULL, NULL, 'Colobus guereza', NULL, 'Andy', 'M', 'Brussel', 'België', '08-JUN-2019', 'Uitgezet')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met GeboorteLand. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met GeboorteLand]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= 'America',
		@GeboorteDatum	= NULL,
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('CYP-002', NULL, NULL, 'Cyprinus carpio', NULL, 'Oakley', 'M', NULL, 'America', '01-JAN-2020', 'Aanwezig'),
	('ALL-001', NULL, NULL, 'Alligator mississippiensis', NULL, 'Jamie-Leigh', 'M', NULL, 'America', NULL, 'Aanwezig'),
	('ALL-003', NULL, NULL, 'Alligator mississippiensis', NULL, 'Daryl', 'M', NULL, 'America', NULL, 'Afwezig'),
	('ALL-005', 'Aquarium', 7, 'Alligator mississippiensis', NULL, 'Sjaak', 'M', NULL, 'America', NULL, 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met GeboorteDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met GeboorteDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= '18-OCT-1986',
		@Status			= NULL

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES ('ALL-002', NULL, NULL, 'Alligator mississippiensis', NULL, 'Kali', 'F', 'Tallahassee', NULL,'18-OCT-1986', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met Status. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met Status]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= NULL,
		@GebiedNaam		= NULL,
		@VerblijfID		= NULL,
		@Diersoort		= NULL,
		@FokID			= NULL,
		@DierNaam		= NULL,
		@Geslacht		= NULL,
		@Geboorteplaats	= NULL,
		@GeboorteLand	= NULL,
		@GeboorteDatum	= NULL,
		@Status			= 'Overleden'

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES 
	('CYP-003', NULL, NULL, 'Cyprinus carpio', NULL, 'Deon', 'M', NULL, NULL, '11-JUN-2020', 'Overleden'),
	('COL-005', NULL, NULL, 'Colobus guereza', NULL, 'Cai', 'M', NULL, 'Japan', '14-APR-2013', 'Overleden')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

-- | T 2.2 | UC 1.16, FR 1.3 | De juiste dieren data wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDier].[test De juiste dieren data wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectDier].[actual](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	EXEC STP_SelectDier
		@DierID			= 'PAN-003',
		@GebiedNaam		= 'Savanne',
		@VerblijfID		= 1,
		@Diersoort		= 'Panthera leo',
		@FokID			= 1,
		@DierNaam		= 'Claire',
		@Geslacht		= 'F',
		@Geboorteplaats	= 'Berlijn',
		@GeboorteLand	= 'Duitsland',
		@GeboorteDatum	= '07-SEP-2009',
		@Status			= 'Aanwezig'

	INSERT INTO [test_STP_SelectDier].[expected](DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS)
	VALUES ('PAN-003', 'Savanne', 1, 'Panthera leo', 1, 'Claire', 'F', 'Berlijn', 'Duitsland', '07-SEP-2009', 'Aanwezig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDier.actual', 'test_STP_SelectDier.expected'
END
GO

------------------------------------------ T2.3 ------------------------------------------ Vince
-- Unit Tests UC 1.17
EXEC tSQLt.NewTestClass 'test_STP_SelectGebied'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectGebied].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_SelectGebied].[actual]
	FROM GEBIED

	SELECT top 0 *
	INTO [test_STP_SelectGebied].[verwacht]
	FROM GEBIED

    EXEC tSQLt.FakeTable 'dbo', 'GEBIED';	
	
	INSERT INTO GEBIED(GEBIEDNAAM, HOOFDVERZORGER)
	VALUES
	('Savanne', 2),
	('Vlindertuin', 3),
	('Aquarium', 4),
	('Europa & Amerika', 5)
END	
GO

-- | T 2.3 | UC 1.17, FR 1.1 | De juiste gebieds data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectGebied].[test De juiste gebieds data wordt teruggegeven zonder parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectGebied].[actual](GEBIEDNAAM, HOOFDVERZORGER)
	EXEC STP_SelectGebied

	INSERT INTO [test_STP_SelectGebied].[verwacht](GEBIEDNAAM, HOOFDVERZORGER)
	VALUES
	('Savanne', 2),
	('Vlindertuin', 3),
	('Aquarium', 4),
	('Europa & Amerika', 5)	

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectGebied.actual', 'test_STP_SelectGebied.verwacht'
END
GO

-- | T 2.3 | UC 1.17, FR 1.1 | De juiste gebieds data wordt teruggegeven met parameter GebiedNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectGebied].[test De juiste gebieds data wordt teruggegeven met parameter GebiedNaam]
AS
BEGIN	
	INSERT INTO [test_STP_SelectGebied].[actual](GEBIEDNAAM, HOOFDVERZORGER)
	EXEC STP_SelectGebied 
	@GebiedNaam = 'Savanne'

	INSERT INTO [test_STP_SelectGebied].[verwacht](GEBIEDNAAM, HOOFDVERZORGER)
	VALUES('Savanne', 2)
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectGebied.actual', 'test_STP_SelectGebied.verwacht'
END
GO

-- | T 2.3 | UC 1.17, FR 1.1 | De juiste gebieds data wordt teruggegeven met parameter Hoofdverzorger. |
CREATE OR ALTER PROCEDURE [test_STP_SelectGebied].[test De juiste gebieds data wordt teruggegeven met parameter Hoofdverzorger]
AS
BEGIN
	INSERT INTO [test_STP_SelectGebied].[actual](GEBIEDNAAM, HOOFDVERZORGER)
	EXEC STP_SelectGebied 
	@HoofdVerzorger = 5

	INSERT INTO [test_STP_SelectGebied].[verwacht](GEBIEDNAAM, HOOFDVERZORGER)
	VALUES('Europa & Amerika', 5)	

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectGebied.actual', 'test_STP_SelectGebied.verwacht'
END
GO

-- | T 2.3 | UC 1.17, FR 1.1 | De juiste gebieds data wordt teruggegeven met parameters Hoofdverzorger & Gebiednaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectGebied].[test De juiste gebieds data wordt teruggegeven met parameters Hoofdverzorger & Gebiednaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectGebied].[actual](GEBIEDNAAM, HOOFDVERZORGER)
	EXEC STP_SelectGebied 
	@HoofdVerzorger = 4,
	@GebiedNaam = 'Aquarium'

	INSERT INTO [test_STP_SelectGebied].[verwacht](GEBIEDNAAM, HOOFDVERZORGER)
	VALUES('Aquarium', 4)
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectGebied.actual', 'test_STP_SelectGebied.verwacht'
END
GO

------------------------------------------ T2.4 ------------------------------------------ Nick
-- Unit Tests UC 1.18
EXEC tSQLt.NewTestClass test_STP_SelectVerblijf
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectVerblijf].[SetUp]
AS
BEGIN
	SELECT TOP 0 *
	INTO [test_STP_SelectVerblijf].[actual]
	FROM VERBLIJF

	SELECT TOP 0 *
	INTO [test_STP_SelectVerblijf].[expected]
	FROM VERBLIJF

	EXEC tSQLt.FakeTable 'dbo', 'Verblijf'

	INSERT INTO VERBLIJF (VERBLIJFID, GEBIEDNAAM)
	VALUES
	(0, 'Savanne'),		
	(1, 'Savanne'),		
	(2, 'Aquarium'),		
	(3, 'Europa & Amerika'),
	(4, 'Europa & Amerika'),
	(5, 'Vlindertuin'),	
	(6, 'Aquarium'),		
	(7, 'Europa & Amerika'),
	(8, 'Europa & Amerika')
END
GO

-- | T 2.4 | UC 1.18, FR 1.2 | De juiste verblijfs data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectVerblijf].[test De juiste verblijfs data wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectVerblijf].[actual] (GEBIEDNAAM, VERBLIJFID)
	EXEC STP_SelectVerblijf
		@GebiedNaam				= NULL,
		@VerblijfID				= NULL
	
	SET IDENTITY_INSERT [test_STP_SelectVerblijf].[expected] ON
	INSERT INTO [test_STP_SelectVerblijf].[expected] (GEBIEDNAAM, VERBLIJFID)
	SELECT * FROM VERBLIJF

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectVerblijf.actual', 'test_STP_SelectVerblijf.expected'
END
GO

-- | T 2.4 | UC 1.18, FR 1.2 | De juiste verblijfs data wordt teruggegeven met GebiedNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectVerblijf].[test De juiste verblijfs data wordt teruggegeven met GebiedNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectVerblijf].[actual] (GEBIEDNAAM, VERBLIJFID)
	EXEC STP_SelectVerblijf
		@GebiedNaam				= 'Savanne',
		@VerblijfID				= NULL
	
	SET IDENTITY_INSERT [test_STP_SelectVerblijf].[expected] ON
	INSERT INTO [test_STP_SelectVerblijf].[expected] (VERBLIJFID, GEBIEDNAAM)
	VALUES
	(0, 'Savanne'),		
	(1, 'Savanne')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectVerblijf.actual', 'test_STP_SelectVerblijf.expected'
END
GO

-- | T 2.4 | UC 1.18, FR 1.2 | De juiste verblijfs data wordt teruggegeven met VerblijfID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectVerblijf].[test De juiste verblijfs data wordt teruggegeven met VerblijfID]
AS
BEGIN
	INSERT INTO [test_STP_SelectVerblijf].[actual] (GEBIEDNAAM, VERBLIJFID)
	EXEC STP_SelectVerblijf
		@GebiedNaam				= NULL,
		@VerblijfID				= 5
	
	SET IDENTITY_INSERT [test_STP_SelectVerblijf].[expected] ON
	INSERT INTO [test_STP_SelectVerblijf].[expected] (VERBLIJFID, GEBIEDNAAM)
	VALUES (5, 'Vlindertuin')	

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectVerblijf.actual', 'test_STP_SelectVerblijf.expected'
END
GO

-- | T 2.4 | UC 1.18, FR 1.2 | De juiste verblijfs data wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectVerblijf].[test De juiste verblijfs data wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectVerblijf].[actual] (GEBIEDNAAM, VERBLIJFID)
	EXEC STP_SelectVerblijf
		@GebiedNaam				= 'Europa & Amerika',
		@VerblijfID				= 3
	
	SET IDENTITY_INSERT [test_STP_SelectVerblijf].[expected] ON
	INSERT INTO [test_STP_SelectVerblijf].[expected] (VERBLIJFID, GEBIEDNAAM)
	VALUES (3, 'Europa & Amerika')	

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectVerblijf.actual', 'test_STP_SelectVerblijf.expected'
END
GO

------------------------------------------ T2.5 ------------------------------------------ Levi
-- Unit Tests UC 1.19
EXEC tSQLt.NewTestClass 'test_STP_SelectDiersoort'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectDiersoort].[SetUp]
AS
BEGIN
	SELECT TOP 0 LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO
	INTO [test_STP_SelectDiersoort].[actual]
	FROM DIERSOORT
	
	SELECT TOP 0 LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO
	INTO [test_STP_SelectDiersoort].[verwacht]
	FROM DIERSOORT

    EXEC tSQLt.FakeTable 'dbo', 'DIERSOORT';	

	INSERT INTO DIERSOORT (LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'),
	('Argynnis paphia', 'keizersmantel', 'De keizersmantel (Argynnis paphia) is een vlinder uit de familie Nymphalidae, de vossen, parelmoervlinders en weerschijnvlinders.', NULL)
END	
GO

-- | T 2.5 | UC 1.19, FR 1.5 | De juiste diersoort data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDiersoort].[test De juiste diersoort data wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectDiersoort].[actual]
	EXEC STP_SelectDiersoort

	INSERT INTO [test_STP_SelectDiersoort].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg'),
	('Argynnis paphia', 'keizersmantel', 'De keizersmantel (Argynnis paphia) is een vlinder uit de familie Nymphalidae, de vossen, parelmoervlinders en weerschijnvlinders.', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDiersoort.actual', 'test_STP_SelectDiersoort.verwacht'
END
GO

-- | T 2.5 | UC 1.19, FR 1.5 | De juiste diersoort data wordt teruggegeven met parameter DiersoortNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDiersoort].[test De juiste diersoort data wordt teruggegeven met parameter DiersoortNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectDiersoort].[actual]
	EXEC STP_SelectDiersoort
		@DiersoortNaam = 'keizersmantel'

	INSERT INTO [test_STP_SelectDiersoort].[verwacht]
	VALUES
	('Argynnis paphia', 'keizersmantel', 'De keizersmantel (Argynnis paphia) is een vlinder uit de familie Nymphalidae, de vossen, parelmoervlinders en weerschijnvlinders.', NULL)
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDiersoort.actual', 'test_STP_SelectDiersoort.verwacht'
END
GO

-- | T 2.5 | UC 1.19, FR 1.5 | De juiste diersoort data wordt teruggegeven met parameter LatijnseNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDiersoort].[test De juiste diersoort data wordt teruggegeven met parameter LatijnseNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectDiersoort].[actual]
	EXEC STP_SelectDiersoort
		@LatijnseNaam = 'Panthera Leo'

	INSERT INTO [test_STP_SelectDiersoort].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDiersoort.actual', 'test_STP_SelectDiersoort.verwacht'
END
GO

-- | T 2.5 | UC 1.19, FR 1.5 | De juiste diersoort data wordt teruggegeven met parameter EduTekstFragment. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDiersoort].[test De juiste diersoort data wordt teruggegeven met parameter EduTekstFragment]
AS
BEGIN
	INSERT INTO [test_STP_SelectDiersoort].[actual]
	EXEC STP_SelectDiersoort
		@EduTekstFragment = 'een vlinder'

	INSERT INTO [test_STP_SelectDiersoort].[verwacht]
	VALUES
	('Argynnis paphia', 'keizersmantel', 'De keizersmantel (Argynnis paphia) is een vlinder uit de familie Nymphalidae, de vossen, parelmoervlinders en weerschijnvlinders.', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDiersoort.actual', 'test_STP_SelectDiersoort.verwacht'
END
GO

-- | T 2.5 | UC 1.19, FR 1.5 | De juiste diersoort data wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDiersoort].[test De juiste diersoort data wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectDiersoort].[actual]
	EXEC STP_SelectDiersoort
		@DiersoortNaam = 'Leeuw',
		@LatijnseNaam = 'Panthera Leo',
		@EduTekstFragment = 'katachtigen'

	INSERT INTO [test_STP_SelectDiersoort].[verwacht]
	VALUES
	('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter.', '1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDiersoort.actual', 'test_STP_SelectDiersoort.verwacht'
END
GO

------------------------------------------ T2.6 ------------------------------------------ Vince
--Unit Testing 1.20
EXEC tSQLt.NewTestClass 'test_STP_SelectFokDossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[SetUp]
AS
BEGIN

	CREATE TABLE [test_STP_SelectFokDossier].[actual](
		FOKID int,
		FOKDIER DIERID,
		FOKPARTNER DIERID,
		FOKDATUM DATUM,
		FOKPLAATS PLAATS
	)


	CREATE TABLE [test_STP_SelectFokDossier].[verwacht](
		FOKID int,
		FOKDIER DIERID,
		FOKPARTNER DIERID,
		FOKDATUM DATUM,
		FOKPLAATS PLAATS
	)

    EXEC tSQLt.FakeTable 'dbo', 'FOKDOSSIER'
	
	INSERT INTO FOKDOSSIER (FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(1, 'PAN-002', 'PAN-001', '19-APR-2017', 'Nijmegen'),
		(2, 'LOX-002', NULL, NULL, NULL),
		(3, 'CEN-002', 'CEN-001', NULL, NULL),
		(4, 'CAN-002', NULL, '25-MAR-2018', NULL),
		(5, 'COL-002', NULL, NULL, 'Hilversum'),
		(6, 'ALL-002', 'ALL-001', '21-SEP-2020', 'Tallahassee'),
		(7, 'PHO-006', 'PHO-001', '01-AUG-2019', 'Hilversum')

END	
GO


-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven zonder parameters]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(1, 'PAN-002', 'PAN-001', '19-APR-2017', 'Nijmegen'),
		(2, 'LOX-002', NULL, NULL, NULL),
		(3, 'CEN-002', 'CEN-001', NULL, NULL),
		(4, 'CAN-002', NULL, '25-MAR-2018', NULL),
		(5, 'COL-002', NULL, NULL, 'Hilversum'),
		(6, 'ALL-002', 'ALL-001', '21-SEP-2020', 'Tallahassee'),
		(7, 'PHO-006', 'PHO-001', '01-AUG-2019', 'Hilversum')
			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven met parameter FokId]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier
		@FokID = 1

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(1, 'PAN-002', 'PAN-001', '19-APR-2017', 'Nijmegen')

			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven met parameter FokDier]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier
	@FokDier = 'ALL-002'

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(6, 'ALL-002', 'ALL-001', '21-SEP-2020', 'Tallahassee')

			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven met parameter FokPartner]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier
	@FokPartner = 'CEN-001'

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(3, 'CEN-002', 'CEN-001', NULL, NULL)

			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven met parameter FokDatum]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier
	@FokDatum = '01-AUG-2019'

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(7, 'PHO-006', 'PHO-001', '01-AUG-2019', 'Hilversum')
			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven met parameter FokPlaats]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier
	@FokPlaats = 'Hilversum'

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(5, 'COL-002', NULL, NULL, 'Hilversum'),
		(7, 'PHO-006', 'PHO-001', '01-AUG-2019', 'Hilversum')
			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

-- | T 2.6 | UC 1.20, FR 1.16 | De juiste data van het fokdossier wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectFokDossier].[test De juiste data van het fokdossier wordt teruggegeven met alle parameters]
AS
BEGIN	

	INSERT INTO [test_STP_SelectFokDossier].[actual](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	EXEC STP_SelectFokDossier
	@FokID = 6,
	@FokDier = 'ALL-002',
	@FokPartner = 'ALL-001',
	@FokDatum = '21-SEP-2020',
	@FokPlaats = 'Tallahassee'

	INSERT INTO [test_STP_SelectFokDossier].[verwacht](FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
	VALUES
		(6, 'ALL-002', 'ALL-001', '21-SEP-2020', 'Tallahassee')
			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectFokDossier.actual', 'test_STP_SelectFokDossier.verwacht'

END
GO

------------------------------------------ T2.7 ------------------------------------------ Vince
--Unit testing UC 1.21
EXEC tSQLt.NewTestClass 'test_STP_SelectUitleenDossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_SelectUitleenDossier].[actual]
	FROM UITLEENDOSSIER

	SELECT top 0 *
	INTO [test_STP_SelectUitleenDossier].[verwacht]
	FROM UITLEENDOSSIER

    EXEC tSQLt.FakeTable 'dbo', 'UITLEENDOSSIER';	
	
	INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('ALL-003', '10-JAN-2020', 'Somerleyton Animal Park', 'Nordhorn Zoo', '10-JAN-2021', 'ALL-003 kwam terug met een wond op zijn rug.'),
	('EXT-COL-001', '17-JUN-2021', 'Beijing Zoo', 'Somerleyton Animal Park', NULL, NULL),
	('PAN-001', '20-NOV-2020', 'Somerleyton Animal Park', 'San Diego Zoo Safari Park', '20-NOV-2021', NULL),
	('EXT-PHO-007', '20-NOV-2021', 'Uilenbos', 'Somerleyton Animal Park', NULL, 'Wordt erg paniekerig wanneer opgesloten in een kleine kooi.'),
	('EXT-CYP-005', '04-SEP-2018', 'Brookfield Zoo', 'Somerleyton Animal Park', '04-SEP-2020', 'Covid uitbraak vertraagde het verplaatsingsproces.')
END	
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven zonder parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('ALL-003', '10-JAN-2020', 'Somerleyton Animal Park', 'Nordhorn Zoo', '10-JAN-2021', 'ALL-003 kwam terug met een wond op zijn rug.'),
	('EXT-COL-001', '17-JUN-2021', 'Beijing Zoo', 'Somerleyton Animal Park', NULL, NULL),
	('PAN-001', '20-NOV-2020', 'Somerleyton Animal Park', 'San Diego Zoo Safari Park', '20-NOV-2021', NULL),
	('EXT-PHO-007', '20-NOV-2021', 'uilenbos', 'Somerleyton Animal Park', NULL, 'Wordt erg paniekerig wanneer opgesloten in een kleine kooi.'),
	('EXT-CYP-005', '04-SEP-2018', 'Brookfield Zoo', 'Somerleyton Animal Park', '04-SEP-2020', 'Covid uitbraak vertraagde het verplaatsingsproces.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven met parameter DierID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven met parameter DierID]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier
		@DierId = 'ALL-003'

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('ALL-003', '10-JAN-2020', 'Somerleyton Animal Park', 'Nordhorn Zoo', '10-JAN-2021', 'ALL-003 kwam terug met een wond op zijn rug.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven met parameter UitleenDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven met parameter UitleenDatum]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier
		@UitleenDatum = '17-JUN-2021'

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('EXT-COL-001', '17-JUN-2021', 'Beijing Zoo', 'Somerleyton Animal Park', NULL, NULL)			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven met parameter UitlenendeDierentuin. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven met parameter UitlenendeDierentuin]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier
		@UitlenendeDierentuin = 'Somerleyton Animal Park'

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('ALL-003', '10-JAN-2020', 'Somerleyton Animal Park', 'Nordhorn Zoo', '10-JAN-2021', 'ALL-003 kwam terug met een wond op zijn rug.'),
	('PAN-001', '20-NOV-2020', 'Somerleyton Animal Park', 'San Diego Zoo Safari Park', '20-NOV-2021', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven met parameters OntvangendeDierentuin. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven met parameters OntvangendeDierentuin]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier
		@OntvangendeDierentuin = 'Somerleyton Animal Park'

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('EXT-COL-001', '17-JUN-2021', 'Beijing Zoo', 'Somerleyton Animal Park', NULL, NULL),
	('EXT-PHO-007', '20-NOV-2021', 'uilenbos', 'Somerleyton Animal Park', NULL, 'Wordt erg paniekerig wanneer opgesloten in een kleine kooi.'),
	('EXT-CYP-005', '04-SEP-2018', 'Brookfield Zoo', 'Somerleyton Animal Park', '04-SEP-2020', 'Covid uitbraak vertraagde het verplaatsingsproces.')
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven met parameter TerugkeerDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven met parameter TerugkeerDatum]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier
		@TerugkeerDatum = '04-SEP-2020'

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('EXT-CYP-005', '04-SEP-2018', 'Brookfield Zoo', 'Somerleyton Animal Park', '04-SEP-2020', 'Covid uitbraak vertraagde het verplaatsingsproces.')	

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

-- | T 2.7 | UC 1.21, FR 1.5 | De juiste uitleen data wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitleenDossier].[test De juiste uitleen data wordt teruggegeven met alle parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectUitleenDossier].[actual](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	EXEC STP_SelectUitleenDossier
		@DierId = 'EXT-CYP-005',
		@UitleenDatum = '04-SEP-2018',
		@UitlenendeDierentuin = 'Brookfield Zoo',
		@OntvangendeDierentuin = 'Somerleyton Animal Park',
		@TerugkeerDatum = '04-SEP-2020',
		@UitleenOpmerking = 'Covid uitbraak vertraagde het verplaatsingsproces.'

	INSERT INTO [test_STP_SelectUitleenDossier].[verwacht](DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
	VALUES
	('EXT-CYP-005', '04-SEP-2018', 'Brookfield Zoo', 'Somerleyton Animal Park', '04-SEP-2020', 'Covid uitbraak vertraagde het verplaatsingsproces.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitleenDossier.actual', 'test_STP_SelectUitleenDossier.verwacht'
END
GO

------------------------------------------ T2.8 ------------------------------------------ Nick
-- Unit Tests UC 1.22
EXEC tSQLt.NewTestClass test_STP_SelectUitzetDossier
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[SetUp]
AS
BEGIN
	SELECT TOP 0 *
	INTO [test_STP_SelectUitzetDossier].[actual]
	FROM UITZETDOSSIER

	SELECT TOP 0 *
	INTO [test_STP_SelectUitzetDossier].[expected]
	FROM UITZETDOSSIER

	EXEC tSQLt.FakeTable 'dbo', 'UITZETDOSSIER';	

	INSERT INTO UITZETDOSSIER (DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES
	('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.'),
	('COL-009', '30-APR-2020', 'Brazil', 'BP342', NULL),
	('COL-005', '12-JAN-1919', 'Nationaal natuurpark van Japan', 'HSH727', NULL),
	('CYP-004', '03-SEP-2012', 'Nederland, de Rijn', NULL, 'In diep water uitgezet.')
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= NULL,
		@UitzetDatum			= NULL,
		@UitzetLocatie			= NULL,
		@UitzetProgramma		= NULL,
		@UitzetOpmerking		= NULL

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	SELECT * FROM UITZETDOSSIER

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven met DierID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven met DierID]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= 'PHO-002',
		@UitzetDatum			= NULL,
		@UitzetLocatie			= NULL,
		@UitzetProgramma		= NULL,
		@UitzetOpmerking		= NULL

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES ('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven met UitzetDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven met UitzetDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= NULL,
		@UitzetDatum			= '23-DEC-2019',
		@UitzetLocatie			= NULL,
		@UitzetProgramma		= NULL,
		@UitzetOpmerking		= NULL

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES ('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven met UitzetLocatie. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven met UitzetLocatie]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= NULL,
		@UitzetDatum			= NULL,
		@UitzetLocatie			= 'Spanje',
		@UitzetProgramma		= NULL,
		@UitzetOpmerking		= NULL

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES ('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven met UitzetProgramma. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven met UitzetProgramma]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= NULL,
		@UitzetDatum			= NULL,
		@UitzetLocatie			= NULL,
		@UitzetProgramma		= 'SHS',
		@UitzetOpmerking		= NULL

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES ('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven met UitzetOpmerking. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven met UitzetOpmerking]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= NULL,
		@UitzetDatum			= NULL,
		@UitzetLocatie			= NULL,
		@UitzetProgramma		= NULL,
		@UitzetOpmerking		= 'nog lang in de buurt'

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES ('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

-- | T 2.8 | UC 1.22, FR 1.6 | De juiste data van het uitzet dossier wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectUitzetDossier].[test De juiste data van het uitzet dossier wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectUitzetDossier].[actual](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	EXEC STP_SelectUitzetDossier
		@DierID					= 'PHO-002',
		@UitzetDatum			= '23-DEC-2019',
		@UitzetLocatie			= 'Spanje',
		@UitzetProgramma		= 'SHS',
		@UitzetOpmerking		= 'nog lang in de buurt'

	INSERT INTO [test_STP_SelectUitzetDossier].[expected](DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
	VALUES ('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectUitzetDossier.actual', 'test_STP_SelectUitzetDossier.expected'
END
GO

------------------------------------------ T2.9 ------------------------------------------ Levi
-- Unit Tests UC 1.25
EXEC tSQLt.NewTestClass 'test_STP_SelectSpotting'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[SetUp]
AS
BEGIN
	SELECT TOP 0 DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE
	INTO [test_STP_SelectSpotting].[actual]
	FROM GESPOT
	
	SELECT TOP 0 DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE
	INTO [test_STP_SelectSpotting].[verwacht]
	FROM GESPOT

    EXEC tSQLt.FakeTable 'dbo', 'GESPOT';	

	INSERT INTO GESPOT (DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE)
	VALUES
	('PHO-002', '23-DEC-2019', '14-OCT-2021', 'Portugal, Oost van Lisbon'),
	('COL-009', '30-APR-2020', '27-FEB-2021', 'Brazil, Bondinho Pão de Açúcar'),
	('CYP-004', '03-SEP-2012', '10-FEB-2013', 'Nederland, de Lek')
END	
GO

-- | T 2.9 | UC 1.25, FR 1.18 | De juiste spottingsdata wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[test De juiste spottingsdata wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectSpotting].[actual]
	EXEC STP_SelectSpotting

	INSERT INTO [test_STP_SelectSpotting].[verwacht]
	VALUES
	('PHO-002', '23-DEC-2019', '14-OCT-2021', 'Portugal, Oost van Lisbon'),
	('COL-009', '30-APR-2020', '27-FEB-2021', 'Brazil, Bondinho Pão de Açúcar'),
	('CYP-004', '03-SEP-2012', '10-FEB-2013', 'Nederland, de Lek')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectSpotting.actual', 'test_STP_SelectSpotting.verwacht'
END
GO

-- | T 2.9 | UC 1.25, FR 1.18 | De juiste spottingsdata wordt teruggegeven met parameter DierID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[test De juiste spottingsdata wordt teruggegeven met parameter DierID]
AS
BEGIN
	INSERT INTO [test_STP_SelectSpotting].[actual]
	EXEC STP_SelectSpotting
		@DierID = 'PHO-002'

	INSERT INTO [test_STP_SelectSpotting].[verwacht]
	VALUES
	('PHO-002', '23-DEC-2019', '14-OCT-2021', 'Portugal, Oost van Lisbon')
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectSpotting.actual', 'test_STP_SelectSpotting.verwacht'
END
GO

-- | T 2.9 | UC 1.25, FR 1.18 | De juiste spottingsdata wordt teruggegeven met parameter UitzetDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[test De juiste spottingsdata wordt teruggegeven met parameter UitzetDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectSpotting].[actual]
	EXEC STP_SelectSpotting
		@UitzetDatum = '30-APR-2020'

	INSERT INTO [test_STP_SelectSpotting].[verwacht]
	VALUES
	('COL-009', '30-APR-2020', '27-FEB-2021', 'Brazil, Bondinho Pão de Açúcar')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectSpotting.actual', 'test_STP_SelectSpotting.verwacht'
END
GO
-- | T 2.9 | UC 1.25, FR 1.18 | De juiste spottingsdata wordt teruggegeven met parameter SpotDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[test De juiste spottingsdata wordt teruggegeven met parameter SpotDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectSpotting].[actual]
	EXEC STP_SelectSpotting
		@SpotDatum = '10-FEB-2013'

	INSERT INTO [test_STP_SelectSpotting].[verwacht]
	VALUES
	('CYP-004', '03-SEP-2012', '10-FEB-2013', 'Nederland, de Lek')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectSpotting.actual', 'test_STP_SelectSpotting.verwacht'
END
GO

-- | T 2.9 | UC 1.25, FR 1.18 | De juiste spottingsdata wordt teruggegeven met parameter Spotlocatie. |
CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[test De juiste spottingsdata wordt teruggegeven met parameter Spotlocatie]
AS
BEGIN
	INSERT INTO [test_STP_SelectSpotting].[actual]
	EXEC STP_SelectSpotting
		@SpotLocatie = 'Lisbon'

	INSERT INTO [test_STP_SelectSpotting].[verwacht]
	VALUES
	('PHO-002', '23-DEC-2019', '14-OCT-2021', 'Portugal, Oost van Lisbon')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectSpotting.actual', 'test_STP_SelectSpotting.verwacht'
END
GO

-- | T 2.9 | UC 1.25, FR 1.18 | De juiste spottingsdata wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectSpotting].[test De juiste spottingsdata wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectSpotting].[actual]
	EXEC STP_SelectSpotting
		@DierID 		= 'CYP',
		@UitzetDatum 	= '03-SEP-2012',
		@SpotDatum		= '10-FEB-2013',
		@SpotLocatie 	= 'land'

	INSERT INTO [test_STP_SelectSpotting].[verwacht]
	VALUES
	('CYP-004', '03-SEP-2012', '10-FEB-2013', 'Nederland, de Lek')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectSpotting.actual', 'test_STP_SelectSpotting.verwacht'
END
GO

------------------------------------------ T2.10 ----------------------------------------- Vince
--Unit testing UC 1.28
EXEC tSQLt.NewTestClass 'test_STP_SelectMedischDossier'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[SetUp]
AS
BEGIN
	CREATE TABLE [test_STP_SelectMedischDossier].[actual](
		DIERID DIERID,
		CONTROLEDATUM DATUM,
		MEDEWERKERID ID,
		VOLGENDECONTROLE DATUM,
		DIAGNOSE DIAGNOSE,
		VOORSCHRIFT VOORSCHRIFT,
		OBSERVATIEID ID,
	)

	CREATE TABLE [test_STP_SelectMedischDossier].[verwacht](
		DIERID DIERID,
		CONTROLEDATUM DATUM,
		MEDEWERKERID ID,
		VOLGENDECONTROLE DATUM,
		DIAGNOSE DIAGNOSE,
		VOORSCHRIFT VOORSCHRIFT,
		OBSERVATIEID ID,
	)

    EXEC tSQLt.FakeTable 'dbo', 'MEDISCHDOSSIER'
	EXEC tSQLt.FakeTable 'dbo', 'DIAGNOSES'
	
	INSERT INTO MEDISCHDOSSIER (DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
	VALUES
	('PAN-001', '13-SEP-2020', 11, '13-OCT-2020'),
	('LOX-001', '24-MAY-2016', 12, NULL),
	('TOR-002', '28-OCT-2019', 13, NULL),
	('PHO-002', '02-JUN-2019', 14, '16-JUN-2019'),
	('PHO-006', '06-AUG-2017', 14, NULL),
	('COL-007', '14-NOV-2021', 11, '14-NOV-2022'),
	('TOR-001', '19-JAN-2018', 12, NULL)

	INSERT INTO DIAGNOSES (OBSERVATIEID, DIERID, CONTROLEDATUM, DIAGNOSE, VOORSCHRIFT)
	VALUES
	(1, 'PAN-001', '13-SEP-2020', 'Luizen', '3ml anti luizen zalf/d'),
	(2, 'LOX-001', '24-MAY-2016', NULL, 'Vit. D 10µl/d'),
	(3, 'TOR-002', '28-OCT-2019', 'Zwanger', NULL),
	(4, 'PHO-002', '02-JUN-2019', NULL, NULL),
	(5, 'PHO-006', '06-AUG-2017', 'HepA', 'HepA injectie')
END	
GO

-- | T 2.10 | UC 1.28, FR 1.4 | De juiste data van het medisch dossier wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[test De juiste data van het medisch dossier wordt teruggegeven zonder parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	EXEC STP_SelectMedischDossier

	INSERT INTO [test_STP_SelectMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	VALUES
		('COL-007', '2021-11-14 00:00:00.000', 11, '2022-11-14 00:00:00.000', NULL,			NULL,							NULL),
		('LOX-001', '2016-05-24 00:00:00.000', 12,  NULL,                     NULL,			'Vit. D 10µl/d',				'2'),
		('PAN-001', '2020-09-13 00:00:00.000', 11, '2020-10-13 00:00:00.000', 'Luizen',		'3ml anti luizen zalf/d',		'1'),
		('PHO-002', '2019-06-02 00:00:00.000', 14, '2019-06-16 00:00:00.000', NULL,			NULL,							'4'),
		('PHO-006', '2017-08-06 00:00:00.000', 14,  NULL,                     'HepA',		'HepA injectie',				'5'),
		('TOR-001', '2018-01-19 00:00:00.000', 12,  NULL,                     NULL,			NULL,							NULL),
		('TOR-002', '2019-10-28 00:00:00.000', 13,  NULL,                     'Zwanger',	NULL,							'3')
			

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedischDossier.actual', 'test_STP_SelectMedischDossier.verwacht'
END
GO


-- | T 2.10 | UC 1.28, FR 1.4 | De juiste data van het medisch dossier wordt teruggegeven met parameter DierID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[test De juiste data van het medisch dossier wordt teruggegeven met parameter DierID]
AS
BEGIN	
	INSERT INTO [test_STP_SelectMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	EXEC STP_SelectMedischDossier
		@DierId = 'PHO-002'

	INSERT INTO [test_STP_SelectMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	VALUES
	('PHO-002', '2019-06-02 00:00:00.000', 14, '2019-06-16 00:00:00.000', NULL,	NULL, '4')	

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedischDossier.actual', 'test_STP_SelectMedischDossier.verwacht'
END
GO

-- | T 2.10 | UC 1.28, FR 1.4 | De juiste data van het medisch dossier wordt teruggegeven met parameter DatumControle. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[test De juiste data van het medisch dossier wordt teruggegeven met parameter DatumControle]
AS
BEGIN	
	INSERT INTO [test_STP_SelectMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	EXEC STP_SelectMedischDossier
		@DatumControle = '14-NOV-2021'

	INSERT INTO [test_STP_SelectMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	VALUES
	('COL-007', '2021-11-14 00:00:00.000', 11, '2022-11-14 00:00:00.000', NULL,	NULL, NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedischDossier.actual', 'test_STP_SelectMedischDossier.verwacht'
END
GO


-- | T 2.10 | UC 1.28, FR 1.4 | De juiste data van het medisch dossier wordt teruggegeven met parameter MedewerkerID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[test De juiste data van het medisch dossier wordt teruggegeven met parameter MedewerkerID]
AS
BEGIN	
	INSERT INTO [test_STP_SelectMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	EXEC STP_SelectMedischDossier
		@MedewerkerId = 14

	INSERT INTO [test_STP_SelectMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	VALUES
	('PHO-002', '2019-06-02 00:00:00.000', 14, '2019-06-16 00:00:00.000', NULL,			NULL,							'4'),
	('PHO-006', '2017-08-06 00:00:00.000', 14,  NULL,                     'HepA',		'HepA injectie',				'5')
			
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedischDossier.actual', 'test_STP_SelectMedischDossier.verwacht'
END
GO

-- | T 2.10 | UC 1.28, FR 1.4 | De juiste data van het medisch dossier wordt teruggegeven met parameter VolgendeControle. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[test De juiste data van het medisch dossier wordt teruggegeven met parameter VolgendeControle]
AS
BEGIN	
	INSERT INTO [test_STP_SelectMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	EXEC STP_SelectMedischDossier
		@VolgendeControle = '14-NOV-2022'

	INSERT INTO [test_STP_SelectMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	VALUES
	('COL-007', '2021-11-14 00:00:00.000', 11, '2022-11-14 00:00:00.000', NULL,	NULL, NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedischDossier.actual', 'test_STP_SelectMedischDossier.verwacht'
END
GO

-- | T 2.10 | UC 1.28, FR 1.4 | De juiste data van het medisch dossier wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedischDossier].[test De juiste data van het medisch dossier wordt teruggegeven met alle parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectMedischDossier].[actual](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	EXEC STP_SelectMedischDossier
		@DierId = 'PAN-001', 
		@DatumControle = '13-SEP-2020',
		@MedewerkerID = 11,
		@VolgendeControle = '13-OCT-2020'

	INSERT INTO [test_STP_SelectMedischDossier].[verwacht](DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE, DIAGNOSE, VOORSCHRIFT, OBSERVATIEID)
	VALUES
	('PAN-001', '2020-09-13 00:00:00.000', 11, '2020-10-13 00:00:00.000', 'Luizen',	'3ml anti luizen zalf/d', '1')
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedischDossier.actual', 'test_STP_SelectMedischDossier.verwacht'
END
GO

------------------------------------------ T2.11 ----------------------------------------- Vince
--Unit Tests UC 1.32
EXEC tSQLt.NewTestClass 'test_STP_SelectDieetInformatie'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_STP_SelectDieetInformatie].[actual]
	FROM DIEETINFORMATIE

	SELECT top 0 *
	INTO [test_STP_SelectDieetInformatie].[verwacht]
	FROM DIEETINFORMATIE

    EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE';	
	
	INSERT INTO DIEETINFORMATIE (DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('PAN-001', 'Gecondenseerde Melk', '19-APR-2007', '1.5', 'Liter'),
	('PAN-001', 'Pens', '15-AUG-2007', '1.5', 'Kilogram'),
	('PAN-001', 'Hart', '03-JUN-2012', '400', 'Gram'),
	('PAN-001', 'Karkas', '03-JUN-2012', '1', 'Aantal'),
	('LOX-001', 'Gecondenseerde Melk', '19-JAN-2001', '5', 'Liter'),
	('LOX-001', 'Bladgroentenmix', '25-NOV-2004', '100', 'Kilogram'),
	('LOX-001', 'Bladgroentenmix', '14-APR-2013', '150', 'Kilogram'),
	('LOX-001', 'Water', '14-APR-2013', '190', 'Liter'),
	('CAN-001', 'Gecondenseerde Melk', '26-NOV-2005', '2.3', 'Liter'),
	('CAN-001', 'Pens', '24-AUG-2006', '1.8', 'Kilogram'),
	('CAN-001', 'Vleesmix', '29-JAN-2008', '7', 'Kilogram')
END	
GO

-- | T 2.11 | UC 1.32, FR 1.9 | De juiste dieetinformatie data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[test De juiste dieetinformatie data wordt teruggegeven zonder parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectDieetInformatie].[actual](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	EXEC STP_SelectDieetInformatie

	INSERT INTO [test_STP_SelectDieetInformatie].[verwacht](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('PAN-001', 'Gecondenseerde Melk', '19-APR-2007', '1.5', 'Liter'),
	('PAN-001', 'Pens', '15-AUG-2007', '1.5', 'Kilogram'),
	('PAN-001', 'Hart', '03-JUN-2012', '400', 'Gram'),
	('PAN-001', 'Karkas', '03-JUN-2012', '1', 'Aantal'),
	('LOX-001', 'Gecondenseerde Melk', '19-JAN-2001', '5', 'Liter'),
	('LOX-001', 'Bladgroentenmix', '25-NOV-2004', '100', 'Kilogram'),
	('LOX-001', 'Bladgroentenmix', '14-APR-2013', '150', 'Kilogram'),
	('LOX-001', 'Water', '14-APR-2013', '190', 'Liter'),
	('CAN-001', 'Gecondenseerde Melk', '26-NOV-2005', '2.3', 'Liter'),
	('CAN-001', 'Pens', '24-AUG-2006', '1.8', 'Kilogram'),
	('CAN-001', 'Vleesmix', '29-JAN-2008', '7', 'Kilogram')


	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDieetInformatie.actual', 'test_STP_SelectDieetInformatie.verwacht'
END
GO

-- | T 2.11 | UC 1.32, FR 1.9 | De juiste dieetinformatie data wordt teruggegeven met parameter DierID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[test De juiste dieetinformatie data wordt teruggegeven met parameter DierID]
AS
BEGIN	
	INSERT INTO [test_STP_SelectDieetInformatie].[actual](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	EXEC STP_SelectDieetInformatie
		@DierId = 'PAN-001'

	INSERT INTO [test_STP_SelectDieetInformatie].[verwacht](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('PAN-001', 'Gecondenseerde Melk', '19-APR-2007', '1.5', 'Liter'),
	('PAN-001', 'Pens', '15-AUG-2007', '1.5', 'Kilogram'),
	('PAN-001', 'Hart', '03-JUN-2012', '400', 'Gram'),
	('PAN-001', 'Karkas', '03-JUN-2012', '1', 'Aantal')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDieetInformatie.actual', 'test_STP_SelectDieetInformatie.verwacht'
END
GO

-- | T 2.11 | UC 1.32, FR 1.9 | De juiste dieetinformatie data wordt teruggegeven met parameter VoedselSoort. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[test De juiste dieetinformatie data wordt teruggegeven met parameter VoedselSoort]
AS
BEGIN	
	INSERT INTO [test_STP_SelectDieetInformatie].[actual](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	EXEC STP_SelectDieetInformatie
		@VoedselSoort = 'Gecondenseerde Melk'

	INSERT INTO [test_STP_SelectDieetInformatie].[verwacht](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('PAN-001', 'Gecondenseerde Melk', '19-APR-2007', '1.5', 'Liter'),
	('LOX-001', 'Gecondenseerde Melk', '19-JAN-2001', '5', 'Liter'),
	('CAN-001', 'Gecondenseerde Melk', '26-NOV-2005', '2.3', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDieetInformatie.actual', 'test_STP_SelectDieetInformatie.verwacht'
END
GO

-- | T 2.11 | UC 1.32, FR 1.9 | De juiste dieetinformatie data wordt teruggegeven met parameter StartDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[test De juiste dieetinformatie data wordt teruggegeven met parameter StartDatum]
AS
BEGIN	
	INSERT INTO [test_STP_SelectDieetInformatie].[actual](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	EXEC STP_SelectDieetInformatie
		@StartDatum = '14-APR-2013'

	INSERT INTO [test_STP_SelectDieetInformatie].[verwacht](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('LOX-001', 'Bladgroentenmix', '14-APR-2013', '150', 'Kilogram'),
	('LOX-001', 'Water', '14-APR-2013', '190', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDieetInformatie.actual', 'test_STP_SelectDieetInformatie.verwacht'
END
GO

-- | T 2.11 | UC 1.32, FR 1.9 | De juiste dieetinformatie data wordt teruggegeven met parameters Hoeveelheid & Eenheid. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[test De juiste dieetinformatie data wordt teruggegeven met parameters Hoeveelheid & Eenheid]
AS
BEGIN	
	INSERT INTO [test_STP_SelectDieetInformatie].[actual](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	EXEC STP_SelectDieetInformatie
		@HoeveelheidPerDag = '1.5',
		@Eenheid = 'Kilogram'

	INSERT INTO [test_STP_SelectDieetInformatie].[verwacht](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('PAN-001', 'Pens', '15-AUG-2007', '1.5', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDieetInformatie.actual', 'test_STP_SelectDieetInformatie.verwacht'
END
GO

-- | T 2.11 | UC 1.32, FR 1.9 | De juiste dieetinformatie data wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectDieetInformatie].[test De juiste dieetinformatie data wordt teruggegeven met alle parameters]
AS
BEGIN	
	INSERT INTO [test_STP_SelectDieetInformatie].[actual](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	EXEC STP_SelectDieetInformatie
		@DierID = 'CAN-001',
		@VoedselSoort = 'Vleesmix',
		@StartDatum = '29-JAN-2008',
		@HoeveelheidPerDag = '7',
		@Eenheid = 'Kilogram'

	INSERT INTO [test_STP_SelectDieetInformatie].[verwacht](DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
	VALUES
	('CAN-001', 'Vleesmix', '29-JAN-2008', '7', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectDieetInformatie.actual', 'test_STP_SelectDieetInformatie.verwacht'
END
GO

------------------------------------------ T2.12 ----------------------------------------- Nick
-- Unit Tests UC 1.34
EXEC tSQLt.NewTestClass test_STP_SelectLeveringControle
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[SetUp]
AS
BEGIN
	SELECT TOP 0 *
	INTO [test_STP_SelectLeveringControle].[actual]
	FROM LEVERINGCONTROLE

	SELECT TOP 0 *
	INTO [test_STP_SelectLeveringControle].[expected]
	FROM LEVERINGCONTROLE

	EXEC tSQLt.FakeTable 'dbo', 'LEVERINGCONTROLE';	

	INSERT INTO LEVERINGCONTROLE (BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES
	(1, 'Stro', '03-FEB-2021', '1000', '1000', 'Kilogram'),
	(1, 'Hooi', '03-FEB-2021', '1000', '1500', 'Kilogram'),
	(2, 'Pens', '15-NOV-2020', '100', '100', 'Kilogram'),
	(2, 'Karkas', '17-NOV-2020', '30', '30', 'Aantal'),
	(2, 'Spier', '15-NOV-2020', '250', '250', 'Kilogram'),
	(3, 'Fruitmix', '15-MAR-2020', '1500', '1500', 'Kilogram'),
	(3, 'Fruitmix', '27-MAR-2020', '500', '500', 'Kilogram'),
	(3, 'Haver', '15-MAR-2020', '500', '500', 'Kilogram'),
	(3, 'Gecondenseerde Melk', '15-MAR-2020', '500', '500', 'Liter')
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= NULL,
		@VoedselSoort			= NULL,
		@OntvangenDatumTijd		= NULL,
		@OntvangenHoeveelheid	= NULL,
		@VerwachteHoeveelheid	= NULL

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	SELECT * FROM LEVERINGCONTROLE

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven met BestellingID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven met BestellingID]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= 2,
		@VoedselSoort			= NULL,
		@OntvangenDatumTijd		= NULL,
		@OntvangenHoeveelheid	= NULL,
		@VerwachteHoeveelheid	= NULL

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES
	(2, 'Pens', '15-NOV-2020', '100', '100', 'Kilogram'),
	(2, 'Karkas', '17-NOV-2020', '30', '30', 'Aantal'),
	(2, 'Spier', '15-NOV-2020', '250', '250', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven met VoedselSoort. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven met VoedselSoort]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= NULL,
		@VoedselSoort			= 'Fruitmix',
		@OntvangenDatumTijd		= NULL,
		@OntvangenHoeveelheid	= NULL,
		@VerwachteHoeveelheid	= NULL

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES
	(3, 'Fruitmix', '15-MAR-2020', '1500', '1500', 'Kilogram'),
	(3, 'Fruitmix', '27-MAR-2020', '500', '500', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven met OntvangenDatumTijd. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven met OntvangenDatumTijd]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= NULL,
		@VoedselSoort			= NULL,
		@OntvangenDatumTijd		= '15-MAR-2020',
		@OntvangenHoeveelheid	= NULL,
		@VerwachteHoeveelheid	= NULL

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES
	(3, 'Fruitmix', '15-MAR-2020', '1500', '1500', 'Kilogram'),
	(3, 'Haver', '15-MAR-2020', '500', '500', 'Kilogram'),
	(3, 'Gecondenseerde Melk', '15-MAR-2020', '500', '500', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven met OntvangenHoeveelheid. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven met OntvangenHoeveelheid]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= NULL,
		@VoedselSoort			= NULL,
		@OntvangenDatumTijd		= NULL,
		@OntvangenHoeveelheid	= 500,
		@VerwachteHoeveelheid	= NULL

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES
	(3, 'Fruitmix', '27-MAR-2020', '500', '500', 'Kilogram'),
	(3, 'Haver', '15-MAR-2020', '500', '500', 'Kilogram'),
	(3, 'Gecondenseerde Melk', '15-MAR-2020', '500', '500', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven met VerwachteHoeveelheid. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven met VerwachteHoeveelheid]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= NULL,
		@VoedselSoort			= NULL,
		@OntvangenDatumTijd		= NULL,
		@OntvangenHoeveelheid	= NULL,
		@VerwachteHoeveelheid	= 1500

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES
	(1, 'Hooi', '03-FEB-2021', '1000', '1500', 'Kilogram'),
	(3, 'Fruitmix', '15-MAR-2020', '1500', '1500', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

-- | T 2.12 | UC 1.34, FR 1.12 | De juiste data van de leveringcontrole wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeveringControle].[test De juiste data van de leveringcontrole wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeveringControle].[actual](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	EXEC STP_SelectLeveringControle
		@BestellingID			= 2,
		@VoedselSoort			= 'Pens',
		@OntvangenDatumTijd		= '15-NOV-2020',
		@OntvangenHoeveelheid	= 100,
		@VerwachteHoeveelheid	= 100

	INSERT INTO [test_STP_SelectLeveringControle].[expected](BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
	VALUES	(2, 'Pens', '15-NOV-2020', '100', '100', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeveringControle.actual', 'test_STP_SelectLeveringControle.expected'
END
GO

------------------------------------------ T2.13 ----------------------------------------- Levi
-- Unit Tests UC 1.39
EXEC tSQLt.NewTestClass 'test_STP_SelectBestelling'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[SetUp]
AS
BEGIN
	SELECT TOP 0 B.BESTELLINGID, B.LEVERANCIERNAAM, B.BESTELDATUM, B.BESTELSTATUS, B.BETAALDATUM,
		R.VOEDSELSOORT, R. BESTELDEHOEVEELHEID, R.PRIJS, R.EENHEID
	INTO [test_STP_SelectBestelling].[actual]
	FROM BESTELLING B INNER JOIN BESTELLINGREGEL R ON B.BESTELLINGID = R.BESTELLINGID
	
	SELECT TOP 0 B.BESTELLINGID, B.LEVERANCIERNAAM, B.BESTELDATUM, B.BESTELSTATUS, B.BETAALDATUM,
		R.VOEDSELSOORT, R. BESTELDEHOEVEELHEID, R.PRIJS, R.EENHEID
	INTO [test_STP_SelectBestelling].[verwacht]
	FROM BESTELLING B INNER JOIN BESTELLINGREGEL R ON B.BESTELLINGID = R.BESTELLINGID

    EXEC tSQLt.FakeTable 'dbo', 'BESTELLING';	
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLINGREGEL';

	INSERT INTO BESTELLING (BESTELLINGID, LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	VALUES 
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020')

	INSERT INTO BESTELLINGREGEL (BESTELLINGID, VOEDSELSOORT, BESTELDEHOEVEELHEID, PRIJS, EENHEID)
	VALUES
	(1, 'Stro', '1000', '£0.74', 'Kilogram'),
	(1, 'Hooi', '1500', '£1.24', 'Kilogram'),
	(1, 'Gedroogd Gras', '800', '£0.62', 'Kilogram'),
	(2, 'Pens', '100', '£4.32', 'Kilogram'),
	(2, 'Karkas', '30', '£32.98', 'Aantal'),
	(2, 'Spier', '250', '£3.78', 'Kilogram'),
	(3, 'Fruitmix', '2000', '£2.3', 'Kilogram'),
	(3, 'Haver', '500', '£1.89', 'Kilogram'),
	(3, 'Gecondenseerde Melk', '500', '£3.45', 'Liter')
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Stro', '1000', '£0.74', 'Kilogram'),
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Hooi', '1500', '£1.24', 'Kilogram'),
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Gedroogd Gras', '800', '£0.62', 'Kilogram'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Pens', '100', '£4.32', 'Kilogram'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Karkas', '30', '£32.98', 'Aantal'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Spier', '250', '£3.78', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Fruitmix', '2000', '£2.3', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Haver', '500', '£1.89', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Gecondenseerde Melk', '500', '£3.45', 'Liter')
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven met parameter BestellingID. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven met parameter BestellingID]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling
		@BestellingID = 1

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES 
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Stro', '1000', '£0.74', 'Kilogram'),
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Hooi', '1500', '£1.24', 'Kilogram'),
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Gedroogd Gras', '800', '£0.62', 'Kilogram')
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven met parameter LeverancierNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven met parameter LeverancierNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling
		@LeverancierNaam = 'Mapleton Zoological Supplies'

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Stro', '1000', '£0.74', 'Kilogram'),
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Hooi', '1500', '£1.24', 'Kilogram'),
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL, 'Gedroogd Gras', '800', '£0.62', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Fruitmix', '2000', '£2.3', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Haver', '500', '£1.89', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Gecondenseerde Melk', '500', '£3.45', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven met parameter BestelDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven met parameter BestelDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling
		@BestelDatum = '01-NOV-2020'

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Pens', '100', '£4.32', 'Kilogram'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Karkas', '30', '£32.98', 'Aantal'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Spier', '250', '£3.78', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven met parameter BestelStatus. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven met parameter BestelStatus]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling
		@BestelStatus = 'Betaling_Nodig'

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Pens', '100', '£4.32', 'Kilogram'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Karkas', '30', '£32.98', 'Aantal'),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL, 'Spier', '250', '£3.78', 'Kilogram')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven met parameter BetaalDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven met parameter BetaalDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling
		@BetaalDatum = '2-APR-2020'

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Fruitmix', '2000', '£2.3', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Haver', '500', '£1.89', 'Kilogram'),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Gecondenseerde Melk', '500', '£3.45', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

-- | T 2.13 | UC 1.39, FR 1.10 | De juiste bestellingen data wordt teruggegeven met parameter VoedselSoort. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestelling].[test De juiste bestellingen data wordt teruggegeven met parameter VoedselSoort]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestelling].[actual]
	EXEC STP_SelectBestelling
		@VoedselSoort = 'Melk'

	INSERT INTO [test_STP_SelectBestelling].[verwacht]
	VALUES
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020', 'Gecondenseerde Melk', '500', '£3.45', 'Liter')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestelling.actual', 'test_STP_SelectBestelling.verwacht'
END
GO

------------------------------------------ T2.14 ----------------------------------------- Levi
-- Unit Tests UC 1.44
EXEC tSQLt.NewTestClass test_STP_SelectBestellingStatus
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectBestellingStatus].[SetUp]
AS
BEGIN
	SELECT TOP 0 BESTELSTATUS
	INTO [test_STP_SelectBestellingStatus].[actual]
	FROM BESTELLING

	SELECT TOP 0 BESTELSTATUS
	INTO [test_STP_SelectBestellingStatus].[expected] 
	FROM BESTELLING

	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING';	

	INSERT INTO BESTELLING (BESTELLINGID, LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
	VALUES 
	(1, 'Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL),
	(2, 'Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL),
	(3, 'Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020')
END
GO

-- | T 2.14 | UC 1.40, FR 1.13 | De juiste status van de bestelling wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestellingStatus].[test De juiste bestelstatus wordt teruggegeven voor bestelling 1]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestellingStatus].[actual]
	EXEC STP_SelectBestellingStatus
		@BestellingID = 1

	INSERT INTO [test_STP_SelectBestellingStatus].[expected]
	VALUES ('Besteld')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestellingStatus.actual', 'test_STP_SelectBestellingStatus.expected'
END
GO

-- | T 2.14 | UC 1.40, FR 1.13 | De juiste status van de bestelling wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestellingStatus].[test De juiste bestelstatus wordt teruggegeven voor bestelling 2]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestellingStatus].[actual]
	EXEC STP_SelectBestellingStatus
		@BestellingID = 2

	INSERT INTO [test_STP_SelectBestellingStatus].[expected]
	VALUES ('Betaling_Nodig')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestellingStatus.actual', 'test_STP_SelectBestellingStatus.expected'
END
GO

-- | T 2.14 | UC 1.40, FR 1.13 | De juiste status van de bestelling wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_STP_SelectBestellingStatus].[test De juiste bestelstatus wordt teruggegeven voor bestelling 3]
AS
BEGIN
	INSERT INTO [test_STP_SelectBestellingStatus].[actual]
	EXEC STP_SelectBestellingStatus
	@BestellingID = 3

	INSERT INTO [test_STP_SelectBestellingStatus].[expected]
	VALUES ('Betaald')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectBestellingStatus.actual', 'test_STP_SelectBestellingStatus.expected'
END
GO

------------------------------------------ T2.15 ----------------------------------------- Nick
-- Unit Tests UC 1.44
EXEC tSQLt.NewTestClass test_STP_SelectMedewerker
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[SetUp]
AS
BEGIN
	SELECT TOP 0 MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM
	INTO [test_STP_SelectMedewerker].[actual]
	FROM MEDEWERKER

	SELECT TOP 0 MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM
	INTO [test_STP_SelectMedewerker].[expected] 
	FROM MEDEWERKER

	EXEC tSQLt.FakeTable 'dbo', 'MEDEWERKER';	

	INSERT INTO MEDEWERKER (MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES
	(1,'Maxwell', 'Alfaro', 'Parkeigenaar', NULL),
	(2,'Eboni', 'Lyons', 'Hoofdverzorger', 'Savanne'),
	(3,'Rhiannon', 'Huff', 'Hoofdverzorger', 'Vlindertuin'),
	(4,'Bruno', 'Conroy', 'Hoofdverzorger', 'Aquarium'),
	(5,'Ronan', 'Ponce', 'Hoofdverzorger', 'Europa & Amerika'),
	(6,'Andrei', 'Meyer', 'Verzorger', 'Savanne'),
	(7,'Irfan', 'Currie', 'Verzorger', 'Vlindertuin'),
	(8,'Rufus', 'Galvan', 'Verzorger', 'Savanne'),
	(9,'Richard', 'Bray', 'Verzorger', 'Aquarium'),
	(10,'Griffin', 'Draper', 'Verzorger', 'Europa & Amerika'),
	(11,'Bella-Rose', 'Harrison', 'Dierenarts', NULL),
	(12,'Shae', 'Haigh', 'Dierenarts', NULL),
	(13,'Shae', 'Black', 'Dierenarts', NULL),
	(14,'Esmay', 'Swift', 'Dierenarts', NULL),
	(15,'Ryker', 'Akhtar', 'Team leider', NULL),
	(16,'Bryony', 'Mckee', 'Administratief assistent', NULL),
	(17,'Talha', 'Holloway', 'Kantoormedewerker', NULL),
	(18,'Callen', 'Knox', 'Kantoormedewerker', NULL),
	(19,'Clive', 'Potter', 'Kantoormedewerker', NULL),
	(20,'Connah', 'Soto', 'Kantoormedewerker', NULL),
	(21,'Marwah', 'Barclay', 'Kantoormedewerker', NULL),
	(22,'Yousef', 'Tanner', 'Kantoormedewerker', NULL),
	(23,'Erica', 'Buchanan', 'Schoonmaker', NULL),
	(24,'Dawid', 'Buchanan', 'Restaurantmedewerker', NULL),
	(25,'Kadeem', 'Oakley', 'Restaurantmedewerker', NULL),
	(26,'Leonie', 'Howe', 'Restaurantmedewerker', NULL),
	(27,'Bilaal', 'Bishop', 'Restaurantmedewerker', NULL),
	(28,'Nabeel', 'Burns', 'Restaurantmedewerker', NULL)
END
GO

-- | T 2.15 | UC 1.44, FR 1.7 | De juiste data van medewerker wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= NULL,
		@GebiedNaam		= NULL,
		@Voornaam		= NULL,
		@Achternaam		= NULL,
		@Functie		= NULL

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	SELECT MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM FROM MEDEWERKER

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven met MedewerkerID]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= 1,
		@GebiedNaam		= NULL,
		@Voornaam		= NULL,
		@Achternaam		= NULL,
		@Functie		= NULL

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES	(1,'Maxwell', 'Alfaro', 'Parkeigenaar', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

-- | T 2.15 | UC 1.44, FR 1.7 | De juiste data van medewerker wordt teruggegeven met GebiedNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven met GebiedNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= NULL,
		@GebiedNaam		= 'Europa & Amerika',
		@Voornaam		= NULL,
		@Achternaam		= NULL,
		@Functie		= NULL

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES
	(5,'Ronan', 'Ponce', 'Hoofdverzorger', 'Europa & Amerika'),
	(10,'Griffin', 'Draper', 'Verzorger', 'Europa & Amerika')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

-- | T 2.15 | UC 1.44, FR 1.7 | De juiste data van medewerker wordt teruggegeven met Voornaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven met Voornaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= NULL,
		@GebiedNaam		= NULL,
		@Voornaam		= 'Callen',
		@Achternaam		= NULL,
		@Functie		= NULL

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES (18,'Callen', 'Knox', 'Kantoormedewerker', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

-- | T 2.15 | UC 1.44, FR 1.7 | De juiste data van medewerker wordt teruggegeven met Achternaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven met Achternaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= NULL,
		@GebiedNaam		= NULL,
		@Voornaam		= NULL,
		@Achternaam		= 'Draper',
		@Functie		= NULL

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES (10,'Griffin', 'Draper', 'Verzorger', 'Europa & Amerika')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

-- | T 2.15 | UC 1.44, FR 1.7 | De juiste data van medewerker wordt teruggegeven met Functie. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven met Functie]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= NULL,
		@GebiedNaam		= NULL,
		@Voornaam		= NULL,
		@Achternaam		= NULL,
		@Functie		= 'Kantoormedewerker'

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES 
	(17,'Talha', 'Holloway', 'Kantoormedewerker', NULL),
	(18,'Callen', 'Knox', 'Kantoormedewerker', NULL),
	(19,'Clive', 'Potter', 'Kantoormedewerker', NULL),
	(20,'Connah', 'Soto', 'Kantoormedewerker', NULL),
	(21,'Marwah', 'Barclay', 'Kantoormedewerker', NULL),
	(22,'Yousef', 'Tanner', 'Kantoormedewerker', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

-- | T 2.15 | UC 1.44, FR 1.7 | De juiste data van medewerker wordt teruggegeven met alle parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectMedewerker].[test De juiste data van medewerker wordt teruggegeven met alle parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectMedewerker].[actual](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	EXEC STP_SelectMedewerker
		@MedewerkerID	= 4,
		@GebiedNaam		= 'Aquarium',
		@Voornaam		= 'Bruno',
		@Achternaam		= 'Conroy',
		@Functie		= 'Hoofdverzorger'

	SET IDENTITY_INSERT [test_STP_SelectMedewerker].[expected] ON
	INSERT INTO [test_STP_SelectMedewerker].[expected](MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
	VALUES (4,'Bruno', 'Conroy', 'Hoofdverzorger', 'Aquarium')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectMedewerker.actual', 'test_STP_SelectMedewerker.expected'
END
GO

------------------------------------------ T2.16 ----------------------------------------- Levi
-- Unit Tests UC 1.46
EXEC tSQLt.NewTestClass 'test_STP_SelectLeverancier'
GO

CREATE OR ALTER PROCEDURE [test_STP_SelectLeverancier].[SetUp]
AS
BEGIN
	SELECT TOP 0 LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES, CONTACTINFORMATIE
	INTO [test_STP_SelectLeverancier].[actual]
	FROM LEVERANCIER
	
	SELECT TOP 0 LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES, CONTACTINFORMATIE
	INTO [test_STP_SelectLeverancier].[verwacht]
	FROM LEVERANCIER

    EXEC tSQLt.FakeTable 'dbo', 'LEVERANCIER';	

	INSERT INTO LEVERANCIER (LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES, CONTACTINFORMATIE)
	VALUES
	('Freeks Freaky Frikandellen', 'Nijmegen', 'Professor Molkenboerstraat 3', 'Emailadres: FrikandellenFun@Gmail.nl'),
	('Mapleton Zoological Supplies', 'Suffolk', '134 Murray R.', NULL),
	('Dierentuingoederen Overijssel', 'Zwolle', 'Industrielaan 305', 'Telefoonnummer: 0612345678'),
	('Zoologischer Bedarf München', 'München', 'Schnitzelstraße 42', NULL),
	('Kiezebrink UK Ltd', 'Bury St Edmunds', 'Church Road', 'Emailadres: KiezebrinkInc@Gmail.co.uk')
END
GO

-- | T 2.16 | UC 1.46, FR 1.11 | De juiste Leveranciers data wordt teruggegeven zonder parameters. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeverancier].[test De juiste Leveranciers data wordt teruggegeven zonder parameters]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeverancier].[actual]
	EXEC STP_SelectLeverancier

	INSERT INTO [test_STP_SelectLeverancier].[verwacht]
	VALUES
	('Freeks Freaky Frikandellen', 'Nijmegen', 'Professor Molkenboerstraat 3', 'Emailadres: FrikandellenFun@Gmail.nl'),
	('Mapleton Zoological Supplies', 'Suffolk', '134 Murray R.', NULL),
	('Dierentuingoederen Overijssel', 'Zwolle', 'Industrielaan 305', 'Telefoonnummer: 0612345678'),
	('Zoologischer Bedarf München', 'München', 'Schnitzelstraße 42', NULL),
	('Kiezebrink UK Ltd', 'Bury St Edmunds', 'Church Road', 'Emailadres: KiezebrinkInc@Gmail.co.uk')
	
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeverancier.actual', 'test_STP_SelectLeverancier.verwacht'
END
GO

-- | T 2.16 | UC 1.46, FR 1.11 | De juiste Leveranciers data wordt teruggegeven met parameter LeverancierNaam. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeverancier].[test De juiste Leveranciers data wordt teruggegeven met parameter LeverancierNaam]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeverancier].[actual]
	EXEC STP_SelectLeverancier
		@LeverancierNaam = 'Zoo'

	INSERT INTO [test_STP_SelectLeverancier].[verwacht]
	VALUES 
	('Mapleton Zoological Supplies', 'Suffolk', '134 Murray R.', NULL),
	('Zoologischer Bedarf München', 'München', 'Schnitzelstraße 42', NULL)

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeverancier.actual', 'test_STP_SelectLeverancier.verwacht'
END
GO

-- | T 2.16 | UC 1.46, FR 1.11 | De juiste Leveranciers data wordt teruggegeven met parameter LeverancierPlaats. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeverancier].[test De juiste Leveranciers data wordt teruggegeven met parameter LeverancierPlaats]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeverancier].[actual]
	EXEC STP_SelectLeverancier
		@LeverancierPlaats = 'Nijmegen'

	INSERT INTO [test_STP_SelectLeverancier].[verwacht]
	VALUES
	('Freeks Freaky Frikandellen', 'Nijmegen', 'Professor Molkenboerstraat 3', 'Emailadres: FrikandellenFun@Gmail.nl')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeverancier.actual', 'test_STP_SelectLeverancier.verwacht'
END
GO

-- | T 2.16 | UC 1.46, FR 1.11 | De juiste Leveranciers data wordt teruggegeven met parameter BestelDatum. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeverancier].[test De juiste Leveranciers data wordt teruggegeven met parameter BestelDatum]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeverancier].[actual]
	EXEC STP_SelectLeverancier
		@LeverancierAdres = 'Industrielaan'

	INSERT INTO [test_STP_SelectLeverancier].[verwacht]
	VALUES
	('Dierentuingoederen Overijssel', 'Zwolle', 'Industrielaan 305', 'Telefoonnummer: 0612345678')

	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeverancier.actual', 'test_STP_SelectLeverancier.verwacht'
END
GO

-- | T 2.16 | UC 1.46, FR 1.11 | De juiste Leveranciers data wordt teruggegeven met parameter BestelStatus. |
CREATE OR ALTER PROCEDURE [test_STP_SelectLeverancier].[test De juiste Leveranciers data wordt teruggegeven met parameter BestelStatus]
AS
BEGIN
	INSERT INTO [test_STP_SelectLeverancier].[actual]
	EXEC STP_SelectLeverancier
		@ContactInformatie = 'Emailadres'

	INSERT INTO [test_STP_SelectLeverancier].[verwacht]
	VALUES
	('Freeks Freaky Frikandellen', 'Nijmegen', 'Professor Molkenboerstraat 3', 'Emailadres: FrikandellenFun@Gmail.nl'),
	('Kiezebrink UK Ltd', 'Bury St Edmunds', 'Church Road', 'Emailadres: KiezebrinkInc@Gmail.co.uk')
	EXEC [tSQLt].[AssertEqualsTable] 'test_STP_SelectLeverancier.actual', 'test_STP_SelectLeverancier.verwacht'
END
GO

------------------------------------------ T2.17 ----------------------------------------- Levi
-- Unit Testing UC 1.47
EXEC tSQLt.NewTestClass 'test_VW_SelectVoedsel'
GO

CREATE OR ALTER PROCEDURE [test_VW_SelectVoedsel].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_VW_SelectVoedsel].[actual]
	FROM VOEDSEL

	SELECT top 0 *
	INTO [test_VW_SelectVoedsel].[verwacht]
	FROM VOEDSEL

    EXEC tSQLt.FakeTable 'dbo', 'VOEDSEL';	
	
	INSERT INTO VOEDSEL (VOEDSELSOORT)
	VALUES 
	('Stro'),('Hooi'),('Gedroogd Gras'),('Sla'),('Witlof'),('Radijs'),('Bladgroentenmix'),('Tomaat'),('Komkommer'),('Wortel'),('Prei'),
	('Banaan'),('Appel'),('Kiwi'),('Druiven'),('Fruitmix'),('Haver'),('Gerst'),('Gecondenseerde Melk'),('Water'),('Pens'),('Hart'),
	('Spier'),('Karkas'),('Vleesmix'),('Inktvis'),('Zalm'),('Haring'),('Vismix')
END	
GO

-- | T 2.17 | UC 1.47, FR 1.19 | De juiste voedselsoorten data wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_VW_SelectVoedsel].[test De juiste voedselsoort data wordt teruggegeven]
AS
BEGIN	
	INSERT INTO [test_VW_SelectVoedsel].[actual](VOEDSELSOORT)
	SELECT VOEDSELSOORT
	FROM VW_SelectVoedsel

	INSERT INTO [test_VW_SelectVoedsel].[verwacht](VOEDSELSOORT)
	VALUES
	('Stro'),('Hooi'),('Gedroogd Gras'),('Sla'),('Witlof'),('Radijs'),('Bladgroentenmix'),('Tomaat'),('Komkommer'),('Wortel'),('Prei'),
	('Banaan'),('Appel'),('Kiwi'),('Druiven'),('Fruitmix'),('Haver'),('Gerst'),('Gecondenseerde Melk'),('Water'),('Pens'),('Hart'),
	('Spier'),('Karkas'),('Vleesmix'),('Inktvis'),('Zalm'),('Haring'),('Vismix')	

	EXEC [tSQLt].[AssertEqualsTable] 'test_VW_SelectVoedsel.actual', 'test_VW_SelectVoedsel.verwacht'
END
GO

------------------------------------------ T2.18 ----------------------------------------- Vince
-- Unit Testing UC 1.49
EXEC tSQLt.NewTestClass 'test_VW_SelectFuncties'
GO

CREATE OR ALTER PROCEDURE [test_VW_SelectFuncties].[SetUp]
AS
BEGIN
	SELECT top 0 *
	INTO [test_VW_SelectFuncties].[actual]
	FROM FUNCTIES

	SELECT top 0 *
	INTO [test_VW_SelectFuncties].[verwacht]
	FROM FUNCTIES

    EXEC tSQLt.FakeTable 'dbo', 'FUNCTIES';	
	
	INSERT INTO FUNCTIES(FUNCTIE)
	VALUES
	('Parkeigenaar'),
	('Hoofdverzorger'),
	('Verzorger'),
	('Dierenarts'),
	('Team leider'),
	('Administratief assistent'),
	('Kantoormedewerker'),
	('Schoonmaker'),
	('Restaurantmedewerker')
END	
GO

-- | T 2.18 | UC 1.49, FR 1.20 | De juiste functies data wordt teruggegeven. |
CREATE OR ALTER PROCEDURE [test_VW_SelectFuncties].[test De juiste functie data wordt teruggegeven]
AS
BEGIN	
	INSERT INTO [test_VW_SelectFuncties].[actual](FUNCTIE)
	SELECT FUNCTIE
	FROM VW_SelectFuncties

	INSERT INTO [test_VW_SelectFuncties].[verwacht](FUNCTIE)
	VALUES
	('Parkeigenaar'),
	('Hoofdverzorger'),
	('Verzorger'),
	('Dierenarts'),
	('Team leider'),
	('Administratief assistent'),
	('Kantoormedewerker'),
	('Schoonmaker'),
	('Restaurantmedewerker')

	EXEC [tSQLt].[AssertEqualsTable] 'test_VW_SelectFuncties.actual', 'test_VW_SelectFuncties.verwacht'
END
GO