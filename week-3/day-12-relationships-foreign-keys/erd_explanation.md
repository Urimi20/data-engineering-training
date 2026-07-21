# ERD Explanation - Day 12

## 1. What are the main entities in this project?

The main entities are:

- Customers
- Products
- Orders
- Order Items

These entities represent the people who buy products, the products themselves, the orders placed by customers, and the products included in each order.

---

## 2. Which table should store customers?

The **customers** table should store all customer information.

Columns:

- customer_id
- customer_name
- city
- segment

---

## 3. Which table should store products?

The **products** table should store all product information.

Columns:

- product_id
- product_name
- category
- price

---

## 4. Which table should store orders?

The **orders** table should store order information.

Columns:

- order_id
- customer_id
- order_date
- status
- channel

Each order belongs to one customer.

---

## 5. Why should orders not repeat all customer and product details directly?

Repeating customer and product information creates duplicate data and makes the database harder to maintain.

If customer information changes, we would have to update every order. By storing only the customer_id and product_id, the database stays clean, consistent, and easier to manage.

---

## 6. What is the relationship between customers and orders?

The relationship is **one-to-many (1:N)**.

One customer can place many orders, but each order belongs to only one customer.

customers (1) ------< orders (many)

---

## 7. What is the relationship between orders and products?

The relationship is **many-to-many (M:N)**.

One order can contain many products, and one product can appear in many different orders.

This relationship cannot be represented directly with only two tables.

---

## 8. Why do we need an order_items table?

The **order_items** table acts as a bridge between orders and products.

It stores:

- order_item_id
- order_id
- product_id
- quantity

This table allows:

- Multiple products in one order.
- The same product to appear in multiple orders.
- The quantity of each product in every order.

Without this table, the database would not correctly represent customer purchases.

---

# Database Relationships

customers

- customer_id (Primary Key)

↓

orders

- order_id (Primary Key)
- customer_id (Foreign Key)

↓

order_items

- order_item_id (Primary Key)
- order_id (Foreign Key)
- product_id (Foreign Key)

↑

products

- product_id (Primary Key)

---

## Summary

- customers → orders = One-to-Many
- orders → order_items = One-to-Many
- products → order_items = One-to-Many
- orders ↔ products = Many-to-Many (through order_items)

This relational design reduces duplicate data, enforces referential integrity, and makes reporting with SQL JOINs much easier.
