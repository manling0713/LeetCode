# Write your MySQL query statement below
WITH cte1 AS(
    SELECT *, ROW_NUMBER() OVER() AS num
    FROM CoffeeShop
), cte2 AS(
    SELECT *, SUM(IF(drink IS NULL, 0, 1)) OVER(ORDER BY num) AS group_id
    FROM cte1
)

SELECT id, FIRST_VALUE(drink) OVER(PARTITION BY group_id ORDER BY num) AS drink
FROM cte2