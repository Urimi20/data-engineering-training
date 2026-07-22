PRAGMA foreign_keys = ON;

-- Invalid course instructor
INSERT INTO courses (course_name, level, instructor_id)
VALUES ('Machine Learning', 'Advanced', 999);

-- Invalid enrollment student
INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
VALUES (999, 1, '2026-07-23', 'active');

-- Invalid enrollment course
INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
VALUES (1, 999, '2026-07-23', 'active');

-- Duplicate enrollment
INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
VALUES (1, 1, '2026-07-23', 'active');

-- Invalid attendance enrollment
INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended)
VALUES (999, '2026-07-24', 1, 90);

-- Invalid attendance minutes
INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended)
VALUES (1, '2026-07-24', 1, -10);

-- Invalid course level
INSERT INTO courses (course_name, level, instructor_id)
VALUES ('AI Fundamentals', 'Expert', 1);

-- Invalid submission assignment
INSERT INTO submissions (assignment_id, student_id, submitted_at, score, status)
VALUES (999, 1, '2026-07-30', 90, 'submitted');

-- Invalid submission score
INSERT INTO submissions (assignment_id, student_id, submitted_at, score, status)
VALUES (1, 1, '2026-07-30', -5, 'submitted');

-- Duplicate email
INSERT INTO students (full_name, city, email, created_at)
VALUES ('Test Student', 'Prishtina', 'arta@gmail.com', '2026-07-23');