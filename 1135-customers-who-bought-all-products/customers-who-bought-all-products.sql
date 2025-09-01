# Write your MySQL query statement below
SELECT customer_id
FROM Product p
INNER JOIN Customer c
ON p.product_key = c.product_key
GROUP BY customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(*) FROM Product);