-- 1. Show all students with their programs and instructors.

SELECT
    s.full_name AS student_name,
    p.program_name,
    i.full_name AS instructor_name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
JOIN instructors i
    ON e.instructor_id = i.instructor_id;


-- 2. Show active enrollments only, including student name, program name, instructor name, and status.


SELECT
    s.full_name AS student_name,
    p.program_name,
    i.full_name AS instructor_name,
    e.status
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
JOIN instructors i
    ON e.instructor_id = i.instructor_id
WHERE e.status = 'Active';

-- 3. Show completed enrollments with student and program information.

SELECT
    s.full_name AS student_name,
    p.program_name,
    e.status
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
WHERE e.status = 'Active';

-- 4. Show dropped students and the program they dropped from.

SELECT
    s.full_name AS student_name,
    p.program_name,
    e.status
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
WHERE e.status = 'Dropped';

-- 5. Show attendance records with student name, program name, date, and attended value.

SELECT
    s.full_name AS student_name,
    p.program_name,
    a.session_date,
    a.status AS attendance_status
FROM attendance a
JOIN enrollments e
    ON a.enrollment_id = e.enrollment_id
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id;


-- 6. Show payment records with student name, program name, payment month, status, and amount


SELECT
    s.full_name AS student_name,
    p.program_name,
    pay.payment_month,
    pay.payment_status,
    pay.amount
FROM payments pay
JOIN enrollments e
    ON pay.enrollment_id = e.enrollment_id
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id;




-- 7. Show each student with city and all programsthey are enrolled in


SELECT
    s.full_name AS student_name,
    s.city,
    p.program_name
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN programs p
    ON e.program_id = p.program_id
ORDER BY s.full_name;




-- 8. Show instructors and the students/programs they are responsible for


SELECT
    i.full_name AS instructor_name,
    s.full_name AS student_name,
    p.program_name
FROM instructors i
JOIN enrollments e
    ON i.instructor_id = e.instructor_id
JOIN students s
    ON e.student_id = s.student_id
JOIN programs p
    ON e.program_id = p.program_id
ORDER BY i.full_name;