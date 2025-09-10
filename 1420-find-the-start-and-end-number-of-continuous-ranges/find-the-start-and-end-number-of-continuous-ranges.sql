# Write your MySQL query statement below
WITH cte AS(
    SELECT log_id
        , ROW_NUMBER() OVER(ORDER BY log_id) rnk
    FROM Logs
)
SELECT MIN(log_id) AS start_id
    , MAX(log_id) AS end_id
FROM cte
GROUP BY log_id - rnk