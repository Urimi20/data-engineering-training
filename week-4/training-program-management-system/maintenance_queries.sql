PRAGMA foreign_keys = ON;

-- 1. Correct a student's city
SELECT *
FROM students
WHERE student_id = 2;

UPDATE students
SET city = 'Prishtina'
WHERE student_id = 2;

SELECT *
FROM students
WHERE student_id = 2;


-- 2. Correct a wrong email
SELECT *
FROM students
WHERE student_id = 3;

UPDATE students
SET email = 'luan.berisha@gmail.com'
WHERE student_id = 3;

SELECT *
FROM students
WHERE student_id = 3;


-- 3. Change program status
SELECT *
FROM programs
WHERE program_id = 1;

UPDATE programs
SET status = 'Completed'
WHERE program_id = 1;

SELECT *
FROM programs
WHERE program_id = 1;


-- 4. Soft delete
SELECT *
FROM students
WHERE student_id = 6;

UPDATE students
SET status = 'Dropped'
WHERE student_id = 6;

SELECT *
FROM students
WHERE student_id = 6;


-- 5. Correct attendance
SELECT *
FROM attendance
WHERE student_id = 4
AND session_id = 1;

UPDATE attendance
SET attendance_status = 'Present'
WHERE student_id = 4
AND session_id = 1;

SELECT *
FROM attendance
WHERE student_id = 4
AND session_id = 1;


-- 6. Add missing feedback
SELECT
    submission_id
FROM submissions
WHERE submission_id NOT IN
(
    SELECT submission_id
    FROM feedback
);


INSERT INTO feedback
(
    submission_id,
    reviewer_id,
    feedback_text,
    review_date
)
VALUES
(
    3,
    1,
    'Good improvement after revision.',
    '2026-04-15'
);


SELECT *
FROM feedback
WHERE submission_id = 3;


-- 7. Update score after review
SELECT *
FROM submissions
WHERE submission_id = 10;

UPDATE submissions
SET score = 82,
    status = 'Reviewed'
WHERE submission_id = 10;

SELECT *
FROM submissions
WHERE submission_id = 10;


-- 8. Normalize city names
SELECT student_id, first_name, city
FROM students;

UPDATE students
SET city = 'Prishtina'
WHERE city IN
(
    'prishtina',
    'PRISHTINA',
    'Prishtine',
    'PRISHTINE'
);

UPDATE students
SET city = 'Vushtrri'
WHERE city IN
(
    'vushtri',
    'VUSHTRRI',
    'vushtrri'
);

SELECT student_id, first_name, city
FROM students;


-- 9. Dangerous DELETE

DELETE FROM students
WHERE student_id = 5;


-- 10. Verify dropped students
SELECT
    student_id,
    first_name,
    last_name,
    status
FROM students
WHERE status = 'Dropped';