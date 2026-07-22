# Answers and Explanation

## 1. What problem does a primary key solve?

A primary key uniquely identifies every row in a table. It prevents duplicate records and allows other tables to reference the correct row.

## 2. What problem does AUTOINCREMENT solve?

AUTOINCREMENT automatically generates a unique ID for each new record, so IDs do not need to be entered manually.

## 3. What problem does a foreign key solve?

A foreign key maintains relationships between tables and prevents inserting records that reference non-existing data.

## 4. Why is enrollments a bridge table?

The `enrollments` table connects students and courses. One student can enroll in many courses, and one course can have many students.

## 5. Why is submissions also a relationship table?

The `submissions` table connects students with assignments. It stores each student's submission, score, and status for an assignment.

## 6. What is one-to-many in your project? Give two examples.

- One instructor → Many courses.
- One course → Many assignments.

## 7. What is many-to-many in your project? Give one example.

Students and courses have a many-to-many relationship. A student can enroll in many courses, and a course can have many students through the `enrollments` table.

## 8. Why should we not store instructor_name directly inside every course report table?

Because it creates duplicated data. If an instructor's name changes, it would have to be updated in many places. Using JOIN keeps the data consistent.

## 9. What is the difference between INNER JOIN and LEFT JOIN?

INNER JOIN returns only matching records from both tables. LEFT JOIN returns all records from the left table, even if there is no matching record in the right table.

## 10. Which constraint test was most important and why?

The foreign key constraint test was the most important because it prevents invalid relationships and keeps the database consistent.

## 11. How does this prepare you for Databricks tables and reporting?

It teaches how to design relational tables, enforce data quality with constraints, and combine data using JOINs to create business reports, which are essential skills when working with Databricks and SQL.
