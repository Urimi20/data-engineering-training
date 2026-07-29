PRAGMA foreign_keys = ON;


-- ALTER 1 - Add phone_number to students


ALTER TABLE students
ADD COLUMN phone_number TEXT;

SELECT * FROM students;

UPDATE students
SET phone_number = '+38344111222'
WHERE student_id = 1;

UPDATE students
SET phone_number = '+38349123456'
WHERE student_id = 2;

UPDATE students
SET phone_number = '+38345111222'
WHERE student_id = 3;

UPDATE students
SET phone_number = '+38348123456'
WHERE student_id = 4;

SELECT student_id, first_name, phone_number
FROM students;


-- ALTER 2 - Add github_username to students


ALTER TABLE students
ADD COLUMN github_username TEXT;

SELECT * FROM students;

UPDATE students
SET github_username = 'arta-dev'
WHERE student_id = 1;

UPDATE students
SET github_username = 'blend-code'
WHERE student_id = 2;

UPDATE students
SET github_username = 'dren-sql'
WHERE student_id = 3;

UPDATE students
SET github_username = 'elira-tech'
WHERE student_id = 4;

SELECT student_id, first_name, github_username
FROM students;


-- ALTER 3 - Add review_status to submissions


ALTER TABLE submissions
ADD COLUMN review_status TEXT;

SELECT * FROM submissions;

UPDATE submissions
SET review_status = 'reviewed'
WHERE submission_id IN (1,2,4,7);

UPDATE submissions
SET review_status = 'needs revision'
WHERE submission_id IN (5,10);

UPDATE submissions
SET review_status = 'not reviewed'
WHERE review_status IS NULL;

SELECT
submission_id,
student_id,
review_status
FROM submissions;


-- ALTER 4 - Add reviewed_at to submissions


ALTER TABLE submissions
ADD COLUMN reviewed_at DATE;

SELECT * FROM submissions;

UPDATE submissions
SET reviewed_at = '2026-07-07'
WHERE submission_id = 1;

UPDATE submissions
SET reviewed_at = '2026-07-07'
WHERE submission_id = 2;

UPDATE submissions
SET reviewed_at = '2026-07-08'
WHERE submission_id = 4;

SELECT
submission_id,
review_status,
reviewed_at
FROM submissions;


-- ALTER 5 - Add corrected_at to attendance


ALTER TABLE attendance
ADD COLUMN corrected_at DATE;

SELECT * FROM attendance;

UPDATE attendance
SET corrected_at = '2026-07-06'
WHERE attendance_id IN (3,5,10);

SELECT
attendance_id,
student_id,
status,
corrected_at
FROM attendance;


-- ALTER 6 - Add difficulty_level to programs


ALTER TABLE programs
ADD COLUMN difficulty_level TEXT;

SELECT * FROM programs;

UPDATE programs
SET difficulty_level = 'beginner'
WHERE program_id = 1;

SELECT
program_id,
program_name,
difficulty_level
FROM programs;


-- ALTER 7 - Add task_type to assignments


ALTER TABLE assignments
ADD COLUMN task_type TEXT;

SELECT * FROM assignments;

UPDATE assignments
SET task_type = 'SQL'
WHERE assignment_id = 1;

UPDATE assignments
SET task_type = 'SQL'
WHERE assignment_id = 2;

UPDATE assignments
SET task_type = 'Pipeline'
WHERE assignment_id = 3;

UPDATE assignments
SET task_type = 'Databricks Prep'
WHERE assignment_id = 4;

SELECT
assignment_id,
title,
task_type
FROM assignments;