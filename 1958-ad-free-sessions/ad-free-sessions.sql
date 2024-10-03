# Write your MySQL query statement below
SELECT DISTINCT session_id
FROM Playback
WHERE session_id NOT IN 
(SELECT DISTINCT p.session_id
FROM Playback p LEFT JOIN Ads a ON p.customer_id = a.customer_id
WHERE a.timestamp BETWEEN p.start_time AND p.end_time)