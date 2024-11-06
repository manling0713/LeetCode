# Write your MySQL query statement below
SELECT sp.salesperson_id
    , name
    , IFNULL(SUM(price), 0) AS total
FROM Salesperson sp
LEFT JOIN Customer c
ON sp.salesperson_id = c.salesperson_id
LEFT JOIN Sales s
ON s.customer_id = c.customer_id
GROUP BY sp.salesperson_id;