-- Create Table
CREATE TABLE reatil_sales_analysis(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender	VARCHAR(20),
	age	INT,
	category VARCHAR(20),	
	quantiy	INT,
	price_per_unit FLOAT,	
	cogs FLOAT,
	total_sale FLOAT

)

SELECT * FROM reatil_sales_analysis


SELECT 
	COUNT (*) 
FROM reatil_sales_analysis

-- SELECT *
-- FROM reatil_sales_analysis
-- WHERE 
-- 	transactions_id IS NULL
-- 	OR
-- 	sale_date IS NULL
-- 	OR
-- 	sale_time IS NULL
-- 	OR
-- 	customer_id IS NULL
-- 	OR
-- 	gender IS NULL
-- 	OR
-- 	age IS NULL
-- 	OR
-- 	category IS NULL
-- 	OR
-- 	quantiy IS NULL
-- 	OR
-- 	price_per_unit IS NULL
-- 	OR
-- 	cogs IS NULL
-- 	OR
-- 	total_sale IS NULL


-- DELETE FROM reatil_sales_analysis
-- WHERE 
-- 	transactions_id IS NULL
-- 	OR
-- 	sale_date IS NULL
-- 	OR
-- 	sale_time IS NULL
-- 	OR
-- 	customer_id IS NULL
-- 	OR
-- 	gender IS NULL
-- 	OR
-- 	age IS NULL
-- 	OR
-- 	category IS NULL
-- 	OR
-- 	quantiy IS NULL
-- 	OR
-- 	price_per_unit IS NULL
-- 	OR
-- 	cogs IS NULL
-- 	OR
-- 	total_sale IS NULL

SELECT 
	COUNT (DISTINCT customer_id)
FROM reatil_sales_analysis

SELECT 
	COUNT (DISTINCT category)
FROM reatil_sales_analysis

-- Data analysis and Business problem
-- Q.1 write a sql query to retrive all columns for sales made on 2012-11-05
SELECT * FROM reatil_sales_analysis
WHERE sale_date = '2022-11-05'

-- Q.2 write a sql query script to retrive all transaction where all the category is clothing and the quantity
-- sold is more than 4 in the month of Nov-2022
SELECT * 
FROM reatil_sales_analysis
WHERE category = 'Clothing'
	   AND 
	   quantiy >= '4'
	   AND 
	   TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
ORDER BY 1

-- Q.3 write a sql query to calculate the total sales for each category
SELECT 
	category,
	SUM(total_sale) AS net_sale,
	COUNT(*) AS total_orders
FROM reatil_sales_analysis
GROUP BY 1

-- Q.4 write a sql query to find the average age of customers who purchased items from the 'Beauty' category
SELECT 
	category, 
	ROUND(AVG (age), 2) AS avg_age
FROM reatil_sales_analysis
WHERE category = 'Beauty'
GROUP BY 1

-- Q.5 write a sql query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM reatil_sales_analysis
WHERE total_sale >= '1000'

-- Q.6 write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category,
	gender,
	COUNT(*) AS total_trans
FROM reatil_sales_analysis
GROUP BY 1, 2

-- Q.7 write a sql query to calculate the average sale for each month, find the best selling month for each year
SELECT 
	year,
	month,
	avg_sale
FROM
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC) AS rank
	FROM reatil_sales_analysis
	GROUP BY 1,2
) AS t1
WHERE rank = 1
-- ORDER BY 1,3 DESC

-- Q.8 write an sql query to find the top five customers based on the highest total sale
SELECT 
	customer_id,
	SUM(total_sale) AS total_sale
FROM reatil_sales_analysis
GROUP BY 1
ORDER BY total_sale DESC
LIMIT 5

-- Q.9 write a sql query to find the number of unique customers who purchased items in each category
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS unique_custmers
FROM reatil_sales_analysis
GROUP BY category

-- Q.10 write a sql query to create each shift and number of orders (Example Morning <= 12, Afternoon between 12 & 17, Evening > 17)
WITH hourly_sales
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning' 
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS SHIFT 
FROM reatil_sales_analysis
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift

-- END OF PRACTICE PROJECT