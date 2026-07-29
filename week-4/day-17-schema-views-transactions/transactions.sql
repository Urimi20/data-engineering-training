PRAGMA foreign_keys = ON;

-- Transaction 1 Update one score then ROLLBACK

BEGIN TRANSACTION;

UPDATE submissions
SET score = 100
WHERE submission_id = 3;

SELECT submission_id, score
FROM submissions
WHERE submission_id = 3;

ROLLBACK;

SELECT submission_id, score
FROM submissions
WHERE submission_id = 3;

-- Transaction 2 Update review_status then COMMIT

BEGIN TRANSACTION;

UPDATE submissions
SET review_status = 'reviewed',
    reviewed_at = '2026-07-28'
WHERE submission_id = 5;

COMMIT;

SELECT
submission_id,
review_status,
reviewed_at
FROM submissions
WHERE submission_id = 5;

-- Transaction 3 Try to delete a student with related records

BEGIN TRANSACTION;

DELETE FROM students
WHERE student_id = 1;

ROLLBACK;

-- Transaction 4 Soft delete an enrollment

BEGIN TRANSACTION;

UPDATE enrollments
SET status = 'Dropped'
WHERE enrollment_id = 2;

COMMIT;

SELECT *
FROM enrollments
WHERE enrollment_id = 2;

-- Transaction 5 Update score and feedback together

BEGIN TRANSACTION;

UPDATE submissions
SET
    score = 95,
    feedback = 'Excellent improvement'
WHERE submission_id = 6;

COMMIT;

SELECT
submission_id,
score,
feedback
FROM submissions
WHERE submission_id = 6;

