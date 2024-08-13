# Write your MySQL query statement below
SELECT activity 
FROM friends
GROUP BY activity
HAVING COUNT(*)> (SELECT COUNT(*) FROM friends GROUP BY activity ORDER BY 1 LIMIT 1)
AND COUNT(*)< (SELECT COUNT(*) FROM friends GROUP BY activity ORDER BY 1 DESC LIMIT 1)