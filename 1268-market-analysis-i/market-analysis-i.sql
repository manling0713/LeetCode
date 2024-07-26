# Write your MySQL query statement below
SELECT user_id AS buyer_id
    , join_date
    , IFNULL(COUNT(order_date), 0) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
ON o.buyer_id = u.user_id AND YEAR(order_date) = 2019
GROUP BY user_id
