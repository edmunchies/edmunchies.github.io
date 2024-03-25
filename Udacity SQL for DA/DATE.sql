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
