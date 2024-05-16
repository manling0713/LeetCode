# Write your MySQL query statement below
WITH bus_order AS(
    SELECT bus_id, passenger_id, p.arrival_time, RANK() OVER(PARTITION BY passenger_id ORDER BY b.arrival_time) AS num
    FROM Buses b, Passengers p
    WHERE p.arrival_time <= b.arrival_time
)
SELECT b.bus_id
    , SUM(IF(num=1,1,0)) AS passengers_cnt
FROM Buses b
LEFT JOIN bus_order bo
ON b.bus_id = bo.bus_id
GROUP BY b.bus_id
ORDER BY b.bus_id

