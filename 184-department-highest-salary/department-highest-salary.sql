# Write your MySQL query statement below
WITH salary_rank AS(
    SELECT d.name AS Department
        , e.name AS Employee
        , salary
        , DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) AS rnk
    FROM Employee e
    LEFT JOIN Department d
    ON e.departmentId = d.id
)
SELECT  Department
    , Employee
    , salary
FROM salary_rank
WHERE rnk = 1
