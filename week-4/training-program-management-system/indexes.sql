PRAGMA foreign_keys = ON;

-- Index 1
-- students(email)
--
-- Reason:
-- Email is UNIQUE and is commonly searched when looking
-- up a specific student.
--
-- Benefits:
-- SELECT * FROM students
-- WHERE email = 'ardit@gmail.com'

CREATE INDEX IF NOT EXISTS idx_students_email
ON students(email);


-- Index 2
-- enrollments(student_id)
--
-- Reason:
-- Frequently used in JOIN operations between
-- students and enrollments.
--
-- Benefits:
-- Student enrollment reports

CREATE INDEX IF NOT EXISTS idx_enrollments_student
ON enrollments(student_id);


-- Index 3
-- enrollments(program_id)
--
-- Reason:
-- Used when joining programs and enrollments.
--
-- Benefits:
-- Program summary reports

CREATE INDEX IF NOT EXISTS idx_enrollments_program
ON enrollments(program_id);


-- Index 4
-- attendance(student_id)
--
-- Reason:
-- Frequently used to calculate attendance summaries.
--
-- Benefits:
-- Attendance reports

CREATE INDEX IF NOT EXISTS idx_attendance_student
ON attendance(student_id);


-- Index 5
-- attendance(session_id)
--
-- Reason:
-- Used when retrieving attendance
-- for a specific training session.
--
-- Benefits:
-- Session attendance reports

CREATE INDEX IF NOT EXISTS idx_attendance_session
ON attendance(session_id);


-- Index 6
-- assignments(program_id)
--
-- Reason:
-- Used when finding assignments
-- belonging to a program.
--
-- Benefits:
-- Assignment reports

CREATE INDEX IF NOT EXISTS idx_assignments_program
ON assignments(program_id);


-- Index 7
-- submissions(student_id)
--
-- Reason:
-- Used in many reporting queries
-- and JOIN operations.
--
-- Benefits:
-- Student performance reports

CREATE INDEX IF NOT EXISTS idx_submissions_student
ON submissions(student_id);


-- Index 8
-- submissions(assignment_id)
--
-- Reason:
-- Used to retrieve submissions
-- for a specific assignment.
--
-- Benefits:
-- Assignment reports and grading

CREATE INDEX IF NOT EXISTS idx_submissions_assignment
ON submissions(assignment_id);


-- Index 9
-- feedback(submission_id)
--
-- Reason:
-- Used to quickly locate feedback
-- for a submission.
--
-- Benefits:
-- Feedback reports

CREATE INDEX IF NOT EXISTS idx_feedback_submission
ON feedback(submission_id);



SELECT
    name
FROM sqlite_master
WHERE type = 'index'
ORDER BY name;