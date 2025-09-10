# Write your MySQL query statement below
SELECT u.user_id AS buyer_id
    , join_date
    , SUM(CASE WHEN YEAR(order_date) = 2019 THEN 1 ELSE 0 END) AS orders_in_2019
FROM users u
LEFT JOIN Orders l
ON u.user_id = l.buyer_id
GROUP BY 1, 2;