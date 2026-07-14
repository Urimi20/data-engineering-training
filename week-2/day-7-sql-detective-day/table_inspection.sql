-- Retrieve all rows from the orders table to review transaction data
SELECT * FROM orders;

-- Retrieve all rows from the customers table to verify customer details.
SELECT * FROM customers;

-- Retrieve all rows from the products table to inspect product information.
SELECT * FROM products;

-- Count the total number of records in the orders table.
SELECT COUNT(*) AS total_orders
FROM orders;

-- Count the total number of customers to ensure all expected customers exist.
SELECT COUNT(*) AS total_customers
FROM customers;

-- Count the total number of products to verify that the product catalog is complete.
SELECT COUNT(*) AS total_products
FROM products;