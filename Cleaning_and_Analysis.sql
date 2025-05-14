-- Retail Sales Data Cleaning and Analysis
-- =======================================

-- 1. Load the Sales Data
SELECT * FROM store.sales;


-- 2. Remove Duplicates
-- --------------------
SELECT transaction_id, COUNT(*)
FROM sales
GROUP BY transaction_id
HAVING COUNT(*) = 2;

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS Row_Num
    FROM sales
)
DELETE FROM sales
WHERE transaction_id IN (
    SELECT transaction_id
    FROM cte
    WHERE Row_Num = 2
);


-- 3. Correct Column Names
-- -----------------------
ALTER TABLE sales CHANGE quantiy quantity INT;
ALTER TABLE sales CHANGE prce price INT;


-- 4. Convert Purchase Date to Proper Date Format
-- ----------------------------------------------
ALTER TABLE sales ADD purchase_date_temp DATE;

UPDATE sales
SET purchase_date_temp = STR_TO_DATE(purchase_date, '%d/%m/%Y');

ALTER TABLE sales DROP COLUMN purchase_date;
ALTER TABLE sales CHANGE purchase_date_temp purchase_date DATE;


-- 5. Check for Null or Empty Fields
-- ---------------------------------
SELECT *
FROM sales
WHERE transaction_id IS NULL OR transaction_id = ''
   OR customer_id IS NULL OR customer_id = ''
   OR customer_age IS NULL
   OR gender IS NULL OR gender = ''
   OR product_id IS NULL OR product_id = ''
   OR product_category IS NULL OR product_category = ''
   OR quantity IS NULL
   OR price IS NULL
   OR payment_mode IS NULL OR payment_mode = ''
   OR time_of_purchase IS NULL
   OR `status` IS NULL OR `status` = ''
   OR purchase_date IS NULL;


-- 6. Fix Missing Customer IDs
-- ---------------------------
UPDATE sales SET customer_id = 'CUST9494' WHERE transaction_id = 'TXN977900';
UPDATE sales SET customer_id = 'CUST1401' WHERE transaction_id = 'TXN985663';


-- 7. Normalize Gender and Payment Mode
-- ------------------------------------
UPDATE sales SET gender = 'Female' WHERE gender = 'F';
UPDATE sales SET gender = 'Male' WHERE gender = 'M';

UPDATE sales SET payment_mode = 'Credit Card' WHERE payment_mode = 'CC';


-- =======================================
-- 🧠 Data Analysis Begins
-- =======================================

-- 1. Top 5 Selling Products
SELECT product_name, SUM(quantity) AS quantity
FROM sales
WHERE status = 'delivered'
GROUP BY product_name
ORDER BY quantity DESC
LIMIT 5;


-- 2. Most Frequently Cancelled Products
SELECT product_name, COUNT(*) AS cancelled_orders
FROM sales
WHERE status = 'cancelled'
GROUP BY product_name
ORDER BY cancelled_orders DESC
LIMIT 5;


-- 3. Purchase Time Distribution
SELECT 
    CASE
        WHEN HOUR(time_of_purchase) BETWEEN 0 AND 5 THEN 'Night'
        WHEN HOUR(time_of_purchase) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(time_of_purchase) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(time_of_purchase) BETWEEN 18 AND 23 THEN 'Evening'
    END AS time_of_day,
    COUNT(*) AS total_orders
FROM sales
GROUP BY time_of_day
ORDER BY total_orders DESC;


-- 4. Top 5 Highest Spending Customers
SELECT customer_name,
       SUM(price * quantity) AS total_spent,
       COUNT(*) AS total_orders
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;


-- 5. Revenue by Product Category
SELECT product_category, SUM(quantity * price) AS revenue
FROM sales
GROUP BY product_category
ORDER BY revenue DESC
LIMIT 5;


-- 6. Return and Cancellation Rates
SELECT product_category, 
       CONCAT(FORMAT(COUNT(CASE WHEN `status` = 'cancelled' THEN 1 END) * 100 / COUNT(*), 2), '%') AS cancellation_rate
FROM sales
GROUP BY product_category
ORDER BY cancellation_rate DESC;

SELECT product_category, 
       CONCAT(FORMAT(COUNT(CASE WHEN `status` = 'returned' THEN 1 END) * 100 / COUNT(*), 2), '%') AS return_rate
FROM sales
GROUP BY product_category
ORDER BY return_rate DESC;


-- 7. Preferred Payment Mode
SELECT payment_mode, COUNT(*) AS usage_count
FROM sales
GROUP BY payment_mode
ORDER BY usage_count DESC;


-- 8. Age Group Purchase Behavior
SELECT
    CASE
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END AS age_group,
    CONCAT('Rs ', FORMAT(SUM(price * quantity), 0)) AS total_spent
FROM sales
GROUP BY age_group
ORDER BY total_spent DESC;


-- 9. Monthly Sales Trend
SELECT 
    YEAR(purchase_date) AS year,
    MONTHNAME(purchase_date) AS month,
    MONTH(purchase_date) AS month_num,
    SUM(price * quantity) AS monthly_sales
FROM sales
GROUP BY year, month, month_num
ORDER BY year, month_num;


-- 10. Gender-Wise Product Category Interest
SELECT
    product_category,
    SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS Male,
    SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS Female
FROM sales
GROUP BY product_category
ORDER BY product_category;
