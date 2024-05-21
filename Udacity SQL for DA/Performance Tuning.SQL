One way to make a query run faster is to reduce the number of calculations that need to be performed. Some of the high-level things that will affect the number of calculations a given query will make include:

Table size
Joins
Aggregations
Query runtime is also dependent on some things that you can’t really control related to the database itself:

Other users running queries concurrently on the database
Database software and optimization (e.g., Postgres is optimized differently than Redshift)

In general, you should use LIMIT in the inner query vs. outer since aggregations are run first, followed by LIMIT.
If you have a time series data, limiting to a small window can help your query run faster. 
Testing your queries on a subset of data, finalizing your query, then removing the limitation is a good strategy. 


Another method is to make your joins less complicated. You can do this by reduce the number of rows evaluated during the join. 
 (SLOW, searches 9k rows)
SELECT accounts.name, 
  COUNT(*) AS web_events
FROM accounts accounts
JOIN web_events_full events
  ON events.account_id = accounts.id 
GROUP BY 1
ORDER BY 2 DESC;

(PRE_AGGREGATION, faster searches 351 rows. Then put it into a subquery)
SELECT account_id, 
  COUNT(*) AS web_events
FROM web_events_full events
GROUP BY 1;
---------
SELECT a.name, sub.web_events
FROM (
SELECT account_id,   
  COUNT(*) AS web_events
FROM web_events_full events
GROUP BY 1
) sub
JOIN accounts a 
ON a.id = sub.account_id 
ORDER BY 2 DESC;
