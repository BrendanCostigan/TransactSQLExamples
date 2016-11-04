USE tempdb;
GO

IF OBJECT_ID(N'dbo.parent', N'P') IS NOT NULL
	DROP PROCEDURE dbo.parent;
GO

IF OBJECT_ID(N'dbo.child', N'P') IS NOT NULL
	DROP PROCEDURE dbo.child;
GO


CREATE PROCEDURE dbo.parent
	@IncomingParameter	VARCHAR(255)
AS
BEGIN
	DECLARE @parentvariable			INT = 99;

	CREATE TABLE #test
	(
		Id				INT
	)


	INSERT #test
	VALUES (1);

	EXEC dbo.child;

END
GO



CREATE PROCEDURE dbo.child
AS
	BEGIN

		SELECT * FROM #test;		--< Can access a temporary table defined in a parent procedure

		--SELECT @parentvariable;		--< Cannot access a variable defined in a parent procedure
	
		--SELECT @IncomingParameter;	--< Cannot access a parameter defined in a parent procedure

		--SELECT 

	END
GO


EXEC dbo.parent;



-- TidyUp

IF OBJECT_ID(N'dbo.parent', N'P') IS NOT NULL
	DROP PROCEDURE dbo.parent;
GO

IF OBJECT_ID(N'dbo.child', N'P') IS NOT NULL
	DROP PROCEDURE dbo.child;
GO









