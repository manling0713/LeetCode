# Write your MySQL query statement below
WITH pur_nov AS(
    SELECT *,
    FLOOR(DAY(purchase_date)/7)+1 AS week_of_month
    FROM Purchases p
    LEFT JOIN Users u 
    USING(user_id)
    WHERE purchase_date BETWEEN '2023-11-01' AND '2023-11-30'
        AND WEEKDAY(purchase_date) = 4
), week_month AS(
    SELECT *
    FROM (
            SELECT 1 AS week_of_month UNION ALL
            SELECT 2 UNION ALL
            SELECT 3 UNION ALL
            SELECT 4
        ) AS weeks
    CROSS JOIN(
            SELECT 'Premium' AS membership UNION ALL
            SELECT 'VIP'
    ) AS types
)

SELECT w.week_of_month
    , w.membership
    , IFNULL(SUM(amount_spend), 0) AS total_amount
FROM week_month w
LEFT JOIN pur_nov p
ON w.week_of_month = p.week_of_month
    AND w.membership = p.membership
GROUP BY w.week_of_month, w.membership
ORDER BY w.week_of_month, w.membership