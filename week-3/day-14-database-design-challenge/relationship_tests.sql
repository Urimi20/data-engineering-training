PRAGMA foreign_keys = ON;


-- RELATIONSHIP AND CONSTRAINT TESTS


-- TEST 1:
-- Insert enrollment with a student ID that does not exist
-- Expected: FAIL
-- Reason:
-- student_id must exist in the students table.
-- The foreign key enforces this relationship.

INSERT INTO enrollments
(student_id, program_id, instructor_id, enrollment_date, status)
VALUES
(202, 1, 1, '2026-06-01', 'Active');

-- TEST 2:
-- Insert enrollment with a program ID that does not exist
-- Expected: FAIL
-- Reason:
-- program_id must exist in the programs table.

INSERT INTO enrollments
(student_id, program_id, instructor_id, enrollment_date, status)
VALUES
(1, 87, 1, '2026-06-01', 'Active')


-- TEST 3:
-- Insert attendance for enrollment ID that does not exist
-- Expected: FAIL
-- Reason:
-- attendance must be linked to a real enrollment.

INSERT INTO attendance
(enrollment_id, session_date, status)
VALUES
(67, '2026-06-01', 'Present');

-- TEST 4:
-- Insert payment for an enrollment ID that does not exist
-- Expected: FAIL
-- Reason:
-- The payment must be associated with an existing enrollment.

insert into payments(enrollment_id,payment_month,amount,payment_status, payment_date) 
values 
(191 , '2026-06', 200 , 'Paid' , '2026-06-01' );



-- TEST 5:
-- Insert student with duplicate email
-- Expected: FAIL
-- Reason:
-- The email column has a UNIQUE constraint.
-- Two students with the same email are not allowed.

INSERT INTO students 
(full_name, email, phone, city, birth_date)
VALUES
('Amar Shabani', 'arta.krasniqi@gmail.com', '044111111', 'Prishtina', '2003-05-14')

-- TEST 6:
-- Insert payment with negative amount
-- Expected: FAIL
-- Reason:
-- amount ka CHECK(amount > 0).
-- negative amount are not allowed

INSERT INTO payments
(enrollment_id, payment_month, amount, payment_status, payment_date)
VALUES
(15,'2026-01',0,'Paid','2026-01-10')

-- TEST 7:
-- Insert invalid enrollment status
-- Expected: FAIL
-- Reason:
-- status allows only:
-- Active, Completed, Dropped

INSERT INTO enrollments
(student_id, program_id, instructor_id, enrollment_date, status)
VALUES
(1, 1, 1, '2026-06-01', 'Cancelled');