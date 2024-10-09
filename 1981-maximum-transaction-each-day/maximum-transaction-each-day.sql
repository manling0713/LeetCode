# Write your MySQL query statement below
WITH amount_rank AS(
SELECT 
    transaction_id
    , day
    , DENSE_RANK() OVER(PARTITION BY day ORDER BY amount DESC) AS rnk
FROM Transactions
)
SELECT transaction_id
FROM amount_rank
WHERE rnk = 1
ORDER BY transaction_id;
