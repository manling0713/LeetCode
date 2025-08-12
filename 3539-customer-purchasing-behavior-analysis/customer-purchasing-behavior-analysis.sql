# Write your MySQL query statement below
WITH trans_product AS(    
    SELECT transaction_id
        , customer_id
        , t.product_id
        , amount
        , transaction_date
        , category
    FROM Transactions t
    LEFT JOIN Products p
    ON t.product_id = p.product_id
), category_rank AS (
    SELECT customer_id
        , category 
        , transaction_date
        , ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY COUNT(*) DESC, MAX(transaction_date) DESC) AS cat_rnk
    FROM trans_product
    GROUP BY customer_id, category
)

SELECT t.customer_id
    , ROUND(SUM(amount), 2) AS total_amount
    , COUNT(DISTINCT transaction_id) AS transaction_count
    , COUNT(DISTINCT t.category) AS unique_categories
    , ROUND(AVG(amount), 2) AS avg_transaction_amount
    , c.category AS top_category
    , ROUND(COUNT(DISTINCT transaction_id) * 10 + SUM(amount)/100,2) AS loyalty_score
FROM trans_product t
LEFT JOIN category_rank c
ON t.customer_id = c.customer_id
WHERE cat_rnk = 1
GROUP BY customer_id
ORDER BY loyalty_score DESC, t.customer_id

