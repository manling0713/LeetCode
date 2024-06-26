# Write your MySQL query statement below
WITH first_order AS(
    SELECT customer_id
        , MIN(order_date) AS first
    FROM Delivery
    GROUP BY customer_id
)
SELECT ROUND(AVG(IF(order_date=customer_pref_delivery_date, 1, 0))*100,2) AS  immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (SELECT * FROM first_order)