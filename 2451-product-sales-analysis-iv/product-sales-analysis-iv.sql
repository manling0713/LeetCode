# Write your MySQL query statement below
WITH product_rank AS(
    SELECT user_id
        , s.product_id
        , RANK() OVER(PARTITION BY user_id ORDER BY SUM(quantity * price) DESC) AS rnk
    FROM Sales s
    LEFT JOIN Product p
    ON s.product_id = p.product_id
    GROUP BY user_id, s.product_id
)


SELECT user_id
    , product_id
FROM product_rank
WHERE rnk = 1;