-- ***********************
-- Name: FENIL SONI
-- ID: 145416228
-- Date: 2024-03-10
-- Purpose: Lab 6 DBS311
-- ***********************
-- ***********************
-- Name: Justin San Pedro
-- ID: 151471224
-- Date: 2024-03-10
-- Purpose: Lab 6 DBS311
-- ***********************
-- ***********************
-- Name: MOHAMED ASHRAF BHAROT
-- ID: 139539225
-- Date: 2024-03-10
-- Purpose: Lab 6 DBS311
-- ***********************
SET SERVEROUTPUT ON;

-- Q1 --
-- Write a store procedure that gets an integer number n and calculates and displays its factorial

-- Q1 SOLUTION --
CREATE OR REPLACE PROCEDURE fact(n IN INT) AS
    message VARCHAR2(10000);
    i INT := 0;
    result NUMBER := n;
BEGIN
    IF (n = 0) THEN
        message := n || '! = 1';
    ELSE
        message := n || '! = fact(' || n || ') = ' || n;
        i := i + 1;
        WHILE (n-i) > 0 LOOP
            message := message || ' * ' || (n-i);
            result := result * (n-i);
            i := i+1;
        END LOOP;
        message := message || ' = ' || result;
    END IF;

    DBMS_OUTPUT.PUT_LINE(message);
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE('No Data Found');
    WHEN TOO_MANY_ROWS
        THEN
            DBMS_OUTPUT.PUT_LINE('Too Many Rows Returned');
    WHEN VALUE_ERROR
        THEN
            DBMS_OUTPUT.PUT_LINE('Value Too Large');
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

-- Q1 TEST --
BEGIN
    fact(0);
    fact(2);
    fact(3);
    fact(10);
END;
/

-- Q2 --
-- Write a stored procedure named calculate_salary which gets an employee ID and for that employee calculates 
-- the salary based on the number of years the employee has been working in the company.  
-- (Use a loop construct to calculate the salary).

-- Q2 SOLUTION --
CREATE OR REPLACE PROCEDURE calculate_salary(empID IN employees.employee_id%TYPE) AS
    increaseRate NUMBER(4,2) := 0.05;
    i INT := 0;
    currentSalary NUMBER := 10000;
    fname employees.first_name%TYPE;
    lname employees.last_name%TYPE;
    numYears NUMBER;
BEGIN
    SELECT first_name, last_name, EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM hire_date)
        INTO fname, lname, numYears
    FROM employees
    WHERE employee_id = empID;
    
    WHILE i < numYears LOOP
        currentSalary := currentSalary * (1+increaseRate);
        i := i+1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('First Name: ' || fname);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || lname);
    DBMS_OUTPUT.PUT_LINE('Salary:' || TO_CHAR(currentSalary, '$99,999.99'));
    DBMS_OUTPUT.NEW_LINE;
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE('Employee With ID Number ' || empID || ' Not Found');
            DBMS_OUTPUT.NEW_LINE;
    WHEN TOO_MANY_ROWS
        THEN
            DBMS_OUTPUT.PUT_LINE('Too Many Rows Returned');
    WHEN VALUE_ERROR
        THEN
            DBMS_OUTPUT.PUT_LINE('Value Too Large');
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

-- Q2 TEST --
BEGIN
    calculate_salary(0);
    calculate_salary(100);
    calculate_salary(101);
    calculate_salary(102);
END;
/
SELECT first_name, last_name, salary
FROM employees_a;
/

-- Q3 --
-- Write a stored procedure named warehouses_report to print the warehouse ID, warehouse name, 
-- and the city where the warehouse is located in the following format for all warehouses

-- Q3 SOLUTION --
CREATE OR REPLACE PROCEDURE warehouse_report AS
    wID warehouses.warehouse_id%TYPE;
    wName warehouses.warehouse_name%TYPE;
    wCity locations.city%TYPE;
    wState locations.state%TYPE;
    i INT := 0;
    maxWarehouseID INT := 9;
BEGIN
    WHILE i <= maxWarehouseID LOOP
        SELECT MIN(warehouse_id)
            INTO i
        FROM warehouses
        WHERE warehouse_id > i;
    
        SELECT warehouse_id, warehouse_name, city, NVL(state, 'no state')
            INTO wID, wName, wCity, wState
        FROM warehouses
        NATURAL JOIN locations
        WHERE warehouse_id = i;
        
        DBMS_OUTPUT.PUT_LINE('Warehouse ID: ' || wID);
        DBMS_OUTPUT.PUT_LINE('Warehouse name: ' || wName);
        DBMS_OUTPUT.PUT_LINE('City: ' || wCity);
        DBMS_OUTPUT.PUT_LINE('State: ' || wState);
        DBMS_OUTPUT.NEW_LINE;
        
        IF i >= maxWarehouseID
            THEN EXIT;
        END IF;
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE('No Data Found');
    WHEN TOO_MANY_ROWS
        THEN
            DBMS_OUTPUT.PUT_LINE('Too Many Rows Returned');
    WHEN ROWTYPE_MISMATCH
        THEN
            DBMS_OUTPUT.PUT_LINE('Value Passed to Stored Variable/s Not Compatible');
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

-- Q3 TEST --
BEGIN
    warehouse_report();
END;
/