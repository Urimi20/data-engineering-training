PRAGMA foreign_keys = ON;


-- 1. ALTER TABLE
-- Add missing fields needed for report

ALTER TABLE students
ADD COLUMN phone_number TEXT;

ALTER TABLE students
ADD COLUMN github_username TEXT;


ALTER TABLE submissions
ADD COLUMN review_status TEXT;


-- 2. UPDATE
-- Fill new fields

UPDATE students
SET phone_number = '+38344111111',
    github_username = 'arta-dev'
WHERE student_id = 1;


UPDATE students
SET phone_number = '+38349111111',
    github_username = 'blend-code'
WHERE student_id = 2;


UPDATE students
SET phone_number = '+38345111111',
    github_username = 'dren-sql'
WHERE student_id = 3;


UPDATE students
SET phone_number = '+38348111111',
    github_username = 'elira-tech'
WHERE student_id = 4;


UPDATE submissions
SET review_status = 'reviewed'
WHERE submission_id IN (1,2,4);


UPDATE submissions
SET review_status = 'needs revision'
WHERE submission_id IN (5,6);


UPDATE submissions
SET review_status = 'not reviewed'
WHERE review_status IS NULL;



-- 3. Create Final Student Progress View

CREATE VIEW final_student_progress_view AS

SELECT

    s.student_id,

    s.first_name || ' ' || s.last_name AS student_name,

    s.city,

    s.phone_number,

    s.github_username,

    e.status AS enrollment_status,


    a.title AS assignment_title,


    sub.score,


    CASE
        WHEN sub.score >= 90 THEN 'Excellent'
        WHEN sub.score >= 75 THEN 'Good'
        WHEN sub.score >= 60 THEN 'Average'
        WHEN sub.score IS NULL THEN 'No Score'
        ELSE 'Needs Improvement'
    END AS performance_level,


    COALESCE(
        sub.feedback,
        'No feedback yet'
    ) AS feedback_status,


    sub.review_status,


    att.status AS attendance_status


FROM students s


-- Include students even without submissions
LEFT JOIN enrollments e
ON s.student_id = e.student_id


LEFT JOIN submissions sub
ON s.student_id = sub.student_id


LEFT JOIN assignments a
ON sub.assignment_id = a.assignment_id


LEFT JOIN attendance att
ON s.student_id = att.student_id;



-- 4. Test Final View

SELECT *
FROM final_student_progress_view;



-- 5. Create Indexes
-- Support final report performance


CREATE INDEX idx_report_students_id
ON submissions(student_id);


CREATE INDEX idx_report_attendance_student
ON attendance(student_id);



-- Verify indexes

SELECT name
FROM sqlite_master
WHERE type = 'index';