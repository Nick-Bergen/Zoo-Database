------------------------------------------ Verzorger --------------------------------------------
--CREATE Verzorger user
CREATE LOGIN [VerzorgerLogin] WITH PASSWORD= 'verzorger'
CREATE USER [VerzorgerUser] FOR LOGIN [VerzorgerLogin] 
GO

--CREATE Verzorger Role
CREATE ROLE VerzorgerRole
GO

ALTER ROLE [VerzorgerRole] ADD MEMBER [VerzorgerUser]
GO

--Verzorger toegang geven tot de juiste stored procedure
-- UC 1.1	Nieuw dier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDier    
TO VerzorgerRole;  
GO  

-- UC 1.2	Nieuw gebied toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertGebied 
TO VerzorgerRole;  
GO 

-- UC 1.3	Nieuw verblijf toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertVerblijf
TO VerzorgerRole;  
GO  

-- UC 1.4	Nieuwe diereninformatie toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDiersoort    
TO VerzorgerRole;  
GO  

-- UC 1.5	Nieuw fokdossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertFokdossier
TO VerzorgerRole;  
GO  

-- UC 1.6	Nieuw uitleendossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertUitleenDossier
TO VerzorgerRole;  
GO  

-- UC 1.7	Nieuw uitzetdossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertUitzetDossier
TO VerzorgerRole;  
GO  

-- UC 1.8	Dier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDier
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDier
TO VerzorgerRole;  
GO  

-- UC 1.9	Gebied aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateGebied
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteGebied
TO VerzorgerRole;  
GO  

-- UC 1.10	Verblijf aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateVerblijf
TO VerzorgerRole;  
GO 

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteVerblijf
TO VerzorgerRole;  
GO 

-- UC 1.11	Diereninformatie aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDiersoort
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDiersoort
TO VerzorgerRole;  
GO  

-- UC 1.12	Fokdossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateFokDossier
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteFokDossier
TO VerzorgerRole;  
GO  

-- UC 1.13	Uitleendossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateUitleenDossier
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteUitleenDossier
TO VerzorgerRole;  
GO  

-- UC 1.14	Uitzetdossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateUitzetDossier
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteUitzetDossier
TO VerzorgerRole;  
GO  

-- UC 1.15	Uitdraaisel maken van diereninformatie
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitdraaisel
TO VerzorgerRole;  
GO  

-- UC 1.16	Data ophalen van dier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDier
TO VerzorgerRole;  
GO  

-- UC 1.17	Data ophalen van gebied
GRANT EXECUTE ON OBJECT::dbo.STP_SelectGebied
TO VerzorgerRole;  
GO  

-- UC 1.18	Data ophalen van verblijf
GRANT EXECUTE ON OBJECT::dbo.STP_SelectVerblijf
TO VerzorgerRole;  
GO  

-- UC 1.19	Data ophalen van diersoorten
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDiersoort
TO VerzorgerRole;  
GO

-- UC 1.20	Data ophalen van fokdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectFokDossier
TO VerzorgerRole;  
GO  

-- UC 1.21	Data ophalen van uitleendossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitleenDossier
TO VerzorgerRole;  
GO  

-- UC 1.22	Data ophalen van uitzetdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitzetDossier
TO VerzorgerRole;  
GO  

-- UC 1.30	Ontvangen goederen toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertOntvangenGoederen
TO VerzorgerRole;  
GO  

-- UC 1.32	Data ophalen van voedingsinformatie
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDieetInformatie
TO VerzorgerRole;  
GO  

-- UC 1.33	Ontvangen goederen aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateOntvangenGoederen
TO VerzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteOntvangenGoederen
TO VerzorgerRole;  
GO 

-- UC 1.34	Data ophalen van ontvangen goederen
GRANT EXECUTE ON OBJECT::dbo.STP_SelectLeveringControle
TO VerzorgerRole;  
GO  


-- TEST User Verzorger

-- | T 7.1  | Een verzorger kan zijn stored procedures uitvoeren. |
EXECUTE AS LOGIN = 'VerzorgerLogin'

EXEC STP_SelectUitdraaisel

EXEC STP_SelectDier

REVERT

-- | T 7.2  | Een verzorger kan niet andere stored procedures uitvoeren. |
EXECUTE AS LOGIN = 'VerzorgerLogin'

EXEC STP_SelectMedewerker
-- The EXECUTE permission was denied on the object 'STP_SelectMedewerker', database 'Somerleyton', schema 'dbo'.

EXEC STP_DeleteMedischDossier
	@DierId = 'COL-007',
	@ControleDatum = '2021-11-14 00:00:00.000'
--The EXECUTE permission was denied on the object 'STP_DeleteMedischDossier', database 'Somerleyton', schema 'dbo'.

REVERT

-- | T 7.3 | Een verzorger heeft geen directe toegang tot tabellen. |
EXECUTE AS LOGIN = 'VerzorgerLogin'

SELECT *
FROM DIER
-- The SELECT permission was denied on the object 'DIER', database 'Somerleyton', schema 'dbo'.

DELETE 
FROM DIER
-- The DELETE permission was denied on the object 'DIER', database 'Somerleyton', schema 'dbo'.

INSERT INTO VERBLIJF(GEBIEDNAAM)
VALUES('TEST')
-- The INSERT permission was denied on the object 'VERBLIJF', database 'Somerleyton', schema 'dbo'.

REVERT

----------------------------------------- Hoofdverzorger ----------------------------------------
-- CREATE Hoofdverzorger user
CREATE LOGIN [HoofdverzorgerLogin] WITH PASSWORD= 'hoofdverzorger'
CREATE USER [HoofdverzorgerUser] FOR LOGIN [HoofdverzorgerLogin] 
GO

-- CREATE Hoofdverzorger Role
CREATE ROLE HoofdverzorgerRole
GO

ALTER ROLE [HoofdverzorgerRole] ADD MEMBER [HoofdverzorgerUser]
GO

-- Hoofdverzorger toegang geven tot de juiste stored procedure
-- UC 1.1	Nieuw dier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDier    
TO HoofdverzorgerRole;  
GO  

-- UC 1.2	Nieuw gebied toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertGebied 
TO HoofdverzorgerRole;  
GO 

-- UC 1.3	Nieuw verblijf toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertVerblijf
TO HoofdverzorgerRole;  
GO  

-- UC 1.4	Nieuwe diereninformatie toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDiersoort    
TO HoofdverzorgerRole;  
GO  

-- UC 1.5	Nieuw fokdossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertFokdossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.6	Nieuw uitleendossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertUitleenDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.7	Nieuw uitzetdossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertUitzetDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.8	Dier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDier
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDier
TO HoofdverzorgerRole;  
GO  

-- UC 1.9	Gebied aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateGebied
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteGebied
TO HoofdverzorgerRole;  
GO  

-- UC 1.10	Verblijf aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateVerblijf
TO HoofdverzorgerRole;  
GO 

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteVerblijf
TO HoofdverzorgerRole;  
GO 

-- UC 1.11	Diereninformatie aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDiersoort
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDiersoort
TO HoofdverzorgerRole;  
GO  

-- UC 1.12	Fokdossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateFokDossier
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteFokDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.13	Uitleendossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateUitleenDossier
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteUitleenDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.14	Uitzetdossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateUitzetDossier
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteUitzetDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.15	Uitdraaisel maken van diereninformatie
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitdraaisel
TO HoofdverzorgerRole;  
GO  

-- UC 1.16	Data ophalen van dier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDier
TO HoofdverzorgerRole;  
GO  

-- UC 1.17	Data ophalen van gebied
GRANT EXECUTE ON OBJECT::dbo.STP_SelectGebied
TO HoofdverzorgerRole;  
GO  

-- UC 1.18	Data ophalen van verblijf
GRANT EXECUTE ON OBJECT::dbo.STP_SelectVerblijf
TO HoofdverzorgerRole;  
GO  

-- UC 1.19	Data ophalen van diersoorten
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDiersoort
TO HoofdverzorgerRole;  
GO

-- UC 1.20	Data ophalen van fokdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectFokDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.21	Data ophalen van uitleendossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitleenDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.22	Data ophalen van uitzetdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitzetDossier
TO HoofdverzorgerRole;  
GO  

-- UC 1.29 Nieuwe voedingsinformatie toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDieetInformatie
TO HoofdverzorgerRole;  
GO  

-- UC 1.30	Ontvangen goederen toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertOntvangenGoederen
TO HoofdverzorgerRole;  
GO  

-- UC 1.31 Voedingsinformatie aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDieetinformatie
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDieetinformatie
TO HoofdverzorgerRole;  
GO  

-- UC 1.32	Data ophalen van voedingsinformatie
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDieetInformatie
TO HoofdverzorgerRole;  
GO  

-- UC 1.33	Ontvangen goederen aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateOntvangenGoederen
TO HoofdverzorgerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteOntvangenGoederen
TO HoofdverzorgerRole;  
GO  

-- UC 1.34	Data ophalen van ontvangen goederen
GRANT EXECUTE ON OBJECT::dbo.STP_SelectLeveringControle
TO HoofdverzorgerRole;  
GO  

-- TEST User Hoofdverzorger

-- | T 7.4 | Een hoofdverzorger kan zijn stored procedures uitvoeren. |
EXECUTE AS LOGIN = 'HoofdverzorgerLogin'

EXEC STP_SelectFokDossier

EXEC STP_SelectUitzetDossier

EXEC STP_SelectDier

REVERT

-- | T 7.5 | Een hoofdverzorger kan niet andere stored procedures uitvoeren. |
EXECUTE AS LOGIN = 'HoofdverzorgerLogin'

EXEC STP_SelectMedischDossier
-- The EXECUTE permission was denied on the object 'STP_SelectMedischDossier', database 'Somerleyton', schema 'dbo'.

EXEC STP_DeleteFunctie 
	@Functie = 'Dierenarts'
--The EXECUTE permission was denied on the object 'STP_DeleteFunctie', database 'Somerleyton', schema 'dbo'.

REVERT

-- | T 7.6 | Een hoofdverzorger heeft geen directe toegang tot tabellen. |
EXECUTE AS LOGIN = 'HoofdverzorgerLogin'

SELECT *
FROM DIERENTUIN
-- The SELECT permission was denied on the object 'DIERENTUIN', database 'Somerleyton', schema 'dbo'.

DELETE
FROM MEDEWERKER
-- The DELETE permission was denied on the object 'MEDEWERKER', database 'Somerleyton', schema 'dbo'.

INSERT INTO MEDEWERKER(VOORNAAM, ACHTERNAAM, FUNCTIE)
VALUES('Test', 'Moet Falen', 'Dierenarts')
-- The INSERT permission was denied on the object 'MEDEWERKER', database 'Somerleyton', schema 'dbo'.

UPDATE DIER
SET STATUS = 'Overleden'
WHERE DIERID = 'COL-001'
--The UPDATE permission was denied on the object 'DIER', database 'Somerleyton', schema 'dbo'.

REVERT

---------------------------------------- Kantoormedewerker --------------------------------------
-- CREATE Kantoormedewerker user
CREATE LOGIN [KantoormedewerkerLogin] WITH PASSWORD= 'kantoormedewerker'
CREATE USER [KantoormedewerkerUser] FOR LOGIN [KantoormedewerkerLogin] 
GO

-- CREATE Kantoormedewerker Role
CREATE ROLE KantoormedewerkerRole
GO

ALTER ROLE [KantoormedewerkerRole] ADD MEMBER [KantoormedewerkerUser]
GO

--Kantoormedewerker toegang geven tot de juiste stored procedure
-- UC 1.1	Nieuw dier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDier    
TO KantoormedewerkerRole;  
GO  

-- UC 1.2	Nieuw gebied toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertGebied 
TO KantoormedewerkerRole;  
GO 

-- UC 1.3	Nieuw verblijf toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertVerblijf
TO KantoormedewerkerRole;  
GO  

-- UC 1.4	Nieuwe diereninformatie toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDiersoort    
TO KantoormedewerkerRole;  
GO  

-- UC 1.5	Nieuw fokdossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertFokdossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.6	Nieuw uitleendossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertUitleenDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.7	Nieuw uitzetdossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertUitzetDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.8	Dier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDier
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDier
TO KantoormedewerkerRole;  
GO  

-- UC 1.9	Gebied aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateGebied
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteGebied
TO KantoormedewerkerRole;  
GO  

-- UC 1.10	Verblijf aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateVerblijf
TO KantoormedewerkerRole;  
GO 

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteVerblijf
TO KantoormedewerkerRole;  
GO 

-- UC 1.11	Diereninformatie aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateDiersoort
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteDiersoort
TO KantoormedewerkerRole;  
GO  

-- UC 1.12	Fokdossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateFokDossier
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteFokDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.13	Uitleendossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateUitleenDossier
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteUitleenDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.14	Uitzetdossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateUitzetDossier
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteUitzetDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.15	Uitdraaisel maken van diereninformatie
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitdraaisel
TO KantoormedewerkerRole;  
GO  

-- UC 1.16	Data ophalen van dier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDier
TO KantoormedewerkerRole;  
GO  

-- UC 1.17	Data ophalen van gebied
GRANT EXECUTE ON OBJECT::dbo.STP_SelectGebied
TO KantoormedewerkerRole;  
GO  

-- UC 1.18	Data ophalen van verblijf
GRANT EXECUTE ON OBJECT::dbo.STP_SelectVerblijf
TO KantoormedewerkerRole;  
GO  

-- UC 1.19	Data ophalen van diersoorten
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDiersoort
TO KantoormedewerkerRole;  
GO

-- UC 1.20	Data ophalen van fokdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectFokDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.21	Data ophalen van uitleendossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitleenDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.22	Data ophalen van uitzetdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectUitzetDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.23	Nieuwe spotting toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertGespot
TO KantoormedewerkerRole;  
GO  

-- UC 1.24	Spotting aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateGespot
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteGespot
TO KantoormedewerkerRole;  
GO  

-- UC 1.25	Data ophalen van spotting
GRANT EXECUTE ON OBJECT::dbo.STP_SelectSpotting
TO KantoormedewerkerRole;  
GO  

-- UC 1.28	Data ophalen van medischdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectMedischDossier
TO KantoormedewerkerRole;  
GO  

-- UC 1.30	Ontvangen goederen toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertOntvangenGoederen
TO KantoormedewerkerRole;  
GO  

-- UC 1.32	Data ophalen van voedingsinformatie
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDieetInformatie
TO KantoormedewerkerRole;  
GO  

-- UC 1.33	Ontvangen goederen aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateOntvangenGoederen
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteOntvangenGoederen
TO KantoormedewerkerRole;  
GO  

-- UC 1.34	Data ophalen van ontvangen goederen
GRANT EXECUTE ON OBJECT::dbo.STP_SelectLeveringControle
TO KantoormedewerkerRole;  
GO  

-- UC 1.35	Nieuwe bestelling toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertBestelling
TO KantoormedewerkerRole;  
GO  

-- UC 1.36	Bestelling als betaald zetten
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateStatusBestelling
TO KantoormedewerkerRole;  
GO  

-- UC 1.37	Bestelling aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateBestelling
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteBestelling
TO KantoormedewerkerRole;  
GO  

-- UC 1.38	Bestellingvoedsel aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateBestellingRegel
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteBestellingRegel
TO KantoormedewerkerRole;  
GO  

-- UC 1.39	Data ophalen van bestelling
GRANT EXECUTE ON OBJECT::dbo.STP_SelectBestelling
TO KantoormedewerkerRole;  
GO  

-- UC 1.40	Ophalen status van bestelling
GRANT EXECUTE ON OBJECT::dbo.STP_SelectBestellingStatus
TO KantoormedewerkerRole;  
GO  

-- UC 1.41	De hoofdverzorger van een gebied aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateHoofdverzorger
TO KantoormedewerkerRole;  
GO  

-- UC 1.42	Het gebied van een verzorger aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateGebiedVerzorger
TO KantoormedewerkerRole;  
GO  

-- UC 1.43	Data ophalen van een medewerker
GRANT EXECUTE ON OBJECT::dbo.STP_SelectMedewerker
TO KantoormedewerkerRole;  
GO  

-- UC 1.44	Nieuwe leverancier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertLeverancier
TO KantoormedewerkerRole;  
GO  

-- UC 1.45	Leverancier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateLeveranciers
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteLeverancier
TO KantoormedewerkerRole;  
GO  

-- UC 1.46	Data ophalen van leverancier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectLeverancier
TO KantoormedewerkerRole;  
GO  

-- UC 1.47	Data ophalen van over voedselsoorten
GRANT SELECT ON OBJECT::dbo.VW_SelectVoedsel
TO KantoormedewerkerRole;  
GO  

-- UC 1.48	Nieuwe voedselsoorten toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertVoedsel
TO KantoormedewerkerRole;  
GO  

-- UC 1.49	Data ophalen van functies
GRANT SELECT ON OBJECT::dbo.VW_SelectFuncties
TO KantoormedewerkerRole;  
GO  

-- UC 1.50	Nieuwe functie toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertFuncties
TO KantoormedewerkerRole;  
GO  

-- UC 1.51	Voedselsoorten aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateVoedselsoort
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteVoedsel
TO KantoormedewerkerRole;  
GO  

-- UC 1.52	Functies aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_UpdateFuncties
TO KantoormedewerkerRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteFunctie
TO KantoormedewerkerRole;  
GO  

-- UC 1.53	Nieuwe medewerker toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertMedewerker
TO KantoormedewerkerRole;  
GO  

-- TEST User Kantoormedewerker

-- | T 7.7 | Een kantoormedewerker kan zijn stored procedures uitvoeren.  
EXECUTE AS LOGIN = 'KantoormedewerkerLogin'

EXEC STP_SelectMedewerker

EXEC STP_SelectBestelling

EXEC STP_SelectDier

REVERT

-- | T 7.8 | Een kantoormedewerker kan niet andere stored procedures uitvoeren.  
EXECUTE AS LOGIN = 'KantoormedewerkerLogin'

EXEC STP_UpdateDieetinformatie 
	@OudDierId = 'CAN-001',
	@OudVoedselSoort = 'Gecondenseerde Melk',
	@OudStartDatum = '26-NOV-2005',
	@HoeveelheidPerDag = '2,3',
	@Eenheid = 'Liter',
	@NieuwVoedselsoort = 'Banaan'
-- The EXECUTE permission was denied on the object 'STP_UpdateDieetinformatie', database 'Somerleyton', schema 'dbo'.

EXEC STP_InsertDieetInformatie
	@DierId = 'CAN-001',
	@VoedselSoort = 'Gecondenseerde Melk',
	@StartDatum = '26-NOV-2005',
	@HoeveelheidPerDag = '2,3',
	@Eenheid = 'Liter'
-- The EXECUTE permission was denied on the object 'STP_InsertDieetInformatie', database 'Somerleyton', schema 'dbo'.

REVERT

--| T 7.9 | Een kantoormedewerker heeft geen directe toegang tot tabellen.
EXECUTE AS LOGIN = 'KantoormedewerkerLogin'

SELECT *
FROM DIER
-- The SELECT permission was denied on the object 'DIER', database 'Somerleyton', schema 'dbo'.

DELETE
FROM MEDEWERKER
-- The DELETE permission was denied on the object 'MEDEWERKER', database 'Somerleyton', schema 'dbo'.

UPDATE Gebied
SET GEBIEDNAAM = 'Afrika'
-- The UPDATE permission was denied on the object 'GEBIED', database 'Somerleyton', schema 'dbo'.

INSERT GESPOT
VALUES ('CYP-004', '3-SEP-2012', '9-DEC-2013', 'Nijmegen')
-- The INSERT permission was denied on the object 'GESPOT', database 'Somerleyton', schema 'dbo'.

REVERT

------------------------------------------ Dierenarts -------------------------------------------
--CREATE Dierenarts user
CREATE LOGIN [DierenartsLogin] WITH PASSWORD= 'dierenarts'
CREATE USER [DierenartsUser] FOR LOGIN [DierenartsLogin] 
GO

--CREATE Dierenarts Role
CREATE ROLE DierenartsRole
GO

ALTER ROLE [DierenartsRole] ADD MEMBER [DierenartsUser]
GO

--Dierenarts toegang geven tot de juiste stored procedure

-- UC 1.16	Data ophalen van dier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectDier
TO DierenartsRole;  
GO  

-- UC 1.26 Medisch dossier toevoegen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertMedischDossier
TO DierenartsRole;  
GO  

-- UC 1.27 Medisch dossier aanpassen
GRANT EXECUTE ON OBJECT::dbo.STP_InsertDiagnoses
TO DierenartsRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_UpdateMedischDossier
TO DierenartsRole;  
GO  

GRANT EXECUTE ON OBJECT::dbo.STP_DeleteMedischDossier
TO DierenartsRole;  
GO  

-- UC 1.28	Data ophalen van medischdossier
GRANT EXECUTE ON OBJECT::dbo.STP_SelectMedischDossier
TO DierenartsRole;  
GO  

-- | T 7.10 | Een dierenarts kan zijn stored procedures uitvoeren.  
EXECUTE AS LOGIN = 'DierenartsLogin'

EXEC STP_SelectDier
GO

EXEC STP_SelectMedischDossier
GO

EXEC STP_InsertMedischDossier
	@DierID = 'COL-007',
	@ControleDatum = '10-JAN-2022',
	@MedewerkerID = '11'
GO

EXEC STP_DeleteMedischDossier
	@DierID = 'COL-007',
	@ControleDatum = '10-JAN-2022'
GO

REVERT

-- | T 7.11 | Een dierenarts kan niet andere stored procedures uitvoeren. |
EXECUTE AS LOGIN = 'DierenartsLogin'

EXEC STP_SelectMedewerker
-- The EXECUTE permission was denied on the object 'STP_SelectMedewerker', database 'Somerleyton', schema 'dbo'.

EXEC STP_SelectBestelling
-- The EXECUTE permission was denied on the object 'STP_SelectBestelling', database 'Somerleyton', schema 'dbo'.

EXEC STP_DeleteDier
	@DierID = 'COL-007'
-- The EXECUTE permission was denied on the object 'STP_DeleteDier', database 'Somerleyton', schema 'dbo'.

REVERT

-- | T 7.12 | Een dierenarts heeft geen directe toegang tot tabellen. |
EXECUTE AS LOGIN = 'DierenartsLogin'

SELECT *
FROM MEDISCHDOSSIER
-- The SELECT permission was denied on the object 'MEDISCHDOSSIER', database 'Somerleyton', schema 'dbo'.

DELETE 
FROM DIAGNOSES
-- The DELETE permission was denied on the object 'DIAGNOSES', database 'Somerleyton', schema 'dbo'.

INSERT INTO MEDEWERKER(VOORNAAM, ACHTERNAAM, FUNCTIE)
VALUES('Test', 'Achternaam', 'Dierenarts')
-- The INSERT permission was denied on the object 'MEDEWERKER', database 'Somerleyton', schema 'dbo'.

UPDATE DIER
SET STATUS = 'Overleden'
WHERE DIERID = 'COL-007'
-- The UPDATE permission was denied on the object 'DIER', database 'Somerleyton', schema 'dbo'.

REVERT

--------------------------------------------- Admin ---------------------------------------------
/*enable 'SQL Server and Windows authentication mode' in SQL Server.
Without enabling it any SQL login will not be allowed to login.
It is under general -> Security */

CREATE LOGIN SomerleytonAdmin WITH PASSWORD ='ENTERSTRONGPASSWORD';
GO

CREATE USER SomerleytonAdmin FOR LOGIN SomerleytonAdmin;  
GO   

EXEC sp_addsrvrolemember 'SomerleytonAdmin','sysadmin';
GO

-- | T 7.13 | De Admin rol heeft toegang tot alle stored procedures en tabellen. |
EXECUTE AS LOGIN = 'SomerleytonAdmin'

SELECT *
FROM DIER

EXEC STP_SelectDier
GO

SELECT *
FROM MEDEWERKER
GO

EXEC STP_UpdateGebiedVerzorger
	@MedewerkerID = '2',
	@GebiedNaam = 'Vlindertuin'
GO

UPDATE MEDEWERKER
SET GEBIEDNAAM = 'Savanne'
WHERE MEDEWERKERID = '2'
GO

REVERT