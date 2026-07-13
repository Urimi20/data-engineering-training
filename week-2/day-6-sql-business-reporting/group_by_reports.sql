-- 1. Count orders by status.

SELECT status,
       COUNT(*) AS order_count
FROM orders
GROUP BY status

-- 2. Count orders by order_date.

SELECT order_date,
       COUNT(*) AS order_date
FROM orders
GROUP BY order_date

-- 3. Count orders by customer_id.

SELECT customer_id,
       COUNT(*) AS customer_id
FROM customers
GROUP BY customer_id

-- 4. Count orders by product_id.

SELECT product_id,
       COUNT(*) AS product_id
FROM products
GROUP BY product_id

-- 5.Calculate total quantity by product_id for completed orders only.

SELECT product_id,
       SUM(quantity) AS total_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id;

-- 6. Calculate completed revenue by product_id.

SELECT orders.product_id,
       SUM(orders.quantity * products.price) AS completed_revenue
FROM orders 
JOIN products  ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY orders.product_id

-- 7. Calculate completed revenue by status and explain why the result is not always a good business report.

SELECT orders.status,
       SUM(orders.quantity * products.price) AS total_value
FROM orders 
JOIN products  ON orders.product_id = products.product_id
GROUP BY orders.status

-- This report is not always good for business,because it includes pending and cancelled items, which do not represent actual revenue.

-- 8. Use HAVING to show only customer_id values with more than one order.

SELECT customer_id,
       COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1

-- 9. Use HAVING to show only product_id values where completed quantity is greater than 2.

SELECT product_id,
       SUM(quantity) AS total_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id
HAVING SUM(quantity) > 2
ORDER BY total_quantity DESC;
