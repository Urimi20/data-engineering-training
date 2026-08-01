PRAGMA foreign_keys = ON;

-- 1. Students with their enrolled programs

SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    p.program_name,
    e.status AS enrollment_status,
    e.enrollment_date
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
ORDER BY student_name;


-- 2. Programs with instructors and mentors

SELECT
    p.program_name,
    st.first_name || ' ' || st.last_name AS staff_name,
    st.role
FROM program_staff ps
JOIN programs p
    ON ps.program_id = p.program_id
JOIN staff st
    ON ps.staff_id = st.staff_id
ORDER BY p.program_name;


-- 3. Sessions with program information

SELECT
    se.session_title,
    se.session_date,
    p.program_name,
    p.program_type
FROM sessions se
JOIN programs p
    ON se.program_id = p.program_id
ORDER BY se.session_date;


-- 4. Attendance with student and session information

SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    se.session_title,
    se.session_date,
    a.attendance_status
FROM attendance a
JOIN students s
    ON a.student_id = s.student_id
JOIN sessions se
    ON a.session_id = se.session_id
ORDER BY se.session_date, student_name;


-- 5. Submissions with student and assignment

SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    ass.assignment_title,
    sub.github_url,
    sub.score,
    sub.status
FROM submissions sub
JOIN students s
    ON sub.student_id = s.student_id
JOIN assignments ass
    ON sub.assignment_id = ass.assignment_id
ORDER BY student_name;


-- 6. All active students

SELECT
    first_name,
    last_name,
    email,
    city
FROM students
WHERE status = 'Active';


-- 7. All dropped students

SELECT
    first_name,
    last_name,
    email,
    city
FROM students
WHERE status = 'Dropped';


-- 8. All reviewed submissions

SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    ass.assignment_title,
    sub.score,
    sub.github_url
FROM submissions sub
JOIN students s
    ON sub.student_id = s.student_id
JOIN assignments ass
    ON sub.assignment_id = ass.assignment_id
WHERE sub.status = 'Reviewed'
ORDER BY sub.score DESC;


-- 9. Students enrolled but with little activity

SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    p.program_name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
LEFT JOIN submissions sub
    ON s.student_id = sub.student_id
WHERE sub.submission_id IS NULL;


-- 10. Management Friendly Report

SELECT
    s.first_name || ' ' || s.last_name AS student,
    p.program_name AS program,
    st.first_name || ' ' || st.last_name AS instructor,
    e.status AS enrollment_status
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
JOIN program_staff ps
    ON p.program_id = ps.program_id
JOIN staff st
    ON ps.staff_id = st.staff_id
WHERE st.role = 'Instructor'
ORDER BY program, student;