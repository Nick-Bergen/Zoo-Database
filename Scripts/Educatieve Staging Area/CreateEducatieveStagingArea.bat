REM maak connectie met de database (zorg ervoor dat je IP is toegestaan in mongo atlas)
mongosh "mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username ISEC2 --password k5LoS2GUPz6F

USE Somerleyton
REM Maak de tabel/collection aan
db.createCollection("diersoort", {

   validator: {$jsonSchema: {
      bsonType: "object",
      required: ["LATIJNSENAAM"],
      properties: {
         LATIJNSENAAM: {
            bsonType: "string",
            description: "must be a string and is required"
         },
         NORMALENAAM: {
            bsonType: "string",
            description: "must be a string."
         },
          EDUTEKST: {
            bsonType: "string",
            description: "must be a string."
         },
          FOTO: {
            bsonType: "string",
            description: "must be a string."
         }
      }
   }}
})

db.createCollection("seksueeldimorfisme", {

   validator: {$jsonSchema: {
      bsonType: "object",
      required: ["LATIJNSENAAM"],
      properties: {
         LATIJNSENAAM: {
            bsonType: "string",
            description: "must be a string and is required"
         },
         GESLACHT: {
            bsonType: "string",
            description: "must be a string."
         },
          VOLWASSENLEEFTIJD: {
            bsonType: "string",
            description: "must be a string."
         },
          VOLWASSENGEWICHT: {
            bsonType: "string",
            description: "must be a string."
         }, 
          OVERIGEKENMERKEN: {
            bsonType: "string",
            description: "must be a string."
         }
      }
   }}
})

REM insert testdata
db.DIERSOORT.insertMany([
    {   LATIJNSENAAM: "Panthera leo" ,
        NORMALENAAM:   "Leeuw",
        EDUTEKST:     "De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae).Van alle katachtigen is enkel de tijger groter. De grootte en de manen van het mannetje geven het dier een imposant uiterlijk, waardoor de leeuw in grote delen van de wereld bekendstaat als de koning der dieren. In Europa heeft hij deze rol overigens pas in de loop van de middeleeuwen overgenomen van de bruine beer. De leeuw is vaak onderwerp van folklore en symboliek geweest. Zo staat de leeuw afgebeeld in de wapens van verscheidene landen, streken en steden, waaronder Nederland, Belgi� en Sri Lanka. De leeuw komt nog in bepaalde delen van Afrika voor en in een klein stukje van India, maar vroeger was hij ook algemeen aanwezig in het Midden-Oosten en in Zuidoost-Europa.Leeuwen leven in groepsverband (de enige katachtige die voornamelijk in sociale groepen leeft) en leeuwinnen gaan in de regel samen op jacht, waarmee ze een groter aandeel in de jacht leveren dan de mannetjesleeuwen.",
        FOTO:"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg')"
    },
    { LATIJNSENAAM: "Loxodonta" ,
    },
    {   LATIJNSENAAM: "Canis lupus" ,
        NORMALENAAM:   "Wolf",
        EDUTEKST:     "De wolf (Canis lupus), meer specifiek de grijze wolf, is een zoogdier uit de familie hondachtigen (Canidae), die behoort tot de roofdieren (Carnivora). De wolf komt op het noordelijk halfrond voor. Er worden meerdere ondersoorten onderscheiden, waaronder enkele die zijn uitgestorven. De wolf leeft in groepen met een sociale structuur. De wolf is de voorouder van de hond (Canis lupus familiaris). Een wolf en een hond kunnen samen vruchtbare nakomelingen voortbrengen, zodat ze, volgens een gangbaar soortbegrip in de biologie, tot dezelfde soort kunnen worden gerekend."
    }
])

REM show diereninformatie
mongosh "mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username ISEC2 --password k5LoS2GUPz6F
db.getCollection('diersoort').aggregate([{ $lookup: { from: 'seksueeldimorfisme', localField: 'LATIJNSENAAM', foreignField: 'LATIJNSENAAM', as: 'Diereninformatie' } }]);






-- WERKENDE test data
INSERT INTO DIERSOORT (LATIJNSENAAM, NORMALENAAM, EDUTEKST, FOTO)
VALUES
('Panthera leo', 'Leeuw', 'De leeuw (Panthera leo) is een roofdier uit de familie der katachtigen (Felidae).', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Berlin_Tierpark_Friedrichsfelde_12-2015_img18_Indian_lion.jpg/1280px-Berlin_Tierpark_Friedrichsfelde_12-2015.jpg'),
('Loxodonta', NULL, NULL, NULL), -- Afrikaanse olifanten
('Centrophorus harrissoni', 'Langsnuitzwelghaai', NULL, NULL),
('Canis lupus', NULL, 'De wolf (Canis lupus), meer specifiek de grijze wolf', NULL), -- De wolf
('Torgos tracheliotos', NULL, NULL, 'https://upload.wikimedia.org/wikipedia/commons/7/77/Nubianvulture.jpeg'), -- Oorgier
('Argynnis paphia', 'keizersmantel', 'De keizersmantel (Argynnis paphia) is een vlinder uit de familie Nymphalidae, de vossen, parelmoervlinders en weerschijnvlinders. De keizersmantel is een grote en opvallende vlinder met een vleugellengte van 27 tot 35 mm. Aan de enterhaakvormige vlekken op bovenkant van de vleugels kan men de mannetjes herkennen. De onderkant van de achtervleugel is groenig met zilverkleurige strepen.',NULL),
('Cyprinus carpio', NULL, 'De Europese karper (Cyprinus carpio), ook wel gewoon karper.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Cyprinus_carpio_2008_G1_%28cropped%29.jpg/1920px-Cyprinus_carpio_2008_G1_%28cropped%29.jpg'),
('Alligator mississippiensis', 'mississippialligator', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/American_Alligator_at_Lake_Woodruff_-_Flickr_-_Andrea_Westmoreland.jpg/1280px-American_Alligator_at_Lake_Woodruff_-_Flickr_-_Andrea_Westmoreland.jpg'),
('Phoenicopteridae', 'Flamingo', 'De flamingos (Phoenicopteridae) vormen een familie van grote, steltpotige waadvogels. ','https://upload.wikimedia.org/wikipedia/commons/b/b2/Lightmatter_flamingo.jpg'),
('Colobus guereza', 'Oostelijke franjeaap', 'De oostelijke franjeaap heeft een zwart-witte vacht.','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Colubusmonkey.JPG/1280px-Colubusmonkey.JPG')
