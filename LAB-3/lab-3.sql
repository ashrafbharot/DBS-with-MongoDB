

-- Q1 SOLUTION --
SELECT last_name, TO_CHAR(hire_date, 'DD-MON-YY')
FROM employees
WHERE hire_date > TO_DATE('2016-04-01', 'YYYY-MM-DD')
    AND hire_date < (SELECT hire_date FROM employees WHERE employee_id = 107)
ORDER BY hire_date, employee_id;


-- Q2 SOLUTION --
SELECT name, credit_limit
FROM customers
WHERE credit_limit = (SELECT MIN(credit_limit) FROM customers)
ORDER BY customer_id;


-- Q3 SOLUTION --
SELECT category_id, product_id, product_name, list_price
FROM products p1
WHERE list_price = (
    SELECT MAX(list_price)
    FROM products p2
    WHERE p1.category_id = p2.category_id
)
ORDER BY category_id, product_id;



-- Q4 SOLUTION --
SELECT c.category_id, c.category_name
FROM product_categories c
JOIN products p ON c.category_id = p.category_id
WHERE p.list_price = (SELECT MAX(list_price) FROM products);


-- Q5 SOLUTION --
SELECT product_name, list_price
FROM products
WHERE category_id = 1
    AND list_price < ANY (SELECT MIN(list_price) FROM products GROUP BY category_id)
ORDER BY list_price DESC, product_id;


-- Q6 SOLUTION --
SELECT MAX(list_price)
FROM products
WHERE category_id = (
    SELECT category_id FROM products WHERE list_price = (
        SELECT MIN(list_price) FROM products)
);

