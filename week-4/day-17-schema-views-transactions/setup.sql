PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS submissions;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS programs;


CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    city TEXT NOT NULL,
    created_at DATE NOT NULL
);

CREATE TABLE programs (
    program_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_name TEXT NOT NULL,
    program_type TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Planned','Active','Completed'))
);

CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Active','Completed','Dropped')),
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(program_id) REFERENCES programs(program_id)
);

CREATE TABLE sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id INTEGER NOT NULL,
    session_title TEXT NOT NULL,
    session_date DATE NOT NULL,
    session_number INTEGER NOT NULL,
    topic TEXT NOT NULL,
    FOREIGN KEY(program_id) REFERENCES programs(program_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Present','Absent','Late')),
    notes TEXT,
    FOREIGN KEY(session_id) REFERENCES sessions(session_id),
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);

CREATE TABLE assignments (
    assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    day_number INTEGER NOT NULL,
    due_date DATE NOT NULL,
    max_points INTEGER NOT NULL
        CHECK(max_points > 0),
    FOREIGN KEY(program_id) REFERENCES programs(program_id)
);

CREATE TABLE submissions (
    submission_id INTEGER PRIMARY KEY AUTOINCREMENT,
    assignment_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    github_link TEXT,
    submitted_at DATE NOT NULL,
    score INTEGER
        CHECK(score BETWEEN 0 AND 100),
    feedback TEXT,
    FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id),
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);



INSERT INTO programs
(program_name, program_type, start_date, end_date, status)
VALUES
('Data Engineering Bootcamp',
 'Full-Time',
 '2026-07-01',
 '2026-09-30',
 'Active');


INSERT INTO students
(first_name,last_name,email,city,created_at)
VALUES
('Arta','Berisha','arta@email.com','Vushtrri','2026-07-01'),
('Blend','Krasniqi','blend@email.com','Prishtina','2026-07-01'),
('Dren','Hasani','dren@email.com','Mitrovica','2026-07-02'),
('Elira','Gashi','elira@email.com','Peja','2026-07-02'),
('Leart','Rama','leart@email.com','Ferizaj','2026-07-03'),
('Gresa','Shala','gresa@email.com','Gjakova','2026-07-03');



INSERT INTO enrollments
(student_id,program_id,enrollment_date,status)
VALUES
(1,1,'2026-07-01','Active'),
(2,1,'2026-07-01','Active'),
(3,1,'2026-07-01','Active'),
(4,1,'2026-07-01','Active'),
(5,1,'2026-07-01','Active'),
(6,1,'2026-07-01','Active');


INSERT INTO sessions
(program_id,session_title,session_date,session_number,topic)
VALUES
(1,'Introduction to SQL','2026-07-02',1,'SQL Basics'),
(1,'Joins and Relationships','2026-07-03',2,'JOIN Operations'),
(1,'Data Cleaning','2026-07-04',3,'SQL Data Cleaning'),
(1,'Views and Transactions','2026-07-05',4,'Schema Evolution');



INSERT INTO attendance
(session_id,student_id,status,notes)
VALUES
(1,1,'Present',''),
(1,2,'Present',''),
(1,3,'Late','Traffic'),
(1,4,'Present',''),
(1,5,'Absent','Sick'),
(1,6,'Present',''),

(2,1,'Present',''),
(2,2,'Present',''),
(2,3,'Present',''),
(2,4,'Absent','Family emergency'),
(2,5,'Present',''),
(2,6,'Present',''),

(3,1,'Present',''),
(3,2,'Late',''),
(3,3,'Present',''),
(3,4,'Present',''),
(3,5,'Present',''),
(3,6,'Absent',''),

(4,1,'Present',''),
(4,2,'Present',''),
(4,3,'Present',''),
(4,4,'Present',''),
(4,5,'Late',''),
(4,6,'Present','');



INSERT INTO assignments
(program_id,title,day_number,due_date,max_points)
VALUES
(1,'SQL Basics Homework',1,'2026-07-03',100),
(1,'JOIN Practice',2,'2026-07-04',100),
(1,'Data Cleaning Challenge',3,'2026-07-05',100),
(1,'Views and Transactions Lab',4,'2026-07-06',100);



INSERT INTO submissions
(assignment_id,student_id,github_link,submitted_at,score,feedback)
VALUES
(1,1,'https://github.com/arta/sql-homework','2026-07-03',98,'Excellent work'),
(1,2,'https://github.com/blend/sql-homework','2026-07-03',90,'Good job'),
(1,3,'https://github.com/dren/sql-homework','2026-07-03',85,NULL),
(2,1,'https://github.com/arta/join-practice','2026-07-04',97,'Very clean solution'),
(2,4,'https://github.com/elira/join-practice','2026-07-04',88,NULL),
(2,5,'https://github.com/leart/join-practice','2026-07-04',80,'Needs more comments'),
(3,2,'https://github.com/blend/data-cleaning','2026-07-05',94,'Well done'),
(3,6,'https://github.com/gresa/data-cleaning','2026-07-05',91,NULL),
(4,1,'https://github.com/arta/views-lab','2026-07-06',100,'Perfect'),
(4,3,'https://github.com/dren/views-lab','2026-07-06',89,NULL);



SELECT * FROM students;
SELECT * FROM programs;
SELECT * FROM enrollments;
SELECT * FROM sessions;
SELECT * FROM attendance;
SELECT * FROM assignments;
SELECT * FROM submissions;