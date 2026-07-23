# Day 14 - Database Design Challenge

## Project Goal

Design a relational database for a training center management system that stores students, programs, instructors, enrollments, attendance, and payments. The database supports business reporting while protecting data quality with constraints.

## Business Requirements

The system manages students, programs, instructors, enrollments, attendance, and payments. It provides reports about student progress, attendance, revenue, payment status, and program performance.

## Database Design

Tables created:

- **students** – stores student information.
- **programs** – stores training program details.
- **instructors** – stores instructor information.
- **enrollments** – connects students, programs, and instructors.
- **attendance** – stores attendance records for each enrollment.
- **payments** – stores payment information for each enrollment.

## Relationships

- One student → Many enrollments.
- One program → Many enrollments.
- One instructor → Many enrollments.
- One enrollment → Many attendance records.
- One enrollment → Many payment records.

Primary Keys:

- `student_id`
- `program_id`
- `instructor_id`
- `enrollment_id`
- `attendance_id`
- `payment_id`

Foreign Keys:

- `enrollments.student_id → students.student_id`
- `enrollments.program_id → programs.program_id`
- `enrollments.instructor_id → instructors.instructor_id`
- `attendance.enrollment_id → enrollments.enrollment_id`
- `payments.enrollment_id → enrollments.enrollment_id`

## Constraints

- **PRIMARY KEY** – unique identifier for each table.
- **AUTOINCREMENT** – automatically generates IDs.
- **FOREIGN KEY** – protects relationships.
- **NOT NULL** – required fields cannot be empty.
- **UNIQUE** – prevents duplicate emails.
- **CHECK** – validates statuses and positive payment amounts.

## How to Run

1. `database_schema.sql`
2. `insert_data.sql`
3. `relationship_tests.sql`
4. `join_reports.sql`
5. `aggregation_reports.sql`
6. `having_reports.sql`
7. `data_quality_checks.sql`

## Most Important Reports

- Students by program and instructor.
- Active and completed enrollments.
- Attendance reports.
- Payment reports.
- Revenue by program and city.
- Attendance rate by student and program.

## Data Quality Checks

- Students with no enrollments.
- Programs with no enrollments.
- Enrollments without payments.
- Enrollments without attendance.
- Active students with pending or overdue payments.
- Instructors with no active students.

## Business Insights

The reports help identify the most popular programs, collected revenue, attendance risks, payment risks, and students who need academic or financial support.

## What I Can Explain Live

- Database design decisions.
- Primary keys and foreign keys.
- One-to-many relationships.
- JOIN queries.
- GROUP BY and HAVING.
- Data quality checks using LEFT JOIN.
- How constraints protect data integrity.
