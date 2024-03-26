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
