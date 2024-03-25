# Write your MySQL query statement below
SELECT s1.user_id, s3.steps_date, ROUND((s1.steps_count + s2.steps_count + s3.steps_count)/3, 2) AS rolling_average
FROM Steps s1, Steps s2, Steps s3
WHERE s1.user_id = s2.user_id AND s1.user_id = s3.user_id
    AND s1.steps_date + 1 = s2.steps_date AND s2.steps_date + 1 = s3.steps_date
ORDER BY s1.user_id, s3.steps_date