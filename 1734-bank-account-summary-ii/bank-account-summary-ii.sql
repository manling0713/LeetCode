# Write your MySQL query statement below
SELECT name, SUM(amount) AS balance
FROM Transactions t
LEFT JOIN Users u
USING(account)
GROUP BY name
HAVING SUM(amount) > 10000