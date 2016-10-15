
-- CHARINDEX: Searches an expression for another expression and returns its starting position if found.

-- If the string is found then returns starting location of string searched for.
SELECT CHARINDEX('quick', 'The quick brown fox jumps over a lazy dog.');


-- If the string is NOT found then returns 0.
SELECT CHARINDEX('not found', 'The quick brown fox jumps over a lazy dog.');


-- Optional third parameter which is the location the search starts from.
SELECT CHARINDEX('quick', 'The quick brown fox jumps over a lazy dog.', 6);