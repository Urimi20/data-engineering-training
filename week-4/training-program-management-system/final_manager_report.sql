PRAGMA foreign_keys = ON;

/*
Business Logic

Attendance Rate
= Present Sessions / Total Attendance Records * 100

Final Status

Average >= 85
AND Attendance >= 80%
AND Missing Submissions = 0
----------------------------
Excellent

Average >= 70
----------------------------
Good Progress

Average < 70
----------------------------
Needs Improvement

No submissions
----------------------------
Not Enough Data


Recommended Next Action

Excellent
-> Invite to Next Phase

Good Progress
-> Schedule Live Coding Check

Needs Improvement
-> Needs Extra Practice

Missing submissions >=2
-> Follow Up Individually

No submissions
-> Not Enough Data
*/


SELECT

    s.first_name  AS student_name,

    p.program_name,


    -- Attendance Rate

    ROUND(

        100.0 *

        SUM(
            CASE
                WHEN att.attendance_status='Present'
                THEN 1
                ELSE 0
            END
        )

        /

        COALESCE(
            NULLIF(COUNT(att.attendance_id),0),
            1
        )

    ,2)

    AS attendance_rate,


    -- Average Score

    ROUND(

        COALESCE(AVG(sub.score),0)

    ,2)

    AS average_score,


    -- Missing Submissions

    COUNT(DISTINCT a.assignment_id)

    -

    COUNT(DISTINCT sub.submission_id)

    AS missing_submissions,


    -- Missing Feedback

    COUNT(DISTINCT sub.submission_id)

    -

    COUNT(DISTINCT f.feedback_id)

    AS missing_feedback,


    -- Readiness Score

    CASE

        WHEN AVG(sub.score)>=85 THEN 'Ready'

        WHEN AVG(sub.score)>=70 THEN 'Almost Ready'

        WHEN AVG(sub.score) IS NULL THEN 'Unknown'

        ELSE 'Needs Improvement'

    END

    AS readiness,


    -- Final Status

    CASE

        WHEN AVG(sub.score) IS NULL
        THEN 'Not Enough Data'

        WHEN

            AVG(sub.score)>=85

            AND

            (
                100.0 *

                SUM(
                    CASE
                    WHEN att.attendance_status='Present'
                    THEN 1
                    ELSE 0
                    END
                )

                /

                COALESCE(
                    NULLIF(COUNT(att.attendance_id),0),
                    1
                )

            )>=80

            AND

            COUNT(DISTINCT a.assignment_id)
            -
            COUNT(DISTINCT sub.submission_id)=0

        THEN 'Excellent'

        WHEN AVG(sub.score)>=70

        THEN 'Good Progress'

        ELSE 'Needs Improvement'

    END

    AS final_status,


    -- Recommended Action

    CASE

        WHEN AVG(sub.score) IS NULL

        THEN 'Not Enough Data'

        WHEN

            COUNT(DISTINCT a.assignment_id)
            -
            COUNT(DISTINCT sub.submission_id)>=2

        THEN 'Follow Up Individually'

        WHEN AVG(sub.score)>=85

        THEN 'Invite to Next Phase'

        WHEN AVG(sub.score)>=70

        THEN 'Schedule Live Coding Check'

        ELSE

        'Needs Extra Practice'

    END

    AS recommended_next_action


FROM students s

LEFT JOIN enrollments e

ON s.student_id=e.student_id

LEFT JOIN programs p

ON e.program_id=p.program_id

LEFT JOIN attendance att

ON s.student_id=att.student_id

LEFT JOIN assignments a

ON p.program_id=a.program_id

LEFT JOIN submissions sub

ON sub.student_id=s.student_id
AND sub.assignment_id=a.assignment_id

LEFT JOIN feedback f

ON sub.submission_id=f.submission_id


GROUP BY

s.student_id,
p.program_id

ORDER BY

average_score DESC,
attendance_rate DESC;