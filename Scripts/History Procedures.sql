USE [Somerleyton]
GO

-- Verwijder alle history tabellen
CREATE OR ALTER PROCEDURE stp_DeleteAllHistoryTables
AS
BEGIN
	DECLARE @cmd varchar(4000)
	DECLARE cmds CURSOR FOR
	SELECT 'drop table [' + Table_Name + ']'
	FROM INFORMATION_SCHEMA.TABLES
	WHERE Table_Name LIKE 'HIST_%'

	OPEN cmds
	WHILE 1 = 1
	BEGIN
		FETCH cmds INTO @cmd
		IF @@fetch_status != 0 BREAK
		EXEC(@cmd)
	END
	CLOSE cmds;
	DEALLOCATE cmds
END
GO

-- Procedure die de history table en trigger procedures aanroept voor elk bestaande table.
CREATE OR ALTER PROCEDURE stp_CreateHistoryTablesAndTriggersForAllTables
AS
BEGIN
	DECLARE @TableCount INT
	SELECT @TableCount = COUNT(*) 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_SCHEMA = 'dbo'

	DECLARE @Counter INT = 1
	DECLARE @TableName VARCHAR(128) = ''

	DECLARE @LoopTable TABLE (
		RowNum INT IDENTITY (1, 1),
		Table_Name varchar(128)
	)
	INSERT INTO @LoopTable (Table_Name) SELECT TABLE_NAME 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_SCHEMA = 'dbo'

	WHILE @Counter <= @TableCount
	BEGIN
		SELECT @TableName = TABLE_NAME 
		FROM @LoopTable 
		WHERE RowNum = @Counter

		EXEC stp_CreateHistoryTable @table_name = @TableName
		EXEC stp_CreateHistoryTrigger @table_name = @TableName

		SET @Counter += 1
	END
END
GO

-- Maak een History Tabel voor een enkele bestaande tabel.
CREATE OR ALTER PROCEDURE stp_CreateHistoryTable (@table_name sysname)
AS 
BEGIN
	-- Haal de primary key op
	DECLARE @PK VARCHAR(MAX) = ''
	SELECT @PK = @PK + ',' + COLUMN_NAME
	FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
	ON ccu.TABLE_NAME = tc.TABLE_NAME AND ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
	WHERE ccu.TABLE_NAME = @table_name AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
	
	-- Haal alle kolommen op van de tabel
	DECLARE @COLUMNS VARCHAR(MAX) = ''
	SELECT @COLUMNS =
	CASE
	WHEN DATA_TYPE = 'int' OR DATA_TYPE = 'real' OR DATA_TYPE = 'money' THEN    -- Deze datatypes werkte niet met de volgende opstelling en moeten apart worden toegevoegd
		 @COLUMNS + ',' + COLUMN_NAME + ' ' + DATA_TYPE
	ELSE
		@COLUMNS + ',' + COLUMN_NAME + ' ' + DATA_TYPE + '(' + ISNULL(CONVERT(VARCHAR(5), CHARACTER_MAXIMUM_LENGTH), '')
		+ ISNULL(CONVERT(VARCHAR(5), NUMERIC_PRECISION), '') + ',' + ISNULL(CONVERT(VARCHAR(5), NUMERIC_SCALE), '')  + ')'
	END
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @table_name

	-- Schoon de @COLUMNS op
	SET @COLUMNS = REPLACE(@COLUMNS, '(,)', '') 
	SET @COLUMNS = REPLACE(@COLUMNS, ',)', ')')
	SET @COLUMNS = REPLACE(@COLUMNS, '-1', '8000') -- Vervang de MAX van een varchar met 8000 (Dezelfde waarde maar werkend met de opstelling)

	-- Opstellen van het SQL commando voor de history tabel
	DECLARE @SQL VARCHAR(MAX) = 
	'CREATE TABLE HIST_'+ @table_name + '('														-- Create Table
	+ STUFF(@COLUMNS, 1, 1, '') + ','															-- Add default columns
	+ ' HIST_TIMESTAMP datetime DEFAULT SYSDATETIME(),'											-- Add timestamp
	+ ' HIST_CHANGETYPE varchar(MAX),'															-- Add type of change
	+ ' HIST_USER varchar(MAX),'																-- Add user log
	+ ' CONSTRAINT CHK_changetype_'+ @table_name + ' CHECK (hist_changetype IN (''INSERTED'', ''DELETED'')),'			-- Add check constraint to type of change
	+ ' PRIMARY KEY (' + STUFF(@PK, 1, 1, '') + ', hist_timestamp) )'							-- Set primary key 
	EXEC(@SQL)
END
GO

-- Stel een Trigger op voor een enkele tabel
CREATE OR ALTER PROCEDURE stp_CreateHistoryTrigger(@table_name sysname)
AS 
BEGIN
	DECLARE @SQL VARCHAR(MAX) = '
	;CREATE OR ALTER TRIGGER TRG_' + @table_name + '_FILLHISTORY 
	ON ' + @table_name + '
	AFTER UPDATE, INSERT, DELETE
	AS
	BEGIN
		if @@rowcount = 0
			return
		SET NOCOUNT ON
		BEGIN TRY
			INSERT INTO HIST_' + @table_name + '
			SELECT *, SYSDATETIME(), ''DELETED'', CURRENT_USER
			FROM deleted
		
			INSERT INTO HIST_' + @table_name + '
			SELECT *, DATEADD(second, 1, SYSDATETIME()), ''INSERTED'', CURRENT_USER
			FROM inserted		
		END TRY
		BEGIN CATCH
			;THROW
		END CATCH
	END'
	EXEC(@SQL)
END
GO

-- Execute procedures
EXEC stp_DeleteAllHistoryTables
EXEC stp_CreateHistoryTablesAndTriggersForAllTables
GO