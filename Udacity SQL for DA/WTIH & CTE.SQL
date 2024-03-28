-- WTIH
The WITH statement is often called a Common Table Expression or CTE. 
Though these expressions serve the exact same purpose as subqueries, they are more common in practice, as they tend to be cleaner for a future reader to follow the logic.
SYNTAX: WITH table_name AS (inner query)
WITH events AS (
          SELECT DATE_TRUNC('day',occurred_at) AS day, 
                        channel, COUNT(*) as events
          FROM web_events 
          GROUP BY 1,2)

SELECT channel, AVG(events) AS average_events
FROM events
GROUP BY channel
ORDER BY 2 DESC;
For the above example, we don't need anymore than the one additional table, but imagine we needed to create a second table to pull from. 
We can create an additional table to pull from in the following way:

WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)


SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;

-- CTE practice
Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH t1 AS (
  SELECT r.name AS region, s.name, SUM(o.total_amt_usd) AS total_sales
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY 1, 2),

 t2 AS (
  SELECT t1.region, MAX(total_sales) FROM t1
  GROUP BY 1),
  
 t3 AS (
  SELECT r.name AS region, s.name, SUM(o.total_amt_usd) AS total_sales
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY 1, 2)
   
 
 SELECT t3.name, t3.region, t3.total_sales 
 FROM t2
 JOIN t3
 ON t2.region = t3.region AND t2.max = t3.total_sales;

For the region with the largest sales total_amt_usd, how many total orders were placed?


How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?


For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?


What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.


