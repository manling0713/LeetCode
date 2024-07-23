# Write your MySQL query statement below
SELECT s.product_id, year AS first_year, quantity, price
FROM Sales s
LEFT JOIN Product p
USING(product_id)
WHERE (s.product_id, year) IN (SELECT product_id, MIN(year) AS year FROM Sales GROUP BY product_id)