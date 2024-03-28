# Write your MySQL query statement below
SELECT (WEEK(purchase_date)- WEEK('2023-11-01') + 1) AS week_of_month, purchase_date,
    SUM(amount_spend) AS total_amount
FROM Purchases 
WHERE YEAR(purchase_date) = 2023 AND MONTH(purchase_date) = 11 AND 
    WEEKDAY(purchase_date) = 4
GROUP BY (WEEK(purchase_date)- WEEK('2023-11-01') + 1)
ORDER BY week_of_month