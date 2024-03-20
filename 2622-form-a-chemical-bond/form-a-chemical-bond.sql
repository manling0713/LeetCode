# Write your MySQL query statement below
WITH cte1 AS (
    SELECT symbol AS metal
    FROM Elements
    WHERE type = 'Metal'
), cte2 AS(
    SELECT symbol AS nonmetal
    FROM Elements
    WHERE type = 'Nonmetal'
)
SELECT *
FROM cte1, cte2