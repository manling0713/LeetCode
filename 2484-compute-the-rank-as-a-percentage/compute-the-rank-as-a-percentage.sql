# Write your MySQL query statement below
WITH student_rank AS(
    SELECT student_id
        , department_id
        , RANK() OVER(PARTITION BY department_id ORDER BY mark DESC) AS student_rank_in_the_department 
    FROM Students
), student_cnt AS(
    SELECT department_id
        , COUNT(student_id) AS the_number_of_students_in_the_department
    FROM Students
    GROUP BY department_id
)

SELECT student_id
    , r.department_id
    , ROUND(IFNULL((student_rank_in_the_department - 1) * 100 / (the_number_of_students_in_the_department - 1), 0), 2) AS percentage
FROM student_rank r
LEFT JOIN student_cnt c
ON r.department_id = c.department_id
