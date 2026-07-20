# Pipeline Explanation - Day 11

## Part 1 - Data Understanding

### How many raw orders exist?

The `orders_raw.csv` file contains **24 raw orders**.

### Which columns are used to join orders with customers and products?

- `customer_id` is used to join `orders_raw.csv` with `customers_raw.csv`.
- `product_id` is used to join `orders_raw.csv` with `products_raw.csv`.

### Which values look inconsistent?

Several values are inconsistent and require cleaning:

- Status values use different formats:
  - `completed`
  - `Completed`
  - `done`
  - `canceled`
  - `cancelled`
  - `returned`

- Channel values have inconsistent casing and names:
  - `online`
  - `Online`
  - `store`
  - `Store`
  - `web`
  - `bank`
  - empty value

- City names have inconsistent capitalization:
  - `prishtina`
  - `Prishtina`
  - `VUSHTRRI`
  - `Vushtrri`
  - `ferizaj`

- Some rows contain missing or invalid values:
  - Missing quantity
  - Negative quantity
  - Non-numeric quantity (`abc`)
  - Missing status
  - Missing order date
  - Invalid customer ID (`C013`)
  - Invalid product ID (`P999`)

### Which records should not be trusted for revenue?

The following records should not be included in revenue calculations:

- Orders with invalid quantity.
- Orders with missing order date.
- Orders with invalid customer IDs.
- Orders with invalid product IDs.
- Orders with invalid or missing status.
- Cancelled orders.
- Pending orders.

Only valid **completed** orders from the Silver dataset should be used for revenue reporting.

### Which file is Bronze, which output should be Silver, and which output should be Gold?

**Bronze (Raw Data)**

- `orders_raw.csv`
- `customers_raw.csv`
- `products_raw.csv`

**Silver (Trusted Data)**

- `orders_clean.csv`
- `invalid_orders.csv`

**Gold (Business Reports)**

- `revenue_by_city.csv`
- `revenue_by_category.csv`
- `top_customers.csv`
- `executive_summary.txt`
