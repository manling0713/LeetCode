# Write your MySQL query statement below
WITH reports AS(
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
)
SELECT name
FROM Employee e  
LEFT JOIN reports r
ON e.id = r.managerId
WHERE r.managerId IS NOT NULL