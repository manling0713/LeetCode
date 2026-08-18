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


-- select  
--     customer_id, 
--     count(customer_id) as total_orders, 
--     round(avg(case when ((time(order_timestamp) >= '11:00:00' and time(order_timestamp) <= '14:00:00') or (time(order_timestamp) >= '18:00:00' and time(order_timestamp) <= '21:00:00')) then 1 else 0 end) * 100, 0) as peak_hour_percentage,
--     round(avg(order_rating), 2) as average_rating
-- from restaurant_orders
-- group by customer_id
-- having total_orders > 2 and average_rating >= 4.0 and peak_hour_percentage >= 60 and round(avg(case when order_rating is not NULL then 1 else 0 end)*100, 0) >= 50
-- order by average_rating desc, customer_id desc