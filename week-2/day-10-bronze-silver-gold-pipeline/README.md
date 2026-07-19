# Day 10 - Bronze / Silver / Gold Pipeline with Python

## Project Goal

The goal of this project is to simulate a real-world data engineering pipeline using the Bronze, Silver, and Gold architecture. The pipeline reads raw CSV files, cleans and validates the data, enriches valid records, and generates business-ready reports.

---

## Bronze Layer

The Bronze layer contains the original raw datasets:

* orders_raw.csv
* customers_raw.csv
* products_raw.csv

The raw files are never modified. They represent the original source data and allow the pipeline to be rerun at any time.

---

## Silver Layer

The Silver layer cleans and validates the raw data by:

* Removing duplicate customer records.
* Removing products with invalid prices.
* Normalizing order status values.
* Normalizing sales channels.
* Normalizing customer city names.
* Replacing missing cities with **Unknown**.
* Replacing missing product categories with **Unknown**.
* Validating order quantities.
* Checking missing order dates.
* Validating customer IDs.
* Validating product IDs.
* Detecting duplicate order IDs.
* Enriching orders with customer and product information.
* Calculating the total amount for every valid order.

Generated Silver files:

* customers_clean.csv
* products_clean.csv
* orders_clean.csv
* invalid_orders.csv

---

## Gold Layer

The Gold layer creates business-ready outputs from the cleaned Silver data.

Generated reports:

* revenue_by_category.csv
* revenue_by_city.csv
* revenue_by_customer.csv
* top_products.csv
* executive_summary.txt

These reports can be used for dashboards and business analysis.

---

## How to Run the Pipeline

1. Open the project folder.
2. Make sure the Bronze CSV files are inside `data/bronze/`.
3. Run the pipeline:

```bash
python pipeline.py
```

4. The script automatically generates all Silver and Gold outputs.

---

## Files Generated

Silver:

* customers_clean.csv
* products_clean.csv
* orders_clean.csv
* invalid_orders.csv

Gold:

* revenue_by_category.csv
* revenue_by_city.csv
* revenue_by_customer.csv
* top_products.csv
* executive_summary.txt

Other:

* pipeline_log.txt
* data_quality_report.txt
* layer_explanation.md

---

## Data Quality Checks

The pipeline performs the following validation checks:

* Duplicate customer IDs
* Duplicate order IDs
* Missing order dates
* Invalid order quantities
* Invalid customer IDs
* Invalid product IDs
* Invalid product prices
* Missing customer cities
* Missing product categories
* Status normalization
* Channel normalization

---

## Business Insights

The Gold reports help answer important business questions, such as:

* Which product categories generate the most revenue?
* Which cities have the highest sales?
* Which customers spend the most money?
* Which products are the top sellers?
* What is the overall business performance?

---

## What I Can Explain and Defend

I can explain:

* The purpose of the Bronze, Silver, and Gold architecture.
* Why raw data should remain unchanged.
* How validation rules improve data quality.
* How customer and product enrichment works.
* How total revenue is calculated.
* Why business reports should use Gold data instead of raw Bronze data.

---

## What Was Difficult

The most difficult part was validating the orders, handling duplicate records, checking customer and product IDs, and combining data from multiple CSV files while keeping only valid records.

---

## What I Would Improve Next

If I continued this project, I would:

* Standardize all date formats.
* Add more detailed validation rules.
* Create additional Gold reports and dashboards.
* Improve error logging.
* Organize the pipeline into reusable functions.
* Connect the pipeline to a database instead of CSV files.
