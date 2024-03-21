# Write your MySQL query statement below
WITH cte1 AS(
    SELECT flight_id, COUNT(passenger_id) AS total
    FROM Passengers
    GROUP BY flight_id
)
SELECT f.flight_id, IFNULL(IF(capacity <= total, capacity, total), 0) AS booked_cnt,
    IF(capacity < total, total - capacity, 0) AS waitlist_cnt
FROM Flights f
LEFT JOIN cte1 uSING(flight_id)
ORDER BY flight_id