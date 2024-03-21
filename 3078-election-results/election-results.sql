# Write your MySQL query statement below
WITH cte1 AS(
    SELECT voter, IFNULL(1/COUNT(candidate), 0) AS vote
    FROM Votes
    GROUP BY voter
), cte2 AS(
    SELECT candidate, SUM(vote) AS total
    FROM Votes
    LEFT JOIN cte1 USING(voter)
    GROUP BY candidate
)
SELECT candidate
FROM cte2
WHERE total = (SELECT MAX(total) FROM cte2)
ORDER BY candidate

