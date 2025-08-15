# Write your MySQL query statement below
-- FROM Trips LEFT JOIN Vehicles using(vehicle_id)
-- LEFT JOIN Drivers USING(driver_id)
-- GROUP BY driver_id to calculate ROUND(AVG(rating), 2), SUM(distance)
--  ROW_NUMBER() OVER(PARTITION BY fuel_type ORDER BY avg_rating DESC, total_distance DESC, accidents) AS rnk
-- WHERE rnk = 1

WITH driver_info AS(
    SELECT driver_id
        , fuel_type
        , ROUND(AVG(rating), 2) AS avg_rating
        , SUM(distance) AS total_distance
    FROM Trips t
    LEFT JOIN Vehicles v
    ON t.vehicle_id = v.vehicle_id
    GROUP BY driver_id, fuel_type
), driver_rank AS(
    SELECT fuel_type
        , di.driver_id
        , avg_rating
        , total_distance
        , ROW_NUMBER() OVER(PARTITION BY fuel_type ORDER BY avg_rating DESC, total_distance DESC, accidents) AS rnk
    FROM driver_info di
    LEFT JOIN Drivers d
    ON di.driver_id = d.driver_id
)
SELECT fuel_type
    , driver_id
    , avg_rating AS rating
    , total_distance AS distance
FROM driver_rank
WHERE rnk = 1
ORDER BY fuel_type;



