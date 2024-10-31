# Write your MySQL query statement below

SELECT p1.user_id AS user_id
FROM Purchases p1
LEFT JOIN Purchases p2
ON p1.user_id = p2.user_id 
    AND p1.purchase_id <> p2.purchase_id
WHERE ABS(DATEDIFF(p1.purchase_date, p2.purchase_date)) <= 7
GROUP BY p1.user_id
HAVING COUNT(*) >= 2 
ORDER BY user_id;