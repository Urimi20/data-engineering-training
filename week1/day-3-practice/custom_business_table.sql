-- Query 1: Show all rows from the custom business table
SELECT *
FROM online_store_orders;


-- Query 2: Show selected columns
SELECT customer_name, product
FROM online_store_orders;


-- Query 3: Show only paid orders
SELECT *
FROM online_store_orders
WHERE status = 'paid';


-- Query 4: Show orders where price is greater than 100
SELECT *
FROM online_store_orders
WHERE price > 100;


-- Query 5: Show paid orders with price greater than 100
SELECT *
FROM online_store_orders
WHERE status = 'paid' AND price > 100;


-- Query 6: Show unpaid or cancelled orders
SELECT *
FROM online_store_orders
WHERE status = 'unpaid' OR status = 'cancelled';


-- Query 7: Show orders sorted by highest price
SELECT *
FROM online_store_orders
ORDER BY price DESC;


-- Query 8: Show total amount for each order
SELECT 
    customer_name,
    product,
    quantity * price AS total_amount
FROM online_store_orders;