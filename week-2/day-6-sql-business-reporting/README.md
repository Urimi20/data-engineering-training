# Day 6 - SQL Business Reporting Sprint

## Practice Goal

The goal of this practice was to learn how to transform raw transaction data into useful business reports using SQL.

The dataset was separated into three tables:

- orders (transaction information)
- customers (customer details and locations)
- products (product information and prices)

During this sprint, I practiced SQL aggregations, GROUP BY reports, HAVING filters, and JOIN operations to answer real business questions.

---

## Files Included

The project folder contains:

- `setup.sql`
  - Creates the database tables
  - Inserts all dataset records
  - Verifies the created tables

- `basic_aggregations.sql`
  - Contains COUNT, SUM, AVG, MIN, and MAX calculations

- `group_by_reports.sql`
  - Contains grouped business reports using GROUP BY and HAVING

- `join_reports.sql`
  - Combines orders, customers, and products tables to create complete reports

- `business_report.md`
  - Contains business insights based on SQL results

- `query_explanations.md`
  - Explains important SQL queries and their purpose

- Screenshots
  - Shows SQL results from important reports

---

## How to Run SQL Files

Run the SQL files in this order:

### 1. setup.sql

First, create the database structure and insert all data.

### 2. basic_aggregations.sql

Run basic calculations such as:

- total orders
- completed orders
- total quantity
- revenue calculations

### 3. group_by_reports.sql

Run grouped reports to analyze:

- orders by status
- orders by customer
- revenue by product

### 4. join_reports.sql

Run JOIN reports to combine customer, product, and order information.

The SQL files were tested using:

SQLiteOnline.com

---

## SQL Concepts Explained

### Basic Aggregation

Basic aggregation calculates one overall result from many rows.

Examples:

- COUNT() counts rows
- SUM() adds values
- AVG() calculates averages
- MIN() and MAX() find the smallest and largest values

Example:
Finding total completed revenue from all completed orders.

---

### GROUP BY

GROUP BY is used when we need separate results for different categories.

Instead of getting one total number, we can see results for each group.

Example:

- revenue by product
- orders by city
- orders by status

---

### HAVING

HAVING filters grouped results after an aggregation has been calculated.

WHERE filters individual rows, while HAVING filters grouped results.

Example:
Finding customers who have more than one order.

---

### JOIN

JOIN connects information from different tables using a related column.

In this project:

- orders contains customer_id and product_id
- customers contains customer names and cities
- products contains product names and prices

JOIN allows us to create a complete business report instead of showing only IDs.

---

## Most Important Business Insight

The most important insight from this report is that completed revenue does not depend only on the number of orders, but also on product value.

Electronics products generated the highest completed revenue because products like laptops and monitors have higher prices.

The report also showed which customers and cities generated the most value, helping managers make better decisions about sales strategy, product focus, and customer targeting.
