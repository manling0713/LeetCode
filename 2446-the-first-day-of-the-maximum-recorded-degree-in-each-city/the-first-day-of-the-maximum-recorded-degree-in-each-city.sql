# Write your MySQL query statement below
WITH city_rank AS(
    SELECT city_id
        , day
        , degree
        , RANK() OVER(PARTITION BY city_id ORDER BY degree DESC, day) AS rnk
    FROM Weather
)


SELECT city_id
        , day
        , degree
FROM city_rank
WHERE rnk = 1