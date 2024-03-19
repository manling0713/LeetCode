# Write your MySQL query statement below
WITH cte1 AS(
    SELECT *, rank() OVER(PARTITION BY department_id ORDER BY mark DESC) AS student_rank_in_the_department
    FROM Students
), cte2 AS(
    SELECT department_id, COUNT(*) AS the_number_of_students_in_the_department
    FROM Students
    GROUP BY department_id
)

SELECT student_id, cte1.department_id,
    ROUND(IFNULL((student_rank_in_the_department - 1) * 100 / (IFNULL(the_number_of_students_in_the_department, 0) - 1) ,0), 2) AS percentage
FROM cte1
LEFT JOIN cte2 USING(department_id)
