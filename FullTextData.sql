USE [AdventureWorks2014];
-- Cannot use full-text search in master, tempdb, or model database.
GO


IF OBJECT_ID('dbo.tableForFullTextDemo', 'U') IS NOT NULL
	DROP TABLE dbo.tableForFullTextDemo;
GO

IF  EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'myFullTextCatalog')
	DROP FULLTEXT CATALOG myFullTextCatalog;
GO

-- First create a catalog. I'm using the option to set it as the default catalog which is optional
-- as it the first one I am creating I presume that it would be default anyway.
CREATE FULLTEXT CATALOG myFullTextCatalog
AS DEFAULT;
GO

-- Use a system view to list all the catalogs
SELECT * FROM sys.fulltext_catalogs;
GO

-- Performs a master merge which can help performance on a frequently changing index
-- ... obviously not required here as I have just created it.
ALTER FULLTEXT CATALOG myFullTextCatalog
REORGANIZE;


CREATE TABLE dbo.tableForFullTextDemo
(
	Id			INT	IDENTITY,
	myText		VARCHAR(1024),
	CONSTRAINT PK_Id					-- Name of index
    PRIMARY KEY CLUSTERED (Id)			-- Fields in index
)


-- Out some data in to ve able to create a full text index on
INSERT dbo.tableForFullTextDemo
VALUES	('Lord Of The Rings Trilogy Theatrical Version Blu ray Elijah Wood Ian McKellen Viggo Mortensen Peter Jackson'), 
		('Lords of the Bow Conqueror 2 Conn Iggulden'), 
		('Lords And Ladies Discworld Novels Terry Pratchett'), 
		('Lord of War Blu ray'), 
		('Lord of the Rings Aragorn s Quest Wii'), 
		('Lord of Arcana Slayer Edition PSP'), 
		('Lord of the Flies William Golding'), 
		('Lords of the Bow Conqueror 2 Conn Iggulden'), 
		('Lord of the Flies York Notes for GCSE 2010 Intermediate Sw Foster'), 
		('Lords Of Discipline DVD');


CREATE FULLTEXT INDEX 
ON dbo.tableForFullTextDemo(myText)
KEY INDEX PK_Id
WITH CHANGE_TRACKING AUTO;				--< AUTO says to SQL to keep the index updated automatically
GO

-- Need to leave time for the FULL TEXT INDEX to build
WAITFOR DELAY '00:00:10';  

-- Return one row
SELECT myText
FROM dbo.tableForFullTextDemo
WHERE CONTAINS(myText, 'Lord AND Slayer')
GO

-- Returns four row
SELECT myText
FROM dbo.tableForFullTextDemo
WHERE CONTAINS(myText, 'Rings OR Flies')
GO

-- Returns four row
SELECT myText
FROM dbo.tableForFullTextDemo
WHERE CONTAINS(myText, '"Lords And"')			--< Note need for extra quotes to prevent AND being seeing as a logical operator
GO

-- Returns four row
SELECT myText
FROM dbo.tableForFullTextDemo
WHERE CONTAINS(myText, '"Lords*"')				--< Wildcard
GO


SELECT myText
FROM dbo.tableForFullTextDemo
WHERE CONTAINS(myText, 'NEAR((Lord, ray), 3)');		--< Only seach for second word within 3 words	
GO

-- No rows returned
SELECT myText
FROM dbo.tableForFullTextDemo
WHERE CONTAINS(myText, 'Fly')
GO

-- FREETEXT looks at variants of the search term so returns variants such as FLIES resulting in two rows  
SELECT myText
FROM dbo.tableForFullTextDemo
WHERE FREETEXT(myText, 'Fly')
GO

-- Note JOIN and use of key to join back to primary key
SELECT *
FROM dbo.tableForFullTextDemo fts
INNER JOIN CONTAINSTABLE(dbo.tableForFullTextDemo, myText, 'Lord AND Slayer') AS KEY_TBL
ON fts.Id = KEY_TBL.[Key];
GO

-- Note JOIN and use of key to join back to primary key
SELECT *
FROM dbo.tableForFullTextDemo fts
INNER JOIN FREETEXTTABLE(dbo.tableForFullTextDemo, myText, 'Fly') AS KEY_TBL
ON fts.Id = KEY_TBL.[Key];
GO


--Tidy Up
IF OBJECT_ID('dbo.fullTextSearch', 'U') IS NOT NULL
	DROP TABLE dbo.fullTextSearch;
GO

IF  EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'dbo.tableForFullTextDemo'))
	DROP FULLTEXT INDEX ON dbo.tableForFullTextDemo;			--< Note the ON part of the statement i.e. it is not deleting dbo.tableForFullTextDemo it is deleting the index on the table
GO

IF  EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'myFullTextCatalog')
	DROP FULLTEXT CATALOG myFullTextCatalog;
GO



