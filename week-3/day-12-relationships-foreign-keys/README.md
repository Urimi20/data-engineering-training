## Difference Between INNER JOIN and LEFT JOIN

**INNER JOIN** returns only rows that match in both tables.

**LEFT JOIN** returns all rows from the left table and matching rows from the right table. If there is no match, NULL values are returned.

## Auto Increment

### 34. What happened when you inserted a customer without specifying customer_id?

The database generated the `customer_id` automatically.

### 35. Why is AUTOINCREMENT useful?

It creates a unique ID for every new row automatically.

### 36. Should we manually choose IDs in a real database? Why or why not?

No. The database should generate IDs to avoid duplicates and mistakes.

### 37. What happens if we delete a row? Does AUTOINCREMENT reuse the old ID?

No. AUTOINCREMENT does not reuse deleted IDs.

### 38. Why is a stable unique ID better than using customer_name as the identifier?

Because IDs are unique and never change, while customer names can be duplicated or updated.



# Day 12 - Relationships, Foreign Keys, and JOINs

## Project Goal

The goal of this project is to build a small relational database and understand how tables connect using primary keys, foreign keys, and JOIN operations.

The database represents a technology company that sells products to customers. The data is separated into different tables to avoid duplication and improve data quality.

---

## Database Tables

The database contains four main tables:

### customers
Stores customer information.

Columns:
- customer_id
- customer_name
- city
- segment

### products
Stores product information.

Columns:
- product_id
- product_name
- category
- price

### orders
Stores customer orders.

Columns:
- order_id
- customer_id
- order_date
- status
- channel

### order_items
Bridge table between orders and products.

Columns:
- order_item_id
- order_id
- product_id
- quantity

---

## Primary Keys

Primary keys are unique identifiers for each table.

Used primary keys:

- customers.customer_id
- products.product_id
- orders.order_id
- order_items.order_item_id

Each primary key is generated automatically using AUTOINCREMENT.

---

## Foreign Keys

Foreign keys connect related tables.

Used foreign keys:

- orders.customer_id references customers.customer_id
- order_items.order_id references orders.order_id
- order_items.product_id references products.product_id

Foreign keys prevent invalid relationships and protect data integrity.

---

## Auto Increment

AUTOINCREMENT allows the database to generate unique IDs automatically.

When inserting new records, we do not manually provide IDs. The database creates the next available ID.

This reduces duplicate IDs and prevents manual mistakes.

---

## Relationships

The database contains these relationships:

### Customers and Orders

One customer can have many orders.

Relationship:

customers (1) → orders (many)

### Orders and Products

Orders and products have a many-to-many relationship.

One order can contain many products, and one product can appear in many orders.

The order_items table is used as a bridge table.

---

## Valid and Invalid Insert Tests

Valid inserts:

- Added customers, products, orders, and order items successfully.
- Relationships worked correctly using foreign keys.

Invalid tests:

- Insert order with a non-existing customer_id.
- Insert order_item with invalid order_id.
- Insert order_item with invalid product_id.
- Insert product with price 0.
- Insert order_item with quantity 0.
- Insert order with invalid status.

The database rejected invalid records because of FOREIGN KEY and CHECK constraints.

---

## INNER JOIN vs LEFT JOIN

INNER JOIN returns only records that have matching data in both tables.

LEFT JOIN returns all records from the left table and matching records from the right table. If there is no match, NULL values are returned.

---

## Business Reports

Using JOIN queries, the database can generate reports such as:

- Revenue by city.
- Revenue by product category.
- Top customers by completed revenue.
- Top products by completed revenue.
- Number of orders per customer.
- Products sold multiple times.

Only completed orders are included when calculating revenue.

---

## What I Can Explain Live

I can explain:

- Difference between primary key and foreign key.
- Why we separate data into multiple tables.
- How one-to-many and many-to-many relationships work.
- Why order_items is needed.
- How INNER JOIN and LEFT JOIN combine data.
- How constraints protect database quality.

---

## What I Would Improve Next

Next improvements would be:

- Add more validation rules.
- Add timestamps for created and updated records.
- Add more business reports.
- Connect the database with Python for automated data processing.
- Create a dashboard using the generated reports.