# Write your MySQL query statement below
WITH date AS(
    SELECT DISTINCT visited_on
        , SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) amount
        , MIN(visited_on) OVER() AS first_date
    FROM Customer
)
SELECT visited_on, amount, ROUND(amount/7, 2) average_amount
FROM date
WHERE visited_on >= first_date + 6