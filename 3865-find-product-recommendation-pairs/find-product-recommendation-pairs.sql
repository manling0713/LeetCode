# Write your MySQL query statement below
-- JOIN ProductPurchases
-- ON p1.user_id = p2.user_id AND p1.product_id < p2.product_id
-- GROUP BY p1.product_id, p2.product_id
-- COUNT(DISTINCT p1.user_id) AS customer_count
-- LEFT JOIN ProductInfo
WITH product_user AS (
    SELECT p1.product_id AS product1_id
        , p2.product_id AS product2_id
        , COUNT(DISTINCT p1.user_id) AS customer_count
    FROM ProductPurchases p1
    INNER JOIN ProductPurchases p2
    ON p1.user_id = p2.user_id AND p1.product_id < p2.product_id
    GROUP BY p1.product_id, p2.product_id
    HAVING COUNT(DISTINCT p1.user_id) >= 3
)
SELECT product1_id
    , product2_id
    , pi1.category AS product1_category
    , pi2.category AS product2_category
    , customer_count
FROM product_user pu
LEFT JOIN ProductInfo pi1
ON pu.product1_id = pi1.product_id
LEFT JOIN ProductInfo pi2
ON pu.product2_id = pi2.product_id
ORDER BY customer_count DESC, product1_id, product2_id;