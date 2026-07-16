# Day 9 - CSV Data Pipeline: From Raw Data to Clean Reports

## Practice Goal

The goal of this practice is to build a Python CSV data pipeline that receives raw and messy data, validates records, cleans values, enriches orders using customer and product information, and creates trusted business-ready outputs.

The main idea is to understand how raw data becomes useful data through different data engineering steps:

- Loading raw files
- Cleaning inconsistent values
- Validating data quality
- Joining datasets
- Creating reports

This practice follows the thinking used in real Data Engineering workflows.

---

# Bronze, Silver, and Gold Layers

## Bronze Layer - Raw Data

Bronze represents the original data exactly as received.

In this project:

```
data/
├── orders_raw.csv
├── customers_raw.csv
└── products_raw.csv
```

These files contain raw data with problems such as:

- Missing values
- Invalid IDs
- Different formats
- Inconsistent status and channel values

---

## Silver Layer - Clean and Validated Data

Silver contains cleaned and trusted records after validation and transformation.

In this project:

```
output/
├── orders_clean.csv
└── invalid_orders.csv
```

`orders_clean.csv` contains:

- Valid orders only
- Normalized status, city, and channel
- Customer information
- Product information
- Calculated total amount

`invalid_orders.csv` contains rejected records with the reason why they failed validation.

---

## Gold Layer - Business Reports

Gold contains business-ready information used for analysis and reporting.

In this project:

```
output/
├── business_summary.txt
└── data_quality_report.txt
```

These files provide:

- Business metrics
- Data quality information
- Summary of cleaned data

---

# Project Structure

```
day-9-csv-data-pipeline/

├── data/
│   ├── orders_raw.csv
│   ├── customers_raw.csv
│   └── products_raw.csv
│
├── output/
│   ├── orders_clean.csv
│   ├── invalid_orders.csv
│   ├── business_summary.txt
│   └── data_quality_report.txt
│
├── screenshots/
│   ├── pipeline_success.png
│   ├── output_files.png
│   ├── orders_clean_preview.png
│   └── invalid_orders_preview.png
│
├── csv_pipeline.py
├── pipeline_explanation.md
├── daily_report.txt
└── README.md
```

---

# How to Run the Pipeline

1. Open the project folder.

2. Make sure Python is installed.

3. Run:

```bash
python csv_pipeline.py
```

4. The script will automatically:

- Load raw CSV files
- Clean and validate orders
- Create enriched orders
- Generate output files
- Create reports

---

# Generated Output Files

After running the pipeline, the following files are created:

## orders_clean.csv

Contains validated and enriched orders.

Includes:

- Customer details
- Product details
- Total amount calculation
- Clean status and channel values

---

## invalid_orders.csv

Contains invalid records that failed validation.

Each record includes a reason, such as:

- missing_quantity
- invalid_customer_id
- invalid_product_id
- invalid_quantity
- missing_order_date

---

## data_quality_report.txt

Contains information about:

- Total raw orders
- Valid orders
- Invalid orders
- Problems found during validation

---

## business_summary.txt

Contains business-level summaries created from clean data.

---

# Why Pandas Was Not Used

Pandas was intentionally not used in this practice.

The goal was to understand the basic logic behind data engineering pipelines using Python built-in tools:

- `csv.DictReader`
- `csv.DictWriter`
- Loops
- Dictionaries
- Validation functions
- Manual transformations

Understanding these fundamentals is important before using advanced tools such as Pandas, SQL, and Databricks.

Manual logic helps build a stronger understanding of how data pipelines work internally.
