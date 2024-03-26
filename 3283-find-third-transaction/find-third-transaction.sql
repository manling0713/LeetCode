# Write your MySQL query statement below
WITH cte1 AS(
    SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS num
    FROM Transactions 
), cte2 AS(
    SELECT user_id, MAX(transaction_date) AS third_transaction_date,
        SUM(CASE WHEN num = 1 THEN spend ELSE 0 END) AS first_spend,
        SUM(CASE WHEN num = 2 THEN spend ELSE 0 END) AS second_spend,
        SUM(CASE WHEN num = 3 THEN spend ELSE 0 END) AS third_spend
    FROM cte1
    WHERE num <= 3
    GROUP BY user_id
)
SELECT user_id, third_spend AS third_transaction_spend, third_transaction_date
FROM cte2
WHERE third_spend > second_spend AND third_spend > first_spend



