-- 1. Completed revenue by order_date

SELECT 
    o.order_date,
    SUM(o.quantity * p.price) AS completed_revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY o.order_date
ORDER BY completed_revenue DESC;



-- 2. Average completed order value by category

SELECT
    p.category,
    AVG(o.quantity * p.price) AS average_order_value
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.category
ORDER BY average_order_value DESC;


-- ## Bronze Layer (Raw Data)

-- The Bronze layer contains the original data with minimal changes.

-- In this project:
-- - orders
-- - customers
-- - products

-- are the base tables coming directly from the source system.

-- Goal:
-- Preserving the complete data history.


-- ## Silver Layer (Cleaned Data)

-- The Silver layer contains cleaned and organized data.

-- Examples:
-- - fixing invalid values
-- - standardizing city names
-- - validating dates and prices
-- - removing duplicates

-- Goal:
-- Creating reliable data for analysis.


-- ## Gold Layer (Business Reporting)

-- The Gold layer contains business-ready results.

-- In this project:
-- - completed revenue reports
-- - top customers
-- - top products
-- - city performance reports

-- Goal:
-- Helping managers make data-driven decisions.