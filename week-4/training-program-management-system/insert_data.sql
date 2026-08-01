PRAGMA foreign_keys = ON;



INSERT INTO students 
(first_name, last_name, email, phone, city, status, created_at)
VALUES

('Ardit','Krasniqi','ardit@gmail.com','044111111','Prishtina','Active','2026-01-10'),

('Erina','Hoxha','erina@gmail.com','044222222','Vushtrri','Active','2026-01-11'),

('Luan','Berisha','luan@gmail.com','044333333','Mitrovica','Completed','2026-01-12'),

('Sara','Gashi','sara@gmail.com','044444444','Prishtina','Active','2026-01-15'),

('Dren','Rama','dren@gmail.com','044555555','Peja','Dropped','2026-01-20'),

('Elira','Kelmendi','elira@gmail.com','044666666','Gjilan','Active','2026-01-21'),

('Bleron','Shala','bleron@gmail.com','044777777','Prizren','Completed','2026-01-22'),

('Ariana','Mehmeti','ariana@gmail.com','044888888','Ferizaj','Active','2026-01-25'),

('Valon','Aliu','valon@gmail.com','044999999','Vushtrri','Inactive','2026-01-26'),

('Rina','Zeka','rina@gmail.com','044000000','Prishtina','Active','2026-01-28');




INSERT INTO programs
(program_name, program_type, start_date, end_date, status)
VALUES

('Data Engineering Bootcamp',
 'Technical Training',
 '2026-02-01',
 '2026-05-01',
 'Running'),

('AI Development Camp',
 'AI Training',
 '2026-03-01',
 '2026-06-01',
 'Running');


INSERT INTO staff
(first_name,last_name,email,role)
VALUES

('Andre','Chapman','andre@unitytechhub.com','Instructor'),

('Arben','Krasniqi','arben@unitytechhub.com','Mentor'),

('Diana','Smith','diana@unitytechhub.com','Support');



INSERT INTO program_staff
(program_id,staff_id)
VALUES

(1,1),
(1,2),
(1,3),
(2,1),
(2,2);



INSERT INTO enrollments
(student_id,program_id,enrollment_date,status)
VALUES

(1,1,'2026-02-02','Active'),
(2,1,'2026-02-02','Active'),
(3,1,'2026-02-03','Completed'),
(4,1,'2026-02-05','Active'),
(5,1,'2026-02-06','Dropped'),

(6,2,'2026-03-02','Active'),
(7,2,'2026-03-03','Completed'),
(8,2,'2026-03-04','Active'),
(9,2,'2026-03-05','Dropped'),
(10,2,'2026-03-06','Active');



INSERT INTO sessions
(program_id,session_title,session_date)
VALUES

(1,'Introduction to SQL','2026-02-10'),

(1,'Database Design','2026-02-17'),

(1,'Python Data Pipeline','2026-03-01'),

(2,'Introduction to AI','2026-03-10'),

(2,'Machine Learning Basics','2026-03-20');



INSERT INTO attendance
(student_id,session_id,attendance_status)
VALUES

(1,1,'Present'),
(2,1,'Late'),
(3,1,'Present'),
(4,1,'Absent'),

(1,2,'Present'),
(2,2,'Present'),
(3,2,'Excused'),
(4,2,'Present'),

(6,4,'Present'),
(7,4,'Present'),
(8,4,'Late'),
(10,4,'Absent'),

(6,5,'Present'),
(8,5,'Present');


INSERT INTO assignments
(program_id,assignment_title,due_date)
VALUES

(1,'SQL Database Project','2026-02-20'),

(1,'Python ETL Pipeline','2026-03-10'),

(1,'Data Cleaning Task','2026-03-20'),

(2,'AI Model Research','2026-04-01'),

(2,'Machine Learning Project','2026-04-20');



INSERT INTO submissions
(assignment_id,student_id,github_url,submitted_at,score,status)
VALUES

(1,1,'github.com/ardit/sql-project','2026-02-19',95,'Reviewed'),

(1,2,'github.com/erina/sql-project','2026-02-20',75,'Reviewed'),

(1,3,'github.com/luan/sql-project','2026-02-21',88,'Reviewed'),

(1,4,'github.com/sara/sql-project','2026-02-25',45,'Reviewed'),


(2,1,'github.com/ardit/python-pipeline','2026-03-09',90,'Reviewed'),

(2,2,'github.com/erina/python-pipeline','2026-03-11',60,'Reviewed'),

(2,4,'github.com/sara/python-pipeline','2026-03-15',NULL,'Missing'),


(4,6,'github.com/elira/ai-project','2026-04-02',85,'Reviewed'),

(4,7,'github.com/bleron/ai-project','2026-04-03',98,'Reviewed'),

(4,8,'github.com/ariana/ai-project','2026-04-04',55,'Submitted');




INSERT INTO feedback
(submission_id,reviewer_id,feedback_text,review_date)
VALUES

(1,1,'Excellent SQL structure and clean database design','2026-02-22'),

(2,2,'Good work but improve query optimization','2026-02-23'),

(5,1,'Strong ETL pipeline implementation','2026-03-12'),

(8,2,'Very good AI research project','2026-04-05');