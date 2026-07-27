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
            CHECK(status IN ('planned','active','completed'))
    );


    CREATE TABLE enrollments (
        enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        program_id INTEGER NOT NULL,
        enrollment_date DATE NOT NULL,
        status TEXT NOT NULL
            CHECK(status IN ('active','dropped','completed')),
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
        max_points INTEGER NOT NULL CHECK(max_points > 0),
        FOREIGN KEY(program_id) REFERENCES programs(program_id)
    );


    CREATE TABLE submissions (
        submission_id INTEGER PRIMARY KEY AUTOINCREMENT,
        assignment_id INTEGER NOT NULL,
        student_id INTEGER NOT NULL,
        github_link TEXT,
        submitted_at DATE NOT NULL,
        score INTEGER CHECK(score BETWEEN 0 AND 100),
        feedback TEXT,
        FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id),
        FOREIGN KEY(student_id) REFERENCES students(student_id)
    );


INSERT INTO students(first_name,last_name,email,city,created_at) VALUES
('Urim','Avdiu','urim@email.com','Vushtrri','2026-07-01'),
('Ardit','Hoxha','ardit@email.com','Prishtina','2026-07-01'),
('Sara','Berisha','sara@email.com','Peja','2026-07-02'),
('Lina','Krasniqi','lina@email.com','Prishtine','2026-07-02'),
('Albin','Gashi','albin@email.com','Gjilan','2026-07-03'),
('Era','Mustafa','era@email.com','Mitrovice','2026-07-03');



INSERT INTO programs(
program_name,
program_type,
start_date,
end_date,
status
)
VALUES
(
'Data Engineering Bootcamp',
'Full Time',
'2026-07-01',
'2026-08-30',
'planned'
);


INSERT INTO enrollments(
student_id,
program_id,
enrollment_date,
status
)
VALUES
(1,1,'2026-07-01','active'),
(2,1,'2026-07-01','active'),
(3,1,'2026-07-01','active'),
(4,1,'2026-07-01','active'),
(5,1,'2026-07-01','active'),
(6,1,'2026-07-01','active');


INSERT INTO sessions(
program_id,
session_title,
session_date,
session_number,
topic
)
VALUES
(1,'SQL Basics','2026-07-02',1,'SELECT'),
(1,'SQL Joins','2026-07-03',2,'JOIN'),
(1,'SQL Maintenance','2026-07-04',3,'UPDATE & DELETE');



INSERT INTO attendance(
session_id,
student_id,
status,
notes
)
VALUES
(1,1,'Present',NULL),
(1,2,'Present',NULL),
(1,3,'Absent','Sick'),
(1,4,'Late','Traffic'),
(1,5,'Present',NULL),
(1,6,'Present',NULL),

(2,1,'Present',NULL),
(2,2,'Present',NULL),
(2,3,'Present',NULL),
(2,4,'Present',NULL),
(2,5,'Absent','Family'),
(2,6,'Present',NULL),

(3,1,'Present',NULL),
(3,2,'Present',NULL),
(3,3,'Late','Late bus'),
(3,4,'Present',NULL),
(3,5,'Present',NULL),
(3,6,'Absent','Medical');



INSERT INTO assignments(
program_id,
title,
day_number,
due_date,
max_points
)
VALUES
(1,'SQL Practice',14,'2026-07-15',100),
(1,'JOIN Challenge',15,'2026-07-16',100),
(1,'Maintenance Queries',16,'2026-07-17',100);


INSERT INTO submissions(
assignment_id,
student_id,
github_link,
submitted_at,
score,
feedback
)
VALUES

(1,1,'https://github.com/urim/sql1','2026-07-15',95,'Excellent'),

(1,2,'https://github.com/ardit/sql1','2026-07-15',88,NULL),

(1,3,'https://github.com/sara/sql1','2026-07-15',90,'Very Good'),

(1,4,'https://github.com/lina/sql1','2026-07-15',76,NULL),

(1,5,'https://github.com/albin/sql1','2026-07-15',84,'Good'),

(2,1,'https://github.com/urim/join','2026-07-16',98,'Outstanding'),

(2,2,'https://github.com/ardit/join','2026-07-16',82,NULL),

(2,3,'https://github.com/sara/join','2026-07-16',91,'Great'),

(2,5,'https://github.com/albin/join','2026-07-16',80,NULL),

(2,6,'https://github.com/era/join','2026-07-16',75,'Needs Improvement'),

(3,1,'https://github.com/urim/day16','2026-07-17',96,'Excellent'),

(3,2,'https://github.com/ardit/day16','2026-07-17',89,NULL);

