-- GROUP BY p.2
For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
  SELECT a.name, AVG(standard_qty) avg_standard, AVG(gloss_qty) avg_gloss, AVG(poster_qty) avg_poster
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY name;

For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
  SELECT a.name, AVG(standard_amt_usd) avg_standard, AVG(gloss_amt_usd) avg_gloss, AVG(poster_amt_usd) avg_poster
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY name;

Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
  SELECT s.name, w.channel, COUNT(*) channel_count
  FROM web_events w
  JOIN accounts a
  ON w.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  GROUP BY s.name, w.channel
  ORDER BY channel_count DESC;

Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
  SELECT r.name, COUNT(*) channel_count, w.channel
  FROM web_events w
  JOIN accounts a
  ON w.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id 
  JOIN region r
  ON s.region_id = r.id
  GROUP BY r.name, w.channel
  ORDER BY channel_count DESC;

-- DISTINCT 
Use DISTINCT to test if there are any accounts associated with more than one region.
  SELECT DISTINCT id, name
  FROM accounts;

Have any sales reps worked on more than one account?
  SELECT DISTINCT id, name
  FROM sales_reps;

-- HAVING
HAVING is the “clean” way to filter a query that has been aggregated, but this is also commonly done using a subquery(opens in a new tab). 
Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead.
How many of the sales reps have more than 5 accounts that they manage?
  SELECT s.id, s.name, COUNT(*) num_accounts
  FROM accounts a
  JOIN sales_reps s
  ON s.id = a.sales_rep_id
  GROUP BY s.id, s.name
  HAVING COUNT(*) > 5
  ORDER BY num_accounts;

How many accounts have more than 20 orders?
  SELECT a.id, a.name, COUNT(*) total_orders
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  HAVING COUNT(*) > 20
  ORDER BY total_orders;

Which account has the most orders?
  SELECT a.id, a.name, COUNT(*) total_orders
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  ORDER BY total_orders DESC
  LIMIT 1;

Which accounts spent more than 30,000 usd total across all orders?


Which accounts spent less than 1,000 usd total across all orders?


Which account has spent the most with us?


Which account has spent the least with us?


Which accounts used facebook as a channel to contact customers more than 6 times?


Which account used facebook most as a channel?


Which channel was most frequently used by most accounts?

