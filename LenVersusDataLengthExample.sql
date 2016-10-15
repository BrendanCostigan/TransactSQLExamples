

DECLARE @AsciiString	VARCHAR(255);		--< Note VARCHAR
DECLARE @UnicodeString	NVARCHAR(255);		--< Note NVARCHAR

SET @AsciiString = 'Hello World';
SET @UnicodeString = 'Hello World';


-- Simple length of string example
SELECT 'LEN is ' + CAST(LEN(@AsciiString) AS VARCHAR(20)) AS [ASCII LEN];					-- Characters 
SELECT 'LEN is ' + CAST(LEN(@UnicodeString) AS VARCHAR(20)) AS [UNICODE LEN];				-- Characters



SELECT 'DATALENGTH is ' + CAST(DATALENGTH (@AsciiString) AS VARCHAR(20)) AS [ASCII DATALENGTH];;		-- 11 Bytes
SELECT 'DATALENGTH is ' + CAST(DATALENGTH (@UnicodeString) AS VARCHAR(20)) AS [UNICODE DATALENGTH];;	-- 22 Bytes!



-- Note how trailing spaces are ignored by LEN ...
SET @AsciiString = 'Hello World  ';

SELECT 'LEN is ' + CAST(LEN(@AsciiString) AS VARCHAR(20)) AS [LEN TRAILING SPACES];					-- Characters 

-- ... but leading spaces are counted
SET @AsciiString = '  Hello World';

SELECT 'LEN is ' + CAST(LEN(@AsciiString) AS VARCHAR(20)) AS [LEN LEADING SPACES];					-- Characters 


-- Traling spaces are NOT ignored by the DATALENGTH function
SET @AsciiString = 'Hello World  ';

SELECT 'DATALENGTH is ' + CAST(DATALENGTH (@UnicodeString) AS VARCHAR(20)) AS [DATALENGTH TRAILING SPACES];		-- Characters 


