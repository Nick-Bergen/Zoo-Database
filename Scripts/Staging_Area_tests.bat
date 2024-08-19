PRINT [UserRoles Educatieve Staging Area]


mongosh "mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username Gebruiker --password SomerleytonGebruiker
db.diersoort.find() 
PRINT [-- test slaagt als resultaat returned]
db.diersoort.deleteMany({})
PRINT [-- test slaagt als 'user is not allowed to do action [remove] on [Somerleyton.diersoort]' returned]
