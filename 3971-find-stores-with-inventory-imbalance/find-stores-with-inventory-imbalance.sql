# Write your MySQL query statement below
-- GROUP BY store_id
-- HAVING COUNT(product_name) >= 3
-- INNER JOIN inventory 
-- ON store_id AND <> product_name
-- i1.price = MAX(price) GROUP BY store_id
-- ROUND(i2.price / i1.price, 2)
WITH store_info AS(
    SELECT store_id
        , MAX(price) AS max_price
        , MIN(price) AS min_price
    FROM inventory
    GROUP BY store_id
    HAVING COUNT(product_name) >= 3
)

SELECT si.store_id
    , store_name
    , location
    , i1.product_name AS most_exp_product
    , i2.product_name AS cheapest_product
    , ROUND(i2.quantity / i1.quantity, 2) AS imbalance_ratio
FROM store_info si
LEFT JOIN inventory i1
ON si.store_id = i1.store_id AND si.max_price = i1.price
LEFT JOIN inventory i2
ON si.store_id = i2.store_id AND si.min_price = i2.price
LEFT JOIN stores s
ON si.store_id = s.store_id
WHERE i1.quantity < i2.quantity
ORDER BY imbalance_ratio DESC, store_name;
