-- Posted

DECLARE	@myDateTime2		DATETIME2;
SET @myDateTime2 = '01 Jan 0001 00:00:00';		--< Note minimum year is 0001 not 0000 as you might expect
SELECT @myDateTime2 AS MinimumDATETIME2;

SET @myDateTime2 = '31 Dec 9999 23:59:59';
SELECT @myDateTime2 AS MaximumDATETIME2;


-- Reduces the percision of the seconds percision
DECLARE	@anotherMyDateTime		DATETIME2(1);

SET @anotherMyDateTime = CURRENT_TIMESTAMP;		--< Normally CURRENT_TIMESTAMP returns three digits of fractional precision

SELECT @anotherMyDateTime;						--< Note that the result has only one second of precision on the fractional part of the seconds
