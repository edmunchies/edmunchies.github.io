-- LIKE and Wildcards
Use the accounts table to find
All the companies whose names start with 'C'.
  SELECT name 
  FROM accounts
  WHERE name LIKE 'C%';
All companies whose names contain the string 'one' somewhere in the name.
  SELECT name 
  FROM accounts
  WHERE name LIKE '%one%';
All companies whose names end with 's'.
  SELECT name 
  FROM accounts
  WHERE name LIKE '%s';

-- IN clause
The IN operator is useful for working with both numeric and text columns. This operator allows you to use an =, but for more than one item of that particular column. We can check one, two or many column values for which we want to pull data, but all within the same query. In the upcoming concepts, you will see the OR operator that would also allow us to perform these tasks, but the IN operator is a cleaner way to write these queries.

Expert Tip
In most SQL environments, although not in our Udacity's classroom, you can use single or double quotation marks - and you may NEED to use double quotation marks if you have an apostrophe within the text you are attempting to pull.

In our Udacity SQL workspaces, note you can include an apostrophe by putting two single quotes together. For example, Macy's in our workspace would be 'Macy''s'.

Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
  SELECT name, primary_poc, sales_rep_id
  FROM accounts
  WHERE name IN ('Walmart', 'Target', 'Nordstrom');

Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
  SELECT * 
  FROM web_events
  WHERE channel IN ('organic', 'adwords');

-- NOT clause
We can pull all of the rows that were excluded from the queries in the previous two concepts with our new operator.
All the companies whose names do not start with 'C'.
  SELECT name
  FROM accounts
  WHERE name NOT LIKE 'C%';
All companies whose names do not contain the string 'one' somewhere in the name.
  SELECT name
  FROM accounts
  WHERE name NOT LIKE '%one%';
All companies whose names do not end with 's'.
  SELECT name
  FROM accounts
  WHERE name NOT LIKE '%s';

-- AND & BETWEEN
The AND operator is used within a WHERE statement to consider more than one logical clause at a time. Each time you link a new statement with an AND, you will need to specify the column you are interested in looking at. You may link as many statements as you would like to consider at the same time. This operator works with all of the operations we have seen so far including arithmetic operators (+, *, -, /).* LIKE*,* IN*, and* NOT logic can also be linked together using the AND* operator.

BETWEEN Operator
Sometimes we can make a cleaner statement using BETWEEN than we can using AND. Particularly this is true when we are using the same column for different parts of our AND statement. In the previous video, we probably should have used BETWEEN.

Instead of writing :

WHERE column >= 6 AND column <= 10
we can instead write, equivalently:

WHERE column BETWEEN 6 AND 10
  
Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
  SELECT * 
  FROM orders
  WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;
Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
  SELECT name 
  FROM accounts
  WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s';
When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.
  SELECT occurred_at, gloss_qty 
  FROM orders
  WHERE gloss_qty BETWEEN 24 AND 29;
Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.
  SELECT *
  FROM web_events
  WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
  ORDER BY occurred_at DESC;

-- OR clause
