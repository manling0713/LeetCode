# Write your MySQL query statement below
-- SELECT DISTINCT e1.name
-- FROM Employee e1
-- LEFT JOIN Employee e2
-- ON e1.id = e2.managerId
-- GROUP BY e1.name
-- HAVING COUNT(e2.id) >= 5

SELECT name 
FROM Employee 
WHERE id in (
    SELECT managerId 
    FROM Employee 
    GROUP BY managerId 
    HAVING COUNT(managerId) >= 5
)