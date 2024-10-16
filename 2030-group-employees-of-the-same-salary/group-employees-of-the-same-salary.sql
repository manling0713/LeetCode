# Write your MySQL query statement below
-- employee_id|name|salary|team_id
-- found employees w/ the same salary
-- COUNT(employee_id) 
-- group by salary
-- having count(employee_id) >= 2
-- DENSE_RANK() on salary
-- order by team_id, employee_id
WITH salary_rank AS(
    SELECT
        salary
        , DENSE_RANK() OVER(ORDER BY salary) AS team_id
    FROM Employees
    GROUP BY salary
    HAVING COUNT(employee_id) >= 2
)
SELECT employee_id
    , name
    , e.salary
    , team_id
FROM Employees e
INNER JOIN salary_rank s
ON e.salary = s.salary
ORDER BY team_id, employee_id
