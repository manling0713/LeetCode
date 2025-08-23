# Write your MySQL query statement below
-- LEFT JOIN products ON product_id
-- CASE WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'WINTER'... END AS season
-- SUM(quantity) AS total_quantity
-- SUM(quantity *price) AS total_revenue
-- GROUP BY category
-- ROW_NUMBER() OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) AS rnk
-- WHERE rnk = 1

WITH sales_info AS(
    SELECT sale_id
        , s.product_id
        , category
        , CASE WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(sale_date) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall' END AS season
        , quantity
        , quantity * price AS revenue
    FROM sales s
    LEFT JOIN products p
    ON s.product_id = p.product_id
), cat_rank AS(
    SELECT season
        , category
        , SUM(quantity) AS total_quantity
        , SUM(revenue) AS total_revenue
        , ROW_NUMBER() OVER(PARTITION BY season ORDER BY SUM(quantity) DESC, SUM(revenue) DESC) AS rnk
    FROM sales_info
    GROUP BY season, category
)
SELECT season
    , category
    , total_quantity
    , total_revenue
FROM cat_rank
WHERE rnk = 1
ORDER BY season;
