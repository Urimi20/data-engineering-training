

INSERT INTO customers (customer_name, city, segment)
VALUES
('Arta', 'Vushtrri', 'Retail'),
('Blend', 'Prishtina', 'Business'),
('Dren', 'Mitrovica', 'Retail'),
('Elira', 'Peja', 'Business'),
('Leart', 'Ferizaj', 'Retail'),
('Gresa', 'Gjakova', 'Business');

INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 1200),
('Mouse', 'Accessories', 25),
('Monitor', 'Electronics', 250),
('Keyboard', 'Accessories', 45),
('Desk', 'Furniture', 180),
('Headphones', 'Accessories', 80);


INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(1, '2026-07-01', 'completed', 'online'),
(2, '2026-07-02', 'completed', 'store'),
(3, '2026-07-03', 'pending', 'online'),
(1, '2026-07-04', 'completed', 'store'),
(4, '2026-07-05', 'cancelled', 'online'),
(5, '2026-07-06', 'completed', 'store'),
(6, '2026-07-07', 'completed', 'online'),
(2, '2026-07-08', 'completed', 'store');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 2, 1),
(4, 1, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 2),
(7, 2, 1),
(7, 3, 1),
(8, 1, 1),
(8, 6, 1);