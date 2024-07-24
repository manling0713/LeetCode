# Write your MySQL query statement below
WITH event_avg AS(
    SELECT event_type, AVG(occurrences) AS avg_activity
    FROM Events
    GROUP BY event_type
)
SELECT DISTINCT business_id
FROM Events e
LEFT JOIN event_avg ea
USING(event_type)
WHERE occurrences > avg_activity
GROUP BY business_id
HAVING COUNT(event_type) > 1