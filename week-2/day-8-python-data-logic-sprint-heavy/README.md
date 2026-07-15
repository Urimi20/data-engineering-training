# Day 8 - Python Data Logic Sprint Heavy Version

## Business Scenario

In this project, we work with an orders dataset. The goal is to take raw (unclean) data, validate it, clean it, and then generate business insights such as revenue, top customers, and other reports. This simulates a real data engineering workflow where data is often messy and needs processing before it can be used.

---

## Project Structure

* `python_data_analysis.py` → main script with all logic

* `order_data.py` → dataset containing orders

* `output/`

  * `validation_report.txt`
  * `invalid_records.txt`
  * `business_report.txt`

* `logic_explanations.md` → explanation of logic

* `README.md` → project documentation

---

## How to Run

Open the terminal in the project folder and run:

```bash
python python_data_analysis.py
```

The script will process the data and generate reports automatically.

---

## Output Files

After running the script, the following files are created:

* `output/validation_report.txt`
  Contains total records, valid records, invalid records, and validation details.

* `output/invalid_records.txt`
  Contains all invalid orders with their IDs and reasons.

* `output/business_report.txt`
  Contains key business metrics like revenue, completed orders, and top results.

---

## Python Concepts Used

* Lists and Dictionaries
* Loops (`for`)
* Conditional statements (`if`)
* Functions (modular structure)
* Data validation
* Data cleaning / normalization
* Aggregations (count, sum)
* Manual sorting (without lambda)
* File handling (`open`, write)

---

## Challenges

The most difficult part was managing the data pipeline correctly, especially ensuring that only valid and cleaned data is used for calculations. Also, comparing values before and after normalization required careful handling, because using the wrong lists could lead to incorrect results.
