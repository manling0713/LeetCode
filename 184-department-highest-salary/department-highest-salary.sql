# Write your MySQL query statement below
WITH dep_rank AS(
    SELECT d.name AS Department
        ,e.name AS Employee
        , salary
        , RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee e
    LEFT JOIN Department d
    ON e.departmentId = d.id)
SELECT Department, Employee, Salary
FROM  dep_rank
WHERE rnk = 1
