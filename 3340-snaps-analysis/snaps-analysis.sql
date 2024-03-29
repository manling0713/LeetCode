# Write your MySQL query statement below
WITH cte1 AS(
    SELECT age_bucket, activity_type, SUM(time_spent) AS a_time
    FROM Activities ac
    LEFT JOIN Age ag USING(user_id)
    GROUP BY age_bucket, activity_type
), cte2 AS(
    SELECT age_bucket, SUM(time_spent) AS total
    FROM Activities ac
    LEFT JOIN Age ag USING(user_id)
    GROUP BY age_bucket
)
SELECT cte1.age_bucket, SUM(ROUND(IF(activity_type='send', a_time/total*100, 0),2)) AS send_perc,
    SUM(ROUND(IF(activity_type='open', a_time/total*100, 0),2)) AS open_perc
FROM cte1
LEFT JOIN cte2 USING(age_bucket)
GROUP BY age_bucket