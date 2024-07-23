# Write your MySQL query statement below
SELECT DISTINCT buyer_id
FROM Sales 
WHERE buyer_id IN (
    SELECT buyer_id 
    FROM Sales
    LEFT JOIN Product p
    USING(product_id)
    WHERE product_name = 'S8'
) AND buyer_id NOT IN (
    SELECT buyer_id 
    FROM Sales
    LEFT JOIN Product p
    USING(product_id)
    WHERE product_name = 'iPhone'
)