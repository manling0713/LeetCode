# Write your MySQL query statement below
SELECT machine_id
    , ROUND(SUM(IF(activity_type = 'start', -timestamp, timestamp)) / (COUNT(*)/2), 3) AS processing_time
FROM Activity
GROUP BY machine_id