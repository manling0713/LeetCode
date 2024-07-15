# Write your MySQL query statement below
SELECT DISTINCT b.seat_id
FROM Cinema a, Cinema b
  WHERE abs(a.seat_id - b.seat_id) = 1
  AND a.free = 1 AND b.free = 1