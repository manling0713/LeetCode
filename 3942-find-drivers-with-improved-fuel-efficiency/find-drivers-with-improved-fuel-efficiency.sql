# Write your MySQL query statement below

SELECT t1.driver_id
    , driver_name
    , ROUND(AVG(t1.distance_km / t1.fuel_consumed), 2) AS first_half_avg
    , ROUND(AVG(t2.distance_km / t2.fuel_consumed), 2) AS second_half_avg
    , ROUND(AVG(t2.distance_km / t2.fuel_consumed) - AVG(t1.distance_km / t1.fuel_consumed), 2) AS efficiency_improvement
FROM trips t1
INNER JOIN trips t2
ON t1.driver_id = t2.driver_id
AND MONTH(t1.trip_date) <= 6 AND MONTH(t2.trip_date) > 6
LEFT JOIN drivers d
ON t1.driver_id = d.driver_id
GROUP BY t1.driver_id, driver_name
HAVING AVG(t2.distance_km / t2.fuel_consumed) - AVG(t1.distance_km / t1.fuel_consumed) > 0
ORDER BY efficiency_improvement DESC, driver_name;