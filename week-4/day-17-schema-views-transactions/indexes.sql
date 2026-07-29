PRAGMA foreign_keys = ON;

-- Index 1: submissions.student_id

-- Helps find all submissions made by a specific student.
-- Useful when generating student reports or checking progress.

CREATE INDEX idx_submissions_student_id
ON submissions(student_id);


-- Index 2: submissions.assignment_id

-- Helps quickly find all submissions for a specific assignment.
-- Useful when teachers review one assignment from many students.

CREATE INDEX idx_submissions_assignment_id
ON submissions(assignment_id);


-- Index 3: attendance.session_id

-- Helps find attendance records for a specific session.
-- Useful when checking who attended a training session.

CREATE INDEX idx_attendance_session_id
ON attendance(session_id);


-- Index 4: attendance.student_id

-- Helps find all attendance records of one student.
-- Useful for attendance reports and student performance tracking.

CREATE INDEX idx_attendance_student_id
ON attendance(student_id);


-- Index 5: enrollments.program_id

-- Helps find all students enrolled in a specific program.
-- Useful when managers need program-level reports.

CREATE INDEX idx_enrollments_program_id
ON enrollments(program_id);


-- Verify indexes

SELECT name
FROM sqlite_master
WHERE type = 'index';