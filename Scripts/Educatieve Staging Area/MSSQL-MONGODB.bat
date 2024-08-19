$dir = 'C:\Users\Joria\Documents\GitHub\ise-project\Exports\'
$diersoortfile = 'diersoortstagingarea.json'
$seksueeldimorfismefile = 'seksueeldimorfismestagingarea.json'
CD $dir
bcp "SELECT * FROM [Somerleyton].[dbo].[DIERSOORT] FOR JSON AUTO" queryout  $dir$diersoortfile -T -q -c
(Get-Content $diersoortfile) -join ' ' | Set-Content $diersoortfile 
mongoimport --db=Somerleyton --collection=diersoort --file=$diersoortfile --uri="mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username ISEC2 --password k5LoS2GUPz6F --type json --jsonArray
bcp "SELECT * FROM [Somerleyton].[dbo].[SEKSUEELDIMORFISME] FOR JSON AUTO" queryout  $dir$seksueeldimorfismefile -T -q -c
(Get-Content $seksueeldimorfismefile) -join ' ' | Set-Content $seksueeldimorfismefile
mongoimport --db=Somerleyton --collection=seksueeldimorfisme --file=$seksueeldimorfismefile --uri="mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username ISEC2 --password k5LoS2GUPz6F --type json --jsonArray



