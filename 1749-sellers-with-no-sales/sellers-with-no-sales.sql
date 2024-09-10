# Write your MySQL query statement below
SELECT DISTINCT seller_name
FROM Seller s
WHERE seller_id NOT IN (
    SELECT DISTINCT seller_id
    FROM Orders o
    WHERE YEAR(sale_date) = 2020
)
ORDER BY seller_name
