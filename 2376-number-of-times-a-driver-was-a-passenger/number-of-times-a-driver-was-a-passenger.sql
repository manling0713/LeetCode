# Write your MySQL query statement below
WITH driver_cnt As(
    SELECT DISTINCT passenger_id AS driver_id
        , COUNT(*) AS cnt
    FROM Rides
    WHERE passenger_id
    GROUP BY 1
)

SELECT DISTINCT r.driver_id
    , IFNULL(cnt, 0) cnt
FROM Rides r
LEFT JOIN driver_cnt d
ON r.driver_id = d.driver_id
