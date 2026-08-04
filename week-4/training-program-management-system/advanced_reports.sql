PRAGMA foreign_keys = ON;

-- ==========================================================
-- Part 5 - Advanced Reports
-- Unity Tech Hub x Agilyti
-- ==========================================================

-- 1. Average score by student

SELECT
    s.first_name AS student_name,
    ROUND(AVG(sub.score),2) AS average_score
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id;


-- 2. Average score by assignment

SELECT
    a.assignment_title,
    ROUND(AVG(sub.score),2) AS average_score
FROM assignments a
JOIN submissions sub
ON a.assignment_id = sub.assignment_id
GROUP BY a.assignment_id;


-- 3. Attendance summary by student

SELECT
    s.first_name AS student_name,
    COUNT(att.attendance_id) AS total_sessions,
    SUM(CASE WHEN att.attendance_status='Present' THEN 1 ELSE 0 END) AS present,
    SUM(CASE WHEN att.attendance_status='Absent' THEN 1 ELSE 0 END) AS absent,
    SUM(CASE WHEN att.attendance_status='Late' THEN 1 ELSE 0 END) AS late,
    SUM(CASE WHEN att.attendance_status='Excused' THEN 1 ELSE 0 END) AS excused
FROM students s
LEFT JOIN attendance att
ON s.student_id = att.student_id
GROUP BY s.student_id;


-- 4. Submission count by student

SELECT
    s.first_name AS student_name,
    COUNT(sub.submission_id) AS total_submissions
FROM students s
LEFT JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id;


-- 5. Missing submission count by student

SELECT
    s.first_name AS student_name,
    COUNT(a.assignment_id) - COUNT(sub.submission_id) AS missing_submissions
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN assignments a
ON e.program_id = a.program_id
LEFT JOIN submissions sub
ON s.student_id = sub.student_id
AND a.assignment_id = sub.assignment_id
GROUP BY s.student_id;


-- 6. Feedback missing count

SELECT
    s.first_name AS student_name,
    COUNT(sub.submission_id) - COUNT(f.feedback_id) AS missing_feedback
FROM students s
LEFT JOIN submissions sub
ON s.student_id = sub.student_id
LEFT JOIN feedback f
ON sub.submission_id = f.submission_id
GROUP BY s.student_id;


-- 7. Program performance summary

SELECT
    p.program_name,
    COUNT(DISTINCT e.student_id) AS students,
    ROUND(AVG(sub.score),2) AS average_score,
    MIN(sub.score) AS lowest_score,
    MAX(sub.score) AS highest_score
FROM programs p
LEFT JOIN enrollments e
ON p.program_id = e.program_id
LEFT JOIN submissions sub
ON e.student_id = sub.student_id
GROUP BY p.program_id;


-- 8. Students with average score below 70

SELECT
    s.first_name AS student_name,
    ROUND(AVG(sub.score),2) AS average_score
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id
HAVING AVG(sub.score) < 70;


-- 9. Students with 2 or more absences

SELECT
    s.first_name AS student_name,
    COUNT(*) AS absences
FROM students s
JOIN attendance att
ON s.student_id = att.student_id
WHERE att.attendance_status='Absent'
GROUP BY s.student_id
HAVING COUNT(*) >=2;


-- 10. Students who need support

SELECT
    s.first_name AS student_name,
    ROUND(AVG(sub.score),2) AS average_score
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id
HAVING AVG(sub.score) < 70;


-- 11. Students ready for the next phase

SELECT
    s.first_name AS student_name,
    ROUND(AVG(sub.score),2) AS average_score
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id
HAVING AVG(sub.score) >=85;


-- 12. Program-level summary

SELECT

    p.program_name,

    COUNT(DISTINCT e.student_id) AS total_students,

    COUNT(DISTINCT att.attendance_id) AS attendance_records,

    ROUND(AVG(sub.score),2) AS average_score,

    COUNT(DISTINCT a.assignment_id)
    -
    COUNT(DISTINCT sub.submission_id)
    AS missing_submissions

FROM programs p

LEFT JOIN enrollments e
ON p.program_id = e.program_id

LEFT JOIN attendance att
ON e.student_id = att.student_id

LEFT JOIN assignments a
ON p.program_id = a.program_id

LEFT JOIN submissions sub
ON e.student_id = sub.student_id
AND a.assignment_id = sub.assignment_id

GROUP BY p.program_id;