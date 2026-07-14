# Day 7 - SQL Detective Day

## Practice Goal

The goal of this practice is to improve SQL debugging skills by identifying incorrect queries, fixing mistakes, and validating business results using a three-table dataset.

The practice focuses on:

- Understanding table relationships
- Using JOIN correctly
- Finding SQL mistakes
- Creating accurate business reports based on verified data

## Files Included

- `setup.sql`  
  Creates the database structure, inserts sample data, and runs basic verification checks.

- `table_inspection.sql`  
  Inspects tables and checks available records and row counts.

- `broken_queries.sql`  
  Contains intentionally incorrect SQL queries used for debugging practice.

- `fixed_queries.sql`  
  Contains corrected versions of broken queries with explanations.

- `validation_queries.sql`  
  Contains verification queries used as evidence for the final business report.

- `verified_business_report.md`  
  Summarizes business insights based on validated SQL results.

- `query_explanations.md`  
  Explains the logic behind fixed and validation queries.

- `daily_report.txt`  
  Contains a short summary of the learning progress during the practice.

- `screenshots/`  
  Contains screenshots of executed SQL results.

## How to Run SQL Files

Run the SQL files in the following order:

1. `setup.sql`

   Creates the tables, inserts all sample data, and verifies that the database was created correctly.

2. `table_inspection.sql`

   Reviews table contents and checks the number of records in each table.

3. `fixed_queries.sql`

   Runs corrected SQL queries after identifying mistakes from the broken queries.

4. `validation_queries.sql`

   Runs validation queries that provide evidence for business metrics and reports.

5. Review:

   `verified_business_report.md`

   Compare the business report with the results returned from validation queries.

## What Was Learned About Debugging SQL

During this practice, I learned how to identify common SQL problems such as:

- Using columns from the wrong table
- Missing JOIN conditions
- Incorrect query order
- Missing commas or syntax errors
- Applying incorrect filters
- Using aggregation functions incorrectly

I also learned that understanding the database structure before writing queries helps prevent mistakes.

## What Was Learned About Verifying Business Reports

This practice showed the importance of connecting business reports with SQL evidence.

Key learnings:

- Every number in a report should come from a validated SQL query.
- Revenue calculations should only include completed transactions.
- Data from related tables should be combined using correct JOIN logic.
- Business decisions should be based on tested and accurate results.

The validation queries ensure that the final report is supported by real data from the database.
