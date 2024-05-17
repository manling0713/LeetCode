# Write your MySQL query statement below
WITH cte AS(
    SELECT *
        , RANK() OVER(PARTITION BY gender ORDER BY user_id) AS rnk
        , IF(gender = 'female',1, IF(gender='other',2 ,3 )) AS rnk2
    FROM Genders
)
SELECT user_id, gender
FROM cte
ORDER BY rnk, rnk2