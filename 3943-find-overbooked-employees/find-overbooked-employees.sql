# Write your MySQL query statement below
WITH employee_hour AS(
    SELECT employee_id
        , WEEK(meeting_date, 1) AS week_id
        , SUM(duration_hours) AS meeting_hour
    FROM meetings
    GROUP BY employee_id
        , WEEK(meeting_date, 1)
        , YEAR(meeting_date)
)
SELECT e.employee_id
    , employee_name
    , department
    , COUNT(week_id) AS meeting_heavy_weeks
FROM employee_hour eh
LEFT JOIN employees e
ON eh.employee_id = e.employee_id
WHERE meeting_hour > 20
GROUP BY employee_id
HAVING COUNT(week_id) >= 2
ORDER BY meeting_heavy_weeks DESC, employee_name