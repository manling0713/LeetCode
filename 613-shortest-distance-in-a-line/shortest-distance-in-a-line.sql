# Write your MySQL query statement below
SELECT ABS(p1.x-p2.x) AS shortest
FROM Point p1, Point p2
WHERE p1.x <> p2.x
ORDER BY shortest
LIMIT 1