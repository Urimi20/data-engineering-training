PRAGMA foreign_keys = ON;



DROP TABLE IF EXISTS feedback;
DROP TABLE IF EXISTS submissions;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS program_staff;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS students;


CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT,
    city TEXT NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Active','Inactive','Dropped','Completed')),
    created_at DATE NOT NULL
);



CREATE TABLE programs (
    program_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_name TEXT NOT NULL,
    program_type TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Planned','Running','Completed'))
);


CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL
        CHECK(role IN ('Instructor','Mentor','Support'))
);


CREATE TABLE program_staff (
    program_staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,

    UNIQUE(program_id, staff_id),

    FOREIGN KEY(program_id)
        REFERENCES programs(program_id),

    FOREIGN KEY(staff_id)
        REFERENCES staff(staff_id)
);


CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,

    status TEXT NOT NULL
        CHECK(status IN ('Active','Completed','Dropped')),

    UNIQUE(student_id, program_id),

    FOREIGN KEY(student_id)
        REFERENCES students(student_id),

    FOREIGN KEY(program_id)
        REFERENCES programs(program_id)
);


CREATE TABLE sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id INTEGER NOT NULL,
    session_title TEXT NOT NULL,
    session_date DATE NOT NULL,

    FOREIGN KEY(program_id)
        REFERENCES programs(program_id)
);


CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    session_id INTEGER NOT NULL,

    attendance_status TEXT NOT NULL
        CHECK(attendance_status IN
        ('Present','Absent','Late','Excused')),

    UNIQUE(student_id, session_id),

    FOREIGN KEY(student_id)
        REFERENCES students(student_id),

    FOREIGN KEY(session_id)
        REFERENCES sessions(session_id)
);


CREATE TABLE assignments (
    assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id INTEGER NOT NULL,
    assignment_title TEXT NOT NULL,
    due_date DATE NOT NULL,

    FOREIGN KEY(program_id)
        REFERENCES programs(program_id)
);



CREATE TABLE submissions (
    submission_id INTEGER PRIMARY KEY AUTOINCREMENT,
    assignment_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,

    github_url TEXT NOT NULL,
    submitted_at DATE,

    score INTEGER
        CHECK(score BETWEEN 0 AND 100),

    status TEXT NOT NULL
        CHECK(status IN ('Submitted','Reviewed','Missing')),

    UNIQUE(student_id, assignment_id),

    FOREIGN KEY(assignment_id)
        REFERENCES assignments(assignment_id),

    FOREIGN KEY(student_id)
        REFERENCES students(student_id)
);



CREATE TABLE feedback (
    feedback_id INTEGER PRIMARY KEY autoincrement,

    submission_id INTEGER NOT NULL,
    reviewer_id INTEGER NOT NULL,

    feedback_text TEXT, 

    review_date DATE,

    FOREIGN KEY(submission_id)
        REFERENCES submissions(submission_id),

    FOREIGN KEY(reviewer_id)
        REFERENCES staff(staff_id)
);

