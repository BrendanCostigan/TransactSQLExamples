

-- EOMONTH: Returns the last day of the month that contains the specified date, with an optional offset.

-- Returns 31/01/2013
SELECT EOMONTH ( '01 Jan 2013' )


DECLARE @date DATETIME = GETDATE();

SELECT EOMONTH ( @date ) AS 'This Month';
SELECT EOMONTH ( @date, 1 ) AS 'Next Month';
SELECT EOMONTH ( @date, -1 ) AS 'Last Month';
GO


