-- ORDER BY clause
Must go after SELECT FROM statement and before LIMIT clause in order for the query to run.

Let's get some practice using ORDER BY:
  Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
SELECT id, occurred_at, total_amt_usd
FROM orders 
ORDER BY occurred_at 
LIMIT 10;

  Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders 
ORDER BY total_amt_usd DESC
LIMIT 5;

  Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders 
ORDER BY total_amt_usd 
LIMIT 20;

Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).
Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).
Compare the results of these two queries above. How are the results different when you switch the column you sort on first?
