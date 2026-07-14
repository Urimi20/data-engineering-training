# Query Explanations - Day 7 SQL Detective Day

## Fixed Query 1 - Orders by city

### What the query does:
This query counts how many orders were made in each customer city.

### Tables used:
- orders
- customers

### Why JOIN is needed:
The city column does not exist in the orders table. It is stored in the customers table, so a JOIN is required using customer_id.

### What the result means:
The result shows customer activity by location and helps identify which cities generate more orders.


---

## Fixed Query 2 - Revenue by product

### What the query does:
This query calculates completed revenue for each product by multiplying quantity with product price.

### Tables used:
- orders
- products

### Why JOIN is needed:
The orders table contains quantity and product_id, but it does not contain product_name or price. Product information must be retrieved from the products table.

### What the result means:
The result shows which products contribute the most revenue to the business.


---

## Fixed Query 3 - Orders grouped by status

### What the query does:
This query counts orders based on their status, such as completed, pending, and cancelled.

### Tables used:
- orders

### Why JOIN is needed:
JOIN is not required because all needed information exists inside the orders table.

### What the result means:
The result shows the current order distribution and helps understand how many transactions are successful or unfinished.


---

## Fixed Query 4 - Order total amount calculation

### What the query does:
This query calculates the total value of each order using quantity multiplied by product price.

### Tables used:
- orders
- products

### Why JOIN is needed:
Price is stored only in the products table. The orders table only contains the product_id and quantity.

### What the result means:
The result shows the financial value of each individual order.


---

## Fixed Query 5 - Revenue by category

### What the query does:
This query calculates completed revenue grouped by product category.

### Tables used:
- orders
- products

### Why JOIN is needed:
Category information belongs to products, not orders. JOIN connects each order with its product details.

### What the result means:
The result identifies which product categories generate the highest revenue.


---

## Fixed Query 6 - Customers with multiple orders

### What the query does:
This query finds customers who placed more than one order.

### Tables used:
- orders

### Why JOIN is not needed:
All required information is available in the orders table because customer_id is stored there.

### What the result means:
The result identifies repeat customers who may have higher customer value.


---

## Fixed Query 7 - Orders with customer names

### What the query does:
This query displays each order together with the name of the customer who created it.

### Tables used:
- orders
- customers

### Why JOIN is needed:
Customer names are stored in the customers table, while order information is stored in the orders table.

### What the result means:
The result creates a clearer view of transactions by showing who made each order.


---

## Fixed Query 8 - Orders that do not generate revenue

### What the query does:
This query finds orders with pending or cancelled status.

### Tables used:
- orders

### Why JOIN is not needed:
The status column exists directly in the orders table.

### What the result means:
The result identifies transactions that should be excluded from revenue calculations.


# Validation Query Explanations

## Validation Query V1 - Count all orders

### What the query does:
Counts the total number of records inside the orders table.

### Tables used:
- orders

### Why JOIN is not needed:
Only the number of order records is required, and all data exists in one table.

### What the result means:
The result confirms the total transaction volume in the dataset.


---

## Validation Query V7 - Completed revenue only

### What the query does:
Calculates revenue only from completed orders.

### Tables used:
- orders
- products

### Why JOIN is needed:
Revenue requires quantity from orders and price from products.

### What the result means:
The result represents actual business revenue without including unsuccessful orders.


---

## Validation Query V8 - Completed revenue by product

### What the query does:
Groups completed revenue by individual product.

### Tables used:
- orders
- products

### Why JOIN is needed:
Product names and prices are stored in products, while sales quantity is stored in orders.

### What the result means:
The result shows the best-performing products based on revenue.


---

## Validation Query V10 - Orders by city

### What the query does:
Counts the number of orders from each city.

### Tables used:
- orders
- customers

### Why JOIN is needed:
City information belongs to customers, not orders.

### What the result means:
The result shows where customer activity is highest.


---

## Validation Query V14 - Highest revenue category

### What the query does:
Finds the category with the highest completed revenue.

### Tables used:
- orders
- products

### Why JOIN is needed:
Category information comes from products, while order quantity comes from orders.

### What the result means:
The result identifies the strongest product category financially.