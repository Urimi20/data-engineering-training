# Day 9 - CSV Data Pipeline Explanation

## Source Data:

The pipeline starts with three raw CSV files:

* orders_raw.csv
* customers_raw.csv
* products_raw.csv

These files contain messy and inconsistent data, including missing values, incorrect formats, and invalid references.

---

## Ingestion:

Data is read using Python’s built-in CSV module with `csv.DictReader`.
At this stage, the data is not modified. It is only loaded into memory exactly as received.

---

## Bronze Layer:

The Bronze layer represents raw data as it is.

* No validation is applied
* No cleaning is performed
* Data is stored exactly as received

Files:

* orders_raw.csv
* customers_raw.csv
* products_raw.csv

---

## Cleaning Rules:

Cleaning focuses on making data consistent:

* Normalize status:

  * "Completed", "complete", "done" → "completed"
* Normalize channel:

  * "Online", "web" → "online"
  * "Store" → "store"
* Normalize city names:

  * Convert to consistent format (e.g. "prishtina" → "Prishtina")
* Normalize date formats:

  * Convert all formats into "YYYY-MM-DD"

---

## Validation Rules:

Each record must pass strict checks:

* Required fields must not be empty
* quantity must be a number greater than 0
* order_date must be valid
* status must be one of: completed, cancelled, pending
* channel must be either online or store
* customer_id must exist in customers dataset
* product_id must exist in products dataset

If any rule fails:
→ the record is marked as invalid and stored separately

---

## Silver Layer:

The Silver layer contains cleaned and validated data.

Outputs:

* orders_clean.csv → valid records only
* invalid_orders.csv → rejected records with reasons

This layer ensures that only trustworthy data moves forward.

---

## Transformation Rules:

For valid records:

* Join with customers data:

  * Add customer_name and city
* Join with products data:

  * Add product_name, category, price
* Calculate:

  * total_amount = quantity × price

This step enriches raw data into meaningful structured data.

---

## Gold Layer:

The Gold layer produces business-ready outputs.

It uses only clean and validated data from the Silver layer.

---

## Business Output:

Generated outputs:

* business_summary.txt:

  * total raw records
  * valid records
  * invalid records
  * completed orders
  * total revenue (completed only)

* data_quality_report.txt:

  * list of validation issues
  * number of failed records
  * types of data quality problems

---

## What makes this data trusted:

Data becomes trusted because:

* Invalid records are removed
* All fields are validated and standardized
* Data is enriched with correct references
* Calculations are based only on clean data
* Every transformation is controlled and reproducible

This ensures that business decisions are based on accurate and reliable data.
