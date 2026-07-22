
-- Beginner
-- Show all students with their city and email
SELECT full_name, city, email
FROM students;

-- Beginner
-- Show all courses with instructor name and specialization
SELECT c.course_name, i.full_name, i.specialization
FROM courses c
JOIN instructors i
ON c.instructor_id = i.instructor_id;

-- Beginner
-- Show all assignments with course name and due date
SELECT a.title, c.course_name, a.due_date
FROM assignments a
JOIN courses c
ON a.course_id = c.course_id;

-- Intermediate
-- Show all enrollments with student name, course name,
-- enrollment date and status
SELECT s.full_name, c.course_name, e.enrollment_date, e.status
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id;

-- Intermediate
-- Show only active enrollments
SELECT s.full_name, c.course_name, e.enrollment_date, e.status
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE e.status = 'active';

-- Intermediate
-- Show attendance records with student, course,
-- session date, attended and minutes attended
SELECT s.full_name, c.course_name, a.session_date,
       a.attended, a.minutes_attended
FROM attendance a
JOIN enrollments e
ON a.enrollment_id = e.enrollment_id
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id;

-- Intermediate
-- Show submissions with student name,
-- assignment title, course name, score and status
SELECT s.full_name, ass.title, c.course_name,
       sub.score, sub.status
FROM submissions sub
JOIN students s
ON sub.student_id = s.student_id
JOIN assignments ass
ON sub.assignment_id = ass.assignment_id
JOIN courses c
ON ass.course_id = c.course_id;

-- Advanced
-- Count students enrolled in each course
SELECT c.course_name,
COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Advanced
-- Show students enrolled in more than one course
SELECT s.full_name,
COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING COUNT(e.course_id) > 1;

-- Advanced
-- Show average attendance minutes by course
SELECT c.course_name,
AVG(a.minutes_attended) AS average_minutes
FROM attendance a
JOIN enrollments e
ON a.enrollment_id = e.enrollment_id
JOIN courses c
ON e.course_id = c.course_id
GROUP BY c.course_name;

-- Advanced
-- Show average score by course
SELECT c.course_name,
AVG(sub.score) AS average_score
FROM submissions sub
JOIN assignments a
ON sub.assignment_id = a.assignment_id
JOIN courses c
ON a.course_id = c.course_id
GROUP BY c.course_name;

-- Advanced
-- Show missing or late submissions
-- with student and course context
SELECT s.full_name,
c.course_name,
a.title,
sub.status
FROM submissions sub
JOIN students s
ON sub.student_id = s.student_id
JOIN assignments a
ON sub.assignment_id = a.assignment_id
JOIN courses c
ON a.course_id = c.course_id
WHERE sub.status IN ('missing', 'late');

-- Advanced
-- Use LEFT JOIN to show students
-- with no enrollments
SELECT s.full_name,
e.course_id
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Advanced
-- Use LEFT JOIN to show assignments
-- with no submissions
SELECT a.title,
c.course_name
FROM assignments a
LEFT JOIN submissions s
ON a.assignment_id = s.assignment_id
JOIN courses c
ON a.course_id = c.course_id
WHERE s.submission_id IS NULL;