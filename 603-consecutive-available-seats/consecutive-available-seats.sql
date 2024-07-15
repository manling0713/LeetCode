# Write your MySQL query statement below
SELECT DISTINCT c1.seat_id
FROM Cinema c1, Cinema c2
  WHERE abs(c1.seat_id - c2.seat_id) = 1
  AND c1.free = 1 AND c2.free = 1
ORDER BY c1.seat_id