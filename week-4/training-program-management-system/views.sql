PRAGMA foreign_keys = ON;


-- 1. Student Program Overview

DROP VIEW IF EXISTS student_program_overview;

CREATE VIEW student_program_overview AS

SELECT

    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    p.program_name,
    e.status AS enrollment_status,
    e.enrollment_date 

FROM students s

JOIN enrollments e
ON s.student_id = e.student_id

JOIN programs p
ON e.program_id = p.program_id;



-- 2. Student Submission Overview

DROP VIEW IF EXISTS student_submission_overview;

CREATE VIEW student_submission_overview AS

SELECT

    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    a.assignment_title,
    sub.score,
    sub.status,
    sub.github_url

FROM submissions sub

JOIN students s
ON sub.student_id = s.student_id

JOIN assignments a
ON sub.assignment_id = a.assignment_id;



-- 3. Student Attendance Summary

DROP VIEW IF EXISTS student_attendance_summary;

CREATE VIEW student_attendance_summary AS

SELECT

    s.student_id,

    s.first_name || ' ' || s.last_name AS student_name,

    COUNT(att.attendance_id) AS total_sessions,

    SUM(
        CASE
            WHEN att.attendance_status='Present'
            THEN 1
            ELSE 0
        END
    ) AS present,

    SUM(
        CASE
            WHEN att.attendance_status='Absent'
            THEN 1
            ELSE 0
        END
    ) AS absent,

    SUM(
        CASE
            WHEN att.attendance_status='Late'
            THEN 1
            ELSE 0
        END
    ) AS late,

    SUM(
        CASE
            WHEN att.attendance_status='Excused'
            THEN 1
            ELSE 0
        END
    ) AS excused

FROM students s

LEFT JOIN attendance att
ON s.student_id = att.student_id

GROUP BY s.student_id;



-- 4. Student Risk Analysis

DROP VIEW IF EXISTS student_risk_analysis;

CREATE VIEW student_risk_analysis AS

SELECT

    s.student_id,

    s.first_name || ' ' || s.last_name AS student_name,

    ROUND(COALESCE(AVG(sub.score),0),2) AS average_score,

    SUM(
        CASE
            WHEN att.attendance_status='Absent'
            THEN 1
            ELSE 0
        END
    ) AS absences,

    CASE

        WHEN AVG(sub.score) < 70
             OR
             SUM(
                CASE
                    WHEN att.attendance_status='Absent'
                    THEN 1
                    ELSE 0
                END
             ) >= 2

        THEN 'Needs Support'

        ELSE 'On Track'

    END AS risk_level

FROM students s

LEFT JOIN submissions sub
ON s.student_id = sub.student_id

LEFT JOIN attendance att
ON s.student_id = att.student_id

GROUP BY s.student_id;



-- 5. Management Dashboard

DROP VIEW IF EXISTS management_dashboard;

CREATE VIEW management_dashboard AS

SELECT

    p.program_name,

    COUNT(DISTINCT e.student_id) AS total_students,

    COUNT(DISTINCT se.session_id) AS total_sessions,

    COUNT(DISTINCT a.assignment_id) AS total_assignments,

    COUNT(DISTINCT sub.submission_id) AS total_submissions,

    ROUND(COALESCE(AVG(sub.score),0),2) AS average_score,

    SUM(
        CASE
            WHEN att.attendance_status='Absent'
            THEN 1
            ELSE 0
        END
    ) AS total_absences

FROM programs p

LEFT JOIN enrollments e
ON p.program_id = e.program_id

LEFT JOIN sessions se
ON p.program_id = se.program_id

LEFT JOIN assignments a
ON p.program_id = a.program_id

LEFT JOIN submissions sub
ON a.assignment_id = sub.assignment_id

LEFT JOIN attendance att
ON e.student_id = att.student_id

GROUP BY p.program_id;