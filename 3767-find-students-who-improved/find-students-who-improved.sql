# Write your MySQL query statement below
-- GROUP BY student_id, subject
-- HAVING COUNT(DISTINCT exam_date) >= 2
-- ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date)
-- ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC)
-- last_score > first_score
-- WITH student_2_exams AS(
--     SELECT student_id
--         , subject
--     FROM Scores
--     GROUP BY student_id, subject
--     HAVING COUNT(DISTINCT exam_date) >= 2
-- ), score_rank AS (
--     SELECT student_id
--         , subject
--         , score
--         , ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS rnk1
--         , ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS rnk2
--     FROM Scores
--     WHERE (student_id, subject) IN (SELECT student_id, subject FROM student_2_exams)
-- ), first AS(
--     SELECT student_id
--         , subject
--         , score AS first_score
--     FROM score_rank
--     WHERE rnk1 = 1
-- ), last AS(
--     SELECT student_id
--         , subject
--         , score AS latest_score
--     FROM score_rank
--     WHERE rnk2 = 1
-- )

-- SELECT f.student_id
--     , f.subject
--     , first_score
--     , latest_score
-- FROM first f
-- LEFT JOIN last l
-- ON f.student_id = l.student_id AND f.subject = l.subject
-- WHERE first_score < latest_score
-- ORDER BY f.student_id, f.subject;
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

