# Write your MySQL query statement below
SELECT user_id, name, IFNULL(SUM(distance), 0) AS 'traveled distance' 
FROM Users u
LEFT JOIN Rides r USING(user_id)
GROUP BY user_id
ORDER BY user_id