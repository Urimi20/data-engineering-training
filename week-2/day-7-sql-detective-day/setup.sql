-- Remove existing tables if they already exist.
-- This ensures the script can be rerun without errors.
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- Create the customers table to store customer details.
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    city TEXT
);

-- Create the products table to store product information
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

-- Create the orders table to store transaction data.
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    order_date TEXT,
    quantity INTEGER,
    status TEXT
);

-- Insert sample customer data into the customers table.
INSERT INTO customers VALUES
(1, 'Ardi', 'Prishtina'),
(2, 'Besa', 'Vushtrri'),
(3, 'Luan', 'Mitrovica'),
(4, 'Drita', 'Prishtina'),
(5, 'Alban', 'Peja'),
(6, 'Era', 'Prizren'),
(7, 'Gent', 'Ferizaj'),
(8, 'Ilir', 'Gjilan'),
(9, 'Mira', 'Gjakova'),
(10, 'Nora', 'Prishtina');

-- Insert product data into the products table.
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 700),
(102, 'Mouse', 'Accessories', 15),
(103, 'Keyboard', 'Accessories', 40),
(104, 'Monitor', 'Electronics', 180),
(105, 'Headphones', 'Accessories', 50),
(106, 'Desk Chair', 'Office', 120),
(107, 'USB Cable', 'Accessories', 8),
(108, 'Desk', 'Office', 220),
(109, 'Webcam', 'Electronics', 90),
(110, 'Microphone', 'Electronics', 130);

-- Insert order records into the orders table.

INSERT INTO orders VALUES
(1, 1, 101, '2026-07-01', 1, 'completed'),
(2, 2, 102, '2026-07-01', 2, 'completed'),
(3, 1, 103, '2026-07-02', 1, 'cancelled'),
(4, 3, 104, '2026-07-02', 1, 'completed'),
(5, 4, 102, '2026-07-03', 1, 'completed'),
(6, 3, 101, '2026-07-03', 1, 'pending'),
(7, 5, 105, '2026-07-04', 1, 'completed'),
(8, 6, 104, '2026-07-04', 2, 'completed'),
(9, 7, 106, '2026-07-05', 1, 'completed'),
(10, 2, 107, '2026-07-05', 3, 'completed'),
(11, 8, 101, '2026-07-06', 1, 'cancelled'),
(12, 9, 108, '2026-07-06', 1, 'pending'),
(13, 10, 102, '2026-07-07', 4, 'completed'),
(14, 4, 105, '2026-07-07', 2, 'completed');


-- Check all order records
SELECT * FROM orders;

-- Check all customers
SELECT * FROM customers;

-- Check all products
SELECT * FROM products;