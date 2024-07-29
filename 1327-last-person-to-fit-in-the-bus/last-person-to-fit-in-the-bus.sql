# Write your MySQL query statement below
WITH accum_weight AS(
    SELECT *, SUM(weight) OVER(ORDER BY turn) AS total_weight
    FROM Queue
)

SELECT person_name
FROM accum_weight
WHERE turn= (
    SELECT MAX(turn)
    FROM accum_weight
    WHERE total_weight <= 1000
    ORDER BY total_weight DESC
)