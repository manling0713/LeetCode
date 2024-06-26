# Write your MySQL query statement below
WITH start_end AS(
    SELECT server_id
        , session_status
        , CASE WHEN session_status = 'start' THEN status_time END AS status_start_time
        , LEAD(status_time) OVER(PARTITION BY server_id ORDER BY status_time) AS status_end_time
    FROM Servers
)
SELECT FLOOR(SUM(TIMESTAMPDIFF(SECOND, status_start_time, status_end_time)/(24*60*60))) As total_uptime_days
FROM start_end
WHERE session_status = 'start'