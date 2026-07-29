```md
# Day 17 - SQL Schema Evolution, Views, Transactions & Indexes

## Project Goal

The goal of this project is to understand **database schema evolution** and how databases change as business requirements grow. Instead of recreating tables, we learned how to safely modify an existing database by adding new columns, creating reusable views, using transactions to protect data, and creating indexes to improve query performance.

---

# Setup

The project uses a small training platform database with the following tables:

- **students** – stores student information.
- **programs** – stores training program details.
- **enrollments** – connects students to programs.
- **sessions** – stores training sessions.
- **attendance** – stores attendance records.
- **assignments** – stores assignment information.
- **submissions** – stores student assignment submissions.

The database includes foreign keys, constraints, and sample data to simulate a real training platform.

---

# ALTER TABLE

To simulate changing business requirements, I used **ALTER TABLE** to extend the database without deleting existing data.

I added the following columns:

| Table       | New Column       | Purpose                      |
| ----------- | ---------------- | ---------------------------- |
| students    | phone_number     | Store student phone numbers  |
| students    | github_username  | Store GitHub usernames       |
| submissions | review_status    | Track review progress        |
| submissions | reviewed_at      | Store review date            |
| attendance  | corrected_at     | Track attendance corrections |
| programs    | difficulty_level | Store program difficulty     |
| assignments | task_type        | Identify assignment category |

After adding each column, I used **UPDATE** statements to populate the new fields with sample values.

---

# Views

Views were created to provide reusable reports.

### student_profile_view

Shows student information including city, email, phone number, GitHub username, and enrollment status.

**Business question:**

> What are the contact details and enrollment status of each student?

---

### student_submission_report

Shows student names, assignment titles, scores, feedback, and review status.

**Business question:**

> How did each student perform on assignments?

---

### attendance_summary_view

Shows attendance for every session including session number, topic, attendance status, and notes.

**Business question:**

> Which students attended each session?

---

### missing_feedback_view

Shows submissions where feedback is missing or the submission has not yet been reviewed.

**Business question:**

> Which submissions still need instructor review?

---

### student_performance_view

Uses **CASE WHEN** to classify students based on assignment scores.

Performance levels:

- Excellent
- Good
- Average
- Needs Improvement

**Business question:**

> Which students are performing well and which need additional support?

---

### missing_submission_view

Uses **LEFT JOIN** to identify enrolled students who have not submitted an assignment.

**Business question:**

> Which students are missing assignment submissions?

---

# Transactions

Transactions were used to safely test database changes.

### ROLLBACK Example

I updated a student's submission score inside a transaction and then used **ROLLBACK**.

Result:

- The score returned to its original value.
- No permanent changes were saved.

### COMMIT Example

I updated the review status and review date of a submission.

After verifying the change, I used **COMMIT**.

Result:

- The update was permanently saved.

Transactions are useful because they allow changes to be tested safely before affecting production data.

---

# Indexes

To improve query performance, I created indexes on frequently searched columns.

| Index                     | Reason                                            |
| ------------------------- | ------------------------------------------------- |
| submissions.student_id    | Quickly find a student's submissions              |
| submissions.assignment_id | Quickly find submissions for an assignment        |
| attendance.session_id     | Quickly retrieve attendance for a session         |
| attendance.student_id     | Quickly retrieve attendance history for a student |
| enrollments.program_id    | Quickly find students enrolled in a program       |

Indexes reduce the amount of data the database must scan when executing queries.

---

# Integration Challenge

The **final_student_progress_view** combines information from multiple tables into one management report.

The report includes:

- Student ID
- Student name
- City
- Phone number
- GitHub username
- Enrollment status
- Assignment title
- Score
- Performance level
- Feedback status
- Review status
- Attendance status

The report uses:

- **LEFT JOIN** to include students without submissions.
- **CASE WHEN** to classify performance.
- **COALESCE** to display "No feedback yet" when feedback is NULL.

This provides managers with a complete overview of student progress.

---

# What I Can Explain Live

I can explain:

- The difference between changing data and changing database schema.
- How **ALTER TABLE** works and why it is used.
- Why new columns were added to the database.
- How **UPDATE** fills newly added columns.
- What a **VIEW** is and why it is useful.
- The difference between a table and a view.
- How **LEFT JOIN** finds missing submissions.
- How **CASE WHEN** classifies student performance.
- How **COALESCE** replaces NULL values.
- What **BEGIN TRANSACTION**, **ROLLBACK**, and **COMMIT** do.
- Why transactions protect the database from accidental changes.
- What indexes are and how they improve query performance.
- How schema evolution, views, indexes, and transactions prepare me for working with Databricks and large-scale data engineering systems.
```
