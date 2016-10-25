USE tempdb;
GO

IF OBJECT_ID('dbo.test_table', 'U') IS NOT NULL
	DROP TABLE dbo.test_table;
GO

-- Unnamed PRIMARY KEY in column defintion
CREATE TABLE dbo.test_table
(
	Id			INT	IDENTITY PRIMARY KEY CLUSTERED,
	myText		VARCHAR(1024)
)
GO

DROP TABLE dbo.test_table;
GO

-- Unnamed PRIMARY KEY in column defintion
CREATE TABLE dbo.test_table
(
	Id			INT	IDENTITY,
	myText		VARCHAR(1024),
	CONSTRAINT PK_Id					-- Name of index
    PRIMARY KEY CLUSTERED (Id)			-- Fields in index
    WITH (IGNORE_DUP_KEY = OFF)			-- When ON just a warning is generated, when OFF an error message is generated
)
GO

DROP TABLE dbo.test_table;
GO

-- No index
CREATE TABLE dbo.test_table
(
	Id			INT	IDENTITY,
	myText		VARCHAR(1024)
)
GO


ALTER TABLE dbo.test_table WITH NOCHECK						
ADD CONSTRAINT PK_Id PRIMARY KEY CLUSTERED (Id)
WITH (FILLFACTOR = 75, ONLINE = OFF, PAD_INDEX = ON);	-- Need Enterprise addition to build index with ONLINE = ON
GO


IF OBJECT_ID('dbo.test_table', 'U') IS NOT NULL
	DROP TABLE dbo.test_table;
GO