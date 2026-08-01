PRAGMA foreign_keys = ON;
-- TEST 1


INSERT INTO students
(first_name,last_name,email,phone,city,status,created_at)
VALUES
(
'Test',
'Duplicate',
'ardit@gmail.com',
'040000000',
'Prishtina',
'Active',
'2026-05-01'
);



-- TEST 2

INSERT INTO attendance
(student_id,session_id,attendance_status)
VALUES
(
1,
1,
'Present'
);



-- TEST 3


INSERT INTO submissions
(
assignment_id,
student_id,
github_url,
submitted_at,
score,
status
)
VALUES
(
1,
1,
'github.com/test/duplicate',
'2026-05-01',
80,
'Submitted'
);



-- TEST 4


INSERT INTO submissions
(
assignment_id,
student_id,
github_url,
submitted_at,
score,
status
)
VALUES
(
3,
6,
'github.com/test/high-score',
'2026-05-01',
150,
'Reviewed'
);



-- TEST 5

INSERT INTO submissions
(
assignment_id,
student_id,
github_url,
submitted_at,
score,
status
)
VALUES
(
3,
8,
'github.com/test/negative-score',
'2026-05-01',
-20,
'Reviewed'
);



-- TEST 6

INSERT INTO attendance
(
student_id,
session_id,
attendance_status
)
VALUES
(
2,
3,
'Unknown'
);



-- TEST 7

INSERT INTO submissions
(
assignment_id,
student_id,
github_url,
submitted_at,
score,
status
)
VALUES
(
1,
999,
'github.com/test/wrong-student',
'2026-05-01',
70,
'Submitted'
);



-- TEST 8

INSERT INTO submissions
(
assignment_id,
student_id,
github_url,
submitted_at,
score,
status
)
VALUES
(
999,
1,
'github.com/test/wrong-assignment',
'2026-05-01',
70,
'Submitted'
);



-- TEST 9

INSERT INTO attendance
(
student_id,
session_id,
attendance_status
)
VALUES
(
1,
999,
'Present'
);



-- TEST 10

INSERT INTO students
(
first_name,
last_name,
email,
phone,
city,
status,
created_at
)
VALUES
(
'Invalid',
'Status',
'invalid@test.com',
'040000000',
'Prishtina',
'Unknown',
'2026-05-01'
);