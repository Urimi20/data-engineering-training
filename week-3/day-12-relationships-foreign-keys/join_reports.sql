-- 9. Show all customers.
SELECT * FROM customers;

-- 10. Show all products.
SELECT * FROM products;

-- 11. Show all orders.
SELECT * FROM orders;

-- 12. Show all order_items.
SELECT * FROM order_items;

-- 13. Show only completed orders.
SELECT *
FROM orders
WHERE status = 'completed';

-- 14. Show only pending or cancelled orders.
SELECT *
FROM orders
WHERE status IN ('pending', 'cancelled');

-- 15. Show each order with customer details.
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date,
    o.status,
    o.channel
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- 16. Show each order_item with product details.
SELECT
    oi.order_item_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity
FROM order_items oi
INNER JOIN products p
ON oi.product_id = p.product_id;

-- 17. Show order, customer, product, quantity, price and total amount.
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS total_amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;

-- 18. Show only completed orders with customer and product details.
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS total_amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
WHERE o.status = 'completed';

-- 19. Join customers, orders, order_items and products.
SELECT *
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;

-- 20. Show customer, city, order, product, category, quantity, price and total amount.
SELECT
    c.customer_name,
    c.city,
    o.order_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;

-- 21. Sort by order_id and product_name.
SELECT
    c.customer_name,
    c.city,
    o.order_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;

-- 22. Show only completed joined orders.
SELECT
    c.customer_name,
    c.city,
    o.order_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
WHERE o.status = 'completed';

-- 23. Calculate completed revenue by city.
SELECT
    c.city,
    SUM(oi.quantity * p.price) AS revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.city;

-- 24. Calculate completed revenue by category.
SELECT
    p.category,
    SUM(oi.quantity * p.price) AS revenue
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.category;

-- 25. Top 5 customers by completed revenue.
SELECT
    c.customer_name,
    SUM(oi.quantity * p.price) AS revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 5;

-- 26. Top 5 products by completed revenue.
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- 27. Count how many orders each customer has.
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 28. Count how many items each order has.
SELECT
    order_id,
    COUNT(*) AS total_items
FROM order_items
GROUP BY order_id;

-- 29. Find customers with more than one order.
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

-- 30. Find products sold more than once.
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity) > 1;

-- 31. Show all customers and their orders.
SELECT
    c.customer_name,
    o.order_id,
    o.status
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- 32. Show all products and how many times they appear in orders.
SELECT
    p.product_name,
    COUNT(oi.order_item_id) AS times_sold
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name;