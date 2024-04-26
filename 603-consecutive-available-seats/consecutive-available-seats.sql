# Write your MySQL query statement below
SELECT seat_id
FROM(
    SELECT seat_id, free, LAG(free) OVER(ORDER BY seat_id) AS pre, LEAD(free) OVER(ORDER BY seat_id) AS next
    FROM Cinema
) AS st
WHERE (free = 1 AND next=1) OR (free=1 AND pre=1)
ORDER BY seat_id
