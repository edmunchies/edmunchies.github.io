-- Intro Practice
1. Find the number of events that occur for each day for each channel
  SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS 	num_events
  FROM web_events w
  GROUP BY 1, 2
  ORDER BY num_events DESC;

2. Now create a subquery that simply provides all of the data from your first query
  SELECT * FROM
  (SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS 	num_events
  FROM web_events w
  GROUP BY 1, 2) sub;

3. Now find the average number of events for each channel. Since you broke out by day earlier, this is giving you the average per day
SELECT SUM(num_events) AS total_events, COUNT(DISTINCT day) AS total_days, SUM(num_events)/COUNT(DISTINCT day) AS avg_events_per_day, channel FROM 
(SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS 	num_events
FROM web_events w
GROUP BY 1, 2) sub
GROUP BY 4;
