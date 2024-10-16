# Write your MySQL query statement below
-- WHERE YEAR(time_stamp) = 2020
-- MAX(time_stamp)
-- GROUP BY user_id

SELECT user_id
    , MAX(time_stamp) AS last_stamp
FROM Logins
WHERE YEAR(time_stamp) = 2020
GROUP BY user_id;