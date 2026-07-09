# Python vs SQL Comparison

## Task: Show completed orders

**Python approach:**

- Loop through the orders list.
- Check if order["status"] == "completed".
- Print matching orders.

**SQL approach:**

- SELECT the columns we need.
- FROM the orders table.
- Use WHERE status = 'completed'.

**What I understood:**
Both approaches filter rows. Python uses a loop and if statement. SQL filters directly from the table using WHERE.

---

## Task: Show orders with price > 100

**Python approach:**

- Loop through all orders.
- Use an if condition: order["price"] > 100.
- Print the matching records.

**SQL approach:**

- SELECT \* FROM orders.
- Use WHERE price > 100.

**What I understood:**
Python checks each record manually using if. SQL does the filtering automatically using WHERE without needing a loop.

---

## Task: Calculate total_amount

**Python approach:**

- Loop through each order.
- Calculate total = quantity \* price inside the loop.
- Print or store the result.

**SQL approach:**

- SELECT quantity, price, quantity \* price AS total_amount
- FROM orders.

**What I understood:**
Python calculates values step by step in memory. SQL calculates directly in the query using expressions.

---

## Task: Sort by price descending

**Python approach:**

- Use sorted(orders, key=lambda x: x["price"], reverse=True).

**SQL approach:**

- SELECT \* FROM orders
- ORDER BY price DESC.

**What I understood:**
Python uses a function (sorted) to reorder data. SQL uses ORDER BY to sort results directly from the database.

---

## Task: Show top 3 orders

**Python approach:**

- Sort the list first.
- Then use slicing [:3] to get top 3.

**SQL approach:**

- SELECT \* FROM orders
- ORDER BY price DESC
- LIMIT 3.

**What I understood:**
Both need sorting first. Python uses slicing after sorting, while SQL uses LIMIT to restrict results.

---

## Task: Count orders by status

**Python approach:**

- Create a dictionary to count statuses.
- Loop through orders and increment counts.

**SQL approach:**

- SELECT status, COUNT(\*)
- FROM orders
- GROUP BY status.

**What I understood:**
Python manually counts using a dictionary. SQL has built-in aggregation functions like COUNT and GROUP BY.

---

## Task: Calculate revenue from completed orders

**Python approach:**

- Loop through orders.
- Check if status == "completed".
- Add quantity \* price to total revenue.

**SQL approach:**

- SELECT SUM(quantity \* price)
- FROM orders
- WHERE status = 'completed'.

**What I understood:**
Python uses loops and variables to accumulate values. SQL uses SUM to calculate totals directly.
