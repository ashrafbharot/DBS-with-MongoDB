-- ***********************
-- Name: Justin San Pedro
-- ID: 151471224
-- Date: 2024-01-23
-- Purpose: Lab 2 DBS311
-- ***********************
-- ***********************
-- Name: MOHAMED ASHRAF BHAROT
-- ID: 139539225
-- Date: 2024-01-23
-- Purpose: Lab 2 DBS311
-- ***********************
-- ***********************
-- Name: FENIL SONI
-- ID: 145416228
-- Date: 2024-01-23
-- Purpose: Lab 2 DBS311
-- ***********************


-- 1.
-- For each job title, display the number of employees. Sort the result according to the number of employees.
SELECT job_title, COUNT(employee_id) AS "EMPLOYEES"
FROM employees
GROUP BY job_title
ORDER BY "EMPLOYEES";

-- 2.	
-- Display the highest, lowest, and average customer credit limits. 
-- Name these results high, low, and average. 
-- Add a column that shows the difference between the highest and the lowest credit limits named �High and Low Difference�. 
-- Round the average to 2 decimal places.
SELECT MAX(credit_limit) AS "HIGH", MIN(credit_limit) AS "LOW", 
    ROUND(AVG(credit_limit),2) AS "AVERAGE", 
    MAX(credit_limit) - MIN(credit_limit) AS "High Low Difference"
FROM customers;

-- 3.
-- Display the order id, the total number of products, and the total order amount for orders with the 
-- total amount over $1,000,000. Sort the result based on total amount from the high to low values.
SELECT order_id, SUM(quantity) AS "TOTAL_ITEMS", SUM(quantity*unit_price) AS "TOTAL_AMOUNT"
FROM order_items
GROUP BY order_id
HAVING SUM(quantity*unit_price) > 1000000
ORDER BY "TOTAL_AMOUNT" DESC;

-- 4.
-- Display the warehouse id, warehouse name, and the total number of products for each warehouse. 
-- Sort the result according to the warehouse ID.
SELECT i.warehouse_id, w.warehouse_name, SUM(i.quantity) AS "TOTAL_PRODUCTS"
FROM inventories i
INNER JOIN warehouses w
ON w.warehouse_id = i.warehouse_id
GROUP BY i.warehouse_id, w.warehouse_name
ORDER BY i.warehouse_id;

-- 5.
-- For each customer, display customer number, customer full name, and the total number of orders issued by the customer. 
-- ?    If the customer does not have any orders, the result shows 0.
-- ?    	Display only customers whose customer name starts with �O� and contains �e�.
-- ?    	Include also customers whose customer name ends with�t�.
-- ?    	Show the customers with highest number of orders first.
SELECT c.customer_id, c.name AS "customer name", COUNT(o.customer_id) AS "total number OF orders"
FROM orders o
RIGHT JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING c.name LIKE 'O%e%' OR c.name LIKE '%t'
ORDER BY 3 DESC;

-- 6.
-- Write a SQL query to show the total and the average sale amount for each category. 
-- Round the average to 2 decimal places.
SELECT p.category_id, ROUND(SUM(oi.quantity*oi.unit_price),2) AS "TOTAL_AMOUNT", 
    ROUND(AVG(oi.quantity*oi.unit_price),2) AS "AVERAGE_AMOUNT"
FROM products p
INNER JOIN order_items oi
ON oi.product_id = p.product_id
GROUP BY p.category_id
ORDER BY (
CASE p.category_id
WHEN 5 THEN 4
WHEN 4 THEN 5
ELSE 1 
END);
