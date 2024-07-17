# Write your MySQL query statement below
SELECT name
FROM SalesPerson
WHERE name NOT IN(
    SELECT s.name
    FROM SalesPerson s
    LEFT JOIN Orders o
    USING(sales_id)
    LEFT JOIN Company c
    USING(com_id)
    WHERE c.name = 'RED' 
)
