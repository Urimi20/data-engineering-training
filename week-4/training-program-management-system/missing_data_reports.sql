PRAGMA foreign_keys = ON;

-- Part 6 - Missing Data Reports
-- Unity Tech Hub x Agilyti


-- 1. Students who did not submit Assignment 1

SELECT
    s.first_name AS student_name,
    a.assignment_title
FROM students s
CROSS JOIN assignments a
LEFT JOIN submissions sub
    ON s.student_id = sub.student_id
    AND a.assignment_id = sub.assignment_id
WHERE a.assignment_id = 1
AND sub.submission_id IS NULL;



-- 2. Students with no submissions at all

SELECT
    s.first_name AS student_name
FROM students s
LEFT JOIN submissions sub
    ON s.student_id = sub.student_id
WHERE sub.submission_id IS NULL;



-- 3. Submissions without feedback

SELECT

    s.first_name AS student_name,

    a.assignment_title,

    COALESCE(sub.score,'Not Graded') AS score,

    sub.github_url

FROM submissions sub

LEFT JOIN feedback f
ON sub.submission_id = f.submission_id

JOIN students s
ON sub.student_id = s.student_id

JOIN assignments a
ON sub.assignment_id = a.assignment_id

WHERE f.feedback_id IS NULL;



-- 4. Students without attendance for Session 1

SELECT

    s.first_name AS student_name,

    se.session_title

FROM students s

CROSS JOIN sessions se

LEFT JOIN attendance att

ON s.student_id = att.student_id
AND se.session_id = att.session_id

WHERE se.session_id = 1
AND att.attendance_id IS NULL;



-- 5. Students without review/evaluation

SELECT

    s.first_name AS student_name,

    a.assignment_title,

    sub.status

FROM submissions sub

LEFT JOIN feedback f
ON sub.submission_id = f.submission_id

JOIN students s
ON sub.student_id = s.student_id

JOIN assignments a
ON sub.assignment_id = a.assignment_id

WHERE f.feedback_id IS NULL;



-- 6. Programs with fewer than 3 sessions

SELECT

    p.program_name,

    COUNT(se.session_id) AS total_sessions

FROM programs p

LEFT JOIN sessions se
ON p.program_id = se.program_id

GROUP BY p.program_id

HAVING COUNT(se.session_id) < 3;



-- 7. Assignments without submissions

SELECT

    a.assignment_title

FROM assignments a

LEFT JOIN submissions sub
ON a.assignment_id = sub.assignment_id

WHERE sub.submission_id IS NULL;



-- 8. Active students with no recent activity
-- (No submissions)

SELECT

    s.first_name AS student_name,

    s.email

FROM students s

LEFT JOIN submissions sub
ON s.student_id = sub.student_id

WHERE s.status = 'Active'

AND sub.submission_id IS NULL;



-- 9. Students with attendance but no submission history

SELECT DISTINCT

    s.first_name AS student_name

FROM students s

JOIN attendance att
ON s.student_id = att.student_id

LEFT JOIN submissions sub
ON s.student_id = sub.student_id

WHERE sub.submission_id IS NULL;



-- 10. Students with submissions but no feedback yet

SELECT DISTINCT

    s.first_name AS student_name,

    a.assignment_title,

    COALESCE(f.feedback_text,'No Feedback Yet') AS feedback_status

FROM submissions sub

LEFT JOIN feedback f
ON sub.submission_id = f.submission_id

JOIN students s
ON sub.student_id = s.student_id

JOIN assignments a
ON sub.assignment_id = a.assignment_id

WHERE f.feedback_id IS NULL;