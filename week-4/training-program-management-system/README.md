# Training Program Management & Analytics System

## Unity Tech Hub x Agilyti

### Data Engineering / Databricks Training

### 3-Day SQL Mini Project

---

# Project Goal

The goal of this project is to design and build a relational database system for managing training programs at Unity Tech Hub. The system stores student information, program details, attendance records, assignments, submissions, feedback, and staff information while protecting data integrity through constraints and relationships.

The database also provides meaningful reports that help management monitor student progress, identify risks, and support better decision-making.

---

# Client Problem

The client was managing information using spreadsheets, messages, GitHub links, attendance notes, and manual tracking. As the number of training programs increased, it became difficult to keep information organized and consistent.

The client needed a centralized relational database that:

- Stores information in one place.
- Prevents invalid or duplicate data.
- Maintains historical records.
- Generates useful management reports.
- Supports future growth.

---

# Database Design

The database was designed using a normalized relational model instead of storing everything in one large table.

The design separates different business entities into individual tables connected by foreign keys.

This approach reduces redundancy, improves data consistency, and makes reporting easier.

---

# Tables Created

The project contains the following tables:

- students
- programs
- staff
- program_staff
- enrollments
- sessions
- attendance
- assignments
- submissions
- feedback

Each table represents a real business entity.

For example:

- Students store personal information.
- Programs store training details.
- Enrollments connect students to programs.
- Attendance records session participation.
- Assignments represent learning tasks.
- Submissions store GitHub project links and scores.
- Feedback stores reviewer comments.

---

# Relationships

The most important relationships are:

- One student can enroll in many programs.
- One program can have many students.
- One program can have multiple instructors and mentors.
- One instructor can teach multiple programs.
- One program contains many sessions.
- One program contains many assignments.
- Students submit assignments.
- Staff members review submissions.

These relationships were implemented using foreign keys.

---

# Primary Keys

Primary keys uniquely identify every record.

Examples:

- student_id
- program_id
- staff_id
- enrollment_id
- session_id
- attendance_id
- assignment_id
- submission_id
- feedback_id

Each primary key uses AUTOINCREMENT.

---

# Foreign Keys

Foreign keys protect relationships between tables.

Examples:

- enrollments.student_id → students.student_id
- enrollments.program_id → programs.program_id
- attendance.student_id → students.student_id
- attendance.session_id → sessions.session_id
- assignments.program_id → programs.program_id
- submissions.assignment_id → assignments.assignment_id
- submissions.student_id → students.student_id
- feedback.submission_id → submissions.submission_id
- feedback.reviewer_id → staff.staff_id

These constraints prevent invalid references.

---

# Unique Constraints

Unique constraints were used to prevent duplicate data.

Examples:

- Student email
- Staff email
- Student enrollment in the same program
- Attendance for the same student and session
- Submission for the same student and assignment
- Program and staff combination

---

# CHECK Constraints

CHECK constraints were used to ensure valid business values.

Examples:

Student status:

- Active
- Inactive
- Dropped
- Completed

Attendance status:

- Present
- Absent
- Late
- Excused

Program status:

- Planned
- Running
- Completed

Submission status:

- Submitted
- Reviewed
- Missing

Role:

- Instructor
- Mentor
- Support

Score:

- Between 0 and 100

---

# Reports Created

The project contains several reporting files.

### Basic Reports

- Students with enrolled programs
- Program instructors
- Attendance reports
- Submission reports
- Active students
- Dropped students
- Reviewed submissions

### Advanced Reports

- Average score by student
- Average score by assignment
- Attendance summary
- Missing submission count
- Missing feedback count
- Program performance
- Students needing support
- Students ready for the next phase

### Missing Data Reports

- Students without submissions
- Missing attendance
- Missing feedback
- Programs with few sessions
- Assignments without submissions
- Students with attendance but no submissions

### Final Manager Report

The final report combines attendance, scores, missing work, readiness, and recommended actions into one management dashboard.

---

# Missing Data Analysis

Missing data was identified using:

- LEFT JOIN
- IS NULL
- COALESCE

These techniques make it possible to find:

- Missing submissions
- Missing attendance
- Missing feedback
- Students with no activity

INNER JOIN was intentionally avoided where missing records needed to be detected.

---

# Views Created

Five reusable views were created:

- student_program_overview
- student_submission_overview
- student_attendance_summary
- student_risk_analysis
- management_dashboard

Views simplify reporting and avoid repeating complex SQL queries.

---

# Transactions

Three transactions were tested.

### Transaction 1

Updated data and used **ROLLBACK** to cancel changes.

### Transaction 2

Updated data and used **COMMIT** to save changes permanently.

### Transaction 3

Tested a dangerous DELETE operation and restored the data using **ROLLBACK**.

This demonstrates safe database maintenance.

---

# Indexes

Indexes were created on frequently searched columns.

Examples:

- students.email
- enrollments.student_id
- enrollments.program_id
- attendance.student_id
- attendance.session_id
- assignments.program_id
- submissions.student_id
- submissions.assignment_id
- feedback.submission_id

Indexes improve query performance but do not change query results.

As the database grows, indexes help the database find records much faster.

---

# Soft Delete vs Hard Delete

Hard Delete permanently removes a record from the database using DELETE.

Example:

```sql
DELETE FROM students
WHERE student_id = 5;
```

Soft Delete keeps the record but changes its status.

Example:

```sql
UPDATE students
SET status='Dropped'
WHERE student_id=5;
```

Soft Delete preserves historical information and is safer for business systems.

---

# Hardest Part

The most challenging part of this project was designing a relational database that satisfies all client requirements while maintaining data integrity.

Creating advanced reports using multiple JOINs, aggregation functions, business logic, and missing-data analysis was also an important learning experience.

---

# What I Can Explain Live

I can confidently explain:

- Database design decisions
- Table relationships
- Primary Keys
- Foreign Keys
- Unique Constraints
- CHECK Constraints
- One-to-Many and Many-to-Many relationships
- JOIN operations
- LEFT JOIN vs INNER JOIN
- GROUP BY
- Aggregate functions
- CASE WHEN
- COALESCE
- Transactions
- COMMIT vs ROLLBACK
- Views
- Indexes
- Missing data analysis
- Final management report
- Business logic used for recommendations

---

# Technologies Used

- SQLite
- SQL
- DB Browser for SQLite
- GitHub
- dbdiagram.io

---

# Conclusion

This project demonstrates how a relational database can solve real business problems by organizing training information, protecting data quality, and providing meaningful reports for management. The solution follows SQL best practices using normalization, constraints, relationships, views, transactions, indexes, and business reporting.
