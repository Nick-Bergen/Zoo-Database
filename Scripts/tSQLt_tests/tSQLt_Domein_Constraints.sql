/* ==================================================
=	ISE-Project groep C-2							=
=	Tests Domein Constraints T5.1-T5.24 			=
================================================== */ 

/* Drop de check constraints in het geval ze opnieuw toegevoegd moeten worden

ALTER TABLE BESTELLING
DROP CONSTRAINT CHK_BestelStatus
ALTER TABLE DIER
DROP CONSTRAINT CHK_DierStatus
ALTER TABLE DIER
DROP CONSTRAINT CHK_DierGeslacht
ALTER TABLE BESTELLINGREGEL
DROP CONSTRAINT CHK_Prijs
ALTER TABLE BESTELLINGREGEL
DROP CONSTRAINT CHK_BesteldeHoeveelheid
ALTER TABLE LEVERINGCONTROLE
DROP CONSTRAINT CHK_OntvangenVerwachteHoeveelheid
ALTER TABLE DIEETINFORMATIE
DROP CONSTRAINT CHK_HoeveelheidPerDag

De Unit Tests volgen de vorm AAA: Assembly, Act, Assert
Eerst worden in de SetUp procedure tabellen gekopieerd en gevuld met testdata.
Vervolgens wordt een verwachte uitkomst gedeclareerd (Exception of NoException).
De te testen handeling/procedure wordt uitgevoerd en de test slaagt als de uitkomst overeenkomt met de verwachting.
*/

------------------------------------------ T1.1 - T1.4 -------------------------------------------- Levi
-- Unit Tests DC 1
EXEC tSQLt.NewTestClass 'test_CHK_BestelStatus'
GO

CREATE OR ALTER PROCEDURE [test_CHK_BestelStatus].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLING'
	EXEC tSQLt.ApplyConstraint @TableName = 'BESTELLING', @ConstraintName = 'CHK_BestelStatus';
END
GO

-- | T 5.1 | DC 1 | Een bestelling wordt toegevoegd met correcte status. |
CREATE OR ALTER PROCEDURE [test_CHK_BestelStatus].[test Een bestelling wordt toegevoegd met correcte status.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO BESTELLING(BESTELSTATUS) VALUES ('Besteld'), ('Betaling_Nodig'), ('Betaald')
END
GO

-- | T 5.2 | DC 1 | Een bestelling wordt niet toegevoegd met een incorrecte status. |
CREATE OR ALTER PROCEDURE [test_CHK_BestelStatus].[test Een bestelling wordt niet toegevoegd met een incorrecte status.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO BESTELLING(BESTELSTATUS) VALUES ('FouteStatus')
END
GO

-- | T 5.3 | DC 1 | Een bestelling wordt geüpdate met correcte status. |
CREATE OR ALTER PROCEDURE [test_CHK_BestelStatus].[test Een bestelling wordt geüpdate met correcte status.]
AS
BEGIN
	INSERT INTO BESTELLING(BESTELSTATUS) VALUES ('Besteld')
	EXEC tSQLt.ExpectNoException
    UPDATE BESTELLING
	SET BESTELSTATUS = 'Betaling_Nodig'
END
GO

-- | T 5.4 | DC 1 | Een bestelling wordt niet geüpdate met een incorrecte status. |
CREATE OR ALTER PROCEDURE [test_CHK_BestelStatus].[test Een bestelling wordt niet geüpdate met een incorrecte status.]
AS
BEGIN
	INSERT INTO BESTELLING(BESTELSTATUS) VALUES ('Besteld')
	EXEC tSQLt.ExpectException
    UPDATE BESTELLING
	SET BESTELSTATUS = 'FouteStatus'
END
GO

------------------------------------------ T1.5 - T1.8 -------------------------------------------- Levi
-- Unit Tests DC 2
EXEC tSQLt.NewTestClass 'test_CHK_DierStatus'
GO

CREATE OR ALTER PROCEDURE [test_CHK_DierStatus].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyConstraint @TableName = 'DIER', @ConstraintName = 'CHK_DierStatus';
END
GO

-- | T 5.5 | DC 2 | Een dier wordt toegevoegd met correcte status. |
CREATE OR ALTER PROCEDURE [test_CHK_DierStatus].[test Een dier wordt toegevoegd met correcte status.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIER(STATUS) VALUES ('Aanwezig'), ('Afwezig'), ('Uitgeleend'), ('Uitgezet'), ('Overleden')
END
GO

-- | T 5.6 | DC 2 | Een dier wordt niet toegevoegd met een incorrecte status. |
CREATE OR ALTER PROCEDURE [test_CHK_DierStatus].[test Een dier wordt niet toegevoegd met een incorrecte status.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO DIER(STATUS) VALUES ('FouteStatus')
END
GO

-- | T 5.7 | DC 2 | Een dier wordt geüpdate met correcte status. |
CREATE OR ALTER PROCEDURE [test_CHK_DierStatus].[test Een dier wordt geüpdate met correcte status.]
AS
BEGIN
	INSERT INTO DIER(STATUS) VALUES ('Aanwezig')
	EXEC tSQLt.ExpectNoException
    UPDATE DIER
	SET STATUS = 'Overleden'
END
GO

-- | T 5.8 | DC 2 | Een dier wordt niet geüpdate met een incorrecte status. |
CREATE OR ALTER PROCEDURE [test_CHK_DierStatus].[test Een dier wordt niet geüpdate met een incorrecte status.]
AS
BEGIN
	INSERT INTO DIER(STATUS) VALUES ('Uitgezet')
	EXEC tSQLt.ExpectException
    UPDATE DIER
	SET STATUS = 'FouteStatus'
END
GO

------------------------------------------ T1.9 - T1.12 ------------------------------------------- Levi
-- Unit tests DC 3
EXEC tSQLt.NewTestClass 'test_CHK_DierGeslacht'
GO 

CREATE OR ALTER PROCEDURE [test_CHK_DierGeslacht].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'DIER'
	EXEC tSQLt.ApplyConstraint @TableName = 'DIER', @ConstraintName = 'CHK_DierGeslacht';
END
GO

-- | T 5.9 | DC 3 | Een dier wordt toegevoegd met een correct geslacht. |
CREATE OR ALTER PROCEDURE [test_CHK_DierGeslacht].[test Een dier wordt toegevoegd met een correct geslacht.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO DIER(GESLACHT) VALUES ('M'),('F')
END
GO

-- | T 5.10 | DC 3 | Een dier wordt niet toegevoegd met een incorrect geslacht. |
CREATE OR ALTER PROCEDURE [test_CHK_DierGeslacht].[test Een dier wordt niet toegevoegd met een incorrect geslacht.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO DIER(GESLACHT) VALUES ('A')
END
GO

-- | T 5.11 | DC 3 | Een dier wordt geüpdate met een correct geslacht. |
CREATE OR ALTER PROCEDURE [test_CHK_DierGeslacht].[test Een dier wordt geüpdate met een correct geslacht.]
AS
BEGIN
	INSERT INTO DIER(GESLACHT) VALUES ('M')
	EXEC tSQLt.ExpectNoException
	UPDATE DIER
	SET GESLACHT = 'F'
END
GO

-- | T 5.12 | DC 3 | Een dier wordt niet geüpdate met een incorrect geslacht. |
CREATE OR ALTER PROCEDURE [test_CHK_DierGeslacht].[test Een dier wordt niet geüpdate met een incorrect geslacht.]
AS
BEGIN
	INSERT INTO DIER(GESLACHT) VALUES ('F')
	EXEC tSQLt.ExpectException
    UPDATE DIER
	SET GESLACHT = 'A'
END
GO

------------------------------------------ T1.13 - T1.18 ------------------------------------------ Levi
-- Unit tests DC 4
EXEC tSQLt.NewTestClass 'test_CHK_Prijs'
GO

CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLINGREGEL'
	EXEC tSQLt.ApplyConstraint @TableName = 'BESTELLINGREGEL', @ConstraintName = 'CHK_Prijs';
END
GO

-- | T 5.13 | DC 4 | Een prijs wordt toegevoegd met een positieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[test Een prijs wordt toegevoegd met een positieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO BESTELLINGREGEL(PRIJS) VALUES (1)
END
GO

-- | T 5.14 | DC 4 | Een prijs wordt toegevoegd met een nulwaarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[test Een prijs wordt toegevoegd met een nulwaarde.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
    INSERT INTO BESTELLINGREGEL(PRIJS) VALUES (0)
END
GO

-- | T 5.15 | DC 4 | Een prijs wordt niet toegevoegd met een negatieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[test Een prijs wordt niet toegevoegd met een negatieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO BESTELLINGREGEL(PRIJS) VALUES (-1)
END
GO

-- | T 5.16 | DC 4 | Een prijs wordt geüpdate met een positieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[test Een prijs wordt geüpdate met een positieve waarde.]
AS
BEGIN
	INSERT INTO BESTELLINGREGEL(PRIJS) VALUES (1)
	EXEC tSQLt.ExpectNoException
	UPDATE BESTELLINGREGEL
	SET PRIJS = 2
END
GO

-- | T 5.17 | DC 4 | Een prijs wordt geüpdate met een nulwaarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[test Een prijs wordt geüpdate met een nulwaarde.]
AS
BEGIN
	INSERT INTO BESTELLINGREGEL(PRIJS) VALUES (1)
	EXEC tSQLt.ExpectNoException
	UPDATE BESTELLINGREGEL
	SET PRIJS = 0
END
GO

-- | T 5.18 | DC 4 | Een prijs wordt niet geüpdate met een negatieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Prijs].[test Een prijs wordt niet geüpdate met een negatieve waarde.]
AS
BEGIN
	INSERT INTO BESTELLINGREGEL(PRIJS) VALUES (1)
	EXEC tSQLt.ExpectException
	UPDATE BESTELLINGREGEL
	SET PRIJS = -1
END
GO

------------------------------------------ T1.19 - T1.24 ------------------------------------------ Levi
-- Unit tests DC 5
EXEC tSQLt.NewTestClass 'test_CHK_Hoeveelheid'
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[SetUp]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'BESTELLINGREGEL'
	EXEC tSQLt.ApplyConstraint @TableName = 'BESTELLINGREGEL', @ConstraintName = 'CHK_BesteldeHoeveelheid';
	EXEC tSQLt.FakeTable 'dbo', 'LEVERINGCONTROLE'
	EXEC tSQLt.ApplyConstraint @TableName = 'LEVERINGCONTROLE', @ConstraintName = 'CHK_OntvangenVerwachteHoeveelheid';
	EXEC tSQLt.FakeTable 'dbo', 'DIEETINFORMATIE'
	EXEC tSQLt.ApplyConstraint @TableName = 'DIEETINFORMATIE', @ConstraintName = 'CHK_HoeveelheidPerDag';
END
GO

-- | T 5.19 | DC 5 | Een hoeveelheid wordt toegevoegd met een positieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test Een hoeveelheid wordt toegevoegd met een positieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectNoException
	INSERT INTO BESTELLINGREGEL(BESTELDEHOEVEELHEID) VALUES (1)
	INSERT INTO LEVERINGCONTROLE(ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID) VALUES (1,1)
	INSERT INTO DIEETINFORMATIE(HOEVEELHEIDPERDAG) VALUES (1)
END
GO
-- | T 5.20 | DC 5 | Een hoeveelheid wordt niet toegevoegd met een nulwaarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 1 Een hoeveelheid wordt niet toegevoegd met een nulwaarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO BESTELLINGREGEL(BESTELDEHOEVEELHEID) VALUES (0)
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 2 Een hoeveelheid wordt niet toegevoegd met een nulwaarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO LEVERINGCONTROLE(ONTVANGENHOEVEELHEID) VALUES (0)
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 3 Een hoeveelheid wordt niet toegevoegd met een nulwaarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO LEVERINGCONTROLE(VERWACHTEHOEVEELHEID) VALUES (0)
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 4 Een hoeveelheid wordt niet toegevoegd met een nulwaarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO DIEETINFORMATIE(HOEVEELHEIDPERDAG) VALUES (0)
END
GO

-- | T 5.21 | DC 5 | Een hoeveelheid wordt niet toegevoegd met een negatieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 1 Een hoeveelheid wordt niet toegevoegd met een negatieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO BESTELLINGREGEL(BESTELDEHOEVEELHEID) VALUES (-1)
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 2 Een hoeveelheid wordt niet toegevoegd met een negatieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO LEVERINGCONTROLE(ONTVANGENHOEVEELHEID) VALUES (-1)
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 3 Een hoeveelheid wordt niet toegevoegd met een negatieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO LEVERINGCONTROLE(VERWACHTEHOEVEELHEID) VALUES (-1)
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 4 Een hoeveelheid wordt niet toegevoegd met een negatieve waarde.]
AS
BEGIN
	EXEC tSQLt.ExpectException
    INSERT INTO DIEETINFORMATIE(HOEVEELHEIDPERDAG) VALUES (-1)
END
GO

-- | T 5.22 | DC 5 | Een hoeveelheid wordt geüpdate met een positieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test Een hoeveelheid wordt geüpdate met een positieve waarde.]
AS
BEGIN
	INSERT INTO BESTELLINGREGEL(BESTELDEHOEVEELHEID) VALUES (1)
	INSERT INTO LEVERINGCONTROLE(ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID) VALUES (1,1)
	INSERT INTO DIEETINFORMATIE(HOEVEELHEIDPERDAG) VALUES (1)
	EXEC tSQLt.ExpectNoException
	UPDATE BESTELLINGREGEL
	SET BESTELDEHOEVEELHEID = 2
	UPDATE LEVERINGCONTROLE
	SET ONTVANGENHOEVEELHEID = 2, VERWACHTEHOEVEELHEID = 2
	UPDATE DIEETINFORMATIE
	SET HOEVEELHEIDPERDAG = 2
END
GO

-- | T 5.23 | DC 5 | Een hoeveelheid wordt niet geüpdate met een nulwaarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 1 Een hoeveelheid wordt niet geüpdate met een nulwaarde.]
AS
BEGIN
	INSERT INTO BESTELLINGREGEL(BESTELDEHOEVEELHEID) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE BESTELLINGREGEL
	SET BESTELDEHOEVEELHEID = 0
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 2 Een hoeveelheid wordt niet geüpdate met een nulwaarde.]
AS
BEGIN
	INSERT INTO LEVERINGCONTROLE(ONTVANGENHOEVEELHEID) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE LEVERINGCONTROLE
	SET ONTVANGENHOEVEELHEID = 0
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 3 Een hoeveelheid wordt niet geüpdate met een nulwaarde.]
AS
BEGIN
	INSERT INTO LEVERINGCONTROLE(VERWACHTEHOEVEELHEID) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE LEVERINGCONTROLE
	SET VERWACHTEHOEVEELHEID = 0
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 4 Een hoeveelheid wordt niet geüpdate met een nulwaarde.]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(HOEVEELHEIDPERDAG) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE DIEETINFORMATIE
	SET HOEVEELHEIDPERDAG = 0
END
GO

-- | T 5.24 | DC 5 | Een hoeveelheid wordt niet geüpdate met een negatieve waarde. |
CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 1 Een hoeveelheid wordt niet geüpdate met een negatieve waarde.]
AS
BEGIN
	INSERT INTO BESTELLINGREGEL(BESTELDEHOEVEELHEID) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE BESTELLINGREGEL
	SET BESTELDEHOEVEELHEID = -1
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 2 Een hoeveelheid wordt niet geüpdate met een negatieve waarde.]
AS
BEGIN
	INSERT INTO LEVERINGCONTROLE(ONTVANGENHOEVEELHEID) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE LEVERINGCONTROLE
	SET ONTVANGENHOEVEELHEID = -1
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 3 Een hoeveelheid wordt niet geüpdate met een negatieve waarde.]
AS
BEGIN
	INSERT INTO LEVERINGCONTROLE(VERWACHTEHOEVEELHEID) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE LEVERINGCONTROLE
	SET VERWACHTEHOEVEELHEID = -1
END
GO

CREATE OR ALTER PROCEDURE [test_CHK_Hoeveelheid].[test 4 Een hoeveelheid wordt niet geüpdate met een negatieve waarde.]
AS
BEGIN
	INSERT INTO DIEETINFORMATIE(HOEVEELHEIDPERDAG) VALUES (1)
	EXEC tSQLt.ExpectException
    UPDATE DIEETINFORMATIE
	SET HOEVEELHEIDPERDAG = -1
END
GO