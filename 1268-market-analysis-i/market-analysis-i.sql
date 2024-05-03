# Write your MySQL query statement below
WITH order_2019 AS(
    SELECT buyer_id
        , COUNT(order_id) AS orders_in_2019
    FROM Orders
    WHERE year(order_date)=2019
    GROUP BY buyer_id
)
SELECT user_id AS buyer_id
    , join_date 
    , IFNULL(orders_in_2019, 0) AS orders_in_2019
FROM Users u
LEFT JOIN order_2019 o
ON u.user_id = o.buyer_id