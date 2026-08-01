PRAGMA foreign_keys = ON;

-- 1. Students who did not submit a specific assignment

SELECT
    s.first_name AS student_name
FROM students s
LEFT JOIN submissions sub
    ON s.student_id = sub.student_id
    AND sub.assignment_id = 1
WHERE sub.submission_id IS NULL;



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
    COALESCE(sub.score,'Not Reviewed') AS score
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
    s.first_name AS student_name
FROM students s
LEFT JOIN attendance a
    ON s.student_id = a.student_id
    AND a.session_id = 1
WHERE a.attendance_id IS NULL;



-- 5. Students without review/evaluation

SELECT
    s.first_name AS student_name,
    a.assignment_title
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
    COUNT(s.session_id) AS total_sessions
FROM programs p
LEFT JOIN sessions s
    ON p.program_id = s.program_id
GROUP BY p.program_id
HAVING COUNT(s.session_id) < 3;



-- 7. Assignments without submissions

SELECT
    a.assignment_title
FROM assignments a
LEFT JOIN submissions sub
    ON a.assignment_id = sub.assignment_id
WHERE sub.submission_id IS NULL;



-- 8. Active students with no recent activity

SELECT
    s.first_name AS student_name
FROM students s
LEFT JOIN submissions sub
    ON s.student_id = sub.student_id
WHERE s.status='Active'
AND sub.submission_id IS NULL;



-- 9. Students with attendance but no submissions

SELECT DISTINCT

    s.first_name AS student_name

FROM students s

JOIN attendance a
    ON s.student_id = a.student_id

LEFT JOIN submissions sub
    ON s.student_id = sub.student_id

WHERE sub.submission_id IS NULL;



-- 10. Students with submissions but no feedback

SELECT DISTINCT

    s.first_name AS student_name,

    a.assignment_title

FROM submissions sub

LEFT JOIN feedback f
    ON sub.submission_id = f.submission_id

JOIN students s
    ON sub.student_id = s.student_id

JOIN assignments a
    ON sub.assignment_id = a.assignment_id

WHERE f.feedback_id IS NULL;