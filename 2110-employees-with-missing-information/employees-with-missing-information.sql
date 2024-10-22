# Write your MySQL query statement below
WITH all_employee AS(
    SELECT employee_id
    FROM Employees
    UNION ALL
    SELECT employee_id
    FROM Salaries
)

SELECT DISTINCT a.employee_id
FROM all_employee a
LEFT JOIN Employees e
USING(employee_id)
LEFT JOIN Salaries s
USING(employee_id)
WHERE name IS NULL 
    OR salary IS NULL
ORDER BY 1;
