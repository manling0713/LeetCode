# Write your MySQL query statement below
-- join 2 tables using p.arrival_time <= b.arrival_time
-- WHERE b.arrival_time = MIN(b.arrival_time) group by passenger_id
-- count(passenger_id) group by bus_id

WITH bus_pass AS(
    SELECT passenger_id
        , MIN(b.arrival_time) AS bus_time
    FROM Buses b
    LEFT JOIN Passengers p
    ON p.arrival_time <= b.arrival_time
    GROUP BY passenger_id
)

SELECT b.bus_id
    , COUNT(bp.passenger_id) AS passengers_cnt
FROM Buses b
LEFT JOIN bus_pass bp
ON bp.bus_time = b.arrival_time
GROUP BY b.bus_id
ORDER BY b.bus_id;

