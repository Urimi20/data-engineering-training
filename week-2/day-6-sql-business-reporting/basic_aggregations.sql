
-- 1. Count all orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. select only completed orders 
SELECT COUNT(*) AS completed_orders 
FROM orders WHERE status = 'completed'

-- 3. select only pending orders 
SELECT COUNT(*) AS completed_orders 
FROM orders WHERE status = 'pending'

-- 4. select only cancelled orders 
SELECT COUNT(*) AS completed_orders 
FROM orders WHERE status = 'cancelled'


-- 5. select total quantity 
SELECT SUM(quantity) AS total_quantity 
FROM orders


-- 5. select total quantity that are completed
SELECT SUM(quantity) AS total_quantity FROM orders
WHERE status = 'completed'


-- 6. select average price from products 
SELECT AVG(price) AS average_price FROM products

-- 7. select cheapest price 
SELECT MIN(price) AS cheapest_price from products

-- 8. select most expensive price 
SELECT MAX(price) AS most_expensive_price from products


SELECT SUM(orders.quantity * products.price) AS completed_revenue
FROM orders 
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed';

-- 9. Calculate completed revenue using quantity * price.

SELECT SUM(orders.quantity * products.price) AS completed_revenue
FROM orders 
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed';

-- 10.Calculate non-completed potential value from pending and cancelled orders.

SELECT SUM(orders.quantity * products.price) AS potential_value
FROM orders 
JOIN products  ON orders.product_id = products.product_id
WHERE orders.status IN ('pending', 'cancelled');