# Write your MySQL query statement below
-- SELECT DISTINCT e1.name
-- FROM Employee e1
-- LEFT JOIN Employee e2
-- ON e1.id = e2.managerId
-- GROUP BY e1.name
-- HAVING COUNT(e2.id) >= 5

select name from Employee 
where id in (select managerId from Employee group by managerId 
having count(managerId)>4);