REM enable 'SQL Server and Windows authentication mode' in SQL Server. Without enabling it any SQL login will not be allowed to login. It is under general -> Security"
REM Benodigheden: MongoDB, MongoDB database tools, SQLCMD. deze moeten allemaal in je PATH staan als je windows gebruikt"
REM QLCMD -s localhost -d Somerleyton -U 'SomerleytonAdmin' -P 'ENTERSTRONGPASSWORD'
REM BCP DIERSOORT OUT C:\Users\Joria\Documents\GitHub\ise-project\Exports\stagingarea.csv -U 'SomerleytonAdmin' -P 'ENTERSTRONGPASSWORD' -S Somerleyton
REM bcp DIERSOORT out C:\Users\Joria\Documents\GitHub\ise-project\Exports\stagingarea.csv -c -T werkt voor some reason
REM mongoimport --db=Somerleyton --collection=diersoort --file=stagingarea.json --uri="mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username ISEC2 --password k5LoS2GUPz6F --type json --jsonArray





REM Set Location
$dir = 'C:\Users\Joria\Documents\GitHub\ise-project\Exports\';
$file = 'stagingarea.json'

REM Check of locatie bestaat
IF ((Test-Path -Path $dir) -eq 0)
{
    Write-Host "The path $dir does not exist; please create or modify the directory.";
    RETURN;
};

REM Go to relevant folder
CD $dir

REM Export SQL data naar een JSON file
bcp "SELECT LATIJNSENAAM,NORMALENAAM,EDUTEKST FROM [Somerleyton].[dbo].[DIERSOORT] FOR JSON AUTO" queryout  $dir$file -T -q -c

REM strip json export of newlines
(Get-Content 'stagingarea.json') -join ' ' | Set-Content 'stagingarea1.json'

REM Import JSON file in de MongoDB
mongoimport --db=Somerleyton --collection=diersoort --file=stagingarea1.json --uri="mongodb+srv://cluster0.b2pzk.mongodb.net/Somerleyton" --username ISEC2 --password k5LoS2GUPz6F --type json --jsonArray






