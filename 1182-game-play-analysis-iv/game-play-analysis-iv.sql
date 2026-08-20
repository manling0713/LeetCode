# Write your MySQL query statement below
WITH user_first AS(
    SELECT player_id
        , MIN(event_date) AS first_date
    FROM Activity 
    GROUP BY player_id
)

SELECT ROUND(COUNT(a.player_id)/COUNT(u.player_id), 2) AS fraction
FROM user_first u
LEFT JOIN Activity a
ON u.player_id = a.player_id
    AND a.event_date = DATE_ADD(first_date, INTERVAL 1 DAY)