# Write your MySQL query statement below
SELECT e.employee_id
FROM Employees e
LEFT JOIN Logs l
ON e.employee_id = l.employee_id
GROUP BY e.employee_id, needed_hours
HAVING SUM(CEIL(IFNULL(TIMESTAMPDIFF(SECOND, in_time, out_time), 0) / 60) / 60) < needed_hours
 