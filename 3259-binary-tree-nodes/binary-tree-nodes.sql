# Write your MySQL query statement below
WITH cte1 AS(
    SELECT N, 'Root' AS Type
    FROM Tree
    WHERE P IS NULL
    UNION ALL
    SELECT N, 'Inner' AS Type
    FROM Tree
    WHERE N IN (
        SELECT P
        FROM Tree
        GROUP BY P
        HAVING COUNT(N) <> 0
    ) AND N NOT IN(
        SELECT N
        FROM Tree
        WHERE P IS NULL  
    )
)
SELECT N, IF(Type IS NULL, 'Leaf', Type) AS Type
FROM Tree
LEFT JOIN cte1 USING(N)
ORDER BY N


