PRAGMA foreign_keys = ON;

-- Transaction 1

BEGIN TRANSACTION;


SELECT
    student_id,
    first_name,
    city
FROM students
WHERE student_id = 1;


UPDATE students
SET city = 'Peja'
WHERE student_id = 1;

SELECT
    student_id,
    first_name,
    city
FROM students
WHERE student_id = 1;


ROLLBACK;

SELECT
    student_id,
    first_name,
    city
FROM students
WHERE student_id = 1;


-- Transaction 2

BEGIN TRANSACTION;

SELECT
    program_id,
    program_name,
    status
FROM programs
WHERE program_id = 2;

UPDATE programs
SET status = 'Completed'
WHERE program_id = 2;


SELECT
    program_id,
    program_name,
    status
FROM programs
WHERE program_id = 2;

COMMIT;

SELECT
    program_id,
    program_name,
    status
FROM programs
WHERE program_id = 2;


-- Transaction 3

BEGIN TRANSACTION;

SELECT
    student_id,
    first_name,
    status
FROM students
WHERE student_id = 5;

DELETE
FROM students
WHERE student_id = 5;

SELECT *
FROM students
WHERE student_id = 5;

ROLLBACK;

SELECT
    student_id,
    first_name,
    status
FROM students
WHERE student_id = 5;