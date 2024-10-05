-- ***********************
-- Name: Justin San Pedro
-- ID: 151471224
-- Date: 2024-01-16
-- Purpose: Lab 1 DBS311
-- ***********************
-- ***********************
-- Name: MOHAMED ASHRAF BHAROT
-- ID: 139539225
-- Date: 2024-01-16
-- Purpose: Lab 1 DBS311
-- ***********************
-- ***********************
-- Name: FENIL SONI
-- ID: 145416228
-- Date: 2024-01-16
-- Purpose: Lab 1 DBS311
-- ***********************




-- Q1: Write a query to display the tomorrow's date in the following format:

 SELECT TO_CHAR(CURRENT_DATE+1, 'FMMonth ddth "of year" YYYY') AS "Tomorrow" 
 FROM dual;



-- Q2: For each product in category 2, 3, and 5, show product ID, product name, list price, and the new list price increased by 2%. Display a new list price as a whole number.

SELECT 
    product_id, product_name, list_price,
    ROUND(list_price * 1.02) AS NEW_LIST_PRICE,
    ROUND((list_price * 1.02) - list_price) AS DIFFERENCE_PRICE
FROM 
    products
WHERE 
    category_id IN (2, 3, 5);




-- Q3: For employees whose manager ID is 2, write a query that displays the employee's Full Name and Job Title in the following format:

SELECT UPPER(last_name || ', ' || first_name) || ' is ' || job_title AS  "Name and Job Title"
FROM employees
WHERE manager_id = 2;

-- Q4: For each employee hired before October 2016, display the employee's last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.

SELECT last_name, hire_date, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) AS "YEARS_WORKED"
FROM employees
WHERE hire_date < to_date('10/01/2016', 'MM/DD/YYYY')
ORDER BY "YEARS_WORKED";

-- Q5: Display each employee's last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016.  

SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(hire_date+365, 'Tuesday'), 'FMDAY, Month "the "DdSPTH" of year" YYYY') AS "REVIEW DAY"
FROM employees
WHERE hire_date > TO_DATE('12/31/2016', 'MM/DD/YYYY')
ORDER BY "REVIEW DAY";

-- Q6: For all warehouses, display warehouse id, warehouse name, city, and state. For warehouses with the null value for the state column, display “unknown”.

SELECT W.WAREHOUSE_ID,W.WAREHOUSE_NAME,L.CITY, NVL(L.state, 'unknown')
FROM WAREHOUSES W
JOIN LOCATIONS L 
ON W.LOCATION_ID = L.LOCATION_ID;