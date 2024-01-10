----------------------------------------
-- Date and Time Functions in Postgresql
----------------------------------------

-- Retrieve current date.
SELECT CURRENT_DATE;

-- Retrieve current time with timezone.
SELECT CURRENT_TIME;

-- Retrieve current time with a positional parameter (micro_seconds).
SELECT CURRENT_TIME(3);

-- Retrieve current timestamp.
SELECT CURRENT_TIMESTAMP;

-- Retrieve current date and time (like clock_timestamp, but as a text string).
SELECT timeofday();

-- Retrieve current date and time (at the start of the current transaction).
SELECT transaction_timestamp();

-- Retrieve the current date and time with NOW() function.
SELECT NOW();

-- Add 1 hour interval to NOW().
SELECT (NOW() + interval '1 hour') AS "1 hour later";

-- Add 5 days interval to NOW().
SELECT (NOW() + interval '5 days') AS "5 days later";

-- Calculate difference between December 20th, 2023 and January 1st, 2019.
SELECT AGE('2023-12-20', '2019-01-01');

-- How old is Mary, who was born March 13th, 1976.
SELECT AGE(CURRENT_DATE, '1976-03-13') AS mary_age;

-- Extract the day of the month of the current date.
SELECT EXTRACT(DAY FROM CURRENT_DATE);

-- Extract the day of the week of the current date.
SELECT EXTRACT(ISODOW FROM CURRENT_DATE);

-- Extract the hour of the month of the current date.
SELECT EXTRACT(HOUR FROM CURRENT_TIMESTAMP);

-- Extract the day of the date '2022-11-04'.
SELECT EXTRACT(DAY FROM DATE('2022-11-04'));

-- Extract minutes from time '184412'.
SELECT EXTRACT(MINUTE FROM '184412'::TIME);

-- Change string '2021/12/03' to correct date formate-
SELECT TO_DATE('2021/12/03', 'YYYY/MM/DD');

-- Change string '20211203' to correct date formate-
SELECT TO_DATE('20211203', 'YYYYMMDD');



------------------------------------
-- Create two tables and insert data
------------------------------------

-- Create table 'employees'.
CREATE TABLE IF NOT EXISTS employees(
    employee_id integer,
    first_name character varying(255),
    last_name character varying(255),
    birth_date date,
    hire_date date);

-- Insert data into table 'employees'.
INSERT INTO employees (employee_id, first_name, last_name, birth_date, hire_date) VALUES 
(1, 'Horatius', 'Ronca', '2001-06-05', '2013-01-27'),
(2, 'Yuma', 'Alderson', '1963-01-18', '2015-09-04'),
(3, 'Celisse', 'O''Cannovane', '1996-03-24', '2012-05-06'),
(4, 'Sherill', 'Peche', '1966-10-25', '2013-08-29'),
(5, 'Maitilde', 'Andrini', '2001-01-21', '2016-08-17'),
(6, 'Elga', 'Dominelli', '1991-01-07', '2017-04-29'),
(7, 'Barbette', 'Loyns', '1983-10-05', '2018-10-26'),
(8, 'Alia', 'Geharke', '1984-03-01', '2016-10-26'),
(9, 'Karleen', 'Khidr', '1989-09-25', '2020-03-06'),
(10, 'Hyacinthia', 'Goldberg', '1967-08-18', '2011-06-17'),
(11, 'Hally', 'Oiseau', '1965-04-22', '2011-02-16'),
(12, 'Sarge', 'Vaughten', '1982-07-01', '2011-07-31'),
(13, 'Merlina', 'Albro', '1972-09-17', '2018-04-19'),
(14, 'Dur', 'Dorre', '1964-08-01', '2020-01-30'),
(15, 'Dotty', 'Sesser', '1979-06-24', '2018-01-09'),
(16, 'Kevan', 'Coffelt', '2003-12-07', '2015-03-14'),
(17, 'Rhona', 'Baselio', '1976-05-17', '2018-05-29'),
(18, 'Gwenneth', 'Coyish', '1976-03-08', '2015-05-20'),
(19, 'Alicia', 'Tomasian', '1984-11-10', '2019-10-20'),
(20, 'Corie', 'Vedmore', '1994-09-14', '2017-04-14');

-- Create table 'shipping'.
CREATE TABLE IF NOT EXISTS shipping(
    shipping_id integer,
    order_id integer,
    shipping_date date,
    delivery_date date);

-- Insert data into table 'shipping'.
insert into shipping (shipping_id, order_id, shipping_date, delivery_date) values 
(1, 8147, '2023-01-17', '2023-12-09'),
(2, 1760, '2023-01-08', '2023-12-07'),
(3, 7597, '2023-02-14', '2023-11-03'),
(4, 6367, '2023-04-27', '2023-11-05'),
(5, 8939, '2023-09-01', '2023-12-24'),
(6, 8615, '2023-05-26', '2023-11-24'),
(7, 5112, '2023-06-24', '2023-11-30'),
(8, 4194, '2023-06-29', '2023-11-11'),
(9, 1019, '2023-07-03', '2023-12-25'),
(10, 4581, '2023-03-05', '2023-10-19'),
(11, 2243, '2023-09-05', '2023-10-18'),
(12, 8771, '2023-04-16', '2023-11-29'),
(13, 3685, '2023-04-14', '2023-12-24'),
(14, 7162, '2023-03-07', '2023-12-02'),
(15, 3317, '2023-08-10', '2023-12-01'),
(16, 8963, '2023-07-24', '2023-12-10'),
(17, 2251, '2023-02-18', '2023-10-26'),
(18, 5450, '2023-08-14', '2023-11-24'),
(19, 3853, '2023-02-04', '2023-11-12'),
(20, 4022, '2023-10-07', '2023-10-29');



--------------------------------------------
-- Query tables with date and time functions
--------------------------------------------

-- Calculate the age of the employees.
SELECT first_name, last_name, AGE(CURRENT_DATE, birth_date) AS age FROM employees;

-- How old were the employees, when they were hired?
SELECT first_name, last_name, EXTRACT(YEAR FROM AGE(hire_date, birth_date)) AS hire_age 
FROM employees
ORDER BY hire_age DESC;

-- Calculate the average age (rounded to year) of the employees.
SELECT EXTRACT(YEAR FROM AVG(AGE(CURRENT_DATE, birth_date))) AS avg_age_year 
FROM employees;

-- Who has worked more the 8 year in our company?
SELECT first_name, last_name, AGE(CURRENT_DATE, hire_date) AS time_employed 
FROM employees 
WHERE AGE(CURRENT_DATE, hire_date) > '8 years'
ORDER BY 3 DESC;

-- Calculate shipping time in seconds.
SELECT shipping_id, shipping_date, delivery_date, 
(EXTRACT(EPOCH FROM delivery_date) - EXTRACT(EPOCH FROM shipping_date)) AS shipping_seconds
FROM shipping
ORDER BY shipping_seconds DESC;

-- Calculate shipping time in days.
SELECT shipping_id, shipping_date, delivery_date, 
(EXTRACT(DAY FROM delivery_date) - EXTRACT(DAY FROM shipping_date)) AS shipping_days
FROM shipping 
ORDER BY shipping_days DESC;

-- How many shippings go out per month?
SELECT COUNT(*) AS number_of_shippings, TO_CHAR(shipping_date, 'Month') AS shipping_month
FROM shipping
GROUP BY shipping_month
ORDER BY number_of_shippings DESC;

-- Same query as before, but not ordered by the number of shippings, instead ordered by the number of the month.
SELECT EXTRACT(MONTH FROM shipping_date) AS month_int,
TO_CHAR(shipping_date, 'Month') AS shipping_month,
COUNT(*) AS shipping_number
FROM shipping
GROUP BY month_int, shipping_month
ORDER BY month_int ASC;

-- Cast the delivery_date of the shipping table to a string in the format of 'Month FMDDth, YYYY' ('August 21st, 2020').
SELECT delivery_date, TO_CHAR(delivery_date, 'Month FMDDth, YYYY') from shipping;

-- Cast the delivery_date of the shipping table to a string in the format of 'Day/Month' ('Monday/December').
SELECT delivery_date, TO_CHAR(delivery_date, 'Day/Month') from shipping;

-- Retrieve everything from the employees table and add a column with the hire_date cast as string.
SELECT *, TO_CHAR(hire_date, 'YYYY-MM-DD') FROM employees;




