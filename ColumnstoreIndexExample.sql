
USE tempdb;
GO

DROP TABLE IF EXISTS SimpleTable;

CREATE TABLE SimpleTable
(
	ProductKey		int NOT NULL,
	OrderDateKey	int NOT NULL,
	DueDateKey		int NOT NULL,
	ShipDateKey		int NOT NULL
);
GO

-- This example was originally written for SQL 2012. I recall seeing that significant changes were made in SQL 2104 which may make the following comments invalid in versions post 2012.

-- Columnstore index cannot be clustered
-- Columnstore index cannot be a unique index
-- Columnstore index cannot act as a primary key or a foreign key
CREATE CLUSTERED INDEX cl_simple ON SimpleTable (ProductKey);
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX csindx_simple
ON SimpleTable
(
	OrderDateKey,
	DueDateKey,
	ShipDateKey
);
GO


--!! SQL 2012 ERROR - INSERT statement failed because data cannot be updated in a table with a columnstore index. Consider disabling the columnstore index before issuing the INSERT statement, then rebuilding the columnstore index after INSERT is complete.
--!! SQL 2016 - This statement now works.
--INSERT SimpleTable
--VALUES (1, 2, 3, 4);


-- Tidy up
DROP TABLE IF EXISTS SimpleTable;

