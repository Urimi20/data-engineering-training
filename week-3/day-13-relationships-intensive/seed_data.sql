PRAGMA foreign_keys = ON;


INSERT INTO students (full_name, city, email, created_at) VALUES
('Arta Krasniqi','Vushtrri','arta@gmail.com','2026-07-23'),
('Blend Berisha','Prishtina','blend@gmail.com','2026-07-23'),
('Dren Gashi','Mitrovica','dren@gmail.com','2026-07-23'),
('Elira Hoxha','Peja','elira@gmail.com','2026-07-23'),
('Leart Rexha','Ferizaj','leart@gmail.com','2026-07-23'),
('Gresa Shala','Gjakova','gresa@gmail.com','2026-07-23'),
('Arber Kelmendi','Prizren','arber@gmail.com','2026-07-23'),
('Sara Mustafa','Gjilan','sara@gmail.com','2026-07-23');

SELECT * FROM students;


INSERT INTO instructors (full_name, specialization) VALUES
('Albin Berisha','SQL'),
('Mira Hoxha','Python'),
('Luan Gashi','Data Engineering');

SELECT * FROM instructors;


INSERT INTO courses (course_name, level, instructor_id) VALUES
('SQL','Beginner',1),
('Python','Intermediate',2),
('Databricks','Advanced',3),
('PySpark','Advanced',3),
('Data Modeling','Intermediate',1);

SELECT * FROM courses;


INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES
(1,1,'2026-07-23','active'),
(1,2,'2026-07-23','completed'),
(2,1,'2026-07-23','active'),
(2,3,'2026-07-23','active'),
(3,2,'2026-07-23','completed'),
(3,5,'2026-07-23','active'),
(4,4,'2026-07-23','active'),
(5,5,'2026-07-23','completed'),
(5,2,'2026-07-23','dropped'),
(6,1,'2026-07-23','active'),
(7,3,'2026-07-23','completed'),
(7,4,'2026-07-23','active');

SELECT * FROM enrollments;


INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended) VALUES
(1,'2026-07-24',1,90),
(1,'2026-07-25',1,85),
(2,'2026-07-24',1,88),
(2,'2026-07-25',0,0),
(3,'2026-07-24',1,92),
(4,'2026-07-24',1,75),
(5,'2026-07-24',1,80),
(6,'2026-07-24',0,0),
(7,'2026-07-24',1,95),
(8,'2026-07-24',1,70),
(9,'2026-07-24',0,0),
(10,'2026-07-24',1,89),
(11,'2026-07-24',1,91),
(12,'2026-07-24',1,87),
(3,'2026-07-26',1,90),
(5,'2026-07-26',1,84),
(8,'2026-07-26',0,0),
(12,'2026-07-26',1,93);

SELECT * FROM attendance;


INSERT INTO assignments (course_id, title, max_score, due_date) VALUES
(1,'SQL Basics',100,'2026-08-01'),
(1,'SQL JOINs',100,'2026-08-05'),
(2,'Python Functions',100,'2026-08-03'),
(3,'Databricks Notebook',100,'2026-08-07'),
(4,'PySpark DataFrame',100,'2026-08-10'),
(5,'ER Diagram',100,'2026-08-12');

SELECT * FROM assignments;


INSERT INTO submissions (assignment_id, student_id, submitted_at, score, status) VALUES
(1,1,'2026-07-30',95,'submitted'),
(2,1,'2026-08-05',90,'late'),
(1,2,'2026-07-31',88,'submitted'),
(4,2,'2026-08-06',91,'submitted'),
(3,3,'2026-08-02',97,'submitted'),
(6,3,NULL,0,'missing'),
(5,4,'2026-08-09',85,'submitted'),
(6,5,'2026-08-11',93,'submitted'),
(3,5,'2026-08-04',80,'late'),
(1,6,NULL,0,'missing'),
(4,7,'2026-08-07',89,'submitted'),
(5,7,'2026-08-11',92,'submitted');

SELECT * FROM submissions;