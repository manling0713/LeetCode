# Write your MySQL query statement below
WITH grade_order AS(
    SELECT student_id
        , course_id
        , grade
        , RANK() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id) AS num
    FROM Enrollments
)
SELECT student_id, course_id, grade
FROM grade_order
WHERE num = 1
ORDER BY student_id