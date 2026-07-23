PRAGMA foreign_keys = ON;

-- 21. Show programs with more than 3 enrollments

SELECT
    p.program_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
GROUP BY p.program_id
HAVING COUNT(e.enrollment_id) > 3
ORDER BY total_enrollments DESC;


-- 22. Show cities with more than 2 students

SELECT
    city,
    COUNT(student_id) AS total_students
FROM students
GROUP BY city
HAVING COUNT(student_id) > 2
ORDER BY total_students DESC;


-- 23. Show students with attendance rate below 70%

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
HAVING attendance_rate < 70
ORDER BY attendance_rate;



-- 24. Show programs with collected revenue greater than 300

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
HAVING SUM(pay.amount) > 300
ORDER BY collected_revenue DESC;



-- 25. Show instructors with more than 3 active enrollments

SELECT
    i.full_name AS instructor_name,
    COUNT(e.enrollment_id) AS active_enrollments
FROM instructors i
JOIN enrollments e
    ON i.instructor_id = e.instructor_id
WHERE e.status = 'Active'
GROUP BY i.instructor_id
HAVING COUNT(e.enrollment_id) > 3
ORDER BY active_enrollments DESC;



-- 26. Show programs with unpaid or overdue payment amount
-- greater than 100

SELECT
    p.program_name,
    SUM(pay.amount) AS unpaid_amount
FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id
JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status IN ('Pending','Overdue')
GROUP BY p.program_id
HAVING SUM(pay.amount) > 100
ORDER BY unpaid_amount DESC;