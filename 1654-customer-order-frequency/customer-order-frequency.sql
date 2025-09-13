# Write your MySQL query statement below
WITH customer_spend AS(
    SELECT c.customer_id
        , name
    FROM Orders o
    LEFT JOIN Product p
    ON o.product_id = p.product_id
    LEFT JOIN Customers c
    ON o.customer_id = c.customer_id
    WHERE order_date BETWEEN '2020-06-01' AND '2020-07-31'
    GROUP BY c.customer_id, MONTH(order_date)
    HAVING SUM(quantity*price) >= 100
)
SELECT *
FROM customer_spend
GROUP BY customer_id
HAVING COUNT(*) = 2;