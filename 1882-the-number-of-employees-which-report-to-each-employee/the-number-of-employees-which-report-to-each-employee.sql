# Write your MySQL query statement below
SELECT e2.employee_id
    , e2.name
    , COUNT(e1.employee_id) AS reports_count
    , ROUND(AVG(e1.age)) AS average_age
FROM Employees e1
LEFT JOIN Employees e2
ON e1.reports_to = e2.employee_id
WHERE e1.reports_to IS NOT NULL
GROUP BY e1.reports_to
HAVING COUNT(e1.employee_id) >= 1
ORDER BY e2.employee_id