
-- Evaluates the arguments in order and returns the current value of the first expression that initially does not evaluate to NULL.

SELECT COALESCE(NULL, 'Fred', 'Joe');  --< Returns Fred

SELECT COALESCE('Joe', 'Fred', 'Mary'); --< Returns Joe


-- ISNULL Non-standard t-SQL alterative which is limited to two parameters. Do not use.

SELECT ISNULL(NULL, 'Fred');  --< Returns Fred

