# Day 2 Practice - CSV Mini Data Pipeline

This project is a small data pipeline built with Python. It reads raw student data from a CSV file, checks the data quality, detects missing and invalid values, cleans the records, saves the cleaned data, and generates summary reports.

## Input

The program reads the raw student dataset from:

- data/students_raw.csv

The raw file contains student information such as:

- student name
- city
- course
- age
- attendance
- homework score
- registered date

The raw data is not changed. All cleaning is done using Python.

## Outputs

After running the program, the generated files are saved inside the output folder:

- output/students_clean.csv
  - Contains cleaned student records with additional fields:
    - total_score
    - performance_status
    - risk_flag

- output/data_quality_report.txt
  - Contains detected data quality issues:
    - missing values
    - invalid numeric values
    - inconsistent text values

- output/summary_report.txt
  - Contains the final student summary:
    - total records
    - averages
    - students by city
    - students by course
    - performance groups
    - top students by score

## How to run

Open the terminal inside the project folder and run:

```bash
python csv_pipeline.py
```

<img width="2265" height="1325" alt="image" src="https://github.com/user-attachments/assets/dab89af8-4158-4dfd-b00d-7434b16d694b" />



