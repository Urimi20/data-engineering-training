# Schema Evolution Notes

## 15. What is the difference between changing data and changing schema?

Changing data means modifying the values stored in a table. For example, using `UPDATE` to change a student's phone number.

Changing schema means modifying the structure of a database. For example, using `ALTER TABLE` to add a new column such as `phone_number` or `github_username`.

---

## 16. Why do real databases need ALTER TABLE?

Business requirements change over time. New information may need to be stored without recreating the database. `ALTER TABLE` allows developers to add new columns or modify the table structure while keeping the existing data.

---

## 17. What is a view and why is it useful?

A view is a saved SQL query. It does not store data itself; instead, it displays data from one or more tables. Views make reporting easier because the same query can be reused without writing it again.

---

## 18. What is the difference between a table and a view?

A table stores actual data in the database.

A view does not store data. It stores only a SQL query and displays the latest data from the underlying tables whenever it is queried.

---

## 19. What does ROLLBACK do?

`ROLLBACK` cancels all changes made during the current transaction and restores the database to its previous state.

---

## 20. What does COMMIT do?

`COMMIT` permanently saves all changes made during the current transaction.

---

## 21. Why are transactions useful before dangerous updates/deletes?

Transactions allow us to test changes safely. If a mistake happens, we can use `ROLLBACK` to undo the changes. If everything is correct, we use `COMMIT` to save them permanently.

---

## 22. What is an index in simple words?

An index is like the index of a book. It helps the database find rows much faster without checking every row in a table.

---

## 23. Which columns did you index and why?

I created indexes on:

- `submissions.student_id` – to quickly find submissions for a specific student.
- `submissions.assignment_id` – to quickly find submissions for an assignment.
- `attendance.session_id` – to quickly find attendance records for a session.
- `attendance.student_id` – to quickly find a student's attendance history.
- `enrollments.program_id` – to quickly find students enrolled in a program.

These indexes improve query performance as the database grows.

---

## 24. How does this prepare you for Databricks tables and views?

These concepts are important for Databricks because real data platforms also require schema evolution, reusable views, transactions, and performance optimization. Learning these SQL concepts provides a strong foundation for working with Databricks tables, Delta Lake, and large-scale data engineering pipelines.
