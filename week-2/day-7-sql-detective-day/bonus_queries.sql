-- Bonus 1:
-- Calculate completed revenue by city.
-- This uses orders for transactions, customers for city information,
-- and products for price calculation.

SELECT
    customers.city,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city
ORDER BY completed_revenue DESC;



-- Bonus 2:
-- Calculate the average completed order value by product category.
-- Order value is calculated using quantity multiplied by product price.

SELECT
    products.category,
    AVG(orders.quantity * products.price) AS average_completed_order_value
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY average_completed_order_value DESC;



-- Bonus 3:
-- Show only products where completed revenue is greater than 100.

SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
HAVING completed_revenue > 100
ORDER BY completed_revenue DESC;



-- Bonus 4:
-- Compare completed, pending, and cancelled order counts by city.
-- Uses conditional aggregation to count each status separately.

SELECT
    customers.city,
    SUM(CASE WHEN orders.status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN orders.status = 'pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN orders.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY completed_orders DESC;



-- Bonus 5:
-- Intentional broken query:
-- Mistake: product_name does not exist in orders table.
-- It belongs to products table, so a JOIN is required.

-- BROKEN QUERY:
-- SELECT product_name, SUM(quantity)
-- FROM orders
-- GROUP BY product_name;


-- FIXED QUERY:
-- This shows total quantity sold for each product.

SELECT
    products.product_name,
    SUM(orders.quantity) AS total_quantity
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.product_name;