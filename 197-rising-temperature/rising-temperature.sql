# Write your MySQL query statement below
SELECT w1.id
FROM Weather w1
LEFT JOIN Weather w2
ON W1.recordDate = DATE_ADD(W2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature 