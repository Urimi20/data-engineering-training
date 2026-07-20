# Day 11 - Python + SQL Pipeline Preparation

## Project Goal

The goal of this project was to build a small local data engineering pipeline using Python and SQL.

The workflow followed a Bronze → Silver → Gold architecture:

- Bronze: Raw CSV data collected from the business system.
- Silver: Clean, validated, and enriched data ready for analysis.
- Gold: Business reports created from trusted Silver data.

This project simulates the thinking used in Databricks notebooks where Python is used for data processing and SQL is used for analytics.

---

# Bronze Data

## What raw files did you receive?

The Bronze layer contained three raw CSV files:

- `orders_raw.csv`
- `customers_raw.csv`
- `products_raw.csv`

These files contained order information, customer information, and product information.

## What problems did you notice?

The raw data contained several quality issues:

- Different status formats:
  - `Completed`
  - `completed`
  - `done`
  - `cancelled`
  - `canceled`

- Incorrect or missing quantities:
  - Empty values
  - Negative numbers
  - Text values like `abc`
  - Zero quantities

- Missing order dates.

- Invalid customer IDs.

- Invalid product IDs.

- Duplicate order IDs.

- Different city capitalization:
  - `prishtina`
  - `VUSHTRRI`
  - `Vushtrri`

- Missing channels.

---

# Silver Data

## What validation rules did you apply?

The following validation rules were applied:

- Quantity must exist.
- Quantity must be numeric.
- Quantity must be greater than zero.
- Status must be one of:
  - completed
  - pending
  - cancelled

- Missing status was rejected.
- Missing order date was rejected.
- Customer ID had to exist in customers data.
- Product ID had to exist in products data.
- Duplicate order IDs were rejected.

Invalid records were separated into:
