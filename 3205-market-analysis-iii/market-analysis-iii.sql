# Write your MySQL query statement below
WITH num AS(
    SELECT seller_id, COUNT(DISTINCT item_id) AS num_items
    FROM Orders
    LEFT JOIN Users USING(seller_id)
    LEFT JOIN Items USING(item_id)
    WHERE favorite_brand <> item_brand
    GROUP BY seller_id
)

SELECT seller_id, num_items
FROM (
    SELECT *, DENSE_RANK() OVER(ORDER BY num_items DESC) AS rk
    FROM num
) sub
WHERE rk = 1
ORDER BY seller_id