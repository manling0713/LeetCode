# Write your MySQL query statement below
WITH driver_avg AS(
    SELECT driver_id
        , AVG(CASE WHEN MONTH(trip_date) <= 6 THEN distance_km/fuel_consumed END) AS first_half_avg
        , AVG(CASE WHEN MONTH(trip_date) > 6 THEN distance_km/fuel_consumed END) AS second_half_avg
    FROM trips
    GROUP BY driver_id
)
SELECT da.driver_id
    , driver_name
    , ROUND(first_half_avg, 2) AS first_half_avg
    , ROUND(second_half_avg, 2) AS second_half_avg
    , ROUND(second_half_avg - first_half_avg, 2) AS efficiency_improvement
FROM driver_avg da
LEFT JOIN drivers d
ON da.driver_id = d.driver_id
WHERE first_half_avg < second_half_avg
ORDER BY efficiency_improvement DESC, driver_name
