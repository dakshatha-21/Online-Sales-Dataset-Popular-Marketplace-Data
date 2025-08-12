CREATE DATABASE Sales_db;

CREATE TABLE Sales_db.Online_Sales (
    `Transaction ID` INT,
    `Date` DATE,
    `Product Category` VARCHAR(100),
    `Product Name` VARCHAR(200),
    `Units Sold` INT,
    `Unit Price` DECIMAL(10,2),
    `Total Revenue` DECIMAL(10,2),
    `Region` VARCHAR(100),
    `Payment Method` VARCHAR(50)
);

/*Monthly Revenue & Order Volume Analysis*/
SELECT 
YEAR(`Date`) as order_year,
MONTH(`Date`) as order_month,
SUM(`Total Revenue`) as total_revenue,
COUNT(DISTINCT `Transaction ID`) as total_orders
FROM Sales_db.Online_Sales
GROUP BY YEAR(`Date`),MONTH(`Date`)
ORDER BY order_year,order_month;

/*Add Month Names*/

SELECT 
DATE_FORMAT(`Date`,'%M-%Y') AS month_year,
SUM(`Total Revenue`) as total_revenue,
COUNT(DISTINCT `Transaction ID`) as total_orders
FROM  Sales_db.Online_Sales
GROUP BY month_year
ORDER BY str_to_date(month_year,'%M-%Y');

/*Break Down by Product Category*/

SELECT
YEAR(`Date`) as order_year,
MONTH(`Date`) as order_month,
SUM(`Total Revenue`) as total_revenue,
`Product Category`
FROM Sales_db.Online_Sales
GROUP BY YEAR(`Date`),MONTH(`Date`),`Product Category`
ORDER BY order_year,order_month,total_revenue DESC;

/*FIND THE BEST MONTH*/

SELECT 
    DATE_FORMAT(`Date`, '%M %Y') AS best_month,
    SUM(`Total Revenue`) AS total_revenue
FROM Sales_db.Online_Sales
GROUP BY best_month
ORDER BY total_revenue DESC
LIMIT 1;

/*Show all months ranked by revenue*/
SELECT 
    DATE_FORMAT(`Date`, '%M %Y') AS month_year,
    SUM(`Total Revenue`) AS total_revenue,
    COUNT(DISTINCT `Transaction ID`) AS total_orders
FROM Sales_db.Online_Sales
GROUP BY month_year
ORDER BY total_revenue DESC;

 /*Identify best-selling product per month*/
 
 SELECT 
    DATE_FORMAT(`Date`,'%M-%Y') AS month_year,
    `Product Name`,
    SUM(`Total Revenue`) AS total_revenue,
    SUM(`Units Sold`) AS total_units_sold
FROM Sales_db.Online_Sales
GROUP BY month_year, `Product Name`
ORDER BY month_year, total_revenue DESC;

/*MONTHLY SALES TRENDS*/
-- 1. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(`Date`, '%M-%Y') AS month_year,
    SUM(`Total Revenue`) AS total_revenue,
    COUNT(DISTINCT `Transaction ID`) AS total_orders
FROM Sales_db.Online_Sales
GROUP BY month_year
ORDER BY STR_TO_DATE(month_year, '%M-%Y') DESC;

-- 2. Yearly Growth Summary
SELECT 
    YEAR(`Date`) AS order_year,
    SUM(`Total Revenue`) AS total_revenue,
    COUNT(DISTINCT `Transaction ID`) AS total_orders
FROM Sales_db.Online_Sales
GROUP BY order_year
ORDER BY order_year;

-- Average Order Value by Month
SELECT 
    DATE_FORMAT(`Date`, '%M-%Y') AS month_year,
    SUM(`Total Revenue`) / COUNT(DISTINCT `Transaction ID`) AS avg_order_value
FROM Sales_db.Online_Sales
GROUP BY month_year
ORDER BY STR_TO_DATE(month_year, '%M-%Y');



