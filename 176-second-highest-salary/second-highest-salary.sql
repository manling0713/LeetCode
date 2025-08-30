# Write your MySQL query statement below
WITH second_salary AS(
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
)
SELECT COALESCE(MAX(salary), NULL) AS SecondHighestSalary
FROM second_salary;
