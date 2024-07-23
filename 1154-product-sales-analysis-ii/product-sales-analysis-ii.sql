# Write your MySQL query statement below
SELECT s.product_id, SUM(quantity) AS total_quantity
FROM Sales s
LEFT JOIN Product p
USING(product_id)
GROUP BY s.product_id