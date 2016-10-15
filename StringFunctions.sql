
-- REPLACE ( string_expression , string_pattern , string_replacement )
SELECT REPLACE('abcdefghicde','cde','xxx');

--REPLICATE ( string_expression ,integer_expression ) 
SELECT  REPLICATE('X', 20)

--STUFF ( character_expression , start , length , replaceWith_expression )
-- Replace two charcters starting in position 6 with the second string, XXX
SELECT STUFF('Brendan', 6, 2, 'XXX');