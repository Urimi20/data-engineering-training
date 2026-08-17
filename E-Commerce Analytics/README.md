# E-Commerce Analytics Data Pipeline

## 1. Project Purpose

This project builds a simple and trusted data pipeline for an e-commerce business.

The purpose is to transform raw customer and order exports into cleaned and trusted data
that can be used for management reporting and business analysis.

The pipeline follows a simple:

Raw → Bronze → Silver → Gold

architecture.

The main technologies used are:

- Databricks
- PySpark
- Spark SQL
- Delta
- CSV


## 2. Source Datasets

The project uses two source datasets:

### Customers

The customer dataset contains:

- customer_id
- customer_name
- email
- city
- customer_type

### Orders

The order dataset contains:

- order_id
- customer_id
- order_date
- city
- product_category
- quantity
- unit_price
- status
- payment_method


## 3. Project Structure

```text
E-Commerce_Analytics_Data_Pipeline/
│
├── data/
│   ├── customers_raw.csv
│   └── orders_raw.csv
│
├── notebooks/
│   ├── 01_data_exploration
│   ├── 02_data_cleaning
│   └── 03_business_analysis
│
├── sql/
│   ├── 01_spark_sql_crosscheck.sql
│   └── 02_data_quality_summary.sql
│
├── reports/
│
├── management_summary.md
└── README.md