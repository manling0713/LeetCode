# Write your MySQL query statement below
WITH cte AS (
    SELECT *, ROW_NUMBER() OVER() AS rn 
    FROM Users
)

SELECT DISTINCT(a.user_id)
FROM cte a, cte b
WHERE a.user_id = b.user_id AND a.rn <> b.rn
    AND ABS(DATEDIFF(b.created_at,a.created_at)) <= 7