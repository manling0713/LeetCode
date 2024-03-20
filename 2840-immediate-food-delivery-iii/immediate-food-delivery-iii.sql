# Write your MySQL query statement below
WITH cte1 AS(
    SELECT order_date, COUNT(delivery_id) AS immediate
    FROM Delivery
    WHERE order_date = customer_pref_delivery_date
    GROUP BY order_date
), cte2 AS(
    SELECT order_date, COUNT(delivery_id) AS total
    FROM Delivery
    GROUP BY order_date
)

SELECT cte2.order_date, ROUND(IFNULL(immediate/total, 0)*100, 2) AS immediate_percentage
FROM cte2
LEFT JOIN cte1 USING(order_date)
ORDER BY cte2.order_date
