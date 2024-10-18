# Write your MySQL query statement below

SELECT DISTINCT c1.user_id
FROM Confirmations c1
LEFT JOIN Confirmations c2
ON c1.user_id = c2.user_id AND c1.time_stamp <  c2.time_stamp 
WHERE c1.time_stamp >= DATE_SUB(c2.time_stamp, INTERVAL 24 HOUR)