PRAGMA foreign_keys = ON;

-- REPORT 1
-- Show all students and their submissions, including students with no submission.

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    sub.assignment_id,
    sub.score
FROM students s
LEFT JOIN submissions sub
ON s.student_id = sub.student_id
ORDER BY s.student_id;


-- REPORT 2
-- Show students who did not submit Assignment 3.

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    a.title AS assignment_title
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN assignments a
ON e.program_id = a.program_id
LEFT JOIN submissions sub
ON s.student_id = sub.student_id
AND a.assignment_id = sub.assignment_id
WHERE a.assignment_id = 3
AND sub.submission_id IS NULL;


-- REPORT 3
-- Show students whose submission has no feedback.

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    a.title,
    sub.score,
    sub.feedback
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
JOIN assignments a
ON sub.assignment_id = a.assignment_id
WHERE sub.feedback IS NULL;


-- REPORT 4
-- Show enrolled students with missing attendance for Session 2.

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    ses.session_title
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN sessions ses
ON e.program_id = ses.program_id
LEFT JOIN attendance att
ON s.student_id = att.student_id
AND ses.session_id = att.session_id
WHERE ses.session_id = 2
AND att.attendance_id IS NULL;