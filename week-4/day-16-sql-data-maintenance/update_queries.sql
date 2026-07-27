
-- UPDATE 1
-- Correct incorrect student city
UPDATE students
SET city = 'Prishtina'
WHERE student_id = 4;

SELECT * FROM students
WHERE student_id = 4;

-- UPDATE 2 Correct student email


UPDATE students
SET email = 'arditKOLLA@email.com'
WHERE student_id = 2;

SELECT * FROM students
WHERE student_id = 2;

-- Update 3 Update program status.

UPDATE programs 
SET status = 'active';

SELECT * from programs;

-- Update 4 Change enrollment status to dropped. Do not delete the student. 

UPDATE enrollments 
SET status = 'dropped';

select * from enrollments;


-- Update 5 Change attendance status to present and add a note.

SELECT * FROM attendance
WHERE session_id = 3
AND student_id = 6;

UPDATE attendance
SET
    status = 'Present',
    notes = 'Attendance corrected after instructor review'
WHERE session_id = 3
AND student_id = 6;

SELECT * FROM attendance
WHERE session_id = 3


-- Update 6 Update score and feedback.


SELECT * FROM submissions
WHERE assignment_id = 2
AND student_id = 6;

UPDATE submissions
SET
    score = 82,
    feedback = 'Score updated after manual review'
WHERE assignment_id = 2
AND student_id = 6;

SELECT * FROM submissions
WHERE assignment_id = 2
AND student_id = 6;


-- Update 7 Normalize city values using UPDATE with condition.

SELECT student_id, first_name, city
FROM students
WHERE city IN ('Prishtine','Mitrovice');

UPDATE students
SET city = 'Prishtina'
WHERE city = 'Prishtine';

UPDATE students
SET city = 'Mitrovica'
WHERE city = 'Mitrovice';

SELECT student_id, first_name, city
FROM students
WHERE city IN ('Prishtina','Mitrovica');

