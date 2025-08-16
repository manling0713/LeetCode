# Write your MySQL query statement below
-- DENSE_RANK() OVER(PARTITION BY dept ORDER BY salary DESC)
-- WHERE rnk = 2
-- ORDER BY emp_id
WITH salary_rank AS(
    SELECT emp_id
        , dept
        , DENSE_RANK() OVER(PARTITION BY dept ORDER BY salary DESC) AS rnk
    FROM employees
)

SELECT emp_id
    , dept
FROM salary_rank
WHERE rnk = 2
ORDER BY emp_id;


