-- V1: Check the total number of orders available in the orders table.
-- This verifies the total transaction records in the dataset.

SELECT COUNT(*) as total_orders from orders


-- V2: COUNT only completed orders.
-- Completed orders are the transactions that can generate revenue.

SELECT COUNT(*) as total_completed_orders 
FROM orders 
WHERE status = 'completed'

-- V3: COUNT pending orders.
-- Pending orders are not finished and should not be included in revenue calculations.

SELECT COUNT(*) as total_pending_orders 
FROM orders 
WHERE status = 'pending'

-- V4: COUNT cancelled orders.
-- Cancelled orders should not be considered successful transactions.


SELECT COUNT(*) as total_cancelled_orders 
FROM orders 
WHERE status = 'cancelled'

-- V5: Count all customers.
-- 

SELECT COUNT(*) as total_costumers from costumers

-- V5: Count all products.
-- 

SELECT COUNT(*) as total_products from products


-- V7: Calculate total revenue only from completed orders.
-- Pending and cancelled orders are excluded because they are not real sales.
SELECT 
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed';



-- V8: Calculate completed revenue grouped by product name.
-- This shows which products generate the most revenue.

SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name


-- V9: Calculate completed revenue grouped by product category.
-- This shows which products generate the most revenue.
SELECT
    products.category,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name


-- V10: Count orders by customer city.
-- Customer city information comes from the customers table.

SELECT customers.city ,
COUNT(orders.order_id) as order_count
FROM orders 
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY order_count;



-- V11: Find customers who placed more than one order.
-- This identifies repeat customers.
SELECT
    customer_id,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;



-- V12: Find the top 3 completed orders by total amount.
-- Calculates order value using quantity multiplied by product price.
SELECT
    orders.order_id,
    products.product_name,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS total_amount
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
ORDER BY total_amount DESC
LIMIT 3;

-- V13: Find orders that should not count as real revenue.
-- Pending and cancelled orders are excluded from revenue.
SELECT *
FROM orders
WHERE status IN ('pending', 'cancelled');

-- V14: Find the category with the highest completed revenue.
-- Returns the category that generated the most successful sales.
SELECT
    products.category,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY completed_revenue DESC
LIMIT 1;

-- V15: Find the city with the highest order activity.
-- Measures which city has the most total orders.
SELECT
    customers.city,
    COUNT(orders.order_id) AS total_orders
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY total_orders DESC
LIMIT 1;




