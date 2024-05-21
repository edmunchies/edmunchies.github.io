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
