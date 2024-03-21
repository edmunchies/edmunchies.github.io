-- JOINS
Try pulling all the data from the accounts table, and all the data from the orders table.
  SELECT * 
  FROM accounts 
  JOIN orders
  ON accounts.id = orders.id;
Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
  SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
  FROM orders
  JOIN accounts
  ON orders.id = accounts.id;

Notice this result is the same as if you switched the tables in the FROM and JOIN. Additionally, which side of the = a column is listed doesn't matter.
The PK is always equal to the FK
--Practice
Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
  SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel, accounts.name
  FROM web_events
  JOIN accounts
  ON accounts.id = web_events.account_id
  WHERE name = 'Walmart';
  
Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
  SELECT sales_reps.name AS SRN, region.name AS RN, accounts.name AS AN
  FROM sales_reps
  JOIN region 
  ON sales_reps.region_id = region.id
  JOIN accounts
  ON accounts.sales_rep_id = sales_reps.id
  ORDER BY accounts.name;
-------OR--------------
  SELECT s.name AS sales_rep_name, r.name AS region_name, a.name AS accounts_name
  FROM sales_reps s
  JOIN region r
  ON s.region_id = r.id
  JOIN accounts a
  ON a.sales_rep_id = s.id
  ORDER BY a.name;
  
  NOTE: Use column aliases when dealing with same column names to differentiate.
Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
  SELECT a.name AS acct_name, (total_amt_usd/(total+0.01)) AS unit_price, r.name
  FROM accounts a
  JOIN orders o 
  ON o.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON r.id = s.region_id;                                           
