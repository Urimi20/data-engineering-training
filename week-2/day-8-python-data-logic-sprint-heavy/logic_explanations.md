# Logic Explanations

## 1. Why validation is done before revenue calculation

Validation is done before calculating revenue because the dataset may contain:

* quantity <= 0
* price <= 0
* missing fields
* invalid status or channel

If these are used directly in revenue calculations, the result will be incorrect (e.g. negative or zero revenue by mistake).

That’s why we first separate:

* valid_orders
* invalid_orders

and only use valid_orders later for calculations.

---

## 2. How status normalization works

In `normalize_order()`:

* the status is converted to lowercase using `.lower()`
* if the status is "complete" or "completed"
  → it is converted to "completed"

Example:

* "Complete" → "completed"
* "COMPLETED" → "completed"

This ensures all values are consistent and avoids duplicates in analysis.

---

## 3. Why only completed orders count as revenue

Only "completed" means the order is finalized and payment is done.

Other statuses:

* pending → still in process
* cancelled → order was cancelled
* returned → order was returned

If these are included in revenue, the revenue becomes incorrect (higher than it should be).

---

## 4. How count_by_field works (step by step)

Example: `count_by_city()`

1. create an empty dictionary:
   `city_count = {}`

2. for each order:

   * get the city

3. if the city is not in the dictionary:

   * initialize it with 0

4. increase the count:
   `city_count[city] += 1`

5. return the dictionary with counts per city

---

## 5. How sum_revenue_by_field works (step by step)

Example: `completed_revenue_by_city()`

1. create an empty dictionary:
   `revenue = {}`

2. for each order:

   * check if status == "completed"

3. get the city

4. if the city is not in the dictionary:

   * initialize it with 0

5. add revenue:
   `revenue[city] += total_amount`

6. return revenue per city

---

## 6. How sorting is used to find top records

Sorting is done manually using two loops:

* compare two elements
* if the first is smaller, swap them

This sorts the list from highest to lowest based on `total_amount`.

Then:

* take only the top values (e.g. top 5)

---

## 7. What main() does and why it is useful

`main()` is the entry point of the program.

Inside it:

1. separate valid and invalid orders
2. clean the data (`cleaned_orders`)
3. call functions to generate reports

Why it is useful:

* organizes the code
* makes the script easier to read
* easier to debug and test

---

## 8. Example metric explanation (Completed revenue)

Completed revenue is calculated like this:

1. take only orders with status "completed"

2. get `total_amount` for each order

3. use `sum()`:

   `sum(order["total_amount"] for order in completed_orders)`

4. the result is the total revenue from completed orders

This ensures:

* invalid orders are not included
* non-completed orders are not included
* revenue is accurate
