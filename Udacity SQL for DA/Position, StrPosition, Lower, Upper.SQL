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
FROM table_name

This will pull all city names from a table.

Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
SELECT
LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
FROM accounts a;

Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
SELECT
LEFT(s.name, STRPOS(s.name, ' ') - 1) AS first_name,
RIGHT(s.name, LENGTH(s.name) - STRPOS(s.name, ' ')) AS last_name
FROM sales_reps s;
