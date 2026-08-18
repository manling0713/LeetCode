SELECT customer_id
    , COUNT(order_id) AS total_orders
    , ROUND(SUM(CASE WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00' THEN 1
        WHEN TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00' THEN 1
        ELSE 0 END) / COUNT(order_id), 2) * 100 AS peak_hour_percentage
    , ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING total_orders >= 3
    AND peak_hour_percentage >= 60
    AND average_rating >= 4.0
    AND SUM(CASE WHEN order_rating IS NOT NULL THEN 1 ELSE 0 END)/ COUNT(order_id) >= 0.5
ORDER BY average_rating DESC, customer_id DESC
