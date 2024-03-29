POSITION takes a character and a column, and provides the index where that character is for each row. The index of the first position is 1 in SQL. 
If you come from another programming language, many begin indexing at 0. Here, you saw that you can pull the index of a comma as POSITION(',' IN city_state).

STRPOS provides the same result as POSITION, but the syntax for achieving those results is a bit different as shown here: STRPOS(city_state, ',').

POS and STRPOS both pull a numerical value. They do the same thing, but the order of arguments and syntax are different. 

POSITION('x', IN column_name)
STRPOS(column_name, 'x')

Note, both POSITION and STRPOS are case sensitive, so looking for A is different than looking for a.

Therefore, if you want to pull an index regardless of the case of a letter, you might want to use LOWER or UPPER to make all of the characters lower or uppercase.
Ex: 
SELECT city_state,
LOWER(city_state) AS lowercase,
LEFT(city_state, POSITION(',' IN city_state) - 1) AS city 

This will pull all city names from a table.
