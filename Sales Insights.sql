/*Show all customer records*/
SELECT * FROM sales.customers;

/*Show transactions in 2020 join by date table*/
SELECT sales.transactions.*, sales.date.* 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020;

/*Show transactions in 2019 join by date table*/
SELECT sales.transactions.*, sales.date.* 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019;

-- Remove hidden carriage return characters from currency values
-- Standardize currency codes for accurate analysis.
SET SQL_SAFE_UPDATES = 0;

update transactions
set currency = trim(replace(currency, '\r', ''))
where currency like '%r%';

/*Show total revenue in year 2020*/
SELECT sum(sales.transactions.sales_amount) 
from sales.transactions
INNER JOIN sales.date
ON sales.transactions.order_date=sales.date.date
where sales.date.year= 2020 and transactions.currency IN ("INR" , "USD");


/*Show total revenue in year 2019,*/
SELECT SUM(sales.transactions.sales_amount) 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year= 2019 and transactions.currency IN ("INR" , "USD");

/*Show  average in year 2020,*/
SELECT AVG(sales.transactions.sales_amount) 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year= 2020 and transactions.currency IN ("INR" , "USD");


/*Show  max sales amount in year 2019,*/
SELECT MAX(sales.transactions.sales_amount) 
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year= 2019 and transactions.currency IN ("INR" , "USD");

/* Show total revenue in year 2020, January Month */
-- Show total revenue in year 2020, January Month
SELECT SUM(transactions.sales_amount) 
FROM transactions 
INNER JOIN date 
ON transactions.order_date=date.date 
where date.year=2020 and date.month_name="January"
and (transactions.currency="INR" or transactions.currency="USD");


/*Show total revenue in year 2020, February Month,*/
SELECT SUM(transactions.sales_amount) 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='February' 
and transactions.currency IN ("INR" , "USD");


/*Show total revenue in year 2019, February Month,*/
SELECT SUM(transactions.sales_amount) 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019 and sales.date.month_name='February' 
and transactions.currency IN ("INR" , "USD");

/*Show total revenue in year 2020 in Chennai*/
SELECT SUM(sales.transactions.sales_amount) 
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.market_code="Mark001";

/*Show total revenue in year 2020 in Mumbai*/
SELECT SUM(sales.transactions.sales_amount) 
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.market_code="Mark002";

/*show the distinct product channai*/
SELECT distinct product_code from sales.transactions where market_code='Mark001';

/* show the distinct product Mumbai */
SELECT distinct product_code from sales.transactions where market_code='Mark002';

/* Show total revenue in year 2020, January Month, in chennai */
SELECT SUM(transactions.sales_amount) 
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='January' 
and sales.transactions.market_code="Mark001";


-- Identify product codes present in transactions table
-- but missing from the products master table
SELECT DISTINCT t.product_code
FROM transactions t
LEFT JOIN products p
ON t.product_code = p.product_code
WHERE p.product_code IS NULL;
