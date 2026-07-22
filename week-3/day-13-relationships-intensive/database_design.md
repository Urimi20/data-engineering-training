# Database Design

Students:
Stores student information.

Primary Key: student_id

One student can have many enrollments and many submissions.

---

Instructors:
Stores instructor information.

Primary Key: instructor_id

One instructor can teach many courses.

---

Courses:
Stores course information.

Primary Key: course_id

Foreign Key: instructor_id → instructors

One course belongs to one instructor and can have many enrollments and assignments.

---

Enrollments:
Connects students and courses.

Primary Key: enrollment_id

Foreign Keys:
- student_id → students
- course_id → courses

This is the bridge table.

---

Attendance:
Stores attendance records.

Primary Key: attendance_id

Foreign Key:
- enrollment_id → enrollments

---

Assignments:
Stores course assignments.

Primary Key: assignment_id

Foreign Key:
- course_id → courses

One course can have many assignments.

---

Submissions
Stores student assignment submissions.

Primary Key: submission_id

Foreign Keys:
- assignment_id → assignments
- student_id → students

---

Primary Keys:

- students → student_id
- instructors → instructor_id
- courses → course_id
- enrollments → enrollment_id
- attendance → attendance_id
- assignments → assignment_id
- submissions → submission_id

---

Foreign Keys:

- courses.instructor_id → instructors
- enrollments.student_id → students
- enrollments.course_id → courses
- attendance.enrollment_id → enrollments
- assignments.course_id → courses
- submissions.assignment_id → assignments
- submissions.student_id → students

---

One-to-Many Relationships :

- One instructor → many courses
- One course → many assignments
- One course → many enrollments
- One student → many enrollments
- One enrollment → many attendance records
- One assignment → many submissions

---

Many-to-Many Relationship:

Students ↔ Courses

Bridge table: enrollments

 Why should course_name not be stored in students?

A student can enroll in many courses. Storing the course name inside the students table would create duplicate data, make updates harder, and reduce data consistency.


