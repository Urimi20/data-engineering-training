


-- Show all clean orders.

SELECT 
	COUNT(*) as completed_orders,
    SUM(total_amount) as completed_revenue
FROM clean_orders
where status = 'completed'

-- Calculate completed revenue.
SELECT 
    SUM(total_amount) as completed_revenue
FROM clean_orders
where status = 'completed'

-- Count orders by status.

SELECT 
    status,
    COUNT(*) AS total_orders
FROM clean_orders
GROUP BY status;

-- Count orders by city.

SELECT 
    city,
    COUNT(*) AS total_orders
FROM clean_orders
GROUP BY city;

--  Calculate completed revenue by city.


SELECT
    city,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY city;


--  Calculate completed revenue by category.

SELECT
    category,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY category;

-- Show top 5 orders by total_amount.

SELECT
    total_amount
FROM clean_orders
GROUP BY total_amount LIMIT 5;


-- Show top customers by completed revenue.


SELECT
    customer_name,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY customer_name
ORDER BY completed_revenue DESC;

-- Count orders by channel.

SELECT
    channel,
    COUNT(*) AS total_orders
FROM clean_orders
GROUP BY channel;


-- Find the city with the highest completed revenue.
SELECT
    city,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY city
ORDER BY completed_revenue DESC
LIMIT 1;