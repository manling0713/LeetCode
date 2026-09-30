# Write your MySQL query statement below
WITH product_date AS(
    SELECT product_id
        , MAX(change_date) AS max_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
), product_price AS(
    SELECT product_id
        , new_price
    FROM Products
    WHERE (product_id, change_date) IN (SELECT * FROM product_date)
), all_product AS(
    SELECT DISTINCT product_id
    FROM Products
)
SELECT a.product_id   
    , IFNULL(new_price, 10) AS price
FROM all_product a
LEFT JOIN product_price p
ON a.product_id = p.product_id


