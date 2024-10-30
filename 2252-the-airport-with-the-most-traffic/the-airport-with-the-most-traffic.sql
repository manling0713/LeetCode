# Write your MySQL query statement below
-- calculate total sum of flights
-- DENSE_RANK() OVER(ORDER BY sum of flights DESC)
-- WHERE rnk = 1

WITH airport_flights AS(
    SELECT departure_airport AS airport_id
        , flights_count
    FROM Flights
    UNION ALL 
    SELECT arrival_airport AS airport_id
        , flights_count
    FROM Flights
), airport_rank AS(
    SELECT airport_id
        , SUM(flights_count) AS total_flights
        , DENSE_RANK() OVER(ORDER BY SUM(flights_count) DESC) AS rnk
    FROM airport_flights
    GROUP BY airport_id
)

SELECT airport_id
FROM airport_rank
WHERE rnk = 1;

