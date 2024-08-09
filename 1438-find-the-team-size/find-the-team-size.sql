# Write your MySQL query statement below
SELECT employee_id, team_size
FROM Employee
LEFT JOIN(
    SELECT team_id, COUNT(employee_id) AS team_size
    FROM Employee
    GROUP BY team_id
) sub
USING(team_id)