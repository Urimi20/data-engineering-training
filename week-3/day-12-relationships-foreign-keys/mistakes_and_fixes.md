# Mistakes and Fixes - Day 12

## Mistake 1: Insert order with invalid customer_id

### Problem:

I tried to insert an order with a customer_id that does not exist.

Example:

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (999, '2026-07-10', 'completed', 'online');
```

### Error:

```
FOREIGN KEY constraint failed
```

### Why it happened:

The customer_id must exist in the customers table before creating an order.

### Fix:

Use an existing customer_id.

Correct example:

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (1, '2026-07-10', 'completed', 'online');
```

---

## Mistake 2: Insert order_item with invalid product_id

### Problem:

I tried to add an order item with a product_id that does not exist.

### Error:

```
FOREIGN KEY constraint failed
```

### Why it happened:

The product must exist in the products table before it can be used in order_items.

### Fix:

Use an existing product_id.

Correct example:

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 2);
```

---

## Mistake 3: Insert product with invalid price

### Problem:

I tried to insert a product with price 0.

Example:

```sql
INSERT INTO products (product_name, category, price)
VALUES ('Invalid Product', 'Electronics', 0);
```

### Error:

```
CHECK constraint failed
```

### Why it happened:

The CHECK rule requires price to be greater than 0.

### Fix:

Insert a valid positive price.

Correct example:

```sql
INSERT INTO products (product_name, category, price)
VALUES ('Tablet', 'Electronics', 300);
```

---

## Mistake 4: Insert order with invalid status

### Problem:

I tried to insert an order with status "done".

Example:

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (1, '2026-07-10', 'done', 'online');
```

### Error:

```
CHECK constraint failed
```

### Why it happened:

The status column only allows:

- completed
- pending
- cancelled

### Fix:

Use one of the allowed values.

Correct example:

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (1, '2026-07-10', 'completed', 'online');
```

---

## Lesson Learned

Foreign keys and CHECK constraints help prevent incorrect data from entering the database. They improve data quality and make relationships between tables more reliable.
