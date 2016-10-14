--
-- SQL Server 2016 upwards required
--
-- This script takes about a minute to run
--

USE tempdb;
GO

-- Prepare

-- Note need to switch off versioning before deleting
IF OBJECT_ID(N'dbo.ProductPrice', N'U') IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[ProductPrice] SET ( SYSTEM_VERSIONING = OFF )
	DROP TABLE dbo.ProductPrice;
END


IF OBJECT_ID(N'dbo.ProductPriceHistory', N'U') IS NOT NULL
	DROP TABLE dbo.ProductPriceHistory;




CREATE TABLE dbo.ProductPrice   
(    
	 Id				INT IDENTITY(1, 1) NOT NULL PRIMARY KEY CLUSTERED,
	 Price			SMALLMONEY	NOT NULL,		  
     SysStartTime	DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,  
     SysEndTime		DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,  
     PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)     
)   
WITH    
   (   
      SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ProductPriceHistory)   -- No option to have it initially set as OFF
   );  

-- Note two tables are created
SELECT * FROM sys.objects WHERE type = 'U' AND Name LIKE 'Product%';

INSERT dbo.ProductPrice (Price)
VALUES (0.79);

WAITFOR DELAY '00:00:09';

UPDATE dbo.ProductPrice SET Price = 0.82 WHERE Id = 1;

WAITFOR DELAY '00:00:19';

UPDATE dbo.ProductPrice SET Price = 0.95 WHERE Id = 1;

-- Note the datetime used by the dates fields are UTC

DECLARE @StartDateTime	DATETIME2 = DATEADD(ss, -10, SYSUTCDATETIME()),
        @EndDateTime	DATETIME2 = SYSUTCDATETIME();	


SELECT 'Contents of main table' AS Comment
SELECT * FROM dbo.ProductPrice;
SELECT 'Contents of history table' AS Comment
SELECT * FROM dbo.ProductPriceHistory;


SELECT @StartDateTime AS TimeOfSelect;

SELECT 'Contents as at a few seconds ago' AS Comment
SELECT * FROM dbo.ProductPrice FOR SYSTEM_TIME AS OF @StartDateTime;


SELECT 'Contents between a few seconds ago and now' AS Comment
SELECT * FROM dbo.ProductPrice FOR SYSTEM_TIME BETWEEN @StartDateTime AND @EndDateTime;


-- Tuidy up

-- Note need to switch off versioning before deleting
IF OBJECT_ID(N'dbo.ProductPrice', N'U') IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[ProductPrice] SET ( SYSTEM_VERSIONING = OFF )
	DROP TABLE dbo.ProductPrice;
END


IF OBJECT_ID(N'dbo.ProductPriceHistory', N'U') IS NOT NULL
	DROP TABLE dbo.ProductPriceHistory;




