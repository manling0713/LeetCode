# Write your MySQL query statement below
WITH cte AS(
    SELECT department, MAX(salary) AS max
    FROM Salaries
    GROUP BY department
)

SELECT ABS(a.max - b.max) AS salary_difference
FROM cte a, cte b
WHERE a.department = 'Marketing' AND b.department = 'Engineering'
