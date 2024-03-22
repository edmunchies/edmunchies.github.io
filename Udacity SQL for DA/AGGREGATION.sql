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
