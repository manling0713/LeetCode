# Write your MySQL query statement below
WITH change_price AS (
    SELECT product_id, new_price
    FROM Products
    WHERE (product_id, change_date) IN (
        SELECT product_id
            , MAX(change_date) AS change_date
        FROM Products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    )
)
SELECT DISTINCT product_id
    , IF(cp.new_price iS NULL, 10, cp.new_price) AS price
FROM Products p
LEFT JOIN change_price cp
USING(product_id)