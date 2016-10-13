
--DATEFROMPARTS ( year, month, day )
SELECT DATEFROMPARTS ( 2010, 12, 31 ) AS [DATEFROMPARTS];

-- DATETIMEFROMPARTS ( year, month, day, hour, minute, seconds, milliseconds )
SELECT DATETIMEFROMPARTS ( 2010, 12, 31, 23, 59, 59, 0 ) AS [DATETIMEFROMPARTS];

--DATETIME2FROMPARTS ( year, month, day, hour, minute, seconds, fractions, precision )
SELECT DATETIME2FROMPARTS ( 2010, 12, 31, 23, 59, 59, 0, 0 ) AS [DATETIME2FROMPARTS];

--DATETIMEOFFSETFROMPARTS ( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )
SELECT DATETIMEOFFSETFROMPARTS( 2010, 12, 31, 14, 23, 23, 0, 12, 0, 7 ) AS [DATETIMEOFFSETFROMPARTS];

--SMALLDATETIMEFROMPARTS ( year, month, day, hour, minute )
SELECT SMALLDATETIMEFROMPARTS ( 2010, 12, 31, 23, 59 ) AS [SMALLDATETIMEFROMPARTS]

--TIMEFROMPARTS ( hour, minute, seconds, fractions, precision )
SELECT TIMEFROMPARTS(23, 59, 59, 0, 0) AS [TIMEFROMPARTS];

--TIMEFROMPARTS - Note the fractional part 12 is returned as 012
--23:59:59.012
SELECT TIMEFROMPARTS(23, 59, 59, 12, 3 ) AS [TIMEFROMPARTS]; 

--TIMEFROMPARTS - Note the fractional part 12 is returned as 012
--23:59:59.12
SELECT TIMEFROMPARTS(23, 59, 59, 12, 2 ) AS [TIMEFROMPARTS]; 

-- Following generates error 'Cannot construct data type time, some of the arguments have values which are not valid.'
-- SELECT TIMEFROMPARTS(23, 59, 59, 12, 1 ) AS [TIMEFROMPARTS]; 

-- Because the factional part has more numbers than the percision. The following will work:
--TIMEFROMPARTS 
--23:59:59.12
SELECT TIMEFROMPARTS(23, 59, 59, 12, 2 ) AS [TIMEFROMPARTS];

-- The following return an offset e.g. 2011-08-15 14:30:00.5 +12:30. The three different examples are for different precision.
SELECT DATETIMEOFFSETFROMPARTS ( 2011, 8, 15, 14, 30, 00, 5, 12, 30, 1 );  
SELECT DATETIMEOFFSETFROMPARTS ( 2011, 8, 15, 14, 30, 00, 50, 12, 30, 2 );  
SELECT DATETIMEOFFSETFROMPARTS ( 2011, 8, 15, 14, 30, 00, 500, 12, 30, 3 );  
GO 
