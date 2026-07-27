# Day 16 - SQL Data Maintenance & Safe Business Updates

## Project Goal

The goal of this project is to understand how databases are maintained after data already exists. Instead of only creating tables and inserting data, this practice focuses on updating records safely, handling missing data, protecting historical information, and creating business reports using SQL.

---

## Setup

I created the following tables:

- **students** – stores student information.
- **programs** – stores training program details.
- **enrollments** – connects students with programs.
- **sessions** – stores class sessions.
- **attendance** – records student attendance.
- **assignments** – stores assignment information.
- **submissions** – stores student submissions, scores, and feedback.

The database uses primary keys, foreign keys, and constraints to maintain data integrity.

---

## Safe Updates

Before every update, I first checked the existing record using a **SELECT** statement. Then I updated the required value using **UPDATE** with a **WHERE** clause and finally verified the result with another **SELECT**.

Using **WHERE** is very important because it updates only the intended record. Without a WHERE clause, every row in the table could be modified accidentally.

---

## Delete Logic

This project demonstrates both **hard delete** and **soft delete**.

- **Hard delete** permanently removes a record from the database using `DELETE`.
- **Soft delete** keeps the record but changes its status (for example, from `active` to `dropped`).

Soft delete is safer because it preserves historical data, reports, attendance records, and submissions while still marking a student as inactive.

---

## NULL Handling

Some submission feedback and attendance notes were intentionally left as **NULL**.

To work with missing values, I used:

- `IS NULL` to find missing values.
- `IS NOT NULL` to find existing values.
- `COALESCE()` to display friendly text such as **"No feedback yet"** or **"No notes"** instead of NULL.

This makes reports easier to read.

---

## CASE WHEN

I used **CASE WHEN** to create business-friendly categories.

Performance levels:

- Score **90 or above** → Excellent
- Score **75–89** → Good
- Score **60–74** → Needs Improvement
- Score **Below 60** → At Risk

Attendance categories:

- Present → Attended
- Late → Late Arrival
- Absent → Absent

Enrollment risk:

- Active → Low Risk
- Completed → Graduated
- Dropped → High Risk

These classifications make reports easier for managers and instructors to understand.

---

## LEFT JOIN

I used **LEFT JOIN** to find missing data.

Examples include:

- Students who have not submitted an assignment.
- Students with missing attendance records.
- Students without feedback.

LEFT JOIN returns all records from the left table, even when no matching record exists in the right table. This allows missing data to be identified easily.

---

## What I Can Explain Live

I can explain:

- The difference between UPDATE and DELETE.
- Why UPDATE should always use a WHERE clause.
- The difference between hard delete and soft delete.
- Why foreign keys prevent deleting important historical records.
- How NULL values work and why `IS NULL` is required.
- How `COALESCE()` replaces NULL values in reports.
- How `CASE WHEN` creates business classifications.
- The difference between INNER JOIN and LEFT JOIN.
- How LEFT JOIN helps identify missing submissions and attendance.
- Why maintaining data safely is important in real database systems.
