# Write your MySQL query statement below
WITH student_count AS(
    SELECT 'New York University' AS school
        , COUNT(student_id) AS students
    FROM NewYork
    WHERE score >= 90
    UNION ALL 
    SELECT 'California University' AS school
        , COUNT(student_id) AS students
    FROM California
    WHERE score >= 90
)

SELECT CASE WHEN COUNT(*) = 1 THEN school
    ELSE 'No Winner' END AS winner
FROM student_count
WHERE students = (SELECT MAX(students) FROM student_count)
