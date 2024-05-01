WITH cte AS (
    SELECT exam_id
        , e.student_id
        , student_name
        , score
        , RANK() OVER(PARTITION BY exam_id ORDER BY score) AS rk1
        , RANK() OVER(PARTITION BY exam_id ORDER BY score DESC) AS rk2
    FROM Exam e
    LEFT JOIN Student s
    USING(student_id)
)
SELECT DISTINCT student_id, student_name
FROM cte
WHERE student_id NOT IN(
    SELECT student_id
    FROM cte
    WHERE rk1 = 1 OR rk2 = 1
)
ORDER BY student_id;