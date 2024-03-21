# Write your MySQL query statement below
SELECT 'bull' AS word, SUM(IF(content LIKE '% bull %', 1, 0)) AS count
FROM Files
UNION ALL
SELECT 'bear' AS word, SUM(IF(content LIKE '% bear %', 1, 0)) AS count
FROM Files
