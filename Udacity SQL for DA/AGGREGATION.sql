-- MIN and MAX are similar to COUNT as they all take numerical and non-numerical data.
Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical columns. 
Depending on the column type, MIN will return the lowest number, earliest date, or non-numerical value as early in the alphabet as possible. 
As you might suspect, MAX does the opposite—it returns the highest number, the latest date, or the non-numerical value closest alphabetically to “Z.”

When was the earliest order ever placed? You only need to return the date.
  SELECT MIN(occurred_at)
  FROM orders;

Try performing the same query as in question 1 without using an aggregation function.
  SELECT occurred_at
  FROM orders
  ORDER BY occurred_at
  LIMIT 1;

When did the most recent (latest) web_event occur?
  SELECT MAX(occurred_at)
FROM web_events;

Try to perform the result of the previous query without using an aggregation function.
  SELECT occurred_at
  FROM web_events
  ORDER BY occurred_at DESC
  LIMIT 1;

Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
  SELECT AVG(standard_qty) AS avg_standard_qty, AVG(standard_amt_usd) AS avg_standard_usd,
  AVG(poster_qty) AS avg_poster_qty, AVG(poster_amt_usd) AS avg_poster_usd,
  AVG(gloss_qty) AS avg_gloss_qty, AVG(gloss_amt_usd) AS avg_gloss_usd
  FROM orders;

Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
SELECT *
FROM (SELECT total_amt_usd
         FROM orders
         ORDER BY total_amt_usd
         LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- GROUP BY 
Allows creating segments that will aggregate independent from each other. Allows you  to take the sum of data from each account rather than across the entire data set.
GROUP BY can be used to aggregate data within subsets of the data. For example, grouping for different accounts, different regions, or different sales representatives.
Any column in the SELECT statement that is not within an aggregator must be in the GROUP BY clause.
The GROUP BY always goes between WHERE and ORDER BY.
ORDER BY works like SORT in spreadsheet software.

Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
  SELECT a.name, o.occurred_at AS date
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  ORDER BY date
  LIMIT 1;

Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
  SELECT a.name, SUM(o.total_amt_usd) AS usd
  FROM orders o 
  JOIN accounts a
  ON a.id = o.account_id 
  GROUP BY a.name
  ORDER BY a.name;
  
Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
  SELECT w.occurred_at AS date, w.channel, a.name 
  FROM web_events w
  JOIN accounts a
  ON w.account_id = a.id
  ORDER BY date
  LIMIT 1;
  
Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
  SELECT w.channel, COUNT(channel) 
  FROM web_events w
  GROUP BY channel;
  
Who was the primary contact associated with the earliest web_event?
  SELECT a.primary_poc 
  FROM accounts a
  JOIN web_events w
  ON w.account_id = a.id
  ORDER BY w.occurred_at
  LIMIT 1;
  
What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
  SELECT a.name, o.total_amt_usd AS total_usd
  FROM accounts a
  JOIN orders o 
  ON a.id = o.account_id
  ORDER BY total_usd;
  
Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
  SELECT r.name AS region, COUNT(s.name) AS sales_reps
  FROM region r 
  JOIN sales_reps s
  ON s.region_id = r.id
  GROUP BY region
  ORDER BY sales_reps;
