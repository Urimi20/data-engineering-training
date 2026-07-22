# Day 13 - Intensive Relationships and Foreign Keys

## Project Goal

The goal of this project was to design a relational database using SQLite, create relationships between tables with primary and foreign keys, insert realistic data, test database constraints, and build SQL JOIN reports for business analysis.

---

## Database Design

The database was designed using a normalized structure to avoid duplicated data and maintain data integrity. Each table has its own purpose and is connected using foreign keys.

---

## Tables and Relationships

The project contains the following tables:

- students
- instructors
- courses
- enrollments
- attendance
- assignments
- submissions

Relationships:

- One instructor → Many courses
- One course → Many assignments
- One student → Many enrollments
- One course → Many enrollments
- One enrollment → Many attendance records
- One assignment → Many submissions
- One student → Many submissions

The `enrollments` table creates the many-to-many relationship between students and courses.

---

## Primary Keys, Foreign Keys, and Constraints

This project uses:

- PRIMARY KEY
- AUTOINCREMENT
- FOREIGN KEY
- UNIQUE
- CHECK constraints

These constraints help protect the database by preventing invalid or duplicate data.

---

## Seed Data

The database was populated with realistic sample data including:

- 8 students
- 3 instructors
- 5 courses
- 12 enrollments
- 18 attendance records
- 6 assignments
- 12 submissions

The data was created to make JOIN reports meaningful.

---

## Constraint Tests

Constraint tests were created to verify that the database rejects invalid data.

Examples include:

- Invalid foreign keys
- Duplicate enrollments
- Duplicate student email
- Invalid course level
- Negative attendance minutes
- Invalid submission score

These tests confirm that the schema protects data quality.

---

## JOIN Reports

Several JOIN reports were created, including:

- Students with city and email
- Courses with instructors
- Assignments by course
- Enrollment reports
- Active enrollments
- Attendance reports
- Submission reports
- Student count by course
- Students enrolled in multiple courses
- Average attendance by course
- Average score by course
- Missing and late submissions
- Students without enrollments
- Assignments without submissions

---

## Manager Report

Business reports include:

- Courses with the most enrollments
- Students active in multiple courses
- Strongest average attendance
- Weakest assignment completion
- Students needing attention
- Instructor with the most active enrollments
- Final management report combining student, course, instructor, attendance, and score information

---

## Screenshots

Include screenshots of:

- Database schema
- Seed data
- Constraint tests
- JOIN reports
- Manager report results

---

## What I Can Explain Live

I can explain:

- Primary Keys
- Foreign Keys
- AUTOINCREMENT
- One-to-many relationships
- Many-to-many relationships
- Bridge tables
- INNER JOIN
- LEFT JOIN
- GROUP BY
- Aggregate functions
- Database normalization
- Constraint testing

---

## What I Would Improve Next

Future improvements include:

- Adding indexes for better performance
- Creating SQL views for reports
- Using triggers for advanced validation
- Adding more realistic data
- Building dashboards using Databricks or Power BI
- Expanding reporting with additional business metrics
