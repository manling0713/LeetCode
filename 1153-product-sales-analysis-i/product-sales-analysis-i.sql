# Write your MySQL query statement below
SELECT product_name, year, price
FROM Sales s
LEFT JOIN Product p
USING(product_id)