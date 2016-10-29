-- Fail returns null
SELECT TRY_CONVERT(DATETIME, '00000000');

-- Fail with traditional CONVERT raises errror: The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.
SELECT CONVERT(DATETIME, '00000000');

--= Success and so returns the current date and time
SELECT TRY_CONVERT(DATETIME, CURRENT_TIMESTAMP);
