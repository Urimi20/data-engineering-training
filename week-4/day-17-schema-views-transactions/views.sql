PRAGMA foreign_keys = ON;

-- VIEW 1 - Student Profile View

CREATE VIEW student_profile_view AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.city,
    s.email,
    s.phone_number,
    s.github_username,
    e.status AS enrollment_status
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id;

SELECT * FROM student_profile_view;

-- VIEW 2 - Student Submission Report

CREATE VIEW student_submission_report AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    a.title AS assignment_title,
    sub.score,
    sub.feedback,
    sub.review_status
FROM submissions sub
JOIN students s
ON sub.student_id = s.student_id
JOIN assignments a
ON sub.assignment_id = a.assignment_id;

SELECT * FROM student_submission_report;

-- VIEW 3 - Attendance Summary View

CREATE VIEW attendance_summary_view AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    se.session_number,
    se.topic,
    a.status AS attendance_status,
    a.notes
FROM attendance a
JOIN students s
ON a.student_id = s.student_id
JOIN sessions se
ON a.session_id = se.session_id;

SELECT * FROM attendance_summary_view;

-- VIEW 4 - Missing Feedback View

CREATE VIEW missing_feedback_view AS
SELECT
    sub.submission_id,
    s.first_name,
    s.last_name,
    ass.title,
    sub.feedback,
    sub.review_status
FROM submissions sub
JOIN students s
ON sub.student_id = s.student_id
JOIN assignments ass
ON sub.assignment_id = ass.assignment_id
WHERE sub.feedback IS NULL
   OR sub.review_status = 'not reviewed';

SELECT * FROM missing_feedback_view;

-- VIEW 5 - Student Performance View

CREATE VIEW student_performance_view AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    sub.score,

    CASE
        WHEN sub.score >= 90 THEN 'Excellent'
        WHEN sub.score >= 75 THEN 'Good'
        WHEN sub.score >= 60 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_level

FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id;

SELECT * FROM student_performance_view;

-- VIEW 6 - Missing Submission View
-- Students enrolled but missing Assignment 4

CREATE VIEW missing_submission_view AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    a.assignment_id,
    a.title

FROM students s
JOIN enrollments e
ON s.student_id = e.student_id

CROSS JOIN assignments a

LEFT JOIN submissions sub
ON sub.student_id = s.student_id
AND sub.assignment_id = a.assignment_id

WHERE a.assignment_id = 4
AND sub.submission_id IS NULL;

SELECT * FROM missing_submission_view;