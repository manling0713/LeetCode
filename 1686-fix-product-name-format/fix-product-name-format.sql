# Write your MySQL query statement below
SELECT TRIM(LOWER(product_name)) AS product_name
    , LEFT(sale_date, 7) AS sale_date
    , COUNT(sale_id) AS total
FROM Sales
WHERE YEAR(sale_date) = 2000
GROUP BY TRIM(LOWER(product_name)), MONTH(sale_date)
ORDER BY 1, 2