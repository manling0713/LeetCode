-- # Write your MySQL query statement below
WITH number AS(
    SELECT id, drink, ROW_NUMBER() OVER() AS num
    FROM CoffeeShop
), group_num AS(
    SELECT *, SUM(IF(drink IS NULL, 0, 1)) OVER(ORDER BY num) AS group_id
    FROM number
)

SELECT id,  FIRST_VALUE(drink) OVER(PARTITION BY group_id ORDER BY num) AS drink
FROM group_num
