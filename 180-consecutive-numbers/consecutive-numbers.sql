# Write your MySQL query statement below
WITH num_cons AS(
    SELECT id
        , num AS num_1
        , LEAD(num, 1) OVER() AS num_2
        , LEAD(num, 2) OVER() AS num_3
    FROM Logs

)

SELECT DISTINCT num_1 AS ConsecutiveNums
FROM num_cons
WHERE num_1 = num_2 AND num_2 = num_3;
