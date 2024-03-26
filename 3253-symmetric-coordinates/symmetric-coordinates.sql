# Write your MySQL query statement below
WITH cte AS(
    SELECT *, ROW_NUMBER() OVER() AS num
    FROM Coordinates
)

SELECT DISTINCT c1.X, c1.Y
FROM cte c1, cte c2
WHERE c1.num <> c2.num 
    AND c1.X = c2.Y AND c2.x = c1.Y 
    AND c1.X <= c1.Y 
ORDER BY c1.X, c1.Y