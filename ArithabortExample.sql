--
-- https://msdn.microsoft.com/en-us/library/ms190306.aspx
--

USE tempdb;
GO

IF OBJECT_ID(N't1', N'U') IS NOT NULL
BEGIN
  DROP TABLE dbo.t1;
END

IF OBJECT_ID(N't2', N'U') IS NOT NULL
BEGIN
  DROP TABLE dbo.t2;
END


IF SESSIONPROPERTY('ARITHABORT') = 0
	PRINT 'ARITHABORT IS OFF';
ELSE
	PRINT 'ARITHABORT IS ON';

IF SESSIONPROPERTY('ANSI_WARNINGS') = 0
	PRINT 'ANSI_WARNINGS IS OFF';
ELSE
	PRINT 'ANSI_WARNINGS IS ON';


-- SET ARITHABORT
-------------------------------------------------------------------------------
-- Create tables t1 and t2 and insert data values.
CREATE TABLE t1 (
   a TINYINT,
   b TINYINT
);

CREATE TABLE t2 (
   a TINYINT
);
GO

INSERT INTO t1
VALUES (1, 0);

INSERT INTO t1
VALUES (255, 1);
GO

PRINT '*** SET ARITHABORT ON';
GO
-- SET ARITHABORT ON and testing.
SET ARITHABORT ON;
GO

PRINT '*** Testing divide by zero during SELECT';
GO
SELECT a / b AS ab
FROM t1;
GO

PRINT '*** Testing divide by zero during INSERT';
GO
INSERT INTO t2
SELECT a / b AS ab
FROM t1;
GO

PRINT '*** Testing tinyint overflow';
GO
INSERT INTO t2
SELECT a + b AS ab
FROM t1;
GO

PRINT '*** Resulting data - should be no data';
GO
SELECT *
FROM t2;
GO

-- Truncate table t2.
TRUNCATE TABLE t2;
GO

-- SET ARITHABORT OFF and testing.
PRINT '*** SET ARITHABORT OFF';
GO
SET ARITHABORT OFF;
GO

-- This works properly.
PRINT '*** Testing divide by zero during SELECT';
GO
SELECT a / b AS ab
FROM t1;
GO

-- This works as if SET ARITHABORT was ON.
PRINT '*** Testing divide by zero during INSERT';
GO
INSERT INTO t2
SELECT a / b AS ab
FROM t1;
GO
PRINT '*** Testing tinyint overflow';
GO
INSERT INTO t2
SELECT a + b AS ab
FROM t1;
GO

PRINT '*** Resulting data - should be 0 rows';
GO
SELECT *
FROM t2;
GO

-- Drop tables t1 and t2.
DROP TABLE t1;
DROP TABLE t2;
GO
