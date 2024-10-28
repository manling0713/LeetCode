# Write your MySQL query statement below
-- amount > 500

SELECT COUNT(DISTINCT customer_id) AS rich_count
FROM Store
WHERE amount > 500;
