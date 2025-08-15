# Write your MySQL query statement below
-- FROM products LEFT JOIN Discounts using category
-- WHEN discount is not null THEN price * (100 - discount)/100 ELSE price
-- ORDER BY product_id

SELECT product_id
    , CASE WHEN discount IS NOT NULL THEN price * (100 - discount)/100 
        ELSE price END AS final_price
    , p.category
FROM Products p
LEFT JOIN Discounts d
ON p.category = d.category
ORDER BY product_id;