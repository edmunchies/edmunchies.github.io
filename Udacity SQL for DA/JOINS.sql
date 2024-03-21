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
