USE tempdb;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'myTable' and type = 'U')
	DROP TABLE myTable;
GO

CREATE TABLE myTable
(
	Id			INT IDENTITY,
	ItemName	VARCHAR(255)
)

INSERT myTable
VALUES ('Orange');

SELECT
	SCOPE_IDENTITY() AS SCOPE_IDENTITY,
	@@IDENTITY AS [@@IDENTITY],								--< Last inserted value
	IDENT_CURRENT('myTable') AS IDENT_CURRENT;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'myExampleProcedure' AND type = 'P')
	DROP PROCEDURE myExampleProcedure;
GO

CREATE PROCEDURE myExampleProcedure
AS
BEGIN
	INSERT myTable
	VALUES ('Apples');

	SELECT
		SCOPE_IDENTITY() AS SCOPE_IDENTITY,
		@@IDENTITY AS [@@IDENTITY],									--< Last inserted value
		IDENT_CURRENT('myTable') AS IDENT_CURRENT;
END
GO


EXEC myExampleProcedure


SELECT
	SCOPE_IDENTITY() AS SCOPE_IDENTITY,				-- Ignores identity update in procedure as this is another session
	@@IDENTITY AS [@@IDENTITY],						-- Recognises everything in this session even if in another scope
	IDENT_CURRENT('myTable') AS IDENT_CURRENT;		-- Looks at the table rather than scope or session


DBCC CHECKIDENT('myTable', RESEED, 200);

INSERT myTable VALUES ('Apple');

SELECT
	SCOPE_IDENTITY() AS SCOPE_IDENTITY,				-- Ignores identity update in procedure as this is another session
	@@IDENTITY AS [@@IDENTITY],						-- Recognises everything in this session even if in another scope
	IDENT_CURRENT('myTable') AS IDENT_CURRENT;		-- Looks at the table rather than scope or session


-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'myExampleProcedure' AND type = 'P')
	DROP PROCEDURE myExampleProcedure;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'myTable' and type = 'U')
	DROP TABLE myTable;
GO