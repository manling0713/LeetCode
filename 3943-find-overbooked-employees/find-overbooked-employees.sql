# Write your MySQL query statement below
-- GROUP BY employee_id, WEEK(meeting_date)
-- HAVING SUM(duration_hours) >= 20
-- GROUP BY employee_id
-- HAVING COUNT(week) >= 2
WITH employee_meetings AS (
    SELECT employee_id
        , WEEK(meeting_date) AS weeks
        , SUM(duration_hours) AS meeting_duration
    FROM meetings
    GROUP BY employee_id, WEEKOFYEAR(meeting_date), YEAR(meeting_date)
    HAVING SUM(duration_hours) > 20
)
SELECT em.employee_id
    , employee_name
    , department
    , COUNT(em.employee_id) AS meeting_heavy_weeks
FROM employee_meetings em
LEFT JOIN employees e
ON em.employee_id = e.employee_id
GROUP BY em.employee_id
HAVING COUNT(DISTINCT weeks) >= 2
ORDER BY meeting_heavy_weeks DESC, employee_name;