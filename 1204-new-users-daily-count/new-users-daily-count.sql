# Write your MySQL query statement below
WITH first_login AS(
    SELECT user_id, MIN(activity_date) AS login_date
    FROM Traffic
    WHERE activity = 'login'
    GROUP BY user_id
)

SELECT login_date, COUNT(user_id) AS user_count
FROM first_login
WHERE login_date > '2019-03-31'
GROUP BY login_date
