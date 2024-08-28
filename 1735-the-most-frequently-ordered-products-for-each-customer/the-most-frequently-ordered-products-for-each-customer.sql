# Write your MySQL query statement below
WITH customer_product AS(
    SELECT customer_id
        , product_id
        , RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(*) DESC) As num
    FROM Orders o
    GROUP BY customer_id, product_id
)
SELECT c.customer_id
    , p.product_id
    , product_name
FROM customer_product cp
LEFT JOIN Customers c
USING(customer_id)
LEFT JOIN Products p
USING(product_id)
WHERE num = 1
