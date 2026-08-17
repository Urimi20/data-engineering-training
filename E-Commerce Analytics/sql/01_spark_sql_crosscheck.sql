
-- 1. READ CLEAN ORDERS

CREATE OR REPLACE TEMP VIEW clean_orders AS

SELECT
    CAST(order_id AS INT) AS order_id,
    CAST(customer_id AS INT) AS customer_id,
    order_date,
    city,
    product_category,
    CAST(quantity AS INT) AS quantity,
    CAST(unit_price AS DOUBLE) AS unit_price,
    status,
    payment_method,
    CAST(quantity AS INT) * CAST(unit_price AS DOUBLE) AS total_amount

FROM read_files(
    '/Volumes/ecommerce_catalog/ecommerce_schema/silver/clean_orders/clean_orders.csv',
    format => 'csv',
    header => true
);


-- 2. READ CLEAN CUSTOMERS

CREATE OR REPLACE TEMP VIEW clean_customers AS

SELECT
    CAST(customer_id AS INT) AS customer_id,
    customer_name,
    email,
    city,
    customer_type

FROM read_files(
    '/Volumes/ecommerce_catalog/ecommerce_schema/silver/clean_customers/clean_customers.csv',
    format => 'csv',
    header => true
);


-- CROSS-CHECK 1
-- COMPLETED ORDERS

SELECT
    COUNT(*) AS completed_orders
FROM clean_orders
WHERE LOWER(TRIM(status)) = 'completed';


-- CROSS-CHECK 2
-- REVENUE BY CITY

SELECT
    city,
    SUM(total_amount) AS revenue
FROM clean_orders
WHERE LOWER(TRIM(status)) = 'completed'
GROUP BY city
ORDER BY revenue DESC;


-- CROSS-CHECK 3
-- REVENUE BY PRODUCT CATEGORY

SELECT
    product_category,
    SUM(total_amount) AS revenue
FROM clean_orders
WHERE LOWER(TRIM(status)) = 'completed'
GROUP BY product_category
ORDER BY revenue DESC;