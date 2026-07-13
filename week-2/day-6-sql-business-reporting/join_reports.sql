--  1. Join orders with customers and show order_id, customer_name, city, order_date, and status.

SELECT o.order_id,
       c.customer_name,
       c.city,
       o.order_date,
       o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 2. Join orders with products and show order_id, product_name, category, quantity, price, total_amount, and status.

SELECT o.order_id,
       p.product_name,
       p.category,
       o.quantity,
       p.price,
       (o.quantity * p.price) AS total_amount,
       o.status
FROM orders o
JOIN products p ON o.product_id = p.product_id


-- 3. Join all three tables and create a complete order report with customer_name, city, product_name, category,quantity, price, total_amount, status, and order_date.

SELECT c.customer_name,
       c.city,
       p.product_name,
       p.category,
       o.quantity,
       p.price,
       (o.quantity * p.price) AS total_amount,
       o.status,
       o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id

-- 4. Create completed revenue by product_name.

SELECT p.product_name,
       SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.product_name

-- 5. Create completed revenue by category.

SELECT p.category,
       SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.category

-- 6. Order count by city
SELECT c.city,
       COUNT(*) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY order_count DESC;



-- 7. Completed revenue by city
SELECT c.city,
       SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.city
ORDER BY completed_revenue DESC;


-- 8. Completed revenue by customer_name
SELECT c.customer_name,
       SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.customer_name
ORDER BY completed_revenue DESC;


-- 9. Customers with more than one order
SELECT c.customer_name,
       COUNT(*) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(*) > 1
ORDER BY order_count DESC;


-- 10. Top 3 customers by completed revenue
SELECT c.customer_name,
       SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.customer_name
ORDER BY completed_revenue DESC
LIMIT 3;


-- 11. Top 3 products by completed revenue
SELECT p.product_name,
       SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.product_name
ORDER BY completed_revenue DESC
LIMIT 3;


-- 12. Pending or Cancelled Orders (Potential Value)
SELECT c.customer_name,
       c.city,
       p.product_name,
       (o.quantity * p.price) AS potential_amount,
       o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status IN ('pending', 'cancelled')
ORDER BY potential_amount DESC;