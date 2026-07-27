PRAGMA foreign_keys = ON;

-- DELETE 1
-- Safe delete: delete a record that is NOT connected
-- to any attendance or submissions.

-- First create a temporary test student.

INSERT INTO students (
    first_name,
    last_name,
    email,
    city,
    created_at
)
VALUES (
    'Test',
    'Student',
    'test.student@email.com',
    'Prishtina',
    '2026-07-20'
);

-- Verify the record exists.

SELECT *
FROM students
WHERE email = 'test.student@email.com';

-- Safe to delete because this student has
-- no enrollments, attendance, or submissions.

DELETE FROM students
WHERE email = 'test.student@email.com';

-- Verify deletion.

SELECT *
FROM students
WHERE email = 'test.student@email.com';


-- DELETE 2
-- Unsafe delete: try deleting a student that has history.
-- This should fail because of foreign key references.

SELECT *
FROM students
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 1;

-- Expected:
-- FOREIGN KEY constraint failed


-- DELETE 3
-- Unsafe delete: assignment already has submissions.
-- Foreign key protection should prevent deletion.

SELECT *
FROM assignments
WHERE assignment_id = 1;

DELETE FROM assignments
WHERE assignment_id = 1;

-- Expected:
-- FOREIGN KEY constraint failed


-- DELETE 4
-- Safe delete: create a temporary assignment that has
-- no submissions, then delete it.

INSERT INTO assignments (
    program_id,
    title,
    day_number,
    due_date,
    max_points
)
VALUES (
    1,
    'Temporary Assignment',
    99,
    '2026-08-01',
    100
);

SELECT *
FROM assignments
WHERE title = 'Temporary Assignment';

-- Safe because no submission references this assignment.

DELETE FROM assignments
WHERE title = 'Temporary Assignment';

SELECT *
FROM assignments
WHERE title = 'Temporary Assignment';



PRAGMA foreign_keys = ON;

-- CASE WHEN 1
-- Classify student performance based on score


SELECT
    student_id,
    assignment_id,
    score,
    CASE
        WHEN score >= 90 THEN 'Excellent'
        WHEN score >= 75 THEN 'Good'
        WHEN score >= 60 THEN 'Needs Improvement'
        ELSE 'At Risk'
    END AS performance_level
FROM submissions;


-- CASE WHEN 2
-- Classify attendance


SELECT
    attendance_id,
    student_id,
    session_id,
    status,
    CASE
        WHEN status = 'Present' THEN 'Attended'
        WHEN status = 'Late' THEN 'Late Arrival'
        WHEN status = 'Absent' THEN 'Absent'
    END AS attendance_category
FROM attendance;


-- CASE WHEN 3
-- Classify enrollment risk

SELECT
    enrollment_id,
    student_id,
    status,
    CASE
        WHEN status = 'active' THEN 'Low Risk'
        WHEN status = 'completed' THEN 'Graduated'
        WHEN status = 'dropped' THEN 'High Risk'
    END AS enrollment_risk
FROM enrollments;