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
