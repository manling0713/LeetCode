# Write your MySQL query statement below
WITH product_id_cnt AS(
    SELECT product_id
        , YEAR(purchase_date) AS purchase_year
    FROM Orders
    GROUP BY product_id, purchase_year
    HAVING COUNT(order_id) >= 3
)

SELECT DISTINCT p1.product_id
FROM product_id_cnt p1
JOIN product_id_cnt p2
ON p2.purchase_year = p1.purchase_year + 1
    AND p1.product_id = p2.product_id;
