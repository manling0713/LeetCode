# Write your MySQL query statement below
SELECT name AS warehouse_name
    , SUM(units*Width*Length*Height) AS volume
FROM Warehouse w
LEFT JOIN Products p
USING(product_id)
GROUP BY name