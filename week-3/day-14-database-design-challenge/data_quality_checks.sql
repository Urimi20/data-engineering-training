PRAGMA foreign_keys = ON;


-- 27. Find students with no enrollments

SELECT
    s.student_id,
    s.full_name
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;



-- 28. Find programs with no enrollments

SELECT
    p.program_id,
    p.program_name
FROM programs p
LEFT JOIN enrollments e
    ON p.program_id = e.program_id
WHERE e.enrollment_id IS NULL;



-- 29. Find enrollments with no payment record

SELECT
    e.enrollment_id,
    s.full_name,
    p.program_name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
LEFT JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_id IS NULL;



-- 30. Find enrollments with no attendance records

SELECT
    e.enrollment_id,
    s.full_name,
    p.program_name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
LEFT JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
WHERE a.attendance_id IS NULL;



-- 31. Find active students with pending or overdue payments

SELECT
    s.full_name,
    p.program_name,
    pay.payment_status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN programs p
    ON e.program_id = p.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE e.status = 'Active'
AND pay.payment_status IN ('Pending','Overdue');



-- 32. Find students with low attendance but paid payments

SELECT
    s.full_name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)
        *100.0/COUNT(a.attendance_id),2
    ) AS attendance_rate,
    pay.payment_status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status='Paid'
GROUP BY s.student_id
HAVING attendance_rate < 70;



-- 33. Find students with high attendance but pending
-- or overdue payments

SELECT
    s.full_name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)
        *100.0/COUNT(a.attendance_id),2
    ) AS attendance_rate,
    pay.payment_status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status IN ('Pending','Overdue')
GROUP BY s.student_id
HAVING attendance_rate >= 70;



-- 34. Find dropped students who still have paid
-- or overdue payment records

SELECT
    s.full_name,
    p.program_name,
    e.status,
    pay.payment_status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN programs p
    ON e.program_id = p.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE e.status='Dropped'
AND pay.payment_status IN ('Paid','Overdue');



-- 35. Find instructors with no active students

SELECT
    i.full_name
FROM instructors i
LEFT JOIN enrollments e
    ON i.instructor_id = e.instructor_id
    AND e.status='Active'
WHERE e.enrollment_id IS NULL;



-- 36. Find risky or inconsistent records
-- Completed enrollments that still have overdue payments

SELECT
    s.full_name,
    p.program_name,
    e.status,
    pay.payment_status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN programs p
    ON e.program_id = p.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE e.status='Completed'
AND pay.payment_status='Overdue';