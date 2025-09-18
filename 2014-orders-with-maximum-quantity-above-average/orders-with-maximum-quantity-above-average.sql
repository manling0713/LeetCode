# Write your MySQL query statement below
WITH orders AS(
    SELECT order_id
        , AVG(quantity) AS avg_q
        , MAX(quantity) AS max_q
    FROM OrdersDetails
    GROUP BY order_id
)
SELECT DISTINCT order_id
FROM orders
WHERE max_q > (SELECT MAX(avg_q) FROM orders)