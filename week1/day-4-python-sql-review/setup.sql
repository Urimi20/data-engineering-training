-- # Python vs SQL Comparison

-- ## Task: Show completed orders

-- **Python approach:**

* Loop through the orders list.
* Check if order["status"] == "completed".
* Print matching orders.

-- **SQL approach:**

* SELECT the columns we need
* FROM the orders table
* WHERE status = 'completed'

-- **What I understood:**
-- Both approaches filter rows. Python uses a loop and an if statement, while SQL filters directly using WHERE.

-- ---

-- ## Task: Show orders with price > 100

-- **Python approach:**

* Loop through all orders
* Use an if condition: order["price"] > 100
* Print matching records

-- **SQL approach:**

-- * SELECT * FROM orders
-- * WHERE price > 100

-- **What I understood:**
-- Python checks each record manually using if. SQL applies the condition directly to the dataset.

---

-- ## Task: Calculate total_amount

-- **Python approach:**

* Loop through each order
* Calculate total = quantity * price
* Print or store the result

-- **SQL approach:**

* SELECT quantity, price, quantity * price AS total_amount
* FROM orders

-- **What I understood:**
-- Python calculates values step by step in memory. SQL performs calculations directly in the query.

---

-- ## Task: Sort by price descending

-- **Python approach:**

* Use sorted(orders, key=lambda x: x["price"], reverse=True)

-- **SQL approach:**

* SELECT * FROM orders
* ORDER BY price DESC

-- **What I understood:**
-- Python uses a sorting function, while SQL sorts results using ORDER BY.

---

-- ## Task: Show top 3 orders

-- **Python approach:**

* Sort the list first
* Use slicing [:3] to get top 3

-- **SQL approach:**

* SELECT * FROM orders
* ORDER BY price DESC
* LIMIT 3

-- **What I understood:**
-- Both approaches require sorting first. Python uses slicing, while SQL uses LIMIT.

---

-- ## Task: Count orders by status

-- **Python approach:**

-- * Create a dictionary for counting
-- * Loop through orders and increment values

-- **SQL approach:**

* SELECT status, COUNT(*)
* FROM orders
* GROUP BY status

-- **What I understood:**
-- Python counts manually using a dictionary. SQL uses built-in aggregation functions.

-- ---

-- ## Task: Calculate revenue from completed orders

-- **Python approach:**

* Loop through orders
* Check if status == "completed"
* Add quantity * price to total

-- **SQL approach:**

* SELECT SUM(quantity * price)
* FROM orders
* WHERE status = 'completed'

-- **What I understood:**
-- Python uses loops and variables to accumulate values. SQL uses SUM for direct aggregation.
