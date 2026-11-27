# Write your MySQL query statement below
WITH rank_score AS(
    SELECT student_id
        , subject
        , FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS first_score
        , FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores
)

SELECT DISTINCT *
FROM rank_score
WHERE first_score < latest_score
ORDER BY student_id, subject