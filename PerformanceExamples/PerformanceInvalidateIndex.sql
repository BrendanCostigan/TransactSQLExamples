USE AdventureWorks2014;
GO

-- The purpose of this example is to show that you can prevent SQL from using an index by using an expression, 
-- in this case COALESCE, when comparing columns.
--
-- The example is broken into two runs the first uses COALESCE on an index field, the second has the join 
-- rewritten in a more verbose style, but it allows SQL to continue to use the index and hence runs faster.
--
-- Example run times (milliseconds)
-- 
-- Run 1: 643 vs 377
-- Run 2: 594 vs 423
-- Run 3: 611 vs 438
-- Run 4: 581 vs 422
-- Run 5: 596 vs 467



-- Setup

-- Create an index for the column we are using

CREATE NONCLUSTERED INDEX [NonClusteredIndex_CarrierTrackingNumber] ON [Sales].[SalesOrderDetail]
(
	[CarrierTrackingNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO


-- temporary table to hold results that we are not interested in
IF OBJECT_ID('tempdb..#temp') IS NOT NULL
	DROP TABLE #temp;


CREATE TABLE #temp
(
	[CarrierTrackingNumber] NVARCHAR(25)
)


-- Clean out buffers
CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
GO

-- Record the start time
DECLARE @StartTime	DATETIME2 = SYSDATETIME();


-- Do the work
INSERT #temp
SELECT sod1.CarrierTrackingNumber 
FROM Sales.SalesOrderDetail sod1
INNER JOIN Sales.SalesOrderDetail sod2
ON sod1.SalesOrderID = sod2.SalesOrderID
AND sod1.SalesOrderDetailID = sod2.SalesOrderDetailID
AND COALESCE(sod1.CarrierTrackingNumber, '') = COALESCE(sod2.CarrierTrackingNumber, '');	--Note COALESCE in the join


-- Display how long it took
SELECT DATEDIFF(MS, @StartTime, SYSDATETIME());

TRUNCATE TABLE #temp;

CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
GO

DECLARE @StartTime	DATETIME2 = SYSDATETIME();

INSERT #temp
SELECT sod1.CarrierTrackingNumber 
FROM Sales.SalesOrderDetail sod1
INNER JOIN Sales.SalesOrderDetail sod2
ON sod1.SalesOrderID = sod2.SalesOrderID
AND sod1.SalesOrderDetailID = sod2.SalesOrderDetailID
AND (sod1.CarrierTrackingNumber = sod2.CarrierTrackingNumber						--< Run it again this time without using COALESCE
OR (sod1.CarrierTrackingNumber IS NULL AND sod2.CarrierTrackingNumber IS NULL));	--< COALESCE is replaced by two statemenst


-- Display how long it took
SELECT DATEDIFF(MS, @StartTime, SYSDATETIME());

TRUNCATE TABLE #temp

-- Remove index added for test

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('Sales.SalesOrderDetail') AND NAME ='NonClusteredIndex_CarrierTrackingNumber')
    DROP INDEX NonClusteredIndex_CarrierTrackingNumber ON Sales.SalesOrderDetail;

GO

