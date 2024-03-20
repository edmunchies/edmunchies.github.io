Creating a new column that is a combination of existing columns is known as a derived column (or "calculated" or "computed" column). Usually you want to give a name, or "alias," to your new column using the AS keyword.

This derived column, and its alias, are generally only temporary, existing just for the duration of your query. The next time you run a query and access this table, the new column will not be there.

If you are deriving the new column from existing columns using a mathematical expression, then these familiar mathematical operators will be useful:

* (Multiplication)
+ (Addition)
- (Subtraction)
/ (Division)
Consider this example:
  SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
  FROM orders
  LIMIT 10;
Here we divide the standard paper dollar amount by the total order amount to find the standard paper percent for the order, and use the AS keyword to name this new column "std_percent." You can run this query on the next page if you'd like, to see the output.

Order of Operations
Remember PEMDAS from math class to help remember the order of operations? If not, check out this link(opens in a new tab) as a reminder. The same order of operations applies when using arithmetic operators in SQL.

The following two statements have very different end results:

Standard_qty / standard_qty + gloss_qty + poster_qty
standard_qty / (standard_qty + gloss_qty + poster_qty)
It is likely that you mean to do the calculation as written in statement number 2!

Questions using Arithmetic Operations
Using the orders table:

Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.
  SELECT id, account_id, (standard_amt_usd/standard_qty) AS unit_price
  FROM orders
  LIMIT 10;

Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also. NOTE - you will receive an error with the correct solution to this question. This occurs because at least one of the values in the data creates a division by zero in your formula. You will learn later in the course how to fully handle this issue. For now, you can just limit your calculations to the first 10 orders, as we did in question #1, and you'll avoid that set of data that causes the problem.
  SELECT id, account_id, poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) * 100 AS poster_rev
  FROM orders
  LIMIT 10;
Notice, the above operators combine information across columns for the same row. If you want to combine values of a particular column, across multiple rows, we will do this with aggregations. We will get to that before the end of the course!

