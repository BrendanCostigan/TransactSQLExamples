USE tempdb;
GO

IF OBJECT_ID(N'dbo.myTable', N'U') IS NOT NULL
	DROP TABLE dbo.myTable;
GO

CREATE TABLE dbo.myTable
(
	Id			INT IDENTITY,
	ItemName	VARCHAR(255)
)

INSERT dbo.myTable
VALUES ('Orange');

SELECT
	SCOPE_IDENTITY() AS SCOPE_IDENTITY,						--< Last identity value generated in a session in the current scope
	@@IDENTITY AS [@@IDENTITY],								--< Last inserted value
	IDENT_CURRENT('dbo.myTable') AS IDENT_CURRENT;
GO

IF OBJECT_ID(N'dbo.myExampleProcedure', N'P') IS NOT NULL
	DROP PROCEDURE dbo.myExampleProcedure;
GO

CREATE PROCEDURE dbo.myExampleProcedure
AS
BEGIN
	INSERT dbo.myTable
	VALUES ('Apples');

	SELECT
		SCOPE_IDENTITY() AS SCOPE_IDENTITY,
		@@IDENTITY AS [@@IDENTITY],									--< Last inserted value
		IDENT_CURRENT('dbo.myTable') AS IDENT_CURRENT;
END
GO


EXEC dbo.myExampleProcedure


SELECT
	SCOPE_IDENTITY() AS SCOPE_IDENTITY,				-- Ignores identity update in procedure as this is another session
	@@IDENTITY AS [@@IDENTITY],						-- Recognises everything in this session even if in another scope
	IDENT_CURRENT('dbo.myTable') AS IDENT_CURRENT;	-- Looks at the table rather than scope or session


DBCC CHECKIDENT('dbo.myTable', RESEED, 200);

INSERT dbo.myTable VALUES ('Apple');

SELECT
	SCOPE_IDENTITY() AS SCOPE_IDENTITY,				-- Ignores identity update in procedure as this is another session
	@@IDENTITY AS [@@IDENTITY],						-- Recognises everything in this session even if in another scope
	IDENT_CURRENT('dbo.myTable') AS IDENT_CURRENT;		-- Looks at the table rather than scope or session


-- Tidy up

IF OBJECT_ID(N'dbo.myExampleProcedure', N'P') IS NOT NULL
	DROP PROCEDURE dbo.myExampleProcedure;
GO

IF OBJECT_ID(N'dbo.myTable', N'U') IS NOT NULL
	DROP TABLE dbo.myTable;
GO