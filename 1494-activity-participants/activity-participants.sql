# Write your MySQL query statement below
WITH activity_rank AS(
    SELECT activity
        , RANK() OVER(ORDER BY COUNT(id) DESC) AS rnk1
        , RANK() OVER(ORDER BY COUNT(id)) AS rnk2
    FROM Friends
    GROUP BY activity
)
SELECT activity
FROM activity_rank
WHERE rnk1 <> 1 AND rnk2 <> 1

