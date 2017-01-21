-- Note uses SQL 2016 features

USE tempdb;
GO

DROP TABLE IF EXISTS dbo.TestColumnStore;

CREATE TABLE dbo.TestColumnStore
(
	ProductKey		int NOT NULL,
	OrderDateKey	int NOT NULL,
	DueDateKey		int NOT NULL,
	ShipDateKey		int NOT NULL
)
GO

INSERT dbo.TestColumnStore
VALUES (1, 2, 3, 4);

SELECT * FROM dbo.TestColumnStore;

CREATE CLUSTERED COLUMNSTORE INDEX cci_TestColumnStore ON dbo.TestColumnStore;  
GO

-- Note creating a CLUSTERED COLUMNSTORE index keeps the contents intact
SELECT * FROM dbo.TestColumnStore;

-- !! ERROR: Cannot have two clustered indexes even if one is a CLUSTERED COLUMNSTORE index
--CREATE CLUSTERED INDEX ci_simple ON TestColumnStore (ProductKey);
--GO


-- Note DROP CLUSTERED COLUMNSTORE converts the table back to rowstore
DROP INDEX cci_TestColumnStore ON dbo.TestColumnStore;

-- Tidy up
DROP TABLE IF EXISTS TestColumnStore;

