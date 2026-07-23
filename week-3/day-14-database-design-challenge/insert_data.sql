-- ===========================
-- INSERT STUDENTS
-- ===========================

INSERT INTO students 
(full_name, email, phone, city, birth_date)
VALUES
('Arta Krasniqi', 'arta.krasniqi@gmail.com', '044111111', 'Prishtina', '2003-05-14'),
('Blend Gashi', 'blend.gashi@gmail.com', '044222222', 'Vushtrri', '2002-11-20'),
('Dren Berisha', 'dren.berisha@gmail.com', '044333333', 'Mitrovica', '2001-08-09'),
('Elira Shala', 'elira.shala@gmail.com', '044444444', 'Peja', '2004-01-17'),
('Leart Hoxha', 'leart.hoxha@gmail.com', '044555555', 'Ferizaj', '2003-09-30'),
('Gresa Kelmendi', 'gresa.kelmendi@gmail.com', '044666666', 'Gjakova', '2002-04-22'),
('Arber Maliqi', 'arber.maliqi@gmail.com', '044777777', 'Prizren', '2001-12-12'),
('Sara Rexhepi', 'sara.rexhepi@gmail.com', '044888888', 'Gjilan', '2003-07-05'),
('Besa Mustafa', 'besa.mustafa@gmail.com', '044999999', 'Podujeva', '2004-03-18'),
('Luan Mehmeti', 'luan.mehmeti@gmail.com', '044123456', 'Fushe Kosove', '2002-10-25');


-- ===========================
-- INSERT PROGRAMS
-- ===========================

INSERT INTO programs
(program_name, category, duration_months, fee, status)
VALUES
('Full Stack Development', 'Software Development', 6, 1200, 'Active'),
('Data Engineering', 'Data & AI', 5, 1000, 'Active'),
('English Language', 'Languages', 4, 600, 'Active'),
('After School Coding', 'Kids Education', 3, 450, 'Inactive');




INSERT INTO instructors
(full_name, specialization, email, phone)
VALUES
('Albin Hoxha', 'Full Stack Development', 'albin.hoxha@unityhub.com', '044101101'),
('Arta Gashi', 'Data Engineering', 'arta.gashi@unityhub.com', '044202202'),
('Florian Berisha', 'English Language', 'florian.berisha@unityhub.com', '044303303');




INSERT INTO enrollments
(student_id, program_id, instructor_id, enrollment_date, status)
VALUES
(1,1,1,'2026-01-10','Active'),
(1,2,2,'2026-02-15','Completed'),
(2,2,2,'2026-01-12','Active'),
(3,2,2,'2026-01-18','Completed'),
(4,1,1,'2026-02-05','Dropped'),
(5,2,2,'2026-02-10','Active'),
(6,3,3,'2026-03-01','Completed'),
(7,2,2,'2026-03-05','Active'),
(8,1,1,'2026-03-12','Completed'),
(9,2,2,'2026-03-20','Active'),
(10,3,3,'2026-04-01','Dropped'),
(5,1,1,'2026-04-10','Active'),
(6,2,2,'2026-04-15','Completed'),
(8,2,2,'2026-05-01','Active');




INSERT INTO attendance
(enrollment_id, session_date, status)
VALUES
(1,'2026-01-15','Present'),
(1,'2026-01-22','Present'),
(1,'2026-01-29','Present'),

(2,'2026-02-20','Present'),
(2,'2026-02-27','Late'),

(3,'2026-01-18','Present'),
(3,'2026-01-25','Absent'),

(4,'2026-01-20','Present'),
(4,'2026-01-27','Present'),

(5,'2026-02-10','Absent'),
(5,'2026-02-17','Absent'),

(6,'2026-02-15','Present'),
(6,'2026-02-22','Present'),

(7,'2026-03-05','Present'),
(7,'2026-03-12','Late'),

(8,'2026-03-10','Present'),
(8,'2026-03-17','Present'),

(9,'2026-03-15','Present'),
(9,'2026-03-22','Absent'),

(10,'2026-03-25','Present'),
(10,'2026-04-01','Late'),

(11,'2026-04-05','Absent'),
(11,'2026-04-12','Absent'),

(12,'2026-04-15','Present'),
(12,'2026-04-22','Present'),

(13,'2026-04-20','Present'),
(13,'2026-04-27','Late'),

(14,'2026-05-05','Present'),
(14,'2026-05-12','Present');



INSERT INTO payments
(enrollment_id, payment_month, amount, payment_status, payment_date)
VALUES
(1,'2026-01',200,'Paid','2026-01-10'),
(2,'2026-02',200,'Paid','2026-02-10'),
(3,'2026-01',180,'Pending',NULL),
(4,'2026-01',180,'Paid','2026-01-15'),
(5,'2026-02',200,'Overdue',NULL),
(6,'2026-02',150,'Paid','2026-02-20'),
(7,'2026-03',150,'Paid','2026-03-10'),
(8,'2026-03',180,'Pending',NULL),
(9,'2026-03',200,'Paid','2026-03-18'),
(10,'2026-04',150,'Overdue',NULL),
(11,'2026-04',150,'Pending',NULL),
(12,'2026-04',200,'Paid','2026-04-15'),
(13,'2026-05',180,'Paid','2026-05-08'),
(14,'2026-02',200,'Paid','2026-02-10');