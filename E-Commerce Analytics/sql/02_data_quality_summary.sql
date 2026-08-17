

-- 1. RAW ORDERS FROM BRONZE

CREATE OR REPLACE TEMP VIEW raw_orders AS

SELECT *
FROM delta.`/Volumes/ecommerce_catalog/ecommerce_schema/bronze/bronze_orders`;


-- 2. RAW CUSTOMERS FROM BRONZE

CREATE OR REPLACE TEMP VIEW raw_customers AS

SELECT *
FROM delta.`/Volumes/ecommerce_catalog/ecommerce_schema/bronze/bronze_customers`;


-- 3. CLEAN ORDERS FROM SILVER

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


-- 4. CLEAN CUSTOMERS FROM SILVER

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


-- 5. RAW ORDER COUNT

SELECT
    COUNT(*) AS raw_order_count
FROM raw_orders;


-- 6. RAW CUSTOMER COUNT

SELECT
    COUNT(*) AS raw_customer_count
FROM raw_customers;


-- 7. DUPLICATE ORDER RECORDS

SELECT
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_order_records
FROM raw_orders;


-- 8. DUPLICATE CUSTOMER RECORDS

SELECT
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_records
FROM raw_customers;


-- 9. CLEAN / TRUSTED ORDER COUNT

SELECT
    COUNT(*) AS clean_trusted_order_count
FROM clean_orders;


-- 10. INVALID / EXCLUDED ORDER RECORDS

SELECT
    (SELECT COUNT(*) FROM raw_orders)
    -
    (SELECT COUNT(*) FROM clean_orders)
    AS invalid_excluded_order_records;


-- 11. MISSING CUSTOMER REFERENCES

SELECT
    COUNT(*) AS missing_customer_references

FROM clean_orders o

LEFT JOIN clean_customers c
    ON o.customer_id = c.customer_id

WHERE c.customer_id IS NULL;


-- 12. INVALID QUANTITY OBSERVATIONS

SELECT
    COUNT(*) AS invalid_quantity_observations

FROM raw_orders

WHERE quantity <= 0
   OR quantity IS NULL;


-- 13. INVALID PRICE OBSERVATIONS

SELECT
    COUNT(*) AS invalid_price_observations

FROM raw_orders

WHERE unit_price <= 0
   OR unit_price IS NULL;


-- 14. UNEXPECTED STATUS VALUES

SELECT
    status,
    COUNT(*) AS status_count

FROM raw_orders

WHERE LOWER(TRIM(status)) NOT IN (
    'pending',
    'completed',
    'cancelled',
    'refunded'
)
OR status IS NULL

GROUP BY status

ORDER BY status_count DESC;


-- 15. TOTAL UNEXPECTED STATUS RECORDS

SELECT
    COUNT(*) AS unexpected_status_observations

FROM raw_orders

WHERE LOWER(TRIM(status)) NOT IN (
    'pending',
    'completed',
    'cancelled',
    'refunded'
)
OR status IS NULL;


-- 16. CLEANING SUCCESS RATE

SELECT
    ROUND(
        (
            CAST(
                (SELECT COUNT(*) FROM clean_orders)
                AS DOUBLE
            )
            /
            CAST(
                (SELECT COUNT(*) FROM raw_orders)
                AS DOUBLE
            )
        ) * 100,
        2
    ) AS cleaning_success_rate_percent;


-- 17. COMPLETE DATA QUALITY SUMMARY

SELECT

    -- Raw counts

    (SELECT COUNT(*)
     FROM raw_orders)
        AS raw_order_count,

    (SELECT COUNT(*)
     FROM raw_customers)
        AS raw_customer_count,


    -- Duplicates

    (
        SELECT COUNT(*) - COUNT(DISTINCT order_id)
        FROM raw_orders
    )
        AS duplicate_order_records,

    (
        SELECT COUNT(*) - COUNT(DISTINCT customer_id)
        FROM raw_customers
    )
        AS duplicate_customer_records,


    -- Clean / trusted orders

    (
        SELECT COUNT(*)
        FROM clean_orders
    )
        AS clean_trusted_order_count,


    -- Invalid / excluded orders

    (
        SELECT COUNT(*)
        FROM raw_orders
    )
    -
    (
        SELECT COUNT(*)
        FROM clean_orders
    )
        AS invalid_excluded_order_records,


    -- Missing customer references

    (
        SELECT COUNT(*)
        FROM clean_orders o

        LEFT JOIN clean_customers c
            ON o.customer_id = c.customer_id

        WHERE c.customer_id IS NULL
    )
        AS missing_customer_references,


    -- Invalid quantity

    (
        SELECT COUNT(*)
        FROM raw_orders
        WHERE quantity <= 0
           OR quantity IS NULL
    )
        AS invalid_quantity_observations,


    -- Invalid price

    (
        SELECT COUNT(*)
        FROM raw_orders
        WHERE unit_price <= 0
           OR unit_price IS NULL
    )
        AS invalid_price_observations,


    -- Unexpected status

    (
        SELECT COUNT(*)
        FROM raw_orders

        WHERE LOWER(TRIM(status)) NOT IN (
            'pending',
            'completed',
            'cancelled',
            'refunded'
        )
        OR status IS NULL
    )
        AS unexpected_status_observations,


    -- Cleaning success rate

    ROUND(
        (
            CAST(
                (SELECT COUNT(*) FROM clean_orders)
                AS DOUBLE
            )
            /
            CAST(
                (SELECT COUNT(*) FROM raw_orders)
                AS DOUBLE
            )
        ) * 100,
        2
    )
        AS cleaning_success_rate_percent;