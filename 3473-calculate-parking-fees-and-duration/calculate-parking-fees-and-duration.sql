# Write your MySQL query statement below
WITH most AS(
    SELECT car_id
        , lot_id
        , RANK() OVER(PARTITION BY car_id ORDER BY SUM(TIMESTAMPDIFF(second, entry_time, exit_time)) DESC ) AS rnk
    FROM ParkingTransactions
    GROUP BY car_id, lot_id
), avg_fee AS(
    SELECT p.car_id
        , SUM(fee_paid) AS total_fee_paid
        , ROUND(SUM(fee_paid)/SUM(TIMESTAMPDIFF(second, entry_time, exit_time)/3600), 2) AS avg_hourly_fee
    FROM ParkingTransactions p
    GROUP BY car_id
)

SELECT car_id
    ,total_fee_paid
    , avg_hourly_fee
    , lot_id AS most_time_lot
FROM most m
LEFT JOIN avg_fee a
USING(car_id)
WHERE rnk = 1





