/* Setupscript Somerleyton DB

Inhoud:
1. SQL CreateDB Somerleyton (23)
2. SQL Testdata Somerleyton (468)
3. SQL Foreign Keys Somerleyton (779)
4. Domein Constraints (999)
5. Integrity Rules (1049)
6. Use Cases Insert (1901)
7. Use Cases Select (3093)
8. Use Cases Update (3846)
9. Use Cases Delete (4929)
*/

/* Drop Database voor gemakkelijke reset

USE master
DROP DATABASE IF EXISTS Somerleyton
CREATE DATABASE Somerleyton
USE Somerleyton
*/

/* ==================================================
= SQL CreateDB Somerleyton             			        =
================================================== */
/*==============================================================*/
/* Domain: ADRES                                                */
/*==============================================================*/
create type ADRES
   from varchar(64)
go

/*==============================================================*/
/* Domain: BESTELSTATUS                                         */
/*==============================================================*/
create type BESTELSTATUS
   from varchar(16)
go

/*==============================================================*/
/* Domain: DATUM                                                */
/*==============================================================*/
create type DATUM
   from datetime
go

/*==============================================================*/
/* Domain: DATUMTIJD                                            */
/*==============================================================*/
create type DATUMTIJD
   from datetime
go

/*==============================================================*/
/* Domain: DIAGNOSE                                             */
/*==============================================================*/
create type DIAGNOSE
   from varchar(128)
go

/*==============================================================*/
/* Domain: DIERID                                               */
/*==============================================================*/
create type DIERID
   from varchar(32)
go

/*==============================================================*/
/* Domain: DIERSTATUS                                           */
/*==============================================================*/
create type DIERSTATUS
   from varchar(32)
go

/*==============================================================*/
/* Domain: EDUTEKST                                             */
/*==============================================================*/
create type EDUTEKST
   from varchar(MAX)
go

/*==============================================================*/
/* Domain: EENHEID                                              */
/*==============================================================*/
create type EENHEID
   from varchar(16)
go

/*==============================================================*/
/* Domain: FUNCTIE                                              */
/*==============================================================*/
create type FUNCTIE
   from varchar(32)
go

/*==============================================================*/
/* Domain: GESLACHT                                             */
/*==============================================================*/
create type GESLACHT
   from char(1)
go

/*==============================================================*/
/* Domain: GEWICHT                                              */
/*==============================================================*/
create type GEWICHT
   from varchar(32)
go

/*==============================================================*/
/* Domain: ID                                                   */
/*==============================================================*/
create type ID
   from int
go

/*==============================================================*/
/* Domain: LAND                                                 */
/*==============================================================*/
create type LAND
   from varchar(56)
go

/*==============================================================*/
/* Domain: LEEFTIJD                                             */
/*==============================================================*/
create type LEEFTIJD
   from varchar(32)
go

/*==============================================================*/
/* Domain: LINK                                                 */
/*==============================================================*/
create type LINK
   from varchar(512)
go

/*==============================================================*/
/* Domain: LOCATIE                                              */
/*==============================================================*/
create type LOCATIE
   from varchar(256)
go

/*==============================================================*/
/* Domain: NAAM                                                 */
/*==============================================================*/
create type NAAM
   from varchar(64)
go

/*==============================================================*/
/* Domain: OVERIGEOPMERKING                                     */
/*==============================================================*/
create type OVERIGEOPMERKING
   from varchar(512)
go

/*==============================================================*/
/* Domain: PLAATS                                               */
/*==============================================================*/
create type PLAATS
   from varchar(85)
go

/*==============================================================*/
/* Domain: PREFIX                                               */
/*==============================================================*/
create type PREFIX
   from varchar(4)
go

/*==============================================================*/
/* Domain: PRIJS                                                */
/*==============================================================*/
create type PRIJS
   from money
go

/*==============================================================*/
/* Domain: PROGRAMMANUMMER                                      */
/*==============================================================*/
create type PROGRAMMANUMMER
   from varchar(8)
go

/*==============================================================*/
/* Domain: VOEDSELHOEVEELHEID                                   */
/*==============================================================*/
create type VOEDSELHOEVEELHEID
   from float(12)
go

/*==============================================================*/
/* Domain: VOEDSELNAAM                                          */
/*==============================================================*/
create type VOEDSELNAAM
   from varchar(32)
go

/*==============================================================*/
/* Domain: VOORSCHRIFT                                          */
/*==============================================================*/
create type VOORSCHRIFT
   from varchar(32)
go

/*==============================================================*/
/* Table: BESTELLING                                            */
/*==============================================================*/
create table BESTELLING (
   BESTELLINGID         ID                   identity,
   LEVERANCIERNAAM      NAAM                 not null,
   BESTELDATUM          DATUM                not null,
   BESTELSTATUS         BESTELSTATUS         not null,
   BETAALDATUM          DATUM                null,
   constraint PK_BESTELLING primary key (BESTELLINGID)
)
go

/*==============================================================*/
/* Table: BESTELLINGREGEL                                       */
/*==============================================================*/
create table BESTELLINGREGEL (
   BESTELLINGID         ID                   not null,
   VOEDSELSOORT         VOEDSELNAAM          not null,
   BESTELDEHOEVEELHEID  VOEDSELHOEVEELHEID   not null,
   PRIJS                PRIJS                not null,
   EENHEID              EENHEID              not null,
   constraint PK_BESTELLINGREGEL primary key (BESTELLINGID, VOEDSELSOORT)
)
go

/*==============================================================*/
/* Table: DIAGNOSES                                             */
/*==============================================================*/
create table DIAGNOSES (
   OBSERVATIEID         ID                   identity,
   DIERID               DIERID               not null,
   CONTROLEDATUM        DATUM                not null,
   DIAGNOSE             DIAGNOSE             null,
   VOORSCHRIFT          VOORSCHRIFT          null,
   constraint PK_DIAGNOSES primary key (OBSERVATIEID)
)
go

/*==============================================================*/
/* Table: DIEETINFORMATIE                                       */
/*==============================================================*/
create table DIEETINFORMATIE (
   DIERID               DIERID               not null,
   VOEDSELSOORT         VOEDSELNAAM          not null,
   STARTDATUM           DATUM                not null,
   HOEVEELHEIDPERDAG    VOEDSELHOEVEELHEID   not null,
   EENHEID              EENHEID              not null,
   constraint PK_DIEETINFORMATIE primary key (DIERID, VOEDSELSOORT, STARTDATUM)
)
go

/*==============================================================*/
/* Table: DIER                                                  */
/*==============================================================*/
create table DIER (
   DIERID               DIERID               not null,
   GEBIEDNAAM           NAAM                 null,
   VERBLIJFID           ID                   null,
   DIERSOORT            NAAM                 not null,
   FOKID                ID                   null,
   DIERNAAM             NAAM                 not null,
   GESLACHT             GESLACHT             not null,
   GEBOORTEPLAATS       PLAATS               null,
   GEBOORTELAND         LAND                 null,
   GEBOORTEDATUM        DATUM                null,
   STATUS               DIERSTATUS           not null,
   constraint PK_DIER primary key (DIERID)
)
go

/*==============================================================*/
/* Table: DIERENTUIN                                            */
/*==============================================================*/
create table DIERENTUIN (
   DIERENTUINNAAM       NAAM                 not null,
   DIERENTUINPREFIX     PREFIX               not null,
   PLAATS               PLAATS               null,
   LAND                 LAND                 null,
   HOOFDVERANTWOORDELIJKE NAAM                 null,
   CONTACTINFORMATIE    OVERIGEOPMERKING     null,
   constraint PK_DIERENTUIN primary key (DIERENTUINNAAM)
)
go

/*==============================================================*/
/* Table: DIERSOORT                                             */
/*==============================================================*/
create table DIERSOORT (
   LATIJNSENAAM         NAAM                 not null,
   NORMALENAAM          NAAM                 null,
   EDUTEKST             EDUTEKST             null,
   FOTO                 LINK                 null,
   constraint PK_DIERSOORT primary key (LATIJNSENAAM)
)
go

/*==============================================================*/
/* Table: EENHEDEN                                              */
/*==============================================================*/
create table EENHEDEN (
   EENHEID              EENHEID              not null,
   constraint PK_EENHEDEN primary key (EENHEID)
)
go

/*==============================================================*/
/* Table: FOKDOSSIER                                            */
/*==============================================================*/
create table FOKDOSSIER (
   FOKID                ID                   identity,
   FOKDIER              DIERID               not null,
   FOKPARTNER           DIERID               null,
   FOKDATUM             DATUM                null,
   FOKPLAATS            PLAATS               null,
   constraint PK_FOKDOSSIER primary key (FOKID)
)
go

/*==============================================================*/
/* Table: FUNCTIES                                              */
/*==============================================================*/
create table FUNCTIES (
   FUNCTIE              FUNCTIE              not null,
   constraint PK_FUNCTIES primary key (FUNCTIE)
)
go

/*==============================================================*/
/* Table: GEBIED                                                */
/*==============================================================*/
create table GEBIED (
   GEBIEDNAAM           NAAM                 not null,
   HOOFDVERZORGER       ID                   not null,
   constraint PK_GEBIED primary key (GEBIEDNAAM)
)
go

/*==============================================================*/
/* Table: GESPOT                                                */
/*==============================================================*/
create table GESPOT (
   DIERID               DIERID               not null,
   UITZETDATUM          DATUM                not null,
   SPOTDATUM            DATUM                not null,
   SPOTLOCATIE          LOCATIE              not null,
   constraint PK_GESPOT primary key (SPOTDATUM, DIERID, UITZETDATUM)
)
go

/*==============================================================*/
/* Table: LEVERANCIER                                           */
/*==============================================================*/
create table LEVERANCIER (
   LEVERANCIERNAAM      NAAM                 not null,
   LEVERANCIERPLAATS    PLAATS               null,
   LEVERANCIERADRES     ADRES                null,
   CONTACTINFORMATIE    OVERIGEOPMERKING     null,
   constraint PK_LEVERANCIER primary key (LEVERANCIERNAAM)
)
go

/*==============================================================*/
/* Table: LEVERINGCONTROLE                                      */
/*==============================================================*/
create table LEVERINGCONTROLE (
   BESTELLINGID         ID                   not null,
   VOEDSELSOORT         VOEDSELNAAM          not null,
   ONTVANGDATUMTIJD     DATUMTIJD            not null,
   ONTVANGENHOEVEELHEID VOEDSELHOEVEELHEID   not null,
   VERWACHTEHOEVEELHEID VOEDSELHOEVEELHEID   not null,
   EENHEID              EENHEID              not null,
   constraint PK_LEVERINGCONTROLE primary key (BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD)
)
go

/*==============================================================*/
/* Table: MEDEWERKER                                            */
/*==============================================================*/
create table MEDEWERKER (
   MEDEWERKERID         ID                   identity,
   GEBIEDNAAM           NAAM                 null,
   VOORNAAM             NAAM                 not null,
   ACHTERNAAM           NAAM                 not null,
   FUNCTIE              FUNCTIE              not null,
   constraint PK_MEDEWERKER primary key (MEDEWERKERID)
)
go

/*==============================================================*/
/* Table: MEDISCHDOSSIER                                        */
/*==============================================================*/
create table MEDISCHDOSSIER (
   DIERID               DIERID               not null,
   CONTROLEDATUM        DATUM                not null,
   MEDEWERKERID         ID                   not null,
   VOLGENDECONTROLE     DATUM                null,
   constraint PK_MEDISCHDOSSIER primary key (DIERID, CONTROLEDATUM)
)
go

/*==============================================================*/
/* Table: SEKSUEELDIMORFISME                                    */
/*==============================================================*/
create table SEKSUEELDIMORFISME (
   LATIJNSENAAM         NAAM                 not null,
   GESLACHT             GESLACHT             not null,
   VOLWASSENLEEFTIJD    LEEFTIJD             null,
   VOLWASSENGEWICHT     GEWICHT              null,
   OVERIGEKENMERKEN     OVERIGEOPMERKING     null,
   constraint PK_SEKSUEELDIMORFISME primary key (LATIJNSENAAM, GESLACHT)
)
go

/*==============================================================*/
/* Table: UITLEENDOSSIER                                        */
/*==============================================================*/
create table UITLEENDOSSIER (
   DIERID               DIERID               not null,
   UITLEENDATUM         DATUM                not null,
   UITLENENDEDIERENTUIN NAAM                 not null,
   ONTVANGENDEDIERENTUIN NAAM                 not null,
   TERUGKEERDATUM       DATUM                null,
   UITLEENOPMERKING     OVERIGEOPMERKING     null,
   constraint PK_UITLEENDOSSIER primary key (DIERID, UITLEENDATUM)
)
go

/*==============================================================*/
/* Table: UITZETDOSSIER                                         */
/*==============================================================*/
create table UITZETDOSSIER (
   DIERID               DIERID               not null,
   UITZETDATUM          DATUM                not null,
   UITZETLOCATIE        LOCATIE              not null,
   UITZETPROGRAMMA      PROGRAMMANUMMER      null,
   UITZETOPMERKING      OVERIGEOPMERKING     null,
   constraint PK_UITZETDOSSIER primary key (DIERID, UITZETDATUM)
)
go

/*==============================================================*/
/* Table: VERBLIJF                                              */
/*==============================================================*/
create table VERBLIJF (
   GEBIEDNAAM           NAAM                 not null,
   VERBLIJFID           ID                   identity,
   constraint PK_VERBLIJF primary key (GEBIEDNAAM, VERBLIJFID)
)
go

/*==============================================================*/
/* Table: VOEDSEL                                               */
/*==============================================================*/
create table VOEDSEL (
   VOEDSELSOORT         VOEDSELNAAM          not null,
   constraint PK_VOEDSEL primary key (VOEDSELSOORT)
)
go

/* ==================================================
=	SQL Testdata Somerleyton                          =
================================================== */

USE Somerleyton

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

INSERT INTO MEDEWERKER (VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM)
VALUES
('Maxwell', 'Alfaro', 'Parkeigenaar', NULL),
('Eboni', 'Lyons', 'Hoofdverzorger', 'Savanne'),
('Rhiannon', 'Huff', 'Hoofdverzorger', 'Vlindertuin'),
('Bruno', 'Conroy', 'Hoofdverzorger', 'Aquarium'),
('Ronan', 'Ponce', 'Hoofdverzorger', 'Europa & Amerika'),
('Andrei', 'Meyer', 'Verzorger', 'Savanne'),
('Irfan', 'Currie', 'Verzorger', 'Vlindertuin'),
('Rufus', 'Galvan', 'Verzorger', 'Savanne'),
('Richard', 'Bray', 'Verzorger', 'Aquarium'),
('Griffin', 'Draper', 'Verzorger', 'Europa & Amerika'),
('Bella-Rose', 'Harrison', 'Dierenarts', NULL),
('Shae', 'Haigh', 'Dierenarts', NULL),
('Shae', 'Black', 'Dierenarts', NULL),
('Esmay', 'Swift', 'Dierenarts', NULL),
('Ryker', 'Akhtar', 'Team leider', NULL),
('Bryony', 'Mckee', 'Administratief assistent', NULL),
('Talha', 'Holloway', 'Kantoormedewerker', NULL),
('Callen', 'Knox', 'Kantoormedewerker', NULL),
('Clive', 'Potter', 'Kantoormedewerker', NULL),
('Connah', 'Soto', 'Kantoormedewerker', NULL),
('Marwah', 'Barclay', 'Kantoormedewerker', NULL),
('Yousef', 'Tanner', 'Kantoormedewerker', NULL),
('Erica', 'Buchanan', 'Schoonmaker', NULL),
('Dawid', 'Buchanan', 'Restaurantmedewerker', NULL),
('Kadeem', 'Oakley', 'Restaurantmedewerker', NULL),
('Leonie', 'Howe', 'Restaurantmedewerker', NULL),
('Bilaal', 'Bishop', 'Restaurantmedewerker', NULL),
('Nabeel', 'Burns', 'Restaurantmedewerker', NULL)

INSERT INTO DIERSOORT (LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
VALUES
('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae). Van alle katachtigen is enkel de tijger groter. De grootte en de manen van het mannetje geven het dier een imposant uiterlijk, waardoor de leeuw in grote delen van de wereld bekendstaat als de koning der dieren. In Europa heeft hij deze rol overigens pas in de loop van de middeleeuwen overgenomen van de bruine beer. De leeuw is vaak onderwerp van folklore en symboliek geweest. Zo staat de leeuw afgebeeld in de wapens van verscheidene landen, streken en steden, waaronder Nederland, Belgie en Sri Lanka. De leeuw komt nog in bepaalde delen van Afrika voor en in een klein stukje van India, maar vroeger was hij ook algemeen aanwezig in het Midden-Oosten en in Zuidoost-Europa. Leeuwen leven in groepsverband (de enige katachtige die voornamelijk in sociale groepen leeft) en leeuwinnen gaan in de regel samen op jacht, waarmee ze een groter aandeel in de jacht leveren dan de mannetjesleeuwen.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015.jpg'),
('Loxodonta', NULL, NULL, NULL), -- Afrikaanse olifanten
('Centrophorus harrissoni', 'Langsnuitzwelghaai', NULL, NULL),
('Canis lupus', NULL, 'De wolf (Canis lupus), meer specifiek de grijze wolf, is een zoogdier uit de familie hondachtigen (Canidae), die behoort tot de roofdieren (Carnivora). De wolf komt op het noordelijk halfrond voor. Er worden meerdere ondersoorten onderscheiden, waaronder enkele die zijn uitgestorven. De wolf leeft in groepen met een sociale structuur. De wolf is de voorouder van de hond (Canis lupus familiaris). Een wolf en een hond kunnen samen vruchtbare nakomelingen voortbrengen, zodat ze, volgens een gangbaar soortbegrip in de biologie, tot dezelfde soort kunnen worden gerekend.', NULL), -- De wolf
('Torgos tracheliotos', NULL, NULL, 'https://upload.wikimedia.org/wikipedia/commons/7/77/Nubianvulture.jpeg'), -- Oorgier
('Argynnis paphia', 'keizersmantel', 'De keizersmantel (Argynnis paphia) is een vlinder uit de familie Nymphalidae, de vossen, parelmoervlinders en weerschijnvlinders. De keizersmantel is een grote en opvallende vlinder met een vleugellengte van 27 tot 35 mm. Aan de enterhaakvormige vlekken op bovenkant van de vleugels kan men de mannetjes herkennen. De onderkant van de achtervleugel is groenig met zilverkleurige strepen.',NULL),
('Cyprinus carpio', NULL, 'De Europese karper (Cyprinus carpio), ook wel gewoon karper, is een beenvis uit de orde van karperachtigen. De vis kan tot 120 cm lang worden. De karper is herkenbaar aan zijn 4 baarddraden, twee korte op de bovenlip, twee lange in de mondhoeken en de lange rugvin met zeer sterke eerste vinstralen. In de natuur kan hij 30 tot 40 jaar worden.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Cyprinus_carpio_2008_G1_%28cropped%29.jpg/1920px-Cyprinus_carpio_2008_G1_%28cropped%29.jpg'),
('Alligator mississippiensis', 'mississippialligator', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/American_Alligator_at_Lake_Woodruff_-_Flickr_-_Andrea_Westmoreland.jpg/1280px-American_Alligator_at_Lake_Woodruff_-_Flickr_-_Andrea_Westmoreland.jpg'),
('Phoenicopteridae', 'Flamingo', 'De flamingos (Phoenicopteridae) vormen een familie van grote, steltpotige waadvogels. Alle soorten kenmerken zich door hun lange hals, haakvormige snavel en roze verenkleed. De familie telt zes soorten. Vier flamingosoorten komen verspreid voor over Amerika, inclusief het Caribisch gebied, en twee soorten zijn inheems in Afrika, Azie en delen van Europa. De indeling van flamingos was voor lange tijd onduidelijk. Zij zijn meestal ingedeeld bij de ooievaarachtigen, tegenwoordig ook als eigen orde. Aan de hand van DNA-sequencing kon worden vastgesteld dat de flamingos vrij nauw verwant zijn met de futen en wat verder met de duiven. Een nauwe verwantschap met de ooievaars werd niet geconstateerd.','https://upload.wikimedia.org/wikipedia/commons/b/b2/Lightmatter_flamingo.jpg'),
('Colobus guereza', 'Oostelijke franjeaap', 'De oostelijke franjeaap heeft een zwart-witte vacht. De poten, rug en kroon zijn zwart, evenals het kale gezicht en de oren. De wangen, baard, keel en hals zijn wit, evenals de staartpluim en de mantel. Het haar rond het gezicht is wit en vrij kort in vergelijking met andere franjeapen. De mantel, bestaande uit lange, witte haren, loopt van de schouders tot de onderrug. De staart is lang (65 tot 90 centimeter) en vol. Franjeapen worden 10 tot 23 kilogram zwaar.De oostelijke populaties hebben een dikkere vacht en een wittere staart en mantel, de noordelijke populaties hebben een dunnere vacht en een zwarte staartwortel en schouders.','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Colubusmonkey.JPG/1280px-Colubusmonkey.JPG')

INSERT INTO SEKSUEELDIMORFISME (LATIJNSENAAM, GESLACHT, VOLWASSENLEEFTIJD, VOLWASSENGEWICHT, OVERIGEKENMERKEN) 
VALUES
('Panthera leo', 'M', '5 jaar', '150 tot 280 kg', 'kop-romplengte van 172 tot 250 cm'),
('Panthera leo', 'F', '5 jaar', '100 tot 182 kg', 'kop-romplengte van 140 tot 192 cm'),
('Loxodonta', 'M',  '10 tot 12 jaar','4,700-6,048 kg', 'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.'),
('Loxodonta', 'F', '10 tot 12 jaar','2,160-3,232 kg',  'De slagtanden kunnen 23 tot 45 kg wegen en 1.5 tot 2.4 meter lang zijn.'),
('Centrophorus harrissoni', 'M', NULL, NULL, NULL),
('Centrophorus harrissoni', 'F', NULL, NULL, NULL),
('Canis lupus', 'M', '2 jaar', NULL, NULL),
('Canis lupus', 'F', '2 jaar', NULL, NULL),
('Torgos tracheliotos', 'M', NULL, '6.5-9.2 kg', NULL),
('Torgos tracheliotos', 'F', NULL, '10.5-13.6 kg', NULL),
('Argynnis paphia', 'M', NULL, NULL, 'Eggs hatch around august.'),
('Argynnis paphia', 'F', NULL, NULL, 'Eggs hatch around august.'),
('Cyprinus carpio', 'M', '20 jaar', '2-14 kg', NULL),
('Cyprinus carpio', 'F', '20 jaar', '2-14 kg', NULL),
('Alligator mississippiensis', 'M', NULL, NULL, NULL),
('Alligator mississippiensis', 'F', NULL, NULL, NULL),
('Phoenicopteridae', 'M', NULL, NULL, NULL),
('Phoenicopteridae', 'F', NULL, NULL, NULL),
('Colobus guereza', 'M', NULL, NULL, NULL),
('Colobus guereza', 'F', NULL, NULL, NULL)

INSERT INTO GEBIED (GEBIEDNAAM, HOOFDVERZORGER)
VALUES
('Savanne', 2),
('Vlindertuin', 3),
('Aquarium', 4),
('Europa & Amerika', 5)

INSERT INTO VERBLIJF (GEBIEDNAAM)
VALUES
('Savanne'),
('Savanne'),
('Aquarium'),
('Europa & Amerika'),
('Europa & Amerika'),
('Vlindertuin'),
('Aquarium'),
('Europa & Amerika'),
('Europa & Amerika')

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


INSERT INTO MEDISCHDOSSIER (DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
VALUES
('PAN-001', '13-SEP-2020', 11, '13-OCT-2020'),
('LOX-001', '24-MAY-2016', 12, NULL),
('TOR-002', '28-OCT-2019', 13, NULL),
('PHO-002', '02-JUN-2019', 14, '16-JUN-2019'),
('PHO-006', '06-AUG-2017', 14, NULL),
('COL-007', '14-NOV-2021', 11, '14-NOV-2022'),
('TOR-001', '19-JAN-2018', 12, NULL)

INSERT INTO DIAGNOSES (DIERID, CONTROLEDATUM, DIAGNOSE, VOORSCHRIFT)
VALUES
('PAN-001', '13-SEP-2020', 'Luizen', '3ml anti luizen zalf/d'),
('LOX-001', '24-MAY-2016', NULL, 'Vit. D 10µl/d'),
('TOR-002', '28-OCT-2019', 'Zwanger', NULL),
('PHO-002', '02-JUN-2019', NULL, NULL),
('PHO-006', '06-AUG-2017', 'HepA', 'HepA injectie')

INSERT INTO FOKDOSSIER (FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
VALUES
('PAN-002', 'PAN-001', '19-APR-2017', 'Nijmegen'),
('LOX-002', NULL, NULL, NULL),
('CEN-002', 'CEN-001', NULL, NULL),
('CAN-002', NULL, '25-MAR-2018', NULL),
('COL-002', NULL, NULL, 'Hilversum'),
('ALL-002', 'ALL-001', '21-SEP-2020', 'Tallahassee'),
('PHO-006', 'PHO-001', '01-AUG-2019', 'Hilversum')

INSERT INTO DIERENTUIN (DIERENTUINNAAM, DIERENTUINPREFIX, PLAATS, LAND, HOOFDVERANTWOORDELIJKE, CONTACTINFORMATIE)
VALUES
('Somerleyton Animal Park', 'SAP-', 'Nijmegen', 'Nederland', 'Paksha Thullner', 'Paksha Thullner op teams'),
('Ouwehands Dierenpark', 'OUW-', 'Utrecht', 'Nederland', 'Herman Biet', 'Grebbeweg 111, 3911 AV Rhenen, telefoon: 0317 650 200'),
('Uilenbos', 'UIL-', NULL, NULL, NULL, NULL),
('Apenheul', 'APE-', 'Apeldoorn', NULL, NULL, NULL),
('Artis', 'ART-', NULL, 'Nederland', NULL, NULL),
('Dierenpark Amersfoort', 'AME-', NULL, NULL, 'Kees Kaas', NULL),
('Nordhorn Zoo', 'NHZ-', NULL, NULL, NULL, 'Heseper Weg 110, 48531 Nordhorn, telefoon: +49 5921 712000'),
('San Diego Zoo Safari Park', 'SDZ-', 'Zoo in San Diego', 'America', NULL, NULL),
('NaturZoo Rheine','NZR-', NULL, 'Duitsland', 'Thaksha Pullner', NULL),
('Brookfield Zoo', 'BRO-', NULL, NULL, 'Henry Scott', '8400 W 31st St, Brookfield, IL 60513, United States, telefoon: +1 708-688-8000'),
('Beijing Zoo', 'BEI-', 'Beijing', 'China', 'Ling Ling', NULL),
('Moscow Zoo', 'MOS-', NULL, 'Rusland', 'Alexander Hart', 'Bolshaya Gruzinskaya St, 1, Moscow, Russia, 123242, telefoon: +7 499 252-29-51' )

INSERT INTO UITLEENDOSSIER (DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
VALUES
('ALL-003', '10-JAN-2020', 'Somerleyton Animal Park', 'Nordhorn Zoo', '10-JAN-2021', 'ALL-003 kwam terug met een wond op zijn rug.'),
('BEZ_COL-001', '17-JUN-2021', 'Beijing Zoo', 'Somerleyton Animal Park', NULL, NULL),
('PAN-001', '20-NOV-2020', 'Somerleyton Animal Park', 'San Diego Zoo Safari Park', '20-NOV-2021', NULL),
('UIL_PHO-007', '20-NOV-2021', 'Uilenbos', 'Somerleyton Animal Park', NULL, 'Wordt erg paniekerig wanneer opgesloten in een kleine kooi.'),
('BRZ_CYP-005', '04-SEP-2018', 'Brookfield Zoo', 'Somerleyton Animal Park', '04-SEP-2020', 'Covid uitbraak vertraagde het verplaatsingsproces.')

INSERT INTO UITZETDOSSIER (DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING)
VALUES
('PHO-002', '23-DEC-2019', 'Spanje, Safari resort', 'SHS129', 'Na het vrijlaten bleef ze nog lang in de buurt van mensen.'),
('COL-009', '30-APR-2020', 'Brazil', 'BP342', NULL),
('COL-005', '12-JAN-1919', 'Nationaal natuurpark van Japan', 'HSH727', NULL),
('CYP-004', '03-SEP-2012', 'Nederland, de Rijn', NULL, 'In diep water uitgezet.')

INSERT INTO GESPOT (DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE)
VALUES
('PHO-002', '23-DEC-2019', '14-OCT-2021', 'Portugal, Oost van Lisbon'),
('COL-009', '30-APR-2020', '27-FEB-2021', 'Brazil, Bondinho Pão de Açúcar'),
('CYP-004', '03-SEP-2012', '10-FEB-2013', 'Nederland, de Lek')

INSERT INTO VOEDSEL (VOEDSELSOORT)
VALUES 
('Stro'),
('Hooi'),
('Gedroogd Gras'),
('Sla'),
('Witlof'),
('Radijs'),
('Bladgroentenmix'),
('Tomaat'),
('Komkommer'),
('Wortel'),
('Prei'),
('Banaan'),
('Appel'),
('Kiwi'),
('Druiven'),
('Fruitmix'),
('Haver'),
('Gerst'),
('Gecondenseerde Melk'),
('Water'),
('Pens'),
('Hart'),
('Spier'),
('Karkas'),
('Vleesmix'),
('Inktvis'),
('Zalm'),
('Haring'),
('Vismix')

INSERT INTO EENHEDEN (EENHEID)
VALUES
('Kilogram'),
('Gram'),
('Milligram'),
('Liter'),
('Milliliter'),
('Aantal'),
('Verpakkingen')

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


INSERT INTO LEVERANCIER (LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES)
VALUES
('Freeks Freaky Frikandellen', 'Nijmegen', 'Professor Molkenboerstraat 3'),
('Mapleton Zoological Supplies', 'Suffolk', '134 Murray R.'),
('Dierentuingoederen Overijssel', 'Zwolle', 'Industrielaan 305'),
('Zoologischer Bedarf München', 'München', 'Schnitzelstraße 42'),
('Kiezebrink UK Ltd', 'Bury St Edmunds', 'Church Road')

INSERT INTO BESTELLING (LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS, BETAALDATUM)
VALUES 
('Mapleton Zoological Supplies', '23-JAN-2021', 'Besteld', NULL),
('Kiezebrink UK Ltd', '01-NOV-2020', 'Betaling_Nodig', NULL),
('Mapleton Zoological Supplies', '11-MAR-2020', 'Betaald', '2-APR-2020')

INSERT INTO BESTELLINGREGEL (BESTELLINGID, VOEDSELSOORT, BESTELDEHOEVEELHEID, PRIJS, EENHEID)
VALUES
('1', 'Stro', '1000', '£0.74', 'Kilogram'),
('1', 'Hooi', '1500', '£1.24', 'Kilogram'),
('1', 'Gedroogd Gras', '800', '£0.62', 'Kilogram'),
('2', 'Pens', '100', '£4.32', 'Kilogram'),
('2', 'Karkas', '30', '£32.98', 'Aantal'),
('2', 'Spier', '250', '£3.78', 'Kilogram'),
('3', 'Fruitmix', '2000', '£2.3', 'Kilogram'),
('3', 'Haver', '500', '£1.89', 'Kilogram'),
('3', 'Gecondenseerde Melk', '500', '£3.45', 'Liter')

INSERT INTO LEVERINGCONTROLE (BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID)
VALUES
('1', 'Stro', '03-FEB-2021', '1000', '1000', 'Kilogram'),
('1', 'Hooi', '03-FEB-2021', '1000', '1500', 'Kilogram'),
('2', 'Pens', '15-NOV-2020', '100', '100', 'Kilogram'),
('2', 'Karkas', '17-NOV-2020', '30', '30', 'Aantal'),
('2', 'Spier', '15-NOV-2020', '250', '250', 'Kilogram'),
('3', 'Fruitmix', '15-MAR-2020', '1500', '1500', 'Kilogram'),
('3', 'Fruitmix', '27-MAR-2020', '500', '500', 'Kilogram'),
('3', 'Haver', '15-MAR-2020', '500', '500', 'Kilogram'),
('3', 'Gecondenseerde Melk', '15-MAR-2020', '500', '500', 'Liter')

/* ==================================================
= SQL Foreign Keys Somerleyton         			    =
================================================== */ 
GO
CREATE OR ALTER TRIGGER TRG_DeleteCascadeDier
ON DIER INSTEAD OF DELETE 
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		
		UPDATE FOKDOSSIER SET FOKPARTNER = NULL WHERE FOKPARTNER IN (SELECT DIERID FROM DELETED)
		DELETE FROM FOKDOSSIER WHERE FOKDIER IN (SELECT DIERID FROM DELETED)
		DELETE FROM MEDISCHDOSSIER WHERE DIERID IN (SELECT DIERID FROM DELETED)
		DELETE FROM UITZETDOSSIER WHERE DIERID IN (SELECT DIERID FROM DELETED)
		DELETE FROM UITLEENDOSSIER WHERE DIERID IN (SELECT DIERID FROM DELETED)
		DELETE FROM DIEETINFORMATIE WHERE DIERID IN (SELECT DIERID FROM DELETED)
		DELETE FROM DIER WHERE DIERID IN (SELECT DIERID FROM DELETED)

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Foreign keys naar DIER > on update cascade on delete cascade
-- Alleen fokpartner Update set NULL
-- Wanneer een dier wordt verwijdert worden alle bijbehorende dossiers en dieetinformatie verwijdert.

-- on update cascade on delete cascade (Trigger)
alter table FOKDOSSIER
   add constraint FK_FOKDOSSI_FOKDIER_DIER foreign key (FOKDIER)
      references DIER (DIERID)
go

-- on update cascade on delete cascade (Trigger)
alter table FOKDOSSIER
   add constraint FK_FOKDOSSI_FOKPARTNE_DIER foreign key (FOKPARTNER)
      references DIER (DIERID)
go

-- on update cascade on delete set null (Declaratief)
alter table DIER
   add constraint FK_DIER_RELATIONS_FOKDOSSI foreign key (FOKID)
      references FOKDOSSIER (FOKID)
         on update cascade on delete set null
go

-- on update cascade on delete cascade (Trigger)
alter table DIEETINFORMATIE
   add constraint FK_DIEETINF_VOEDSELVO_DIER foreign key (DIERID)
      references DIER (DIERID)
	     on update cascade on delete no action
go

-- on update cascade on delete cascade (Trigger)
alter table MEDISCHDOSSIER
   add constraint FK_MEDISCHD_MEDISCHDO_DIER foreign key (DIERID)
      references DIER (DIERID)

go

-- on update cascade on delete cascade (Declaratief)
alter table DIAGNOSES
   add constraint FK_DIAGNOSE_RELATIONS_MEDISCHD foreign key (DIERID, CONTROLEDATUM)
      references MEDISCHDOSSIER (DIERID, CONTROLEDATUM)
         on update cascade on delete cascade
go

-- on update cascade on delete cascade (Trigger)
alter table UITZETDOSSIER
   add constraint FK_UITZETDO_UITGEZETD_DIER foreign key (DIERID)
      references DIER (DIERID)
         on update cascade on delete no action
go

-- on update cascade on delete cascade (Declaratief)
alter table GESPOT
   add constraint FK_GESPOT_UITGEZETD_UITZETDO foreign key (DIERID, UITZETDATUM)
      references UITZETDOSSIER (DIERID, UITZETDATUM)
         on update cascade on delete cascade
go

-- on update cascade on delete cascade (Trigger)
alter table UITLEENDOSSIER
   add constraint FK_UITLEEND_UITGELEEN_DIER foreign key (DIERID)
      references DIER (DIERID)
		on update cascade on delete no action
go

-- Dierentuin in Uitleendossier (beiden kunnnen niet update cascade zijn)
-- on update cascade on delete no action (Declaratief)
alter table UITLEENDOSSIER
   add constraint FK_UITLEEND_ONTVANGEN_DIERENTU foreign key (ONTVANGENDEDIERENTUIN)
      references DIERENTUIN (DIERENTUINNAAM)
         on update cascade on delete no action
go

-- on update no action on delete no action (Declaratief)
alter table UITLEENDOSSIER
   add constraint FK_UITLEEND_UITLENEND_DIERENTU foreign key (UITLENENDEDIERENTUIN)
      references DIERENTUIN (DIERENTUINNAAM)
		on update no action on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table MEDISCHDOSSIER
   add constraint FK_MEDISCHD_BEHANDELD_MEDEWERK foreign key (MEDEWERKERID)
      references MEDEWERKER (MEDEWERKERID)
         on update cascade on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table DIEETINFORMATIE
   add constraint FK_DIEETINF_EENHEIDVA_EENHEDEN foreign key (EENHEID)
      references EENHEDEN (EENHEID)
         on update cascade on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table DIEETINFORMATIE
   add constraint FK_DIEETINF_RELATIONS_VOEDSEL foreign key (VOEDSELSOORT)
      references VOEDSEL (VOEDSELSOORT)
         on update cascade on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table DIER
   add constraint FK_DIER_DIERVANDI_DIERSOOR foreign key (DIERSOORT)
      references DIERSOORT (LATIJNSENAAM)
         on update cascade on delete no action
go

-- on update cascade on delete cascade (Declaratief)
alter table SEKSUEELDIMORFISME
   add constraint FK_SEKSUEEL_RELATIONS_DIERSOOR foreign key (LATIJNSENAAM)
      references DIERSOORT (LATIJNSENAAM)
         on update cascade on delete cascade
go

-- on update cascade on delete no action (Declaratief)
alter table DIER
   add constraint FK_DIER_DIERINVER_VERBLIJF foreign key (GEBIEDNAAM, VERBLIJFID)
      references VERBLIJF (GEBIEDNAAM, VERBLIJFID)
         on update cascade on delete no action
go

-- on update cascade on delete cascade (Declaratief)
alter table VERBLIJF
   add constraint FK_VERBLIJF_VERBLIJFI_GEBIED foreign key (GEBIEDNAAM)
      references GEBIED (GEBIEDNAAM)
         on update cascade on delete cascade
go

-- on update no action on delete no action (Declaratief)
alter table GEBIED
	add constraint FK_GEBIED_HOOFDVERZ_MEDEWERK foreign key (HOOFDVERZORGER)
      references MEDEWERKER (MEDEWERKERID)
         on update no action on delete no action
go

-- on update cascade on delete set null (Declaratief)
alter table MEDEWERKER
   add constraint FK_MEDEWERK_VERZORGER_GEBIED foreign key (GEBIEDNAAM)
      references GEBIED (GEBIEDNAAM)
         on update cascade on delete set null
go

-- on update cascade on delete no action (Declaratief)
alter table MEDEWERKER
   add constraint FK_MEDEWERK_FUNCTIEVA_FUNCTIES foreign key (FUNCTIE)
      references FUNCTIES (FUNCTIE)
         on update cascade on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table BESTELLING
   add constraint FK_BESTELLI_LEVERANCI_LEVERANC foreign key (LEVERANCIERNAAM)
      references LEVERANCIER (LEVERANCIERNAAM)
        on update cascade on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table BESTELLINGREGEL
   add constraint FK_BESTELLI_EENHEIDVA_EENHEDEN foreign key (EENHEID)
      references EENHEDEN (EENHEID)
         on update cascade on delete no action
go

-- on update cascade on delete no action (Declaratief)
alter table BESTELLINGREGEL
   add constraint FK_BESTELLI_RELATIONS_VOEDSEL foreign key (VOEDSELSOORT)
      references VOEDSEL (VOEDSELSOORT)
         on update cascade on delete no action
go

-- on update cascade on delete cascade (Declaratief)
alter table BESTELLINGREGEL
   add constraint FK_BESTELLI_VOEDSELIN_BESTELLI foreign key (BESTELLINGID)
      references BESTELLING (BESTELLINGID)
		on update cascade on delete cascade
go

-- on update no action on delete cascade (Declaratief)
alter table LEVERINGCONTROLE
   add constraint FK_LEVERING_RELATIONS_BESTELLI foreign key (BESTELLINGID, VOEDSELSOORT)
      references BESTELLINGREGEL (BESTELLINGID, VOEDSELSOORT)
		on update cascade on delete cascade
go

-- on update cascade on delete no action (Declaratief)
alter table LEVERINGCONTROLE
   add constraint FK_LEVERING_EENHEIDVA_EENHEDEN foreign key (EENHEID)
      references EENHEDEN (EENHEID)
         on update no action on delete no action
go

/* ==================================================
= Domein Constraints DC 1.1-1.5        			        =
================================================== */ 
-- DC 1: IN ("Besteld", "Betaling_Nodig", "Betaald")
ALTER TABLE BESTELLING
	ADD CONSTRAINT CHK_BestelStatus
	CHECK (BestelStatus = 'Besteld' 
		OR BestelStatus = 'Betaling_Nodig' 
		OR BestelStatus = 'Betaald')
GO

-- DC 2: IN ("Aanwezig", "Overleden", "Uitgezet", "Uitgeleend", "Afwezig")
ALTER TABLE DIER
	ADD CONSTRAINT CHK_DierStatus
	CHECK (STATUS = 'Aanwezig'
		OR STATUS = 'Afwezig'
		OR STATUS = 'Uitgeleend'
		OR STATUS = 'Uitgezet'
		OR STATUS = 'Overleden')
GO

-- DC 3: IN ("M", "F", NULL)
ALTER TABLE DIER
	ADD CONSTRAINT CHK_DierGeslacht
	CHECK (GESLACHT = 'M'
		OR GESLACHT = 'F')
GO

-- DC 4: Waarde >= 0
ALTER TABLE BESTELLINGREGEL
	ADD CONSTRAINT CHK_Prijs
	CHECK (Prijs >= 0)
GO

-- DC 5: Waarde > 0
ALTER TABLE BESTELLINGREGEL
	ADD CONSTRAINT CHK_BesteldeHoeveelheid
	CHECK (BESTELDEHOEVEELHEID > 0)
GO

ALTER TABLE LEVERINGCONTROLE
	ADD CONSTRAINT CHK_OntvangenVerwachteHoeveelheid
	CHECK (ONTVANGENHOEVEELHEID > 0 AND VERWACHTEHOEVEELHEID > 0)
GO

ALTER TABLE DIEETINFORMATIE
	ADD CONSTRAINT CHK_HoeveelheidPerDag
	CHECK (HOEVEELHEIDPERDAG > 0)
GO

/* ==================================================
= Integrity Rules IR 1-35             			        =
================================================== */ 
-- IR 1: Voor iedere bestelling mag de ontvangdatum niet voor de besteldatum liggen.
CREATE OR ALTER TRIGGER TRG_LeverdatumBestelling
ON LeveringControle
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN 
    SET NOCOUNT ON 
	BEGIN TRY
	IF EXISTS ( 
        SELECT OntvangDatumTijd
        FROM INSERTED i JOIN Bestelling b ON i.BESTELLINGID = b.BESTELLINGID
        AND b.BESTELDATUM > i.ONTVANGDATUMTIJD
	)
	    THROW 56001, 'Een ontvangen Datum Tijd mag niet later zijn dan de besteldatum', 16
	END TRY
	BEGIN CATCH
	    THROW
	END CATCH
END
GO

-- IR 2: De geboortedatum van een dier kan niet eerder zijn dan de geboortedatum van zijn ouders.
CREATE OR ALTER TRIGGER TRG_GeboortedatumDier
ON DIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN 
    SET NOCOUNT ON 
	BEGIN TRY
		IF EXISTS ( 
		    SELECT 1
		    FROM INSERTED I INNER JOIN FOKDOSSIER F ON I.FOKID = F.FOKID
			WHERE EXISTS (
				SELECT 1
				FROM DIER D
				WHERE (D.DIERID = F.FOKDIER OR D.DIERID = F.FOKPARTNER) AND D.GEBOORTEDATUM > I.GEBOORTEDATUM
			)
		)
			THROW 56002, 'De geboortedatum van een dier moet na de geboortedatum van zijn ouders liggen', 16
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END
GO

-- IR 3: Een dier kan alleen gevoerd worden als deze is geboren. Dit houdt in dat de startdatum niet voor de geboortedatum kan liggen.
CREATE OR ALTER TRIGGER TRG_VoederDatum
ON DIEETINFORMATIE
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM inserted AS I
			INNER JOIN Dier AS D
			ON D.DierID = I.DierID
			WHERE I.Startdatum < D.GeboorteDatum
		)
			THROW 56003, 'Een dier kan alleen gevoerd worden als deze is geboren. Dit houdt in dat de startdatum niet voor de geboortedatum kan liggen.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 4: Een medisch dossier kan alleen worden opgesteld voor een dier dat is geboren. De datum van het medischdossier kan niet voor de geboortedatum zijn.
CREATE OR ALTER TRIGGER TRG_MedischDossierDatum
ON MEDISCHDOSSIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
	RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN DIER D
			ON I.DIERID = D.DIERID
			WHERE I.CONTROLEDATUM < D.GEBOORTEDATUM
		)
			THROW 56004, 'De controledatum kan niet voor de geboortedatum van een dier liggen', 16
	END TRY
	BEGIN CATCH
	;THROW
	END CATCH 
END
GO

-- IR 5: Er kan alleen met een dier gefokt worden als deze ook is geboren. Dit houdt in dat de fokdatum na de geboortedatum moet liggen.
CREATE OR ALTER TRIGGER TRG_FokgeschiedenisDatum
ON FokDossier
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED i JOIN Dier d ON i.FOKDIER = d.DIERID
			AND d.GEBOORTEDATUM > i.FOKDATUM
			)
			THROW 56005, 'De fokdatum van een dier mag niet eerder zijn dan de geboortedatum', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 6: De terugkeerdatum van een dier dat uitgeleend wordt moet na de uitleendatum van een dier zijn.
ALTER TABLE UITLEENDOSSIER
ADD CONSTRAINT CHK_TerugkeerDatum
CHECK (NOT(TERUGKEERDATUM < UITLEENDATUM))
GO

-- IR 7: Als een dier wordt gebruikt om mee te fokken kan dit niet met een dier van hetzelfde geslacht zijn als beide geslachten bekend zijn.
CREATE OR ALTER TRIGGER TRG_GeslachtFokDier
ON FOKDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM inserted AS I
			INNER JOIN DIER AS MOTHERD
			ON I.FOKDIER = MOTHERD.DIERID
			INNER JOIN DIER AS FATHERD
			ON I.FOKPARTNER = FATHERD.DIERID
			WHERE MOTHERD.GESLACHT IS NOT NULL
			AND MOTHERD.GESLACHT = FATHERD.GESLACHT
		)
			THROW 56007, 'Als een dier wordt gebruikt om mee te fokken kan dit niet met een dier van hetzelfde geslacht zijn als beide geslachten bekend zijn.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 8: Een dier kan alleen worden uitgeleend als deze ook geboren is. De uitleendatum moet na de geboortedatum liggen.
CREATE OR ALTER TRIGGER TRG_UitleenDatum
ON UITLEENDOSSIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
	RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN DIER D
			ON i.DIERID = d.DIERID
			WHERE I.UITLEENDATUM < d.GEBOORTEDATUM
		)
			THROW 56008, 'De uitleendatum kan niet voor de geboortedatum van een dier liggen', 16
	END TRY
	BEGIN CATCH
	;THROW
	END CATCH 
END
GO

-- IR 9: Een dier kan alleen uitgezet worden als deze is geboren. De uitzetdatum moet na de geboortedatum zijn.
CREATE OR ALTER TRIGGER TRG_UitzetDatum
ON UitzetDossier
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED i JOIN Dier d ON i.DIERID = d.DIERID
			AND d.GEBOORTEDATUM > i.UITZETDATUM
		)
			THROW 56009, 'De UitzetDatum van een dier mag niet eerder zijn dan de geboortedatum', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 10: De moeder(FokDier) van een dier moet het geslacht van een vrouwtje(F) hebben.
CREATE OR ALTER TRIGGER TRG_GeslachtMoeder
ON FOKDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		return
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM INSERTED I INNER JOIN DIER D
			ON I.FOKDIER = D.DIERID
			WHERE D.GESLACHT = 'M'
		)
			THROW 56010, 'Het FokDier moet van het vrouwelijke geslacht zijn.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 11: De vader(FokPartner) van een dier moet het geslacht van een mannetje(M) hebben.
CREATE OR ALTER TRIGGER TRG_GeslachtVader
ON FOKDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM inserted AS I
			INNER JOIN DIER AS D
			ON I.FOKPARTNER = D.DIERID
			WHERE D.GESLACHT = 'F'
		)
			THROW 56011, 'De vader(FokPartner) van een dier moet het geslacht van een mannetje(M) hebben.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

--IR 12: Een dier dat in FokDossier staat moet dezelfde fokplaats hebben als de locatie waar het dier op dat moment verblijft.
CREATE OR ALTER TRIGGER TRG_FokLocatie
ON FOKDOSSIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
	RETURN
	SET NOCOUNT ON
	BEGIN TRY
		-- Checkt of FOKPLAATS hetzelfde is als PLAATS als FOKDIER of FOKPARTNER in UITLEENDOSSIER voorkomen
		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN UITLEENDOSSIER U
			ON I.FOKDIER = U.DIERID
			JOIN DIERENTUIN D ON U.ONTVANGENDEDIERENTUIN = D.DIERENTUINNAAM
			WHERE I.FOKDATUM >= U.UITLEENDATUM 
			AND I.FOKDATUM <= U.TERUGKEERDATUM
			AND I.FOKPLAATS != D.PLAATS
		)
			THROW 56012, 'Fokplaats is niet hetzelfde als de verblijflocatie van FOKDIER', 1 

		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN UITLEENDOSSIER U
			ON I.FOKPARTNER = U.DIERID
			JOIN DIERENTUIN D ON U.ONTVANGENDEDIERENTUIN = D.DIERENTUINNAAM
			WHERE I.FOKDATUM >= U.UITLEENDATUM 
			AND I.FOKDATUM <= U.TERUGKEERDATUM
			AND I.FOKPLAATS != D.PLAATS
		)
			THROW 56012, 'Fokplaats is niet hetzelfde als de verblijflocatie van FOKPARTNER', 1 

		-- Checkt of FOKPLAATS Somerleyton is wanneer een dier thuis is
		IF EXISTS(
			SELECT 1
			FROM INSERTED I
			JOIN UITLEENDOSSIER U ON I.FOKDIER = U.DIERID
			JOIN DIERENTUIN D ON U.ONTVANGENDEDIERENTUIN = D.DIERENTUINNAAM
			JOIN UITLEENDOSSIER U2 ON I.FOKDIER = U.DIERID
			WHERE I.FOKDATUM <= U.UITLEENDATUM 
			AND I.FOKDATUM >= U2.TERUGKEERDATUM
			AND I.FOKPLAATS != 'Somerleyton Animal Park'
		)
			THROW 56012, 'Fokplaats is niet hetzelfde als de verblijflocatie van FOKDIER', 1 

		IF EXISTS(
			SELECT 1
			FROM INSERTED I
			JOIN UITLEENDOSSIER U ON I.FOKDIER = U.DIERID
			JOIN DIERENTUIN D ON U.ONTVANGENDEDIERENTUIN = D.DIERENTUINNAAM
			JOIN UITLEENDOSSIER U2 ON I.FOKDIER = U.DIERID
			WHERE I.FOKDATUM > U.UITLEENDATUM 
			AND I.FOKDATUM > U2.TERUGKEERDATUM
			AND I.FOKPLAATS != 'Somerleyton Animal Park'
		)
			THROW 56012, 'Fokplaats is niet hetzelfde als de verblijflocatie van FOKDIER', 1 

		IF EXISTS(
			SELECT 1
			FROM INSERTED I
			JOIN UITLEENDOSSIER U ON I.FOKPARTNER = U.DIERID
			JOIN DIERENTUIN D ON U.ONTVANGENDEDIERENTUIN = D.DIERENTUINNAAM
			JOIN UITLEENDOSSIER U2 ON I.FOKPARTNER = U.DIERID
			WHERE I.FOKDATUM <= U.UITLEENDATUM 
			AND I.FOKDATUM >= U2.TERUGKEERDATUM
			AND I.FOKPLAATS != 'Somerleyton Animal Park'
		)
			THROW 56012, 'Fokplaats is niet hetzelfde als de verblijflocatie van FOKPARTNER', 1 

		IF EXISTS(
			SELECT 1
			FROM INSERTED I 
			JOIN UITLEENDOSSIER U ON I.FOKPARTNER = U.DIERID
			JOIN DIERENTUIN D ON U.ONTVANGENDEDIERENTUIN = D.DIERENTUINNAAM
			JOIN UITLEENDOSSIER U2 ON I.FOKPARTNER = U.DIERID
			WHERE I.FOKDATUM > U.UITLEENDATUM 
			AND I.FOKDATUM > U2.TERUGKEERDATUM
			AND I.FOKPLAATS != 'Somerleyton Animal Park'
		)
			THROW 56012, 'Fokplaats is niet hetzelfde als de verblijflocatie van FOKPARTNER', 1 

	END TRY
	BEGIN CATCH
	;THROW
	END CATCH 
END
GO

-- IR 13: De Betaaldatum kan alleen worden ingevuld op het moment dat de bestelstatus op 'Betaling_Nodig' staat.
CREATE OR ALTER TRIGGER TRG_BestellingBetalen
ON Bestelling
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED i
			WHERE i.BestelStatus != 'Betaald'
			AND i.Betaaldatum IS NOT NULL
		) 
			THROW 56013, 'Een betaaldatum mag niet ingevuld zijn als de status niet betaald is', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 14: De Betaaldatum in Bestelling moet gelijk zijn aan of later zijn dan de BestelDatum.
ALTER TABLE BESTELLING
ADD CONSTRAINT CHK_BetaalDatumBestelling
CHECK (NOT(BETAALDATUM < BESTELDATUM))

-- IR 15: De SpotDatum in Gespot moet na of gelijk zijn aan de UitzetDatum in Uitzetdossier liggen.
ALTER TABLE GESPOT
ADD CONSTRAINT CHK_DatumDierGespot
CHECK (SpotDatum > UitzetDatum)
GO

-- IR 16: De medewerkerID in MedischDossier moet de functie dierenarts hebben in medewerker.
CREATE OR ALTER TRIGGER TRG_DiagnoseDoorDierenarts
ON MEDISCHDOSSIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
	RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN MEDEWERKER M
			ON I.MEDEWERKERID = M.MEDEWERKERID
			WHERE M.FUNCTIE != 'Dierenarts'
		)
			THROW 56016, 'De medewerker is geen dierenarts', 16
	END TRY
	BEGIN CATCH
	;THROW
	END CATCH 
END
GO

-- IR 17: Een dier in UitleenDossier kan niet meerdere registraties hebben tussen de UitleenDatum en TerugkeerDatum. De uitleenDatum van een andere registratie van hetzelfde dier kan dus niet in de periode liggen van de uitleen en terugkeerdatum.
CREATE OR ALTER TRIGGER TRG_UitgeleendDier
ON Uitleendossier
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED i JOIN UITLEENDOSSIER u ON i.DIERID = u.DIERID
			WHERE 
			i.UITLEENDATUM < u.TERUGKEERDATUM AND i.UITLEENDATUM > u.UITLEENDATUM
			OR
			i.TERUGKEERDATUM < u.TERUGKEERDATUM AND i.TERUGKEERDATUM > u.UITLEENDATUM
		) 
			THROW 600017, 'Een dier in UitleenDossier kan niet meerdere registraties hebben tussen de UitleenDatum en TerugkeerDatum.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 18: Een dier kan niet voorkomen in UitzetDossier als deze in Dier een VerblijfID heeft.
CREATE OR ALTER TRIGGER TRG_DierInHetWild
ON UITZETDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I INNER JOIN DIER D
			ON I.DIERID = D.DIERID
			WHERE D.VERBLIJFID IS NOT NULL
		) 
			THROW 60018, 'Een uitgezet dier mag geen verblijf hebben', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 19: Alleen een dier met geslacht vrouwtje kan met een zwangerschap gediagnosticeerd worden.
CREATE OR ALTER TRIGGER TRG_ZwangerschapDier
ON DIAGNOSES
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM inserted AS I
			INNER JOIN DIER AS D
			ON I.DIERID = D.DIERID
			WHERE D.GESLACHT != 'F'
			AND I.DIAGNOSE = 'ZWANGER'
		)
			THROW 56019, 'Alleen een dier met geslacht vrouwtje kan met een zwangerschap gediagnosticeerd worden.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 20: Op het moment dat een nieuw dier wordt toegevoegd aan Dier mag de geboortedatum niet in de toekomst liggen.
ALTER TABLE DIER
ADD CONSTRAINT CHK_GeboorteDatumInToekomst 
CHECK (Geboortedatum <=  CAST( GETDATE() AS Date ))
GO

-- IR 21: Een dier kan niet fokken met een ander dier dat dezelfde vader en/ of moeder heeft. Een dier kan ook niet direct met een van de ouders fokken.
CREATE OR ALTER TRIGGER TRG_FokkenMetFamilie
ON FOKDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED i
            WHERE
			-- Mag niet moeder zijn
			i.FOKDIER = (SELECT FOKDIER FROM FOKDOSSIER WHERE FOKID = (SELECT FOKID FROM DIER WHERE DIERID = i.FOKPARTNER))
			OR
			-- Mag niet vader zijn
			i.FOKPARTNER = (SELECT FOKPARTNER FROM FOKDOSSIER WHERE FOKID = (SELECT FOKID FROM DIER WHERE DIERID = i.FOKDIER))
			OR
			-- Mag niet zelfde Moeder hebben
			(SELECT FOKDIER FROM FOKDOSSIER F JOIN DIER D ON F.FOKID = D.FOKID WHERE DIERID = i.FOKDIER) = (SELECT FOKDIER FROM FOKDOSSIER F JOIN DIER D ON F.FOKID = D.FOKID WHERE DIERID = i.FOKPARTNER)
			OR
			-- Mag niet zelfde vader hebben
			(SELECT FOKPARTNER FROM FOKDOSSIER F JOIN DIER D ON F.FOKID = D.FOKID WHERE DIERID = i.FOKDIER) = (SELECT FOKPARTNER FROM FOKDOSSIER F JOIN DIER D ON F.FOKID = D.FOKID WHERE DIERID = i.FOKPARTNER)
		) 
			THROW 56021, 'Een dier kan niet fokken met een familielid', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 22: Een hoofdverzorger in een gebied kan alleen hoofdverzorger zijn als deze ook de functie van hoofdverzorger heeft.
CREATE OR ALTER TRIGGER TRG_HoofdverzorgerGebied
ON GEBIED
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@rowcount = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I INNER JOIN MEDEWERKER M
			ON I.HOOFDVERZORGER = M.MEDEWERKERID
			WHERE M.FUNCTIE != 'Hoofdverzorger'
		) 
			THROW 56022, 'Alleen een hoofdverzorger mag als hoofdverzorger van een gebied aangewezen worden.', 1
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 23: Een dier dat uitgeleend wordt heeft als uitlenende of als ontvangende dierentuin altijd Somerleyton Animal Park.
ALTER TABLE UITLEENDOSSIER
ADD CONSTRAINT CHK_UitleenDierentuin
CHECK 
(
	UITLENENDEDIERENTUIN = 'Somerleyton' OR UITLENENDEDIERENTUIN = 'Somerleyton Animal Park'
	OR ONTVANGENDEDIERENTUIN = 'Somerleyton' OR ONTVANGENDEDIERENTUIN = 'Somerleyton Animal Park'
)
GO

-- IR 24: Een dier kan geen nieuwe registratie krijgen in MedischDossier na de UitzetDatum als deze voorkomt in UitzetDossier.
CREATE OR ALTER TRIGGER TRG_MedischDossierUitgezetDier
ON MEDISCHDOSSIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
	RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN UITZETDOSSIER U
			ON I.DIERID = U.DIERID
			WHERE I.CONTROLEDATUM > U.UITZETDATUM
		)
			THROW 56024, 'Een nieuw medischdossier kan niet worden toegevoegd van een al uitgezet dier (Controledatum kan niet na de uitzetdatum liggen)', 16
	END TRY
	BEGIN CATCH
	;THROW
	END CATCH 
END
GO

-- IR 25: Een dier kan geen nieuwe registratie krijgen in FokDossier na de UitzetDatum als deze voorkomt in UitzetDossier.
CREATE OR ALTER TRIGGER TRG_FokDossierUitgezetDier
ON FOKDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I JOIN UITZETDOSSIER U
			ON I.FOKDIER = U.DIERID
			WHERE I.FOKDATUM > U.UITZETDATUM 
		) 
			THROW 56025, 'Een dier kan niet fokken wanneer deze uitgezet is.', 16

		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I JOIN UITZETDOSSIER U
			ON I.FOKPARTNER = U.DIERID
			WHERE I.FOKDATUM > U.UITZETDATUM 
		) 
			THROW 56025, 'Een dier kan niet fokken wanneer deze uitgezet is.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 26: Een dier kan geen nieuwe registratie krijgen in UitleenDossier na de UitzetDatum als deze voorkomt in UitzetDossier.
CREATE OR ALTER TRIGGER TRG_UitleenDossierUitgezetDier
ON UITLEENDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I INNER JOIN UITZETDOSSIER U
			ON I.DIERID = U.DIERID
			WHERE I.UITLEENDATUM > U.UITZETDATUM OR I.TERUGKEERDATUM > U.UITZETDATUM
		) 
			THROW 56026, 'Een uitgezet dier kan niet uitgeleend worden', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 27: Een dier kan geen nieuwe registratie krijgen in DieetInformatie na de UitzetDatum als deze voorkomt in UitzetDossier.
CREATE OR ALTER TRIGGER TRG_VoedselInfoUitgezetDier
ON DIEETINFORMATIE
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM inserted AS I
			INNER JOIN UITZETDOSSIER AS U
			ON U.DIERID = I.DIERID
			WHERE U.UITZETDATUM < I.STARTDATUM
		)
			THROW 56027, 'Een dier kan geen nieuwe registratie krijgen in DieetInformatie na de UitzetDatum als deze voorkomt in UitzetDossier.', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 28: Een dier dat voorkomt in UitzetDossier heeft geen verblijfID in Dier.
CREATE OR ALTER TRIGGER TRG_VerblijfUitgezetDier
ON UITZETDOSSIER
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
	RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS(
			SELECT 1
			FROM INSERTED I JOIN DIER D
			ON I.DIERID = D.DIERID
			WHERE D.VERBLIJFID IS NOT NULL
		)
			THROW 56028, 'Dier kan niet in uitzetdossier worden opgenomen als deze nog een verblijfID heeft', 16
	END TRY
	BEGIN CATCH
	;THROW
	END CATCH 
END
GO

-- IR 29: Een dier dat is overleden heeft geen nieuwe registraties in MedischDossier.
CREATE OR ALTER TRIGGER TRG_MedischDossierDoodDier
ON MEDISCHDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I JOIN DIER D ON D.DIERID = I.DIERID
			WHERE D.STATUS ='Overleden'		
		) 
			THROW 56029, 'Een overleden dier kan geen nieuwe toevoeging krijgen in het medisch dossier', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 30: Een dier kan geen nieuwe registratie krijgen in Fokdossier als het dier de status 'Overleden' heeft.
CREATE OR ALTER TRIGGER TRG_FokDossierDoodDier
ON FOKDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I 
			WHERE EXISTS (
				SELECT 1
				FROM DIER D
				WHERE (D.DIERID = I.FOKDIER OR D.DIERID = I.FOKPARTNER) AND D.STATUS = 'Overleden'
			)
		) 
			THROW 56030, 'Een overleden dier kan niet gefokt worden', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 31: Een dier kan geen nieuwe registratie krijgen in UitleenDossier als het dier de status 'Overleden' heeft.
CREATE OR ALTER TRIGGER TRG_UitleenDossierDoodDier
ON UITLEENDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS
		(
			SELECT 1
			FROM inserted AS I
			INNER JOIN DIER AS D
			ON D.DIERID = I.DIERID
			WHERE D.STATUS = 'Overleden'
		)
			THROW 56031, 'Een dier kan geen nieuwe registratie krijgen in UitleenDossier als het dier de status "Overleden" heeft', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 32: Een dier kan geen nieuwe registratie krijgen in DieetInformatie als het dier de status 'Overleden' heeft.
CREATE OR ALTER TRIGGER TRG_VoedselInfoDoodDier
ON DIEETINFORMATIE
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I INNER JOIN DIER D
			ON I.DIERID = D.DIERID
			WHERE D.STATUS = 'Overleden'
		) 
			THROW 56032, 'Een overleden dier kan geen nieuwe dieetvoorkeuren krijgen', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 33: Een dier kan geen VerblijfID meer hebben in Dier als deze de status overleden heeft.
ALTER TABLE DIER
ADD CONSTRAINT CHK_VerblijfDoodDier
CHECK (NOT(STATUS = 'Overleden' AND VERBLIJFID IS NOT NULL))
GO

-- IR 34: Een dier kan geen nieuwe registratie krijgen in UitzetDossier als het dier de status 'Overleden' heeft.
CREATE OR ALTER TRIGGER TRG_UitzettenDoodDier
ON UITZETDOSSIER
AFTER UPDATE, INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF EXISTS ( 
			SELECT 1
			FROM INSERTED I INNER JOIN DIER D
			ON I.DIERID = D.DIERID
			WHERE D.STATUS = 'Overleden'
		) 
			THROW 56034, 'Een overleden dier kan niet gefokt worden', 16
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- IR 35: Alleen een medewerker met de functie verzorger/hoofdverzorger heeft een gebiednaam in de tabel Medewerker.
ALTER TABLE MEDEWERKER
ADD CONSTRAINT CHK_VerzorgerInGebied
CHECK (
	(FUNCTIE = 'Verzorger' AND GEBIEDNAAM IS NOT NULL) OR 
	(FUNCTIE = 'Hoofdverzorger' AND GEBIEDNAAM IS NOT NULL) OR
	(FUNCTIE != 'Verzorger' AND GEBIEDNAAM IS NULL) OR
	(FUNCTIE != 'Hoofdverzorger' AND GEBIEDNAAM IS  NULL)
) 
GO

/* ==================================================
= Use Cases Insert UC         			                =
================================================== */ 
-- | UC 1.1 | verzorger, hoofdverzorger, kantoor medewerker | nieuw dier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertDier
	@DIERID 			DIERID,
	@GEBIEDNAAM 		NAAM,
	@VERBLIJFID 		int,
	@DIERSOORT 			NAAM,
	@FOKID 				int,
	@DIERNAAM 			NAAM,
	@GESLACHT 			GESLACHT,
	@GEBOORTEPLAATS		PLAATS,
	@GEBOORTELAND 		LAND,
	@GEBOORTEDATUM 		DATUM,
	@STATUS 			DIERSTATUS

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		-- @DIERNAAM mag alleen uit letters bestaan.
		IF (@DIERNAAM NOT LIKE '%[a-zA-Z]%')	
			THROW 51011, 'De DIERNAAM mag alleen letters bevatten', 16

		-- @DIERSOORT mag alleen uit letters bestaan.
		IF (@DIERSOORT NOT LIKE '%[a-zA-Z]%')
			THROW 51012, 'De DIERSOORT mag alleen letters bevatten', 16

		-- @GEBOORTEPLAATS mag alleen uit letters bestaan.
		IF (@GEBOORTEPLAATS NOT LIKE '%[a-zA-Z]%')
			THROW 51013, 'De GEBOORTEPLAATS mag alleen letters bevatten', 16

		-- @GEBOORTELAND mag alleen uit letters bestaan.
		IF (@GEBOORTELAND NOT LIKE '%[a-zA-Z]%')
			THROW 51014, 'De GEBOORTELAND mag alleen letters bevatten', 16

		--@DIERID moet een dierentuinprefix hebben OF voldoen aan AAA-111
		IF (@DIERID NOT LIKE '[a-zA-Z][a-zA-Z][a-zA-Z]-%')
			THROW 51015, 'Het DIERID moet voldoen aan de dierid standaard.',16

		INSERT INTO Dier(DIERID,GEBIEDNAAM,VERBLIJFID,DIERSOORT,FOKID,DIERNAAM,GESLACHT,GEBOORTEPLAATS,GEBOORTELAND,GEBOORTEDATUM,STATUS)
		VALUES (@DIERID,@GEBIEDNAAM,@VERBLIJFID,@DIERSOORT,@FOKID,@DIERNAAM,@GESLACHT,@GEBOORTEPLAATS,@GEBOORTELAND,@GEBOORTEDATUM,@STATUS)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.2 | verzorger, hoofdverzorger, kantoor medewerker | nieuw gebied toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertGebied
	@GebiedNaam 		Naam,
	@HOOFDVERZORGER 	ID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		-- @Hoofdverzorger moet de functie hoofdverzorger hebben
		IF NOT EXISTS (
			SELECT 1 FROM MEDEWERKER 
			WHERE MEDEWERKERID = @HOOFDVERZORGER 
			AND FUNCTIE = 'Hoofdverzorger'
		)
			THROW 51041, 'De medewerker moet de functie hoofdverzorger hebben',16;

        -- @Deze medewerker is als hoofdverzorger van een gebied
		IF EXISTS (
			SELECT 1 FROM MEDEWERKER 
			WHERE FUNCTIE = 'Hoofdverzorger' 
			AND MEDEWERKERID = @HOOFDVERZORGER 
			AND GEBIEDNAAM IS NOT NULL
		)
		    THROW 51042, 'Deze hoofdverzorger heeft al een gebied', 16;

		INSERT INTO Gebied(GEBIEDNAAM,HOOFDVERZORGER)
		VALUES (@GebiedNaam,@HOOFDVERZORGER)

		UPDATE MEDEWERKER
		SET GEBIEDNAAM = @GebiedNaam
		WHERE MEDEWERKERID = @HOOFDVERZORGER

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.3 | verzorger, hoofdverzorger, kantoor medewerker | nieuw verblijf toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertVerblijf
	@GebiedNaam 		Naam

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		-- @GebiedNaam moet in GEBIED bestaan voordat een VERBLIJF toegevoegd kan worden.
		IF NOT EXISTS (
			SELECT 1 FROM GEBIED 
			WHERE GEBIEDNAAM = @GebiedNaam
		)
			THROW 910006, 'Een verblijf moet deel zijn van een bestaand gebied.', 1;

		INSERT INTO VERBLIJF(GEBIEDNAAM)
		VALUES (@GebiedNaam)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.4 | verzorger, hoofdverzorger, kantoor medewerker | nieuwe diereninformatie toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertDiersoort
	@LatijnseNaam 		NAAM,
	@NormaleNaam 		NAAM,
	@EduTekst 			EDUTEKST,
	@Foto				LINK

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;
		
		IF (@NormaleNaam LIKE '%[0-9]%')
			THROW 51071, 'De normalenaam mag alleen letters bevatten', 16

	    IF (@LatijnseNaam  LIKE '%[0-9]%')
			THROW 51071, 'De normalenaam mag alleen letters bevatten', 16

		IF (@Foto NOT LIKE 'https://%' AND @Foto NOT LIKE 'http://%')
			THROW 51071, 'De Foto moet een link naar een website zijn', 16

		IF (@Foto NOT LIKE '%.jpg' AND @Foto NOT LIKE '%.png')
			THROW 51072, 'De Foto moet een link naar een foto zijn', 16

		INSERT INTO DIERSOORT(LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
		VALUES (@LatijnseNaam, @NORMALENAAM, @EduTekst, @Foto)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.5 | verzorger, hoofdverzorger, kantoor medewerker | nieuw fokdossier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertFokdossier
	@FokDier		DierID,
	@FokPartner 	DierID,
	@FokDatum		Datum,
	@FokPlaats		Plaats

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		-- Een fokdossier kan niet worden toegevoegd met een ongeldig FOKDIER
		IF EXISTS (SELECT 1 FROM DIER WHERE DIERID = @FokDier AND ( GESLACHT != 'F' OR GESLACHT IS NULL))
			THROW 910010, 'Een fokdossier kan niet worden toegevoegd met een ongeldig FOKDIER.', 1;

		-- Een fokdossier kan niet worden toegevoegd met een ongeldig FOKPARTNER
		IF EXISTS (SELECT 1 FROM DIER WHERE DIERID = @FokPartner AND (GESLACHT != 'M' OR GESLACHT IS NULL))
			THROW 910010, 'Een fokdossier kan niet worden toegevoegd met een ongeldig FOKPARTNER.', 1;

		-- Een fokdossier kan niet worden toegevoegd als de FOKDATUM in de toekomst ligt
		IF (@FokDatum > CURRENT_TIMESTAMP)
			THROW 910010, 'Een fokdossier kan niet worden toegevoegd met een FOKDATUM die in de toekomst ligt.', 1;

		-- Een fokdossier kan niet worden toegevoegd als de FOKDATUM voor de geboorte van een betrokken dier.
		IF EXISTS (SELECT 1 FROM DIER WHERE (DIERID = @FokDier OR DIERID = @FokPartner) AND GEBOORTEDATUM > @FokDatum)
			THROW 910010, 'Een fokdossier kan niet worden toegevoegd als de FOKDATUM voor de geboorte van een betrokken dier.', 1;

		-- Een fokdossier wordt niet toegevoegd met een andere FOKPLAATS als FOKDIER en FOKPARTNER de STATUS Aanwezig hebben.
		IF	(
				(
					SELECT COUNT(*) FROM DIER WHERE (DIERID = @FokDier OR DIERID = @FokPartner) 
					AND STATUS = 'Aanwezig'
				) = 2
			)
		AND (@FokPlaats != 'Somerleyton Animal Park')
			THROW 910010, 'Een fokdossier wordt niet toegevoegd met een andere FOKPLAATS dan "Somerleyton Animal Park" als FOKDIER en FOKPARTNER de STATUS Aanwezig hebben.', 1;

		--Een fokdossier wordt niet toegevoegd als FOKDIER een andere status heeft dan FOKPARTNER
		IF (
			(SELECT STATUS FROM DIER WHERE DIERID = @FokPartner) !=
			(SELECT STATUS FROM DIER WHERE DIERID = @FokDier)
		   )
		   THROW 910010, 'Een fokdossier wordt niet toegevoegd als FOKDIER een andere status heeft dan FOKPARTNER.', 1;

		--Een fokdossier wordt niet toegevoegd als een dier zich momenteel niet bevind in de FOKPLAATS 
		--(Dit geldt alleen voor locaties buiten Somerleyton, omdat daar al een andere regel via Status Gecheckt wordt.)
		IF EXISTS	(
						-- Dieren zijn in een andere dierentuin
						SELECT 1
						FROM DIER AS D
						INNER JOIN UITLEENDOSSIER AS U
						ON D.DIERID = U.DIERID
						WHERE ( D.DIERID = @FokDier OR D.DIERID = @FokPartner )
						AND U.TERUGKEERDATUM IS NULL
						AND U.ONTVANGENDEDIERENTUIN != @FokPlaats
					)
			THROW 910010, 'Een fokdossier wordt niet toegevoegd als een dier zich momenteel niet bevind in de FOKPLAATS.', 1;

		INSERT INTO FOKDOSSIER(FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS)
		VALUES (@FokDier, @FokPartner, @FokDatum, @FokPlaats)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.6 | verzorger, hoofdverzorger, kantoor medewerker | nieuw uitleen dossier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertUitleenDossier
	@DierID 				DIERID,
	@UitleenDatum 			Datum,
	@UitlenendeDierentuin 	Naam,
	@OntvangendeDierentuin 	Naam,
	@TerugkeerDatum 		Datum,
	@UitleenOpmerking		OverigeOpmerking

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		SERIALIZABLE

		-- OntvangendeDierentuin of UitlenendeDierentuin moet Somerleyton Animal Park zijn, beide is niet mogelijk
		IF (@UitlenendeDierentuin != 'Somerleyton Animal Park' AND @OntvangendeDierentuin != 'Somerleyton Animal Park'
		OR (@UitlenendeDierentuin = 'Somerleyton Animal Park' AND @OntvangendeDierentuin = 'Somerleyton Animal Park'))
		THROW 56005, 'De uitlenende of ontvangende dierentuin moet Somerleyton Animal Park zijn', 16

		-- TerugkeerDatum moet na UitleenDatum zijn
		IF (@TerugkeerDatum < @UitleenDatum)
		THROW 56005, 'De uitleendatum kan niet voor de terugkeerdatum liggen', 16

		-- UitleenDatum moet na GeboorteDatum zijn
		IF (@UitleenDatum < (
			SELECT GEBOORTEDATUM
			FROM DIER
			WHERE DIERID = @DierID)
		)
			THROW 56005, 'De geboortedatum kan niet voor de uitleendatum liggen', 16

		-- DIER: Dier met status 'Overleden' kan geen nieuwe registratie in UitleenDossier hebben
		IF EXISTS (
			SELECT 1
			FROM DIER
			WHERE DIERID = @DierID
			AND STATUS = 'Overleden'
		)
			THROW 56005, 'Een overleden dier kan niet worden uitgeleend', 16

		--UitleenDossier: Dier kan niet meerdere registraties in dezelfde periode hebben
		IF EXISTS (
			SELECT 1 
			FROM UITLEENDOSSIER U
			WHERE DIERID = @DierID AND 
			(@UitleenDatum BETWEEN U.UITLEENDATUM AND U.TERUGKEERDATUM
			OR 
			@TerugkeerDatum BETWEEN U.UITLEENDATUM AND U.TERUGKEERDATUM
			OR 
			(@UitleenDatum < U.UITLEENDATUM AND @TerugkeerDatum > U.TERUGKEERDATUM))
			
		)
			THROW 56005, 'Een dier kan in dezelfde periode niet meerdere keren worden uitgeleend', 16

		INSERT INTO UITLEENDOSSIER(DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING)
		VALUES(@DierID, @UitleenDatum, @UitlenendeDierentuin, @OntvangendeDierentuin, @TerugkeerDatum, @UitleenOpmerking)

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

-- | UC 1.23 | kantoor medewerker | nieuwe spotting toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertGespot
	@DierId 		DIERID,
	@UitzetDatum 	DATUM,
	@SpotDatum 		DATUM,
	@SpotLocatie 	Locatie

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		IF(@SpotLocatie IS NULL)
			THROW 50001, 'SpotLocatie kan niet leeg zijn', 16

		IF NOT EXISTS (
			SELECT 1
			FROM UITZETDOSSIER
			WHERE DIERID = @DierId
		)
			THROW 50001, 'Het dier komt niet voor in het UitzetDossier', 16

		IF NOT EXISTS (
			SELECT 1
			FROM UITZETDOSSIER
			WHERE DIERID = @DierId
			AND UITZETDATUM = @UitzetDatum
		)
			THROW 50001, 'De UitzetDatum komt niet overeen met de UitzetDatum in het UitzetDossier', 16

		IF (@SpotDatum < @UitzetDatum)
			THROW 50001, 'De SpotDatum kan niet eerder zijn dan de UitzetDatum', 16
		
		INSERT INTO GESPOT(DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE)
		VALUES(@DierId, @UitzetDatum, @SpotDatum, @SpotLocatie)

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

-- | UC 1.26 | dierenarts | medisch dossier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertMedischDossier
	@DierID  			DierID,
	@ControleDatum 		Datum,
	@MedewerkerID		ID,
	@VolgendeControle 	Datum = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ
		
		-- MedischDossier kan alleen gemaakt worden voor een dier na zijn geboortedatum.
		IF (@ControleDatum < (
			SELECT GEBOORTEDATUM 
			FROM DIER 
			WHERE DIERID = @DierID
		))
			THROW 910016, 'ControleDatum van een medisch dossier kan niet voor de geboorte van het betreffende dier liggen.', 1;
			
		-- MedischDossier kan niet gemaakt worden voor een dier als deze overleden is.
		IF EXISTS (
			SELECT 1 FROM DIER 
			WHERE DIERID = @DierID 
			AND STATUS = 'Overleden'
		)
			THROW 910016, 'Er kan geen nieuw medisch dossier aangemaakt worden voor een overleden dier.', 1;

		-- ControleDatum mag niet in de toekomst liggen
		IF (@ControleDatum > CURRENT_TIMESTAMP)
			THROW 910016, 'ControleDatum van een medisch dossier kan niet in de toekomst liggen.', 1;

		-- De medewerker moet een dierenarts zijn bij een medisch dossier.
		IF EXISTS(
			SELECT 1 
			FROM MEDEWERKER 
			WHERE MEDEWERKERID = @MedewerkerID 
			AND FUNCTIE != 'Dierenarts'
		)
			THROW 910016, 'De betreffende medewerker bij een medisch dossier moet altijd de functie "Dierenarts" hebben.', 1;
		
		INSERT INTO MEDISCHDOSSIER (DIERID, CONTROLEDATUM, MEDEWERKERID, VOLGENDECONTROLE)
		VALUES (@DierID, @ControleDatum, @MedewerkerID, @VolgendeControle)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.29 | hoofdverzorger | nieuwe voedingsinformatie toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertDieetInformatie
	@DierId 				DIERID,
	@VoedselSoort			VOEDSELNAAM,
	@StartDatum 			DATUM,
	@HoeveelheidPerDag 		VOEDSELHOEVEELHEID,	
	@Eenheid 				EENHEID	
 
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		IF(@HoeveelheidPerDag < 0)
			THROW 50001, 'Hoeveelheid per dag kan niet lager zijn dan 0', 16

		IF (@StartDatum < (
			SELECT GEBOORTEDATUM
			FROM DIER
			WHERE DIERID = @DierId
		))
			THROW 50001, 'De startdatum kan niet voor de geboortedatum liggen', 16

		IF EXISTS (
			SELECT 1
			FROM UITZETDOSSIER
			WHERE DIERID = @DierId
		) AND @StartDatum > (
			SELECT UITZETDATUM
			FROM UITZETDOSSIER
			WHERE DIERID = @DierId
		)
			THROW 50001, 'Dieetinformatie van een uitgezet dier kan niet worden toegevoegd', 16

		IF EXISTS (
			SELECT 1
			FROM DIER
			WHERE DIERID = @DierId
			AND [STATUS] = 'Overleden'
		)
			THROW 50001, 'Dieetinformatie van een overleden dier kan niet worden toegevoegd', 16

		INSERT INTO DIEETINFORMATIE(DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID)
		VALUES(@DierId, @VoedselSoort, @StartDatum, @HoeveelheidPerDag, @Eenheid)

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

-- | UC 1.30 | verzorger, hoofdverzorger, kantoor medewerker | ontvangen goederen toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertOntvangenGoederen
	@BESTELLINGID				ID,
	@VOEDSELSOORT 				VOEDSELNAAM,
	@ONTVANGDATUMTIJD			DATUMTIJD,
	@ONTVANGENHOEVEELHEID 		VOEDSELHOEVEELHEID,
	@VERWACHTEHOEVEELHEID 		VOEDSELHOEVEELHEID,
	@EENHEID 					EENHEID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		IF @ONTVANGDATUMTIJD < (
			SELECT BESTELDATUM 
			FROM BESTELLING 
			WHERE BESTELLINGID = @BESTELLINGID
		)
			THROW 51191, 'De Levering moet na de datum van de bestelling zijn', 16
		
		IF @EENHEID NOT IN (SELECT * FROM EENHEDEN)
			THROW 51193, 'Deze eenheid bestaat niet', 16

		IF @VERWACHTEHOEVEELHEID > (
			SELECT BESTELDEHOEVEELHEID 
			FROM BESTELLINGREGEL 
			WHERE BESTELLINGID = @BESTELLINGID AND VOEDSELSOORT = @VOEDSELSOORT
		)
			THROW 51194, 'De verwachte hoeveelheid mag niet meer zijn dan de bestelde hoeveelheid' , 16 

		IF @BESTELLINGID NOT IN (
			SELECT BESTELLINGID 
			FROM BESTELLING 
			WHERE BESTELLINGID = @BESTELLINGID
		)
			THROW 51195, 'De Levering moet voor een bestaande bestelling zijn', 16

		IF @BESTELLINGID NOT IN (
			SELECT BESTELLINGID 
			FROM BESTELLINGREGEL 
			WHERE BESTELLINGID = @BESTELLINGID 
			AND VOEDSELSOORT = @VOEDSELSOORT
		)
			THROW 51196, 'De Levering moet voor een bestaande bestellingregel zijn', 16

		IF @BESTELLINGID NOT IN (
			SELECT BESTELLINGID 
			FROM BESTELLING 
			WHERE BESTELLINGID = @BESTELLINGID 
			AND BESTELSTATUS != 'Betaald'
		)
			THROW 51197, 'De Levering waar deze bestelling voor is, is al afgerond', 16
		
		INSERT INTO LEVERINGCONTROLE(BESTELLINGID,VOEDSELSOORT,ONTVANGDATUMTIJD,ONTVANGENHOEVEELHEID,VERWACHTEHOEVEELHEID,EENHEID)
		VALUES (@BESTELLINGID,@VOEDSELSOORT,@ONTVANGDATUMTIJD,@ONTVANGENHOEVEELHEID,@VERWACHTEHOEVEELHEID,@EENHEID)

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

-- | UC 1.35 | kantoor medewerker | nieuwe bestelling toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertBestelling
	@LeverancierNaam	 Naam,
	@BestelDatum 		 Datum

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		-- Leverancier: check of leveranciernaam bekend is.
		IF NOT EXISTS(
			SELECT 1
			FROM LEVERANCIER
			WHERE LEVERANCIERNAAM = @LeverancierNaam
		)
			THROW 50001, 'Naam van leverancier niet bekend', 16

		-- BestelDatum kan niet in de toekomst liggen.
		IF (@BestelDatum > CURRENT_TIMESTAMP)
			THROW 910035, 'BestelDatum kan niet in de toekomst liggen.', 16

		INSERT INTO BESTELLING(LEVERANCIERNAAM, BESTELDATUM, BESTELSTATUS)
		VALUES(@LeverancierNaam, @BestelDatum, 'Besteld')

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

-- Stored Procedure BestellingRegel
CREATE OR ALTER PROCEDURE STP_InsertBestellingRegel
	@BestellingID			 ID,
	@VoedselSoort 			 VoedselNaam,
	@BesteldeHoeveelheid 	 VoedselHoeveelheid,
	@Prijs 					 Prijs,
	@Eenheid 				 Eenheid

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		IF NOT EXISTS(
			SELECT 1
			FROM BESTELLING
			WHERE BESTELLINGID = @BestellingID
		)
			THROW 50001, 'Bestelling is niet bekend', 16

		IF NOT EXISTS(
			SELECT 1
			FROM EENHEDEN
			WHERE EENHEID = @Eenheid
		)
			THROW 50001, 'Eenheid is niet geldig', 16

		IF NOT EXISTS(
			SELECT 1
			FROM VOEDSEL
			WHERE VOEDSELSOORT = @VoedselSoort
		)
			THROW 50001, 'Voedselsoort niet bekend', 16

		IF(@Prijs <= 0)
			THROW 50001, 'Prijs kan niet kleiner of gelijk zijn aan 0', 16

		IF(@BesteldeHoeveelheid < 1)
			THROW 50001, 'Bestelde hoeveelheid kan niet minder dan 1 zijn', 16

		IF EXISTS(
			SELECT 1
			FROM BESTELLING
			WHERE BESTELLINGID = @BestellingID
			AND BESTELSTATUS = 'Betaald'
		)
			THROW 50001, 'Deze bestelling is al betaald', 16

		INSERT INTO BESTELLINGREGEL(BESTELLINGID, VOEDSELSOORT, BESTELDEHOEVEELHEID, PRIJS, EENHEID)
		VALUES(@BestellingID, @VoedselSoort, @BesteldeHoeveelheid, @Prijs, @Eenheid)

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

-- | UC 1.44 | kantoor medewerker | nieuwe leverancier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertLeverancier
	@LeverancierNaam		Naam,
	@LeverancierPlaats		Plaats,
	@leverancierAdres		Adres

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		INSERT INTO LEVERANCIER(LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES)
		VALUES (@LeverancierNaam, @LeverancierPlaats, @leverancierAdres)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.48 | kantoor medewerker | nieuw voedselsoort toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertVoedsel
	@VoedselSoort 		VOEDSELNAAM

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		INSERT INTO VOEDSEL(VOEDSELSOORT)
		VALUES(@VoedselSoort)

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

-- | UC 1.50 | kantoor medewerker | nieuwe functie toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertFuncties
	@Functie	Functie

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		INSERT INTO FUNCTIES(FUNCTIE)
		VALUES (@Functie)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.53 | kantoor medewerker | nieuwe medewerker toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertMedewerker
	@GebiedNaam		Naam,
	@Voornaam		Naam,
	@Achternaam		Naam,
	@Functie		Functie

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		-- Gebiednaam kan niet ingevuld zijn als FUNCTIE iets anders is dan 'Verzorger' of 'Hoofdverzorger'.
		IF	(
			@GebiedNaam IS NOT NULL
			AND @Functie NOT IN ('Verzorger', 'Hoofdverzorger')
		)
			THROW 910030, 'Alleen een Medewerker met de functie "Verzorger" of "Hoofdverzorger" kan het veld Gebiednaam gevuld hebben.', 1;

		INSERT INTO MEDEWERKER(GEBIEDNAAM, VOORNAAM, ACHTERNAAM, FUNCTIE)
		VALUES (@GebiedNaam, @Voornaam, @Achternaam, @Functie)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.7 | verzorger, hoofdverzorger, kantoor medewerker | nieuw uitzet dossier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertUitzetDossier
	@DierID				DIERID,
	@UitzetDatum 		Datum,
	@UitzetLocatie 		Locatie,
	@UitzetProgramma 	Programmanummer,
	@UitzetOpmerking 	OverigeOpmerking

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		-- UitzetDatum moet na GeboorteDatum zijn.
		IF (@UitzetDatum < (
			SELECT GEBOORTEDATUM
			FROM DIER 
			WHERE DIERID = @DierID)
		)
			THROW 56005, 'De geboortedatum kan niet voor de Uitzetdatum liggen', 16

		-- DIER: Dier met status 'Overleden' kan geen nieuwe registratie in uitzetdossier krijgen.
		IF EXISTS (
			SELECT 1
			FROM DIER
			WHERE DIERID = @DierID
			AND STATUS = 'Overleden'
		)
			THROW 56005, 'Een overleden dier kan niet worden uitgeleend nadat het is uitgezet', 16

		INSERT INTO UitzetDOSSIER(DIERID, UitzetDATUM,UITZETLOCATIE,UITZETPROGRAMMA, UitzetOPMERKING)
		VALUES(@DierID, @UitzetDatum, @UitzetLocatie,@UitzetProgramma, @UitzetOpmerking)

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

-- | UC 1.6 | verzorger, hoofdverzorger, kantoor medewerker | nieuw uitleen dossier toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertDierentuin
	@DierentuinNaam			Naam,
	@Plaats					Plaats				= NULL,
	@Land					Land				= NULL,
	@Hoofdverantwoordelijke	Naam				= NULL,
	@ContactInformatie		OverigeOpmerking	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		INSERT INTO DIERENTUIN (DIERENTUINNAAM, PLAATS, LAND, HOOFDVERANTWOORDELIJKE, CONTACTINFORMATIE)
		VALUES (@DierentuinNaam, @Plaats, @Land, @Hoofdverantwoordelijke, @ContactInformatie)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.4 | verzorger, hoofdverzorger, kantoor medewerker | nieuwe diereninformatie toevoegen |
CREATE OR ALTER PROCEDURE STP_InsertSeksueeldimorfisme
	@LatijnseNaam 			NAAM,
	@Geslacht 				Geslacht,
	@Volwassenleeftijd 		Leeftijd,
	@Volwassengewicht 		gewicht,
	@Overigekenmerken 		overigeopmerking

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		IF (@LatijnseNaam LIKE '%[0-9]%')
			THROW 51036, 'Naam mag geen cijfer bevatten', 16

		INSERT INTO Seksueeldimorfisme(LATIJNSENAAM,GESLACHT,VOLWASSENLEEFTIJD,VOLWASSENGEWICHT,OVERIGEKENMERKEN)
		VALUES (@LatijnseNaam,@Geslacht,@Volwassenleeftijd,@Volwassengewicht,@Overigekenmerken)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.27 | dierenarts | medisch dossier aanpassen |
CREATE OR ALTER PROCEDURE STP_InsertDiagnoses
	@DierId				 	DIERID,
	@ControleDatum			DATUM,
	@Diagnose 				DIAGNOSE = NULL,
	@Voorschrift 			VOORSCHRIFT = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		IF (@Diagnose IS NULL AND @Voorschrift IS NULL)
			THROW 50001, 'Diagnose of voorschrift moet ingevuld zijn', 16

		INSERT INTO DIAGNOSES(DIERID, CONTROLEDATUM, DIAGNOSE, VOORSCHRIFT)
		VALUES(@DierId, @ControleDatum, @Diagnose, @Voorschrift)

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

/* ==================================================
= Use Cases Select                    			        =
================================================== */
-- | UC 1.15 | verzorger, hoofdverzorger, kantoor medewerker | uitdraaisel maken van diereninformatie |
CREATE OR ALTER PROCEDURE STP_SelectUitdraaisel
	@LatijnseNaam		NAAM 		= NULL,
	@DiersoortNaam		NAAM 		= NULL,
	@EduTekstFragment	EDUTEKST 	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT D.LATIJNSENAAM, D.NORMALENAAM, D.EDUTEKST, D.FOTO,
		S.GESLACHT, S.VOLWASSENLEEFTIJD, S.VOLWASSENGEWICHT, S.OVERIGEKENMERKEN 
		FROM DIERSOORT D INNER JOIN SEKSUEELDIMORFISME S
		ON D.LATIJNSENAAM = S.LATIJNSENAAM
		WHERE (D.LATIJNSENAAM	LIKE '%'+@LatijnseNaam+'%' 		OR @LatijnseNaam		IS NULL)
		AND	  (D.NORMALENAAM	LIKE '%'+@DiersoortNaam+'%' 	OR @DiersoortNaam		IS NULL)
		AND	  (D.EDUTEKST		LIKE '%'+@EduTekstFragment+'%'	OR @EduTekstFragment	IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.16 | verzorger, hoofdverzorger, dierenarts, kantoor medewerker | data ophalen van dier |
CREATE OR ALTER PROCEDURE STP_SelectDier
	@DierID			DierID		= NULL,
	@GebiedNaam		Naam		= NULL,
	@VerblijfID		ID			= NULL,
	@Diersoort		Naam		= NULL,
	@FokID			ID			= NULL,
	@DierNaam		Naam		= NULL,
	@Geslacht		Geslacht	= NULL,
	@Geboorteplaats	Plaats		= NULL,
	@GeboorteLand	Land		= NULL,
	@GeboorteDatum	Datum		= NULL,
	@Status			DierStatus	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT DIERID, GEBIEDNAAM, VERBLIJFID, DIERSOORT, FOKID, DIERNAAM, GESLACHT, GEBOORTEPLAATS, GEBOORTELAND, GEBOORTEDATUM, STATUS
		FROM DIER
		WHERE	(DIERID				LIKE @DierID						OR @DierID				IS NULL)
		AND		(GEBIEDNAAM			LIKE '%' + @GebiedNaam + '%'		OR @GebiedNaam			IS NULL)
		AND		(VERBLIJFID			LIKE @VerblijfID					OR @VerblijfID			IS NULL)
		AND		(DIERSOORT			LIKE '%' + @Diersoort + '%'			OR @Diersoort			IS NULL)
		AND		(FOKID				LIKE @FokID							OR @FokID				IS NULL)
		AND		(DIERNAAM			LIKE '%' + @DierNaam + '%'			OR @DierNaam			IS NULL)
		AND		(GESLACHT			LIKE @Geslacht						OR @Geslacht			IS NULL)
		AND		(GEBOORTEPLAATS		LIKE '%' + @Geboorteplaats + '%'	OR @Geboorteplaats		IS NULL)
		AND		(GEBOORTELAND		LIKE '%' + @GeboorteLand + '%'		OR @GeboorteLand		IS NULL)
		AND		(GEBOORTEDATUM		LIKE @GeboorteDatum					OR @GeboorteDatum		IS NULL)
		AND		(STATUS				LIKE '%' + @Status + '%'			OR @Status				IS NULL)	

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.17 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van gebied |
CREATE OR ALTER PROCEDURE STP_SelectGebied
	@GebiedNaam NAAM = null,
	@HoofdVerzorger ID = null
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT GEBIEDNAAM, HOOFDVERZORGER
		FROM GEBIED
		WHERE	(GEBIEDNAAM			LIKE @GebiedNaam			OR @GebiedNaam			IS NULL)
		AND		(HOOFDVERZORGER		LIKE @HoofdVerzorger		OR @HoofdVerzorger		IS NULL)
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.18 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van verblijf |
CREATE OR ALTER PROCEDURE STP_SelectVerblijf
	@GebiedNaam				Naam				= NULL,
	@VerblijfID				ID					= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT	GEBIEDNAAM, VERBLIJFID 
		FROM VERBLIJF
		WHERE	(GEBIEDNAAM	LIKE @GebiedNaam	OR @GebiedNaam		IS NULL)
		AND		(VERBLIJFID LIKE @VerblijfID	OR @VerblijfID		IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.19 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van diersoorten |
CREATE OR ALTER PROCEDURE STP_SelectDiersoort
	@LatijnseNaam		NAAM = NULL,
	@DiersoortNaam		NAAM = NULL,
	@EduTekstFragment	EDUTEKST = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO
		FROM DIERSOORT 
		WHERE (LATIJNSENAAM	LIKE '%'+ @LatijnseNaam +'%' 		OR @LatijnseNaam		IS NULL)
		AND	  (NORMALENAAM	LIKE '%'+ @DiersoortNaam +'%' 		OR @DiersoortNaam		IS NULL)
		AND	  (EDUTEKST 	LIKE '%'+ @EduTekstFragment +'%' 	OR @EduTekstFragment	IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.20 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van fokinformatie |
CREATE OR ALTER PROCEDURE STP_SelectFokDossier
	@FokId ID = NULL,
	@FokDier DIERID = NULL,
	@FokPartner DIERID = NULL,
	@FokDatum DATUM = NULL,
	@FokPlaats PLAATS = NULL
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT FOKID, FOKDIER, FOKPARTNER, FOKDATUM, FOKPLAATS
		FROM FOKDOSSIER
		WHERE	(FOKID					LIKE @FokId					OR @FokId					IS NULL)
		AND		(FOKDIER				LIKE @FokDier				OR @FokDier					IS NULL)
		AND		(FOKPARTNER				LIKE @FokPartner			OR @FokPartner				IS NULL)
		AND		(FOKDATUM				LIKE @FokDatum				OR @FokDatum				IS NULL)
		AND		(FOKPLAATS				LIKE @FokPlaats				OR @FokPlaats				IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.21 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van uitleendossier |
CREATE OR ALTER PROCEDURE STP_SelectUitleenDossier
	@DierId 				DIERID = NULL,
	@UitleenDatum 			DATUM = NULL,
	@UitlenendeDierentuin 	NAAM = NULL,
	@OntvangendeDierentuin 	NAAM = NULL,
	@TerugkeerDatum 		DATUM = NULL,
	@UitleenOpmerking 		OVERIGEOPMERKING = NULL
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT DIERID, UITLEENDATUM, UITLENENDEDIERENTUIN, ONTVANGENDEDIERENTUIN, TERUGKEERDATUM, UITLEENOPMERKING
		FROM UITLEENDOSSIER
		WHERE	(DIERID					LIKE @DierId				OR @DierId					IS NULL)
		AND		(UITLEENDATUM			LIKE @UitleenDatum			OR @UitleenDatum			IS NULL)
		AND		(UITLENENDEDIERENTUIN	LIKE @UitlenendeDierentuin	OR @UitlenendeDierentuin	IS NULL)
		AND		(ONTVANGENDEDIERENTUIN	LIKE @OntvangendeDierentuin OR @OntvangendeDierentuin	IS NULL)
		AND		(TERUGKEERDATUM			LIKE @TerugkeerDatum		OR @TerugkeerDatum			IS NULL)
		AND		(UITLEENOPMERKING		LIKE @UitleenOpmerking		OR @UitleenOpmerking		IS NULL)
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.22 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van uitzetdossier |
CREATE OR ALTER PROCEDURE STP_SelectUitzetDossier
	@DierID					DierID				= NULL,
	@UitzetDatum			Datum				= NULL,
	@UitzetLocatie			Locatie				= NULL,
	@UitzetProgramma		ProgrammaNummer		= NULL,
	@UitzetOpmerking		OverigeOpmerking	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT DIERID, UITZETDATUM, UITZETLOCATIE, UITZETPROGRAMMA, UITZETOPMERKING
		FROM UITZETDOSSIER
		WHERE	(DIERID				LIKE @DierID				OR @DierID			IS NULL)
		AND		(UITZETDATUM		LIKE @UitzetDatum			OR @UitzetDatum		IS NULL)
		AND		(UITZETLOCATIE		LIKE '%' + @UitzetLocatie + '%'	OR @UitzetLocatie	IS NULL)
		AND		(UITZETPROGRAMMA	LIKE '%' + @UitzetProgramma + '%'	OR @UitzetProgramma	IS NULL)
		AND		(UITZETOPMERKING	LIKE '%' + @UitzetOpmerking + '%'	OR @UitzetOpmerking IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.25 | kantoor medewerker | data ophalen van spotting |
CREATE OR ALTER PROCEDURE STP_SelectSpotting
	@DierID				DIERID		= NULL,
	@UitzetDatum		DATUM 		= NULL,
	@SpotDatum			DATUM		= NULL,
	@SpotLocatie		LOCATIE		= NULL
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT DIERID, UITZETDATUM, SPOTDATUM, SPOTLOCATIE
		FROM GESPOT
		WHERE (DIERID		LIKE '%'+ @DierID +'%' 		OR @DierID			IS NULL)
		AND	  (UITZETDATUM	LIKE @UitzetDatum			OR @UitzetDatum		IS NULL)
		AND	  (SPOTDATUM 	LIKE @SpotDatum 			OR @SpotDatum		IS NULL)
		AND   (SPOTLOCATIE	LIKE '%'+ @SpotLocatie +'%' OR @SpotLocatie		IS NULL)
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.28 | dierenarts, kantoor medewerker | data ophalen van medisch dossier |
CREATE OR ALTER PROCEDURE STP_SelectMedischDossier
	@DierId DIERID = NULL,
	@DatumControle DATUM = NULL,
	@MedewerkerId ID = NULL,
	@VolgendeControle DATUM = NULL
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT M.DIERID, M.CONTROLEDATUM, M.MEDEWERKERID, M.VOLGENDECONTROLE, D.DIAGNOSE, D.VOORSCHRIFT, D.OBSERVATIEID
		FROM MEDISCHDOSSIER M
		LEFT JOIN DIAGNOSES D ON M.CONTROLEDATUM = D.CONTROLEDATUM
		AND D.DIERID = M.DIERID
		WHERE	(M.DIERID					LIKE @DierId				OR @DierId					IS NULL)
		AND		(M.CONTROLEDATUM			LIKE @DatumControle			OR @DatumControle			IS NULL)
		AND		(M.MEDEWERKERID				LIKE @MedewerkerId			OR @MedewerkerId			IS NULL)
		AND		(M.VOLGENDECONTROLE			LIKE @VolgendeControle		OR @VolgendeControle		IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.32 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van voedingsinformatie |
CREATE OR ALTER PROCEDURE STP_SelectDieetInformatie
	@DierId DIERID = NULL,
	@VoedselSoort VOEDSELNAAM = NULL,
	@Startdatum DATUM = NULL,
	@HoeveelheidPerDag VOEDSELHOEVEELHEID = NULL,
	@Eenheid EENHEID = NULL
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT DIERID, VOEDSELSOORT, STARTDATUM, HOEVEELHEIDPERDAG, EENHEID
		FROM DIEETINFORMATIE
		WHERE	(DIERID						LIKE @DierId				OR @DierId					IS NULL)
		AND		(VOEDSELSOORT				LIKE @VoedselSoort			OR @VoedselSoort			IS NULL)
		AND		(STARTDATUM					LIKE @Startdatum			OR @Startdatum				IS NULL)
		AND		(HOEVEELHEIDPERDAG			LIKE @HoeveelheidPerDag		OR @HoeveelheidPerDag		IS NULL)
		AND		(EENHEID					LIKE @Eenheid				OR @Eenheid					IS NULL)
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.34 | verzorger, hoofdverzorger, kantoor medewerker | data ophalen van ontvangen goederen |
CREATE OR ALTER PROCEDURE STP_SelectLeveringControle
	@BestellingID			ID					= NULL,
	@VoedselSoort			VoedselNaam			= NULL,
	@OntvangenDatumTijd		DatumTijd			= NULL,
	@OntvangenHoeveelheid	VoedselHoeveelheid	= NULL,
	@VerwachteHoeveelheid	VoedselHoeveelheid	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT BESTELLINGID, VOEDSELSOORT, ONTVANGDATUMTIJD, ONTVANGENHOEVEELHEID, VERWACHTEHOEVEELHEID, EENHEID
		FROM LEVERINGCONTROLE
		WHERE	(BESTELLINGID			LIKE @BestellingID					OR @BestellingID			IS NULL)
		AND		(VOEDSELSOORT			LIKE '%' + @VoedselSoort + '%'		OR @VoedselSoort			IS NULL)
		AND		(ONTVANGDATUMTIJD		LIKE @OntvangenDatumTijd			OR @OntvangenDatumTijd		IS NULL)
		AND		(ONTVANGENHOEVEELHEID	LIKE @OntvangenHoeveelheid			OR @OntvangenHoeveelheid	IS NULL)
		AND		(VERWACHTEHOEVEELHEID	LIKE @VerwachteHoeveelheid			OR @VerwachteHoeveelheid	IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.39 | kantoor medewerker | data ophalen van bestelling |
CREATE OR ALTER PROCEDURE STP_SelectBestelling
	@BestellingID		ID				= NULL,
	@LeverancierNaam	NAAM 			= NULL,
	@BestelDatum		DATUM			= NULL,
	@BestelStatus		BESTELSTATUS	= NULL,
	@BetaalDatum		DATUM			= NULL,
	@VoedselSoort		VOEDSELNAAM		= NULL
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT B.BESTELLINGID, B.LEVERANCIERNAAM, B.BESTELDATUM, B.BESTELSTATUS, B.BETAALDATUM,
		R.VOEDSELSOORT, R. BESTELDEHOEVEELHEID, R.PRIJS, R.EENHEID
		FROM BESTELLING B INNER JOIN BESTELLINGREGEL R ON B.BESTELLINGID = R.BESTELLINGID
		WHERE (B.BESTELLINGID 		LIKE @BestellingID				OR @BestellingID			IS NULL)
		AND	  (B.LEVERANCIERNAAM	LIKE '%'+@LeverancierNaam+'%' 	OR @LeverancierNaam			IS NULL)
		AND   (B.BESTELDATUM		LIKE @BestelDatum				OR @BestelDatum				IS NULL)
		AND   (B.BESTELSTATUS		LIKE @BestelStatus				OR @BestelStatus			IS NULL)
		AND   (B.BETAALDATUM		LIKE @BetaalDatum				OR @BetaalDatum				IS NULL)
		AND   (R.VOEDSELSOORT		LIKE '%'+@VoedselSoort+'%'		OR @VoedselSoort			IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.40 | kantoor medewerker | ophalen status van bestelling |
CREATE OR ALTER PROCEDURE STP_SelectBestellingStatus
	@BestellingID 	ID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT BESTELSTATUS
		FROM BESTELLING
		WHERE BESTELLINGID = @BestellingID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.43 | kantoor medewerker | data ophalen van een medewerker |
CREATE OR ALTER PROCEDURE STP_SelectMedewerker
	@MedewerkerID	ID			= NULL,
	@GebiedNaam		Naam		= NULL,
	@Voornaam		Naam		= NULL,
	@Achternaam		Naam		= NULL,
	@Functie		Functie		= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT MEDEWERKERID, VOORNAAM, ACHTERNAAM, FUNCTIE, GEBIEDNAAM
		FROM MEDEWERKER
		WHERE	(MEDEWERKERID			LIKE @MedewerkerID					OR @MedewerkerID			IS NULL)
		AND		(GEBIEDNAAM				LIKE '%' + @GebiedNaam + '%'		OR @GebiedNaam				IS NULL)
		AND		(VOORNAAM				LIKE '%' + @Voornaam + '%'			OR @Voornaam				IS NULL)
		AND		(ACHTERNAAM				LIKE '%' + @Achternaam + '%'		OR @Achternaam				IS NULL)
		AND		(FUNCTIE				LIKE @Functie						OR @Functie					IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.46 | kantoor medewerker | data ophalen van leverancier |
CREATE OR ALTER PROCEDURE STP_SelectLeverancier
	@LeverancierNaam	NAAM 				= NULL,
	@LeverancierPlaats	PLAATS				= NULL,
	@LeverancierAdres	Adres				= NULL,
	@ContactInformatie	OverigeOpmerking	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SELECT LEVERANCIERNAAM, LEVERANCIERPLAATS, LEVERANCIERADRES, CONTACTINFORMATIE
		FROM LEVERANCIER
		WHERE (LEVERANCIERNAAM		LIKE '%'+@LeverancierNaam+'%' 	OR @LeverancierNaam		IS NULL)
		AND	  (LEVERANCIERPLAATS	LIKE '%'+@LeverancierPlaats+'%' OR @LeverancierPlaats	IS NULL)
		AND   (LEVERANCIERADRES		LIKE '%'+@LeverancierAdres+'%'	OR @LeverancierAdres	IS NULL)
		AND   (CONTACTINFORMATIE	LIKE '%'+@ContactInformatie+'%'	OR @ContactInformatie	IS NULL)

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.47 | kantoor medewerker | data ophalen over voedselsoorten |
CREATE OR ALTER VIEW VW_SelectVoedsel AS
	SELECT VOEDSELSOORT
	FROM VOEDSEL
GO

-- | UC 1.49 | kantoor medewerker | data ophalen van functies |
CREATE OR ALTER VIEW VW_SelectFuncties AS
	SELECT FUNCTIE
	FROM FUNCTIES
GO

/* ==================================================
= Use Cases Update                     			        =
================================================== */
-- | UC 1.8 | verzorger, hoofdverzorger, kantoor medewerker | dier aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateDier
	@OudDierID			DierID,
	@DierID				DierID,
	@GebiedNaam			Naam		= NULL,
	@Verblijf			ID			= NULL,
	@Diersoort			Naam,
	@FokID				ID			= NULL,
	@DierNaam			Naam,
	@Geslacht			Geslacht,
	@Geboorteplaats		Plaats		= NULL,
	@GeboorteLand		Land		= NULL,
	@GeboorteDatum		Datum		= NULL,
	@Status				DierStatus

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE DIER
		SET	DIERID			= @DierID,
			GEBIEDNAAM		= @GebiedNaam,
			VERBLIJFID		= @Verblijf,
			DIERSOORT		= @Diersoort,
			FOKID			= @FokID,
			DIERNAAM		= @DierNaam,
			GESLACHT		= @Geslacht,
			GEBOORTEPLAATS	= @Geboorteplaats,
			GEBOORTELAND	= @GeboorteLand,
			GEBOORTEDATUM	= @GeboorteDatum,
			STATUS			= @Status
		WHERE DIERID	= @OudDierID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.9 | verzorger, hoofdverzorger, kantoor medewerker | gebied aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateGebied
    @OudeGebiedNaam 	Naam,
    @NieuwGebiedNaam 	Naam

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE GEBIED
		SET GEBIEDNAAM = @NieuwGebiedNaam
		WHERE GEBIEDNAAM = @OudeGebiedNaam
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.10 | verzorger, hoofdverzorger, kantoor medewerker | verblijf aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateVerblijf
    @OudGebiedNaam 	Naam,
    @VerblijfID 	ID,
    @GebiedNaam 	Naam

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		-- @GebiedNaam moet bestaan in GEBIED voordat het een VERBLIJF kan hebben.
		IF NOT EXISTS (
			SELECT 1 
			FROM GEBIED 
			WHERE GEBIEDNAAM = @GebiedNaam
		)
			THROW 910006, 'Een verblijf moet deel zijn van een bestaand gebied.', 1;

	    UPDATE VERBLIJF
		SET GEBIEDNAAM = @GebiedNaam
		WHERE GEBIEDNAAM = @OudGebiedNaam 
		AND VERBLIJFID = @VerblijfID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.11 | verzorger, hoofdverzorger, kantoor medewerker | diereninformatie aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateDiersoort
	@OudLatijnseNaam 		NAAM,
	@LatijnseNaam 			NAAM,
	@NormaleNaam 			NAAM 		= NULL,
	@EduTekst 				EDUTEKST 	= NULL,
	@Foto 					LINK 		= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE DIERSOORT
		SET LATIJNSENAAM 	= @LatijnseNaam,
			NORMALENAAM		= @NormaleNaam,
			EDUTEKST 		= @EduTekst,
			FOTO 			= @Foto
		WHERE LATIJNSENAAM = @OudLatijnseNaam

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.12 | verzorger, hoofdverzorger, kantoor medewerker | fokdossier aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateFokdossier
	@FokID				ID,
	@Fokdier			DierID,
	@Fokpartner			DierID		= NULL,
	@Fokdatum			Datum		= NULL,
	@Fokplaats			Plaats		= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE FOKDOSSIER
		SET	FOKDIER		= @Fokdier,
			FOKPARTNER	= @Fokpartner,
			FOKDATUM	= @Fokdatum,
			FOKPLAATS	= @Fokplaats
		WHERE FOKID = @FokID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.13 | verzorger, hoofdverzorger, kantoor medewerker | uitleendossier aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateUitleenDossier
	@OudDierID 				DIERID,
	@OudUitleenDatum 		DATUM,
	@DierID 				DIERID,
	@UitleenDatum 			DATUM,
	@UitlenendeDierentuin 	NAAM,
	@OntvangendeDierentuin 	NAAM,
	@TerugkeerDatum 		DATUM = NULL,
	@UitleenOpmerking 		OVERIGEOPMERKING = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		SERIALIZABLE

		--OntvangendeDierentuin of UitlenendeDierentuin moet Somerleyton Animal Park zijn, beide is niet mogelijk
		IF ((@UitlenendeDierentuin != 'Somerleyton Animal Park' AND @OntvangendeDierentuin != 'Somerleyton Animal Park')
		OR (@UitlenendeDierentuin = 'Somerleyton Animal Park' AND @OntvangendeDierentuin = 'Somerleyton Animal Park'))
		THROW 56005, 'De uitlenende of ontvangende dierentuin moet Somerleyton Animal Park zijn', 16

		--TerugkeerDatum moet na UitleenDatum liggen
		IF (@TerugkeerDatum < @UitleenDatum)
			THROW 56005, 'De uitleendatum kan niet voor de terugkeerdatum liggen', 16

		--UitleenDatum moet na GeboorteDatum liggen
		IF (@UitleenDatum < (
			SELECT GEBOORTEDATUM
			FROM DIER 
			WHERE DIERID = @DierID)
		)
			THROW 56005, 'De geboortedatum kan niet voor de uitleendatum liggen', 16

		--DIER: Dier met status 'Overleden' mag geen nieuwe registraties krijgen in uitleendossier
		IF EXISTS (
			SELECT 1
			FROM DIER
			WHERE DIERID = @DierID
			AND STATUS = 'Overleden'
		)
			THROW 56005, 'Een overleden dier kan niet worden uitgeleend', 16

		-- UitleenDossier: Dier kan niet meerdere registraties binnen een periode krijgen
		IF EXISTS (
			SELECT 1 
			FROM UITLEENDOSSIER U
			WHERE (
				(DIERID != @OudDierID OR UITLEENDATUM != @OudUitleenDatum) AND
				(@UitleenDatum BETWEEN U.UITLEENDATUM AND U.TERUGKEERDATUM
				OR 
				@TerugkeerDatum BETWEEN U.UITLEENDATUM AND U.TERUGKEERDATUM
				OR 
				(@UitleenDatum < U.UITLEENDATUM AND @TerugkeerDatum > U.TERUGKEERDATUM))
			)	
		)
			THROW 56005, 'Een dier kan in dezelfde periode niet meerdere keren worden uitgeleend', 16

		UPDATE UITLEENDOSSIER
		SET DIERID = @DierID,
			UITLEENDATUM = @UitleenDatum,
			UITLENENDEDIERENTUIN = @UitlenendeDierentuin,
			ONTVANGENDEDIERENTUIN = @OntvangendeDierentuin,
			TERUGKEERDATUM = @TerugkeerDatum,
			UITLEENOPMERKING = @UitleenOpmerking
		WHERE DIERID = @OudDierID 
		AND UITLEENDATUM = @OudUitleendatum
		
		IF EXISTS (
			SELECT 1 
			FROM DIER
			WHERE DIERID = @DierID
		)
			UPDATE DIER
			SET STATUS = 'Uitgeleend'
			WHERE DIERID = @DierID


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

-- | UC 1.14 | verzorger, hoofdverzorger, kantoor medewerker | uitzetdossier aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateUitzetDossier
	@OudDierID 			DIERID,
	@OudUitzetDatum 	Datum,
	@DierID 			DIERID,
	@UitzetDatum 		Datum,
	@UitzetLocatie 		Locatie 			= NULL,
	@UitzetProgramma 	Programmanummer 	= NULL,
	@UitzetOpmerking 	OverigeOpmerking	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		--UitzetDatum moet voor geboortedatum zijn
		IF(@UitzetDatum < (
			SELECT GEBOORTEDATUM
			FROM DIER 
			WHERE DIERID = @OudDierID
		))
			THROW 56005, 'De geboortedatum kan niet na de Uitzetdatum liggen', 16


		--DIER: Dier met status overleden kan geen nieuwe registratie hebben
		IF EXISTS(
			SELECT 1
			FROM DIER
			WHERE DIERID = @DierID
			AND STATUS = 'Overleden'
		)
			THROW 56005, 'Een overleden dier kan niet worden uitgezet', 16

		UPDATE UITZETDOSSIER
		SET DIERID = @DierID,
			UITZETDATUM = @UitzetDatum,
			UITZETLOCATIE = @UitzetLocatie,
			UITZETPROGRAMMA = @UitzetProgramma,
			UitzetOPMERKING = @UitzetOpmerking
		WHERE DIERID = @OudDierID 
		AND UITZETDATUM = @OudUitzetdatum

		IF EXISTS (
			SELECT 1 
			FROM DIER
			WHERE DIERID = @DierID
		)
			UPDATE DIER
			SET STATUS = 'Uitgezet'
			WHERE DIERID = @DierID

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

-- | UC 1.24 | kantoor medewerker | spotting aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateGespot
	@OudDierID 		ID,
	@OudUitzetDatum 	DATUM,
	@OudSpotDatum 		DATUM,
	@NieuweDierID 		ID,
	@NieuweUitzetDatum 	DATUM,
	@NieuweSpotDatum 	DATUM,
	@NieuweSpotLocatie 	LOCATIE

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE GESPOT
		SET DIERID = @NieuweDierID,
			UITZETDATUM = @NieuweUitzetDatum,
			SPOTDATUM = @NieuweSpotDatum,
			SPOTLOCATIE = @NieuweSpotLocatie
		WHERE DIERID = @OudDierID
		AND UITZETDATUM = @OudUitzetDatum
		AND SPOTDATUM = @OudSpotDatum

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.31 | hoofdverzorger | dieetinformatie aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateDieetinformatie
	@OudDierID			DierID,
	@OudVoedselSoort	VoedselNaam,
	@OudStartdatum		Datum,
	@DierID				DierID,
	@VoedselSoort		VoedselNaam,
	@StartDatum			Datum,
	@HoeveelheidPerDag	VoedselHoeveelheid,
	@Eenheid			Eenheid

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE DIEETINFORMATIE
		SET DIERID				= @DierID,
			VOEDSELSOORT		= @VoedselSoort,
			STARTDATUM			= @StartDatum,
			HOEVEELHEIDPERDAG	= @HoeveelheidPerDag,
			EENHEID				= @Eenheid
		WHERE DIERID 			= @OudDierID
		AND   VOEDSELSOORT		= @OudVoedselSoort
		AND   STARTDATUM		= @OudStartdatum
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.27 | dierenarts | medisch dossier aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateMedischDossier
	@OudDierId 				DIERID,
	@OudDatumControle 		DATUM,
	@DierID		 			DIERID,
	@DatumControle 			DATUM,
	@MedewerkerID 			ID,
	@VolgendeControle 		DATUM = NULL
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE MEDISCHDOSSIER
		SET DIERID = @DierID,
			CONTROLEDATUM = @DatumControle,
			MEDEWERKERID = @MedewerkerID,
			VOLGENDECONTROLE = @VolgendeControle
		WHERE DIERID = @OudDierId
		AND CONTROLEDATUM = @OudDatumControle

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.33 | verzorger, hoofdverzorger, kantoor medewerker | ontvangen goederen aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateOntvangenGoederen
    @OudBestellingID 		ID,
	@OudVoedselSoort 		VOEDSELNAAM,
    @OudOntvangDatumTijd 	DATUMTIJD,
	@BestellingID 			ID,
	@VoedselSoort 			VOEDSELNAAM,
	@OntvangDatumTijd 		DATUMTIJD,
	@OntvangenHoeveelheid 	VOEDSELHOEVEELHEID = NULL,
	@VerwachteHoeveelheid 	VOEDSELHOEVEELHEID = NULL,
	@Eenheid 				EENHEID = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		IF @OntvangDatumTijd < (
			SELECT BESTELDATUM 
			FROM BESTELLING 
			WHERE BESTELLINGID = @BestellingID
		)
			THROW 51191, 'De Levering moet na de datum van de bestelling zijn', 16
		
		-- Foreign key
		IF @Eenheid NOT IN (SELECT * FROM EENHEDEN)
			THROW 51193, 'Deze eenheid bestaat niet' , 16

		IF @VerwachteHoeveelheid > (
			SELECT BESTELDEHOEVEELHEID 
			FROM BESTELLINGREGEL 
			WHERE BESTELLINGID = @BestellingID
		)
			THROW 51194, 'De verwachte hoeveelheid mag niet meer zijn dan de bestelde hoeveelheid' , 16 

		-- Foreign key
		IF @BestellingID NOT IN (
			SELECT BESTELLINGID 
			FROM BESTELLING 
			WHERE BESTELLINGID = @BestellingID
		)
			THROW 51195, 'De Levering moet voor een bestaande bestelling zijn', 16

		-- Foreign key
		IF @BestellingID NOT IN (
			SELECT BESTELLINGID 
			FROM BESTELLINGREGEL 
			WHERE BESTELLINGID = @BestellingID 
			AND VOEDSELSOORT = @VoedselSoort
		)
			THROW 51196, 'De Levering moet voor een bestaande bestellingregel zijn', 16

		IF @BestellingID NOT IN (
			SELECT BESTELLINGID 
			FROM BESTELLING 
			WHERE BESTELLINGID = @BestellingID 
			AND BESTELSTATUS != 'Betaald'
		)
			THROW 51197, 'De Levering waar deze bestelling voor is, is al afgerond', 16
		
		UPDATE LEVERINGCONTROLE
		SET BESTELLINGID 			= @BestellingID,
			VOEDSELSOORT 			= @VoedselSoort,
			ONTVANGDATUMTIJD 		= @OntvangDatumTijd,
			ONTVANGENHOEVEELHEID 	= @OntvangenHoeveelheid,
			VERWACHTEHOEVEELHEID 	= @VerwachteHoeveelheid,
			EENHEID 				= @Eenheid
		WHERE BESTELLINGID = @OudBestellingID
		AND	VOEDSELSOORT = @OudVoedselSoort
		AND	ONTVANGDATUMTIJD = @OudOntvangDatumTijd

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

-- | UC 1.36 | kantoor medewerker | bestelling als betaald zetten |
CREATE OR ALTER PROCEDURE STP_UpdateStatusBestelling
	@BestellingId 		ID,
	@BestelStatus 		BESTELSTATUS,
	@BetaalDatum 		DATUM = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		IF @BestelStatus = 'Betaald' AND (
			SELECT BESTELSTATUS  
			FROM BESTELLING
			WHERE BESTELLINGID = @BestellingId
		) = 'Besteld'
			THROW 50001, 'Deze bestelling kan nog niet betaald worden. De bestelling is nog niet (volledig) ontvangen', 16

		IF @BestelStatus = 'Besteld' AND (
			SELECT BESTELSTATUS  
			FROM BESTELLING
			WHERE BESTELLINGID = @BestellingId
		) = 'Betaling_Nodig' 
			THROW 50001, 'Deze overgang is niet mogelijk, bestelling kan alleen nog betaald worden', 16

		IF @BestelStatus = 'Besteld' AND (
			SELECT BESTELSTATUS  
			FROM BESTELLING
			WHERE BESTELLINGID = @BestellingId
		) = 'Betaald'
			THROW 50001, 'Deze overgang is niet mogelijk, bestelling is al volledig ontvangen', 16

		UPDATE BESTELLING
		SET BESTELSTATUS = @BestelStatus,
			BETAALDATUM = @BetaalDatum
		WHERE BESTELLINGID = @BestellingId

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.37 | kantoor medewerker | bestelling aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateBestelling
	@BestellingID		ID,
	@LeverancierNaam	Naam,
	@BestelDatum		Datum,
	@BetaalDatum		Datum			= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		--Check BESTELDATUM niet in de toekomst
		IF (@BestelDatum > CURRENT_TIMESTAMP)
			THROW 930026, 'BestelDatum kan niet in de toekomst liggen.', 16
		
		--Check BETAALDATUM niet in de toekomst
		IF (@BetaalDatum > CURRENT_TIMESTAMP)
			THROW 930026, 'BetaalDatum kan niet in de toekomst liggen.', 16

		UPDATE BESTELLING
		SET LEVERANCIERNAAM			= @LeverancierNaam,
			BESTELDATUM				= @BestelDatum,
			BETAALDATUM				= @BetaalDatum
		WHERE BESTELLINGID			= @BestellingID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.38 | kantoor medewerker | bestellingvoedsel aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateBestellingRegel
	@OudBestellingID			ID,						-- Kan niet worden geupdate maar is nodig voor primary key
	@OudVoedselSoort		VoedselNaam,
	@VoedselSoort			VoedselNaam,
	@BesteldeHoeveelheid	VoedselHoeveelheid,
	@Prijs					Prijs,
	@Eenheid				Eenheid

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE BESTELLINGREGEL
		SET VOEDSELSOORT			= @VoedselSoort,
			BESTELDEHOEVEELHEID		= @BesteldeHoeveelheid,
			PRIJS					= @Prijs,
			EENHEID					= @Eenheid
		WHERE BESTELLINGID			= @OudBestellingID
		AND VOEDSELSOORT			= @OudVoedselSoort

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.41 | kantoor medewerker | de hoofdverzorger van een gebied aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateHoofdverzorger
    @GebiedNaam 			Naam,
	@NieuweHoofdverzorger 	ID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ

		IF EXISTS (
			SELECT 1 
			FROM GEBIED 
			WHERE HOOFDVERZORGER = @NieuweHoofdverzorger
		)
			THROW 50329,'Deze hoofdverzorger heeft al een gebied',16

		UPDATE GEBIED
		SET HOOFDVERZORGER = @NieuweHoofdverzorger
		WHERE GEBIEDNAAM = @GebiedNaam
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.42 | kantoor medewerker | het gebied van een verzorger aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateGebiedVerzorger
	@MedewerkerID 		ID,
	@GebiedNaam 		NAAM = NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		SET TRANSACTION ISOLATION LEVEL
		REPEATABLE READ
		
		IF NOT EXISTS(
			SELECT FUNCTIE
			FROM MEDEWERKER
			WHERE MEDEWERKERID = @MedewerkerID
			AND (FUNCTIE = 'Verzorger' 
			OR FUNCTIE = 'Hoofdverzorger')
		)
			THROW 50001, 'De medewerker is geen (hoofd)verzorger en kan geen gebiedsnaam hebben', 16

		UPDATE MEDEWERKER
		SET GEBIEDNAAM = @GebiedNaam
		WHERE MEDEWERKERID = @MedewerkerID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.45 | kantoor medewerker | leverancier aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateLeveranciers
	@OudLeverancierNaam		Naam,
	@LeverancierNaam	Naam,
	@LeverancierPlaats		Plaats				= NULL,
	@LeverancierAdres		Adres				= NULL,
	@ContactInformatie		OverigeOpmerking	= NULL

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE LEVERANCIER
		SET LEVERANCIERNAAM			= @LeverancierNaam,
			LEVERANCIERPLAATS		= @LeverancierPlaats,
			LEVERANCIERADRES		= @LeverancierAdres,
			CONTACTINFORMATIE		= @ContactInformatie
		WHERE LEVERANCIERNAAM		= @OudLeverancierNaam

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.51 | kantoor medewerker | voedselsoorten aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateVoedselsoort
	@OudVoedselSoort		VoedselNaam,
	@NieuwVoedselSoort		VoedselNaam

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		UPDATE VOEDSEL
		SET VOEDSELSOORT	= @NieuwVoedselSoort
		WHERE VOEDSELSOORT	= @OudVoedselSoort

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.52 | kantoor medewerker | functies aanpassen |
CREATE OR ALTER PROCEDURE STP_UpdateFuncties
    @OudeFunctie 		FUNCTIE,
	@NieuweFunctie 		FUNCTIE

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		IF EXISTS (
			SELECT 1 
			FROM FUNCTIES 
			WHERE FUNCTIE = @NieuweFunctie
		)
			THROW 50138,'Deze functie bestaat al.',16;

		UPDATE Functies
		SET FUNCTIE 	= @NieuweFunctie
		WHERE FUNCTIE 	= @OudeFunctie
		
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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

/* ==================================================
= Use Cases Delete                    			    =
================================================== */ 
-- | UC 1.8 | verzorger, hoofdverzorger, kantoor medewerker | dier aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteDier
	@DierID 		DIERID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM DIER 
		WHERE DIERID = @DierID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.9 | verzorger, hoofdverzorger, kantoor medewerker | gebied aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteGebied
	@GebiedNaam			Naam

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM GEBIED
		WHERE GEBIEDNAAM = @GebiedNaam

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.10 | verzorger, hoofdverzorger, kantoor medewerker | verblijf aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteVerblijf
	@GEBIEDNAAM 		NAAM,
	@VERBLIJFID 		ID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;


		DELETE FROM VERBLIJF
		WHERE GEBIEDNAAM = @GEBIEDNAAM
		AND VERBLIJFID = @VERBLIJFID


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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE STP_DeleteDiersoort
	@LatijnseNaam		 NAAM	

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE 
		FROM DIERSOORT
		WHERE LATIJNSENAAM = @LatijnseNaam

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

-- | UC 1.12 | verzorger, hoofdverzorger, kantoor medewerker | fokdossier aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteFokDossier
	@FOKID		ID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM FokDossier 
		WHERE FOKID = @FOKID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.13 | verzorger, hoofdverzorger, kantoor medewerker | uitleendossier aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteUitleendossier
	@DierID				DierID,
	@UitleenDatum		Datum

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM UITLEENDOSSIER
		WHERE DIERID		= @DierID
		AND UITLEENDATUM	= @UitleenDatum

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.14 | verzorger, hoofdverzorger, kantoor medewerker | uitzetdossier aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteUitzetdossier
	@DierID				DierID,
	@UitzetDatum		Datum

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM UitzetDOSSIER
		WHERE DIERID		= @DierID
		AND UitzetDATUM	= @UitzetDatum

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.24 | kantoor medewerker | spotting aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteGespot
	@DierId 			DIERID,
	@UitzetDatum 		DATUM,
	@SpotDatum 			DATUM		

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE 
		FROM GESPOT
		WHERE DIERID = @DierId 
		AND UITZETDATUM = @UitzetDatum
		AND SPOTDATUM = @SpotDatum

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

-- | UC 1.27 | dierenarts | medisch dossier aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteMedischDossier
	@DIERID 			DIERID,
	@CONTROLEDATUM 		DATUM

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM MEDISCHDOSSIER
		WHERE DIERID = @DIERID
		AND CONTROLEDATUM = @CONTROLEDATUM

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.33 | verzorger, hoofdverzorger, kantoor medewerker | ontvangen goederen aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteOntvangenGoederen
	@BestellingID			ID,
	@VoedselSoort			VoedselNaam,
	@OntvangenDatumTijd		DatumTijd

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM LEVERINGCONTROLE
		WHERE	BESTELLINGID		= @BestellingID
		AND		VOEDSELSOORT		= @VoedselSoort
		AND		ONTVANGDATUMTIJD	= @OntvangenDatumTijd

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.37 | kantoor medewerker | bestelling aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteBestelling
	@BestellingID		ID

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM BESTELLING
		WHERE	BESTELLINGID = @BestellingID

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.38 | kantoor medewerker | bestellingvoedsel aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteBestellingRegel
	@BestellingID		 ID,
	@VoedselSoort		 VOEDSELNAAM

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE
		FROM BESTELLINGREGEL
		WHERE BESTELLINGID = @BestellingID
		AND VOEDSELSOORT = @VoedselSoort

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

-- | UC 1.45 | kantoor medewerker | leverancier aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteLeverancier
	@Leveranciernaam 		Naam

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM Leverancier
		WHERE LEVERANCIERNAAM = @Leveranciernaam

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.51 | kantoor medewerker | voedselsoorten aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteVoedsel
	@VoedselSoort			VOEDSELNAAM,
	@NewVoedselSoort 		VOEDSELNAAM = null

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		IF @NewVoedselSoort IS NULL AND (SELECT COUNT(*) FROM DIEETINFORMATIE WHERE VOEDSELSOORT = @VoedselSoort) >= 1
		THROW 51041 , 'Een dier heeft dit voedsel nog als dieet, verwijder eerst de dieetinformatie of geef een vervangende functie mee' ,16

		IF @NewVoedselSoort IS NULL AND (SELECT COUNT(*) FROM DIEETINFORMATIE WHERE VOEDSELSOORT = @VoedselSoort) = 0
		DELETE FROM VOEDSEL
		WHERE VOEDSELSOORT = @VoedselSoort

		IF @NewVoedselSoort IS NOT NULL AND (SELECT COUNT(*) FROM VOEDSEL WHERE VOEDSELSOORT = @NewVoedselSoort) >= 1
        THROW 51042 , 'Deze nieuwe voedselsoort bestaat al' ,16
		
		IF @NewVoedselSoort IS NOT NULL AND (SELECT COUNT(*) FROM VOEDSEL WHERE VOEDSELSOORT = @NewVoedselSoort) = 0
        UPDATE VOEDSEL
		SET VOEDSELSOORT = @NewVoedselSoort
		WHERE VOEDSELSOORT = @VoedselSoort
		UPDATE DIEETINFORMATIE
		SET VOEDSELSOORT = @NewVoedselSoort
		WHERE VOEDSELSOORT = @VoedselSoort
		

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.52 | kantoor medewerker | functies aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteFunctie
	@FUNCTIE		FUNCTIE,
	@NEWFUNCTIE 	FUNCTIE = null

AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		IF @NEWFUNCTIE IS NULL AND (SELECT COUNT(*) FROM MEDEWERKER WHERE FUNCTIE = @FUNCTIE) >= 1
		THROW 51041 , 'Een medewerker heeft deze functie nog, verwijder eerst de medewerker of geef een vervangende functie mee' ,16

		IF @NEWFUNCTIE IS NULL AND (SELECT COUNT(*) FROM MEDEWERKER WHERE FUNCTIE = @FUNCTIE) = 0
		DELETE FROM Functies
		WHERE Functie = @FUNCTIE

		IF @NEWFUNCTIE IS NOT NULL AND (SELECT COUNT(*) FROM FUNCTIES WHERE FUNCTIE = @NEWFUNCTIE) >= 1
        THROW 51042 , 'Deze nieuwe functie bestaat al' ,16
		
		IF @NEWFUNCTIE IS NOT NULL AND (SELECT COUNT(*) FROM FUNCTIES WHERE FUNCTIE = @NEWFUNCTIE) = 0
        UPDATE FUNCTIES
		SET FUNCTIE = @NEWFUNCTIE
		WHERE FUNCTIE = @FUNCTIE
		UPDATE MEDEWERKER
		SET FUNCTIE = @NEWFUNCTIE
		WHERE FUNCTIE = @FUNCTIE

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

-- | UC 1.31 | hoofdverzorger | voedingsinformatie aanpassen |
CREATE OR ALTER PROCEDURE STP_DeleteDieetinformatie
	@DierID				DierID,
	@VoedselSoort		VoedselNaam,
	@Startdatum			Datum
	
AS
BEGIN
	DECLARE @savepoint varchar(128)= CAST(OBJECT_NAME(@@PROCID) AS varchar(125)) + CAST(@@NESTLEVEL AS varchar(3));
	DECLARE @startTrancount int= @@TRANCOUNT;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
		SAVE TRANSACTION @savepoint;

		DELETE FROM DIEETINFORMATIE
		WHERE	DIERID				= @DierID
		AND		VOEDSELSOORT		= @VoedselSoort
		AND		STARTDATUM			= @Startdatum

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
		THROW 910015, @errormessage, 1;
	END CATCH;
END;
GO

--CREATE ADMIN Login
CREATE LOGIN SomerleytonAdmin WITH PASSWORD ='ENTERSTRONGPASSWORD';
GO

CREATE USER SomerleytonAdmin FOR LOGIN SomerleytonAdmin;  
GO   

EXEC sp_addsrvrolemember 'SomerleytonAdmin','sysadmin';
GO

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

--CREATE Hoofdverzorger user
CREATE LOGIN [HoofdverzorgerLogin] WITH PASSWORD= 'hoofdverzorger'
CREATE USER [HoofdverzorgerUser] FOR LOGIN [HoofdverzorgerLogin] 
GO

--CREATE Hoofdverzorger Role
CREATE ROLE HoofdverzorgerRole
GO

ALTER ROLE [HoofdverzorgerRole] ADD MEMBER [HoofdverzorgerUser]
GO


--Hoofdverzorger toegang geven tot de juiste stored procedure
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

--CREATE Kantoormedewerker user
CREATE LOGIN [KantoormedewerkerLogin] WITH PASSWORD= 'kantoormedewerker'
CREATE USER [KantoormedewerkerUser] FOR LOGIN [KantoormedewerkerLogin] 
GO

--CREATE Kantoormedewerker Role
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

