-- Source
-- https://technet.microsoft.com/en-us/library/ms175156(v=sql.105).aspx
--
-- The APPLY operator allows you to invoke a table-valued function for each
-- row returned by an outer table expression of a query. The table-valued 
-- function acts as the right input and the outer table expression acts as
-- the left input. The right input is evaluated for each row from the left
-- input and the rows produced are combined for the final output. 

USE tempdb;
GO



IF OBJECT_ID(N'dbo.Departments', N'U') IS NOT NULL
BEGIN
  DROP TABLE dbo.Departments;
END
GO

IF OBJECT_ID(N'dbo.Employees', N'U') IS NOT NULL
BEGIN
  DROP TABLE dbo.Employees;
END
GO

IF OBJECT_ID(N'dbo.fn_getsubtree', N'TF') IS NOT NULL			--< Note TF for TABLE FUNCTION
BEGIN
  DROP FUNCTION dbo.fn_getsubtree
END
GO

--Create Employees table and insert values.
CREATE TABLE dbo.Employees
(
  empid   int         NOT NULL,
  mgrid   int         NULL,
  empname varchar(25) NOT NULL,
  salary  money       NOT NULL,
  CONSTRAINT PK_Employees PRIMARY KEY(empid),
)
GO

INSERT INTO dbo.Employees VALUES(1 , NULL, 'Nancy'   , $10000.00),
								(2 , 1   , 'Andrew'  , $5000.00),
								(3 , 1   , 'Janet'   , $5000.00),
								(4 , 1   , 'Margaret', $5000.00),
								(5 , 2   , 'Steven'  , $2500.00),
								(6 , 2   , 'Michael' , $2500.00),
								(7 , 3   , 'Robert'  , $2500.00),
								(8 , 3   , 'Laura'   , $2500.00),
								(9 , 3   , 'Ann'     , $2500.00),
								(10, 4   , 'Ina'     , $2500.00),
								(11, 7   , 'David'   , $2000.00),
								(12, 7   , 'Ron'     , $2000.00),
								(13, 7   , 'Dan'     , $2000.00),
								(14, 11  , 'James'   , $1500.00)
GO

--Create Departments table and insert values.
CREATE TABLE dbo.Departments
(
  deptid    INT NOT NULL PRIMARY KEY,
  deptname  VARCHAR(25) NOT NULL,
  deptmgrid INT NULL REFERENCES Employees							--< Note how the foreign key is implemented. It automatically uses the primark key
)
GO

INSERT INTO dbo.Departments VALUES(1, 'HR',           2)
INSERT INTO dbo.Departments VALUES(2, 'Marketing',    7)
INSERT INTO dbo.Departments VALUES(3, 'Finance',      8)
INSERT INTO dbo.Departments VALUES(4, 'R&D',          9)
INSERT INTO dbo.Departments VALUES(5, 'Training',     4)
INSERT INTO dbo.Departments VALUES(6, 'Gardening', NULL)
GO

CREATE FUNCTION dbo.fn_getsubtree(@empid AS INT) 
RETURNS @tree TABLE
(
  empid   INT NOT NULL,
  empname VARCHAR(25) NOT NULL,
  mgrid   INT NULL,
  lvl     INT NOT NULL
)
AS
BEGIN
  WITH Employees_Subtree(empid, empname, mgrid, lvl)			--< Note no need for semi-colon
  AS
  (
    -- Anchor Member (AM)
    SELECT empid, empname, mgrid, 0
    FROM dbo.Employees
    WHERE empid = @empid

    UNION ALL

    -- Recursive Member (RM)
    SELECT e.empid, e.empname, e.mgrid, es.lvl+1
    FROM dbo.Employees AS e
      JOIN Employees_Subtree AS es
        ON e.mgrid = es.empid
  )
  INSERT INTO @tree										--< Note the INSERT statement is to the return table
    SELECT * FROM Employees_Subtree

  RETURN
END
GO


-- With the CROSS APPLY example, there is no row returned for 
-- the Gardening department that does not have a manager id. 
-- This is similar to an INNER JOIN.
SELECT *
FROM dbo.Departments AS D
  CROSS APPLY fn_getsubtree(D.deptmgrid) AS ST			--< Note passing in parameter in to function for each row in Department


-- With the OUTER APPLY there is a row returned for the 
-- Gardening department. This is similar to an OUTER JOIN.

SELECT *
FROM dbo.Departments AS D
  OUTER APPLY fn_getsubtree(D.deptmgrid) AS ST			--< Note passing in parameter in to function for each row in Department


  -- Tidy up

  IF OBJECT_ID(N'dbo.Departments', N'U') IS NOT NULL
BEGIN
  DROP TABLE dbo.Departments;
END
GO

IF OBJECT_ID(N'dbo.Employees', N'U') IS NOT NULL
BEGIN
  DROP TABLE dbo.Employees;
END
GO

IF OBJECT_ID(N'dbo.fn_getsubtree', N'TF') IS NOT NULL			--< Note TF for TABLE FUNCTION
BEGIN
  DROP FUNCTION dbo.fn_getsubtree
END
GO
