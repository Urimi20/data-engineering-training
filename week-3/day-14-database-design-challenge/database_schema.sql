PRAGMA foreign_keys = ON;

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT,
    city TEXT NOT NULL,
    birth_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE programs (
    program_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_name TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL,
    duration_months INTEGER NOT NULL CHECK(duration_months > 0),
    fee REAL NOT NULL CHECK(fee > 0),
    status TEXT NOT NULL
        CHECK(status IN ('Active','Inactive'))
);

CREATE TABLE instructors (
    instructor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    specialization TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT
);

CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    instructor_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Active','Completed','Dropped')),

    FOREIGN KEY(student_id)
        REFERENCES students(student_id),

    FOREIGN KEY(program_id)
        REFERENCES programs(program_id),

    FOREIGN KEY(instructor_id)
        REFERENCES instructors(instructor_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    session_date DATE NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('Present','Absent','Late')),

    FOREIGN KEY(enrollment_id)
        REFERENCES enrollments(enrollment_id)
);



CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    payment_month TEXT NOT NULL,
    amount REAL NOT NULL
        CHECK(amount > 0),
    payment_status TEXT NOT NULL
        CHECK(payment_status IN ('Paid','Pending','Overdue')),
    payment_date DATE,

    FOREIGN KEY(enrollment_id)
        REFERENCES enrollments(enrollment_id)
);

