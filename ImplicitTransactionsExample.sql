USE tempdb;
GO

-- SQL Default
SET IMPLICIT_TRANSACTIONS OFF;

IF OBJECT_ID(N'dbo.myTable', N'U') IS NOT NULL
	DROP TABLE dbo.myTable;

CREATE TABLE dbo.myTable
(
	id			Int,
)

SELECT CONCAT('Look no transactions: ', CAST(@@TRANCOUNT AS NVARCHAR(255)));

SET IMPLICIT_TRANSACTIONS ON;				--< Look here! 

INSERT dbo.myTable
VALUES (1);


SELECT CONCAT('Look a transactions: ', CAST(@@TRANCOUNT AS NVARCHAR(255)));

SELECT CONCAT('.. and I can commit it because XACT_STATE() is 1. See what I mean: ', CAST(XACT_STATE() AS NVARCHAR(255)));

ROLLBACK TRAN			--< Need to COMMIT or ROLLBACK the transaction that was automatically started




-- Tidy up
IF OBJECT_ID(N'dbo.myTable', N'U') IS NOT NULL
	DROP TABLE dbo.myTable;


-- SQL Default
SET IMPLICIT_TRANSACTIONS OFF;