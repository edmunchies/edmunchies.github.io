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
     SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY 1,2
      ORDER BY 3 DESC), 
t2 AS (
      SELECT region_name, MAX(total_amt) total_amt
      FROM t1
      GROUP BY 1)

SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

For the region with the largest sales total_amt_usd, how many total orders were placed?
WITH t1 AS (
      SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY r.name), 
t2 AS (
      SELECT MAX(total_amt)
      FROM t1)

SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
WITH t1 AS
  (SELECT a.name, SUM(o.standard_qty) AS total_std, SUM(o.total) AS total_orders
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY 1),

  t2 AS
  (SELECT MAX(total_std)
  FROM t1),

  t3 AS
  (SELECT a.name, SUM(o.total) AS total_orders
  FROM accounts a 
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.standard_qty) = (SELECT * FROM t2)),
  
  t4 AS
  (SELECT total_orders
  FROM t3),

  t5 AS 
  (SELECT a.name, SUM(o.total) AS total_orders
  FROM accounts a 
  JOIN orders o 
  ON a.id = o.account_id 
  GROUP BY 1
  HAVING SUM(o.total)
  > (SELECT * FROM t4))
  
  SELECT COUNT(*) FROM t5;


For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
WITH t1 AS
  (SELECT a.id, a.name, SUM(o.total_amt_usd) AS lifetime_spend
  FROM accounts a
  JOIN ORDERS o
  ON a.id = o.account_id
  GROUP BY 1, 2
  ORDER BY 3 DESC
  LIMIT 1)
  
SELECT a.name, w.channel, COUNT(*) AS channel_count
FROM web_events w
JOIN accounts a 
ON w.account_id = a.id
WHERE w.account_id = (SELECT t1.id FROM t1)
GROUP BY 1, 2


What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.


