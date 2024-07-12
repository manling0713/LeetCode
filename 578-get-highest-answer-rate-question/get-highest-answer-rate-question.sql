# Write your MySQL query statement below
WITH answer AS(
    SELECT question_id, COUNT(answer_id) AS ans_num
    FROM SurveyLog
    GROUP BY question_id
)
SELECT question_id AS survey_log
FROM answer
ORDER BY ans_num/1 DESC, question_id
LIMIT 1