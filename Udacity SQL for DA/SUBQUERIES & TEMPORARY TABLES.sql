-- Intro Practice
1. Find the number of events that occur for each day for each channel
  SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS num_events
  FROM web_events w
  GROUP BY 1, 2
  ORDER BY 3 DESC;

2. Now create a subquery that simply provides all of the data from your first query
  SELECT * FROM
  (SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS 	num_events
  FROM web_events w
  GROUP BY 1, 2) sub;

3. Now find the average number of events for each channel. Since you broke out by day earlier, this is giving you the average per day
  SELECT channel, AVG(num_events) FROM
  (SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS 	num_events
  FROM web_events w
  GROUP BY 1, 2) sub
  GROUP BY 1
  ORDER BY 2 DESC;

In the first subquery you wrote, you created a table that you could then query again in the FROM statement. 
However, if you are only returning a single value, you might use that value in a logical statement like WHERE, HAVING, or even SELECT - the value could be nested within a CASE statement.
On the next concept, we will work through this example, and then you will get some practice on answering some questions on your own.

Note that you should not include an alias when you write a subquery in a conditional statement. 
This is because the subquery is treated as an individual value (or set of values in the IN case) rather than as a table.
Also, notice the query here compared a single value. If we returned an entire column IN would need to be used to perform a logical argument. 
If we are returning an entire table, then we must use an ALIAS for the table, and perform additional logic on the entire table.

1. Use DATE_TRUNC to pull month level information about the first order ever placed in the orders table.
    SELECT DATE_TRUNC('month', MIN(occurred_at)) first_order FROM orders;

2. Use the result of the previous query to find only orders that took place in the same month and year as the first order.
    SELECT * FROM orders
    WHERE DATE_TRUNC('month', occurred_at) =
    (
      SELECT DATE_TRUNC('month', MIN(occurred_at)) first_order FROM orders)
    );
  
3. Then pull the average for each type of paper qty in this month. 
    SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
    FROM orders
    WHERE DATE_TRUNC('month', occurred_at) = 
       (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

4. Find total amount spent on all orders on the first month that any order was placed in the orders table (USD)
   SELECT SUM(total_amt_usd)
    FROM orders
    WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);
-- More tests
1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT region, MAX(total_sales) FROM   
  (SELECT s.name AS name, r.name AS region, SUM(total_amt_usd) 		 total_sales
        FROM orders o
        JOIN accounts a 
        ON o.account_id = a.id
        JOIN sales_reps s
        ON s.id = a.sales_rep_id
        JOIN region r
        ON s.region_id = r.id
        GROUP BY 1, 2
        ORDER BY total_sales DESC
     ) sub
     GROUP BY 1
     ORDER BY max DESC;

2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?


3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?


4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?


5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


5. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
