Database Design Plan:

Project Goal

The goal of this database is to manage a training center system for Unity Tech Hub. The database stores information about students, training programs, instructors, enrollments, attendance, and payments. It is designed to support daily operations while providing accurate business reports for management. The system helps track student progress, attendance, payment status, and overall program performance.

Tables:

Students
Purpose:
Stores personal and contact information about every student.

Main columns:

- student_id
- full_name
- email
- phone
- city
- birth_date
- created_at

---

Programs
Purpose:
Stores all training programs offered by the training center.

Main columns:

- program_id
- program_name
- category
- duration_months
- fee
- status

---

Instructors

Purpose:
Stores information about instructors responsible for teaching programs.

Main columns:

- instructor_id
- full_name
- specialization
- email
- phone

---

Enrollments

Purpose:
Connects students with programs and instructors while tracking enrollment status.

Main columns:

- enrollment_id
- student_id
- program_id
- instructor_id
- enrollment_date
- status

---

Attendance

Purpose:
Stores attendance records for every enrolled student.

Main columns:

- attendance_id
- enrollment_id
- session_date
- status

---

Payments

Purpose:
Stores monthly payment information for each enrollment.

Main columns:

- payment_id
- enrollment_id
- payment_month
- amount
- payment_status
- payment_date

---

 Primary Keys for tables:

 Table        Primary Key   
 -----------  ------------- 
Students   -  student_id    
Programs    - program_id    
Instructors - instructor_id 
Enrollments - enrollment_id 
Attendance -  attendance_id 
Payments   -  payment_id    

Each primary key uses **INTEGER PRIMARY KEY AUTOINCREMENT** to ensure every record has a unique identifier.

---

# Foreign Keys

- Child Table - Foreign Key   - References                 
----------- - ------------- - -------------------------- 
Enrollments - student_id    - Students(student_id)       
Enrollments - program_id    - Programs(program_id)       
Enrollments - instructor_id - Instructors(instructor_id) 
Attendance  - enrollment_id - Enrollments(enrollment_id) 
Payments    - enrollment_id - Enrollments(enrollment_id) 

These foreign keys enforce referential integrity and prevent orphan records.

---

# Relationship Types

Students → Enrollments

**One-to-Many**

One student can have multiple enrollments, but each enrollment belongs to only one student.

---

### Programs → Enrollments

**One-to-Many**

One program can have many enrolled students.

---

### Instructors → Enrollments

**One-to-Many**

One instructor can teach many enrollments.

---

### Enrollments → Attendance

**One-to-Many**

Each enrollment can have many attendance records, one for each class session.

---

### Enrollments → Payments

**One-to-Many**

Each enrollment can have multiple monthly payments.

---

### Students ↔ Programs

**Many-to-Many**

Students can enroll in multiple programs, and each program can have many students. This relationship is implemented through the **Enrollments** table.
