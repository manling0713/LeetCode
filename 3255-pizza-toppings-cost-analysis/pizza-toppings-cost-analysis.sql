# Write your MySQL query statement below
select
  concat(a.topping_name, ",", b.topping_name, ",", c.topping_name) as pizza,
  round(a.cost + b.cost + c.cost, 2) as total_cost
from
  toppings as a,
  toppings as b,
  toppings as c
where
  a.topping_name < b.topping_name
  and b.topping_name < c.topping_name
order by
  total_cost desc,
  pizza
;