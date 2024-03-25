The first function you are introduced to in working with dates is DATE_TRUNC.

DATE_TRUNC allows you to truncate your date to a particular part of your date-time column. Common trunctions are day, month, and year. Here(opens in a new tab) is a great blog post by Mode Analytics on the power of this function.

  DATE_TRUNC(x) truncates by x. Ex, DATE_TRUNC('month'..) would truncate by month 

DATE_PART can be useful for pulling a specific portion of a date, but notice pulling month or day of the week (dow) means that you are no longer keeping the years in order. Rather you are grouping for certain components regardless of which year they belonged in.

For additional functions you can use with dates, check out the documentation here(opens in a new tab), but the DATE_TRUNC and DATE_PART functions definitely give you a great start!

You can reference the columns in your select statement in GROUP BY and ORDER BY clauses with numbers that follow the order they appear in the select statement. For example

SELECT standard_qty, COUNT(*)

FROM orders

GROUP BY 1 (this 1 refers to standard_qty since it is the first of the columns included in the select statement)

ORDER BY 1 (this 1 refers to standard_qty since it is the first of the columns included in the select statement)

-- Practice
Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
  SELECT DATE_PART('year', occurred_at) AS year, SUM(total_amt_usd)
  FROM orders
  GROUP BY year
  ORDER BY 2 DESC;

Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
  SELECT DATE_PART('month', occurred_at) AS month, SUM(total_amt_usd)
  FROM orders
  GROUP BY month
  ORDER BY 2 DESC;

Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
   SELECT DATE_PART('year', occurred_at) AS year, COUNT(*) total_sales
  FROM orders
  GROUP BY year
  ORDER BY 2 DESC;

Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
  SELECT DATE_PART('month', occurred_at) AS month, COUNT(*) total_sales
  FROM orders
  GROUP BY month
  ORDER BY 2 DESC;

In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
  SELECT DATE_TRUNC('month', occurred_at) AS date, SUM(gloss_amt_usd)
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id
  WHERE name LIKE 'Walmart'
  GROUP BY date
  ORDER BY 2 DESC
  LIMIT 1;

-- CASE
Derived column: Takes data from existing columns and modifies them
The CASE statement always goes in the SELECT clause. CASE must include the following components: WHEN, THEN, and END. 
ELSE is an optional component to catch cases that didn’t meet any of the other previous CASE conditions.
You can make any conditional statement using any conditional operator (like WHERE(opens in a new tab)) between WHEN and THEN. This includes stringing together multiple conditional statements using AND and OR.
You can include multiple WHEN statements, as well as an ELSE statement again, to deal with any unaddressed conditions.

SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

-- CASE and Aggregations 
Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
  SELECT account_id, total_amt_usd, 
  	CASE WHEN total_amt_usd >= 3000 THEN 'Large'
      ELSE 'Small'
      END AS order_size
  FROM orders
  ORDER BY total_amt_usd;

Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
SELECT CASE WHEN o.total >= 2000 THEN 'At least 2000'
			WHEN o.total >= 1000 AND o.total <2000 THEN 'Between 1000 and 2000'
            ELSE 'Less than 1000' END AS order_size, COUNT(*) order_count
FROM orders o
GROUP BY 1
ORDER BY order_size;

We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name, o.total_amt_usd AS total_sales, 
	CASE WHEN o.total_amt_usd > 200000 THEN 'Level 1'
    WHEN o.total_amt_usd >= 100000 AND o.total_amt_usd < 200000 THEN 'Level 2'
    ELSE 'Level 3' END AS level
FROM orders o 
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name, o.total_amt_usd
ORDER BY level;

We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
SELECT a.name, o.total_amt_usd AS total_sales,  
	CASE WHEN o.total_amt_usd > 200000 THEN 'Level 1'
    WHEN o.total_amt_usd >= 100000 AND o.total_amt_usd < 200000 THEN 'Level 2'
    ELSE 'Level 3' END AS level
FROM orders o 
JOIN accounts a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY a.name, o.total_amt_usd
ORDER BY total_sales DESC;

We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.
	SELECT s.name, COUNT(*) AS order_count, 
		CASE WHEN COUNT(*) > 200 THEN 'Top'
	    ELSE 'Not' END AS top_salesman
	FROM sales_reps s
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY s.name
	ORDER BY order_count DESC;

The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!
	SELECT s.name, COUNT(*) AS order_count, SUM(o.total_amt_usd), 
			CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'Top'
	        WHEN COUNT(*) > 150 AND COUNT(*) <= 200 OR SUM(o.total_amt_usd) >= 500000 AND SUM(o.total_amt_usd) <= 750000 THEN 'Middle'
		    ELSE 'Low' END AS standing
	FROM sales_reps s
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY s.name
	ORDER BY sum DESC;
