# Write your MySQL query statement below
SELECT IFNULL(ROUND(AVG(sessions), 2), 0) AS average_sessions_per_user
FROM(
    SELECT user_id, COUNT(DISTINCT session_id) AS sessions
    FROM Activity
    WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
    GROUP BY user_id
) AS sub