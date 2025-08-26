# Write your MySQL query statement below
-- GROUP BY customer_id
-- HAVING COUNT(transaction_id) >= 3
-- DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30
-- SUM(IF(transaction_type = 'refund', 1, 0))/COUNT(transaction_id) < 0.2
WITH customer_days AS(
    SELECT customer_id
        , DATEDIFF(MAX(transaction_date), MIN(transaction_date)) AS active_days
    FROM customer_transactions
    GROUP BY customer_id
)

SELECT DISTINCT ct.customer_id
FROM customer_transactions ct
LEFT JOIN customer_days cd
ON ct.customer_id = cd.customer_id
WHERE active_days >= 30
GROUP BY ct.customer_id
HAVING COUNT(transaction_id) >= 3
    AND SUM(IF(transaction_type = 'refund', 1, 0))/COUNT(transaction_id) < 0.2
ORDER BY ct.customer_id;
