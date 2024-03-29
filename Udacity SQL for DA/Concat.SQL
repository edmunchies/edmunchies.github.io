CONCAT combines values from several columns into a single column. You can use || (pipe) to do the same thing
SELECT first_name, 
        last_name, 
    CONCAT(first_name, ' ', last_name) AS full_name,
    first_name || ' ' || last_name AS full_name_alt,
FROM table_name

Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
WITH t1 AS
(SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name,
a.name
FROM accounts a)

SELECT first_name || '.' || last_name || '@' || t1.name || '.com' AS email
FROM t1;

You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here(opens in a new tab).
WITH t1 AS
(SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name,
a.name
FROM accounts a)

SELECT first_name || '.' || last_name || '@' || REPLACE(name, ' ', '') || '.com'  AS email
FROM t1;

We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.
WITH t1 AS
(SELECT primary_poc,
LEFT(LOWER(primary_poc), 1) AS first_name_first_letter,
RIGHT(LEFT(primary_poc, STRPOS(primary_poc,' ') - 1) , 1) AS first_name_last_letter,
LEFT(LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' '))), 1) AS last_name_first_letter,
RIGHT(LOWER(primary_poc), 1) AS last_name_last_letter,
LENGTH(LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1)) AS num_of_letters_first_name,
LENGTH(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' '))) AS num_of_letters_last_name,
REPLACE(name, ' ', '') AS company_name
FROM accounts a)

SELECT first_name_first_letter || first_name_last_letter || last_name_first_letter || last_name_last_letter || num_of_letters_first_name || num_of_letters_last_name || UPPER(company_name) AS password FROM t1;

-----------------------

WITH t1 AS (
    SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
    FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;
