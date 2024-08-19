# Write your MySQL query statement below
SELECT product_name
    , p.product_id
    , order_id
    , order_date
FROM Orders o
LEFT JOIN Products p
USING(product_id)
WHERE (p.product_id, order_date) IN (
    SELECT product_id, MAX(order_date) AS order_date
    FROM Orders
    GROUP BY product_id
)
ORDER BY 1, 2, 3