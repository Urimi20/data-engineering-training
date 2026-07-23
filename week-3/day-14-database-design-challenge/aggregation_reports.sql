-- 9. Count students by city
SELECT
    city,
    COUNT(*) AS total_students
FROM students
GROUP BY city
ORDER BY total_students DESC;

-- 10. Count enrollments by status
SELECT
    status,
    COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY status
ORDER BY total_enrollments DESC;

-- 11. Count enrollments by program
SELECT
    p.program_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM programs p
LEFT JOIN enrollments e
    ON p.program_id = e.program_id
GROUP BY p.program_name
ORDER BY total_enrollments DESC;
-- 12. Count active enrollments by program
SELECT
    p.program_name,
    COUNT(e.enrollment_id) AS active_students
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
WHERE e.status = 'Active'
GROUP BY p.program_name
ORDER BY active_students DESC;

-- 13. Calculate total paid amount by program
SELECT
    p.program_name,
    SUM(pay.amount) AS total_paid_amount
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status = 'Paid'
GROUP BY p.program_name
ORDER BY total_paid_amount DESC;


-- 14. Calculate unpaid or overdue amount by program
SELECT
    p.program_name,
    SUM(pay.amount) AS unpaid_amount
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status IN ('Pending','Overdue')
GROUP BY p.program_name
ORDER BY unpaid_amount DESC;


-- 15. Calculate collected revenue by city
SELECT
    s.city,
    SUM(pay.amount) AS collected_revenue
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status = 'Paid'
GROUP BY s.city
ORDER BY collected_revenue DESC;


-- 16. Calculate average attendance rate by student
-- Formula:
-- Present sessions / total sessions * 100
SELECT
    s.full_name AS student_name,
    ROUND(
        SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(a.attendance_id),
        2
    ) AS attendance_rate
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id
ORDER BY attendance_rate DESC;


-- 17. Calculate average attendance rate by program
SELECT
    p.program_name,
    ROUND(
        SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(a.attendance_id),
        2
    ) AS average_attendance_rate
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
GROUP BY p.program_id
ORDER BY average_attendance_rate DESC;


-- 18. Show top 5 students by attendance rate
SELECT
    s.full_name AS student_name,
    ROUND(
        SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(a.attendance_id),
        2
    ) AS attendance_rate
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id
ORDER BY attendance_rate DESC
LIMIT 5;


-- 19. Show top 5 programs by collected revenue
SELECT
    p.program_name,
    SUM(pay.amount) AS collected_revenue
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status = 'Paid'
GROUP BY p.program_id
ORDER BY collected_revenue DESC
LIMIT 5;


-- 20. Show instructors ranked by number of active students
SELECT
    i.full_name AS instructor_name,
    COUNT(e.student_id) AS active_students
FROM instructors i
JOIN enrollments e
    ON i.instructor_id = e.instructor_id
WHERE e.status = 'Active'
GROUP BY i.instructor_id
ORDER BY active_student DESC; 