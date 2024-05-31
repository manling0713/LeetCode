# Write your MySQL query statement below
WITH session AS(
    SELECT employee_id, 
        SUM(CEIL(TIMESTAMPDIFF(SECOND, in_time, out_time)/60)) AS total_hours
    FROM Logs
    GROUP BY employee_id
)
SELECT  employee_id
FROM Employees e 
LEFT JOIN session s
USING(employee_id)
WHERE total_hours < needed_hours*60 OR total_hours IS NULL


