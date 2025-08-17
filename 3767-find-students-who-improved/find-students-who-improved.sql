# Write your MySQL query statement below
WITH score_rank AS(
    SELECT student_id
        , subject
        , FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS first_score
        , FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores 
)

SELECT DISTINCT student_id
    , subject
    , first_score
    , latest_score
FROM score_rank
WHERE first_score < latest_score
ORDER BY student_id, subject;

