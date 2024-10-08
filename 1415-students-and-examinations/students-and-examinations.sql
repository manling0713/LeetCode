# Write your MySQL query statement below
SELECT st.student_id, student_name, su.subject_name
    , COUNT(e.student_id) AS attended_exams
FROM Students AS st
CROSS JOIN Subjects AS su
LEFT JOIN Examinations e
ON st.student_id = e.student_id AND su.subject_name = e.subject_name
GROUP BY st.student_id, su.subject_name
ORDER BY st.student_id, su.subject_name