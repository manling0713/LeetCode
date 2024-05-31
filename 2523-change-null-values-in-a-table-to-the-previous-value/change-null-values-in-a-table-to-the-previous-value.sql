-- # Write your MySQL query statement below
-- WITH number AS(
--     SELECT id, drink, ROW_NUMBER() OVER() AS num
--     FROM CoffeeShop
-- ), group_num AS(
--     SELECT *, SUM(IF(drink IS NULL,0 , 1)) OVER(ORDER BY num) AS group_id
--     FROM number
-- )

-- SELECT id,  FIRST_VALUE(drink) OVER(PARTITION BY group_id) AS drink
-- FROM group_num
with cte as (
    select id, drink, row_number() over() as rn
    from CoffeeShop
),

cte2 as (
    select id, drink, rn, sum(if(drink is NULL, 0, 1)) over (order by rn) as group_id
    from cte
)

select id, first_value(drink) over (partition by group_id order by rn) as drink
from cte2