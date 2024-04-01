In this video, you saw additional functionality for working with dates including:

TO_DATE
CAST
Casting with ::
DATE_PART('month', TO_DATE(month, 'month')) here changed a month name into the number associated with that particular month.

Then you can change a string to a date using CAST. CAST is actually useful to change lots of column types. Commonly you might be doing as you saw here, where you change a string to a date using CAST(date_column AS DATE). 
However, you might want to make other changes to your columns in terms of their data types. You can see other examples here(opens in a new tab).

In this example, you also saw that instead of CAST(date_column AS DATE), you can use date_column::DATE.

Most of the functions presented in this lesson are specific to strings. They won’t work with dates, integers or floating-point numbers. However, using any of these functions will automatically change the data to the appropriate type.

LEFT, RIGHT, and TRIM are all used to select only certain elements of strings, but using them to select elements of a number or date will treat them as strings for the purpose of the function. 
Though we didn't cover TRIM in this lesson explicitly, it can be used to remove characters from the beginning and end of a string. This can remove unwanted spaces at the beginning or end of a row that often happen with data being moved from Excel or other storage systems.

There are a number of variations of these functions, as well as several other string functions not covered here. Different databases use subtle variations on these functions, so be sure to look up the appropriate database’s syntax if you’re connected to a private database.

--Practice 
1. Write a query to change the date from sf_crime_data into the correct format. Use SUBSTR and CONCAT
WITH t1 AS
(SELECT SUBSTR(date, 1, 10) AS clean_date FROM sf_crime_data)
SELECT SUBSTR(clean_date, 7, 4) AS year, SUBSTR(clean_date, 1, 2) AS month, SUBSTR(clean_date, 4, 2) AS day FROM t1

OR

SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;

2. Once you have created a column in the correct format, use CAST to convert into a date
WITH t1 AS
(SELECT SUBSTR(date, 1, 10) AS clean_date FROM sf_crime_data),

t2 AS
(SELECT SUBSTR(clean_date, 7, 4) AS year, SUBSTR(clean_date, 1, 2) AS month, SUBSTR(clean_date, 4, 2) AS day FROM t1),

t3 AS
(SELECT t2.year || '-' || t2.month || '-' || t2.day AS new_date FROM t2)

SELECT CAST(t3.new_date AS date) FROM t3;

OR

SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data;
