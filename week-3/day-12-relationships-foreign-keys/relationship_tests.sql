PRAGMA foreign_keys = ON;

-- Foreign Key Test 1
-- customer_id 999 does not exist
-- Expected: FOREIGN KEY constraint failed

INSERT INTO orders (
    customer_id,
    order_date,
    status,
    channel
)
VALUES (
    999,
    '2026-07-10',
    'completed',
    'online'
);


-- Foreign Key Test 2
-- order_id 999 does not exist
-- Expected: FOREIGN KEY constraint failed

INSERT INTO order_items (
    order_id,
    product_id,
    quantity
)
VALUES (
    999,
    1,
    1
);


-- Foreign Key Test 3
-- product_id 999 does not exist
-- Expected: FOREIGN KEY constraint failed

INSERT INTO order_items (
    order_id,
    product_id,
    quantity
)
VALUES (
    1,
    999,
    1
);


-- CHECK Test 1
-- price cannot be 0
-- Expected: CHECK constraint failed

INSERT INTO products (
    product_name,
    category,
    price
)
VALUES (
    'Invalid Product',
    'Electronics',
    0
);


-- CHECK Test 2
-- quantity must be greater than 0
-- Expected: CHECK constraint failed

INSERT INTO order_items (
    order_id,
    product_id,
    quantity
)
VALUES (
    1,
    1,
    0
);


-- Status Test
-- status must be completed, pending, or cancelled
-- Expected: CHECK constraint failed

INSERT INTO orders (
    customer_id,
    order_date,
    status,
    channel
)
VALUES (
    1,
    '2026-07-10',
    'done',
    'online'
);