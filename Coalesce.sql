
-- Evaluates the arguments in order and returns the current value of the first expression that initially does not evaluate to NULL.

SELECT COALESCE(NULL, 'Fred');

SELECT COALESCE('Joe', 'Fred');