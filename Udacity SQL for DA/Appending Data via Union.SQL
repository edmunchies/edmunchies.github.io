UNION Use Case
The UNION operator is used to combine the result sets of 2 or more SELECT statements. It removes duplicate rows between the various SELECT statements.
Each SELECT statement within the UNION must have the same number of fields in the result sets with similar data types.
Typically, the use case for leveraging the UNION command in SQL is when a user wants to pull together distinct values of specified columns that are spread across multiple tables. For example, a chef wants to pull together the ingredients and respective aisle across three separate meals that are maintained in different tables.
Details of UNION
There must be the same number of expressions in both SELECT statements.
The corresponding expressions must have the same data type in the SELECT statements. For example: expression1 must be the same data type in both the first and second SELECT statement.
Expert Tip
UNION removes duplicate rows.
UNION ALL does not remove duplicate rows.
You'll likely use UNION ALL more often than UNION.

Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table.

SELECT * FROM accounts 
UNION ALL
SELECT * FROM accounts;

Add a WHERE clause to each of the tables that you unioned in the query above, filtering the first table where name equals Walmart and filtering the second table where name equals Disney.

SELECT * FROM accounts
WHERE name = 'Walmart'

UNION ALL

SELECT * FROM accounts
WHERE name = 'Disney';

Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and name it double_accounts. Then do a COUNT the number of times a name appears in the double_accounts table. If you do this correctly, your query results should have a count of 2 for each name

WITH double_accounts AS (SELECT * FROM accounts 
UNION ALL
SELECT * FROM accounts)

SELECT name, COUNT(*) 
FROM double_accounts
GROUP BY 1
ORDER BY 1;
