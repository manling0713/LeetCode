# Write your MySQL query statement below
WITH cte AS (
    SELECT sp.salesperson_id, SUM(price) AS total
    FROM Sales s
    LEFT JOIN Customer c
    ON s.customer_id = c.customer_id
    LEFT JOIN Salesperson sp 
    ON c.salesperson_id = sp.salesperson_id
    GROUP BY sp.salesperson_id 
)

SELECT s.salesperson_id, name, IFNULL(total, 0) AS total
FROM Salesperson s
LEFT JOIN cte USING(salesperson_id)
