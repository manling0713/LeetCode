# Write your MySQL query statement below
WITH cte AS(
SELECT seller_id,
       COUNT(DISTINCT item_id) as num_items 
FROM Users 
     JOIN Orders USING(seller_id)
     JOIN Items USING(item_id)   
WHERE favorite_brand<> item_brand
GROUP BY seller_id
)
SELECT seller_id, num_items
FROM(
    SELECT *, DENSE_RANK() OVER (ORDER BY num_items DESC) AS rk
    FROM cte
) AS sub
WHERE rk = 1
ORDER BY seller_id

