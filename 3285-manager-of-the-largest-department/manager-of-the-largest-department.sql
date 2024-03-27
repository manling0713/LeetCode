# Write your MySQL query statement below
WITH cte1 AS(
    SELECT dep_id, COUNT(emp_id), RANK() OVER(ORDER BY COUNT(emp_id) DESC) AS num
    FROM Employees
    GROUP BY dep_id
)

SELECT emp_name AS manager_name, cte1.dep_id
FROM cte1
JOIN Employees e USING(dep_id)
WHERE num = 1 AND position = 'Manager' 
ORDER BY dep_id
