LEFT pulls a specified number of characters for each row in a specified column starting at the beginning (or from the left). 
As you saw here, you can pull the first three digits of a phone number using LEFT(phone_number, 3).

RIGHT pulls a specified number of characters for each row in a specified column starting at the end (or from the right). A
s you saw here, you can pull the last eight digits of a phone number using RIGHT(phone_number, 8).


LENGTH provides the number of characters for each row of a specified column. Here, you saw that we could use this to get the length of each phone number as LENGTH(phone_number).
-- Practice
In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here(opens in a new tab). Pull these extensions and provide how many of each website type exist in the accounts table.
SELECT RIGHT(website, 3) AS domain, COUNT(*) 
FROM accounts
GROUP BY 1
ORDER BY count DESC;

There is much debate about how much the name (or even the first letter of a company name)(opens in a new tab) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).
SELECT LEFT(name, 1) AS first_letter, COUNT(*) num_companies
FROM accounts a 
GROUP BY 1
ORDER BY 2 DESC;

Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?


Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?

