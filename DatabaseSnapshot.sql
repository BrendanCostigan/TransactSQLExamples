-- Note this script assumes a database called TestDB exists
-- Note this script assumes the default SQL 2016 folder structure is used.
-- Note this script leaves behind a snapshot
-- The functionality is only available with Enterprise and Developer editions as at SQL2016.

USE master;
GO

DROP DATABASE IF EXISTS TestDB_2016_11_26;


CREATE DATABASE TestDB_2016_11_26 ON																--< Need to specify each file except log file
( NAME = TestDB, FILENAME =																			--< Name of the source database
'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TestDB_data_2016_11_26.ss' )	--< the extension used is down to personal choice
AS SNAPSHOT OF TestDB;									
GO

-- The snapshot, TestDB_2016_11_26, will now appear in Management Studio under Database Snapshots