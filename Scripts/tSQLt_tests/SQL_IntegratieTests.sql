-- Integratietest Bestelling
EXEC STP_InsertBestelling 
	@LeverancierNaam = 'Mapleton Zoological Supplies', 
	@BestelDatum = '10-JAN-2022'

DECLARE @BestellingNummer INT
SET @BestellingNummer = @@IDENTITY

EXEC STP_InsertBestellingRegel 
	@BestellingID = @BestellingNummer, 
	@VoedselSoort = 'Witlof', 
	@BesteldeHoeveelheid = '500', 
	@Prijs = '£0.64', 
	@Eenheid = 'Kilogram'
EXEC STP_InsertBestellingRegel 
	@BestellingID = @BestellingNummer, 
	@VoedselSoort = 'Radijs',
	@BesteldeHoeveelheid = '800', 
	@Prijs = '£0.98', 
	@Eenheid = 'Kilogram'
EXEC STP_InsertOntvangenGoederen 
	@BestellingID = 4, 
	@VoedselSoort = 'Witlof', 
	@OntvangDatumTijd = '14-JAN-2022', 
	@OntvangenHoeveelheid = '500', 
	@VerwachteHoeveelheid = '500',
	@Eenheid = 'Kilogram'
EXEC STP_InsertOntvangenGoederen
	@BestellingID = 4, 
	@VoedselSoort = 'Radijs', 
	@OntvangDatumTijd = '14-JAN-2022', 
	@OntvangenHoeveelheid = '800', 
	@VerwachteHoeveelheid = '800',
	@Eenheid = 'Kilogram'
EXEC STP_UpdateStatusBestelling @BestellingID = 4, @BestelStatus = 'Betaling_Nodig'
EXEC STP_UpdateStatusBestelling @BestellingID = 4, @BestelStatus = 'Betaald'

SELECT * FROM BESTELLING WHERE BESTELLINGID = 4
SELECT * FROM BESTELLINGREGEL WHERE BESTELLINGID = 4
SELECT * FROM LEVERINGCONTROLE WHERE BESTELLINGID = 4

-- Integratietest Dier
EXEC STP_InsertFokdossier
	@FokDier = 'PAN-002',
	@FokPartner = 'PAN-001',
	@FokDatum = '16-JUN-2015',
	@FokPlaats = 'Somerleyton Animal Park'
EXEC STP_InsertDier
	@DIERID = 'PAN-004',
	@GEBIEDNAAM = 'Savanne',
	@VERBLIJFID = 1,
	@DIERSOORT = 'Panthera Leo',
	@FOKID = @@IDENTITY,
	@DIERNAAM = 'Simba',
	@GESLACHT = 'M',
	@GEBOORTEPLAATS	= 'Somerleyton',
	@GEBOORTELAND = 'Verenigd Koninkrijk',
	@GEBOORTEDATUM = '15-FEB-2016',
	@STATUS = 'Aanwezig'
EXEC STP_InsertDieetInformatie
	@DierId = 'PAN-004',
	@VoedselSoort = 'Gecondenseerde Melk',
	@StartDatum = '15-FEB-2016',
	@HoeveelheidPerDag = '0.75',	
	@Eenheid = 'Liter'	
EXEC STP_InsertDieetInformatie
	@DierId = 'PAN-004',
	@VoedselSoort = 'Pens',
	@StartDatum = '12-MAR-2016',
	@HoeveelheidPerDag = '1.25',	
	@Eenheid = 'Kilogram'

EXEC STP_InsertMedischDossier
	@DierID = 'PAN-004',
	@ControleDatum = '18-FEB-2016',
	@MedewerkerID = '12',
	@VolgendeControle = '18-MAR-2016'
EXEC STP_InsertDiagnoses
	@DierID = 'PAN-004',
	@ControleDatum = '18-FEB-2016',
	@Diagnose = 'Gezond en Wel',
	@Voorschrift = NULL

EXEC STP_InsertUitleenDossier
	@DierID = 'PAN-004',
	@UitleenDatum = '08-APR-2018',
	@UitlenendeDierentuin = 'Somerleyton Animal Park',
	@OntvangendeDierentuin = 'Artis',
	@TerugkeerDatum = '08-APR-2019',
	@UitleenOpmerking = 'Als deel van Fokprogramma PLN727'
EXEC STP_UpdateDier
	@OudDierID = 'PAN-004',
	@DierID	= 'PAN-004',
	@Diersoort = 'Panthera Leo',
	@DierNaam = 'Simba',
	@Geslacht = 'M',
	@Status	= 'Afwezig'

EXEC STP_InsertDier
	@DIERID = 'ART-LEO-023',
	@GEBIEDNAAM = NULL,
	@VERBLIJFID = NULL,
	@DIERSOORT = 'Panthera Leo',
	@FOKID = NULL,
	@DIERNAAM = 'Nala',
	@GESLACHT = 'F',
	@GEBOORTEPLAATS	= 'Artis',
	@GEBOORTELAND = 'Nederland',
	@GEBOORTEDATUM = '28-APR-2016',
	@STATUS = 'Afwezig'

EXEC STP_InsertFokdossier
	@FokDier = 'ART-LEO-023',
	@FokPartner = 'PAN-004',
	@FokDatum = '28-OCT-2018',
	@FokPlaats = 'Artis'

EXEC STP_InsertUitzetDossier
	@DierID = 'PAN-004',
	@UitzetDatum = '24-DEC-2020',
	@UitzetLocatie = 'National Nature Reserve of Namibia',
	@UitzetProgramma = 'PLR2643',
	@UitzetOpmerking = 'Geen bijzonderheden'
EXEC STP_InsertGespot
	@DierId = 'PAN-004',
	@UitzetDatum = '24-DEC-2020',
	@SpotDatum = '02-APR-2021',
	@SpotLocatie = 'Rond Waterberg Plateau National Park'

SELECT * FROM DIER WHERE DIERID = 'PAN-004'
SELECT * FROM DIEETINFORMATIE WHERE DIERID = 'PAN-004'
SELECT * FROM MEDISCHDOSSIER WHERE DIERID = 'PAN-004'
SELECT * FROM DIAGNOSES WHERE DIERID = 'PAN-004'
SELECT * FROM UITLEENDOSSIER WHERE DIERID = 'PAN-004'
SELECT * FROM FOKDOSSIER WHERE FOKPARTNER = 'PAN-004'
SELECT * FROM UITZETDOSSIER WHERE DIERID = 'PAN-004'
SELECT * FROM GESPOT WHERE DIERID = 'PAN-004'