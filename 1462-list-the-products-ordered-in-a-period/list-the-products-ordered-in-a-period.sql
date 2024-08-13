# Write your MySQL query statement below
SELECT product_name, SUM(unit) AS unit
FROM Orders o
LEFT JOIN Products p
USING(product_id)
WHERE order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY product_name
HAVING SUM(unit) >= 100