-- A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. 
-- But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result.
Window functions apply to aggregate and ranking functions over a particular window (set of rows). OVER clause is used with window functions to define that window. OVER clause does two things : 

Partitions rows to form a set of rows. (PARTITION BY clause is used) 
Orders rows within those partitions into a particular order. (ORDER BY clause is used)

SELECT coulmn_name1, 
 window_function(cloumn_name2)
 OVER([PARTITION BY column_name1] [ORDER BY column_name3]) AS new_column
FROM table_name;

1. Using Derek's previous video as an example, create another running total. This time, create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: 
one with the amount being added for each new row, and a second with the running total.

SELECT standard_amt_usd, SUM(standard_amt_usd)
OVER (ORDER BY occurred_at) AS running_total
FROM orders;

2. Now, modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, 
but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. Your final table should have three columns: One with the amount being added for each row, 
one for the truncated date, and a final column with the running total within each year.

SELECT standard_amt_usd, 
DATE_TRUNC('year', occurred_at) AS year,
SUM(standard_amt_usd)
OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders;

-- ROW_NUMBER, RANK, DENSE_RANK
ROW_NUMBER assigns a unique number to each row, regardless of duplicate values or repeats. (1, 2, 3, 4, 5, etc.)
RANK assings a number to each row and skips if there are repeated values. (1, 2, 2, 4, 5, 6, etc.)
DENSE_RANK assigns a number to each row and continues where it left off if there are repeated values. (1, 2, 2, 3, 4, 5, etc.)
When DENSE_RANK is used with PARTITION, the rank count resets.

Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. 
Your final table should have these four columns.

SELECT id, account_id, total,
RANK() OVER(PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders;
