PRAGMA foreign_keys = ON;

-- QUERY 1
-- Find submissions where feedback is missing

SELECT *
FROM submissions
WHERE feedback IS NULL;


-- QUERY 2
-- Find submissions where feedback exists

SELECT *
FROM submissions
WHERE feedback IS NOT NULL;


-- QUERY 3
-- Find attendance records where notes are missing

SELECT *
FROM attendance
WHERE notes IS NULL;


-- QUERY 4
-- Find attendance records where notes exist

SELECT *
FROM attendance
WHERE notes IS NOT NULL;


-- QUERY 5
-- Show "No feedback yet" when feedback is NULL

SELECT
    submission_id,
    student_id,
    assignment_id,
    score,
    COALESCE(feedback, 'No feedback yet') AS feedback_status
FROM submissions;


-- QUERY 6
-- Show "No notes" when attendance notes are NULL

SELECT
    attendance_id,
    session_id,
    student_id,
    status,
    COALESCE(notes, 'No notes') AS attendance_notes
FROM attendance;


-- QUERY 7
-- Student submission report with feedback status

SELECT
    student_id,
    assignment_id,
    score,
    COALESCE(feedback, 'No feedback yet') AS feedback_status
FROM submissions
ORDER BY student_id, assignment_id;


-- QUERY 8
-- Attendance report with note status

SELECT
    student_id,
    session_id,
    status,
    COALESCE(notes, 'No notes') AS note_status
FROM attendance
ORDER BY student_id, session_id;