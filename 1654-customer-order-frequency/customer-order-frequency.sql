# Write your MySQL query statement below
WITH all_name AS(
    SELECT c.customer_id, c.name
    FROM orders o 
    LEFT JOIN Product p
    USING(product_id)
    LEFT JOIN Customers c 
    USING(customer_id)
    WHERE order_date BETWEEN '2020-06-01' AND '2020-07-31'
    GROUP BY c.customer_id, MONTH(order_date)
    HAVING SUM(price*quantity) >= 100
)
SELECT customer_id, name
FROM all_name
GROUP BY customer_id
HAVING COUNT(*)=2